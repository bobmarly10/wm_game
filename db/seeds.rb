# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Team.connection.execute('TRUNCATE TABLE teams')
Game.connection.execute('TRUNCATE TABLE games')

Time.zone = 'Berlin'

br = Team.create!(country: 'BR', group: :a)
hr = Team.create!(country: 'HR', group: :a)
mx = Team.create!(country: 'MX', group: :a)
cm = Team.create!(country: 'CM', group: :a)

es = Team.create!(country: 'ES', group: :b)
nl = Team.create!(country: 'NL', group: :b)
cl = Team.create!(country: 'CL', group: :b)
au = Team.create!(country: 'AU', group: :b)

co = Team.create!(country: 'CO', group: :c)
gr = Team.create!(country: 'GR', group: :c)
ci = Team.create!(country: 'CI', group: :c)
jp = Team.create!(country: 'JP', group: :c)

uy = Team.create!(country: 'UY', group: :d)
cr = Team.create!(country: 'CR', group: :d)
en = Team.create!(country: 'EN', group: :d)
it = Team.create!(country: 'IT', group: :d)

ch = Team.create!(country: 'CH', group: :e)
ec = Team.create!(country: 'EC', group: :e)
fr = Team.create!(country: 'FR', group: :e)
hn = Team.create!(country: 'HN', group: :e)

ar = Team.create!(country: 'AR', group: :f)
ba = Team.create!(country: 'BA', group: :f)
ir = Team.create!(country: 'IR', group: :f)
ng = Team.create!(country: 'NG', group: :f)

de = Team.create!(country: 'DE', group: :g)
pt = Team.create!(country: 'PT', group: :g)
gh = Team.create!(country: 'GH', group: :g)
us = Team.create!(country: 'US', group: :g)

be = Team.create!(country: 'BE', group: :h)
dz = Team.create!(country: 'DZ', group: :h)
ru = Team.create!(country: 'RU', group: :h)
kr = Team.create!(country: 'KR', group: :h)



br = Team.find_by(country: 'BR')
hr = Team.find_by(country: 'HR')
mx = Team.find_by(country: 'MX')
cm = Team.find_by(country: 'CM')
es = Team.find_by(country: 'ES')
nl = Team.find_by(country: 'NL')
cl = Team.find_by(country: 'CL')
au = Team.find_by(country: 'AU')
co = Team.find_by(country: 'CO')
gr = Team.find_by(country: 'GR')
ci = Team.find_by(country: 'CI')
jp = Team.find_by(country: 'JP')
uy = Team.find_by(country: 'UY')
cr = Team.find_by(country: 'CR')
en = Team.find_by(country: 'EN')
it = Team.find_by(country: 'IT')
ch = Team.find_by(country: 'CH')
ec = Team.find_by(country: 'EC')
fr = Team.find_by(country: 'FR')
hn = Team.find_by(country: 'HN')
ar = Team.find_by(country: 'AR')
ba = Team.find_by(country: 'BA')
ir = Team.find_by(country: 'IR')
ng = Team.find_by(country: 'NG')
de = Team.find_by(country: 'DE')
pt = Team.find_by(country: 'PT')
gh = Team.find_by(country: 'GH')
us = Team.find_by(country: 'US')
be = Team.find_by(country: 'BE')
dz = Team.find_by(country: 'DZ')
ru = Team.find_by(country: 'RU')
kr = Team.find_by(country: 'KR')

# round 1

