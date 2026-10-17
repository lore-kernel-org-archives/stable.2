Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383ED29D26C;
	Sat, 17 Oct 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198844; cv=none; b=rJnaeAIeEaXeCkyLJGf+EMfPekngTw/XdpuZ4y2DIZwGACvHkUzxMkZrXQIiXqL7DMP6fz8Rwuu8J8eeiOgfN6EfUBTx5Po/jZoqom0bIa7XzaxL+IaudVuK/lnkjaFwPByHPq9r+T7+gtuln219YSBTyvAHxpLbMFKZ8EwEN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198844; c=relaxed/simple;
	bh=y7b39JwQw4bNmnIc1MKR11PbOXxW6ZNtRh5nKysZ/v4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+6DEHiTRHEjuczxJshlEKCTmFcPSqYXxO8yo05bq++2QgGBjvRF6QtNWFXL5S0yc980HuXExUtOba2tdzpD0EdrR3s/t5CqeQn7chs+UZqS3LIU/jOM7MUb9bG7qcUguJiBKcKpqrX+RJmeB69JBUbzp1kTk0+IpH3YqH4KPks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNUH0f8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNUH0f8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264F01F000C4;
	Sat, 17 Oct 2026 01:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198842;
	bh=4j55LpyEzQqGZji30wH6uo27jlh2slcCgrKqqgdzSd0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fNUH0f8mUl0ONLtRGMszF3YX7K0flj8GBgM78D0CbsVswCBUmji4YYgFc2shnFNzd
	 t/pWiKSk32Tw9rpflI97pBaUnbE06URQT+tCPEsQG10DAtlMbfN02zgHER6wQT4U0K
	 +PmQVkS3FUiZ62nqFF78kDhtFiNYruMQxrxaPOQf8EFzIfqy3pwvG6kN5eIQrLfTqg
	 lWN5efeCAJgOjPkb0oZDlLOBdMhFIvchzeJJo7xIMkYWyfxqX13Ap/g2yJ5C8Ntqcg
	 EHXpA2apnDi3E/pYE7D7qwbM96LR8QZDPi80eTJ/OMpsvTP7jjJTPKXdnJIW3al2aw
	 1cC0cX6pvz3kw==
Subject: Re: [PATCH net v5 1/6] can: dev: prevent bus-off recovery when the
 interface is not running
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, heiko@sntech.de,
 davem@davemloft.net, wg@grandegger.com, socketcan@hartkopp.net,
 kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 17 Oct 2026 01:00:41 +0000
Message-ID: <179219884173.1406898.3472467604167875171@kernel.org>
In-Reply-To: <20261015-rockchip-canfd-restart-close-v5-1-ae77327037c9@qq.com>
References: <20261015-rockchip-canfd-restart-close-v5-1-ae77327037c9@qq.com>
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

- [Medium] In can_restart() (drivers/net/can/dev/dev.c), the new
  netif_running() check is lockless and is not serialized with…

Pre-existing issues:
- [High] can_bus_off() (drivers/net/can/dev/dev.c:270-282) reads
  netif_running() into `restart` and only later calls…

--

can: dev: prevent bus-off recovery when the interface is not running

This commit adds a netif_running() check to can_restart(), so a bus-off
restart is skipped when the interface is not running. It also changes
can_bus_off() to schedule restart_work only when restart_ms is set and
the interface is running.

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c7..92492c503446e 100644
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
Is this check enough to deliver what the subject line promises? It reads
the running bit once without any lock. can_restart_work() runs on the
system workqueue without RTNL or any CAN-private lock, so nothing orders
it against __dev_close_many() and ndo_stop().

The commit message describes the problem as:

  "Recovery can therefore be queued or started after the interface has
  begun closing, potentially re-enabling hardware while the driver is
  tearing it down."

That still seems possible if the work passes this check just before
__dev_close_many() clears __LINK_STATE_START:

restart_work                          ip link set canX down
can_restart()
  netif_running() == true
                                      __dev_close_many()
                                        clear_bit(__LINK_STATE_START)
                                        ndo_stop() -> sja1000_close()
                                          set_reset_mode(dev);
                                          free_irq(dev->irq, dev);
  can_flush_echo_skb()
  netif_rx(skb)
  netif_carrier_on()
  priv->do_set_mode(dev, CAN_MODE_START)
                                          close_candev()
                                            cancel_delayed_work_sync()

cancel_delayed_work_sync() in close_candev() waits for the work to
finish, but it does not undo the restart. The controller ends up in
operating mode with interrupts enabled and no IRQ handler registered.
The carrier is also on while the interface is down.

With a shared IRQ line, could this cause an unhandled interrupt storm
and get the line disabled for other devices? On runtime-PM drivers, can
do_set_mode() touch registers after the clocks have been cut?

Many drivers (sja1000, cc770, at91, c_can, flexcan, sun4i, ti_hecc and
others) reset the chip and free the IRQ before they call close_candev().
Later in the series, close_candev_cancel_restart_sync() is added and
called early in ndo_stop(), but only for rockchip_canfd ("can:
rockchip_canfd: cancel bus-off restart before closing the device").

Should the other drivers get the same change? Or could the core
serialize this so the window is closed for every driver?

> @@ -264,8 +267,9 @@ int can_restart_now(struct net_device *dev)
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
> @@ -273,7 +277,7 @@ void can_bus_off(struct net_device *dev)
>  
>  	netif_carrier_off(dev);
>  
> -	if (priv->restart_ms)
> +	if (restart)
>  		schedule_delayed_work(&priv->restart_work,
>  				      msecs_to_jiffies(priv->restart_ms));
>  }

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The
patch makes the window smaller, but can restart_work still be queued
after close_candev() has cancelled it?

restart is read before netdev_info() and netif_carrier_off() run.
Nothing ties that read to the later schedule_delayed_work(), or to the
single cancel_delayed_work_sync() in close_candev().

Some drivers call close_candev() before they stop their bus-off
producer. mcp251x_stop() is one example:

drivers/net/can/spi/mcp251x.c:mcp251x_stop() {
	...
	close_candev(net);

	priv->force_quit = 1;
	free_irq(spi->irq, priv);
	...
}

Meanwhile the threaded IST, mcp251x_can_ist(), calls can_bus_off().
hi3110_stop(), mscan_close(), peak_usb_ndo_stop() and f81604_close()
use the same order.

One possible sequence:

mcp251x_can_ist()                     unregister / ifdown
  can_bus_off()
    restart = true
    <preempted>
                                      __dev_close_many()
                                        clear_bit(__LINK_STATE_START)
                                        mcp251x_stop()
                                          close_candev()
                                            cancel_delayed_work_sync()
                                          free_irq()  /* waits for IST */
    netif_carrier_off()
    schedule_delayed_work(&priv->restart_work, ...)

After that, nothing cancels the work. free_candev() is only:

void free_candev(struct net_device *dev)
{
	free_netdev(dev);
}

unregister_candev() does not touch restart_work either. On driver unbind
or USB unplug, the device can be freed before restart_ms expires. Would
the pending delayed_work timer and work item then sit inside freed
netdev_priv memory?

The device might instead be reopened before the work runs. __dev_open()
sets __LINK_STATE_START before ndo_open(), and open_candev() does not
cancel the work. Would the stale work then pass the new netif_running()
check in can_restart() and call do_set_mode(CAN_MODE_START) while the
driver's own open sequence is running?

The series does not add a cancel in free_candev() or unregister_candev().
Would cancelling or disabling restart_work there close this window?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9%40qq.com
