Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E730B529;
	Wed, 14 Oct 2026 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948438; cv=none; b=arRGPy/n3gFsuzUtCQEMKdbol4GG6cxRKQrJrbIExgh1V5cGAc+EDfS6pDGjaPFr0NubZmXjgzJ+tPylLu9DWv6l9xWc+yE6j+6AkIp68JmBK/VHUocl9vulHy9VnfVwvRTVuKj23sUv5E6EopamAvKHJCm+xakXjsluZot60sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948438; c=relaxed/simple;
	bh=honDxEnTpw1TuFR6oCbOz6rywAJ8xqZDwRHZKxeBMHM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gp6s4SvPm0uDa/GmjlIOqVEKvBnJa+qP2wO83YbAIw75VIY7bsuzQoxwM1QJ35aCYCIIfJ/zl9oAdQctIMKPatPQm8AY5q9pXc4flEUezjkmpFMC9PEgOZXedenvH6fJvXnD0+93xxSn0TbxwdiIhN92xKQuVUA5POxg2t5UQyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5uDa+kI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5uDa+kI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2861F1F000FF;
	Wed, 14 Oct 2026 03:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791948436;
	bh=0rMWwBwzIsxgTang0VaqK2qQLpHGh3EmiA/vzN5c6ZA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W5uDa+kIII3GfcJWkHe1W4BJUC7aLnd5wGY+BdewiNgOa/dXOYv3jxB3xv0q+kuuB
	 S93s/SJBlnJ+OmCwgW97NGSfzh4m36qp2W7nXumQcR9UQvV1/SDgVCv+Tit75X0VVw
	 TUE1kl3MMAeyjUHsbPgOeheG0NyyuLpHmil0uXTS7Y5VR6f+1+2aiLpckHSE3TBuhU
	 rfD+q1sYwKxxuqY0INPdZkIOBKutybj+hs8t7TJZwFdqgtFZI9V98DJutb4pvvxTy4
	 dkXkdkWg7lFkepzrrSifRJqsSXcyrmnwF9YTLq1H5u9R+waQ12Fexk6SyFCotoTAuA
	 8ni/GCIl0FcSA==
Subject: Re: [PATCH net] can: rockchip_canfd: stop bus-off restart before
 closing the device
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, kernel@pengutronix.de, heiko@sntech.de,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Wed, 14 Oct 2026 03:27:15 +0000
Message-ID: <179194843570.434549.16906326776857003512@kernel.org>
In-Reply-To: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
References: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
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

Critical: 0 · High: 0 (2) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch now has rkcanfd_set_mode() return -ENETDOWN when it
  sees priv->closing.
- [Medium] rkcanfd_stop() publishes priv->closing = true (line 776)
  before it masks the controller interrupts with…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it sits in the
  restart path the patch hardens and it can corrupt kernel…
- [High] This problem wasn't introduced by this patch, but rkcanfd_open()
  calls can_rx_offload_enable() (napi_enable) at line 750, before the…

--

can: rockchip_canfd: stop bus-off restart before closing the device

This patch adds a mutex and a closing flag so that the bus-off restart
callback, rkcanfd_set_mode(), cannot run concurrently with rkcanfd_stop().
In the close path, interrupts are now masked and the IRQ synchronized
before restart_work is cancelled. During restart, the IRQ is disabled
while the hardware is reinitialized.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
> index 37c1c22c40c9f..e38ddd143a3ad 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c

[ ... ]

