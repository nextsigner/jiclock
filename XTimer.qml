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
            var d = new Date(Date.now())
            let h = d.getHours()
            let m = d.getMinutes()
            let string = 'Ya son las '+h+' horas y '+m+' minutos.'
            unik.speak(r.msg+' '+string)
            r.na++
        }
    }
}
