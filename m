Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636445;
	b=aNK7paMvUpEbVh8+9kreUWKbDXmRMXugpSwc83vOujzYJoOxOr163q9z1PBHAn9K0VN5
	 c0GD86oW4KY2LtnZwOca+27YljoRMKc8FWew2bSiR0Ay7XnFXYkDL3QqQHmbJw2e8tyb6
	 g0iNmH1rJHv3jRfy3C0qkBbMwsRB0H8K7RPnWSDkK+5BI0VssoV5gIgHn/ZbdXU1Vor0v
	 DKzgh9A26F5ugHebTMzd2UIXAblHz41AkRgJaElPaGs2xPFpDT1J7feGTpD4jPEjj0NXi
	 HFEia7pBrOrcE9Y9BVsyxZcF95MurL9Q/ruZGvg44HALziFSq99c2Ra/CQixTL+J0xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636445;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ln7V8Sk/Qk0nXqP+d5oLjL7jmXXBJYXIJ2HBTTc+4dI=;
	b=Lj1vbBcY2c5z4ogPN8aDrgOqLzlmqOEqPrXiWPMJdms8Yi5P2qLzJ0VdntJgAeKDNuQn
	 8h0HVi/jfTZtvRvC3QmwPOwsZaJWpWAKrFNtr5xDlFwUnbL0UWvI/IrfCq4AdSMvhxgpv
	 0nyRNI8jQZLPBFaMX4zK21NmLjMulWTlPSb+te0gFFS+KwRrgtOiwQdBCd4tG27YTZ0i1
	 PJsa2GFDrjQVVX4ABebKkPykof7DaQrRMCvy0dvP1mxbLK2Rn2N0OrTnvt9zVM7nF3/sA
	 BBcHyEljMc6kGg5EYNsJI9xLrSbtdpLuaeGWuEKrM2A3KcTr1kRRbvk3IU6y7k1ulPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NaS3OvgY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969E606A908;
	Mon,  2 Nov 2026 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NaS3OvgY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BB21F0180D;
	Mon,  2 Nov 2026 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793636444;
	bh=Ln7V8Sk/Qk0nXqP+d5oLjL7jmXXBJYXIJ2HBTTc+4dI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NaS3OvgYtu5vhnGme7Fhm6/FvE/a2gI7/Sc8pRy83FVuj7eiFyxBByVK5h11PiIiC
	 Qym7FrGKxY4M3G3uWOzEInnEQ79yASeootpSxCADlTeOu7ICaWWpvU7gleDWtd0dMY
	 O6cg9SO7fPualGXCjyTNhB4TeoD4XdE/NwoPscgxHeiqV6xFA2oSsiIJtKXn5GC3d7
	 dPe970eM5gv8EHNQpkxZTrMo0Ri4pV8r9W8pSwJK0W83pK+iCkMX5KJEUrEHeYNmsv
	 rHCkkgJM3c8h5Z0pVfmvc0WNnyfgZcvJf9q039+Y+QwjVJ6+yRw8dQGhwHB3vpamvk
	 JQYIOwbfl3iMg==
Subject: Re: [PATCH net] net: usb: lan78xx: only stop phylink if the interface
 is running
From: netdev-bot+sashiko@kernel.org
To: 25031212351@stu.xidian.edu.cn
Cc: Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 o.rempel@pengutronix.de, stable@vger.kernel.org, byu@xidian.edu.cn,
 wencheng@xidian.edu.cn, kuba@kernel.org
Date: Mon, 02 Nov 2026 16:20:43 +0000
Message-ID: <179363644377.3131.15126043316754328997@kernel.org>
In-Reply-To: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
References: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The commit message says 'phylink_start() is only called from
  lan78xx_open()'.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the link does
  not come back after a normal resume.

--

net: usb: lan78xx: only stop phylink if the interface is running

This patch changes lan78xx_disconnect() so it calls phylink_stop() only
when the net device is running. The goal is to stop the phy_stop()
warning that fires when the PHY is in PHY_READY or PHY_HALTED at unplug
time.

> lan78xx_disconnect() unconditionally calls phylink_stop(), but
> phylink_start() is only called from lan78xx_open(). When the device is

[Severity: Low]

Is this statement accurate? In drivers/net/usb/lan78xx.c,
lan78xx_reset_resume() calls phylink_resume() without checking
EVENT_DEV_OPEN or netif_running():

lan78xx_reset_resume() {
    ...
	rtnl_lock();
	phylink_resume(dev->phylink);
	rtnl_unlock();
    ...
}

