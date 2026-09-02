Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88B47F78B;
	Wed,  2 Sep 2026 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352629; cv=none; b=HcvnsBtPpvB/3VU3C/56/u3pM0PwKBGiD5kpmqwAkaFz2U2D4udOPOg8iIR6NO9NLkZNShVR2D1lDjKW8HO5CbT8fDoSF7iKvDDHbODOuibbGtcEog7qO0LyLPc0gYFM0xyHvGBUVCokvrrq879qWP6vHtniq7uNXyoNb6PMm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352629; c=relaxed/simple;
	bh=Qo8Xm2xFd6+atB6sU8bScLYB4Sco5qz67VJgYCOL4bQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hr/HZW623q42LiV2A1K3QJKibSOId22wg1OsV8Imffu4JBSz6uPrb1xzSnyNDx44+k8Rso/kSgI7zAYtgOP1uHBooyTHQ9OGRLhtSoSZ6tTJZCB4om1atBIDKc8IeGMEvF4eiB9WV7HrBXCJb85k0ejONIoR5MrQtyGuW7PQZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFgpAJGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFgpAJGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0072A1F000E9;
	Wed,  2 Sep 2026 12:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788352627;
	bh=/73rsp/ooWGRwgfttogQ0Zf76NPzYm9fMcNC/5i9mpM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eFgpAJGCkkEhkPuOPj78KvXTtWrjufHbF051FQUl+qpX+PQ2td3LYat0AsVPAAa/8
	 hKg3erw/MeEia1rTrwd7ZZYTeHLlqQkF60indmVIcEQETp10024yOMylZPiSwTy4Zt
	 rT9rSStNpxWOmMiLt3DbxibKtnI7x7QgyHfG5mkwsCJu7ejjN1kiWnHcuUXY4i8f04
	 BsEEjGyFmH20HmzxV3iHG/aBeFQv7pqz76QCS58O+ttdVmEzGbXXk6JrD7y62LKSM7
	 vS+yhv3ZWa578OLbs7T6Du2I+eJbqA3fO5DCH77uO2ozsF047ezz0PSH2ncCCFgFGx
	 1xbia6JZvAlGA==
Subject: Re: [net] net: enc28j60: fix use-after-free on remove
From: netdev-bot+sashiko@kernel.org
To: me@cherr.cc
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lanconelli.claudio@eptar.com,
 jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 02 Sep 2026 12:37:06 +0000
Message-ID: <178835262645.3394541.11265566890007089061@kernel.org>
In-Reply-To: <20260830-enc28j60-cancel-works-v1-1-4c40f17d401e@cherr.cc>
References: <20260830-enc28j60-cancel-works-v1-1-4c40f17d401e@cherr.cc>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The deferred work items are never quiesced before the
  controller is powered down, and the patch adds the cancels only at the…

--

net: enc28j60: fix use-after-free on remove

enc28j60_remove() now unregisters the netdev, frees the IRQ, cancels the
tx_work, setrx_work and restart_work items, and frees a leftover tx skb
before calling free_netdev().

> diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
> index d6c9491537e4..d16564060fbc 100644
> --- a/drivers/net/ethernet/microchip/enc28j60.c
> +++ b/drivers/net/ethernet/microchip/enc28j60.c
> @@ -1602,6 +1602,11 @@ static void enc28j60_remove(struct spi_device *spi)
>  
>  	unregister_netdev(priv->netdev);
>  	free_irq(spi->irq, priv);
> +	cancel_work_sync(&priv->tx_work);
> +	cancel_work_sync(&priv->setrx_work);
> +	cancel_work_sync(&priv->restart_work);

[Severity: Medium]

Is the placement of these cancels after unregister_netdev() and
free_irq() intentional?

unregister_netdev() runs dev_close(), and enc28j60_net_close() puts the
part to sleep without quiescing any of the works:

drivers/net/ethernet/microchip/enc28j60.c:enc28j60_net_close() {
	enc28j60_hw_disable(priv);
	enc28j60_lowpower(priv, true);
	netif_stop_queue(dev);
}

So a tx_work queued earlier by enc28j60_send_packet() can still run
during the cancel_work_sync() above, and enc28j60_hw_tx() has no
priv->hw_enable or netif_running() gate before it touches the chip:

drivers/net/ethernet/microchip/enc28j60.c:enc28j60_hw_tx() {
	enc28j60_packet_write(priv, priv->tx_skb->len, priv->tx_skb->data);
	...
	/* set TX request flag */
	locked_reg_bfset(priv, ECON1, ECON1_TXRTS);
}

Can that leave ECON1.TXRTS asserted after ECON2.PWRSV has already been
set?  enc28j60_lowpower() itself encodes the opposite ordering:

drivers/net/ethernet/microchip/enc28j60.c:enc28j60_lowpower() {
	nolock_reg_bfclr(priv, ECON1, ECON1_RXEN);
	poll_ready(priv, ESTAT, ESTAT_RXBUSY, 0);
	poll_ready(priv, ECON1, ECON1_TXRTS, 0);
	/* ECON2_VRPS was set during initialization */
	nolock_reg_bfset(priv, ECON2, ECON2_PWRSV);
}

With EIE zeroed by enc28j60_hw_disable() and the IRQ already freed, is
there anything left that can retire that transmit?  The only place that
clears TXRTS and wakes the queue is reachable solely from
enc28j60_irq():

drivers/net/ethernet/microchip/enc28j60.c:enc28j60_tx_clear() {
	locked_reg_bfclr(priv, ECON1, ECON1_TXRTS);
	netif_wake_queue(ndev);
}

The same missing quiesce also applies to the plain "ip link set ethX
down" case, where nothing cancels tx_work or setrx_work at all, so a
deferred transmit or an ERXFCON update can hit a powered-down chip, and
a late tx_work can arm TXRTS while a subsequent enc28j60_net_open() is
running the enc28j60_hw_init() soft reset and txfifo init (priv->lock is
only held per register access, not across that state transition).

Would it make sense to cancel the hardware-touching works while the
interface is still up, for instance in enc28j60_net_close() or in a
helper shared by close and remove, and/or re-quiesce the chip after the
cancels so both teardown paths follow the same rule?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260830-enc28j60-cancel-works-v1-1-4c40f17d401e%40cherr.cc
