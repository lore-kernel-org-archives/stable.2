Received: from mail-ed2-f27.google.com (mail-ed2-f27.google.com [74.125.228.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD61EBFE0
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 04:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791087981; cv=pass; b=Wtbck1aGRDXeQv54DGMkIk8LTQ32b6cE3TOAKUwitcCJJY95Is8t669OZljAKzmQHAwgDmgHcT8Q6o+gOrBE1zSeCssbJBG+3HXSwBRqw+7cepWkk8iyt0Ch90rOmnbrfwMLIeTA5U5d5ExG+Ux/H4Mh2d93mmlkSGqgRpq+/KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791087981; c=relaxed/simple;
	bh=SKotPdHlVTuPg1FAd/5spA1tpsR+3ppmd41oAH4wdg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sk9B09YtWpXEfdcP8tb2TnokqFLJkoKXs2tAftQ/ee6ppqzQe4rH94g8RhFCq6QN4V6PnM6+QkyPijUWIVQzJaKTu97NAukM5M1PMx3uh6CfpNUvcKzN43IxRLSShunChzd2wd8i/Z513uiYuGMcAo7ndhtJ5cdoIHJtVllGtig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njpwzmFW; arc=pass smtp.client-ip=74.125.228.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njpwzmFW"
Received: by mail-ed2-f27.google.com with SMTP id 4fb4d7f45d1cf-6aa135d6e97so900743a12.2
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 21:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791087978; cv=none;
        d=google.com; s=arc-20260327;
        b=QfqaIxK9v3h8/HiO6wuYb9kFl0SCHbKtV4ifJ/1L7ztXYDPi4KdwvtjCImDNPnzFp7
         wlOQu2MM+hj0jGS2s1vZwS9gUmCrgzpNJq//pkdIg3Z14SoZJzI4bgXBWJ89lTmxkB8P
         X1fFgeTi8IeYwLNRqS16IlgrlATOXDnBCypztWoJS1J1hktCAQtrJ+kcYmDUOFchRIwL
         PGpBKO406OxIREgKsdUU2ZcKTt7JODyQIsKut9J+6x8rMQx8Egz5ETka86i2Dkw7yF6R
         yo+M00kXFCH0z3zonP74Y1BWHysCGiN0qlrFMwS/F82JGR75Cfh+hlZlqYpTnluQSa3T
         5BkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iz+fpsXmiRfCDAzd66+Z5Ai8Rr0ZHI0jxjB0XZLmA2w=;
        fh=Qn83ODXhVnKjkqlbD8o6THlSnwPKNOQ59kQ3bnFhuQQ=;
        b=IQ0LehEeHaFGLzky108GuDI15mmA8MUvUHfN1snrLITjonHeYoSKzODUoj4swAIEb0
         M8Sj6ic/CP+BlJbOc4kuUBqZKtkgdn2ybxY4VyOBE6JbX/1ONEcBRgcomuBU0z2GObUF
         pyE3VnegceGpNeWZ/S/TLLtOaPuYm7s7js7whIwA01P7djMNbHxyAxFCDPj/dCe5fqwU
         xMRgtg2aEhGSmHgwrlO+D0yXyaT5ZG7J/EV+aaRsUNm5CjlwTo7cX7iOgpeiNkAJbVan
         rz/vmLqVkO7ODdfsIen5KwBIjucWmHTvEoYGzkDLXttBMEpSoaEdwL+hB5X1s0NF5Egj
         BdKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791087978; x=1791692778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iz+fpsXmiRfCDAzd66+Z5Ai8Rr0ZHI0jxjB0XZLmA2w=;
        b=njpwzmFWOGD3bCxZW7e4mHaG0aXWv5RMw4Cww1FmkIDuX3Q4ElVdJry0EqP+0ESnFS
         MlUwn/j4auMMWhld+vD8Crf0w7Uj7+GAdUgvlvCPmDVr7ly6kDmHKbjkpRW/0Ev0bDzB
         kIWv6JjOku9wK/rNjy6kNq9TO8abgCnAeTPM9AImSZSK8FRSvRr8I0vCjHWsRDyw4+3s
         m+VKAq+QIIe7ZJ5Wk8YxIfXS1fp2KFiIQapkkqji0VHFLzmgjiT9yJYQTW7Q4ekfCUBh
         NvOD4D+tugJWLaCKlxcOmDgFDBj+yL0TxLSjpFzMNQMrgYMfPgl/vVrHXcJxnJJDWHOQ
         Srsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791087978; x=1791692778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iz+fpsXmiRfCDAzd66+Z5Ai8Rr0ZHI0jxjB0XZLmA2w=;
        b=SHtK7+VgqAfzHyGpAmFFS11DIGO5PWH6ERbHzDcXVh59dKVbAXv3M8PMBsQw55SUcv
         1tC4nwpVKK4OTl2akNCNXuqCQzkts5aOd3vwANIPl0NBpJPtZUowvRLpqS+pFC5zs94z
         eF7+1WwhHqKcYfA3iOlgIaAqXYvLNDVhMOUxgTdth1ldquIvPOSqjsx+sffNgkwsQJM3
         pHhCssMOqkVOwgj6w8dslbp1ErUQpke/gtUiaRAHXFUhS0ULkGt4QX4OqWfY1Mprb/4B
         AwUcqx5BNN6mvKuJWv4trZD/6T5Ok2LC5Eh3uXkfQf8pTT5KvD/4yHaelPtpl+tAqJoq
         Mh9g==
X-Forwarded-Encrypted: i=1; AKwUvBxG1aAOko+FavR7x/CPgg8JeJ6acFDYAJnJg6y0nlOA+noZq5+w6tKWphCYRdO4xgxI02ks3Ro=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+asW29EsHqy336wQOuH8zL1jvhfoGXOQKjVukX2d4WiOTI8pH
	9o/hS+Nss3Up6dAmq2Pf97t2aKQZH4EEsPHK1cD5z2eWDyim+2K67P/pnPgBTkFDsGJVfKSs1V2
	g2b+cPkmoBhePM4WlEWk4XMgT1AcDSFGiBMLj1Q==
X-Gm-Gg: AYBFou01vNVXHATQFMOAriNTJnTAP+RwFo8GUBeZR6jalZB7+X399JraCG7slqSXJkh
	ssub+CjeNf85U8yuCiG9tdihy9wLeZiaYl1vqjJ7fqlAmq9RXonDV6rNQ2gaSCPT4ms9dofV06J
	ibz3V2ovkMRMicoecABD4pDUq4KlCnnfKUhnmxXUQPcQuPJOzlfifEBzwrkSPXmuUfWy0X02EIt
	WdPuJqxUphGjN/eWzeGW5EaaQkaIiySNI2AgXQWmz1NynTG1stC7JXO5zw38uWRbRNarji37a8E
	qQ0TnSNUk5V4452RKOWmMEfOxQTyYobo0PphS4T6v8cP49TfNeNcaBrLdwfpo3+OtTIyKa30jLW
	ARRfG8iKupWxbjji9mBN32+ygYdnIqSGNn+rbLylUvSE/3raJC4rpHiR8m+d3U+zArWPh
X-Received: by 2002:a05:6402:24ce:b0:6ab:663:c97c with SMTP id
 4fb4d7f45d1cf-6af9e2fbc80mr4197641a12.18.1791087977728; Sat, 03 Oct 2026
 21:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003041242.650599-1-mhun512@gmail.com> <179108725013.434549.7036380491047031962@kernel.org>
In-Reply-To: <179108725013.434549.7036380491047031962@kernel.org>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 4 Oct 2026 00:26:05 -0400
X-Gm-Features: AclHuK9klZkgqSKlWsLqixubrZTUZHsUiItQSy1Q0vtxuTUQnY5Jwq9tUrgeWEw
Message-ID: <CAGEsz8ENvK96T3R6kQduXwCYB0LPVxKkusLfZ6SLrf7UcsmHJw@mail.gmail.com>
Subject: Re: [PATCH net] net: nixge: stop IRQ producers before draining DMA
 error tasklet
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, ae878000@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review. I agree that clearing RUNSTOP alone is insufficient.
I will send v2 with a checked DMA reset after freeing both IRQs and
draining the tasklet. On reset timeout, it retains the DMA buffers and
rejects subsequent opens.

The other findings are pre-existing issues and need separate fixes.

pw-bot: cr

2026=EB=85=84 10=EC=9B=94 4=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 12:14, =
<netdev-bot+sashiko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 (3) =C2=B7 Medium: 0 (2) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The second stop the patch adds to nixge_stop() (lines 937-943)
>   only clears DMACR.RS on the RX and TX AXI DMA channels.
>
> Pre-existing issues:
> - [High] nixge_hw_dma_bd_release()
>   (drivers/net/ethernet/ni/nixge.c:244-281) frees priv->rx_bd_v, the RX=
=E2=80=A6
> - [High] The DMA error tasklet nixge_dma_err_handler() runs in softirq
>   context and starts by calling __nixge_device_reset() for TX and RX=E2=
=80=A6
> - [High] nixge_dma_err_handler() takes no lock while it resets tx_bd_ci,
>   tx_bd_tail and rx_bd_ci (lines 816-818), rewrites every TX descriptor,=
=E2=80=A6
> - [Medium] nixge_hw_dma_bd_release() calls devm_kfree(priv->tx_skb) (line
>   273) and frees tx_bd_v without first calling nixge_tx_skb_unmap() on=E2=
=80=A6
> - [Medium] nixge_open() calls nixge_device_reset() first.
>
> --
>
> net: nixge: stop IRQ producers before draining DMA error tasklet
>
> This reorders nixge_stop() so both IRQs are freed before tasklet_kill()
> drains the DMA error tasklet. That stops the interrupt handlers from
> rescheduling the tasklet afterwards. It also clears RUNSTOP on both DMA
> channels a second time after tasklet_kill(), in case error recovery
> restarted them.
>
> > diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/=
nixge.c
> > index 230d5ff99dd7e..7bba6f8e64fe1 100644
> > --- a/drivers/net/ethernet/ni/nixge.c
> > +++ b/drivers/net/ethernet/ni/nixge.c
>
> [ ... ]
>
> > @@ -927,11 +928,20 @@ static int nixge_stop(struct net_device *ndev)
> >       nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
> >                           cr & (~XAXIDMA_CR_RUNSTOP_MASK));
> >
> > -     tasklet_kill(&priv->dma_err_tasklet);
> > -
> > +     /* Remove both producers before draining the error tasklet. */
> >       free_irq(priv->tx_irq, ndev);
> >       free_irq(priv->rx_irq, ndev);
>
> [Severity: High]
> This is a pre-existing issue, but what serializes nixge_dma_err_handler()
> against the TX paths? The tasklet takes no lock while it unmaps every
> tx_skb[] entry and resets the ring indices:
>
> drivers/net/ethernet/ni/nixge.c:nixge_dma_err_handler() {
>     ...
>         for (i =3D 0; i < TX_BD_NUM; i++) {
>                 cur_p =3D &lp->tx_bd_v[i];
>                 tx_skb =3D &lp->tx_skb[i];
>                 nixge_tx_skb_unmap(lp, tx_skb);
>     ...
>         lp->tx_bd_ci =3D 0;
>         lp->tx_bd_tail =3D 0;
>         lp->rx_bd_ci =3D 0;
>     ...
> }
>
> Two other paths update the same state:
>
> - nixge_start_xmit(), which holds only netif_tx_lock. The error IRQ
>   handlers never stop the TX queue.
> - nixge_tx_irq()->nixge_start_xmit_done(), in hardirq context. This can
>   run on another CPU because tx_irq and rx_irq are separate lines.
>
> For example:
>
> CPU1
> nixge_rx_irq()            /* DMA error */
>   tasklet_schedule()
> nixge_dma_err_handler()
>   lp->tx_bd_tail =3D 0;
>
> CPU0
> nixge_start_xmit()
>   tx_skb->skb =3D skb;      /* tx_skb[tx_bd_tail] */
>   ++priv->tx_bd_tail;
>
> Another case: a TX completion on CPU0 runs nixge_start_xmit_done(), which
> calls nixge_tx_skb_unmap() on the same entry the tasklet is unmapping.
>
> nixge_tx_skb_unmap() checks and then frees tx_skb->mapping and tx_skb->sk=
b
> without a lock. Can this cause a double dma unmap and a double
> dev_kfree_skb_any()? Could the tasklet also free an skb whose descriptor
> the hardware then transmits from? The sleeping reset poll at the start of
> the tasklet makes this window wider.
>
> nixge_stop() has a similar window between the first RUNSTOP clear and the
> free_irq() calls above.
>
> >
> > +     tasklet_kill(&priv->dma_err_tasklet);
> > +
>
> [Severity: High]
> This isn't a bug introduced by this patch, but nixge_stop() now waits
> here for the error tasklet to finish its recovery. Can
> nixge_dma_err_handler() sleep in softirq context?
>
> nixge_dma_err_handler()
>   __nixge_device_reset()
>     nixge_dma_poll_timeout(priv, offset, status, ..., 10, 1000)
>       readl_poll_timeout()
>         usleep_range()
>
> nixge_dma_poll_timeout() wraps readl_poll_timeout(), not
> readl_poll_timeout_atomic(). With sleep_us set to 10, it calls
> might_sleep_if(). It then calls usleep_range() whenever the reset bit has
> not cleared on the first read. The comment in __nixge_device_reset() says
> the reset "takes a while to complete", so the sleeping path is expected
> to run.
>
> Would every TX or RX DMA error interrupt then trigger "BUG: scheduling
> while atomic"? Using readl_poll_timeout_atomic(), or moving the recovery
> to a workqueue, would avoid that.
>
> > +     /* Error recovery may have restarted DMA, so stop both channels a=
gain. */
> > +     cr =3D nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
> > +     nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
> > +                         cr & (~XAXIDMA_CR_RUNSTOP_MASK));
> > +     cr =3D nixge_dma_read_reg(priv, XAXIDMA_TX_CR_OFFSET);
> > +     nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
> > +                         cr & (~XAXIDMA_CR_RUNSTOP_MASK));
> > +
>
> [Severity: High]
> Is clearing RUNSTOP enough to quiesce the engines before
> nixge_hw_dma_bd_release() frees the rings?
>
> On AXI DMA, clearing DMACR.RS only requests a halt. The engine stops
> after it finishes or flushes the current transfer and any outstanding
> descriptor updates. Nothing here polls XAXIDMA_RX_SR_OFFSET or
> XAXIDMA_TX_SR_OFFSET for the halted bit, and the channels are not reset.
>
> This block is meant for the case where the error tasklet has just
> restarted the engines. In that case nixge_dma_err_handler() has
> re-enabled the interrupts and handed the whole RX ring back to the
> hardware:
>
> drivers/net/ethernet/ni/nixge.c:nixge_dma_err_handler() {
>     ...
>         cr |=3D XAXIDMA_IRQ_ALL_MASK;
>         /* Finally write to the Rx channel control register */
>         nixge_dma_write_reg(lp, XAXIDMA_RX_CR_OFFSET, cr);
>     ...
>         nixge_dma_write_reg(lp, XAXIDMA_RX_CR_OFFSET,
>                             cr | XAXIDMA_CR_RUNSTOP_MASK);
>         nixge_dma_write_desc_reg(lp, XAXIDMA_RX_TDESC_OFFSET, lp->rx_bd_p=
 +
>                             (sizeof(*lp->rx_bd_v) * (RX_BD_NUM - 1)));
>     ...
> }
>
> Right after the posted RS clear, nixge_hw_dma_bd_release() unmaps and
> frees the RX skbs and frees both coherent BD rings. Can an in-flight
> frame or a BD status writeback land in that freed memory?
>
> Frames can still arrive if phy_disconnect() did not power down the PHY,
> for example when the PHY driver has no suspend callback or WoL is
> enabled.
>
> The bare RS clear also leaves the coalesce, delay and error interrupt
> enables set by the tasklet, even though the handlers are now freed.
>
> Other drivers for the same IP wait for the halt:
>
> - axienet_dma_stop() in xilinx_axienet_main.c clears RS and the IRQ
>   enables, polls XAXIDMA_SR_HALT_MASK, and then resets "to ensure DMA is
>   really stopped".
> - xilinx_dma_stop_transfer() in drivers/dma/xilinx/xilinx_dma.c polls
>   DMASR.HALTED after clearing RUNSTOP.
>
> The commit message says:
>
>     Stop them again after tasklet_kill() returns so error recovery cannot
>     undo the final stop before the descriptors are released.
>
> Would one of these be a better final quiesce before the release?
>
> - Call the existing __nixge_device_reset() on both channels here. It
>   writes XAXIDMA_CR_RESET_MASK and waits for it to clear.
> - Wait for the halted bit before releasing the descriptors.
>
> >       nixge_hw_dma_bd_release(ndev);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but nixge_hw_dma_bd_release()
> frees rx_bd_v, the RX skbs, tx_skb and tx_bd_v without setting the
> pointers back to NULL. What happens on the next ifup if an allocation in
> nixge_hw_dma_bd_init() fails?
>
> For example, if dma_alloc_coherent() for tx_bd_v fails, tx_bd_v is NULL.
> rx_bd_v and tx_skb still hold the addresses that the previous
> nixge_stop() freed:
>
> nixge_open()
>   nixge_device_reset()
>     nixge_hw_dma_bd_init()
>       out:
>         nixge_hw_dma_bd_release()
>
> The release then does the following with stale pointers:
>
> - Walks the freed rx_bd_v ring.
> - Calls dma_unmap_single() and dev_kfree_skb() on skbs that were already
>   freed.
> - Calls dma_free_coherent() on rx_bd_v a second time.
> - Calls devm_kfree() on a tx_skb that is no longer on the devres list.
>
> If the failure happens partway through the RX skb loop, the release also
> unmaps descriptors whose phys field was never filled in.
>
> nixge_device_reset() only logs the error:
>
>         if (nixge_hw_dma_bd_init(ndev))
>                 netdev_err(ndev, "%s: descriptor allocation failed\n",
>                            __func__);
>
> So nixge_open() still returns success with NULL or freed rings.
> nixge_start_xmit() and the IRQ handlers then use those rings. The next
> nixge_stop() calls nixge_hw_dma_bd_release() on the same stale pointers
> again.
>
> Should the release set the pointers to NULL, and should
> nixge_device_reset() return the -ENOMEM to nixge_open()?
>
> [Severity: Medium]
> This is also a pre-existing issue, but does nixge_stop() leak the pending
> TX skbs and their DMA mappings? nixge_hw_dma_bd_release() frees the
> tx_skb array and tx_bd_v without first calling nixge_tx_skb_unmap() on
> each entry:
>
>         if (priv->tx_skb)
>                 devm_kfree(ndev->dev.parent, priv->tx_skb);
>
> TX skbs are only unmapped and freed in two places:
>
> - nixge_start_xmit_done(), on a TX completion interrupt.
> - nixge_dma_err_handler().
>
> Some TX descriptors may still be pending when nixge_stop() clears
> RUNSTOP and frees the IRQs. For example, the link may have gone down, or
> a completion interrupt may be held back by coalescing. Are those skbs
> and their mappings then lost on every ifdown?
>
> [Severity: Medium]
> This is another pre-existing issue, not introduced by this patch, but the
> nixge_open() error paths skip this release entirely.
> nixge_device_reset() allocates the rings, allocates and maps 128 RX
> skbs, and sets RUNSTOP on both channels. If of_phy_connect() or either
> request_irq() fails, nixge_open() takes these paths:
>
>         phy =3D of_phy_connect(ndev, priv->phy_node,
>                              &nixge_handle_link_change, 0, priv->phy_mode=
);
>         if (!phy)
>                 return -ENODEV;
>     ...
> err_rx_irq:
>         free_irq(priv->tx_irq, ndev);
> err_tx_irq:
>         napi_disable(&priv->napi);
>         phy_stop(phy);
>         phy_disconnect(phy);
>         tasklet_kill(&priv->dma_err_tasklet);
>
> Neither path calls nixge_hw_dma_bd_release() or stops the DMA. Do the
> coherent rings, the RX skbs and their mappings leak here, with RX DMA
> still running into them?
>
> The next nixge_open() overwrites tx_bd_v, tx_skb and rx_bd_v, so these
> allocations can never be reclaimed.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261003041242.650599-1-mhun512%40gmail.com
