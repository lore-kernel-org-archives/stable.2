Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD41EFFA1
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819524; cv=none; b=esEDmGwhhEZzwIE+OgpypW9jWC8D52B4nZphPTpZRdHplGxyI71fKx371ZPB4nc3hMvpIxJwFkeYPlkotDTcesBDGiUNs2fx9hoBMTcNmqcN2gaAJgW5z1XB7zCDuDh6n6z5ZFk/aXtJsKqyc9sZqax9/mQnLeJPfMRflalbXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819524; c=relaxed/simple;
	bh=8ePSUhaQb8QnUXHlOG+I36CHMeCDYSesDAACGnE1aSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ff/2hb4lUksa1b68nbMc8ZCnrCO9ydxbpUy9OcYIZYzB+cNfVzG20AKv6RmLmAlivm5ipGLhGJ2IXYmR8K+J9N5yCyIuK4fqrZl6CF1122aeiyO2rtm0VnNaHn5qNKO92fx1WwpcsM+Vinz4cooxG1f1634YjT7dsCmjweeOSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUxghtoo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUxghtoo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787819518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gq1pX0waFkvUy+2Abzjcz983OJaf9bd9P1XTs6fxpd4=;
	b=ZUxghtooc/V5otkjExepGrLtdDlvacaDHBq0RWVSRrYDbm9EtWt4An2KXiYVKXC+BCw/sv
	abf/3bF4XtkhZutudlGhJGdm7fVK8H465JW2V11t58XAwiT4WcB0NC62RpLpGR8SF/r9vU
	ZeC322D5AcmBoBiLYBdk0v3wKA8vS0U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-MurbVM_8Pk2eTPtGsKl6UA-1; Thu,
 27 Aug 2026 04:31:55 -0400
X-MC-Unique: MurbVM_8Pk2eTPtGsKl6UA-1
X-Mimecast-MFC-AGG-ID: MurbVM_8Pk2eTPtGsKl6UA_1787819512
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02D2D1835AE2;
	Thu, 27 Aug 2026 08:31:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.49])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D4171955F04;
	Thu, 27 Aug 2026 08:31:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: joe@dama.to
Cc: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com,
	horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH net v2] bnxt_en: Bound SW TPA IDs to prevent crashes
Date: Thu, 27 Aug 2026 10:31:39 +0200
Message-ID: <20260827083139.91346-1-pabeni@redhat.com>
In-Reply-To: <20260825001842.2501798-1-joe@dama.to>
References: <20260825001842.2501798-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
bnxt_en: Bound SW TPA IDs to prevent crashes

