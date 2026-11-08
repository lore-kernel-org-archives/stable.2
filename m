Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121169;
	b=YHmQbAHK6n0h2o9V0C4fiKgPvgbddscoKpJEWk9d64URhcRIL9vV6bitJUZfyq0zTxXi
	 5dxVjUb+OzP3rcgRGQoXDlE2c6yIMWFXoxZQtVf8ZqGKSWI+DYjv3nynCgSUJMCoSPo1H
	 jZPZwwDgTp77w6rAry8gCL4S2yJbbPQDb/xoKG9b6aeTJYrKE4osMImgugwThJ64PIi3m
	 H/yuTBT5DIeS/SMlUtw+dCbTtz1JFln1BoeL/aZcmE5zEFs7yg4mN4egm+EEuNVJ604Ke
	 7hhD1swXRhtdU9tgF2uA0+oMHuXM7ZZRpPRD+BsJ2yIW27NKHJSWwkOf5/5/mtoAtXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121169;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TupQffIQ2RIrTTxvmihRQ2AE3+BnRRzJKFVznFFWYHE=;
	b=1WOsciAAQEL75crC1vXwtD2xrYViTHGSBDRrwWkfKbq8BcWzXL4lS/uenX1f9KEGxyTw
	 rvGG59eC1NtOjDDf6XESXbTvnn7S/YCIEuN6mcya+VzNqdwmj95Ui5TcC/BovMFwll8Tj
	 P0Jz3maLcUAgX7E7xFmihmJSq1+MV3bOG3onsAVtN9TB5XOzlodL9fcLZ5m9GnjIW2izM
	 92hep8vw6Hi0Blhlxt/A30VdlYr3j8Xg1KljJqdW+Ot/JL0wQ6nA4C/2jH/r9+y3oyztJ
	 oN9MYCBMnidChokn+z1H/pCYY4pmSyamWZVocsRsNyYILXo9woQMAqV9LnDN0b5l/9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZkPxRwR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCF606A331;
	Sun,  8 Nov 2026 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZkPxRwR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EA51F008A1;
	Sun,  8 Nov 2026 06:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794121169;
	bh=TupQffIQ2RIrTTxvmihRQ2AE3+BnRRzJKFVznFFWYHE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mZkPxRwRsVE64BANolon3xxYqB4PqdbqnPKH0+KNwG67kh+jF60AfGefQuCORxwR0
	 yCbKpfXSM+uP2jMBbfV9j4PWeA5BAjBKj3F3FKJbUjcnHT7zxrzxFHdJYSPT4m5QlF
	 nwvSJbnMLYxdLO28sYs9LA7DisJ6hZfJTbk+N62oya3HO9DybNBzdaEpsVHr6iqITF
	 6erwb6zImmwUK8xDBeJss29fjaOTm27atOj7jLBBCZR1EUic20/YUeTDthttFoGjvU
	 dF6w9N1gRhI3Iu+T9xeKcfBR7wxOCgaCZK0SBpeCVWH5M2Pj+nWdjDvBLglGC8311u
	 AsGL9ueo0ie6Q==
Subject:
 Re: [PATCH net 2/3] net: enc28j60: disable work before freeing the netdev
From: netdev-bot+sashiko@kernel.org
To: 0xbeac@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 08 Nov 2026 06:59:28 +0000
Message-ID: <179412116809.994134.6737039110469421460@kernel.org>
In-Reply-To: <20261104063245.23402-3-0xbeac@gmail.com>
References: <20261104063245.23402-3-0xbeac@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The skb in flight is leaked when the device is removed, and
  the new teardown makes this worse.
- [Medium] net: enc28j60: tx_work and setrx_work run after
  enc28j60_lowpower() sleep
- [Low] The commit message justifies disable_work_sync() over
  cancel_work_sync() because it "rejects a later queue_work(), which a…

--

net: enc28j60: disable work before freeing the netdev

This commit adds disable_work_sync() calls for tx_work, setrx_work and
restart_work in enc28j60_remove(). They run after unregister_netdev() and
before free_irq() and free_netdev(). The goal is to stop the work
handlers from touching freed private data when they are pending or
running at remove time.

> Unregister the interface first so the xmit and set_rx_mode paths can no
> longer queue work, then disable the three works synchronously before
> freeing the IRQ and the netdev.  disable_work_sync() drains a queued or
> running instance and rejects a later queue_work(), which a plain
> cancel_work_sync() would not.
>
> Fixes: 3ec9c11da033 ("add driver for enc28j60 ethernet chip")
> Cc: stable@vger.kernel.org # 6.10+

[Severity: Low]
Is the "rejects a later queue_work()" justification accurate for this
driver? The only schedule_work() callers are ndo callbacks:

    enc28j60_send_packet()        -> tx_work      (ndo_start_xmit)
    enc28j60_tx_timeout()         -> restart_work (ndo_tx_timeout)
    enc28j60_set_multicast_list() -> setrx_work   (ndo_set_rx_mode)

