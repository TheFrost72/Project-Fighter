package objects;

import flixel.FlxSprite;

class Fighter extends FlxSprite
{
    public var health:Float = 100;
    public var energy:Float = 0;
    public var facingRight:Bool = true;
    public var isCPU:Bool = false;
    public var attackTimer:Float = 0;
    public var attackFlash:Float = 0;
    public var isAttacking:Bool = false;
    public var attackDamage:Float = 10;
    public var attackRange:Float = 54;
    var onGround:Bool = false;

    static inline var MOVE_SPEED:Float = 150;
    static inline var JUMP_SPEED:Float = 330;
    static inline var GRAVITY:Float = 900;
    static inline var FLOOR_Y:Float = 220;

    var wantLeft:Bool = false;
    var wantRight:Bool = false;
    var wantJump:Bool = false;
    var wantAttack:Bool = false;
    var wantSpecial:Bool = false;
    var cpuThink:Float = 0;

    public function new(x:Float, y:Float, tint:Int, label:String)
    {
        super(x, y);
        makeGraphic(24, 42, tint);
        maxVelocity.set(MOVE_SPEED, 500);
        acceleration.y = GRAVITY;
        drag.x = 1100;
        health = 100;
        energy = 0;
    }

    public function setInput(left:Bool, right:Bool, jump:Bool, attack:Bool, special:Bool):Void
    {
        wantLeft = left;
        wantRight = right;
        wantJump = jump;
        wantAttack = attack;
        wantSpecial = special;
    }

    public function updateCPU(target:Fighter, elapsed:Float):Void
    {
        if (!isCPU) return;

        cpuThink -= elapsed;
        if (cpuThink <= 0)
        {
            cpuThink = 0.12;
            var dx = target.x - x;
            wantLeft = dx < -58;
            wantRight = dx > 58;
            wantJump = false;
            wantAttack = Math.abs(dx) < 66 && attackTimer <= 0;
            wantSpecial = false;
        }
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (attackTimer > 0) attackTimer -= elapsed;
        if (attackFlash > 0) attackFlash -= elapsed;
        isAttacking = attackFlash > 0;

        if (wantLeft && !wantRight)
        {
            velocity.x = -MOVE_SPEED;
            facingRight = false;
        }
        else if (wantRight && !wantLeft)
        {
            velocity.x = MOVE_SPEED;
            facingRight = true;
        }
        else velocity.x = 0;

        if (wantJump && onGround)
        {
            velocity.y = -JUMP_SPEED;
            onGround = false;
        }

        if (wantAttack && attackTimer <= 0)
            startAttack(0.28, 0);

        if (wantSpecial && attackTimer <= 0 && energy >= 25)
        {
            energy -= 25;
            startAttack(0.48, 18);
        }

        // Limpa comandos de um único toque.
        wantJump = false;
        wantAttack = false;
        wantSpecial = false;

        if (y >= FLOOR_Y)
        {
            y = FLOOR_Y;
            velocity.y = 0;
            onGround = true;
        }
        else onGround = false;
    }

    public function startAttack(duration:Float, bonusRange:Float):Void
    {
        attackTimer = 0.42;
        attackFlash = duration;
        attackDamage = bonusRange > 0 ? 22 : 10;
        attackRange = bonusRange > 0 ? 82 : 54;
        if (bonusRange <= 0) energy = Math.min(100, energy + 8);
    }

    public function takeHit(damage:Float):Void
    {
        health = Math.max(0, health - damage);
        velocity.x = facingRight ? 85 : -85;
        energy = Math.min(100, energy + 12);
    }

    public function canHit(target:Fighter):Bool
    {
        var dx = target.x - x;
        var inFront = facingRight ? dx > 0 : dx < 0;
        return inFront && Math.abs(dx) < attackRange && Math.abs(target.y - y) < 48;
    }
}

