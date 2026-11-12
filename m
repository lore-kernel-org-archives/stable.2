Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522731;
	b=H8qdaGInhHH46Z57m78MTIRGER6hgRYjD3Ojm0WMmZTlK7p3zRJhAoiTaVhzUvX6fVrj
	 RfhgH6e5iL+uCJy9nedny9MDFBwTVrRiRYhlxzze6tEScGqJFzdOdYtOpI7kLOV8WmQ4o
	 Gq607KjBwvEHp97z0MT235xTQzLQzok71iCNrOQybExj6NvnXcMaPA5xahVPrrmri1l59
	 UlCbBucska9Q1FLJtj33XqC6isVX/SpmSiDNi35I0ixN/b9UthhHMnAxHZsyJUsJ8K4sd
	 BitpuKd5ynJbnZPDa6yuTWy51nshh15mepmM8JVfXR6K6zO3vb3bHcQyqQyslLP8VUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522731;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OX3gd22w+rlqDW01NdjSI/b/1yTOJXzOcVqRAE9xFAs=;
	b=TPB61fYxmbDsv1PlAtXFalcRytH8CXO6x5P6otN8jSnTKJdLTMFmZR8kPhtoJn3BoKp4
	 8tzpMukeMiHFoVlDPB1UmKwtJaQ1sLTf5Eik4kEiXJTvd+HYyGPlvBHyYTTGp1ynY26ly
	 PbeQb07yVb4B0EObIzT4jkLhERTB7zBaZPOcANIMyqdTbM6s2XsXWCqMhgzzkI7cD1lnK
	 oOEQWhiMkuGwr6kEfktVUoH6DA7g2534IOvZPbfjxF5G67w8ZXFds186MUvW60CqelKTE
	 ABDYJF4FuHfYbRxKbOjGpYqF+UmKisiqu8La8gYw2BxOMmXimVsOlJqZjd9bgTZ1m4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6vmzzYQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD51606A338;
	Thu, 12 Nov 2026 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6vmzzYQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0261D1F000CC;
	Thu, 12 Nov 2026 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522731;
	bh=OX3gd22w+rlqDW01NdjSI/b/1yTOJXzOcVqRAE9xFAs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m6vmzzYQbxZxkawCQFWOClVFKpZIGPRjM8NvycCdpGoXEmLZt25/U/wcMNRDuWYri
	 1E+zZR6ErAggzzyv+x4ngfSgoUs5phdn+s8u1G8j2ynEdRdo+dP1+aXZ90onXJJtUk
	 leEqtDIaNF1Ur7O0UPMapTuhaS1xg6OIDD63O7wZbnvxxum2QK2PM+EZ9S6inkLYzg
	 KV5cvXSmBSHQUxgD6howM8wph//Mxxfv7nkY9A3LMv9g19GFPBMH69Y8v4+U1hICVk
	 umzfpe8Qsh1bJjiWLBdDl+/FPxflsnGsJG4bjBUDqIbhOvTYD6ABl+auc+axpC4bhY
	 ism3xWQjHUrHg==
Subject: Re: [PATCH net v9 04/10] can: dev: check netif_running() before
 bus-off recovery
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol@kernel.org,
 heiko@sntech.de, socketcan@hartkopp.net, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 wg@grandegger.com, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 12 Nov 2026 22:32:09 +0000
Message-ID: <179452272955.488853.2430789088711910750@kernel.org>
In-Reply-To: <20261111-rockchip-canfd-restart-close-v9-4-6643f3825ba3@qq.com>
References: <20261111-rockchip-canfd-restart-close-v9-4-6643f3825ba3@qq.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In can_bus_off() (drivers/net/can/dev/dev.c:274-285), the new
  running check and the schedule_delayed_work() call are two separate…
- [High] The new netif_running() check in can_restart()
  (drivers/net/can/dev/dev.c:201) runs from the restart delayed work on…
- [Low] The new text in Documentation/networking/can.rst makes an
  unconditional promise about restart-ms.

--

can: dev: check netif_running() before bus-off recovery

This patch adds netif_running() checks to can_restart() and can_bus_off().
The goal is to stop automatic bus-off recovery from being scheduled or
started once the interface has begun closing. It also updates
Documentation/networking/can.rst to describe the new behaviour and to
recommend setting restart-ms while the interface is down.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e%40qq.com

> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index 51bc70748f753..9debef8702d5f 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -1302,7 +1302,8 @@ More info to the above output:
>  	Automatic restart delay time. If set to a non-zero value, a
>  	restart of the CAN controller will be triggered automatically
>  	in case of a bus-off condition after the specified delay time
> -	in milliseconds. By default it's off.
> +	in milliseconds. Recovery is skipped if the interface is found
> +	to be down. By default it's off.

[ ... ]

> +Before scheduling or starting recovery, the kernel checks whether the
> +interface is running and skips recovery if it is down.

[Severity: Low]
Does this hold for every driver? Only the core software recovery path
(can_bus_off() -> restart_work -> can_restart()) does the new check.

Several in-tree drivers read a non-zero restart_ms as "let the controller
recover from bus-off by itself". In that case they never call can_bus_off()
or can_restart(). For example, kvaser_pciefd_change_state():

	if (!can->can.restart_ms) {
		kvaser_pciefd_start_controller_flush(can);
		can_bus_off(ndev);
	}

