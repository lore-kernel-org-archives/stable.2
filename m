Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040551;
	b=fSxVKF5IpLYkvxfUyGKsCM5cVbCMVnf7uRUH7tkxCMVifZGJHPbTHgrZrJ8i2a7LDZ3E
	 fCPPRYR/+jWV1R10cz3005d46ZlOXq8gSTPmobY5bmb0amH8eZqe+mv5rHYJyMEIhO/Sp
	 urGORKva2gJCgES1gEfMb6xxl0iTwhb/Oy4Rtq6Zz4rC3UOIdd8cefmb81tDNVcFg7n0U
	 GL86ywpH1TvV6CM026tT+1XJhOjEEHTBsVtV/9vbE/y2zDIXUM76TKXFEghC61sYqoH4O
	 wl2ubZcTqTOUse9eHQZ8QSIcPzuKkqys8ZquA9utffbR1JdUG2vToAsx2j6mjhXYscw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040551;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=deC16colvJ6YmP1UCuRm/b/DXcA7zKSPNYZR/ylPBC8=;
	b=qkkJaJcW9KqFf3lMXzRZDAKBojYW1mb247bc8/5eGrlQ5xDAL3JADFtvD7vB25dgG/RK
	 HHq/Is66qHEiqrupd7RnEase63KPI+QSUpoXqrlUJF3BpNR01d2dGdwQagQTwrI3vYQnP
	 gn2Sevq8w3SkkELVILvH73d9J66qnhRyQqYgShGKVSDeDhWgHxFsFuEkTlYMAYDCgTbhc
	 vOq1oVOAZtnotRanmGnwUEzoLrD/G4YVchU8DToUt7mnKSo49Gm70BgHnZqBn0kKq865R
	 mgX6k0OPpeYMhetzos/l63nt9q8jPM/F4dPLC6oj7au/WDmAm9PAxOWQv0PvCb+Nn2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dY/uIibw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106AA606A31C;
	Wed, 18 Nov 2026 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dY/uIibw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3DE1F000C4;
	Wed, 18 Nov 2026 22:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795040550;
	bh=deC16colvJ6YmP1UCuRm/b/DXcA7zKSPNYZR/ylPBC8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dY/uIibwHTdJA4M5PzAmm39IT2+od4JB7aY09mU24btvxJ4jk3dnClNHcU/Xd2djP
	 jf3W9adJTe1KBa18nNeR1HUjFY1ipuC/DlS+1h2u8Pcw0OOEahFVAt06XWlWnjGtEJ
	 VcVWV9oV8M1Lvh8KXF8+kwIGH/X7lWEU3MxDSa1FyJrGESKLZui9+4cHMBg5TpswEQ
	 MUgaMWg8/fULiXQlN4cTnjLvq0i7KPiJ+6YH9cORiD/F6pDZckA/75IPffo/tEi3ml
	 lpBelbATD3DsJfnSYzw2Mi9qOiI7FUasy4HzukKwvN5upqkMAQTOgO3JQbICSC1ssw
	 hxzz813wk3RsA==
Subject: Re: [PATCH net 2/2] net: sgi: ioc3-eth: fix IRQ lifetime against
 netdev teardown
From: netdev-bot+sashiko@kernel.org
To: kaloz@kernel.org
Cc: tsbogend@alpha.franken.de, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, sashiko-bot@kernel.org
Date: Wed, 18 Nov 2026 22:22:29 +0000
Message-ID: <179504054981.3136.8539477779059154181@kernel.org>
In-Reply-To: <20261116101934.25910-3-kaloz@kernel.org>
References: <20261116101934.25910-3-kaloz@kernel.org>
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The IRQ handler can still reach freed skb memory during
  teardown.
- [Medium] In ioc3eth_probe() (drivers/net/ethernet/sgi/ioc3-eth.c), the
  shared IRQ is still requested before the state its handler uses exists.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but ioc3_error()
  can deadlock against the timer callback and warns on every error…

--

net: sgi: ioc3-eth: fix IRQ lifetime against netdev teardown

This patch moves spin_lock_init() and timer_setup() ahead of the IRQ
request in ioc3eth_probe(), and replaces devm_request_irq() with
request_irq(). It also adds free_irq() calls on the probe error path and
in ioc3eth_remove(), so the handler is gone before free_netdev() runs.

Closes: https://lore.kernel.org/all/179473760071.2199510.16065103101920438822@kernel.org/

> diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
> index ee284a4f75ff2..e322a588d5c4d 100644
> --- a/drivers/net/ethernet/sgi/ioc3-eth.c
> +++ b/drivers/net/ethernet/sgi/ioc3-eth.c
> @@ -870,16 +870,16 @@ static int ioc3eth_probe(struct platform_device *pdev)
>  		goto out_free;
>  	}
>  
> -	if (devm_request_irq(&pdev->dev, dev->irq, ioc3_interrupt,
> -			     IRQF_SHARED, "ioc3-eth", dev)) {
> +	spin_lock_init(&ip->ioc3_lock);
> +	timer_setup(&ip->ioc3_timer, ioc3_timer, 0);

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. The timer
is set up here without TIMER_IRQSAFE. Can ioc3_error() deadlock against
the timer callback?

ioc3_error() runs in hardirq context from ioc3_interrupt(). It takes the
lock and then calls ioc3_init():

ioc3_interrupt()
  ioc3_error()
    spin_lock(&ip->ioc3_lock);
    ...
    ioc3_init(dev);
      timer_delete_sync(&ip->ioc3_timer);

Because the timer is not TIMER_IRQSAFE, every error interrupt should hit
this check in __timer_delete_sync():

    WARN_ON(in_hardirq() && !(timer->flags & TIMER_IRQSAFE));

The timer callback takes the same lock:

ioc3_timer()
  ioc3_setup_duplex()
    spin_lock_irq(&ip->ioc3_lock);

Suppose CPU1 is in ioc3_timer() spinning on ioc3_lock, while CPU0 holds
ioc3_lock in ioc3_error(). CPU0 would then spin forever in the ret < 0
loop of __timer_delete_sync(), waiting for CPU1's callback to finish.

The timer is re-armed every 1.2s while the interface is up. Heavy
incoming traffic can cause RX overflow errors.

ioc3_timeout() has the same pattern. It holds
spin_lock_irq(&ip->ioc3_lock) across ioc3_init() -> timer_delete_sync().

> +
> +	if (request_irq(dev->irq, ioc3_interrupt, IRQF_SHARED, "ioc3-eth",
> +			dev)) {
>  		dev_err(&pdev->dev, "Can't get irq %d\n", dev->irq);
>  		err = -ENODEV;
>  		goto out_free;
>  	}
>  
> -	spin_lock_init(&ip->ioc3_lock);
> -	timer_setup(&ip->ioc3_timer, ioc3_timer, 0);
> -
>  	ioc3_stop(ip);
>  
>  	/* Allocate rx ring.  4kb = 512 entries, must be 4kb aligned */

[Severity: Medium]
The commit message says the handler could run before its state was
initialized. Doesn't the same problem still apply to the rings?

When request_irq() returns, ioc3_stop() has not run yet. ip->rxr,
ip->txr, rx_skbs[] and tx_skbs[] are all still NULL from
alloc_etherdev(). ioc3_init(), which resets the MAC with EMCR_RST, also
runs later.

ioc3_interrupt() acts on the raw EISR value. It does not mask it with
EIER, does not check any device state, and always returns IRQ_HANDLED:

    eisr = readl(&regs->eisr);
    writel(eisr, &regs->eisr);
    ...
    if (eisr & (EISR_RXOFLO | ...))
        ioc3_error(dev_id, eisr);
    if (eisr & EISR_RXTIMERINT)
        ioc3_rx(dev_id);

If an EISR bit is latched when the handler runs here, ioc3_rx() would
dereference a NULL rx_skbs[0]:

    skb = ip->rx_skbs[rx_entry];
    rxb = (struct ioc3_erxbuf *)(skb->data - RX_OFFSET);

ioc3_error() -> ioc3_clean_tx_ring() would also write through a NULL
ip->txr:

    ip->txr[i].cmd = 0;

The rings do exist after later failures, such as no PHY being found or
register_netdev() failing. In that case ioc3_error() would allocate and
DMA-map new RX skbs and call ioc3_start(), which turns DMA and EIER back
on. The out_stop path would then free the rings with DMA still running
and leak those skbs.

ioc3_stop() only clears EMCR and EIER and never acks EISR. The parent's
ioc3_setup() in drivers/mfd/ioc3.c clears EISR separately from EIER. That
suggests the status bits can stay latched while EIER is 0.

There are two ways the handler can run in this window:

- another device asserts the shared line.
- CONFIG_DEBUG_SHIRQ makes its extra handler call from the free_irq()
  this patch adds on the out_stop path.

Should the rings be set up and EISR acked before the IRQ is requested?
Alternatively, request_irq() and free_irq() could move into ndo_open and
ndo_stop.

[ ... ]

> @@ -969,6 +970,7 @@ static void ioc3eth_remove(struct platform_device *pdev)
>  	struct ioc3_private *ip = netdev_priv(dev);
>  
>  	unregister_netdev(dev);
> +	free_irq(dev->irq, dev);
>  	timer_delete_sync(&ip->ioc3_timer);
>  
>  	dma_free_coherent(ip->dma_dev, RX_RING_SIZE, ip->rxr, ip->rxr_dma);

[Severity: High]
Can the handler still reach freed skbs in this teardown path?

unregister_netdev() runs ioc3_close() before this free_irq():

ioc3_close()
    timer_delete_sync(&ip->ioc3_timer);
    netif_stop_queue(dev);
    ioc3_stop(ip);
    ioc3_free_rx_bufs(ip);
    ioc3_clean_tx_ring(ip);

ioc3_close() has no synchronize_irq(), and ioc3_rx() takes no lock. A
handler already running on another CPU when EIER is cleared can
therefore race with ioc3_free_rx_bufs().

ioc3_free_rx_bufs() frees rx_skbs[rx_ci..rx_pi) with dev_kfree_skb_any().
It leaves the pointers in ip->rx_skbs[] and does not reset rx_ci or
rx_pi.

The handler can run after that in two ways:

- a shared-line interrupt arrives while the interface is down.
- CONFIG_DEBUG_SHIRQ makes its extra call inside this new free_irq().
  The commit message names that config as the reproduction method.

ioc3_interrupt() acts on EISR without checking EIER or IFF_UP:

- EISR_RXTIMERINT goes to ioc3_rx(), which dereferences the freed
  ip->rx_skbs[rx_ci]->data and can pass a freed skb to netif_rx().

- The error bits go to ioc3_error(), which runs ioc3_free_rx_bufs()
  again over the stale indices and frees the same skbs twice. It then
  allocates new RX skbs and calls ioc3_start(). That turns DMA and EIER
  back on for a downed interface just before the dma_free_coherent()
  calls below, and the new skbs are leaked.

Would it be better to move request_irq() and free_irq() into ndo_open
and ndo_stop? The other option is to add synchronize_irq(), ack EISR in
the stop path and clear rx_skbs[] after freeing.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116101934.25910-1-kaloz%40kernel.org
