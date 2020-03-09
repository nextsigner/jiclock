import QtQuick 2.0

Rectangle {
    id: r
    width: parent.width
    height: col.height+app.fs
    color: app.c1
    border.width: unikSettings.borderWidth
    border.color: app.c2
    property int currentIndex: -1
    property alias h: ti1.text
    property alias m: ti2.text
    property alias a: ti3.text
    property alias c: ti4.text
    property alias v: ti5.text
    signal editFinished(string h, string m, string c, string v, string a, int index)
    signal deleteItem(int index)
    onVisibleChanged: {
        if(visible){
            ti1.focus=true
        }else{
            ti1.focus=false
            ti2.focus=false
            ti3.focus=false
            ti4.focus=false
            ti5.focus=false
        }
    }
    Column{
        id: col
        spacing: app.fs
        anchors.centerIn: parent
        UText{
            text: '<b>Editando alarma '+parseInt(r.currentIndex + 1)+'</b>'
            font.pixelSize: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Row{
            spacing: app.fs
            UTextInput{
                id: ti1
                label: 'Hora:'
                width: app.fs*6
                KeyNavigation.tab: ti2
                regularExp: RegExpValidator{ regExp: /[0-9]{2}/ }
            }
            UTextInput{
                id: ti2
                label: 'Minuto:'
                width: app.fs*6
                KeyNavigation.tab: ti5
                regularExp: RegExpValidator{ regExp: /[0-9]{2}/ }
            }
        }
        Row{
            spacing: app.fs
            UText{
                text: 'Avisar'
                anchors.verticalCenter: parent.verticalCenter
            }
            UTextInput{
                id: ti5
                label: ''
                width: app.fs*3
                KeyNavigation.tab: ti4
                regularExp: RegExpValidator{ regExp: /[0-9]{3}/ }
            }
            UText{
                text: ti5.text!=='1'?'veces cada ':'vez'
                anchors.verticalCenter: parent.verticalCenter
            }
            UTextInput{
                id: ti4
                label: ''
                width: app.fs*3
                visible: ti5.text!=='1'
                KeyNavigation.tab: ti3
                regularExp: RegExpValidator{ regExp: /[0-9]{3}/ }
            }
            UText{
                text: 'segundos'
                anchors.verticalCenter: parent.verticalCenter
                visible: ti5.text!=='1'
            }
        }
        UTextInput{
            id: ti3
            label: 'Asunto:'
            width: r.width-app.fs*3
            KeyNavigation.tab: ti1
        }
        Row{
            spacing: app.fs
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.5
            BotonUX{
                text: 'Eliminar'
                onClicked: {
                    r.deleteItem(r.currentIndex)
                    r.visible=false
                }
            }
            BotonUX{
                text: 'Cancelar'
                onClicked: {
                    r.visible=false
                }
            }
            BotonUX{
                text: 'Listo'
                onClicked: {
                    editFinished(ti1.text, ti2.text, ti4.text, ti5.text, ti3.text, r.currentIndex)
                    r.visible=false
                }
            }
        }
    }
}
