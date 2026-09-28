Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031824BB5B9
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601369; cv=none; b=skkVv6fIbpcCpJVkcNavqkSlAs5b6Q+S1dAIFfNFLdjaj07+hsF5XEay2FuEty1jomeOdV2pTKZrGhccYinG3+SBRAEPwxXREzgqhxMeO5OmZGdE2fbqYkOim7rSAe8TD6gY44H8/uBlyeOYa+kaZqs+jC+J8CO9XRj/m2/MpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601369; c=relaxed/simple;
	bh=AlzINplvdWYcDFyKAa6hX7eIbM2sW1a9ZtLt9WWLCTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyUhkVm2QKtwlsgWhZkPAOhWiJoZb6js/DzIteUO1ZqwYlN8xA86KBn2rZw2F4AVec/KkI3CNvtMAdgjYOnxN8Pr66qEvcKIz6lAtmn6/Q5Qx6NY/0dQk/J7pQt1UfSTxUjxWbbzI0K+IX0GiYhPqcN08BMtP919ErYXPyf6a2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RM/XkdR4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RM/XkdR4"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b8ea0ca5baso9325e87.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790601365; x=1791206165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zfkmB0S4jeBJLSAu3i4B90N1Mz4e/se/EDU8xgXVyyk=;
        b=RM/XkdR4tOC1kvtl7SJsCWl1DXq7ZsQNmtKsS6Ao1H/Ro1nTdE+F8Cke1FnL7l0gBo
         mfU44dPgT+XEkMgCi9imh1fUcoHF7jfiRdzJBlsDgGa9fMhJ5Yo751JDsScJU/ka2RyM
         haWwf3qcuwwTo/v5Tak8mr9jpg2M7ff37pAaqkqoxE26oIK5FQAopIVsVG92+43RaFuQ
         k+CBm5L68IrDWEn7w24IMkL0hJdeBnO/h9JTu0RBm4+4utxgw8/AdB0z0JwdWPbKwjU2
         Ltk5xcniRxCPOnrYnVSwQvJQgmYsXdyZY4Y0zDU5C8zXuqBHpUSgQ87tOiSfvbFgSDrE
         jQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601365; x=1791206165;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfkmB0S4jeBJLSAu3i4B90N1Mz4e/se/EDU8xgXVyyk=;
        b=aqMDu2yaIcbHeFwzEfbZIkNN5eTjI24IYlIC8KVG88Xm+0Kjtzo0O60OpgD4Qdkx18
         cjBFu2PrcVbJK2n3ZurnbP7gTJ9Nl1zurh/L8pBm/o257LhXTa08SkDpqD3d2MVcH+Y+
         wnJKgT/xfgvuh6NKgaIcC/gbvtVkLJ9z4LASWsNQxDXm6pwJTNDzDrqY9HRKOL2QOSNU
         Olvj39D4bN6mef3ggilkyRb2T1c0besBoGd0k9syes/MDWbbgJsXP/5xzouePNVDBsyU
         fkflGDG6rKblF3xw3daNO21HZG/TGoAJnr06Wj41zmqwEcG/Do0Rxwu3xPL6/BByRdWh
         Nc/A==
X-Forwarded-Encrypted: i=1; AKwUvBxWKhMUNiEDJmjgpo+UvHrRMO+UIbctpiGKBgLOYzrkNuh9hnCzUEIsyL9HboZK1JIPwVNE65c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgkLJr2sgGM7TTVeCy75CwOOrHwipNRM/03SvjleFoZ8PFZCgr
	zjY/FBj7g4scaj7VD5dy8Ce+tmm8XyP8qzCvNh9hosVlqKghgnvyTcVqHnGI7D2Ymw==
