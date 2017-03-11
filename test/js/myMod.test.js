const test = require('ava')
const myMod = require('../../_build/self/myMod')

test('same output with reason', t => {
  t.is(myMod.secret, 'hello')
})
