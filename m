Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D84A1387
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856044; cv=none; b=kYrY+rE3hHkzGAupCq8sYDEQFpOCkxD+7kBsTZPcV0R27IibVw1rPZ3zrJBagECnWkAVbpeercI6nus4/6kYIvzkoOziz1pHY/9JshmgOLkF+Nj/24x5eM2Pj3iek90r3htrdlcozhwVqqk99tYrOi/Nxu2B9SXsBT0vIKC7FQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856044; c=relaxed/simple;
	bh=s38raES+aYLadiG+3JXZ2zNKydA9RD56IOss05saA6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMhpthh3jwRK39vRyIcc2B97ZPVRO4HkqvzE+8/A/FDioDN1t1q/ZGxeOmc2L2YazA7YIhTpS3NV+2b3sjEfB8jSYoGp0EcxCpO2SRUIqwe3BTB9tntLDMPI2MCWxDlz5FuGaFbFx/JX9rrzlt9scAKFU7aXy57N0fvZX94khJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=BjcytC7E; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="BjcytC7E"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d01663d816so1444715ad.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 11:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787856041; x=1788460841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XejAmH/KP2JAkT0dl9by3HENDzeG7XsT4Hjw5tlQtvk=;
        b=BjcytC7EngX77ZT0CBzXfyIWi/6zrwODKinxvh/rUbJE21IC/kFXRVMHAvNV+XxleM
         k5ZMcroEpgbB3pao9L62mIUIRtp6lPKggUdRpd+ScI7zd9cBckASjOWgJ3xgnPARE8zi
         Th+1WAGEl385smDZeCNCIPO13bEmsL+iOKjSm9ptntCx+49TXwp0hVKzsVWjBwpr49Ix
         GBb4OmdNj+jzvHPW1VbF8hZANGkQsaiVNXBWnCiDwNqNLha5xiNIbDbz+VX7e3fcoow3
         ZazImkDPzOFzhz3LSqkBFdIleQfs/JjakYAeRU3G37UEeFEaRzhstlDDDRtIJeoTTw6X
         dWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856041; x=1788460841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XejAmH/KP2JAkT0dl9by3HENDzeG7XsT4Hjw5tlQtvk=;
        b=mOMZITj8HtwkjcDj7IfwWimLmnDrsWTq7+Ict4cpps4fnNTWtq/BEfKTNbFm7HM+y5
         qqHOODeh904xWGzJmrISA0plMFultchmSq9MPvH+3Zc5Dsb6PuGx7kv4xYPmLvJrSIiF
         10BqNJwMHcSs9EEupsgxtq35D0EtfrdZvP8nCb7UhCYDYBuW82Febpe5gX5cP4F1zpY9
         ek3M3EYr5BW2jTA12MINU6544rjsjXpBx9gggj4uYTBnLy/fNVQlNr9z3ucEfJSFNnZF
         b78dSFTAcIONzAAaPJW0DVrfV7FB4g9LH6VAq1SZ66aOjz4BA8IswP6E3DaBNgo3GTAe
         8ICQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcHZFiqCMS2hNK9fDycqSFPhaT212Nl8ybN2lutAHJovJHrd9if6w/BQTFYcO+WKX7lw6Wv1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nsgNtHxOi098sVRjlauo6AzMC60XnsnBj9/UhX+k+7IomCBZBJ
	6D+6H2a92NmSYWR+zmEiC4E6klmxYYYP1WZOxZo/wj4yLmbblwTb4Qoot8yBveDcBZg=
X-Gm-Gg: AR+sD113JmilX578XTqwECwUnkVCt4TYhCUfaRSCs5DSeuP/lp6UeDEPCPaXTuYkOtU
	ZZzFjqLMiI24hENeE1ltLosILm44BJ7pQPyZNy1XMAsRLUOd00DHTwstHypWfL/h+ODsKEXhQWY
	FTGmM5Vib5wZYu5/3YhldggEUReJAfMRUt+mfz5+G5VkpDU+Mb0uYtJTeisllS3B/n1GihxHPvZ
	sM/p9PPTkhjz1n8vNIdtmIZFifj2Ev9z6V4SN0KHdRu5o+xajUcxF7DbeeOAaJEDRqNefWNhv3Z
	uA3eCyZ9eXSEsDg38sBnw+HTVJBPlpIX9BBZ1S2b2bzXROl3algEwJdJe/geGXIR4TP+qeH0p0m
	NT0FSRp7xBoFI7UTMyD+e16YCtkl45mt8TvvgZ4IhltNHKk1CcyPosUgPmve4DpurFRbLsUxq8T
	2Q4VMIZmGqZxUxEP0ZJYVJglaDmR+4Xhpim4AHFdHQzw==
