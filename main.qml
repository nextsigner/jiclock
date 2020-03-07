import QtQuick 2.7
import QtQuick.Controls 2.0
import QtWebEngine 1.4
import QtQuick.Window 2.2
import "qrc:/"
ApplicationWindow {
    id: app
    visible: true
    visibility: "FullScreen"
    color: app.c1
    property string moduleName: 'jiclock'
    property int fs: 20
    property color c1: 'black'
    property color c2: 'white'
    property color c3: 'gray'
    property color c4: 'red'
    property string uHtml: ''
    property bool voiceEnabled: true
    property string user: ''
    property string url: ''
    FontLoader{name: "FontAwesome"; source: "qrc:/fontawesome-webfont.ttf"}
    USettings{
        id: unikSettings
        url:'./jiclock'
        //url:pws+'/'+app.moduleName
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
                color: 'yellow'
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                id: labelTit2
                text: 'creado por @nextsigner'
                font.pixelSize: app.fs
                color: 'yellow'
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Item{
                width: 1
                height: app.fs*3
            }
            Text {
                id: labelStatus
                text: tCheck.running?'Encendido':'Apagado'
                font.pixelSize: app.fs
                color: 'yellow'
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        /*Rectangle{
            anchors.fill: parent

        }*/
        MouseArea{
            anchors.fill: parent
            onClicked: tCheck.running=!tCheck.running
            onDoubleClicked: {
                let d = new Date(Date.now())
                let h = d.getHours()
                let m = d.getMinutes()
                unik.speak('Es la hora : '+h+'  '+m+' minutos.')
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
        onTriggered: {
                let d = new Date(Date.now())
                let h = d.getHours()
                let m = d.getMinutes()
                let string = ''+h+':'+m
                if(arrayHoras.indexOf(string)>=0){
                    unik.speak('Es la hora : '+h+'  '+m+' minutos.')
                }else{
                    //unik.speak('Hora: '+h+'  '+m+' minutos.')
                }

        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Component.onCompleted: {
    }
}

