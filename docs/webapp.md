---
title: Webapp
layout: default
---
# Webapp

## Form style

When you create a new form, think to specify the bootstrap class .well like it is presented below in `views/experiment/_form.php`  for the experiment form :

```
<div class="experiment-form well">

   <?php $form = ActiveForm::begin(); ?>
```

## Activate animated multiple background images feature

If you want to activate animated multiple background images feature, go to `views/site/index.php` . Add `use app\components\widgets\FullScreenImageSliderWidget;` at the beginning of the file and use the code below.

**Usage**

``` php
      <?= 
         FullScreenImageSliderWidget::widget([
               FullScreenImageSliderWidget::IMAGES_URL_LINK => [ // local image links
                  "background/wallpaper_grapes_vine.jpg",
                  "background/wallpaper_leaf.jpg",
                  "background/wallpaper_tomato.jpg",
                  "background/wallpaper_vine.jpg"
               ],
            // FullScreenImageSliderWidget::DURATION_PER_IMAGE => 10 // time in seconds between two images
         ]);
      ?>
```

**More information**

Image links are concatenated with `{web_app_path}/web/images/`.
For example, `background/wallpaper_grapes_vine.jpg` in the example code below will create a link to `{web_app_path}/web/images/background/wallpaper_grapes_vine.jpg`.

 - *You can also see `{web_app_path}/web/css/full-slider.css` file to set different css animation style.*
 - *Urls are currently not supported.*