The patch allocates rxr->rx_tpa with bp->max_tpa rounded up to the next
power of two, stored in a new bp->max_tpa_roundup_size field, and masks the
firmware TPA ID with that size in bnxt_alloc_agg_idx() instead of using
MAX_TPA_P5_MASK.  All of the TPA info allocation and free loops now use the
new field as their bound.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 9c2cc50276a59..ba710704b1921 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -1517,14 +1517,16 @@ static int bnxt_discard_rx(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	return 0;
>  }
>  
> -static u16 bnxt_alloc_agg_idx(struct bnxt_rx_ring_info *rxr, u16 agg_id)
> +static u16 bnxt_alloc_agg_idx(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
> +			      u16 agg_id)
>  {
>  	struct bnxt_tpa_idx_map *map = rxr->rx_tpa_idx_map;
> -	u16 idx = agg_id & MAX_TPA_P5_MASK;
> +	u16 idx = agg_id & (bp->max_tpa_roundup_size - 1);
>  
>  	if (test_bit(idx, map->agg_idx_bmap)) {
> -		idx = find_first_zero_bit(map->agg_idx_bmap, MAX_TPA_P5);
> -		if (idx >= MAX_TPA_P5)
> +		idx = find_first_zero_bit(map->agg_idx_bmap,
> +					  bp->max_tpa_roundup_size);
> +		if (idx >= bp->max_tpa_roundup_size)
>  			return INVALID_HW_RING_ID;
>  	}
>  	__set_bit(idx, map->agg_idx_bmap);

[Severity: Medium]

This isn't a bug introduced by this patch, but the value stored is now
bounded while the index it is stored at is still the raw firmware ID, just
below the last quoted line:

	map->agg_id_tbl[agg_id] = idx;

agg_id comes from TPA_START_AGG_ID_P5(), whose descriptor field is 12 bits
wide:

	#define RX_TPA_START_CMP_AGG_ID_P5	(0x0fff << 16)

and the table it indexes is 1024 entries, immediately followed by the
in-use bitmap:

struct bnxt_tpa_idx_map {
	u16		agg_id_tbl[1024];
	DECLARE_BITMAP(agg_idx_bmap, MAX_TPA_P5);
};

Can an ID of 1024 or above write past agg_id_tbl[] into agg_idx_bmap?

The same raw ID is used for the read side in bnxt_lookup_agg_idx(), whose
result is used unchecked by bnxt_tpa_end() and bnxt_tpa_agg():

	agg_id = bnxt_lookup_agg_idx(rxr, agg_id);
	tpa_info = &rxr->rx_tpa[agg_id];

The commit message says "TPA IDs are generated by FW and can be up to
1024", which matches the table size, and I could not find a capability
field that would allow firmware to emit an ID above 1023, so this may not
be reachable in practice.

Would an agg_id &= ARRAY_SIZE(map->agg_id_tbl) - 1 in both helpers be worth
adding while this function is being touched?

[ ... ]

> @@ -3784,7 +3786,7 @@ static void bnxt_free_one_tpa_info(struct bnxt *bp,
>  	kfree(rxr->rx_tpa_idx_map);
>  	rxr->rx_tpa_idx_map = NULL;
>  	if (rxr->rx_tpa) {
> -		for (i = 0; i < bp->max_tpa; i++) {
> +		for (i = 0; i < bp->max_tpa_roundup_size; i++) {
>  			kfree(rxr->rx_tpa[i].agg_arr);
>  			rxr->rx_tpa[i].agg_arr = NULL;
>  		}
> @@ -3810,13 +3812,14 @@ static int bnxt_alloc_one_tpa_info(struct bnxt *bp,
>  	struct rx_agg_cmp *agg;
>  	int i;
>  
> -	rxr->rx_tpa = kzalloc_objs(struct bnxt_tpa_info, bp->max_tpa);
> +	rxr->rx_tpa = kzalloc_objs(struct bnxt_tpa_info,
> +				   bp->max_tpa_roundup_size);
>  	if (!rxr->rx_tpa)
>  		return -ENOMEM;
>  
>  	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
>  		return 0;
> -	for (i = 0; i < bp->max_tpa; i++) {
> +	for (i = 0; i < bp->max_tpa_roundup_size; i++) {
>  		agg = kzalloc_objs(*agg, MAX_SKB_FRAGS);
>  		if (!agg)
>  			return -ENOMEM;

[Severity: High]

This is a pre-existing issue, but this loop now runs up to
bp->max_tpa_roundup_size times (for example 33 becoming 64), so there are
more chances for the 272 byte kzalloc_objs(*agg, MAX_SKB_FRAGS) to fail.

On failure, bnxt_alloc_one_tpa_info() returns before rx_tpa_idx_map is
replaced, and the caller for a queue restart goes to the cleanup path:

	if (bp->flags & BNXT_FLAG_TPA) {
		rc = bnxt_alloc_one_tpa_info(bp, clone);
		if (rc)
			goto err_free_tpa_info;
	...
err_free_tpa_info:
	bnxt_free_one_tpa_info(bp, clone);

clone is a shallow copy of the live ring made in bnxt_queue_mem_alloc():

	memcpy(clone, rxr, sizeof(*rxr));
	bnxt_init_rx_ring_struct(bp, clone);
	bnxt_reset_rx_ring_struct(bp, clone);
	...
	clone->rx_agg_bmap = NULL;

Only rx_agg_bmap is cleared there, and bnxt_reset_rx_ring_struct() does not
touch rx_tpa or rx_tpa_idx_map.

So does bnxt_free_one_tpa_info(bp, clone) free the running ring's map here?

	kfree(rxr->rx_tpa_idx_map);
	rxr->rx_tpa_idx_map = NULL;

The live ring's own rx_tpa_idx_map field is not cleared by that, and the
NAPI path writes through it on every TPA completion, in
bnxt_alloc_agg_idx():

	__set_bit(idx, map->agg_idx_bmap);
	map->agg_id_tbl[agg_id] = idx;

with a second kfree() of the same pointer when the source ring is torn down.
Should clone->rx_tpa and clone->rx_tpa_idx_map be set to NULL alongside
clone->rx_agg_bmap before allocating?

> @@ -3843,6 +3846,8 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
>  			bp->max_tpa = MAX_TPA_P5;
>  	}
>  
> +	bp->max_tpa_roundup_size = roundup_pow_of_two(bp->max_tpa);
> +
>  	for (i = 0; i < bp->rx_nr_rings; i++) {
>  		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
>  

[Severity: Medium]

Can the early return earlier in bnxt_alloc_tpa_info() skip this assignment
while bp->max_tpa is already set?

	bp->max_tpa = MAX_TPA;
	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
		if (!bp->max_tpa_v2)
			return 0;

On a P5+ device whose firmware does not report max_aggs_supported,
bp->max_tpa_v2 is 0, so bp->max_tpa_roundup_size keeps its zero value while
bp->max_tpa is MAX_TPA.

bnxt_alloc_one_tpa_info() is also reachable from bnxt_queue_mem_alloc(),
which is gated only on the TPA flag and not on max_tpa_v2:

	if (bp->flags & BNXT_FLAG_TPA) {
		rc = bnxt_alloc_one_tpa_info(bp, clone);

With a count of 0, does kzalloc_objs(struct bnxt_tpa_info, 0) return
ZERO_SIZE_PTR and pass the following check?

	if (!rxr->rx_tpa)
		return -ENOMEM;

And in bnxt_alloc_agg_idx(), does the new mask become a no-op when the field
is 0?

	u16 idx = agg_id & (bp->max_tpa_roundup_size - 1);

That would leave idx as large as 4095 for the test_bit()/__set_bit() calls
on the 256 bit agg_idx_bmap and for &rxr->rx_tpa[idx] in bnxt_tpa_start().

BNXT_FLAG_TPA can be set in that state because bnxt_set_rx_skb_mode(), which
bnxt_xdp_set() calls on XDP detach, adds NETIF_F_LRO to hw_features without
a BNXT_SUPPORTS_TPA() check:

		if (rx > 1) {
			bp->flags &= ~BNXT_FLAG_NO_AGG_RINGS;
			bp->dev->hw_features |= NETIF_F_LRO;
		}

Would setting bp->max_tpa_roundup_size next to every bp->max_tpa assignment
keep the two in sync?

> @@ -4554,7 +4559,7 @@ static int bnxt_alloc_one_tpa_info_data(struct bnxt *bp,
>  	u8 *data;
>  	int i;
>  
> -	for (i = 0; i < bp->max_tpa; i++) {
> +	for (i = 0; i < bp->max_tpa_roundup_size; i++) {
>  		data = __bnxt_alloc_rx_frag(bp, &mapping, rxr,
>  					    GFP_KERNEL);
>  		if (!data)

[Severity: High]

This is a pre-existing issue, but this loop now performs up to twice as many
GFP_KERNEL allocations, and the queue restart caller ignores the -ENOMEM
that follows the quoted check, in bnxt_queue_mem_alloc():

	if (bp->flags & BNXT_FLAG_TPA)
		bnxt_alloc_one_tpa_info_data(bp, clone);

	return 0;

The open path checks the same call, so is the missing check here
intentional?

If the first __bnxt_alloc_rx_frag() fails, the remaining rxr->rx_tpa[i]
entries keep data == NULL and mapping == 0, and bnxt_queue_start() installs
the array into the live ring:

	rxr->rx_tpa = clone->rx_tpa;
	rxr->rx_tpa_idx_map = clone->rx_tpa_idx_map;

Does bnxt_tpa_start() then post a zero DMA address to the device and a NULL
buffer into the software ring for such an entry?

	prod_rx_buf->data = tpa_info->data;
	prod_rx_buf->data_ptr = tpa_info->data_ptr;

	mapping = tpa_info->mapping;
	prod_rx_buf->mapping = mapping;
	...
	prod_bd->rx_bd_haddr = cpu_to_le64(mapping);

When that descriptor completes, bnxt_rx_pkt() uses rx_buf->data without a
NULL check.
-- 
This is an AI-generated review.

