page_performance_node
=====================

A simple page performance tool with node and PhantomJS

Target
------

The target of this tool is to simply get aggregatet results from 
loading tests against different websites. The render test is done with 
PhantomJS (the node module). To be able to run different jobs, Kue is 
used for queuing.

Usage
-----

Simply clone the repo and run inside

    npm install
    node app.coffee

Then open a browser at http://localhost:4000 (you know, 3000 is Rails ;-) ).

I plan to also integrate a littel RESTful JSON interface.

Development
-----------

This is still under heavy development and still early stage. So there "are" bugs.

ToDo
----

* Doku
* Tests
* RESTful JSON API
* everything else

License
-------
Released under the MIT license. See the LICENSE file for the complete wording.
