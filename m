Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2E28E0;
	Tue, 28 Jul 2026 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196921; cv=none; b=J+0KI5oj9SsxxiJY6Ihkyet6XGdZVqhlBJytMeKpHv1LUTwwtNlPjMEN9ukGcH+8+4oJ6vW2rjtBb88HUz3ETj+8lmh6J630T1SJGxOYXALpNgVVPE/pKkjr9aovfVN546SBofbdzV29VXL7FhT3mrHRc4SKVEAKqsDawtksoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196921; c=relaxed/simple;
	bh=lUIEnpD6Ur058oPqFJ8q+P1S0FTjfiEfATOzD5Kiqfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTszxRtzh3Y7iT3KrhOVGlK8kZlIY74P+iX3BiBdVEzpjvEmaF0OdEQdLW++WiekgaSiCzoUNdgkWJL/BDvaLWTaCTdfmSqjEwq7OPKL2risGigqQBkicnWuozv3Bq44wBQpb+fGaDCoqb7rd0QwguoWVgHTldNVQlZ6wWd42SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyhQicsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyhQicsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63081F000E9;
	Tue, 28 Jul 2026 00:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196920;
	bh=SfscAtmh/mxxf7tJ9Gz2m2pVGQecvP85BeOv7tMqN6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YyhQicspCXj4Tura4iZO+qH1/aaifwJfiWDE0MXJTB10Jk28owX9QEOotlIwx1adQ
	 37YjCU1PC+pUyK4SemgbsCWLAFZkt2h5YVFgfjTkUWHl3UyFGJXPsiFy7YJIM+XJ/g
	 +doZUBKBJ63wDMpRhJAgk7cxSElvrCiD0mx8V/XewDOWTU6AcSwfOUtaj1Btb5GxKM
	 JUCfi5hIqHUdrfVG0R9QtD7OpnxPHz1QnmVwPtpgDDi9oVsJkCiA+WY6Xk1hY67+bM
	 WRxpQEVUFKDsJoxsu5ZCYvBB03lenpFz1JSF20zxiPrP7nDDHU3Fcm9bmuw1nHVUey
	 9tePSLaAU+8Zg==
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
Subject: Re: [PATCH net v2] qede: Fix NULL pointer dereference in TPA fragment processing
Date: Mon, 27 Jul 2026 17:01:58 -0700
Message-ID: <20260728000158.2951111-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724140044.1055918-1-vnagare@redhat.com>
References: <20260724140044.1055918-1-vnagare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
qede: Fix NULL pointer dereference in TPA fragment processing

This patch adds NULL page validation in qede_fill_frag_skb(), moves the
TPA error-state check to run before fragment processing in
qede_tpa_end(), and adds a similar check in qede_tpa_cont(), so that
TPA aggregations whose start failed under memory pressure are dropped
instead of crashing.

Link: https://lore.kernel.org/netdev/20260709044704.141507-1-vnagare@redhat.com/

> diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> index c11e0d8f98aa..3de6c5a6056c 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> @@ -698,7 +708,10 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
>  
>  out:
>  	tpa_info->state = QEDE_AGG_STATE_ERROR;
> -	qede_recycle_rx_bd_ring(rxq, 1);
> +	if (current_bd->data)
> +		qede_recycle_rx_bd_ring(rxq, 1);
> +	else
> +		qede_rx_bd_ring_consume(rxq);

[Medium]
On the else branch, qede_rx_bd_ring_consume() advances rxq->sw_rx_cons
without a matching produce and without decrementing rxq->filled_buffers.

Every other consume in this driver is paired with either
qede_alloc_rx_buffer() (which increments sw_rx_prod and filled_buffers)
or qede_reuse_page() via qede_recycle_rx_bd_ring() (which produces a
replacement). Here neither happens.

The end-of-NAPI backfill in qede_rx_int() only tops up while
rxq->num_rx_buffers - rxq->filled_buffers is non-zero, so if
filled_buffers is never decremented, the backfill will not replace this
BD.

Does this mean each hit of the NULL-data drop path permanently shrinks
the number of BDs posted to hardware by one, causing the RX ring to
monotonically deplete under the sustained memory pressure this patch is
supposed to make survivable?

Would decrementing rxq->filled_buffers here (or attempting a
replacement allocation) keep the ring in sync with hardware?