X-Received: by 2002:a17:903:324c:b0:2c2:62ee:5a0d with SMTP id d9443c01a7336-2d74df1c634mr18207755ad.14.1787856041391;
        Thu, 27 Aug 2026 11:40:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70498ca3csm20150005ad.31.2026.08.27.11.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:40:40 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:40:40 -0700
From: Joe Damato <joe@dama.to>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com, horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net v2] bnxt_en: Bound SW TPA IDs to prevent crashes
Message-ID: <apCEqAkcuo27VOp/@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com, horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260825001842.2501798-1-joe@dama.to>
 <20260827083139.91346-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827083139.91346-1-pabeni@redhat.com>

On Thu, Aug 27, 2026 at 10:31:39AM +0200, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> bnxt_en: Bound SW TPA IDs to prevent crashes
> 
> The patch allocates rxr->rx_tpa with bp->max_tpa rounded up to the next
> power of two, stored in a new bp->max_tpa_roundup_size field, and masks the
> firmware TPA ID with that size in bnxt_alloc_agg_idx() instead of using
> MAX_TPA_P5_MASK.  All of the TPA info allocation and free loops now use the
> new field as their bound.
> 
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index 9c2cc50276a59..ba710704b1921 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -1517,14 +1517,16 @@ static int bnxt_discard_rx(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
> >  	return 0;
> >  }
> >  
> > -static u16 bnxt_alloc_agg_idx(struct bnxt_rx_ring_info *rxr, u16 agg_id)
> > +static u16 bnxt_alloc_agg_idx(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
> > +			      u16 agg_id)
> >  {
> >  	struct bnxt_tpa_idx_map *map = rxr->rx_tpa_idx_map;
> > -	u16 idx = agg_id & MAX_TPA_P5_MASK;
> > +	u16 idx = agg_id & (bp->max_tpa_roundup_size - 1);
> >  
> >  	if (test_bit(idx, map->agg_idx_bmap)) {
> > -		idx = find_first_zero_bit(map->agg_idx_bmap, MAX_TPA_P5);
> > -		if (idx >= MAX_TPA_P5)
> > +		idx = find_first_zero_bit(map->agg_idx_bmap,
> > +					  bp->max_tpa_roundup_size);
> > +		if (idx >= bp->max_tpa_roundup_size)
> >  			return INVALID_HW_RING_ID;
> >  	}
> >  	__set_bit(idx, map->agg_idx_bmap);
> 
> [Severity: Medium]
> 
> This isn't a bug introduced by this patch, but the value stored is now
> bounded while the index it is stored at is still the raw firmware ID, just
> below the last quoted line:
> 
> 	map->agg_id_tbl[agg_id] = idx;
> 
> agg_id comes from TPA_START_AGG_ID_P5(), whose descriptor field is 12 bits
> wide:
> 
> 	#define RX_TPA_START_CMP_AGG_ID_P5	(0x0fff << 16)
> 
> and the table it indexes is 1024 entries, immediately followed by the
> in-use bitmap:
> 
> struct bnxt_tpa_idx_map {
> 	u16		agg_id_tbl[1024];
> 	DECLARE_BITMAP(agg_idx_bmap, MAX_TPA_P5);
> };
> 
> Can an ID of 1024 or above write past agg_id_tbl[] into agg_idx_bmap?

I don't think this is possible. bp->max_tpa is min_t(u16, bp->max_tpa_v2,
MAX_TPA_P5), never going above 256. 1024 is 4x the headroom and if FW returned
that, it would be ignoring the count it advertised... which seems like a FW
bug.

> The same raw ID is used for the read side in bnxt_lookup_agg_idx(), whose
> result is used unchecked by bnxt_tpa_end() and bnxt_tpa_agg():
> 
> 	agg_id = bnxt_lookup_agg_idx(rxr, agg_id);
> 	tpa_info = &rxr->rx_tpa[agg_id];
> 
> The commit message says "TPA IDs are generated by FW and can be up to
> 1024", which matches the table size, and I could not find a capability
> field that would allow firmware to emit an ID above 1023, so this may not
> be reachable in practice.

