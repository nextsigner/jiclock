import QtQuick 2.0

Rectangle {
    id: r
    width: r.fs*2*3+r.fs
    height: r.fs*3
    color: app.c1
    border.width: unikSettings.borderWidth
    border.color: app.c2
    radius: r.fs*0.5
    property alias model: repClock.model
    property int fs: app.fs*1.4
    Row{
        //spacing: r.fs*0.05
        anchors.centerIn: parent
        Repeater{
            id: repClock
            model:3
            Item {
                width: index!==3?r.fs*1.5:r.fs*2
                height: r.fs*2
                Text {
                    text: (''+modelData).length===1&&index!==3?'0'+modelData:modelData
                    font.pixelSize: r.fs
                    color: app.c2
                    anchors.centerIn: parent
                }
                Text {
                    text: index!==2?':':'.'
                    font.pixelSize: r.fs
                    color: app.c2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.right
                    anchors.leftMargin: 0-r.fs*0.15
                    visible: index!==3
                }
            }
        }
    }
}