X-Gm-Gg: AYBFou31eyOZiN8DT1EgZpAEDySRzxbJLdqr4ji3HgQK42KEpfIee81iJHQuC1GZzMX
	LONaI4C2X1b4UuGEy8nK9TTki6k2Iw5ysJjTgPT/MWtBTRUoZw0wAvibnB4aq0Vff9TNWhJXqCu
	UALVKQT2GIoEyI46aYkbd9qaqryQHnJXwQaN8d5AsUw+fbQhUS1pQf3IuwCNyAt019wPZwjKT9F
	yQZMU9/XMXnPdebdE4Avha84l6WGEqwnDQXh5NhnRylZGNlV2XWAQ2tBokZdioV3xOwlR49lFIv
	3fWInhQp0VgA94/Y2un3tlahZkrGFlsJGHmfaxqux8G3UisWo85fFX1Ax5PLkmk2ulRgXbsd+Qd
	aLVNDowTk42vrzAzFDowM8PpgfIabaiVGpGVYREiFOnj42fMfxmgzlQoRU0QSxpxEPGXdm9cQ89
	an+JANgwXB5fe02Re3uwLl1rY2TDe0/wCU3A2OcYomCnlD089SHOHn2L4Sk8F0Ys72SqGJZ4kfW
	TWuA0nERkcW3eCMiTXuZNXGpm8DB/XoONDq
X-Received: by 2002:ac2:4650:0:b0:5b8:f142:cf3 with SMTP id 2adb3069b0e04-5b8f1420dc7mr79035e87.11.1790601363833;
        Mon, 28 Sep 2026 06:16:03 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a64b580f63sm29712361fa.8.2026.09.28.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:16:03 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:15:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v7 4/9] iommu/arm-smmu-v3: Optimize range invalidation
 for latency
