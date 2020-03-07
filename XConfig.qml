import QtQuick 2.0
Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    MouseArea{
        anchors.fill: r
    }
    Column{
        spacing: app.fs
        anchors.centerIn: r
        BotonUX{
            text: 'Atras'
            fontSize: app.rot?app.fs*0.5:app.fs
            onClicked: {
                unik.speak('atras')
                r.destroy(10)
            }
        }
        Grid{
            id: gridConfig
            spacing: app.fs
            columns: 1
            //width: r.width-app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            Row{
                spacing: app.fs
                Rectangle{
                    width: children[0].width+app.fs*0.5
                    height: children[0].height+app.fs
                    color: app.c1
                    border.color: app.c4
                    radius: app.fs*0.5
                    Column{
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        UText{
                            text: 'Cambiar\ncolores'
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: app.c2
                            horizontalAlignment: Text.AlignHCenter
                        }
                        UxBotCirc{
                            anchors.horizontalCenter: parent.horizontalCenter
                            opacity: labelTit.opacity
                            width: app.fs*3
                            text: '\uf1fc'//+unikSettings.currentNumColor
                            animationEnabled: true
                            //glowEnabled: true
                            onClicked: {
                                var cc=unikSettings.defaultColors.split('|').length
                                if(unikSettings.currentNumColor<cc-1){
                                    unikSettings.currentNumColor++
                                }else{
                                    unikSettings.currentNumColor=0
                                }
                                //appSettings.currentNumColors = unikSettings.currentNumColor
                                updateUS()
                            }
                        }
                    }
                }
                Rectangle{
                    width: children[0].width+app.fs*0.5
                    height: children[0].height+app.fs
                    color: app.c1
                    border.color: app.c4
                    radius: app.fs*0.5
                    Column{
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        UText{
                            text: 'Actualizar\nMercurio'
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: app.c2
                            horizontalAlignment: Text.AlignHCenter
                        }
                        UxBotCirc{
                            anchors.horizontalCenter: parent.horizontalCenter
                            opacity: labelTit.opacity
                            width: app.fs*3
                            text: '\uf021'
                            animationEnabled: true
                            onClicked: {
                                upd.infoText = unikSettings.lang==='es'?'<b>Actualización: </b>Se ha iniciado la actualización\nde <b>MERCURIO</b>':'<b>Update: </b> Updating <b>MERCURIO</b>'
                                upd.download('https://github.com/nextsigner/'+moduleName+'.git', pws)
                            }
                        }
                    }
                }
            }
            Item{
                width: gridConfig.width
                height: children[0].height
                Rectangle{
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: children[0].width+app.fs*0.5
                    height: children[0].height+app.fs
                    color: app.c1
                    border.color: app.c4
                    radius: app.fs*0.5
                    Column{
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        UText{
                            text: 'Activar\nsonido'
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: app.c2
                            horizontalAlignment: Text.AlignHCenter
                        }
                        UxBotCirc{
                            anchors.horizontalCenter: parent.horizontalCenter
                            opacity: labelTit.opacity
                            width: app.fs*3
                            text: unikSettings.sound?'\uf028':'\uf026'
                            animationEnabled: true
                            onClicked: {
                                unikSettings.sound=!unikSettings.sound
                            }
                        }
                    }
                }
            }
            Item{
                width: gridConfig.width
                height: children[0].height
                Rectangle{
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: children[0].width+app.fs*0.5
                    height: children[0].height+app.fs
                    color: app.c1
                    border.color: app.c4
                    radius: app.fs*0.5
                    Column{
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        UText{
                            id:txtMIU
                            text: 'Iniciar\nUnik'
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: app.c2
                            horizontalAlignment: Text.AlignHCenter
                        }
                        UxBotCirc{
                            id: uxBotCircCfg
                            anchors.horizontalCenter: parent.horizontalCenter
                            opacity: labelTit.opacity
                            width: app.fs*3
                            text: '\uf015'
                            animationEnabled: true
                            property bool seted: false
                            onClicked: {
                                uxBotCircCfg.seted=!uxBotCircCfg.seted
                                let cfgFileLocation=pws+'/cfg.json'
                                if(uxBotCircCfg.seted){
                                    let cfgData=('{"arg0":"-folder='+pws+'/'+moduleName+'","arg1":"https://github.com/nextsigner/'+moduleName+'.git"}').replace(/ /g, '%20')
                                    unik.setFile(cfgFileLocation, cfgData)
                                    xSign.visible=false
                                }else{
                                    xSign.visible=true
                                    unik.deleteFile(cfgFileLocation)
                                    unik.restartApp()
                                }
                                if(uxBotCircCfg.seted){
                                    txtMIU.text='Iniciar Launcher\nde Unik'
                                }else{
                                    txtMIU.text='Iniciar Mercurio\ndirectamente.'
                                }
                            }
                            Text{
                                id: xSign
                                visible: false//!uxBotCircCfg.seted
                                text: 'X'
                                font.pixelSize: parent.width*0.6
                                color: 'red'
                                anchors.centerIn: parent
                            }
                            Component.onCompleted: {
                                let cfgFileLocation=pws+'/cfg.json'
                                seted = unik.fileExist(cfgFileLocation)
                                if(seted){
                                    txtMIU.text='Iniciar Launcher\nde Unik'
                                }else{
                                    txtMIU.text='Iniciar Mercurio\ndirectamente.'
                                }
                                xSign.visible=!seted
                            }
                        }
                    }
                }
            }
            Item{
                width: gridConfig.width
                height: children[0].height
                Rectangle{
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: children[0].width+app.fs*0.5
                    height: children[0].height+app.fs
                    color: app.c1
                    border.color: app.c4
                    radius: app.fs*0.5
                    Column{
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        UText{
                            text: 'Apagar'
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: app.c2
                            horizontalAlignment: Text.AlignHCenter
                        }
                        UxBotCirc{
                            anchors.horizontalCenter: parent.horizontalCenter
                            opacity: labelTit.opacity
                            width: app.fs*3
                            text: '\uf011'
                            animationEnabled: true
                            onClicked: {
                                Qt.quit()
                            }
                        }
                    }
                }
            }
        }
    }
    function updateUS(){
        var nc=unikSettings.currentNumColor
        var cc1=unikSettings.defaultColors.split('|')
        var cc2=cc1[nc].split('-')
        app.c1=cc2[0]
        app.c2=cc2[1]
        app.c3=cc2[2]
        app.c4=cc2[3]

        //unikSettings.zoom=1.4
        //unikSettings.borderWidth=app.fs*0.5
        //unikSettings.padding=0.5

        app.visible=true
    }
}
