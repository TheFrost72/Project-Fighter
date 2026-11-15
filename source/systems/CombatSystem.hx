package systems;

import objects.Fighter;

class CombatSystem
{
    var playerHitLock:Float = 0;
    var rivalHitLock:Float = 0;

    public function new() {}

    public function resolve(player:Fighter, rival:Fighter, elapsed:Float):Void
    {
        playerHitLock = Math.max(0, playerHitLock - elapsed);
        rivalHitLock = Math.max(0, rivalHitLock - elapsed);

        if (player.isAttacking && playerHitLock <= 0 && player.canHit(rival))
        {
            rival.takeHit(player.attackDamage);
            playerHitLock = 0.32;
        }

        if (rival.isAttacking && rivalHitLock <= 0 && rival.canHit(player))
        {
            player.takeHit(rival.attackDamage);
            rivalHitLock = 0.36;
        }
    }
}
