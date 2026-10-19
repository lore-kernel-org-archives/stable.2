Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49737E5D2;
	Mon, 19 Oct 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378643; cv=none; b=Twayt3eNRgYvYy//qgArnl0kQGqXagN/XzpBu1rlWTS+3iIXMtk7MAbmD4b8m22PFFey92+ZPFq/9L/w3vCTJYWCIZqM33WvDJkPbgOtmgR2jb+2Xfulyrt4cryp/bU3hX/F7+5HD8rULShiVSqha1AeKg00c0FX97h64KdcN3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378643; c=relaxed/simple;
	bh=X8ihD6Eyge+fZTh6cL9EEbhE0krAzDGBObPa4JCeJ+Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3z6qn3UGXT5GDAPXO3zzUdb6Hms8W94IRZ7A99nNLetE1I13boFdJ0wbHTE6vr8uqxYnx18fbsvflU6wGGwT7/UFTz9KQCtHgqAfm5qtK9etwev1JuczvQbBqa6hH7uHli+DQfX6rubXPoq19enSJA7048YOaGf+abNjRQW2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUj8Ycfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUj8Ycfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2611F1F000C5;
	Mon, 19 Oct 2026 02:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792378642;
	bh=mTGE5PbqpCX7JgrNOh1LLgryClihqC8acCoXQ+w/znw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KUj8YcfmOETOrGgsb59oAUieoDR/+1QWVtj6m75B6a+xEfja/ztIa3yiOAhPmt7bg
	 n2W1FlAl3ATlV6hKKJRGNC8xjN2zzPyPu5QSW3TwE706QRl7Ooew78UwUa/Oe/U2if
	 D83995rfYqJiYOpMIq4UsNocxFo/XFqD1FXrS+0y/sOAqVd+UuGSHkVvMsSAgeeo0S
	 mxZgv5/qqJ2/y2Ajp+NdArYIQkiq+dBf59aOzsyhc/NC98TjsCp31gKlJgGuLRwjq6
	 7P/VjjADvTSrHylt1bMtJYV79XM8bwzy4RjwDiMSBnM82iLt380kdJQe5bassGbwgN
	 jhYxeH+HYi++Q==
Subject: Re: [PATCH net v6 3/6] can: rockchip_canfd: cancel bus-off restart
 before closing the device
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, heiko@sntech.de,
 davem@davemloft.net, wg@grandegger.com, socketcan@hartkopp.net,
 kernel@pengutronix.de, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 19 Oct 2026 02:57:20 +0000
Message-ID: <179237864073.3135.8117104622491949177@kernel.org>
In-Reply-To: <20261017-rockchip-canfd-restart-close-v6-3-ed605feb4b6e@qq.com>
References: <20261017-rockchip-canfd-restart-close-v6-3-ed605feb4b6e@qq.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds a boolean gate, priv->irq_suspended.

Pre-existing issues:
- [Medium] At this commit, rkcanfd_start_xmit() is not serialized with
  the bus-off stop or with restart reinitialisation.
- [Medium] At this commit, rkcanfd_timestamp_work() calls
  timecounter_read(&priv->tc), which updates frac, cycle_last and nsec,…
- [Low] At this commit, rkcanfd_timestamp_stop() (rockchip_canfd-
  timestamp.c:101-104) only calls cancel_delayed_work(), while…

--

can: rockchip_canfd: cancel bus-off restart before closing the device

This patch cancels the bus-off restart at the start of ndo_stop(). During
CAN_MODE_START it masks the device interrupts, sets an irq_suspended flag
and synchronizes the IRQ, and it drains the timestamp work before the
controller is reinitialized. It also moves INIT_DELAYED_WORK() to probe and
disables RX offload when request_irq() fails in open.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
> index 37c1c22c40c9f..4b3db07242395 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c

[ ... ]

> @@ -356,7 +357,18 @@ static int rkcanfd_set_mode(struct net_device *ndev,
>  
>  	switch (mode) {
>  	case CAN_MODE_START:
> +		rkcanfd_chip_interrupts_disable(priv);
> +		/* Flush the interrupt mask write before suspending the handler. */
> +		rkcanfd_read(priv, RKCANFD_REG_INT_MASK);
> +		/* Keep shared IRQs from accessing the device during restart. */
> +		WRITE_ONCE(priv->irq_suspended, true);
> +		/* Wait for handlers that already passed the suspended check. */
> +		synchronize_irq(ndev->irq);
> +		rkcanfd_timestamp_stop_sync(priv);
> +
>  		rkcanfd_chip_start(priv);

[Severity: Medium]
This isn't a bug introduced by this patch, but is rkcanfd_start_xmit()
serialized against this reinitialization at all?

The restart path quiesces the IRQ handler and the timestamp work, but not
the TX path. The bus-off path only turns the carrier off, and can_restart()
calls netif_carrier_on() before do_set_mode(). So xmit can run while
rkcanfd_chip_start() resets the controller and rkcanfd_chip_fifo_setup()
does:

	WRITE_ONCE(priv->tx_head, 0);
	WRITE_ONCE(priv->tx_tail, 0);
	netdev_reset_queue(priv->ndev);

A concurrent rkcanfd_start_xmit() could write the TX frame registers and
RKCANFD_REG_CMD into a controller that is being reset. It could also leave
an echo_skb slot occupied after the indices have been zeroed.

On RKCANFD_QUIRK_RK3568_ERRATUM_12 parts, rkcanfd_start_xmit_write_cmd()
also writes the full mode register:

	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_12)
		rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default);

