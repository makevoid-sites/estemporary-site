# estemporary

EsTemporary website

open source - instructions follow:

### install everything

    bundle

### run webite/app:

    bundle exec rackup -p 3000


then visit http://localhost:3000


### dev tasks:

link source images with dropbox dir  

    ln -s ~/Dropbox/estemporary/photos_src public/

generate images and thumbs:

    cd public; ruby resize.rb

---

### Credits:

Image gallery with [Fancybox2](http://fancyapps.com/fancybox/) (CCAttribution)
