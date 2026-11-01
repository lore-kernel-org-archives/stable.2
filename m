Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551959;
	b=JmaTjcaTquAn9otW4cqFUzy+Hi/yZV7uGPeiM36+SxJ5oO5wEEnW9sALCbkWcZZ/RsFN
	 e+joYzcm1ST5pn8FewMWQgKAitOqIeI8g3JzwcfclfPzAMo2XKKYDhrkwojM7Hji01UOy
	 UNwwu5Z/+MIf0NFCAQOqrpElHlCwug1xV2CdIzDeUK8PTjui7rXWpSgiobPNb/hGQABEG
	 JeeHTC0wUH5qMd1++kYjnHRtCg1zQL7/NVE7+rEesV2PZeZsK+VNybpbOUoFUykdHR7tt
	 t81QJfwmbuLkJcp+iBDBQzIdUEMX8Q88D1uYn2gX804uipuI+3DGUm7BMoEag8mGT3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551959;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=m4Jbx6Bfo1ddm8Iqy1wqgq9WiTU/MIHTtxEsKpTryfA=;
	b=d0adHRxCSvBJ/fQ8nkVkzIqEN+WEP0tZutVfYQoBw9qgVtjm/Sa/Sn91ypqqsWkmcexL
	 B9fYS6CQczDrvVtVttec+WQUSUZxhxlQL000f7kHydbiAbbLNujt/jo5ibnQ8yp6Q5m07
	 doU9eNW5S/hQ8gJLPAsOmccuB/rrCMoyyCotq8IICD/c3lngjBzoK2SiS0t8y1uxs4hNE
	 qAYRqh0/wmFb6jH17kLTzVDGEZzIRe6Le8NbxPDvfOHPfe5ZrOUv11fLJAxZjrtA0mz79
	 2dXdT9USfG9uOxAfCxHOrBQezHyEMjWVqlgBNE6yNbDu25VlfSO9Xgy0m8NjkpFu3vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhoXEZxD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE7606A324;
	Sun,  1 Nov 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhoXEZxD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1931F000C1;
	Sun,  1 Nov 2026 16:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793551958;
	bh=m4Jbx6Bfo1ddm8Iqy1wqgq9WiTU/MIHTtxEsKpTryfA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UhoXEZxD/lABF3hCCh1uoq03tqfOlcwp5FcWDndtpoLX9o68BYueCl75NL12l7+kA
	 g8PcKwKSKdbw9zDNvrBUbIM6Rc934HZM2xbmgR/Dt2U5DnWK3r0OwK38puq+IDqSq0
	 uLm26hUiP54VANmDk5jvuO529HkhKtQ6KATB+n2bmnyHxhLxsxKUsLoUUEZ2nzzLep
	 KFkg9Oh3T4aJi5y/PVUvmzN8WdY6GR7kQKg4Uwifvhqv7hVMANoRWwFtOCFma1FCev
	 CDamEpBMxJhvBooj5kY7BKQszBTH4hUcak+QqjqfFEuYppjLklzOVWEGQCHSsIqpJb
	 skmxTLlYV0lPA==
Subject:
 Re: [PATCH net v2] net: usb: lan78xx: let unregister_netdev() stop phylink
From: netdev-bot+sashiko@kernel.org
To: 25031212351@stu.xidian.edu.cn
Cc: Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 o.rempel@pengutronix.de, stable@vger.kernel.org, byu@xidian.edu.cn,
 wencheng@xidian.edu.cn, kuba@kernel.org
Date: Sun, 01 Nov 2026 16:52:37 +0000
Message-ID: <179355195704.3131.3408534065723152966@kernel.org>
In-Reply-To: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>
References: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The reordered disconnect still calls phy_stop() on a halted
  PHY after a normal system suspend/resume of an open interface.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but lan78xx has an
  AB-BA lock inversion between dev->dev_mutex and rtnl_mutex.
- [Low] This problem wasn't introduced by this patch, but lan78xx_stop()
  uses timer_pending() to decide whether to synchronize with the…

--

net: usb: lan78xx: let unregister_netdev() stop phylink

This patch reorders lan78xx_disconnect() so that unregister_netdev() runs
first and phylink_disconnect_phy() runs after it. The explicit
phylink_stop() call is dropped, so that phylink is only stopped through
lan78xx_stop() when the interface is running. The aim is to avoid the
phy_stop() "called from state READY/HALTED" warning on unplug.

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 181e8c087655c..4780aef87736e 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -4593,13 +4593,12 @@ static void lan78xx_disconnect(struct usb_interface *intf)
>
>  	net = dev->net;
>
> +	unregister_netdev(net);
> +

[Severity: Medium]
The commit message says the interface is "stopped exactly once and only
while it is running". Does that still hold after a normal system suspend
and resume of an open interface?