Could that take the controller out of reset while it is bus-off, or before
the bit timing has been programmed?

A later patch in the series, "can: rockchip_canfd: serialize TX with bus-off
and restart", appears to fix this. It adds tx_lock and tx_enabled, calls
rkcanfd_tx_disable() in the bus-off path and at the start of
CAN_MODE_START, and makes xmit return NETDEV_TX_BUSY while TX is disabled.

> +		/* Publish the initialized state before resuming IRQ handling. */
> +		smp_store_release(&priv->irq_suspended, false);
> +		rkcanfd_chip_interrupts_enable(priv);
> +		netif_wake_queue(ndev);
>  		break;
> @@ -666,6 +678,10 @@ static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
>  	struct rkcanfd_priv *priv = dev_id;
>  	u32 reg_int_unmasked, reg_int;
>  
> +	/* Pairs with the release after restart has initialized the device. */
> +	if (smp_load_acquire(&priv->irq_suspended))
> +		return IRQ_NONE;
> +

[Severity: Medium]
irq_suspended is set at the start of the CAN_MODE_START region in
rkcanfd_set_mode() and cleared before the final unmask and queue wake.
While it is set, rkcanfd_irq() returns IRQ_NONE. Is this flag enough to
keep the handler out of the rest of the restart?

Once smp_store_release() clears the flag, nothing stops a shared IRQ on
another CPU from running the whole handler before the restart has finished.
restart_work is preemptible, so the window could be wide:

CPU0 (restart_work)
rkcanfd_set_mode(CAN_MODE_START)
    rkcanfd_chip_start(priv);
    smp_store_release(&priv->irq_suspended, false);
    <preempted>

CPU1 (shared IRQ)
rkcanfd_irq()
    smp_load_acquire(&priv->irq_suspended) returns false
    reads RKCANFD_REG_INT, sees a new bus-off
    rkcanfd_handle_state_error_int()
        rkcanfd_chip_stop(priv, CAN_STATE_BUS_OFF);
        can_bus_off(ndev);

CPU0 resumes
    rkcanfd_chip_interrupts_enable(priv);
    netif_wake_queue(ndev);

Would this leave INT_MASK unmasked and the TX queue awake on a controller
that is in reset with the CAN state at CAN_STATE_BUS_OFF? That would undo
the newer bus-off.

The later patch "can: rockchip_canfd: serialize TX with bus-off and
restart" seems to close this window. It clears the flag, unmasks and wakes
the queue under tx_lock in rkcanfd_chip_start_finish(), and the bus-off
path takes tx_lock through rkcanfd_tx_disable(). The flag-as-gate scheme is
still present at the end of the series, though, including in
rkcanfd_open().

Lockdep cannot see a flag like this. Would a real lock shared with the
handler be a better fit here?

[ ... ]

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
> index 72774cd2f94b7..ad582afbbd682 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
> @@ -37,6 +37,11 @@ static void rkcanfd_timestamp_work(struct work_struct *work)
>  	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
>  }

[Severity: Low]
This isn't a bug introduced by this patch, but rkcanfd_timestamp_work()
always requeues itself, and rkcanfd_timestamp_stop() only does:

	cancel_delayed_work(&priv->timestamp);

Suppose the bus-off interrupt runs rkcanfd_chip_stop()->
rkcanfd_timestamp_stop() while the worker is executing. Can the worker
rearm itself and keep polling RKCANFD_REG_TIMESTAMP on a controller in
reset? That would continue until the restart path or ndo_stop cancels it
synchronously.

This appears to be fixed later in the series by "can: rockchip_canfd:
prevent timestamp work from rearming after bus-off". That patch adds
timestamp_lock and a timestamp_active flag, which the worker checks before
reading or requeueing.

[Severity: Medium]
This is also a pre-existing issue. In rkcanfd_timestamp_work(),
timecounter_read(&priv->tc) updates cycle_last, nsec and frac in process
context without any lock.

rkcanfd_skb_set_timestamp() reads the same state from the IRQ handler for
RX, TX-done and error frames, also without a lock:

	ns = timecounter_cyc2time(&priv->tc, timestamp);

Can the handler see a new cycle_last together with an old nsec, and produce
a hardware timestamp that is off by a whole work period? On 32-bit the u64
fields could also tear.

The later patch "can: rockchip_canfd: serialize timecounter timestamp
conversion" appears to fix this by holding timestamp_lock across
timecounter_cyc2time().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e%40qq.com
