Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC20360EC6;
	Mon, 19 Oct 2026 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378642; cv=none; b=bqTGy0QcGErvgi9teohl4JXF0vGMOukieKQMfsLuBmxzOlb6EMXqLhgkvCwDAGu8XAzLGpbrLgbclBcykgRhuN+Cp8xKpo8112VfFAWTUw7csl2C8SSrQG28pLf6dyYip8PN483FesdDmXktpmHBeoEZkwFPsO+A37QbZSUiRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378642; c=relaxed/simple;
	bh=MROBembhKh2MtsGxWOWhn2y86sktX7Rgv9BN5HTh3g0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iJqKfmoGaD3PUMcTfHut6UfQA8P7XpQRuqHxHAo/qVvDantkgY2iE4YWvd7EjAOyVUFiMuYbhcVRPKwDjIPGpfbo4IWBPH9eglPIM/tj/MTmu2avE1Fhsee7ihsvdhcaWMPx3D2Vuj5StnN7sq42hydIo+hIdN+wpfOjHAugw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1E4tGPh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1E4tGPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633EE1F000C4;
	Mon, 19 Oct 2026 02:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792378640;
	bh=hqGSmcH9+ql+tEzrz3OUYyCpkz7GsJAUKHd9AYB6ZuE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U1E4tGPhA3a75LS+t0HIP1THYdihWm2Qztg4A6+NkkiArrZ+mmMwdD3i15saFKXxk
	 aMPzC/lu35nY4M1rePgi8YaCCKxj6VKytt2aLhGHKqj7hNauNunFbVrZZvfv7B0i4Q
	 ULNq3sHrD3s3K6MD80dA7WnH83y/VIohMGrV73He3O3PN7wVufgHsyVJd42QHZoz/G
	 JESmb15SmA4darfDuW9EWRIFKYxeXc4Pi++YrEzbj2TMxQPaUPZ+40g/9G8UPkHHgN
	 7jei6u8hFYYP0W25FzlBR+1tznmH3bdicTd3vBK9zy7AWI9B9NIHB9neYOFhK+5WSv
	 m12WjGjIhag2w==
Subject: Re: [PATCH net v6 1/6] can: dev: prevent bus-off recovery when the
 interface is not running
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
Date: Mon, 19 Oct 2026 02:57:18 +0000
Message-ID: <179237863891.3135.16148468658160918424@kernel.org>
In-Reply-To: <20261017-rockchip-canfd-restart-close-v6-1-ed605feb4b6e@qq.com>
References: <20261017-rockchip-canfd-restart-close-v6-1-ed605feb4b6e@qq.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch is titled 'prevent bus-off recovery when the
  interface is not running', but the netif_running() checks it adds are…
- [Low] The patch rewords the bus-off recovery paragraph in
  Documentation/networking/can.rst so that the 'e.g.::' now follows the…
- [Low] The new user-facing text in Documentation/networking/can.rst
  states that recovery happens only while the interface is running, with…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch only
  narrows it.

--

can: dev: prevent bus-off recovery when the interface is not running

This patch adds a netif_running() check to can_restart() before the echo
skbs are flushed and the driver restart callback is called. It also changes
can_bus_off() so the restart work is only scheduled when restart_ms is set
and the interface is running. Documentation/networking/can.rst is updated to
describe the running-interface requirement.

> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index 536ff411da1d1..861397e4ce906 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -1298,7 +1298,8 @@ More info to the above output:
>  	Automatic restart delay time. If set to a non-zero value, a
>  	restart of the CAN controller will be triggered automatically
>  	in case of a bus-off condition after the specified delay time
> -	in milliseconds. By default it's off.
> +	in milliseconds, provided the interface is running. By default
> +	it's off.

