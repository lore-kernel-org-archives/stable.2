Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121170;
	b=YIHSFUOqi5DOVAwp9NkaV3Lwe1EQfIFhtpmZ9hzpD6FmnhIJie97aS22Sbq7q4f7j0xs
	 xLyLeXmezW1Ukws3jV50cXHKivQbtS6uK7nGHFqqKgJ0aEtc8lqjkAVHITCP8VgZ61ytp
	 blr+BnJbNDTRNsnVy8x9RqelJXM6Pz7uUSTsOhi7eEvj8DDYc4PuNj07mBo0gNVfE+RHn
	 cShltiKj7fjaXHKTw1QTHfzAEnM07hYEUbE80mCJ3lIsgaOSpvmrda3vA6zblhFgcz4S5
	 iuaI8UbOHZZaV8PsjhOwMHjfR1MgLei5CE2AIqAgxwOJcjo6AIkfSGem/nEIaZVrXSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121170;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XOzF4wHAqjx7GKBzWRVfKJ5JeQgw7NrDI7qQvZi9SXg=;
	b=2pJKR/1jVhkqOnm9VZKIihLQ0QjGBam2H1z+k3VqhqomTagg441wstCHkMVMT1lyi6RN
	 Gr811qqw094mHC+5S0E+F9C+Yn6mGj1CzmwygGm9kcUSPWLSrZuiODEoL4BR5FC1EBoru
	 f89rMUAQZ+QRZDFgOrkh3kdrjE/cZD+xGm2ZfoFaggnryNRqVWQJkFVxN8ix6TQqHT266
	 EEjG8UQSxPRG6zM9etKZAEDlAEsCbq3dFJnGLCA5N8PKvd+kKH8DfRZ+HjzPapkoEys2V
	 POIik6Oi1j3CfzavdRBskiBTivKmA5Ag0hyw9V744MiCF1IzpZRN4OXNv6swIiD27eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqbHpPJ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40F606A33D;
	Sun,  8 Nov 2026 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqbHpPJ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998431F0089F;
	Sun,  8 Nov 2026 06:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794121170;
	bh=XOzF4wHAqjx7GKBzWRVfKJ5JeQgw7NrDI7qQvZi9SXg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jqbHpPJ8XQrj14DsdGG1XTV3oWvr842DVUpmHzsSKSlCOA2hoTT1BREDWpEuDiiR6
	 YuTXemeFPQBffYAAxPJDNLTb2OW96B8ZcU3tRDWkI8cKWd9I71aY8jn2BZUx4lRmS1
	 jAZoYTlcOoS0RNuktBpNBpMPLDzDqg9150l2bc5PSQ3ED728G0N19sfOt6Cl9X12hh
	 1PqkwkshlmKZ0452sXdgvvI20dVCEGDqYSa19SrsNnTX4EVptDpWOkj/WTq4hDy5QL
	 liTx5YZ7zjUT7Ktytt+ZsRQOfRZ0wtzA5dF9rUXUR3hC20/eHoNxvJujYY7J4d3tay
	 xf835mtdnDp5Q==
Subject: Re: [PATCH net 3/3] net: xgmac: disable timeout work before teardown
From: netdev-bot+sashiko@kernel.org
To: 0xbeac@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 08 Nov 2026 06:59:29 +0000
Message-ID: <179412116920.994134.12974909597820462141@kernel.org>
In-Reply-To: <20261104063245.23402-4-0xbeac@gmail.com>
References: <20261104063245.23402-4-0xbeac@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] xgmac_resume() can deadlock against the timeout work.
- [Medium] The workqueue disable count can get stuck above zero and stay
  that way, so TX-hang recovery is lost for good.
- [Medium] In xgmac_suspend(), netif_device_detach() (line 1887) runs
  before disable_work_sync() (line 1893).
- [Low] The new comments describe the enable/disable pairing wrongly.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it sits on the
  same stop/failed-open path.

--

net: xgmac: disable timeout work before teardown

This patch disables tx_timeout_work at probe and re-enables it in
xgmac_open() and xgmac_resume(). It also synchronously disables the work
in xgmac_stop(), xgmac_suspend() and xgmac_remove(). The goal is to keep
the TX timeout work from running against freed DMA rings, released IRQs
or unmapped registers.

> diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
> index a2410fba6be2e..9b7aee56f2610 100644
> --- a/drivers/net/ethernet/calxeda/xgmac.c
> +++ b/drivers/net/ethernet/calxeda/xgmac.c
> @@ -1023,6 +1023,9 @@ static int xgmac_open(struct net_device *dev)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* xgmac_stop() disables this work before freeing the rings. */
> +	enable_work(&priv->tx_timeout_work);
> +

[Severity: Medium]
Can the disable count on tx_timeout_work get stuck above zero here?

disable_work() and enable_work() nest, so every xgmac_stop() needs a
matching xgmac_open() that succeeds. xgmac_change_mtu() does:

	xgmac_stop(dev);
	WRITE_ONCE(dev->mtu, new_mtu);
	return xgmac_open(dev);

If xgmac_dma_desc_rings_init() fails with -ENOMEM, xgmac_open() returns
before enable_work() and the count stays at 1. A failed ndo_change_mtu
does not close the device, so it stays running.

A later ifdown calls xgmac_stop() again, and disable_work_sync() raises
the count to 2. The next ifup succeeds, but its enable_work() only brings
the count back to 1.

>From then on, schedule_work() from xgmac_tx_timeout() and from the
DMA_STATUS_TPS path in xgmac_interrupt() does nothing until the driver
is rebound. Without this patch, a down/up cycle fully recovered the
device.

