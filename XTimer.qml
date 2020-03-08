import QtQuick 2.0

Item {
    id: r
    property string msg: ''
    property int na: 0
    property int nma: 0
    property alias interval: tr.interval
    Timer{
        id: tr
        running: true
        repeat: true
        interval: 5000
        onTriggered: {
            if(r.na>=r.nma){
                stop()
                return
            }
            unik.speak(r.msg)
            r.na++
        }
    }
}
