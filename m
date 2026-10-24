Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814335;
	b=PoJQ1JLl0nfMYh9lB5jWNVZ15/QnaJM5k3jiLdcun35n6M7QA73kV8x0pAytFJo6fNZH
	 EgNSbw66vtMQqMhyRBdKR6WrJhtUTTdvIegk5jhfXLJelyvMsfICFAuWwp8QLyv0Tmw8W
	 8I6tvsIpIv8cHAZfcqKiOQZhE7we9casY2G91bnofH1+oZ6f5cZacyKcsnIEStuiHcPTz
	 MQezPypCUM4zs3PEjs2JHRajOO+cqMmuH5SPqXwATeGebed4q+lNmFlOw5MNdGzQKOT95
	 ntUjsJo0gVAtf3ZE+q9rK4UisnG3D5459JZXJERhcULM6j6XHcQpDCKV03TPL7/0i9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814335;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xb0kY8mG929k7bWSkiX0xS9sat/I2UuhmeFbU3YCROU=;
	b=kIaoZGyj62KD1iElzkanN+8+nKYJgAI/zgqXtx02RpcmXGsVtTQXfbnqEk1qnH/LQXtb
	 rogOpFbgbA/JIgvy/j2EyLAgtBJ2PsLq53DqQbP5ZMUnZGRafRkQTTO5r7Kci2pL7tSVI
	 RPt1f3U4/oZi1gRL9DuVowqIbVZkWwIsWSS/tO28m6yHZ2vBbQ+WoKr+OjOGJKi92drCY
	 W5MzwJHd0TcqbqXHx4hpdWCZ0SHaI5Du4TgLk08/Uh7pbRdQJUanidLjH59j7PDSw1YKe
	 +HV96S4szgFyWyLkHvBw5hej1mdG+FWKiUC8f6cqANzHljZWX7BCCVp2GxhVi2QTy0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U38NS/YL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98964606A321;
	Sat, 24 Oct 2026 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U38NS/YL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B251F01825;
	Sat, 24 Oct 2026 03:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814335;
	bh=xb0kY8mG929k7bWSkiX0xS9sat/I2UuhmeFbU3YCROU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U38NS/YL1lzHaoCqIGEk476Xr4vWAkA+GpSHyb3kn+EfVG3d0/X0kLDoOyDuC5TEN
	 cl/OZu3rxLaGqWWiHY9GqeURBLUs304eTi3UOZ+Hpsp1PsERSgPO/obJPvrK3xeNw8
	 KCmHsHNqn17cC3RlV9cLqydCvUbPonMoiZAeNdWztcAoWFeYoLPeBc7d4TSbixxHGz
	 1mHaLAowO8K5aYeHc9ol0fkF13VYKN77806pZaP9T1cNc3oAYgcpBbV4s2FtMt+V7K
	 +RnUZL0G98JJZ/69uaTLJfkhYZFRATcgCw2DOXs/cYBb1tooPl0lMd9aPBuT0daB7i
	 R4vlPYxiXaqaA==
Subject: Re: [PATCH v6 09/13] can: peak_usb: register the netdevs only once
 all channels are set up
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, wg@grandegger.com,
 error27@gmail.com, lukas.magel@posteo.net, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 24 Oct 2026 03:58:54 +0000
Message-ID: <179281433446.3130.6290059781976829176@kernel.org>
In-Reply-To:
 <20261022-canfd_check_channel_idx-v6-9-197704231551@peak-system.fr>