None of these can run once unregister_netdev() has gone through
dev_close() and dev_deactivate(). The threaded IRQ handler queues no
work, and none of the three work handlers queues another work.
enc28j60_restart_work_handler() also checks netif_running() under rtnl.

The new comment in enc28j60_remove() says the same thing: after
unregister_netdev() the xmit and set_rx_mode paths "can no longer queue
new work". So it looks like cancel_work_sync() would be just as correct
here.

Because the patch uses disable_work_sync(), it carries "# 6.10+", while
the Fixes: tag points at the original driver. The 5.10, 5.15, 6.1 and
6.6 stable trees have the same use-after-free on remove.

Could the commit message be corrected? Would using cancel_work_sync()
let the fix be backported to those older trees too?

> diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
> index d6c9491537e47..bb29a94a1e2c1 100644
> --- a/drivers/net/ethernet/microchip/enc28j60.c
> +++ b/drivers/net/ethernet/microchip/enc28j60.c
> @@ -1600,7 +1600,16 @@ static void enc28j60_remove(struct spi_device *spi)
>  {
>  	struct enc28j60_net *priv = spi_get_drvdata(spi);
>  
> +	/*
> +	 * Stop the interface first so the xmit and set_rx_mode paths can no
> +	 * longer queue new work.  Then drain the works that were already
> +	 * queued; the IRQ handler does not queue work, so the IRQ can be
> +	 * released after the drain and before free_netdev().
> +	 */
>  	unregister_netdev(priv->netdev);
> +	disable_work_sync(&priv->tx_work);

[Severity: Medium]
Does draining tx_work and setrx_work only after unregister_netdev()
still leave a window where they touch the chip after it has been put
to sleep?

When the interface is up, unregister_netdev() goes through dev_close()
and calls enc28j60_net_close() before any of the new
disable_work_sync() calls run:

    enc28j60_hw_disable(priv);
    enc28j60_lowpower(priv, true);
    netif_stop_queue(dev);

enc28j60_lowpower() clears ECON1_RXEN and waits for ESTAT_RXBUSY and
ECON1_TXRTS to clear. Then it sets ECON2_PWRSV. Nothing in
enc28j60_net_close() cancels or waits for tx_work or setrx_work. An
instance queued by enc28j60_send_packet() or
enc28j60_set_multicast_list() just before the interface went down can
still run after enc28j60_lowpower() has returned.

In that case enc28j60_tx_work_handler() calls enc28j60_hw_tx(). That
writes the frame into the TX buffer and sets ECON1_TXRTS on a chip that
is in power-save mode with EIE cleared. This is the state that
enc28j60_lowpower() polled to avoid. enc28j60_setrx_work_handler()
likewise writes ERXFCON after the chip went to sleep. No TX interrupt
follows, so priv->tx_skb is also left behind, as in the leak noted
above.

The disable_work_sync() calls in enc28j60_remove() come too late for
this. They cannot undo a handler that already ran between ndo_stop and
the disable. The same window exists on a plain ifdown, and on the
close/open cycle in enc28j60_restart_work_handler().

Would it be better to cancel tx_work and setrx_work in
enc28j60_net_close() before enc28j60_hw_disable(), and free any pending
priv->tx_skb there? Those two handlers appear to take only priv->lock,
so cancel_work_sync() under rtnl looks safe for them. That is not true
of restart_work, which takes rtnl_lock itself.

[Severity: Medium]
Can this leak the skb held in priv->tx_skb?

After enc28j60_send_packet() hands the skb to tx_work and returns
NETDEV_TX_OK, the driver owns it:

    priv->tx_skb = skb;
    schedule_work(&priv->tx_work);

    return NETDEV_TX_OK;

The skb is freed in only one place, enc28j60_tx_clear(). That function is
reached only from the TXIF/TXERIF handling in enc28j60_irq():

    dev_kfree_skb(priv->tx_skb);
    priv->tx_skb = NULL;

By the time disable_work_sync() runs, this call chain has already masked
all chip interrupts:

  unregister_netdev()->dev_close()->enc28j60_net_close()->enc28j60_hw_disable()

    nolock_regb_write(priv, EIE, 0x00);

If tx_work is still pending, disable_work_sync() cancels it without
running it. If tx_work runs during or after close, the frame is written
to the chip with interrupts masked, so no TX-complete interrupt follows.

Either way, free_netdev() frees priv while priv->tx_skb is still set.
Nothing frees the skb, and its socket wmem charge is never released.

The new comment says this code will "drain the works that were already
queued". But disable_work_sync() cancels a pending instance and only
waits for one that is already running.

The skb could be freed after the disable_work_sync() calls and after
free_irq(), since the IRQ thread can still free it and clear the
pointer. For example, just before free_netdev():

    dev_kfree_skb(priv->tx_skb);
    priv->tx_skb = NULL;

Would that work?

> +	disable_work_sync(&priv->setrx_work);
> +	disable_work_sync(&priv->restart_work);
>  	free_irq(spi->irq, priv);
>  	free_netdev(priv->netdev);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104063245.23402-1-0xbeac%40gmail.com
