Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F819E839;
	Fri, 14 Aug 2026 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668228; cv=none; b=Z3J39XEuc2RxqIh5hsbiQ8H1FA3k4J5tWjdChJMwyB5XF1tyv9vDwAnqndEcH/Y1kLxj0Ta9sJs4M4+utbAr135ipNbKFYntPgpljBhAHmL3y7gkc4wk/eZwflN17CZxDgBJLsJf6P+6VVMMqzE/zTv/0CKuLs1+ZnRFMkhcvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668228; c=relaxed/simple;
	bh=mhzvxLW1qFnzIbEY84rZTKxZLkrCLaH6jjyvuLmDRPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vC2MC5tJ4c3jKPxocy2KQ/0NLwlwWAAtFLrIrKEy9c7H4NL7BYTT0peJlZvvn2o0iVnQzEWHNhWIMGFLxk6UXJNkzootGCiIaKXcdSRisNAhJvjB4K64vZtEz9t0xSIbOGulKBcYUfElBAf/cvULJQMlce/jXieA+BQr3FN8nJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpDlKTHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpDlKTHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D571F000E9;
	Fri, 14 Aug 2026 00:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786668226;
	bh=D02NEgizCXyw2zjc/lKoGm9/FhM8pyBnoyvGH4+7bVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lpDlKTHOmnb7t/4QryvbQZmP4zz8HhKFvq6JV9zpC7NH3IiHE6etMOLeN4aennZRP
	 Ddxs3zPyopSBNsyiLrEW6ZHJCQZuPrucbb9XgRR0OaICtoTDUIh1NU+Wt1/Su2QWNk
	 teujTR1oDU/f2Pr10BrNVR0AjHKO3I4eVgotCHDoRtcKBBi8g/GZaBy4Z2rtv66VwR
	 QUCprFis2gLeXQWe++vN7qs7gy584J9rHURsgrnC5WxMS99zrC//t6woEfMbf8wyGo
	 4huBdulWKCQvMYn7+7Q/aoLlA00p9gIzkssexy9Ik9iLkhKjSAp+6d0btrz9jrk+Pt
	 IeKuOj+dEcHXw==
From: Jakub Kicinski <kuba@kernel.org>
To: nagarevaibhav@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horms@kernel.org,
	davem@davemloft.net,
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
Subject: Re: [PATCH net v4] qede: Fix NULL pointer dereference in TPA fragment processing
Date: Thu, 13 Aug 2026 17:42:52 -0700
Message-ID: <20260814004251.2757568-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810131859.1870628-1-vnagare@redhat.com>
References: <20260810131859.1870628-1-vnagare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says: "Looks like AI is questioning whether some of the extra
code is really needed. Please TAL, the incorrect indent definitely
needs fixing, however trivial that is."
---
qede: Fix NULL pointer dereference in TPA fragment processing

This restores the tpa_info->buffer.data assignment in qede_tpa_start() that
commit 8a8633978b84 ("qede: Add build_skb() support.") dropped, and adds a
NULL page check plus early error-state exits in the TPA fragment paths.  The
new early exits recycle or consume the BDs described by cqe->len_list.

A few questions on the commit message and on the added hardening below.

First, on the enumerated list of changes:

>     Fix the root cause by:
>     1. Restoring the tpa_info->buffer.data assignment in qede_tpa_start().
>     2. Reverting the error recovery block in qede_tpa_end() to rely on
>        tpa_start_fail, which safely recycles the page without causing
>        double DMA unmaps.

[Severity: Medium]
Does item 2 correspond to anything in this patch?  In the tree being
patched, the err: label in qede_tpa_end() already reads:

	if (tpa_info->tpa_start_fail) {
		qede_reuse_page(rxq, &tpa_info->buffer);
		tpa_info->tpa_start_fail = false;
	}

and that block is not touched by any hunk here, so there is nothing being
reverted relative to the base tree.

>     4. Correct bounds checking logic in TPA error loops (evaluating bounds
>        before reading the array elements to prevent out-of-bounds reads).

[Severity: Medium]
Similarly, which out-of-bounds read does item 4 fix?  The existing loops in
qede_tpa_cont() and qede_tpa_end() already evaluate the bound first:

	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)

and they appear only as unchanged context lines in the hunks below.  Both
items 2 and 4 look like deltas against the earlier v3 posting rather than
against the tree, and an advertised out-of-bounds-read fix in a Cc: stable
patch tends to get picked up by backport and CVE tooling.  Could the message
describe only what this patch changes, namely restoring buffer.data, the
NULL page guard, and the early error-state exits with the consume and
filled_buffers accounting?

> diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> index c11e0d8f98aa5..ed9db7399d2fc 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> @@ -670,13 +670,23 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
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
> +		if (net_ratelimit())
> +			DP_NOTICE(edev,
> +				  "Failed to allocate RX buffer for TPA agg %u\n",
> +				  tpa_agg_index);
> +		goto out;
> +	}

[Severity: Low]
Do the comment and the message here describe the condition that is actually
detected?  current_bd is just a ring slot:

	struct sw_rx_data *current_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
							 NUM_RX_BDS_MAX];

so no allocator runs between function entry and this test, and a NULL data
means the sw_rx_ring entry at the consumer index is the "ghost" BD (valid
mapping, NULL page) that the commit message describes qede_reuse_page() as
pushing back into the ring.  That is a ring bookkeeping inconsistency rather
than an allocation failure.

