function generate(angle,sx,sy,h,dx)
{
    let rects = []
    for(var j=sy;j<h;j+=sy)
    {
        for(var x=(h-j)/Math.tan(angle);x>0;x-=sx)
        {
            let r = Qt.rect(x-sx,j-sy,dx,sy)
            rects.push(r)
        }
    }
    return rects
}

function generatePts(angle,sx,sy,h,dx)
{
    let points = []
    for(var j=sy;j<h;j+=sy)
    {
        for(var x=(h-j)/Math.tan(angle);x>0;x-=sx)
        {
            let p = Qt.point(x-sx+dx/2,j)
            points.push(p)
        }
    }
    return points
}
function drawRects(retcs,status,ctx,sx,sy)
{
    function _x(x){
        return x*sx
    }
    function _y(y){
        return y*sy
    }

    retcs.forEach(function(item,index,array)
    {
        ctx.fillStyle=status[index]?"#aa00AA22":"#aaE8A61F"
        ctx.fillRect(_x(item.x),_y(item.y),_x(item.width),_y(item.height))
        ctx.strokeRect(_x(item.x),_y(item.y),_x(item.width),_y(item.heigt))
    });
}