Agreed, it is not reachable.

> 
> > @@ -3784,7 +3786,7 @@ static void bnxt_free_one_tpa_info(struct bnxt *bp,
> >  	kfree(rxr->rx_tpa_idx_map);
> >  	rxr->rx_tpa_idx_map = NULL;
> >  	if (rxr->rx_tpa) {
> > -		for (i = 0; i < bp->max_tpa; i++) {
> > +		for (i = 0; i < bp->max_tpa_roundup_size; i++) {
> >  			kfree(rxr->rx_tpa[i].agg_arr);
> >  			rxr->rx_tpa[i].agg_arr = NULL;
> >  		}
> > @@ -3810,13 +3812,14 @@ static int bnxt_alloc_one_tpa_info(struct bnxt *bp,
> >  	struct rx_agg_cmp *agg;
> >  	int i;
> >  
> > -	rxr->rx_tpa = kzalloc_objs(struct bnxt_tpa_info, bp->max_tpa);
> > +	rxr->rx_tpa = kzalloc_objs(struct bnxt_tpa_info,
> > +				   bp->max_tpa_roundup_size);
> >  	if (!rxr->rx_tpa)
> >  		return -ENOMEM;
> >  
> >  	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
> >  		return 0;
> > -	for (i = 0; i < bp->max_tpa; i++) {
> > +	for (i = 0; i < bp->max_tpa_roundup_size; i++) {
> >  		agg = kzalloc_objs(*agg, MAX_SKB_FRAGS);
> >  		if (!agg)
> >  			return -ENOMEM;
> 
> [Severity: High]
> 
> This is a pre-existing issue, but this loop now runs up to
> bp->max_tpa_roundup_size times (for example 33 becoming 64), so there are
> more chances for the 272 byte kzalloc_objs(*agg, MAX_SKB_FRAGS) to fail.
> 
> On failure, bnxt_alloc_one_tpa_info() returns before rx_tpa_idx_map is
> replaced, and the caller for a queue restart goes to the cleanup path:
> 
> 	if (bp->flags & BNXT_FLAG_TPA) {
> 		rc = bnxt_alloc_one_tpa_info(bp, clone);
> 		if (rc)
> 			goto err_free_tpa_info;
> 	...
> err_free_tpa_info:
> 	bnxt_free_one_tpa_info(bp, clone);
> 
> clone is a shallow copy of the live ring made in bnxt_queue_mem_alloc():
> 
> 	memcpy(clone, rxr, sizeof(*rxr));
> 	bnxt_init_rx_ring_struct(bp, clone);
> 	bnxt_reset_rx_ring_struct(bp, clone);
> 	...
> 	clone->rx_agg_bmap = NULL;
> 
> Only rx_agg_bmap is cleared there, and bnxt_reset_rx_ring_struct() does not
> touch rx_tpa or rx_tpa_idx_map.
> 
> So does bnxt_free_one_tpa_info(bp, clone) free the running ring's map here?
> 
> 	kfree(rxr->rx_tpa_idx_map);
> 	rxr->rx_tpa_idx_map = NULL;
> 
> The live ring's own rx_tpa_idx_map field is not cleared by that, and the
> NAPI path writes through it on every TPA completion, in
> bnxt_alloc_agg_idx():
> 
> 	__set_bit(idx, map->agg_idx_bmap);
> 	map->agg_id_tbl[agg_id] = idx;
> 
> with a second kfree() of the same pointer when the source ring is torn down.
> Should clone->rx_tpa and clone->rx_tpa_idx_map be set to NULL alongside
> clone->rx_agg_bmap before allocating?

I think this is a real bug, but as mentioned above this is a pre-existing
issue and not related to the patch I posted.

I can send a separate patch in the future addressing this, if desired, but I
don't think it makes sense to try to address this in this patch since it would
need a different fixes.
 
> > @@ -3843,6 +3846,8 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
> >  			bp->max_tpa = MAX_TPA_P5;
> >  	}
> >  
> > +	bp->max_tpa_roundup_size = roundup_pow_of_two(bp->max_tpa);
> > +
> >  	for (i = 0; i < bp->rx_nr_rings; i++) {
> >  		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
> >  
> 
> [Severity: Medium]
> 
> Can the early return earlier in bnxt_alloc_tpa_info() skip this assignment
> while bp->max_tpa is already set?
> 
> 	bp->max_tpa = MAX_TPA;
> 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
> 		if (!bp->max_tpa_v2)
> 			return 0;
> 
> On a P5+ device whose firmware does not report max_aggs_supported,
> bp->max_tpa_v2 is 0, so bp->max_tpa_roundup_size keeps its zero value while
> bp->max_tpa is MAX_TPA.
> 
> bnxt_alloc_one_tpa_info() is also reachable from bnxt_queue_mem_alloc(),
> which is gated only on the TPA flag and not on max_tpa_v2:
> 
> 	if (bp->flags & BNXT_FLAG_TPA) {
> 		rc = bnxt_alloc_one_tpa_info(bp, clone);
> 
> With a count of 0, does kzalloc_objs(struct bnxt_tpa_info, 0) return
> ZERO_SIZE_PTR and pass the following check?
> 
> 	if (!rxr->rx_tpa)
> 		return -ENOMEM;
> 
> And in bnxt_alloc_agg_idx(), does the new mask become a no-op when the field
> is 0?
> 
> 	u16 idx = agg_id & (bp->max_tpa_roundup_size - 1);
> 
> That would leave idx as large as 4095 for the test_bit()/__set_bit() calls
> on the 256 bit agg_idx_bmap and for &rxr->rx_tpa[idx] in bnxt_tpa_start().
> 
> BNXT_FLAG_TPA can be set in that state because bnxt_set_rx_skb_mode(), which
> bnxt_xdp_set() calls on XDP detach, adds NETIF_F_LRO to hw_features without
> a BNXT_SUPPORTS_TPA() check:
> 
> 		if (rx > 1) {
> 			bp->flags &= ~BNXT_FLAG_NO_AGG_RINGS;
> 			bp->dev->hw_features |= NETIF_F_LRO;
> 		}
> 
> Would setting bp->max_tpa_roundup_size next to every bp->max_tpa assignment
> keep the two in sync?

OK, this is real and I will fix this in the v3.

> > @@ -4554,7 +4559,7 @@ static int bnxt_alloc_one_tpa_info_data(struct bnxt *bp,
> >  	u8 *data;
> >  	int i;
> >  
> > -	for (i = 0; i < bp->max_tpa; i++) {
> > +	for (i = 0; i < bp->max_tpa_roundup_size; i++) {
> >  		data = __bnxt_alloc_rx_frag(bp, &mapping, rxr,
> >  					    GFP_KERNEL);
> >  		if (!data)
> 
> [Severity: High]
> 
> This is a pre-existing issue, but this loop now performs up to twice as many
> GFP_KERNEL allocations, and the queue restart caller ignores the -ENOMEM
> that follows the quoted check, in bnxt_queue_mem_alloc():
> 
> 	if (bp->flags & BNXT_FLAG_TPA)
> 		bnxt_alloc_one_tpa_info_data(bp, clone);
> 
> 	return 0;
> 
> The open path checks the same call, so is the missing check here
> intentional?
> 
> If the first __bnxt_alloc_rx_frag() fails, the remaining rxr->rx_tpa[i]
> entries keep data == NULL and mapping == 0, and bnxt_queue_start() installs
> the array into the live ring:
> 
> 	rxr->rx_tpa = clone->rx_tpa;
> 	rxr->rx_tpa_idx_map = clone->rx_tpa_idx_map;
> 
> Does bnxt_tpa_start() then post a zero DMA address to the device and a NULL
> buffer into the software ring for such an entry?
> 
> 	prod_rx_buf->data = tpa_info->data;
> 	prod_rx_buf->data_ptr = tpa_info->data_ptr;
> 
> 	mapping = tpa_info->mapping;
> 	prod_rx_buf->mapping = mapping;
> 	...
> 	prod_bd->rx_bd_haddr = cpu_to_le64(mapping);
> 
> When that descriptor completes, bnxt_rx_pkt() uses rx_buf->data without a
> NULL check.

This seems like it is real, but also not related to this patch and this would
needs its own fixes, so I don't think it is worth wrapping that into the
proposed bugfix.
