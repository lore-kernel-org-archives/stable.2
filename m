Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639953F44FC;
	Thu, 16 Jul 2026 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191701; cv=none; b=hPUSIETtmT0B5hAv4OXjlm5FwBO2qx3Gc1pXzgToLSerMJO+/B8RWdtfvPDd2jrZTKmCucCqYj8dtAfCuj18+ohYqGvG612KIAcxIFhEGm69C0GY8gF9rxz0/pf4K7p85ZktFcd58c7jNV5MvK0j0goWIycM8DfWPH+ybkXlPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191701; c=relaxed/simple;
	bh=mjTfFzJrauUQA1xVM8m5gcIk3A+LbENrAnTOzBdUjAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5ug5n9YX2M0yXMcv5XBSNYRVDN0MXDQYr7kgLOHfSFStQshlVK3rasU0bjN1qIu82mvC3Sk0r+A59dnyFlO7TkBtUYMl3u2mvVufjJStfrGHPEem3JWEhIxU0/4Rz/xS5H7jPJUCGwH1FqbJ0UC5ulVx1+bcl3gPrESdZR95Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr/3Bnvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr/3Bnvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C891F000E9;
	Thu, 16 Jul 2026 08:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784191694;
	bh=J69pzAUYwWIM1Pkegk53G1F9wO482+lM/1bllFaCuPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hr/3Bnvf0FHm62fS80bjqmt1R+ZzB7JnsH9GQxW4IESwbCgeUZlNOuvRzXFnK87kZ
	 gO6i5ikGAtFlE2Uei5/3NwWTwGYDLJwxkmarNNbnIf4ENyua5K85WXjlDEknV3wn+8
	 0ssezpfBFLRlQqRjEsetOjKdFP6XekJw8dO+ITM2/J3oK9wK3atLNcTebdCEYge4Nr
	 UmDfh2cCaCtURKKt985Kkx2L2+ttYxhfooW7In2BH3EyJETR/bZ9TlYA7icyD+c2B/
	 groUcobD4hHvxRgNk5zI8+c+AJy0VwheS4VC8RvVs9ly8mFkNG8phm3hIJFQxwprfX
	 hQ0PafrJ4Wb0g==
From: Simon Horman <horms@kernel.org>
To: nagarevaibhav@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	matvey.kovalev@ispras.ru,
	Pavel.Zhigulin@kaspersky.com,
	aelior@marvell.com,
	manishc@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	vnagare@redhat.com
Subject: Re: [PATCH net] qede: Fix NULL pointer dereference in TPA fragment processing
Date: Thu, 16 Jul 2026 09:47:46 +0100
Message-ID: <20260716084746.212045-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709044704.141507-1-vnagare@redhat.com>
References: <20260709044704.141507-1-vnagare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [1]: [PATCH net] qede: Fix NULL pointer dereference in TPA fragment processing ---
commit 437c90c9a6930fba111f83e319f598fb4b80193c
Author: Vaibhav Nagare <nagarevaibhav@gmail.com>

qede: Fix NULL pointer dereference in TPA fragment processing

This commit attempts to fix a NULL pointer dereference under memory pressure
by adding validation in qede_fill_frag_skb() and checking the aggregation
state early in qede_tpa_end() and qede_tpa_cont().

> diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> index c11e0d8f98aa5..18a3167b35c84 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> @@ -670,13 +670,22 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
>  							 NUM_RX_BDS_MAX];
>  	struct qede_agg_info *tpa_info = &rxq->tpa_info[tpa_agg_index];
>  	struct sk_buff *skb = tpa_info->skb;
> +	struct page *page = current_bd->data;
>  
>  	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START))
>  		goto out;
>  
> +	/* Avoid NULL pointer dereference when under severe memory pressure */
> +	if (unlikely(!page)) {
> +		DP_NOTICE(edev,
> +			  "Failed to allocate RX buffer for TPA agg %u\n",
> +			  tpa_agg_index);

[Severity: Medium]
Since this function executes per-fragment inside the fast-path NAPI poll
loop, could this unconditional DP_NOTICE cause a printk storm under memory
pressure?

If a TPA event has multiple fragments, this might flood the kernel buffer
and potentially cause soft lockups. Should this be a rate-limited print?

> +		goto out;

[Severity: Critical]
This is a pre-existing issue, but does jumping to the out label when page is
NULL actually fix the crash, or just delay it?

Looking at the error path:

qede_fill_frag_skb() {
...
out:
	tpa_info->state = QEDE_AGG_STATE_ERROR;
	qede_recycle_rx_bd_ring(rxq, 1);
...
}

This blindly recycles the poisoned BD via qede_recycle_rx_bd_ring(), placing
the NULL page pointer back into the software ring instead of dropping it.

When a subsequent normal packet arrives, won't the driver panic when
qede_rx_build_skb() calls skb_put_data(skb, page_address(bd->data) + offset)?

The NULL pointer appears to be introduced earlier in qede_tpa_start() when it
copies the mapping and page_offset on failure, but does not copy the data
pointer. Later, qede_tpa_end() calls qede_reuse_page(), pushing this defective
buffer into the active RX ring.

> +	}
> +
>  	/* Add one frag and update the appropriate fields in the skb */
>  	skb_fill_page_desc(skb, tpa_info->frag_id++,
> -			   current_bd->data,
> +			   page,
>  			   current_bd->page_offset + rxq->rx_headroom,
>  			   len_on_bd);

[ ... ]

> @@ -987,6 +1004,10 @@ static int qede_tpa_end(struct qede_dev *edev,
>  	tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
>  	skb = tpa_info->skb;
>  
> +	/* Drop the packet if TPA start failed */
> +	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START || !skb))
> +		goto err;
> +

[Severity: Critical]
By adding this early exit to the err label, do we bypass the teardown steps
required to keep the software and hardware rings in sync?

If a TPA aggregation starts successfully but fails later, tpa_info->state is
set to QEDE_AGG_STATE_ERROR. When the hardware subsequently delivers the
TPA_END completion, this early exit will skip the dma_unmap_page() call
for the initial tpa_info->buffer.

It also skips the loop over cqe->len_list:

	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
		qede_fill_frag_skb(...);

Unlike the fix in qede_tpa_cont() which manually recycles the BDs, skipping
this abandons the BDs used by the hardware. Won't this permanently
desynchronize the software RX consumer index (sw_rx_cons) from the hardware
producer index, leading to out-of-bounds memory accesses?

>  	if (tpa_info->buffer.page_offset == PAGE_SIZE)
>  		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
>  			       PAGE_SIZE, rxq->data_direction);