>  
>  	return -ENOMEM;
>  }
> @@ -964,8 +977,16 @@ static inline void qede_tpa_cont(struct qede_dev *edev,
>  			     struct qede_rx_queue *rxq,
>  			     struct eth_fast_path_rx_tpa_cont_cqe *cqe)
>  {
> +	struct qede_agg_info *tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
>  	int i;
>  
> +	/* Don't process fragments if TPA start failed */
> +	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START)) {
> +		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
> +			qede_recycle_rx_bd_ring(rxq, 1);
> +		return;
> +	}
> +

[High]
The other half of the patch adds a guarded fallback in
qede_fill_frag_skb() with the following justification in the v2
changelog:

  Fixed NULL buffer recycling: check if page is valid before recycling,
  otherwise just consume the BD to prevent NULL from re-entering the
  ring

However this new loop calls qede_recycle_rx_bd_ring() unconditionally on
BDs that belong to the same aggregation whose sw_rx_data may have
data == NULL (that is the exact scenario in the commit message: step 2
says qede_alloc_rx_buffer() returned -ENOMEM leaving sw_rx_data->data
NULL, and step 4 says TPA_CONT is then delivered).

qede_recycle_rx_bd_ring() calls qede_reuse_page():

  static inline void qede_reuse_page(struct qede_rx_queue *rxq,
                                     struct sw_rx_data *curr_cons)
  {
          ...
          *curr_prod = *curr_cons;
          ...
  }

so a NULL data pointer (and possibly a zero mapping) will be copied into
the producer slot and pushed to hardware.

Doesn't this re-introduce exactly the NULL-in-the-ring condition that
the qede_fill_frag_skb() branch above was written to prevent, so the
next TPA aggregation that lands on the recycled slot crashes on the
same NAPI path this commit is trying to protect?

>  	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
>  		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
>  				   le16_to_cpu(cqe->len_list[i]));
> @@ -987,6 +1008,18 @@ static int qede_tpa_end(struct qede_dev *edev,
>  	tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
>  	skb = tpa_info->skb;
>  
> +	/* Drop the packet if TPA start failed */
> +	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START || !skb)) {
> +		/* Clean up: unmap DMA if needed */
> +		if (tpa_info->buffer.page_offset == PAGE_SIZE)
> +			dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
> +				       PAGE_SIZE, rxq->data_direction);
> +		/* Recycle BDs from cqe->len_list to keep ring synchronized */
> +		for (i = 0; cqe->len_list[i] && i < ARRAY_SIZE(cqe->len_list); i++)
> +			qede_recycle_rx_bd_ring(rxq, 1);

[High, High]
The two operands of && are reversed here compared to every other loop
over cqe->len_list in this file (including the sibling loop added just
above in qede_tpa_cont()):

  for (i = 0; cqe->len_list[i] && i < ARRAY_SIZE(cqe->len_list); i++)

Because && evaluates left-to-right, cqe->len_list[i] is read before the
bound check on i.

ETH_TPA_CQE_END_LEN_LIST_SIZE is 4, and in struct
eth_fast_path_rx_tpa_end_cqe the field immediately following len_list[]
is:

  __le16  len_list[ETH_TPA_CQE_END_LEN_LIST_SIZE];
  __le16  reserved3[ETH_TPA_CQE_END_LEN_LIST_SIZE];

If firmware delivers a TPA_END with all four len_list entries non-zero,
does iteration i == 4 read reserved3[0] as if it were len_list[4]?

If reserved3[0] happens to be non-zero, does the loop keep iterating
past the array end and call qede_recycle_rx_bd_ring() extra times,
advancing rxq->sw_rx_cons and producing buffers that firmware never
released, silently desynchronising the RX BD ring?

Would swapping the operands to match the pattern used in
qede_tpa_cont() and the two other loops in qede_tpa_end() fix this?

  for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)

Separately, this loop shares the same NULL-buffer concern as the one in
qede_tpa_cont() above: qede_recycle_rx_bd_ring() will copy a NULL
sw_rx_data into the producer slot for any BD whose allocation failed,
which is the exact scenario the commit message describes.

> +		goto err;
> +	}
> +
>  	if (tpa_info->buffer.page_offset == PAGE_SIZE)
>  		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
>  			       PAGE_SIZE, rxq->data_direction);
-- 
pw-bot: cr
