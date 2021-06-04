#!/bin/bash

echo "Iniciando Desktop e Downloads..."
mkdir ~/Desktop
mkdir ~/Downloads

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Adicionando bibliotecas raspberry pi no debian..."
#Add this repo line into sources list. This will redirect to download the correct gstreamer.
echo deb '[trusted=yes] http://vontaene.de/raspbian-updates/ . main' >> /etc/apt/sources.list

echo "instalando pacotes para o rasp..."
apt install zip pkg-config cmake librsvg2-dev jackd2 libgtk-3-dev

echo "atualizando pacotes..."
sudo apt-get update
sudo apt-get upgrade

echo "instalando pacotes dev essenciais..."
sudo apt-get install build-essential libreadline-dev


echo "instalando cURL..."
sudo apt-get install curl


echo "instalando lua 5.2..."
cd ~/Downloads
curl -R -O "https://www.lua.org/ftp/lua-5.2.4.tar.gz"
tar -zxf lua-5.2.4.tar.gz 
cd lua-5.2.4/
make linux test
sudo make install
cd ~

echo "instalando luarocks..."
wget "https://luarocks.org/releases/luarocks-3.2.1.tar.gz"
tar zxpf luarocks-3.2.1.tar.gz
cd luarocks-3.2.1/
./configure
make build
sudo make install
cd ~

echo "instalando git..."
sudo apt-get install git

echo "instalando cURL dev..."
sudo apt-get install libcurl4-openssl-dev


echo "instalando pacotes lua..."
sudo luarocks install json-lua #para usar json em Lua
sudo luarocks install luasocket #para quase tudo em Lua kkkk
sudo luarocks install cURL #para usar cURL em prog Lua
sudo luarocks install Lua-cURL CURL_INCDIR=/usr/include/x86_64-linux-gnu #para dev cURL em prog Lua
#sudo luarocks install luafilesystem #para a biblioteca MQTT Client Lua
#sudo luarocks install penlight #para a biblioteca MQTT Client Lua
sudo luarocks install luamqtt #módulo client MQTT Lua: https://github.com/xHasKx/luamqtt/

luarocks list #comando para listar todos os módulos instalados pelo luarocks, com versão e local


echo "Instalando pip..."
sudo apt-get install python3-pip

echo "Instalando Meson..."
pip3 install meson

echo "Instalando Ninja..."
apt-get install ninja-build

echo "Instalando módulo JsonCpp..."
cd ~/Downloads
wget -c "https://github.com/open-source-parsers/jsoncpp/archive/master.zip"
unzip master.zip
mv jsoncpp-master jsoncpp
cd jsoncpp
mkdir dependencias
cd dependencias
~/.local/bin/meson ~/Downloads/jsoncpp .
ninja
ninja test
cd ~
echo "AVISO: Copiar a pasta jsoncpp em Downloads para a pasta de bibliotecas do seu projeto"

echo "Instalando restclient.cpp"
cd ~/Downloads
git clone https://github.com/mrtazz/restclient-cpp.git
./autogen.sh
./configure
make install

echo "Instalando Ginga..." 
cd ~/Desktop
git clone https://github.com/marinaivanov/ginga-mulsemedia.git
git clone https://github.com/TeleMidia/nclua.git
sudo apt-get install -y git gcc g++ autotools-dev dh-autoreconf 
  liblua5.2-dev libglib2.0-dev libpango1.0-dev 
  librsvg2-dev libgtk-3-dev libsoup2.4-dev -qq
cd nclua
./bootstrap
./configure --prefix=/usr/
make
sudo make install
cd ..
sudo apt-get install -y git gcc g++ autotools-dev dh-autoreconf \
    cmake cmake-data liblua5.2-dev libglib2.0-dev libpango1.0-dev \
    librsvg2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-libav \
    gstreamer1.0-tools libgtk-3-dev libsoup2.4-dev -qq
cd ginga-mulsemedia
./bootstrap
./configure --prefix=/usr/
make
cd ~



#lista de bibliotecas Lua:
#https://github.com/mqtt/mqtt.github.io/wiki/libraries

# Instalação do servidpr mosquitto:
sudo apt-get update
sudo apt-get upgrade

echo "Instalando servidor Mosquitto..."
sudo apt-get install mosquitto
sudo apt-get install mosquitto-clients

echo "Diretório com Read.me do mosquitto: /usr/share/doc/mosquitto"
echo "Diretório com .config do mosquitto: /etc/mosquitto/mosquitto.conf"

# Para teste será necessário dois terminais de comando. Em um faça:
# mosquitto_sub -t "test"
# No outro faça:
# mosquitto_pub -m "Mensagem" -t "test"