If the interface was down at suspend time, lan78xx_suspend() never calls
phylink_suspend(). PHYLINK_DISABLE_MAC_WOL is therefore clear, and
phylink_resume() calls phylink_start(). That runs phy_start()
(PHY_READY -> PHY_UP) while netif_running() is false.

Suppose the adapter is then unplugged or unbound. The new check in
lan78xx_disconnect() skips the phylink_stop() that used to balance this
start. phylink_disconnect_phy() and phylink_destroy() then run with
phylink still started.

This probably doesn't crash. phy_disconnect() still stops the PHY because
phy_is_started() is true, and phylink_destroy() cancels the resolve work.
It does leave phylink's start/stop unbalanced at teardown, since
mac_link_down() is not run.

Could the commit message be corrected?

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 181e8c087655c..6dc622a6ae783 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -4594,7 +4594,8 @@ static void lan78xx_disconnect(struct usb_interface *intf)
>  	net = dev->net;
>  
>  	rtnl_lock();
> -	phylink_stop(dev->phylink);
> +	if (netif_running(net))
> +		phylink_stop(dev->phylink);

[Severity: High]

Can netif_running() be used as a reliable sign that phylink has been
started here?

If the interface is up during system sleep, lan78xx_suspend() stops
phylink but does not clear __LINK_STATE_START:

lan78xx_suspend() {
    ...
		rtnl_lock();
		phylink_suspend(dev->phylink, false);
		rtnl_unlock();
    ...
}

lan78xx_phylink_mac_ops has no .mac_wol_set, so phylink_suspend() always
takes the phylink_stop() branch, and phy_stop() leaves the PHY in
PHY_HALTED. netif_device_detach() and netif_device_attach() only toggle
__LINK_STATE_PRESENT.

The only phylink_resume() call is in lan78xx_reset_resume(), and it runs
only after both lan78xx_reset() and lan78xx_resume() succeed. The plain
lan78xx_resume() never restarts phylink.

So lan78xx_disconnect() can still run with netif_running() true and the
PHY halted, for example:

  - the adapter is unplugged while the system sleeps. usb_resume_interface()
    skips the driver for NOTATTACHED or UNBINDING interfaces.
  - a normal (non-reset) lan78xx_resume(), then unplug or unbind.
  - lan78xx_reset() or lan78xx_resume() fails inside
    lan78xx_reset_resume(), then unplug or unbind.

pl->phydev is still attached at that point because
phylink_disconnect_phy() runs afterwards, so this happens:

lan78xx_disconnect()
  phylink_stop()
    phy_stop()
      WARN(1, "called from state %s\n", ...)    /* HALTED */

This is the same HALTED warning that the commit message says is fixed.

Would it be simpler to remove the phylink_stop() call from
lan78xx_disconnect()? phy_disconnect() already checks phy_is_started().
For a running interface, unregister_netdev()->lan78xx_stop() also calls
phylink_stop().

The other option is to track the real phylink started state and fix the
resume path.

>  	phylink_disconnect_phy(dev->phylink);
>  	rtnl_unlock();
>  

[Severity: High]

This problem was not introduced by this patch, but does the link ever
come back after a normal (non-reset) resume?

When the interface is open, lan78xx_suspend() calls
phylink_suspend(dev->phylink, false). For this driver that always means
phylink_stop(): PHYLINK_DISABLE_STOPPED is set and the PHY moves to
PHY_HALTED.

The only matching phylink_resume() is in lan78xx_reset_resume().
lan78xx_resume() resubmits the interrupt URB and the deferred TX URBs.
It restarts the TX path, NAPI and the stat timer, and rewrites the wake
registers. It never calls phylink_resume() or phylink_start().

A plain USB resume happens when the device keeps power, for example with
s2idle, or with remote wakeup enabled (lan78xx_probe() enables it via
device_set_wakeup_enable()). In that case the PHY stays halted and the
phylink resolver stays disabled.

Carrier doesn't return until the interface is cycled. The ifdown in that
cycle hits the same phy_stop() "called from state HALTED" warning through
lan78xx_stop()->phylink_stop().

This looks like it dates back to e110bc825897 ("net: usb: lan78xx:
Convert to PHYLINK for improved PHY and MAC management"). That commit
notes that PM runtime testing was limited. It is also why the
netif_running() check above is not enough by itself.

Should lan78xx_resume() pair the phylink_suspend() with a
phylink_resume()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029160204.2567-1-25031212351%40stu.xidian.edu.cn
