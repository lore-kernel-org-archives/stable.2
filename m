Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62F54704D;
	Fri, 16 Oct 2026 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792126951; cv=none; b=XlT0WUNaSoapbk9F9d05eLzDTJl8Do3Ny6jwtQSr5eluw3YbU3WxrG1dcdbo81n5StSxhQ3hwJnqQDHLinWu641WtKRbvDHUwf6AJkh4NR5PqvjfszSEqbUXNaCe5jSfTEOuNtOVx1kXhecNIP0KvoHPgSUSvTKIWdUp5xJ8RA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792126951; c=relaxed/simple;
	bh=KOBChZu/RXJGJj7Q1jqdW7CYdziDCfFze2ZQ74tHsa0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IuXlzkjs6eyqXtzCnxjSx8Kh0QwOPvHEvTuq+WZnlaX0ie/Qrc1qFgAT0v/UtOamR+Fb0w5kTssK3UQxl5dD+U20QYteNOtJeI2SNMX52HxFElUrpCzpAC7WKLCp7yLydto1N6d+AoxniKbY/fs9i2Hw4xAzIuAbG0pVM+0nVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtzVy1ih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtzVy1ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B271F000C4;
	Fri, 16 Oct 2026 05:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792126950;
	bh=ofHJ0AU9zMpvLLzpIeVQ1M96hYTVnc0UtFDnFu9jKcA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZtzVy1ihP4VsDHVWMfFRwI6Uqha4WG2twjKwRoFb/uwl17EATWn1U1NYWsNZPWTHQ
	 EyYqhTzC8zWyTgRIE1pKsTUmAaNgrjJQpxl8DrDRB7vVOqD5ipfwSdgt8pABqMsTFV
	 sOusLy0yYKgWIPs4ZG0lmdpUijPkqx59FUbSQbkZlQuOt5sVWICk2lUoUI2rWlngXC
	 Hvay+tOmP+EysQJBWs5N4H1I3KISuR1rzsAcb2EjEXXY9AN8R432GEtBnKjsIISmXZ
	 TXygl3jFVNnUkqFOZlUWW0oKh4InW013gvgwRD43EOhG1wQE2dz5+hr8yuWN/bCdaB
	 ad04rxDWg+SGw==
Subject: Re: [PATCH net v3 1/5] can: dev: prevent bus-off recovery when the
 interface is not running
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, heiko@sntech.de,
 davem@davemloft.net, wg@grandegger.com, socketcan@hartkopp.net,
 kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 16 Oct 2026 05:02:29 +0000
Message-ID: <179212694915.1406898.5096495212984871051@kernel.org>
In-Reply-To: <20261014-rockchip-canfd-restart-close-v3-1-f0eb41090242@qq.com>
References: <20261014-rockchip-canfd-restart-close-v3-1-f0eb41090242@qq.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new `if (!netif_running(dev)) return -ENETDOWN;` in
  can_restart() (drivers/net/can/dev/dev.c:201) is a lockless test_bit()…
- [Low] The comment above can_bus_off() in drivers/net/can/dev/dev.c
  (line 265) still says "If enabled, a timer is started to trigger bus-…

--

can: dev: prevent bus-off recovery when the interface is not running

This patch adds a netif_running() check to can_restart() so that bus-off
recovery is skipped once __LINK_STATE_START has been cleared. It also
makes can_bus_off() schedule restart_work only for a running interface.
The commit message notes that the checks do not wait for recovery that
has already passed the check.

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c..92492c503446 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -198,6 +198,9 @@ static int can_restart(struct net_device *dev)
>  	if (!priv->do_set_mode)
>  		return -EOPNOTSUPP;
>  
> +	if (!netif_running(dev))
> +		return -ENETDOWN;
> +

[Severity: Medium]
Is this check enough to prevent the failure described in the commit
message, "potentially re-enabling hardware while the driver is tearing it
down"?

netif_running() is a lockless test_bit(). can_restart_work() runs from
the system workqueue and holds neither RTNL nor the instance lock.
__dev_close_many() clears __LINK_STATE_START under RTNL and calls
ndo_stop() some time after that. A restart that tests the bit just before
the clear_bit() still goes on to:

can_restart_work()
  can_restart()
    can_flush_echo_skb()
    netif_rx()
    netif_carrier_on()
    priv->do_set_mode(dev, CAN_MODE_START)

and this can overlap with the driver's ndo_stop().

The only core cancel point is close_candev(), and most drivers call it
after they have already torn down the hardware. For example, in
drivers/net/can/sja1000/sja1000.c:

sja1000_close() {
	netif_stop_queue(dev);
	set_reset_mode(dev);

	if (!(priv->flags & SJA1000_CUSTOM_IRQ_HANDLER))
		free_irq(dev->irq, (void *)dev);

	close_candev(dev);
	...
}

while the restart callback concurrently does:

sja1000_set_mode() {
	case CAN_MODE_START:
		sja1000_start(dev);
		if (netif_queue_stopped(dev))
			netif_wake_queue(dev);
	...
}

Could the controller end up out of reset mode, with interrupts enabled
and the queue woken, after its IRQ handler has been freed? By the time
cancel_delayed_work_sync() in close_candev() waits for the work, the
restart has already happened.

flexcan_close() follows the same order. It disables interrupts, frees
the IRQs, stops the chip, deletes rx-offload and disables the transceiver
before it calls close_candev(). Meanwhile flexcan_set_mode() can be
restarting the chip and re-enabling interrupts.

As far as I can tell, only rockchip_canfd gets
close_candev_cancel_restart_sync() at the start of ndo_stop by the end of
the series. flexcan, sja1000 and the other close_candev() users keep the
window.

Would it make sense to serialize this instead of relying on a lockless
pre-check? One option is to cancel restart_work before any driver
hardware teardown. Another is to recheck under RTNL via rtnl_trylock()
and requeue the work if the trylock fails.

>  	if (netif_carrier_ok(dev))
>  		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
>  
> @@ -264,8 +267,9 @@ int can_restart_now(struct net_device *dev)
>  void can_bus_off(struct net_device *dev)
>  {
>  	struct can_priv *priv = netdev_priv(dev);
> +	const bool restart = priv->restart_ms && netif_running(dev);

[Severity: Low]
This isn't a bug, but the comment above can_bus_off() still describes the
old condition:

/* CAN bus-off
 *
 * This functions should be called when the device goes bus-off to
 * tell the netif layer that no more packets can be sent or received.
 * If enabled, a timer is started to trigger bus-off recovery.
 */

Could it mention that recovery is now only scheduled when the interface
is running?

The word "timer" was already inaccurate before this patch, because
recovery is a delayed work item (priv->restart_work).

The restart-ms description in Documentation/networking/can.rst also says
nothing about a running interface. That matters less, since a down
interface has no user-visible bus-off condition.

>  
> -	if (priv->restart_ms)
> +	if (restart)
>  		netdev_info(dev, "bus-off, scheduling restart in %d ms\n",
>  			    priv->restart_ms);
>  	else

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014-rockchip-canfd-restart-close-v3-0-f0eb41090242%40qq.com