Message-ID: <arpohmaJTPEEI7mi@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <4-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:12PM -0300, Jason Gunthorpe wrote:
> The server IOMMU drivers focus on invalidation latency by default,
> over-invalidating if necessary, to round the invalidation range up to a
> single command. I think this represents a trade off for DMA non-FQ and SVA
> where stalling the operation is overall worse than re-loading the IOTLB.
> 
> For instance AMD and VT-d both round the range up to the largest aligned
> power of two and invalidate that. This causes over-invalidation but that
> is preferred on real HW over trying to issue a number of smaller range
> invalidations.
> 
> SMMUv3 on the other hand will try to do up to 512 single invalidations,
> otherwise falls back to full invalidation, or it will try to issue an
> string of range invalidations for every 5 bits of IOVA range to perfectly
> cover it.
> 
> While the range-invalidation optimization is pretty good we can still do
> better and reduce it to only 2 invalidations at maximum using the idea
> Robin came up with to overlap two range invalidations in the middle. This
> preserves the exact coverage of the current range invalidation and still
> caps the number of range invalidations at 2.
> 
> This works because the range invalidation can start at any IOVA, so we can
> place a range invalidation forwards from the start and backwards from the
> end, overlapping in the middle if the scale isn't precise enough.
> 
> In the cases where this produces 2 range invalidations it continues to
> produce range invalidations that don't overlap, but the exact split point
> is different than the original algorithm due to the new calculation
> method. In cases where the original algorithm would produce 3 or more
> range invalidations this will produce 2 range invalidations with an
> overlap.
> 
> The SVA under invalidation errata work around is maintained by "rounding
> up" to generate a single range invalidation that over-covers the entire
> range.
> 
> Since the normal path is now the only one with a loop, split them into two
> functions and fold a simplified version of arm_smmu_inv_size_too_big()
> directly into the normal flow in a way that directly limits the number of
> single invalidation commands generated, again focusing on controlling
> latency.
> 
> The end result is any gather is converted into either:
>  - One invalidate all
>  - One or two range invalidation operations
>  - At most 512 single invalidation ops
> 
> arm_smmu_domain_inv() is modified to always pass in the tgsz because the
> new logic relies on it being valid.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 372 ++++++++++++--------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  16 +-
>  2 files changed, 238 insertions(+), 150 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index afc0f68728609d..5daebe06556c44 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2460,167 +2460,232 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  	arm_smmu_domain_inv(smmu_domain);
>  }
>  
> -static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
> +/*
> + * Check address alignment for TTL hint per SMMUv3 H.a Section 4.4.1. Address
> + * bits below the alignment must be zero, otherwise UNPREDICTABLE.
> + */
> +static bool arm_smmu_ttl_addr_aligned(u64 address, unsigned int tg,
> +				      unsigned int ttl)
> +{
> +	unsigned int pgsz_lg2 = arm_smmu_pt_level_to_lg2sz(tg, 3 - ttl);
> +
> +	return !(address & GENMASK_U64(pgsz_lg2 - 1, 0));
> +}
> +
> +struct arm_smmu_range_inv {
> +	u64 start_tg;
> +	/* Normal integer, not encoded. 0 means 0.*/
> +	u64 num;
> +	unsigned int scale;
> +};
> +
> +static unsigned int arm_smmu_range_inv_calc_scale(u64 num_tg)
> +{
> +	return fls64((num_tg - 1) / (CMDQ_TLBI_RANGE_NUM_MAX + 1));
> +}
> +
> +static u64 arm_smmu_range_inv_calc_num(u64 num_tg, unsigned int scale)
> +{
> +	return DIV_ROUND_UP_ULL(num_tg, 1ULL << scale);
> +}
> +
> +/*
> + * Initialize the smallest range invalidation covering num_tg and ending at
> + * last_tg.
> + */
> +static struct arm_smmu_range_inv arm_smmu_range_inv_init_end(u64 last_tg,
> +							     u64 num_tg)
> +{
> +	struct arm_smmu_range_inv range_inv = {};
> +
> +	if (!num_tg)
> +		return range_inv;
> +
> +	range_inv.scale = arm_smmu_range_inv_calc_scale(num_tg);
> +	range_inv.num = arm_smmu_range_inv_calc_num(num_tg, range_inv.scale);
> +	range_inv.start_tg = last_tg - ((range_inv.num << range_inv.scale) - 1);
> +	return range_inv;
> +}
> +
> +static void arm_smmu_cmdq_batch_add_range_inv(
> +	struct arm_smmu_device *smmu, struct arm_smmu_cmdq_batch *cmds,
> +	struct arm_smmu_cmd *ref_cmd, bool leaf_only,
> +	const struct arm_smmu_range_inv *range_inv, u8 ttl, u8 tg_enc)
> +{
> +	struct arm_smmu_cmd cmd;
> +	unsigned int tgsz_lg2 = tg_enc * 2 + 10;
> +	u64 iova = range_inv->start_tg << tgsz_lg2;
> +	unsigned int num = range_inv->num - 1;
> +
> +	/* 16K granule TTL=1 is reserved (Section 4.4.1) */
> +	if (WARN_ON(tgsz_lg2 == 14 && ttl == 1))
> +		ttl = 0;
> +
> +	/* Verify address alignment for the TTL hint */
> +	if (ttl && !arm_smmu_ttl_addr_aligned(iova, tgsz_lg2, ttl))
> +		ttl = 0;
> +
> +	/*
> +	 * SMMUv3 H.a Section 4.4.1: TG!=0, NUM==0, SCALE==0, TTL==0 is Reserved
> +	 * and causes CERROR_ILL. Single tg uses NUM=0, SCALE=0 with a TTL hint
> +	 * to target only the exact leaf entry.
> +	 *
> +	 * For a single tg invalidation a 0 TTL can come from places like the
> +	 * SVA path that don't have enough information to get a TTL, or as a
> +	 * side of effect of the splitting.
> +	 *
> +	 * A single-TG invalidation cannot reach this point if it is part of a
> +	 * CONT group, so it is safe to transform it into a single invalidation.
> +	 * The ARM_SMMU_OPT_FULL_CONT_RANGE_INV errata does not apply.
> +	 */
> +	if (!num && !range_inv->scale && !ttl)
> +		tg_enc = 0;
> +
> +	cmd.data[0] = ref_cmd->data[0] | FIELD_PREP(CMDQ_TLBI_0_NUM, num) |
> +		      FIELD_PREP(CMDQ_TLBI_0_SCALE, range_inv->scale);
> +	cmd.data[1] = ref_cmd->data[1] |
> +		      FIELD_PREP(CMDQ_TLBI_1_LEAF, leaf_only) |
> +		      FIELD_PREP(CMDQ_TLBI_1_TTL, ttl) |
> +		      FIELD_PREP(CMDQ_TLBI_1_TG, tg_enc) | iova;
> +	arm_smmu_cmdq_batch_add_cmd_p(smmu, cmds, &cmd);
> +}
> +
> +/*
> + * Issue up to two range TLBI commands covering [iova, iova+size). Returns true
> + * if successful, false if the range is too large to fit into range invalidation
> + * commands.
> + *
> + * Normally the first range invalidation is the largest representable span which
> + * does not exceed the requested range. If necessary, the second range
> + * invalidation is the smallest representable range covering the remainder and
> + * is anchored at the end. Any excess coverage from the second range
> + * invalidation overlaps the first instead of exceeding the requested range.
> + *
> + * If a SVA is being invalidated and the SMMU has the
> + * ARM_SMMU_OPT_FULL_CONT_RANGE_INV errata this produces only a single range
> + * invalidation and overinvalidates to ensure any potential CONT is covered with
> + * a single range invalidation.
> + */
> +static bool arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
>  					  struct arm_smmu_cmdq_batch *cmds,
>  					  struct arm_smmu_cmd *cmd,
>  					  struct arm_smmu_tlbi *tlbi)
>  {
> -	size_t inv_range = tlbi->iopte_size;
> -	unsigned long iova = tlbi->iova;
> -	unsigned long end = iova + tlbi->size;
> -	unsigned long num_pages = 0;
> -	u8 tg = tlbi->tgsz_lg2;
> -	u64 orig_data0 = cmd->data[0];
> -	u8 ttl = 0, tg_enc = 0;
> +	u8 tgsz_lg2 = tlbi->tgsz_lg2;
> +	struct arm_smmu_range_inv first = { .start_tg = tlbi->iova >>
> +							tgsz_lg2 };
> +	u64 last_tg = (tlbi->iova + tlbi->size - 1) >> tgsz_lg2;
> +	u64 num_tg = last_tg - first.start_tg + 1;
> +	u8 tg_enc = (tgsz_lg2 - 10) / 2;
> +	struct arm_smmu_range_inv trail;
> +	u8 ttl = 0;
>  
> -	if (WARN_ON_ONCE(!tlbi->size))
> -		return;
> -
> -	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> -		num_pages = tlbi->size >> tg;
> -
> -		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
> -		tg_enc = (tg - 10) / 2;
> -
> -		/*
> -		 * Determine what level the granule is at. For non-leaf, both
> -		 * io-pgtable and SVA pass a nominal last-level granule because
> -		 * they don't know what level(s) actually apply, so ignore that
> -		 * and leave TTL=0. However for various errata reasons we still
> -		 * want to use a range command, so avoid the SVA corner case
> -		 * where both scale and num could be 0 as well.
> -		 */
> -		if (tlbi->leaf_only)
> -			ttl = 4 - ((ilog2(tlbi->iopte_size) - 3) / (tg - 3));
> -		else if ((num_pages & CMDQ_TLBI_RANGE_NUM_MAX) == 1)
> -			num_pages++;
> -	}
> -
> -	while (iova < end) {
> -		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> -			/*
> -			 * On each iteration of the loop, the range is 5 bits
> -			 * worth of the aligned size remaining.
> -			 * The range in pages is:
> -			 *
> -			 * range = (num_pages & (0x1f << __ffs(num_pages)))
> -			 */
> -			unsigned long scale, num;
> -
> -			/* Determine the power of 2 multiple number of pages */
> -			scale = __ffs(num_pages);
> -
> -			/* Determine how many chunks of 2^scale size we have */
> -			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
> -
> -			/* Keep the pre-DS 5-bit truncation when scale > 31 */
> -			cmd->data[0] = orig_data0 |
> -				FIELD_PREP(CMDQ_TLBI_0_NUM, num - 1) |
> -				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale & 0x1f);
> -
> -			/* range is num * 2^scale * pgsize */
> -			inv_range = num << (scale + tg);
> -
> -			/* Clear out the lower order bits for the next iteration */
> -			num_pages -= num << scale;
> -		}
> -
> -		/*
> -		 * IPA has fewer bits than VA, but they are reserved in the
> -		 * command and something would be very broken if iova had them
> -		 * set.
> -		 */
> -		cmd->data[1] = FIELD_PREP(CMDQ_TLBI_1_LEAF, tlbi->leaf_only) |
> -			       FIELD_PREP(CMDQ_TLBI_1_TTL, ttl) |
> -			       FIELD_PREP(CMDQ_TLBI_1_TG, tg_enc) |
> -			       (iova & ~GENMASK_U64(11, 0));
> -
> -		arm_smmu_cmdq_batch_add_cmd_p(smmu, cmds, cmd);
> -		iova += inv_range;
> -	}
> -}
> -
> -/*
> - * Generate a range invalidation for ARM_SMMU_OPT_FULL_CONT_RANGE_INV by
> - * ensuring the entire SVA requested range is covered with a single range
> - * invalidation command. The scale is adjusted so that the range invalidation
> - * may extend past the end of the requested range. This ensures that any CONT
> - * the MM is invalidating is covered by a single range invalidation. TTL and
> - * LEAF are always 0 because this is only used by SVA.
> - */
> -static bool arm_smmu_cmdq_batch_add_range_inv(struct arm_smmu_device *smmu,
> -					      struct arm_smmu_cmdq_batch *cmds,
> -					      struct arm_smmu_cmd *cmd,
> -					      unsigned long iova, size_t size,
> -					      u8 tgsz_lg2)
> -{
> -	u64 cur_tg = iova >> tgsz_lg2;
> -	u64 num_tg = ((iova + size - 1) >> tgsz_lg2) - cur_tg + 1;
> -	unsigned int scale = fls64((num_tg - 1) / 32);
> -
> -	if (scale > 31)
> -		return false;
> -
> -	cmd->data[0] |=
> -		FIELD_PREP(CMDQ_TLBI_0_NUM,
> -			   DIV_ROUND_UP_ULL(num_tg, 1ULL << scale) - 1) |
> -		FIELD_PREP(CMDQ_TLBI_0_SCALE, scale);
> -	cmd->data[1] = FIELD_PREP(CMDQ_TLBI_1_TG, (tgsz_lg2 - 10) / 2) |
> -		       (cur_tg << tgsz_lg2);
> -	arm_smmu_cmdq_batch_add_cmd_p(smmu, cmds, cmd);
> -	return true;
> -}
> -
> -static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu,
> -				      struct arm_smmu_tlbi *tlbi)
> -{
> -	size_t max_tlbi_ops;
> -
> -	/* 0 size means invalidate all */
> -	if (!tlbi->size || tlbi->size == SIZE_MAX)
> -		return true;
> -
> -	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV)
> +	if (!tlbi->size)
>  		return false;
>  
>  	/*
> -	 * Borrowed from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h,
> -	 * this is used as a threshold to replace "size_opcode" commands with a
> -	 * single "nsize_opcode" command, when SMMU doesn't implement the range
> -	 * invalidation feature, where there can be too many per-granule TLBIs,
> -	 * resulting in a soft lockup.
> +	 * Determine what level the granule is at. For non-leaf, both io-pgtable
> +	 * and SVA pass a nominal last-level granule because they don't know
> +	 * what level(s) actually apply, so leave TTL=0.
>  	 */
> -	max_tlbi_ops = 1 << (ilog2(tlbi->iopte_size) - 3);
> -	return tlbi->size >= max_tlbi_ops * tlbi->iopte_size;
> +	if (tlbi->leaf_only)
> +		ttl = 4 - ((ilog2(tlbi->iopte_size) - 3) / (tgsz_lg2 - 3));
> +
> +	/*
> +	 * The spec defines the invalidated range as:
> +	 *   Range = ((NUM+1) * 2^SCALE) * Translation_Granule_Size
> +	 * NUM is 5 bits, so (NUM+1) covers 1..32 granules. Find the smallest
> +	 * SCALE at which a single command could cover num_tg.
> +	 *
> +	 * Unlike other IOMMUs the spec has no alignment requirement on the
> +	 * address beyond alignment to tg (so long as TTL=0).
> +	 */
> +	first.scale = arm_smmu_range_inv_calc_scale(num_tg);
> +	if (first.scale > 31) {
> +		/* Range too large for a single command do full invalidation */
> +		return false;
> +	}
> +
> +	if (tlbi->has_cont &&
> +	    (smmu->options & ARM_SMMU_OPT_FULL_CONT_RANGE_INV)) {
> +		/*
> +		 * Produce a single invalidation by rounding up and disabling
> +		 * the trailer.
> +		 */
> +		first.num = arm_smmu_range_inv_calc_num(num_tg, first.scale);
> +		trail.num = 0;
> +	} else {
> +		/*
> +		 * Produce two invalidations by rounding down and adding a
> +		 * second trailing range invalidation anchored at the end.
> +		 */
> +		first.num = num_tg >> first.scale;
> +		trail = arm_smmu_range_inv_init_end(
> +			last_tg, num_tg - ((u64)first.num << first.scale));
> +	}
> +	arm_smmu_cmdq_batch_add_range_inv(smmu, cmds, cmd, tlbi->leaf_only,
> +					  &first, ttl, tg_enc);
> +
> +	if (trail.num)
> +		arm_smmu_cmdq_batch_add_range_inv(
> +			smmu, cmds, cmd, tlbi->leaf_only, &trail, ttl, tg_enc);
> +	return true;
>  }
>  
> -/* Used by non INV_TYPE_ATS* invalidations */
> -static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
> +/*
> + * One TLBI command per IOTLB entry, assuming the entries are all at least
> + * iopte_granule sized. Returns false if too many commands would be needed which
> + * indicates too high a latency. The threshold is similar to MAX_DVM_OPS in
> + * arch/arm64/include/asm/tlbflush.h for the 4k PAGE_SIZE.
> + */
> +static bool arm_smmu_cmdq_batch_add_single(struct arm_smmu_device *smmu,
> +					   struct arm_smmu_cmdq_batch *cmds,
> +					   struct arm_smmu_cmd *cmd,
> +					   struct arm_smmu_tlbi *tlbi)
> +{
> +	unsigned long num_ops = tlbi->size / tlbi->iopte_size;
> +	unsigned long iova = tlbi->iova;
> +	unsigned long i;
> +
> +	if (!num_ops || num_ops > 512)
> +		return false;
> +

Should this be ">= 512"? The old arm_smmu_inv_size_too_big() and
arm64's __flush_tlb_range_limit_excess() both fall back to a full
invalidation at exactly 512:

        return pages >= (MAX_DVM_OPS * stride) >> PAGE_SHIFT;

512 is what a walk flush could generate. For example, when 
__arm_lpae_unmap() frees a last-level table on a 4K granule,
it calls io_pgtable_tlb_flush_walk(iova, SZ_2M, SZ_4K), hence,
num_ops == 512.

Before this patch that was a single TLBI_NH_ASID/TLBI_S12_VMALL, now
it becomes 512 VA TLBIs + CMD_SYNC for every 2M table freed on a
non-RIL SMMU. The same check carries into arm_smmu_tlbi_calc_single()
later in the series.

> +	for (i = 0; i < num_ops; i++) {
> +		cmd->data[1] = FIELD_PREP(CMDQ_TLBI_1_LEAF, tlbi->leaf_only) |
> +			       (iova & ~GENMASK_U64(11, 0));
> +		arm_smmu_cmdq_batch_add_cmd_p(smmu, cmds, cmd);
> +		iova += tlbi->iopte_size;
> +	}
> +	return true;
> +}
> +

With that addressed:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