and grcan_err():

	if (priv->can.restart_ms && oldstate == CAN_STATE_BUS_OFF) {
		unsigned long flags;

		cf.can_id |= CAN_ERR_RESTARTED;
		netdev_dbg(dev, "restarted\n");
		priv->can.can_stats.restarts++;
		netif_carrier_on(dev);

kvaser_usb_leaf and kvaser_usb_hydra follow the same pattern. None of these
check netif_running(). A hardware recovery between the clearing of
__LINK_STATE_START and ndo_stop() stopping the controller is therefore not
covered by the documented check.

Given the races in the core path described below, would it be more
accurate to say the check applies only to core-driven recovery and is
best effort?

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c7..a893a49a33813 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -198,6 +198,9 @@ static int can_restart(struct net_device *dev)
>  	if (!priv->do_set_mode)
>  		return -EOPNOTSUPP;
>  
> +	if (!netif_running(dev))
> +		return -ENETDOWN;
> +

[Severity: High]
Can a restart worker pass this check and still restart the controller
while ndo_stop() is running?

can_restart_work() runs on system_percpu_wq in preemptible process
context. It holds neither RTNL nor the netdev instance lock, so nothing
orders this test_bit() against __dev_close_many():

worker                              close path
can_restart_work()
  can_restart()
    netif_running() == true
    <preempted>
                                    __dev_close_many()
                                      clear_bit(__LINK_STATE_START, ...)
                                      ndo_stop()
    can_flush_echo_skb()
    netif_rx(CAN_ERR_RESTARTED skb)
    netif_carrier_on()
    priv->do_set_mode(dev, CAN_MODE_START)

The only thing that waits for the worker is cancel_delayed_work_sync() in
close_candev(). Many drivers call it at the end of ndo_stop, for example
flexcan_close():

	free_irq(dev->irq, dev);
	can_rx_offload_disable(&priv->offload);
	flexcan_chip_stop_disable_on_error(dev);

	can_rx_offload_del(&priv->offload);
	flexcan_transceiver_disable(priv);
	close_candev(dev);

In that case the worker's CAN_MODE_START can restart the chip after it
was stopped. The chip can then stay active on the bus after the interface
is down.

The worker's can_flush_echo_skb() can also run at the same time as the
driver's echo/TX teardown. That contradicts the "No synchronization needed
because the device is bus-off" comment in can_restart().

The commit message says these checks do not serialize with close. It
also says the problem being fixed is "potentially re-enabling hardware
while the driver is tearing it down", and that outcome still looks
reachable here.

Would the check and the restart need to be serialized against close? For
example, can_restart_work() could take rtnl_trylock() or the instance lock
and requeue on contention, or the core could enforce cancel ordering.

The rest of the series appears to fix only rockchip_canfd, through
close_candev_cancel_restart_sync(). The core and drivers such as FlexCAN
are left unchanged.

> @@ -259,13 +262,17 @@ int can_restart_now(struct net_device *dev)

[ ... ]

>  void can_bus_off(struct net_device *dev)
>  {
>  	struct can_priv *priv = netdev_priv(dev);
> +	bool restart;
>  
> -	if (priv->restart_ms)
> +	restart = priv->restart_ms && netif_running(dev);
> +	if (restart)
>  		netdev_info(dev, "bus-off, scheduling restart in %d ms\n",
>  			    priv->restart_ms);
>  	else
> @@ -273,7 +280,7 @@ void can_bus_off(struct net_device *dev)
>  
>  	netif_carrier_off(dev);
>  
> -	if (priv->restart_ms)
> +	if (restart)
>  		schedule_delayed_work(&priv->restart_work,
>  				      msecs_to_jiffies(priv->restart_ms));
>  }

[Severity: High]
Can restart_work still be queued after close_candev() has already
cancelled it?

The netif_running() test and schedule_delayed_work() are two separate
steps with no lock between them. The cancel in close_candev() is not tied
to either step:

IRQ thread                          close path
can_bus_off()
  restart == true
                                    __dev_close_many()
                                      clear_bit(__LINK_STATE_START, ...)
                                      ndo_stop()
                                        close_candev()
                                          cancel_delayed_work_sync()
                                          (nothing queued yet)
  schedule_delayed_work(&priv->restart_work, ...)

HI3110 hits this case. hi3110_stop() calls close_candev() before free_irq(),
so its IRQ thread can still be inside can_bus_off() when the cancel runs:

	close_candev(net);

	priv->force_quit = 1;
	free_irq(spi->irq, priv);

On removal, free_candev() only frees the netdev. It does not cancel
restart_work, which lives inside netdev_priv(dev):

void free_candev(struct net_device *dev)
{
	free_netdev(dev);
}

Would can_restart_work() then run on a freed can_priv? The new
netif_running(priv->dev) check would itself read freed memory.

On a fast reopen within restart_ms, open_candev() does not cancel the stale
work, and netif_running() is true again. The new check in can_restart()
can't tell stale pre-close work apart from work for the new open session.

can_flush_echo_skb() would then free priv->echo_skb[] entries while the
driver's xmit and TX completion paths may be using them. After that it
calls netif_carrier_on() and do_set_mode(CAN_MODE_START) on a healthy
controller.

The underlying lifetime problem predates this patch, and the new check
narrows the window. But the commit message says recovery "can therefore be
queued or started after the interface has begun closing". The queuing side
still seems reachable through this window.

include/linux/workqueue.h already provides disable_delayed_work_sync() and
enable_delayed_work(). If close_candev() used disable_delayed_work_sync()
and open_candev() used enable_delayed_work(), any late
schedule_delayed_work() would become a no-op for every driver. Would that
work better than relying on the unlocked running check?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3%40qq.com
