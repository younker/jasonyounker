# http://www.html5rocks.com/en/tutorials/webcomponents/customelements/
# http://developer.telerik.com/featured/web-components-ready-production/
# http://developer.telerik.com/featured/web-components-arent-ready-production-yet/
Proto = Object.create HTMLElement.prototype

# The four lifecycle callbacks
Proto.createdCallback = () ->
  this.innerHTML = 'This is a new xfoo custom element'

Proto.attachedCallback = () ->
  console.log 'xfoo attached'

Proto.detachedCallback = () ->
  console.log 'xfoo detached'

Proto.attributeChangedCallback = () ->
  console.log 'xfoo attr changed'

# Add custom method
Proto.foo = () ->
  console.log 'foo called on moz xfoo (proto)'

# Define a read-only bar property
Object.defineProperty Proto, 'bar', value: 5

# Register
XFoo = document.registerElement 'x-foo',
  prototype: Proto

# Instantiate
xfoo = document.createElement 'x-foo'

# Add to page
document.body.appendChild xfoo
