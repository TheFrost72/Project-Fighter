package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxVirtualPad;
import flixel.ui.FlxDPadMode;
import flixel.ui.FlxActionMode;
import flixel.ui.FlxVirtualInputID;
import objects.Fighter;
import systems.CombatSystem;
import ui.FightHUD;

class PlayState extends FlxState
{
    var player:Fighter;
    var rival:Fighter;
    var pad:FlxVirtualPad;
    var combat:CombatSystem;
    var hud:FightHUD;
    var ground:FlxSprite;
    var info:FlxText;

    override public function create():Void
    {
        super.create();

        FlxG.camera.bgColor = 0xff18243b;

        // Fundo e plataforma: placeholders para trocar por arte depois.
        var sky = new FlxSprite(0, 0);
        sky.makeGraphic(640, 270, 0xff263b5c);
        add(sky);

        var far = new FlxSprite(0, 215);
        far.makeGraphic(640, 55, 0xff344b67);
        add(far);

        ground = new FlxSprite(0, 270);
        ground.makeGraphic(640, 90, 0xff252b38);
        ground.immovable = true;
        add(ground);

        // Linha de chão visual.
        var floorLine = new FlxSprite(0, 270);
        floorLine.makeGraphic(640, 3, 0xffe5b85c);
        add(floorLine);

        player = new Fighter(145, 220, 0xff36c5f0, "PLAYER");
        rival = new Fighter(455, 220, 0xffef665f, "RIVAL");
        rival.isCPU = true;
        add(player);
        add(rival);

        combat = new CombatSystem();
        hud = new FightHUD(player, rival);
        add(hud);

        // Direcional + três ações: pulo, ataque e especial de teste.
        #if mobile
        pad = new FlxVirtualPad(FlxDPadMode.LEFT_RIGHT, FlxActionMode.A_B_C);
        pad.alpha = 0.82;
        add(pad);
        #end

        info = new FlxText(0, 8, 640, "PIXEL FIGHTER  |  TEST BUILD", 12);
        info.setFormat(null, 12, FlxColor.WHITE, CENTER);
        info.scrollFactor.set(0, 0);
        add(info);

        FlxG.worldBounds.set(0, 0, 640, 360);
    }

    override public function update(elapsed:Float):Void
    {
        var left = FlxG.keys.anyPressed([LEFT, A]);
        var right = FlxG.keys.anyPressed([RIGHT, D]);
        var jump = FlxG.keys.anyJustPressed([SPACE, W, UP]);
        var attack = FlxG.keys.anyJustPressed([J, X]);
        var special = FlxG.keys.anyJustPressed([K, C]);

        #if mobile
        left = left || pad.getButton(FlxVirtualInputID.LEFT).pressed;
        right = right || pad.getButton(FlxVirtualInputID.RIGHT).pressed;
        jump = jump || pad.getButton(FlxVirtualInputID.A).justPressed;
        attack = attack || pad.getButton(FlxVirtualInputID.B).justPressed;
        special = special || pad.getButton(FlxVirtualInputID.C).justPressed;
        #end

        player.setInput(left, right, jump, attack, special);

        // IA simples para o rival de demonstração.
        rival.updateCPU(player, elapsed);

        super.update(elapsed);

        // Mantém os lutadores na arena e no mesmo plano.
        player.y = Math.min(player.y, 220);
        rival.y = Math.min(rival.y, 220);
        player.x = Math.max(18, Math.min(600, player.x));
        rival.x = Math.max(18, Math.min(600, rival.x));

        combat.resolve(player, rival, elapsed);
        hud.refresh();

        if (player.health <= 0 || rival.health <= 0)
        {
            info.text = player.health <= 0 ? "RIVAL VENCEU! (reinicie para testar)" : "PLAYER VENCEU! (reinicie para testar)";
        }
    }
}
