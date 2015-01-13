## JasonYounker

jasonyounker.com

### Quick Start
- git clone git@github.com:younker/jasonyounker.git
- cd jasonyounker
- npm install -g nodemon
- npm install -g coffee-script
- npm install
- grunt build
- nodemon express/server.coffee

### Debugging Serverside
1. start app with `--debug`

    nodemon --debug express/server.coffee

2. install and start node-inspector

    npm install -g node-inspector
    node-inspector

3. open up node-inspector in browser using url they provide, probably something like:

    http://127.0.0.1:8080/debug?port=5858

4. add `debugger` to code, refresh app in browser and you will see it hang/spin. Now check out the node inspector window and you should be sitting at your breakpoint.