The text is also very close to the genuine allocation-failure notice already
present in qede_tpa_rx_build_skb():

	DP_NOTICE(edev,
		  "Failed to allocate RX buffer for tpa start\n");

Would wording that names the ghost descriptor make the two distinguishable
in field logs?

[ ... ]

> @@ -698,8 +708,12 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
>  
>  out:
>  	tpa_info->state = QEDE_AGG_STATE_ERROR;
> -	qede_recycle_rx_bd_ring(rxq, 1);
> -
> +	if (current_bd->data) {
> +		qede_recycle_rx_bd_ring(rxq, 1);
> +	} else {
> +		qede_rx_bd_ring_consume(rxq);
> +		rxq->filled_buffers--;
> +	}
>  	return -ENOMEM;
>  }
>  
> @@ -850,7 +864,7 @@ static void qede_tpa_start(struct qede_dev *edev,
>  					      pad, false);
>  	tpa_info->buffer.page_offset = sw_rx_data_cons->page_offset;
>  	tpa_info->buffer.mapping = sw_rx_data_cons->mapping;
> -
> +	tpa_info->buffer.data = sw_rx_data_cons->data;

[Severity: Low]
This one assignment appears to be the whole crash fix.  Would it be worth
splitting it out as the Fixes: / Cc: stable patch and sending items 3 to 6
as a separate hardening patch?

Two things make the added hardening look inconsistent with itself.  If a
descriptor with a valid mapping but NULL data really can reach the driver,
the regular receive path still dereferences the same field unguarded:

qede_build_skb()
	buf = page_address(bd->data) + bd->page_offset;

qede_rx_build_skb()
	skb_put_data(skb, page_address(bd->data) + offset, len);

and qede_tpa_start() itself hands sw_rx_data_cons to
qede_tpa_rx_build_skb() -> qede_build_skb() just above this new assignment,
before any validation.  Should those consumers get the same treatment, or is
the ghost BD no longer reachable once buffer.data is restored?

[Severity: Low]
This isn't a bug introduced by this patch, but the comment on
struct qede_agg_info::buffer in qede.h is now stale in a way that touches
this hunk:

	/* rx_buf is a data buffer that can be placed / consumed from rx bd
	 * chain. It has two purposes: We will preallocate the data buffer
	 * for each aggregation when we open the interface and will place this
	 * buffer on the rx-bd-ring when we receive TPA_START.
	 ...

There is no such preallocation any more.  The only TPA initialisation,
qede_set_tpa_param() in qede_main.c, just does:

	tpa_info->state = QEDE_AGG_STATE_NONE;

and nothing allocates, unmaps or frees tpa_info->buffer.data; the real
implementation is the copy of the current Rx consumer descriptor being
completed here.  Since this patch makes that field live again, could the
comment be refreshed to match?

>  	if (unlikely(!tpa_info->skb)) {
>  		DP_NOTICE(edev, "Failed to allocate SKB for gro\n");
>  
> @@ -964,8 +978,24 @@ static inline void qede_tpa_cont(struct qede_dev *edev,
>  				 struct qede_rx_queue *rxq,
>  				 struct eth_fast_path_rx_tpa_cont_cqe *cqe)
>  {
> +	struct qede_agg_info *tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
>  	int i;
>  
> +	/* Don't process fragments if TPA start failed */
> +	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START)) {
> +		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++) {
> +			struct sw_rx_data *rx_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
> +								NUM_RX_BDS_MAX];
> +				if (likely(rx_bd->data)) {
> +					qede_recycle_rx_bd_ring(rxq, 1);
> +				} else {
> +					qede_rx_bd_ring_consume(rxq);
> +					rxq->filled_buffers--;
> +				}
> +		}
> +		return;
> +	}
> +

[Severity: Low]
The if (likely(rx_bd->data)) block carries two extra tabs relative to the
enclosing for loop; checkpatch should flag that.

Beyond the indentation, is this new loop doing anything the existing call
did not?  With state != QEDE_AGG_STATE_START, qede_fill_frag_skb() takes its
out: path immediately and, with this patch applied, runs exactly the same
rx_bd->data test and recycle-or-consume sequence once per len_list entry.

> @@ -991,6 +1021,22 @@ static int qede_tpa_end(struct qede_dev *edev,
>  		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
>  			       PAGE_SIZE, rxq->data_direction);
>  
> +	/* Drop the packet if TPA start failed */
> +	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START || !skb)) {
> +		/* Recycle BDs from cqe->len_list to keep ring synchronized */
> +		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++) {
> +			struct sw_rx_data *rx_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
> +								NUM_RX_BDS_MAX];
> +			if (likely(rx_bd->data)) {
> +				qede_recycle_rx_bd_ring(rxq, 1);
> +			} else {
> +				qede_rx_bd_ring_consume(rxq);
> +				rxq->filled_buffers--;
> +			}
> +		}
> +		goto err;
> +	}
> +

[Severity: Low]
Same question here: the existing fill loop below already falls through to
qede_fill_frag_skb()'s out: path when state != QEDE_AGG_STATE_START, and
then reaches the err: label via the following check.  Is this open-coded
copy of that behaviour needed, given it enlarges a patch marked for stable?

>  	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
>  		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
>  				   le16_to_cpu(cqe->len_list[i]));
-- 
pw-bot: cr
