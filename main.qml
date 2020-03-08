import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    id: app
    visible: true
    visibility: Qt.platform.os==='android'?"FullScreen":"Maximized"
    color: app.c1
    property string moduleName: 'jiclock'
    property int fs: 20
    property color c1: 'black'
    property color c2: 'white'
    property color c3: 'gray'
    property color c4: 'red'

    property string uMensaje: ''

    onClosing: {
        if(Qt.platform.os!=='android'){
            close.accepted = true
            Qt.quit()
        }else{
            close.accepted = false
        }
    }

    FontLoader{name: "FontAwesome"; source: "qrc:/fontawesome-webfont.ttf"}
    USettings{
        id: unikSettings
        url:'./jiclock'
    }
    Item{
        id: xApp
        anchors.fill: parent
        Column{
            anchors.centerIn: parent
            Text {
                id: labelTit
                text: '<b>Jiclock</b>'
                font.pixelSize: app.fs*2
                color: app.c4
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                id: labelTit2
                text: 'creado por @nextsigner'
                font.pixelSize: app.fs
                color: app.c2
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Item{
                width: 1
                height: app.fs*3
            }
            Item{
                width: 1
                height: labelTime.contentHeight
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 0-app.fs*8
                Text {
                    id: labelTime
                    text: '00:00:00.000'
                    font.pixelSize: app.fs*2
                    color: app.c2
                }
            }
            Row{
                spacing: app.fs
                Text {
                    id: labelTit3
                    text: 'Archivo actual: '+xListTimes.cFileName.replace('.json', '')
                    font.pixelSize: app.fs
                    color: app.c2
                    anchors.verticalCenter: parent.verticalCenter
                }
                BotonUX{
                    text: 'Editar'
                    onClicked: xListTimes.visible=true
                }
            }
            Item{width: 1; height: app.fs*2}
            Grid{
                spacing: app.fs
                columns: 2
                anchors.horizontalCenter: parent.horizontalCenter
                UxBotCirc{
                    width: app.fs*4
                    fontSize: app.fs
                    text: !tCheck.running?'Iniciar':'Detener'
                    animationEnabled: true
                    onClicked: {
                        if(tCheck.running){
                            tCheck.running=false
                        }else{
                            app.start()
                        }
                    }
                }
                UxBotCirc{
                    width: app.fs*4
                    fontSize: app.fs
                    text: 'Ahora'
                    animationEnabled: true
                    onClicked: {
                        var d = new Date(Date.now())
                        let h = d.getHours()
                        let m = d.getMinutes()
                        unik.speak('Es la hora : '+h+'  '+m+' minutos.')
                    }
                }
                UxBotCirc{
                    width: app.fs*4
                    fontSize: app.fs
                    text: 'Repetir'
                    animationEnabled: true
                    onClicked: {
                        unik.speak(app.uMensaje)
                    }
                }
            }
        }
        XListTimes{
            id: xListTimes;
            visible: false
            onVisibleChanged: {
                if(!visible&&tCheck.running)app.start()
            }
        }
        UxBotCirc{
            opacity: labelTit.opacity
            width: app.fs*3
            tag: 'config'
            animationEnabled: true
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.5
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.5
            onClicked: {
                var comp = Qt.createComponent('XConfig.qml')
                var obj = comp.createObject(xApp, {});
            }
        }
        ULogView{id: uLogView}
        UWarnings{id: uWarnings}
    }
    Item{
        id: xTimers
    }
    Timer{
        id: tClock
        running: true
        repeat: true
        interval: 10
        onTriggered: {
            let d = new Date(Date.now())
            let h = d.getHours()
            let m = d.getMinutes()
            let s = d.getSeconds()
            let ms = d.getMilliseconds()
            let t = ''+h+':'+m+':'+s+'.'+ms
            labelTime.text=t
        }
    }
    Timer{
        id:tCheck
        running: true
        repeat: true
        interval: 1000*15
        property var arrayHoras: []
        property var arrayCadas: []
        property var arrayVeces: []
        property var arrayAsuntos: []
        property int numAvisos: 1
        property int numMaxAvisos: 3
        onRunningChanged: {
            if(running){
                unik.speak('Avisos activados.')
            }else{
                unik.speak('Avisos detenidos.')
            }
        }
        onTriggered: {
            tCheck.interval=1000*15
            var d = new Date(Date.now())
            let h = d.getHours()
            let m = d.getMinutes()
            let string = ''+h+':'+m
            if(arrayHoras.indexOf(string)>=0&&numAvisos<numMaxAvisos){
                let a = arrayAsuntos[arrayHoras.indexOf(string)]
                let msg='Es la hora : '+h+'  '+m+' minutos.'
                msg+=' '+a
                let idName='t'+d.getTime()
                var comp = Qt.createComponent("XTimer.qml")
                let um='Último mensaje de la hora '+h+':'+m+' minutos: '+a
                if(app.uMensaje!==um){
                    var obj = comp.createObject(xTimers, {"msg":msg, "interval":parseInt(arrayCadas[arrayHoras.indexOf(string)] * 1000), "nma": parseInt(arrayVeces[arrayHoras.indexOf(string)]) })
                }
                app.uMensaje=um
                /*let qmlCode='import QtQuick 2.0
                Item{
                    id: '+idName+'
                    Timer{
                        id: t'+idName+'
                        running: true
                        repeat: true
                        interval: 5000
                        property int numAvisos: 0
                        property int numMaxAvisos: 3
                        onTriggered:{
                            numAvisos++
                            uLogView.showLog("n:"+numAvisos+" nm:"+numMaxAvisos)
                            if(numAvisos>=numMaxAvisos){
                                    t'+idName+'.stop()
                                    uLogView.showLog("Detenido!")
                            }else{
                                    unik.speak(\''+msg+'\')
                            }
                        }
                    }
                }'
                let comp = Qt.createQmlObject(qmlCode, xTimers, 'xTimers2')*/
                /*
                unik.speak(msg)
                */
            }else{
                //numAvisos=0
                /*if(arrayHoras.indexOf(string)<0&&numAvisos>0){
                     stop()
                     tCheck.interval=100
                     numAvisos=0
                     tCheck.restart()
                 }*/
            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    function start(){
        tCheck.arrayHoras = xListTimes.getHoras()
        tCheck.arrayCadas = xListTimes.getCadas()
        tCheck.arrayVeces = xListTimes.getVeces()
        tCheck.arrayAsuntos = xListTimes.getAsuntos()
        tCheck.running=true
    }
}