[Severity: Low]
Is this guarantee accurate as written? The bus-off paragraph below makes the
same claim with no qualification ("Recovery is only scheduled and started
while the interface is running").

Each new check is a single lockless netif_running() snapshot. Once the check
in can_restart() passes, the function still goes on to do:

	can_flush_echo_skb(dev);
	...
	netif_carrier_on(dev);
	err = priv->do_set_mode(dev, CAN_MODE_START);

Nothing orders this against __dev_close_many() clearing __LINK_STATE_START
and calling ndo_stop(). In the same way, can_bus_off() saves netif_running()
into restart and only queues the work later.

The only wait point is cancel_delayed_work_sync() in close_candev(). That
runs inside ndo_stop, after the interface has already stopped running.

The commit message says as much ("These checks do not wait for recovery
that has already passed the check, nor serialize the check with work
submission"), but the user documentation doesn't. Would softer wording, for
example that recovery is not scheduled and is skipped once the interface is
down, describe the behaviour more accurately?

> @@ -1372,7 +1373,8 @@ before you can start it to avoid error-prone default settings::
>  A device may enter the "bus-off" state if too many errors occurred on
>  the CAN bus. Then no more messages are received or sent. An automatic
>  bus-off recovery can be enabled by setting the "restart-ms" to a
> -non-zero value, e.g.::
> +non-zero value. Recovery is only scheduled and started while the
> +interface is running, e.g.::
>  
>      $ ip link set canX type can restart-ms 100

[Severity: Low]
Is the "e.g.::" now attached to the wrong sentence? Before this patch, the
example showed how to enable recovery by setting restart-ms. Now it follows
the "while the interface is running" sentence, so it reads as a command to
run on a running interface.

can_changelink() rejects that case:

drivers/net/can/dev/netlink.c:can_changelink() {
    ...
		/* Do not allow changing restart delay while running */
		if (dev->flags & IFF_UP)
			return -EBUSY;
    ...
}

Could the "e.g.::" stay on the enabling sentence, with the running-interface
note moved after the example? It might also be worth saying that restart-ms
must be set while the interface is down.

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c7..d5cb22db2a346 100644
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
Does this check actually close the window the subject line describes?
can_restart_work() runs on system_percpu_wq without RTNL. That means the
check can pass just before __dev_close_many() clears __LINK_STATE_START:

CPU0 (restart work)              CPU1 (RTNL held)
can_restart_work()
  can_restart()
    netif_running() == true
                                 __dev_close_many()
                                   clear_bit(__LINK_STATE_START)
                                   dev_deactivate_many()
                                   flexcan_close()
                                     free_irq()
                                     flexcan_chip_stop_disable_on_error()
                                     can_rx_offload_del()
                                     flexcan_transceiver_disable()
    netif_carrier_on()
    flexcan_set_mode(CAN_MODE_START)
      flexcan_chip_start()
      flexcan_chip_interrupts_enable()
      netif_wake_queue()
                                     close_candev()
                                       cancel_delayed_work_sync()

flexcan_close() calls close_candev() only after all of the hardware
teardown. So cancel_delayed_work_sync() just waits for the restart to
finish.

Could the controller then stay restarted and active on the bus after
ifdown, with its IRQ freed and the transceiver disabled?

can_bus_off() has a similar gap. restart comes from a snapshot, and
schedule_delayed_work() runs later. hi3110_stop() calls close_candev()
before free_irq(), so in drivers like hi3110 the work can be queued after
the only cancel. If the interface is reopened within restart_ms, that stale
work would run can_restart() on a live controller.

The commit message scopes this case out. A later patch in the series adds
close_candev_cancel_restart_sync(), but only rockchip_canfd uses it. At the
end of the series flexcan, hi3110 and the other in-tree drivers still have
this race.

Is real serialization needed here to stop recovery once the interface starts
closing? For example, the restart work could be cancelled at the start of
ndo_stop (in each driver, or through a core hook), or the work could use an
rtnl_trylock() and requeue on failure.

> @@ -259,13 +262,15 @@ int can_restart_now(struct net_device *dev)

[ ... ]

>  void can_bus_off(struct net_device *dev)
>  {
>  	struct can_priv *priv = netdev_priv(dev);
> +	const bool restart = priv->restart_ms && netif_running(dev);
>  
> -	if (priv->restart_ms)
> +	if (restart)
>  		netdev_info(dev, "bus-off, scheduling restart in %d ms\n",
>  			    priv->restart_ms);
>  	else
> @@ -273,7 +278,7 @@ void can_bus_off(struct net_device *dev)
>  
>  	netif_carrier_off(dev);
>  
> -	if (priv->restart_ms)
> +	if (restart)
>  		schedule_delayed_work(&priv->restart_work,
>  				      msecs_to_jiffies(priv->restart_ms));
>  }

[Severity: High]
This is a pre-existing issue, but this patch only narrows it and doesn't
close it. Can restart_work still be queued after close_candev() and then
outlive the net_device?

Here is the teardown path with hi3110:

hi3110_can_remove()
  unregister_candev()
    __dev_close_many()
      hi3110_stop()
        close_candev()
          cancel_delayed_work_sync()   <- nothing pending yet
        priv->force_quit = 1;
        free_irq()

Meanwhile the threaded IST can be on its way into can_bus_off(). It calls
can_bus_off() whatever the value of restart_ms:

hi3110_can_ist()
    ...
			if (new_state == CAN_STATE_BUS_OFF) {
				if (skb)
					netif_rx(skb);
				can_bus_off(net);

Suppose the IST computed restart as true before __LINK_STATE_START was
cleared, and was then delayed until after close_candev(). In that case
schedule_delayed_work() queues the work after the only cancel.
hi3110_can_remove() then calls free_candev(), which is just:

void free_candev(struct net_device *dev)
{
	free_netdev(dev);
}

When restart_ms expires, the delayed_work timer and can_restart_work() would
run on freed memory. That covers the container_of() to priv, the priv->dev
load, the new netif_running() read of dev->state, and the indirect call
through priv->do_set_mode. The new check in can_restart() can't help here,
because it reads the freed net_device itself.

Before this patch, any can_bus_off() after close_candev() queued the work,
so the window is now much smaller. The commit message leaves the remaining
case to drivers, and no later patch in the series changes hi3110 or the core
free path.

Would closing this need either serialization of the check and the queuing
against close_candev(), or a cancel/disable of restart_work in the
unregister or free path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e%40qq.com
