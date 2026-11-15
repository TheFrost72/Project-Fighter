package ui;

import flixel.FlxSprite;
import flixel.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import objects.Fighter;

class FightHUD extends FlxGroup
{
    var player:Fighter;
    var rival:Fighter;
    var pFill:FlxSprite;
    var rFill:FlxSprite;
    var pEnergy:FlxSprite;
    var rEnergy:FlxSprite;
    var pText:FlxText;
    var rText:FlxText;

    public function new(player:Fighter, rival:Fighter)
    {
        super();
        this.player = player;
        this.rival = rival;

        add(new FlxSprite(18, 28).makeGraphic(250, 13, 0xff202020));
        pFill = new FlxSprite(20, 30);
        pFill.makeGraphic(246, 9, 0xff45d483);
        add(pFill);

        add(new FlxSprite(372, 28).makeGraphic(250, 13, 0xff202020));
        rFill = new FlxSprite(374, 30);
        rFill.makeGraphic(246, 9, 0xff45d483);
        add(rFill);

        pEnergy = new FlxSprite(20, 45);
        pEnergy.makeGraphic(246, 4, 0xff49b8ff);
        add(pEnergy);
        rEnergy = new FlxSprite(374, 45);
        rEnergy.makeGraphic(246, 4, 0xff49b8ff);
        add(rEnergy);

        pText = new FlxText(18, 9, 150, "PLAYER", 12);
        pText.setFormat(null, 12, FlxColor.WHITE, LEFT);
        add(pText);
        rText = new FlxText(472, 9, 150, "RIVAL", 12);
        rText.setFormat(null, 12, FlxColor.WHITE, RIGHT);
        add(rText);

        refresh();
    }

    public function refresh():Void
    {
        pFill.scale.x = Math.max(0, player.health / 100);
        rFill.scale.x = Math.max(0, rival.health / 100);
        pEnergy.scale.x = Math.max(0, player.energy / 100);
        rEnergy.scale.x = Math.max(0, rival.energy / 100);
        rFill.x = 620 - (246 * Math.max(0, rival.health / 100)) - 0;
        rEnergy.x = 620 - (246 * Math.max(0, rival.energy / 100));
    }
}
