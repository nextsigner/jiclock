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
            Grid{
                spacing: app.fs
                columns: 2
                anchors.horizontalCenter: parent.horizontalCenter
                UxBotCirc{
                    opacity: labelTit.opacity
                    width: app.fs*8
                    fontSize: app.fs
                    text: !tCheck.running?'Iniciar':'Detener'
                    animationEnabled: true
                    onClicked: {
                            tCheck.running=!tCheck.running
                    }
                }
                UxBotCirc{
                    opacity: labelTit.opacity
                    width: app.fs*8
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
            }
        }
        XListTimes{id: xListTimes}
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
    Timer{
        id:tCheck
        running: true
        repeat: true
        interval: 1000*35
        property var arrayHoras: ['17:30','17:50', '18:0', '18:30', '19:0', '19:30', '19:45', '19:55', '20:0', '20:15']
        onRunningChanged: {
            if(running){
                unik.speak('Avisos activados.')
            }else{
                unik.speak('Avisos detenidos.')
            }
        }
        onTriggered: {
                var d = new Date(Date.now())
                let h = d.getHours()
                let m = d.getMinutes()
                let string = ''+h+':'+m
                if(arrayHoras.indexOf(string)>=0){
                    unik.speak('Es la hora : '+h+'  '+m+' minutos.')
                }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Component.onCompleted: {
         let h = ['17:30','17:50', '18:0', '18:30', '19:0', '19:30', '19:45', '19:55', '20:0', '20:15']
        let a = ['Comienzo 1 ñalsk fdñlskf ñaslk jas dsf sdf ñjsdf jñsdfñ sdkl sdflñk dsfjsfdañlsdñlk sdflksfda ñsfdañlsdfsdfñ sdfklsfdañlsdafkjsñlsdjkñlsdaksñ  asñ dsf jkldsfñlsdfjñlsdalk sñl kñ sdfa sda sdf jklfdsñ sdf ñsdfklj ñsdflk','Comienzo 2', 'Comienzo 3', 'Comienzo 4', 'Comienzo 5']
         xListTimes.addItem(h[0], a[0], true)
         xListTimes.addItem(h[0], a[0], false)
         xListTimes.addItem(h[0], a[0], true)
         xListTimes.addItem(h[0], a[0], false)
    }
}

