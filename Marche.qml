import QtQuick 2.15


Item {
    id:root
    property real angle: 45*Math.PI/180.0
    property real lx: h/Math.tan(angle)
    property real h: 100
    property real dx: 10.0
    property real sx: root.dx/2
    property real sy: 3.0
    onAngleChanged: canvas.requestPaint()
    onLxChanged: canvas.requestPaint()
    onHChanged: canvas.requestPaint()
    onDxChanged: canvas.requestPaint()
    onSxChanged: canvas.requestPaint()
    onSyChanged: canvas.requestPaint()


    Canvas{
        id:canvas
        anchors.fill: parent

        antialiasing: true
        clip:true
        contextType: "2d"
        property real drawing_width: 3.0*root.lx
        property real drawing_heigth: 1.2*root.h
        property real scaleX:parent.width/drawing_width
        property real scaleY: parent.height/drawing_heigth
        function _x(x){
            return x*scaleX
        }
        function _y(y){
            return y*scaleY
        }

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            ctx.translate(100,100)
            ctx.font="16px ubuntu normal"
            ctx.fillText("\u0394H:"+Number(root.h).toFixed(1)+" mm",scaleX*(root.lx+20),scaleY*root.h/2)
            ctx.fillText("\u0394X:"+Number(root.lx).toFixed(1)+" mm",scaleX*(root.lx/2),scaleY*root.h)
            //ctx.scale(scaleX,scaleY)
            ctx.beginPath()
            ctx.fillStyle = Qt.rgba(1, 0, 0, 1);
            ctx.lineCape="butt"
            ctx.lineWidth=1.25
            ctx.strokeStyle="green"
            ctx.moveTo(_x(-200),_y(root.h))
            ctx.lineTo(0,_y(root.h))

            ctx.moveTo(0,_y(root.h))
            ctx.lineTo(_x(root.lx),0)
            ctx.lineTo(_x(root.lx+200),0)
            ctx.stroke()
            ctx.beginPath()
            ctx.strokeStyle="red"
            ctx.moveTo(_x(root.lx),0)
            ctx.lineTo(0,0)
            ctx.lineTo(0,_y(root.h))
            ctx.stroke()

            //dessin des passes
            ctx.beginPath()
            ctx.strokeStyle="orange"
            ctx.fillStyle = Qt.rgba(0.5, 0, 0, 0.25);
            ctx.lineWidth=0.5
            for(var j=root.sy;j<root.h;j+=root.sy)
            {
                console.log("j:"+j)
                for(var x=(root.h-j)/Math.tan(root.angle);x>0;x-=root.sx)
                {
                    console.log("\t x:"+x)
                    ctx.fillRect(_x(x-sx),_y(j-sy),_x(dx),_y(sy))
                    ctx.strokeRect(_x(x-sx),_y(j-sy),_x(dx),_y(sy))
                }
            }

        }

    }





}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:1080;width:1920}D{i:1}
}
##^##*/