# day 1
Game.create!(team_a: br, team_b: hr, group: :a, start_at: Time.parse('2014-06-12 22:00'))
# day 2
Game.create!(team_a: mx, team_b: cm, group: :a, start_at: Time.parse('2014-06-13 18:00'))
Game.create!(team_a: es, team_b: nl, group: :b, start_at: Time.parse('2014-06-13 21:00'))
Game.create!(team_a: cl, team_b: au, group: :b, start_at: Time.parse('2014-06-14 00:00'))
# day 3
Game.create!(team_a: co, team_b: gr, group: :c, start_at: Time.parse('2014-06-14 18:00'))
Game.create!(team_a: uy, team_b: cr, group: :d, start_at: Time.parse('2014-06-14 21:00'))
Game.create!(team_a: en, team_b: it, group: :d, start_at: Time.parse('2014-06-15 00:00'))
Game.create!(team_a: ci, team_b: jp, group: :c, start_at: Time.parse('2014-06-15 03:00'))
# day 4
Game.create!(team_a: ch, team_b: ec, group: :e, start_at: Time.parse('2014-06-15 18:00'))
Game.create!(team_a: fr, team_b: hn, group: :e, start_at: Time.parse('2014-06-15 21:00'))
Game.create!(team_a: ar, team_b: ba, group: :f, start_at: Time.parse('2014-06-16 00:00'))
# day 5
Game.create!(team_a: de, team_b: pt, group: :g, start_at: Time.parse('2014-06-16 18:00'))
Game.create!(team_a: ir, team_b: ng, group: :f, start_at: Time.parse('2014-06-16 21:00'))
Game.create!(team_a: gh, team_b: us, group: :g, start_at: Time.parse('2014-06-17 00:00'))
# day 6
Game.create!(team_a: be, team_b: dz, group: :h, start_at: Time.parse('2014-06-17 18:00'))
Game.create!(team_a: br, team_b: mx, group: :a, start_at: Time.parse('2014-06-17 21:00'))
Game.create!(team_a: ru, team_b: kr, group: :h, start_at: Time.parse('2014-06-18 00:00'))
# day 7
Game.create!(team_a: au, team_b: nl, group: :b, start_at: Time.parse('2014-06-18 18:00'))
Game.create!(team_a: es, team_b: cl, group: :b, start_at: Time.parse('2014-06-18 21:00'))
Game.create!(team_a: cm, team_b: hr, group: :a, start_at: Time.parse('2014-06-19 00:00'))
# day 8
Game.create!(team_a: co, team_b: ci, group: :c, start_at: Time.parse('2014-06-19 18:00'))
Game.create!(team_a: uy, team_b: en, group: :d, start_at: Time.parse('2014-06-19 21:00'))
Game.create!(team_a: jp, team_b: gr, group: :c, start_at: Time.parse('2014-06-20 00:00'))
# day 9
Game.create!(team_a: it, team_b: cr, group: :d, start_at: Time.parse('2014-06-20 18:00'))
Game.create!(team_a: ch, team_b: fr, group: :e, start_at: Time.parse('2014-06-20 21:00'))
Game.create!(team_a: hn, team_b: ec, group: :e, start_at: Time.parse('2014-06-21 00:00'))
# day 10
Game.create!(team_a: ar, team_b: ir, group: :f, start_at: Time.parse('2014-06-21 18:00'))
Game.create!(team_a: de, team_b: gh, group: :g, start_at: Time.parse('2014-06-21 21:00'))
Game.create!(team_a: ng, team_b: ba, group: :f, start_at: Time.parse('2014-06-22 00:00'))
# day 11
Game.create!(team_a: be, team_b: ru, group: :h, start_at: Time.parse('2014-06-22 18:00'))
Game.create!(team_a: kr, team_b: dz, group: :h, start_at: Time.parse('2014-06-22 21:00'))
Game.create!(team_a: us, team_b: pt, group: :g, start_at: Time.parse('2014-06-23 00:00'))
# day 12
Game.create!(team_a: nl, team_b: cl, group: :b, start_at: Time.parse('2014-06-23 18:00'))
Game.create!(team_a: au, team_b: es, group: :b, start_at: Time.parse('2014-06-23 18:00'))
Game.create!(team_a: cm, team_b: br, group: :a, start_at: Time.parse('2014-06-23 22:00'))
Game.create!(team_a: hr, team_b: mx, group: :a, start_at: Time.parse('2014-06-23 22:00'))
# day 13
Game.create!(team_a: it, team_b: uy, group: :d, start_at: Time.parse('2014-06-24 18:00'))
Game.create!(team_a: cr, team_b: en, group: :d, start_at: Time.parse('2014-06-24 18:00'))
Game.create!(team_a: jp, team_b: co, group: :c, start_at: Time.parse('2014-06-24 22:00'))
Game.create!(team_a: gr, team_b: ci, group: :c, start_at: Time.parse('2014-06-24 22:00'))
# day 14
Game.create!(team_a: ng, team_b: ar, group: :f, start_at: Time.parse('2014-06-25 18:00'))
Game.create!(team_a: ba, team_b: ir, group: :f, start_at: Time.parse('2014-06-25 18:00'))
Game.create!(team_a: hn, team_b: ch, group: :e, start_at: Time.parse('2014-06-25 22:00'))
Game.create!(team_a: ec, team_b: fr, group: :e, start_at: Time.parse('2014-06-25 22:00'))
# day 15
Game.create!(team_a: pt, team_b: gh, group: :g, start_at: Time.parse('2014-06-26 18:00'))
Game.create!(team_a: us, team_b: de, group: :g, start_at: Time.parse('2014-06-26 18:00'))
Game.create!(team_a: kr, team_b: be, group: :h, start_at: Time.parse('2014-06-26 22:00'))
Game.create!(team_a: dz, team_b: ru, group: :h, start_at: Time.parse('2014-06-26 22:00'))


# 1/8 finals
Game.create!(team_a: br, team_b: ch, finals: :last_16, start_at: Time.parse('2014-06-28 18:00'))
Game.create!(team_a: co, team_b: uy, finals: :last_16, start_at: Time.parse('2014-06-28 22:00'))
Game.create!(team_a: nl, team_b: mx, finals: :last_16, start_at: Time.parse('2014-06-29 18:00'))
Game.create!(team_a: cr, team_b: gr, finals: :last_16, start_at: Time.parse('2014-06-29 22:00'))
Game.create!(team_a: fr, team_b: ng, finals: :last_16, start_at: Time.parse('2014-06-30 18:00'))
Game.create!(team_a: de, team_b: dz, finals: :last_16, start_at: Time.parse('2014-06-30 22:00'))
Game.create!(team_a: ar, team_b: ch, finals: :last_16, start_at: Time.parse('2014-07-01 18:00'))
Game.create!(team_a: be, team_b: us, finals: :last_16, start_at: Time.parse('2014-07-01 22:00'))

# 1/4 finals
Game.create!(team_a: fr, team_b: de, finals: :last_8, start_at: Time.parse('2014-07-04 18:00'))
Game.create!(team_a: br, team_b: co, finals: :last_8, start_at: Time.parse('2014-07-04 22:00'))
Game.create!(team_a: ar, team_b: be, finals: :last_8, start_at: Time.parse('2014-07-05 18:00'))
Game.create!(team_a: nl, team_b: cr, finals: :last_8, start_at: Time.parse('2014-07-05 22:00'))

# 1/2 finals
Game.create!(team_a: br, team_b: de, finals: :last_4, start_at: Time.parse('2014-07-08 22:00'))
Game.create!(team_a: nl, team_b: ar, finals: :last_4, start_at: Time.parse('2014-07-09 22:00'))

# 3rd place
Game.create!(team_a: br, team_b: nl, finals: :last_2, start_at: Time.parse('2014-07-12 22:00'))

# finals
Game.create!(team_a: de, team_b: ar, finals: :last_2, start_at: Time.parse('2014-07-13 21:00'))

