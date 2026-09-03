Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903A62809;
	Thu,  3 Sep 2026 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421918; cv=none; b=UvEmlie7SZe9oLRz4sS202M2TjsEtAY4xYj5HUywex2lzgynJmPhfRtVN7F13qrY+Ja59eneYq67XLR05/YbCFthUtRrKVyPVvM48VNz3pCsYcmoUqR6xU8nxOI+Y/ovYgZ0eJVakmqF9rXAITcKIkQmZcbjJtSD/7n1y8GLURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421918; c=relaxed/simple;
	bh=12vrxCeahiRMFFClwm46JzrWqrTkJZ+gk2zhllMrOcs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaqEhlRx/oqvgLcQQ36nPBOPQPfTR2GsHI6aANrF3/KclZniQgO6DXhtU8Brs6hukhH3Dh/1iUHcC2p/ba8F83AYIxLkwDvD+SxkPpnm52uKPJV8loM23PLuKAPo0HSEp08jINFir9pan/gWyFuHkHxNmI0r9EjioGrOy7NgWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVxb3rOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVxb3rOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5161F000E9;
	Thu,  3 Sep 2026 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788421916;
	bh=F+vH8a0y5iRSZhuN97GDWV9SeN5RHeUo0YNxwL5iH24=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oVxb3rOep+IUU1LXH2A3wECixLK1oLVhW8FDfxOMGYTwDNKP8CNWZ9LZLJj2BqwLM
	 QBH2iA2PXrf26xksWjx5ubtwEnLvQJLZ++mYqaQa7Ar3vg9RkzZapjRlbKGF7tVw2h
	 E+wiSPjaOvjQ/XLwpbFXc7WfgkRBTR7AcxHluQY18EU5GJ1f1QWIP2kYGZ0/Wz2caw
	 KTqnDMrt1eJbt0J0K+x+S0XsZf+ewR8IiULSKEQuEHjuijiLgOMe2m1Nm9wHLwiKpV
	 9M+UT3GyD6/et+zIFyq2bq5Dpl673Dywn6ePjzWBGz/XpFbIVX2FlvN+Dl/wtpfJ8S
	 iC0NMmD8TznUA==
Subject: Re: [net,v5,4/6] bnxt_en: Handle buffer allocation failure in
 bnxt_rx_ring_reset()
From: netdev-bot+sashiko@kernel.org
To: joe@dama.to
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 prashant@broadcom.com, eddie.wai@broadcom.com, huangjw@broadcom.com,
 horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 colin.winegarden@broadcom.com, rukhsana.ansari@broadcom.com,
 linux-kernel@vger.kernel.org, raphaelcf@meta.com,
 sashiko-bot+sashiko@kernel.org, stable@vger.kernel.org
Date: Thu, 03 Sep 2026 07:51:55 +0000
Message-ID: <178842191510.3394541.8694280493608696004@kernel.org>
In-Reply-To: <20260902015652.2421609-5-joe@dama.to>
References: <20260902015652.2421609-5-joe@dama.to>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] Commit message misdescribes the failure mechanism it is
  fixing.
- [Low] The new error path in `bnxt_rx_ring_reset()`
  (drivers/net/ethernet/broadcom/bnxt/bnxt.c:14606-14616) loses the…

--

bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()

bnxt_rx_ring_reset() used to ignore the return value of
bnxt_alloc_one_rx_ring().  The patch checks it and, on failure, logs a
warning and falls back to a global reset instead of re-enabling TPA with a
partially populated rxr->rx_tpa[] array.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to

A couple of questions below, one about the commit message and one about the
new error path.

>     bnxt_alloc_one_rx_ring() can fail in bnxt_alloc_one_tpa_info_data(), which
>     returns -ENOMEM on the first failed allocation and leaves the remaining
>     rxr->rx_tpa[] entries zeroed.
>
>     This means that when the agg_id from hardware is mapped to a SW index in
>     rxr->rx_tpa[], an uninitialized slot can be chosen which would hand a
>     zero DMA address to the device.

[Severity: Medium]
Is the "entries zeroed" / "zero DMA address" description accurate for the
reset path?

bnxt_rx_ring_reset() calls bnxt_free_one_rx_ring_skbs() ->
bnxt_free_one_tpa_info_data() first, and that only clears ->data:

    for (i = 0; i < bp->max_tpa; i++) {
            struct bnxt_tpa_info *tpa_info = &rxr->rx_tpa[i];
            u8 *data = tpa_info->data;

            if (!data)
                    continue;

            tpa_info->data = NULL;
            page_pool_free_va(rxr->head_pool, data, false);
    }

->data_ptr and ->mapping are left pointing at the buffer that was just
returned to the head pool.  bnxt_alloc_one_tpa_info_data() then bails out
at the first failure:

    for (i = 0; i < bp->max_tpa; i++) {
            data = __bnxt_alloc_rx_frag(bp, &mapping, rxr, GFP_KERNEL);
            if (!data)
                    return -ENOMEM;
            ...
    }

so entries [i, bp->max_tpa) keep the stale mapping from before the reset
rather than becoming zero.  In the unfixed code bnxt_tpa_start() would then
program that stale address into the RX BD:

    mapping = tpa_info->mapping;
    prod_rx_buf->mapping = mapping;
    prod_bd = &rxr->rx_desc_ring[RX_RING(bp, prod)][RX_IDX(prod)];
    prod_bd->rx_bd_haddr = cpu_to_le64(mapping);

Would it be more precise to say the device would DMA into a recycled
page-pool buffer (and prod_rx_buf->data would be NULL), instead of a zero
DMA address?  Since this is tagged for stable, the description is what
backporters will read.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 3755a30f8d403..a8e5fdfcdf591 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14604,7 +14604,14 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
>  		rxr->rx_sw_agg_prod = 0;
>  		rxr->rx_next_cons = 0;
>  		rxr->bnapi->in_reset = false;
> -		bnxt_alloc_one_rx_ring(bp, i);
> +		rc = bnxt_alloc_one_rx_ring(bp, i);
> +		if (rc) {
> +			netdev_warn(bp->dev, "RX ring reset failed to allocate buffers, rc = %d, falling back to global reset\n",
> +				    rc);
> +			bnxt_reset_task(bp, true);
> +			bnxt_rtnl_unlock_sp(bp);
> +			return;
> +		}
>  		cpr = &rxr->bnapi->cp_ring;
>  		cpr->sw_stats->rx.rx_resets++;

[Severity: Low]
Does this new path lose the rx_resets accounting for the reset it just did?

rxr->bnapi->in_reset = false is done just above the allocation, and the new
error path returns before reaching cpr->sw_stats->rx.rx_resets++.

The fallback bnxt_reset_task(bp, true) -> bnxt_close_nic() ->
bnxt_disable_napi() is the only other place that bumps this counter, and it
is gated on in_reset:

    if (bnapi->in_reset)
            cpr->sw_stats->rx.rx_resets++;

which is already false for this ring, so the event is counted nowhere.

Contrast with the sibling failure path in the same function: the
bnxt_hwrm_rx_ring_reset() failure does a break with in_reset still set, so
its global reset does get counted by bnxt_disable_napi().  That leaves two
paths that both do an RX ring reset plus a global reset reporting different
rx_resets values via ethtool -S.

cpr->sw_stats is only freed by bnxt_free_ring_stats(), which is not reached
for an irq_re_init == false close, so the missing increment stays visible in
rx_resets and rx_total_resets.

Would incrementing rx_resets before the early return, or only clearing
in_reset after a successful bnxt_alloc_one_rx_ring(), be preferable here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902015652.2421609-1-joe%40dama.to