Would enabling the work on the open failure path, or tracking whether it
is currently enabled, avoid this?

[Severity: High]
This isn't a bug introduced by this patch, but it is on the same
xgmac_change_mtu() stop/failed-open path. The error labels in
xgmac_dma_desc_rings_init() free the buffers without clearing the
pointers:

err_dma_tx:
	kfree(priv->tx_skbuff);
err_tx_skb:
	dma_free_coherent(priv->device,
			  DMA_RX_RING_SZ * sizeof(struct xgmac_dma_desc),
			  priv->dma_rx, priv->dma_rx_phy);
err_dma_rx:
	kfree(priv->rx_skbuff);
	return -ENOMEM;

When xgmac_change_mtu()->xgmac_open() fails here, the interface stays
running while priv->rx_skbuff, priv->dma_rx and priv->tx_skbuff can
point at freed memory.

The next ndo_stop then goes through
xgmac_stop()->xgmac_free_dma_desc_rings(). There,
xgmac_free_rx_skbufs() walks the freed rx_skbuff[] array, and
dma_free_coherent() on priv->dma_rx and kfree() on
priv->rx_skbuff/priv->tx_skbuff can run a second time.

Could these error labels set the pointers to NULL after freeing them?

>  	/* Enable the MAC Rx/Tx */
>  	xgmac_mac_enable(ioaddr);
>  
> @@ -1046,6 +1049,13 @@ static int xgmac_stop(struct net_device *dev)
>  {
>  	struct xgmac_priv *priv = netdev_priv(dev);
>  
> +	/*
> +	 * The timeout work programs the DMA rings that are freed below, and
> +	 * it toggles NAPI.  Disable it synchronously before touching either;
> +	 * xgmac_open() and xgmac_resume() enable it again.
> +	 */

[Severity: Low]
This isn't a bug, but the comment here and the one added in
xgmac_probe() describe a pairing that doesn't match the code. This
comment says "xgmac_open() and xgmac_resume() enable it again". The
probe comment says the probe-time disable_work() is the matching disable
for "the enable_work() in xgmac_open()/xgmac_resume()".

xgmac_resume() returns early when !netif_running(ndev), and the device
is not running after dev_close()->ndo_stop. So the enable in resume can
never balance a disable done in xgmac_stop() or probe. It is balanced by
the disable_work_sync() in xgmac_suspend().

Could the comments describe the actual pairs, probe/stop with open and
suspend with resume?

> +	disable_work_sync(&priv->tx_timeout_work);
> +

[ ... ]

> @@ -1862,6 +1885,12 @@ static int xgmac_suspend(struct device *dev)
>  		return 0;
>  
>  	netif_device_detach(ndev);
> +	/*
> +	 * The timeout work touches the DMA registers and toggles NAPI.
> +	 * Disable it before NAPI and the interrupts are torn down;
> +	 * xgmac_resume() enables it again.
> +	 */
> +	disable_work_sync(&priv->tx_timeout_work);

[Severity: Medium]
Should disable_work_sync() come before netif_device_detach() here?

If xgmac_tx_timeout_work() is already running when xgmac_suspend() is
called, disable_work_sync() waits for it to finish. The work ends with:

	netif_tx_unlock(priv->dev);
	netif_wake_queue(priv->dev);

That undoes the netif_tx_stop_all_queues() done by netif_device_detach().
Nothing later in xgmac_suspend() stops the queue again. xgmac_stop(), by
contrast, calls netif_tx_disable().

The qdisc path (sch_direct_xmit()->dev_hard_start_xmit()) doesn't check
netif_device_present(). Can xgmac_xmit() then write descriptors and
XGMAC_DMA_TX_POLL while NAPI, interrupts and the MAC/DMA are being shut
down for suspend?

>  	napi_disable(&priv->napi);
>  	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
>  
> @@ -1891,6 +1920,7 @@ static int xgmac_resume(struct device *dev)
>  
>  	/* Enable the MAC and DMA */
>  	xgmac_mac_enable(ioaddr);
> +	enable_work(&priv->tx_timeout_work);
>  	writel(DMA_INTR_DEFAULT_MASK, ioaddr + XGMAC_DMA_STATUS);
>  	writel(DMA_INTR_DEFAULT_MASK, ioaddr + XGMAC_DMA_INTR_ENA);
>  

[Severity: High]
Can system resume deadlock against the timeout work here?

At this point NAPI is still disabled from xgmac_suspend(). The work is
already enabled, and DMA_INTR_DEFAULT_MASK (which includes TSE) is
unmasked before napi_enable() runs. A "transmit process stopped"
interrupt in this window takes this path in xgmac_interrupt():

	if (intr_status & DMA_STATUS_TPS) {
		...
		schedule_work(&priv->tx_timeout_work);
	}

The work then starts with napi_disable() on a NAPI that is already
disabled:

worker
xgmac_tx_timeout_work()
  napi_disable()
    netdev_lock(n->dev)
    napi_disable_locked()
      loops in usleep_range() while NAPIF_STATE_SCHED is set

resume
xgmac_resume()
  napi_enable()
    netdev_lock(n->dev)    <- blocks on the worker

Only napi_enable_locked() clears SCHED, and it needs the netdev_lock the
worker holds. Neither side can make progress.

This window existed before the patch. However, the suspend hunk is meant
to keep the work from toggling NAPI while it is down, and the
enable_work() placement here leaves it open. xgmac_open() also enables
the work before napi_enable(), but there the DMA interrupts stay masked
until after napi_enable().

Would moving enable_work() and the interrupt unmask after napi_enable()
in xgmac_resume() avoid this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104063245.23402-1-0xbeac%40gmail.com