Consider this sequence:

ifup
  lan78xx_open()
    phylink_start()

system suspend
  lan78xx_suspend()
    phylink_suspend(dev->phylink, false)
      phylink_stop()
        phy_stop()      /* PHY now PHY_HALTED, IFF_UP still set */

lan78xx_phylink_mac_ops has no .mac_set_wol, so mac_wol is false and
phylink_suspend() goes through phylink_stop().

normal (non-reset) resume
  lan78xx_resume()      /* no phylink_resume() or phylink_start() */

phylink_resume() is only called from lan78xx_reset_resume(). Because
pc->mac_managed_pm = true, phylib does not restart the PHY either.

unplug
  lan78xx_disconnect()
    unregister_netdev()
      dev_close()
        lan78xx_stop()
          phylink_stop()
            phy_stop()

That reaches this check in phy_stop() with the state HALTED:

	if (!phy_is_started(phydev) && phydev->state != PHY_DOWN &&
	    phydev->state != PHY_ERROR) {
		WARN(1, "called from state %s\n",

Before this patch the warning fired twice in this sequence. Now it fires
once.

The same gap also leaves the link down after such a resume, and a plain
ifdown afterwards hits the same warning.

Would it make sense to also restart phylink on the normal resume path in
lan78xx_resume(), in addition to this reordering?

[Severity: High]
This isn't a bug introduced by this patch, but the commit message relies on
lan78xx_stop() taking dev->dev_mutex under RTNL via unregister_netdev().
Is there a lock order inversion between dev->dev_mutex and rtnl_mutex?

lan78xx_open() and lan78xx_stop() run as ndo_open/ndo_stop with RTNL
already held by __dev_open()/__dev_close_many(), and then take dev_mutex:

  rtnl_mutex -> dev->dev_mutex

lan78xx_suspend() does the reverse for an open interface:

	mutex_lock(&dev->dev_mutex);
	...
		rtnl_lock();
		phylink_suspend(dev->phylink, false);
		rtnl_unlock();

  dev->dev_mutex -> rtnl_mutex

The rtnl_lock() block in lan78xx_suspend() came in with e110bc825897, the
commit named in the Fixes tag.

With CONFIG_PROVE_LOCKING, ifup followed by a system suspend with the
interface open looks like it would produce a circular locking dependency
report.

A real deadlock would need a non-frozen context holding RTNL to call
ndo_open/ndo_stop on this device while lan78xx_suspend() holds dev_mutex.
One example is netns teardown in cleanup_net() moving the device back to
init_net, which goes through dev_close() and then lan78xx_stop().

[Severity: Low]
This is a pre-existing issue, but lan78xx_stop() is now the only place
that stops a running interface on disconnect. lan78xx_stop() uses
timer_pending() to decide whether to synchronize with the stat_monitor
timer:

	if (timer_pending(&dev->stat_monitor))
		timer_delete_sync(&dev->stat_monitor);
	...
	clear_bit(EVENT_STAT_UPDATE, &dev->flags);

	cancel_delayed_work_sync(&dev->wq);

Can the stats timer be re-armed after ifdown?

If lan78xx_delayedwork() has already passed test_bit(EVENT_STAT_UPDATE)
and is inside lan78xx_update_stats(), the timer is not pending, so the
sync delete is skipped. cancel_delayed_work_sync() then waits for the
work, and the work finishes with:

		mod_timer(&dev->stat_monitor,
			  jiffies + (STAT_UPDATE_TIMER * dev->delta));

lan78xx_delayedwork() has no EVENT_DEV_OPEN check. So the timer and work
keep cycling while the interface is down, autoresuming the device and
issuing USB stats reads.

The same thing can happen when lan78xx_stat_monitor() is already running
on another CPU. Its lan78xx_defer_kevent(dev, EVENT_STAT_UPDATE) can land
after the clear_bit() or after cancel_delayed_work_sync().

An unconditional timer_delete_sync() would not cover the first case on
its own. The work would also need to be cancelled before the timer is
shut down.

On disconnect, timer_shutdown_sync(), EVENT_DEV_DISCONNECT and the
cancel_delayed_work_sync() in lan78xx_disconnect() still clean this up.

>  	rtnl_lock();
> -	phylink_stop(dev->phylink);
>  	phylink_disconnect_phy(dev->phylink);
>  	rtnl_unlock();
>
> -	unregister_netdev(net);
> -
>  	timer_shutdown_sync(&dev->stat_monitor);
>  	set_bit(EVENT_DEV_DISCONNECT, &dev->flags);
>  	cancel_delayed_work_sync(&dev->wq);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031165213.2738-1-25031212351%40stu.xidian.edu.cn