> @@ -353,19 +355,27 @@ static int rkcanfd_set_mode(struct net_device *ndev,
>  			    enum can_mode mode)
>  {
>  	struct rkcanfd_priv *priv = netdev_priv(ndev);
> +	int err = 0;

[ ... ]

> +	if (mode != CAN_MODE_START)
>  		return -EOPNOTSUPP;
> +
> +	mutex_lock(&priv->state_lock);
> +	if (READ_ONCE(priv->closing)) {
> +		err = -ENETDOWN;
> +		goto out_unlock;
>  	}

[Severity: Medium]
Suppose restart_work runs after rkcanfd_stop() has set closing and dropped
state_lock, but before it reaches cancel_delayed_work_sync(). How does the
CAN core handle the -ENETDOWN returned here?

In can_restart() in drivers/net/can/dev/dev.c, several steps have already
run by the time do_set_mode() is called:

	/* send restart message upstream */
	skb = alloc_can_err_skb(dev, &cf);
	if (skb) {
		cf->can_id |= CAN_ERR_RESTARTED;
		netif_rx(skb);
	}

	/* Now restart the device */
	netif_carrier_on(dev);
	err = priv->do_set_mode(dev, CAN_MODE_START);
	if (err) {
		netdev_err(dev, "Restart failed, error %pe\n", ERR_PTR(err));
		netif_carrier_off(dev);

So in this window userspace receives a CAN_ERR_RESTARTED frame for a
restart that never happens. The carrier also goes on and then off again,
and a normal ifdown logs "Restart failed, error -ENETDOWN" at error level.

The commit message says the ordering is deliberate so that "a queued
restart can observe the closing state", which suggests this window is
expected to be hit.

Can the restart be aborted without these side effects? Alternatively,
can restart_work be cancelled before a restart can reach can_restart()?

>  
> -	return 0;
> +	disable_irq(ndev->irq);
> +	rkcanfd_chip_start(priv);

[Severity: High]
This isn't a bug introduced by this patch, but this patch hardens the
restart path, so is it safe to reinitialize the timestamp delayed_work
here?

On bus-off, rkcanfd_handle_state_error_int() runs in hardirq context and
calls rkcanfd_chip_stop()->rkcanfd_timestamp_stop(). That function only
does a non-sync cancel:

void rkcanfd_timestamp_stop(struct rkcanfd_priv *priv)
{
	cancel_delayed_work(&priv->timestamp);
}

Meanwhile, rkcanfd_timestamp_work() always re-arms itself:

	timecounter_read(&priv->tc);

	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);

If the worker is running when the bus-off interrupt arrives, the cancel
does nothing and the worker re-arms the timer. When restart_ms expires,
the restart path runs:

can_restart_work()->can_restart()->rkcanfd_set_mode()->rkcanfd_chip_start()
    ->rkcanfd_timestamp_init()
        INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
    ->rkcanfd_timestamp_start()
        schedule_delayed_work(&priv->timestamp, ...);

Can this corrupt the timer wheel? do_init_timer() clears
timer->entry.pprev while the timer is still enqueued. The following
schedule_delayed_work() then enqueues the same timer_list a second time.

If the old callback is still running instead, INIT_WORK clears its pool
association. The later cancel_delayed_work_sync() in rkcanfd_stop() then
cannot wait for it. Could that callback then call timecounter_read() on
the registers and re-queue itself after pm_runtime_put()? The commit
message says this patch prevents exactly that.

The new state_lock and the disable_irq()/enable_irq() pair keep close and
the IRQ handler out, but they don't cover the timestamp worker. Also,
timecounter_init() in rkcanfd_timestamp_start() races with the lockless
timecounter_read() in the worker.

Would it work to call INIT_DELAYED_WORK() once at probe time, and to call
cancel_delayed_work_sync(&priv->timestamp) in the process-context restart
path before the timecounter is reinitialized?

> +	rkcanfd_chip_interrupts_enable(priv);
> +	enable_irq(ndev->irq);
> +	netif_wake_queue(ndev);

[ ... ]

> @@ -736,6 +749,7 @@ static int rkcanfd_open(struct net_device *ndev)
>  	rkcanfd_chip_start(priv);
>  	can_rx_offload_enable(&priv->offload);
>  
> +	WRITE_ONCE(priv->closing, false);
>  	err = request_irq(ndev->irq, rkcanfd_irq, IRQF_SHARED, ndev->name, priv);
>  	if (err)
>  		goto out_rkcanfd_chip_stop;

[Severity: High]
This is a pre-existing issue, but this hunk touches the request_irq()
path in rkcanfd_open(). What happens to NAPI if request_irq() fails?

can_rx_offload_enable() has already called napi_enable() by this point,
and the error unwind never disables it:

out_rkcanfd_chip_stop:
	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
	pm_runtime_put(ndev->dev.parent);
out_close_candev:
	close_candev(ndev);
	return err;

On the next ifup, can_rx_offload_enable()->napi_enable()->
napi_enable_locked() would find NAPI already enabled and hit:

	BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));

Should can_rx_offload_disable(&priv->offload) be added to this error path?

[ ... ]

> @@ -758,9 +772,14 @@ static int rkcanfd_stop(struct net_device *ndev)
>  {
>  	struct rkcanfd_priv *priv = netdev_priv(ndev);
>  
> +	mutex_lock(&priv->state_lock);
> +	WRITE_ONCE(priv->closing, true);
> +	rkcanfd_chip_interrupts_disable(priv);

[Severity: Medium]
Is this ordering safe on a level-triggered line? priv->closing is set
before the controller's interrupt mask is written. The new early return
in rkcanfd_irq() neither acks nor masks the source:

	if (READ_ONCE(priv->closing))
		return IRQ_NONE;

The RK3568 CAN-FD interrupts are IRQ_TYPE_LEVEL_HIGH in rk3568.dtsi.
Suppose the controller raises RX_FINISH or an error interrupt between the
WRITE_ONCE() and rkcanfd_chip_interrupts_disable(). The line then stays
asserted, and the handler rejects it every time it is redelivered.

If that IRQ is routed to the CPU running rkcanfd_stop(), could that CPU
livelock in hardirq and never reach the INT_MASK write? If it goes to
another CPU, the storm would last until the spurious IRQ detector reports
"nobody cared" and disables the line. That would also hit any other users
of this IRQF_SHARED line.

The mutex section is preemptible, so on PREEMPT and PREEMPT_RT kernels the
stop task can be preempted between these two statements, which widens the
window. On PREEMPT_RT, the forced-threaded handler returning IRQ_NONE
combined with the oneshot unmask could loop the same way and starve the
stop task.

Would masking the hardware first help here, i.e. write INT_MASK, read it
back, and only then set closing? Acking or masking inside the closing
branch of rkcanfd_irq() might also work.

> +	mutex_unlock(&priv->state_lock);
> +	synchronize_irq(ndev->irq);
> +	cancel_delayed_work_sync(&priv->can.restart_work);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_5802EE88434010229EDF7A53084D994C6106%40qq.com