References:
 <20261022-canfd_check_channel_idx-v6-9-197704231551@peak-system.fr>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch only half-converts probe-time logging.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the PCAN-USB
  private restart timer (struct pcan_usb::restart_timer, inside the…
- [Medium] This problem wasn't introduced by this patch, but the
  mechanism is real.

--

can: peak_usb: register the netdevs only once all channels are set up

This moves register_candev() out of peak_usb_create_dev() and into
peak_usb_probe(). The netdevs of an interface are now registered only
after dev_init(), dev_set_bus() and dev_get_can_channel_id() have run for
every channel. peak_usb_disconnect() only unregisters netdevs flagged with
the new PCAN_USB_STATE_REGISTERED bit.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 6a5ecb10c4f30..8a0a132983c44 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -390,9 +390,12 @@ static int pcan_usb_get_can_channel_id(struct peak_usb_device *dev, u32 *can_ch_
>  	int err;
>  
>  	err = pcan_usb_wait_rsp(dev, PCAN_USB_CMD_DEVID, PCAN_USB_GET, args);
> +	/* explicit use of dev_xxx() instead of netdev_xxx() here: this is
> +	 * also called during probe, before the netdev is registered.
> +	 */
>  	if (err)
> -		netdev_err(dev->netdev, "getting can channel id failure: %d\n", err);
> -
> +		dev_err(dev->netdev->dev.parent,
> +			"getting can channel id failure: %d\n", err);
>  	else
>  		*can_ch_id = args[0];

[Severity: Low]
Should the helpers on this same path be converted as well?
pcan_usb_wait_rsp() and pcan_usb_send_cmd() still log with
netdev_err(dev->netdev, ...):

pcan_usb_wait_rsp() {
    ...
	if (err)
		netdev_err(dev->netdev,
			"waiting rsp f=0x%x n=0x%x failure: %d\n", f, n, err);
    ...
}

dev_init(), dev_set_bus(dev, 0) and dev_get_can_channel_id() now all run
before register_candev(). At that point the netdev name is still the
"can%d" template and reg_state is NETREG_UNINITIALIZED. These messages
therefore print with an "(unnamed net_device) (uninitialized)" prefix. On
PCAN-USB, one failed channel id read now prints one such netdev_err()
followed by this dev_err().

The other adapters have the same problem in their command helpers, which
are reached from dev_init(), dev_set_bus() and dev_get_can_channel_id()
during probe:

- pcan_usb_pro_send_cmd(), pcan_usb_pro_wait_rsp() and
  pcan_usb_pro_send_req() in pcan_usb_pro.c
- pcan_usb_fd_send_cmd() in pcan_usb_fd.c

The new lbl_disconnect path in peak_usb_probe() has a similar issue.
peak_usb_disconnect() copies netdev->name and logs "%s removed" for
channels that were created but never registered, so it prints a literal
"can%d removed".

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index 49d2c01b8ef7e..ea6c28f3ed0b9 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

[ ... ]

> @@ -1081,7 +1063,8 @@ static void peak_usb_disconnect(struct usb_interface *intf)
>  		dev_prev_siblings = dev->prev_siblings;
>  		strscpy(name, netdev->name, IFNAMSIZ);
>  
> -		unregister_candev(netdev);
> +		if (test_bit(PCAN_USB_STATE_REGISTERED, &dev->state))
> +			unregister_candev(netdev);
>  
>  		kfree(dev->cmd_buf);
>  		dev->next_siblings = NULL;

[Severity: High]
This isn't a bug introduced by this patch, but can the PCAN-USB restart
timer fire after free_candev() in this loop?

struct pcan_usb::restart_timer sits in the netdev private area. It is set
up in pcan_usb_init(). It is armed by pcan_usb_restart_pending(), the
completion handler of the unanchored restart URB that
pcan_usb_restart_async() submits:

pcan_usb_restart_pending() {
	/* the PCAN-USB needs time to restart */
	mod_timer(&pdev->restart_timer,
			jiffies + msecs_to_jiffies(PCAN_USB_STARTUP_TIMEOUT));
	...
}

This handler ignores urb->status, so a URB flushed during unplug or unbind
still arms the timer.

Nothing cancels it:

- pcan_usb.c has no timer_delete_sync() or timer_shutdown_sync() on
  restart_timer.
- The PCAN-USB adapter has no dev_stop, dev_free or dev_exit callback.
- close_candev() only cancels priv->restart_work.

Suppose a restart has happened (restart-ms auto-restart after bus-off, or a
manual "ip link set canX type can restart"). This sequence can then free
the memory that holds the queued timer_list:

peak_usb_disconnect()
    unregister_candev()
        peak_usb_ndo_stop()
    free_candev()

When the timer expires, pcan_usb_restart()->peak_usb_restart_complete()
writes dev->can.state and calls netif_wake_queue() on the freed netdev.

[ ... ]

> @@ -1116,13 +1100,40 @@ static int peak_usb_probe(struct usb_interface *intf,
>  
>  	for (i = 0; i < peak_usb_adapter->ctrl_count; i++) {
>  		err = peak_usb_create_dev(peak_usb_adapter, intf, i);
> +		if (err)
> +			goto lbl_disconnect;
> +	}
> +

[ ... ]

> +	for (; dev; dev = dev->next_siblings) {
> +		err = register_candev(dev->netdev);
>  		if (err) {
> -			/* deregister already created devices */
> -			peak_usb_disconnect(intf);
> -			break;
> +			dev_err(&intf->dev, "couldn't register CAN device: %d\n",
> +				err);
> +			goto lbl_disconnect;
>  		}

[Severity: Medium]
This is a pre-existing issue, but take a multi-channel adapter (PCAN-USB
Pro, or a two-channel PCAN-USB FD). Channel 0 is registered and opened by
userspace, and then register_candev() fails for channel 1. What state is
the hardware left in?

The commit message says:

  Since no netdev can be opened during probe anymore, there is no RX to
  stop when probing a channel fails.

That doesn't quite hold inside this loop. Channel 0 can already be open,
through peak_usb_ndo_open()->dev_start()->dev_set_bus(dev, 1), before
channel 1's registration fails. RX is still stopped by peak_usb_stop_rx()
in peak_usb_disconnect(), so that part works.

However, peak_usb_disconnect() calls peak_usb_stop_rx() first, and that
clears PCAN_USB_STATE_CONNECTED on every sibling:

peak_usb_stop_rx() {
	rtnl_lock();
	for (d = dev; d; d = d->prev_siblings)
		clear_bit(PCAN_USB_STATE_CONNECTED, &d->state);
	rtnl_unlock();
	...
}

Next, unregister_candev(ch0)->peak_usb_ndo_stop() calls dev_stop() and
dev_set_bus(dev, 0). Once CONNECTED is clear, pcan_usb_fd_send_cmd() and
pcan_usb_pro_send_cmd() return 0 without sending anything:

	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
		return 0;

dev_exit() (pcan_usb_fd_exit() or pcan_usb_pro_exit()) is the only place
that sends bus off, LED off, calibration off and drv_loaded(0). It is only
called from peak_usb_do_device_exit(), at module unload.

Does this leave the still-attached adapter bus-on on the opened channel?
Calibration messages would stay enabled, and the firmware would still
believe a driver is loaded.

The same ordering existed before this patch. A failure on channel 1 also
unwound through peak_usb_disconnect() after channel 0 might already have
been opened.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-canfd_check_channel_idx-v6-0-197704231551%40peak-system.fr
