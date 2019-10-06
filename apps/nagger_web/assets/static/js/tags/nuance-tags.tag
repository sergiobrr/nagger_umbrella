<nuance-tags>
  <label>
    <input type="text" name="tags" placeholder="Insert tags comma separated"
      value="{ opts.tags }" onkeyup="{ parseTags }">
  </label>
  <h6>pippo - { opts.nuance_id } - pluto</h6>
  <button class="button" onclick="{addtag}">Add tag</button>
  <script>
    //const superagent = require('superagent');
    this.on('mount', function () {
        console.log('mounted....');
        superagent.get('/api/tags')
        .end(function (err, res) {
            console.log('err', err, 'res', res);
            if (err === null) {
               this.tags = res.body.data;
            }
        });
    });

    this.addtag = function () {
        console.log('Adesso sì...');
        superagent.post('/api/tags')
        .send({tag: {value: 'pluto'}, nuance_id: this.opts.nuance_id})
        .end(function (err, res) {
           console.log('err', err, 'res', res);
        });
    };

    this.parseTags = function (e) {
        console.log('e', e);
        console.log('actual tags', this.opts.tags);
    };

  </script>
</nuance-tags>
