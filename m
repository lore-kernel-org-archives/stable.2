Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D152268A;
	Wed, 23 Sep 2026 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167599; cv=none; b=GgGZzv8drlVWbTq91ht/YLLzMNYvlIRESKExGQ0T/p3EAxW45zt0PjnZesDXj49BeFKJuFBny3w5wDpmB2y2cUpHu1q3thBk8/N8xReYjxWqjgxfM9cxidqQJq8g6r1GLx+iC7d24EmtsqZQr01uEhEmI5XkgsGljsLdDYpjGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167599; c=relaxed/simple;
	bh=SnzjebemUbCVJRvLe1zj2XfQUzNH7xk3Ts5r4bA835g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PScGwB8sc0qTJgEMNBrHrOc1CfeSWkWF+SRWRyYblK5vQCLpQrvPUXeFys/IB2VhcjDbQIqWX3X35CE601lXwBtZ+0nDzciOJ2xJdzJpRaPyNjb0DoSLirGWzb1M2rq9CQp8puGOQy41GcIDBpeKLVVEse6Vbb1ajX1OiQHFaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gARTx8L7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gARTx8L7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C8F1F000FF;
	Wed, 23 Sep 2026 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790167597;
	bh=Z4KoWWf43I44N2oFnm3i3WiG+LboBCTwShWPcNIQiMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gARTx8L72lZ+OWPZ8SLZgCdYMK3z7wreiqwLYUrHVbD+ScXZPudUJeNApdRDaUuht
	 xKC6+PZBzoS3gnb25H2xvPnNX/o/3AEzFVynOtF4cX93aLcidYAOuID1RxSMhi0a2b
	 eL/8mthO5cdD6PXQ4Sxlu4Dmndm2+Zv/8VX5oIIlW6hU3no8ospyV8/KHJh4asSCDw
	 hzYGKOMFt1jyCIEpKmTaAPCfCC37TRdlNYchZ8aoeYbb+P746cyxr3BLx84iGR37pB
	 kZqR6UxH1vSrhZ2dCMjbgI6xgulWoRvRtEeRQmshMZZNyPBoGQvg3vdjf7LpQivnql
	 e4DevUhv/Gjeg==
Subject: Re: [PATCH net v3] net: stmmac: do not cache the new TSO MSS before
 it reaches the DMA
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn, stable@vger.kernel.org,
 lorenzo.bianconi@oss.qualcomm.com
Date: Wed, 23 Sep 2026 12:46:36 +0000
Message-ID: <179016759614.2160803.12192059495158802876@kernel.org>
In-Reply-To: <20260922124408.645496-1-xiaolinkui@126.com>
References: <20260922124408.645496-1-xiaolinkui@126.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Deferring the `tx_q->mss = mss` publication to the end of
  stmmac_tso_xmit() (stmmac_main.c:4715, right after…

--

net: stmmac: do not cache the new TSO MSS before it reaches the DMA

The patch moves the tx_q->mss update in stmmac_tso_xmit() from the point
where the MSS context descriptor is filled to the point where its OWN bit is
set, and keeps the context descriptor at the slot tx_q->cur_tx points to so
the error paths can release it explicitly.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea234..830e80cee6dca 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4563,10 +4563,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  			mss_desc = &tx_q->dma_tx[tx_q->cur_tx];
>  
>  		stmmac_set_mss(priv, mss_desc, mss);
> -		tx_q->mss = mss;
> -		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
> -						priv->dma_conf.dma_tx_size);
> -		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
>  	}
>  
>  	if (netif_msg_tx_queued(priv)) {

[ ... ]

> @@ -4714,6 +4713,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  		 */
>  		dma_wmb();
>  		stmmac_set_tx_owner(priv, mss_desc);
> +		tx_q->mss = mss;
>  	}

[Severity: Medium]
Can this new write position re-publish a stale non-zero tx_q->mss after a
concurrent TX channel reset has invalidated it?

stmmac_tso_xmit() runs under __netif_tx_lock only, but stmmac_tx_err() is
called directly from hard IRQ context and takes no TX queue lock:

stmmac_msi_intr_tx()
    } else if (unlikely(status == tx_hard_error)) {
        stmmac_tx_err(priv, chan);
    }

stmmac_dma_interrupt()
        } else if (unlikely(status[chan] == tx_hard_error)) {
            stmmac_tx_err(priv, chan);
        }

stmmac_tx_err() reinitialises the channel and clears the cached value:

stmmac_tx_err()
    stmmac_stop_tx_dma(priv, chan);
    dma_free_tx_skbufs(priv, &priv->dma_conf, chan);
    stmmac_clear_tx_descriptors(priv, &priv->dma_conf, chan);
    stmmac_reset_tx_queue(priv, chan);
    stmmac_init_tx_chan(...);
    stmmac_start_tx_dma(priv, chan);

stmmac_reset_tx_queue()
    tx_q->cur_tx = 0;
    tx_q->dirty_tx = 0;
    tx_q->mss = 0;

If that interrupt lands after the descriptors have been filled but before
the deferred update, the transmit path still executes:

        dma_wmb();
        stmmac_set_tx_owner(priv, mss_desc);
        tx_q->mss = mss;

which leaves a non-zero cached MSS for a channel that was just
re-initialised and never programmed with it. The next TSO frame with the
same gso_size then takes the mss == tx_q->mss path and emits no context
descriptor. With the old placement the write happened early, so a later
reset always won and the cached value ended up as 0.

Does this interact with the commit message statement "Update tx_q->mss only
once the context descriptor has been given to the DMA, so that the cached
value always describes what the hardware is actually programmed with"? The
tx_q->mss = 0 in stmmac_reset_tx_queue() suggests the driver assumes the
MAC loses its latched MSS across the reset, in which case that invariant
still does not hold for this interleaving.

The missing serialisation of stmmac_tx_err() against the TX path is older
than this patch and already perturbs cur_tx/dirty_tx, but the stale
non-zero MSS outcome comes from the new write placement. Would it make
sense to note this, or to keep the cache coherent some other way?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922124408.645496-1-xiaolinkui%40126.com
