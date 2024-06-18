# SpaceInvaders no FPGA
## Descrição do projeto
Esse projeto é uma recriação do antigo jogo SpaceInvaders, mas com algumas novidades. Como 2 players, um powerup para os players e colocado na **FPGA DE0-CV 4F23C7N**

<img src="https://img.shields.io/static/v1?label=FPGA&message=Em VHDL&color=7159c1&style=for-the-badge&logo=ghost"/>

## Sumário
- [Demonstração](#Demonstracao)
- [Sobre](#Sobre)
- [Como usar](#Usar)
- [Tecnologia](#Tecnologia)

## Demonstração
Segue alguns videos para demonstrar o projeto
<video src="video.mp4" width="320" height="240" controls></video>

## Sobre
Como citado anteriormente, esse projeto é uma recriação do spaceinvaders para a materia de Dispositivos Lógicos Programaveis do Senai Cimatec, desenvolvido em equipe. Essa recriação consta com algumas novidades não tão novidades assim, player 2 e powerup para os players.

Desenvolvido na placa de FPGA DE0-CV do modelo 5CEBA4F23C7, o jogo contém uma definição de 640x480 em qualquer monitor, operando em 60Hz.

## Como usar
- Acesse o Quartus Prime Lite Edition
- Faça a pinagem de acordo com a FPGA
- Compile o código
- Acesse o **Convert Programming File**
- Mude o objeto de arquivo para .jic
- coloque o dipositivo da cyclone V EPCS64
- Adicione a SOF Page criada na pinagem
- Adicione o dispositivo 5CEBA4
- Clique em gerar arquivo
- Publique o arquivo na FPGA acessando o Programmer

## Tecnologia
1. VGA
    - Foi utilizado a tecnologia de VGA para acessar o video e exibir o jogo em tela
2. VHDL
    - Foi usado a linguagem de descrição de hardware VHDL para criar o hardware do jogo.



