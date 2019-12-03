# Vue.js Integration in Yii2

## Plugin application integration

Add this plugin to composer.json
```bash
composer require antkaz/yii2-vue  --ignore-platform-reqs 
```

## View file  integration

In your php view files add this following code at the beginning :
```php
use antkaz\vue\VueAsset;
VueAsset::register($this);
```
Now you can create Vue.js (v2) applications and component inside of your php view files.

## Running example

Add this code to your view file to test if Vue.js is working well.

Example :
```html
<div id='app'>
  <h1>Trying out Vue.js</h1>
 <p>{{ message }}</p>
  <button v-on:click="reverseMessage">Reverse Message</button>
</div>

<script>
new Vue({
  el: '#app',
  data: {
    message: "OpenSILEX is awesome!"
  },
  methods: {
    reverseMessage: function() {
      this.message = this.message.split('').reverse().join('')
    }
  }
})
</script>
```