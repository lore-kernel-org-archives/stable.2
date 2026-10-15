Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE9379C22;
	Thu, 15 Oct 2026 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082287; cv=none; b=fEhA5pfyhikyPfNmbEteeeWOHFKeD0Ej9Yrg5kUQ8/QPLVdLRenQLz+3ij9tHjX+Q4Aglq41NWrqh96PQ+QZP1KzuygOvzhaG/S+wM4FSrg974EoaUH2coxrZmx4DYyGM8LP1tt7zryiJc+s9mZ1NG9AeLa5LWS139neYuCT1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082287; c=relaxed/simple;
	bh=n1uCdm3xlNN/fHbWdmlEXcDFHevyUx13hYn8Ant3lcQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DpG/xNb6f4OCzqeusHXxd3ORkcOYJWqdL6AIP63pCxZZM18/d37VlaxcUQPYNcA9xZqyOprlcA8/Oo7tw+fxt/D3htj+fbZ5JNU+tlVGOS9pSn5ePExkyAJiWR7734660KrYtfoce9+cHZLZhwnqwJvL43hoDaRThpW+a80P+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQSQ4lYd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQSQ4lYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4019C1F000C6;
	Thu, 15 Oct 2026 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792082274;
	bh=dyB/6NmFZRGdrRTP5KsJ3jOecvhsS5ZTpQOfRco2vuc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XQSQ4lYdZyh71183NKR1fUb/KSjbuLiil4dINwYsiQOs3lIRiHgMXCptxbpKkmhDz
	 a/X3K2lWp+bDJoGHX6feWzthtGNOn0UZr5PYiSbz0XEV7zXsEvOSAGSMrSGQnAjiZ0
	 NqxKCpMsQArqjosMi5CwsqglRY77PCl/6W5JHHLpnAUgKDObX5hNVxrrGbRB76Y/LU
	 tI/khRPWUlc5yTzg+aTzNO+NrAhaM0VJuIdPTrzcr4umpYenn9ji5jQadmSZPeLajf
	 6EMgL2rbtc/5zrpyCLAfs3MZ5HAbxdgYTmwk4sW0Q+4w2Wd4/61SV6bB4gJ0yFsWE0
	 Ol29ynRUCrpuQ==
Subject: Re: [PATCH net v2 3/3] can: rockchip_canfd: cancel bus-off restart
 before closing the device
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, heiko@sntech.de,
 davem@davemloft.net, wg@grandegger.com, socketcan@hartkopp.net,
 kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org, kuba@kernel.org
Date: Thu, 15 Oct 2026 16:37:53 +0000
Message-ID: <179208227384.1406898.15110321342582191229@kernel.org>
In-Reply-To: <tencent_B15E13184DA04C4382F48848C006A2B51F06@qq.com>
References: <tencent_B15E13184DA04C4382F48848C006A2B51F06@qq.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] can: rockchip_canfd: disable_irq() called on shared IRQ

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the restart
  callback the patch modifies re-initializes a delayed_work that may…

--

can: rockchip_canfd: cancel bus-off restart before closing the device

This commit calls close_candev_cancel_restart_sync() at the start of
rkcanfd_stop(), so a running bus-off restart finishes while the IRQ and
other resources are still available. It also brackets the hardware
reinitialization in rkcanfd_set_mode() with disable_irq()/enable_irq().
That keeps the IRQ handler out while the controller is restarted.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
> index 37c1c22c40c9f..fb8f6b0675022 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -356,8 +356,10 @@ static int rkcanfd_set_mode(struct net_device *ndev,
>  
>  	switch (mode) {
>  	case CAN_MODE_START:
> +		disable_irq(ndev->irq);
>  		rkcanfd_chip_start(priv);

[Severity: Medium]
rkcanfd_open() requests ndev->irq with IRQF_SHARED, and the commit
message itself relies on the line being shared. disable_irq() masks
the whole line at the irqchip, not only this controller's source.
It also waits in synchronize_irq() for the handlers of every other
device on that line.

Every device sharing the line therefore loses interrupt delivery for
as long as rkcanfd_chip_start() and rkcanfd_chip_interrupts_enable()
run. That window covers:

- the reset and work mode transitions
- FIFO setup
- bittiming programming
- timestamp init and start

The window can be opened from outside the box. Another node on the
CAN bus can drive this controller into bus-off. With restart-ms
configured, restart_work then runs rkcanfd_set_mode(), and a manual
can_restart_now() takes the same path. Each restart stalls the
unrelated devices sharing the IRQ.

Drivers on a shared IRQ are generally expected not to use
disable_irq() for their own exclusion, for exactly this reason.

Would it be possible to exclude rkcanfd_irq() with a real lock
instead? For example, the handler could take a spinlock, and
spin_lock_irqsave() could be held around the chip_start and
interrupts_enable sequence here.

That only works if everything reached from rkcanfd_chip_start() is
safe in atomic context. Can you confirm that? Or is there a reason
the restart path has to be able to sleep while the handler is held
off?

I would rather not see a software flag checked in the handler for
this. Without a lock it does not actually exclude a handler that
has already passed the check.

[Severity: High]
This issue was not introduced by this patch. It sits in the restart path
the patch modifies, though. Can rkcanfd_chip_start() here re-initialize
priv->timestamp while its timer is still queued?

On bus-off, the IRQ path stops the timestamp work without waiting for it:

rkcanfd_irq()
  rkcanfd_handle_state_error_int()
    rkcanfd_chip_stop(priv, CAN_STATE_BUS_OFF)
      rkcanfd_timestamp_stop()
        cancel_delayed_work(&priv->timestamp);

The work callback always re-arms itself:

drivers/net/can/rockchip/rockchip_canfd-timestamp.c:rkcanfd_timestamp_work() {
    ...
	timecounter_read(&priv->tc);

	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
}

Bus-off may be handled while rkcanfd_timestamp_work() is running, either on
another CPU or because the IRQ preempted it on the same CPU. In that case
cancel_delayed_work() finds nothing pending, and the callback then re-queues
itself. From then on the work keeps re-arming.

When the restart runs (restart_work or can_restart_now()), it goes through:

rkcanfd_set_mode()
  rkcanfd_chip_start()
    rkcanfd_timestamp_init()
      INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
    rkcanfd_timestamp_start()
      timecounter_init(&priv->tc, ...);
      schedule_delayed_work(&priv->timestamp, ...);

INIT_DELAYED_WORK() clears the PENDING bit and the timer's linkage while the
timer_list is still in a timer-wheel bucket. The following
schedule_delayed_work() then sees the work as idle and enqueues the same
timer_list a second time. Can that corrupt the timer wheel hlist?
timecounter_init() also writes priv->tc while the old work may still be
using it.

The new disable_irq()/enable_irq() pair keeps the IRQ handler out. It does
not stop the timestamp work. One option is to cancel priv->timestamp
synchronously in this sleepable restart path before re-initializing it.
Another is to call INIT_DELAYED_WORK() once at probe or open time rather
than on every rkcanfd_chip_start().

>  		rkcanfd_chip_interrupts_enable(priv);
> +		enable_irq(ndev->irq);
>  		netif_wake_queue(ndev);
>  		break;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_196A2433801631CD2FA42998465E26316105%40qq.com
