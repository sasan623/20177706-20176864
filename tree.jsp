<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>石三</title>
   <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
   <script src="WebContent/bootstrap/jquery-3.4.1.min.js"></script>
   <script src="bootstrap/css/bootstrap.min.js"></script>
     <style>
   .node {
  cursor: pointer;
}

.node circle {
  fill: #fff;
  stroke: steelblue;
  stroke-width: 1.5px;
}

.node text {
  font: 10px sans-serif;
}

.link {
  fill: none;
  stroke: #ccc;
  stroke-width: 1.5px;
}
.body{
		background:url("img/4.jpg");
		no-repeat;
		background-size: cover;
			}
   </style>
</head>
<body class=body style="font-family:Microsoft YaHei" >
  <ul class="nav nav-pills">
    <li> <a href="#" class="tooltip-test" data-toggle="tooltip" title="Menu">菜单</a>
    <li><a href="main.jsp" class="tooltip-test" data-toggle="tooltip" title="home page">主页</a></li>
	<li class="active"><a href="tree.jsp" class="tooltip-test" data-toggle="tooltip" title="spanning tree">生成家族树</a></li>
	<li><a href="#" class="tooltip-test" data-toggle="tooltip" title="Retrun">退出登录</a></li>	
 </ul>
   
    
    <script src="https://d3js.org/d3.v3.min.js"></script>
    <script>
var treeData = [
  {
	  "name": "",
      "parent": "",
      "children": [{
          "name": "",
          "parent": "",
          "children": [{
              "name": "",
              "parent": ""
          }, {
              "name": "",
              "parent": "",
              
          }, {
              "name": "",
              "parent": ""
          }, {
              "name": "",
              "parent": ""
          },]
      
      
      }, {
          "name": "",
          "parent": "",
          "children": [{
              "name": "",
              "parent": ""
          }, {
              "name": "",
              "parent": ""
          }, {
              "name": "",
              "parent": ""
          }, {
              "name": "",
              "parent": ""                    
          },]

      
      }, {
          "name": "",
          "parent":"",
        	  "children": [{
                  "name": "",
                  "parent": ""
              }, {
                  "name": "",
                  "parent": ""
              }, {
                  "name": "",
                  "parent": ""
              }, {
                  "name": "",
                  "parent": ""   
              }, ]
      }, ]
  }];
function treeInit(tree_num) { 
 var margin = {top: 20, right: 120, bottom: 20, left: 120},
    width = 960 - margin.right - margin.left,
    height = 960 - margin.top - margin.bottom;
    
//Setup zoom and pan设置缩放和平移家族树

	var zoom = d3.behavior.zoom()

		.scaleExtent([.1,1])

		.on('zoom', function(){

			svg.attr("transform", "translate(" + d3.event.translate + ") scale(" + d3.event.scale + ")");

	});
 
 var i = 0,
    duration = 750,
    root;

 var tree = d3.layout.tree()//创建一个树布局
    .size([height, width]);

 var diagonal = d3.svg.diagonal()//创建新的斜线生成器
    .projection(function(d) { return [d.y, d.x]; });
 

  var svg = d3.select("body").append("svg")//声明与定义画布属性
    .attr("width", width + margin.right + margin.left)
    .attr("height", height + margin.top + margin.bottom)
    .call(zoom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


  root = treeData[tree_num];
  root.x0 = height / 2;
  root.y0 = 0;

  function collapse(d) {
    if (d.children) {
      d._children = d.children;
      d._children.forEach(collapse);
      d.children = null;
    }
  }

  root.children.forEach(collapse);
  update(root);


d3.select(self.frameElement).style("height", "1600px");

function update(source) {

  // 计算新树图的布局
  var nodes = tree.nodes(root).reverse(),
      links = tree.links(nodes);

  // 设置y坐标点，每层占180px
  nodes.forEach(function(d) { d.y = d.depth * 180; });

  // Update the nodes…
  var node = svg.selectAll("g.node")
      .data(nodes, function(d) { return d.id || (d.id = ++i); });

  // Enter any new nodes at the parent's previous position.
  var nodeEnter = node.enter().append("g")
      .attr("class", "node")
      .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; })
      .on("click", click);

  nodeEnter.append("circle")
      .attr("r", 1e-6)
      .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });
 
  nodeEnter.append("rect")

	.attr("x",-20)

	.attr("y", -15)       //结点位置

	.attr("width",40)      //矩形宽高

	.attr("height",50)

	.attr("rx",10)

	.attr("fill", function(d){

	//创建人物图片

	var defs = svg.append("defs").attr("id", "imgdefs")

	var catpattern = defs.append("pattern")
							.attr("id", "pat")
							.attr("height", 1)
							.attr("width", 1)
							.attr("patternContentUnits","objectBoundingBox")
							
	catpattern.append("image")
			.attr("width", "1.4")
			.attr("height", "1")
			.attr("xlink:href", "img/00.jpg")

	return "url(#pat)";

})
  
  nodeEnter.append("text")
      .attr("x", function(d) { return d.children || d._children ? -10 : 10; })
      .attr("dy", "50")
      .attr("text-anchor", "middle")
      .text(function(d) { return d.name; })
      .style("fill", "#2dbb8a")
      .style("fill-opacity", 1);

  // Transition nodes to their new position.
  var nodeUpdate = node.transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });

  nodeUpdate.select("circle")
      .attr("r", 4.5)
      .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

  nodeUpdate.select("text")
      .style("fill-opacity", 1);

  // Transition exiting nodes to the parent's new position.
  var nodeExit = node.exit().transition()
      .duration(duration)
      .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
      .remove();

  nodeExit.select("circle")
      .attr("r", 1e-6);

  nodeExit.select("text")
      .style("fill-opacity", 1e-6);

  // Update the links…
  var link = svg.selectAll("path.link")
      .data(links, function(d) { return d.target.id; });

  // Enter any new links at the parent's previous position.
  link.enter().insert("path", "g")
      .attr("class", "link")
      .attr("d", function(d) {
        var o = {x: source.x0, y: source.y0};
        return diagonal({source: o, target: o});
      });

  // Transition links to their new position.
  link.transition()
      .duration(duration)
      .attr("d", diagonal);

  // Transition exiting nodes to the parent's new position.
  link.exit().transition()
      .duration(duration)
      .attr("d", function(d) {
        var o = {x: source.x, y: source.y};
        return diagonal({source: o, target: o});
      })
      .remove();

  // Stash the old positions for transition.
  nodes.forEach(function(d) {
    d.x0 = d.x;
    d.y0 = d.y;
  });


