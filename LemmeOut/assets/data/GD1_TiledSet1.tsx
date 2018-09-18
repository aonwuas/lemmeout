<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.1" tiledversion="2018.09.12" name="GD1_TiledSet1" tilewidth="32" tileheight="32" tilecount="4" columns="4">
 <image source="../TilesMapTest.png" width="128" height="32"/>
 <terraintypes>
  <terrain name="Wall" tile="2"/>
  <terrain name="Floor" tile="0"/>
  <terrain name="Science" tile="3"/>
  <terrain name="WallEnd" tile="1"/>
 </terraintypes>
 <tile id="0" terrain="0,0,0,0"/>
 <tile id="1" terrain=",,2,">
  <objectgroup draworder="index">
   <object id="5" x="0" y="0" width="32" height="32"/>
  </objectgroup>
 </tile>
 <tile id="2" terrain="0,0,0,0"/>
</tileset>
