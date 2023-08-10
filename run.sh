#!/bin/bash

# Kiểm tra và cài đặt Docker (nếu chưa có)
if ! command -v docker &>/dev/null; then
  echo "Docker is not installed. Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $USER
  echo "Docker installed successfully."
else
  echo "Docker is already installed. Skipping Docker installation."
fi

# Kiểm tra và cài đặt PostgreSQL client (nếu chưa có)
if ! command -v psql &>/dev/null; then
  echo "PostgreSQL client is not installed. Installing PostgreSQL client..."
  sudo apt-get update
  sudo apt-get install -qq -y postgresql-client
  echo "PostgreSQL client installed successfully."
else
  echo "PostgreSQL client is already installed. Skipping PostgreSQL client installation."
fi

# Cài đặt Git (nếu chưa có)
if ! command -v git &>/dev/null; then
  echo "Git is not installed. Installing Git..."
  sudo apt-get update
  sudo apt-get install -y git
  echo "Git installed successfully."
else
  echo "Git is already installed. Skipping Git installation."
fi

# Cài đặt Yarn (nếu chưa có)
if ! command -v yarn &>/dev/null; then
  echo "Yarn is not installed. Installing Yarn..."
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/yarnkey.gpg
  echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update
  sudo apt-get install -y yarn
  echo "Yarn installed successfully."
else
  echo "Yarn is already installed. Skipping Yarn installation."
fi

# Kiểm tra và cài đặt Node.js (nếu chưa có hoặc phiên bản thấp hơn 16)
if ! command -v node &>/dev/null; then
  echo "Node.js is not installed. Installing Node.js..."
  curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt-get install -y nodejs
  echo "Node.js version 16 installed successfully."
else
  # Kiểm tra phiên bản Node.js
  NODE_VERSION=$(node -v)
  echo "Node.js version: $NODE_VERSION"

  # So sánh phiên bản Node.js và cài đặt phiên bản 16 nếu phiên bản hiện tại < 16
  if [[ $NODE_VERSION =~ v([0-9]+) ]]; then
    CURRENT_VERSION="${BASH_REMATCH[1]}"
    if [ $CURRENT_VERSION -lt 16 ]; then
      echo "Node.js version is lower than 16. Removing current version..."
      sudo apt-get remove -y nodejs
      sudo apt-get autoremove -y
      echo "Installing Node.js version 16..."
      curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
      sudo apt-get install -y nodejs
      echo "Node.js version 16 installed successfully."
    else
      echo "Node.js version is 16 or higher. Skipping Node.js installation."
    fi
  fi
fi

# Kiểm tra và cài đặt npm (nếu chưa có)
if ! command -v npm &>/dev/null; then
  echo "npm is not installed. Installing npm..."
  sudo apt-get install -y npm
  echo "npm installed successfully."
else
  echo "npm is already installed. Skipping npm installation."
fi

# Kiểm tra và cài đặt Redis (nếu chưa có)
if ! command -v redis-server &>/dev/null; then
  echo "Redis is not installed. Installing Redis..."
  sudo apt-get update
  sudo apt-get install -y redis-server
  echo "Redis installed successfully."
else
  echo "Redis is already installed. Skipping Redis installation."
fi

# Các biến cấu hình (giữ nguyên như bạn đã định nghĩa)
USERNAME="postgres"
PASSWORD="bao123"
DATABASE="maps"
BACKUP_DIR="$PWD/database_backup"
DOCKER_IMAGE_NAME="postgres"

# Bước 1: Chạy Docker container PostgreSQL
docker run --name bao_container -e POSTGRES_USER=$USERNAME -e POSTGRES_PASSWORD=$PASSWORD -p 5432:5432 -d $DOCKER_IMAGE_NAME

# Kiểm tra xem lệnh docker run có thành công hay không
if [ $? -eq 0 ]; then
  echo "Docker container bao_container is running."
else
  echo "Failed to start Docker container!"
  exit 1
fi

# Bước 2: Chờ container khởi động trong 10 giây
sleep 10

# Bước 3: Kiểm tra file init.sql có tồn tại
INIT_SQL_FILE="$PWD/init.sql"
if [ ! -f "$INIT_SQL_FILE" ]; then
  echo "init.sql file not found at $INIT_SQL_FILE. Please make sure the file exists."
  exit 1
fi

# Bước 4: Tạo database từ file init.sql trong container
docker cp "$INIT_SQL_FILE" bao_container:/docker-entrypoint-initdb.d/init.sql

# Kiểm tra xem lệnh docker cp có thành công hay không
if [ $? -eq 0 ]; then
  echo "Copy init.sql to container successfully."
else
  echo "Copy init.sql to container failed!"
  exit 1
fi

docker exec -it bao_container psql -U $USERNAME -f "/docker-entrypoint-initdb.d/init.sql"

# Kiểm tra xem lệnh psql có thành công hay không
if [ $? -eq 0 ]; then
  echo "Database created from init.sql successfully."
else
  echo "Database creation from init.sql failed!"
  exit 1
fi


# Bước 5: Lấy file backup mới nhất trong folder database_backup
LATEST_BACKUP=$(ls -t $BACKUP_DIR | grep "$DATABASE-" | head -1)
BACKUP_FILE="$BACKUP_DIR/$LATEST_BACKUP"

# Kiểm tra xem có file backup mới nhất hay không
if [ -z "$LATEST_BACKUP" ]; then
  echo "No backup file found in $BACKUP_DIR."
  exit 1
fi

# Bước 6: Sao chép file backup vào container
docker cp "$BACKUP_FILE" bao_container:/docker-entrypoint-initdb.d

# Kiểm tra xem lệnh docker cp có thành công hay không
if [ $? -eq 0 ]; then
  echo "Copy backup file $LATEST_BACKUP to container successfully."
else
  echo "Copy backup file $LATEST_BACKUP to container failed!"
  exit 1
fi

# Bước 7: Khôi phục dữ liệu từ file backup trong container
docker exec -it bao_container psql -U $USERNAME -d $DATABASE -f "/docker-entrypoint-initdb.d/$LATEST_BACKUP"

# Kiểm tra xem lệnh psql có thành công hay không
if [ $? -eq 0 ]; then
  echo "Data restore completed."
else
  echo "Data restore failed!"
  exit 1
fi

git clone https://github.com/baophung020394/gps-map-tracking.git
cd gps-map-tracking/frontend
yarn install

sleep 5

sudo chmod -R 777 node_modules

cd ../server
npm install


# Chờ 5 giây trước khi hoàn tất script
sleep 5

# Hoàn tất
echo "Setup completed."