// Toggle children on click.切换子节点事件
function click(d) {
  if (d.children) {
    d._children = d.children;
    d.children = null;
  } else {
    d.children = d._children;
    d._children = null;
  }
  update(d);
}
}
}
</script>
<script type="text/javascript">

function getJsonLength(jsonData) {
    var jsonLength = 0;
    for (var item in jsonData) {
//alert("Son is " + item);
        jsonLength++;
    }
  
    return jsonLength;
}

/*
检查函数，遍历之前所有树的所有子节点，查找是否有导师的学生也是导师的情况

*/
 
function check(nodes, find_name, may_need, keke) {
    var result1 = 0;

    var result2 = 1;
    var length_now = getJsonLength(nodes.children);
    
    for (var first = 0; first < length_now; first++) {

        if (nodes.children[first].name == find_name) {                     
        	
            nodes.children[first] = may_need;//这是该导师的学生为导师的那棵树的根节点
            //alert("add success");
            return result2;

        } else {
            check(nodes.children[first], find_name, may_need, keke);
            //return;
        }
    }

    return result1;
}




/*
分割传输过来的数据并构造json树结构
*/
  function build() {
	//alert("欢迎使用");	
	    var count = 0; 
       var flag = 0; //定义标志是否为关联树值为1
       var all_data = document.getElementById("text").value;
       var sclice_data = [];
       var model_data = [];
       model_data = all_data.split("\n\n");
        
       //document.write(model_data);
       //document.write(model_data.lenth);
       
       
       for (var j = 0; j < model_data.length; ++j) {
           count = 0;
           flag = 0;
           count_shu = 0;
           sclice_data = model_data[j].split("\n");
           //document.write(sclice_data.length);
           for (var i = 0; i < sclice_data.length; ++i) {
           	 var before_tmp = "";
                var back_tmp = "";
                var colon = sclice_data[i].split("："); //从冒号分割一层字符串
                before_tmp = colon[0];
         //document.write(head_tmp);
                back_tmp = colon[1];
         //document.write(body_tmp);
         //alert(head_tmp == "导师");
         //alert(i);
                
                //处理冒号前的部分
                if (before_tmp == "导师")
                {
               	 
                    var daoshi2 =
                    {	 
                        "name": back_tmp,
                        "parent": "null",
                        "children": [{}]
                    }
               
                    //alert(daoshi2.name)//弹出导师名
                    treeData[j] = daoshi2; //将导师嵌入节点
                    //alert(treeData[j]);
                  
                   
                }else {
               	 var children = 
               	 {
                            "name": before_tmp,
                            "parent": "null",
                            "children": [{}]
                    }
               	 treeData[j].children[count] = children; //将导师的学生的年级及职业嵌入节点
                    
                    var bodies = back_tmp.split("、");
                    for (var kk = 0; kk < bodies.length; ++kk) {
                   	 var children = {
                                "name": bodies[kk],
                                "parent": "null"
                            }
                            //treeData.push(children);
                        treeData[j].children[count].children[kk] = children; //将导师的学生的姓名嵌入节点
                    }
                    count++; 
                }  	                     
           }
           
           //和前面所有的树比较，判断是否为关联树
           var tree_tmp = treeData[j];
           var name_tmp = treeData[j].name;
           for (num_tmp = 0; num_tmp < j; num_tmp++) {
               
               //alert("flag = " + flag);
           	flag = check(treeData[num_tmp], name_tmp, tree_tmp, num_tmp);
           }
           if (!flag) count_shu++;
       
       }
       for (var i = 0; i <= count_shu; i++) {
       	
           treeInit(i)
       }

        
}
</script>
	       
	       <br>
	        <center>
	        <p><h2>欢迎使用家族树系统</h2>
		    <textarea id="text" rows="10" cols="50">
		    </textarea>
		    <br>
            <br>
            <br>
    		<button type="button" class="btn btn-success btn-lg " onclick="build()">生成</button>
    		 
    		</center>
</body>
</html>