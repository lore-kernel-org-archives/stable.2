Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F88372EF6
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687655; cv=none; b=uXWbYciiK0R4hNYWGvIphqLzmYZ8HR4PII68Hc9/AeDMYrCTWsf9Mo9Xwl9cVgQ/lNOsI9qFf4/eRH/xm8okuO9lbFD1GUQblBRs8yQ3CiSZAXTXwBAL5AuwKrw+XqygzMNNfS11RXakekb81IcboKmGWiVvWVuOI04Kayp82Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687655; c=relaxed/simple;
	bh=y1f/YWG4aeU3TBXMa+0PbPF2K0h6rQc77aeNVXSbVF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU/zY/O1qC4my/tzJzZ/lp1SgSqWPjW1acG3LdwXZNn5IJ/3aWHIPgX3VMK86QK5sHvbbckB2SeKm+bsfUnXArHVZv5T1F143t/pily3YNunBKT/k64vMa0hSlgxI3ZaLdPcyrvClfWOos2TIOytrjvNGhfOGvBbdYJ9myHC7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMy0SHZT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMy0SHZT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9b1db4964so23205ad.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782687651; x=1783292451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eYEj0yKZwB/DJtVSwa2XkeCzAfCYSyeO+hU4UeJV7oU=;
        b=YMy0SHZT+NDbdBIj/Ch+c3ufj2cNSkJV8m+gnFWUebMRSFDj1u6X8TwY7HVvs6Ml8N
         +eqf/bkjFQ6hVVuTY79RWyIsFZraSwKcVdqqRvQsSHtpd4/tbv26koS0Kw04xb/nbe+Y
         VGBqIC45W2k5yBEYvK92+o4HKP7kYS/xA3iYZnAGeEiP8EU8F8XH0JJzk8/IRrv9ZrTW
         iJ3+miDOjKmBmhV9n7SucFBAbV26gUbxEIfZRvaEjY8/e6hVVR39fEDT7rv2voabtgxQ
         gthnhbaONyqUuAqDPyVY34e7Ot1At37JQUyJfmHCa/voygDZl+qMIQQTCKmC7Iyiq0wt
         e+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782687651; x=1783292451;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eYEj0yKZwB/DJtVSwa2XkeCzAfCYSyeO+hU4UeJV7oU=;
        b=TtPC8V0iks3dNP632MQg5awjF4wG4ap4ggbvmU4efIdI5UkqOjGx41C/N8u36BGbz0
         xqjwOuLQD/IpG1NVZoU10n4IauyTe/q8S5H47YsL5Zh2IAJyrCpSq5HwMLi0mwxL85bJ
         rVCKWuVhq7F6WZtLaq+nhqcGv3hpZkf/Muv2DSaEdVUFXvt1rYv0ldJgPsk7RgRW02yQ
         UqKRJbhv8s1iZCgGICdzmTpkjBbsu8SJIzBoDifRdxRIPSgnuUIPgH7EUtkcuJk8bK68
         IGFRNjvlbnMgY6+UBMmYbfXIhnsL60Ayh3T6dGTrAQm0gXiBjQK0twihxZ4uT3gUQoqz
         RVRA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5S6uVeGUA9NoEDMzBGaCRvhhMViDcOGa4OoyVUb4TsrLavgVNez0v36KUsdvY/YOMarXQALc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNry4PxTJQZDfzDNRRJt/KBw1i2rykr9++cw7uwNe9+WwAPQno
	AXCkzb4MSdfgE4Bh5Ed+4n9uVEzfias8/fEWHQJuMtdC/IwNNlhyFXIaOhv1GCKKnw==
X-Gm-Gg: AfdE7ckEL6JLC5OyGabx2TpunLcE/zFCuY5799sdDco0+wqzUvDYL8iYqk7dFQDL5xY
	vZFpZ+InU6oKdKaulsnRn6SgFzY4kYIcds9oGjd35IVAsT6nyVCr22Sg6DdWJJ2RHuMH++QO9Nr
	U/NXoDilbzeNIlv4FmNFP/ekvqSQilTHmMLAkEKpFh2WKAurL5bj2lO2Y96VYgJ9BANmyzdjtTF
	OPVgzG40FTG/XNeem0dUClGE+k5r7IqHX1156GY9U0lg3U75A9il69E0XLr6nfKEEZ4Y7rndVOp
	78tGk9+ueNcpHe6nUf+dUaAHsQRjTQ9OslDKSdmQ2rm+7D9zPb0l7saaxU5OxZtS/IDyZuzqK4U
	w6WRTH3OWnvDa2HEQ8IyY5rTc6iLGPt+aoWisOGoZ/xVA3zNkSNc8KKPRPus+KRGCklLdcJCgyL
	JJ+5fLx3Qdc2tqJc0gqd1j0ut1u0fQdWQxtcZ9D+CeO8FDeYY=
X-Received: by 2002:a17:902:cecd:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2c9ae676218mr2550725ad.13.1782687650355;
        Sun, 28 Jun 2026 16:00:50 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9878aca91sm41025365ad.79.2026.06.28.16.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 16:00:49 -0700 (PDT)
Date: Sun, 28 Jun 2026 23:00:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 1/7] iommu/arm-smmu-v3: Add
 arm_smmu_kdump_adopt_strtab() for kdump
Message-ID: <akGnm_dzvoapjwoI@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <f3d1f938a9b4d540f67d9c1ff394bd62735a4f5c.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3d1f938a9b4d540f67d9c1ff394bd62735a4f5c.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:18AM -0700, Nicolin Chen wrote:

Hi Nicolin,
> When transitioning to a kdump kernel, the primary kernel might have crashed
> while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> and setting the Global Bypass Attribute (GBPA) to ABORT.
> 
> In a kdump scenario, this aggressive reset is highly destructive:
> a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
>    PCIe AER or SErrors that may panic the kdump kernel
> b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
>    the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.
> 
> To safely absorb in-flight DMAs, a kdump kernel will have to leave SMMUEN=1
> intact and avoid modifying STRTAB_BASE, allowing HW to continue translating
> in-flight DMAs reusing the crashed kernel's page tables until the endpoint
> device drivers probe and quiesce their respective hardware.
> 
> However, the ARM SMMUv3 architecture specification states that updating the
> SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.
> 
> This leaves a kdump kernel no choice but to adopt the stream table from the
> crashed kernel.
> 
> Introduce ARM_SMMU_OPT_KDUMP_ADOPT and adopt functions memremapping all the
> stream tables extracted from STRTAB_BASE and STRTAB_BASE_CFG.
> 
> Note that the adoption of the crashed kernel's stream table follows certain
> strict rules, since the old stream table might be compromised. Thus, apply
> some basic validations against the values read from the registers. If tests
> fail, it means the stream table cannot be trusted, so toss it entirely. To
> avoid OOM due to a potentially corrupted stream table, the memremap for l2
> tables is done on the kdump kernel's demand.
> 
> The new option will be set in a following change.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 254 +++++++++++++++++++-
>  2 files changed, 252 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index ef42df4753ec4..cd60b692c3901 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -861,6 +861,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
>  #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
>  #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
> +#define ARM_SMMU_OPT_KDUMP_ADOPT	(1 << 5)
>  	u32				options;
>  
>  	struct arm_smmu_cmdq		cmdq;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e8d7dbe495f03..aa6837a5daa88 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2040,16 +2040,70 @@ static void arm_smmu_init_initial_stes(struct arm_smmu_ste *strtab,
>  	}
>  }
>  
> +static int arm_smmu_kdump_adopt_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
> +					  phys_addr_t base, u32 span,
> +					  struct arm_smmu_strtab_l2 **l2table)
> +{
> +	struct arm_smmu_strtab_l2 *table;
> +	size_t size;
> +
> +	/*
> +	 * Only a coherent SMMU is supported at this moment. For a non-coherent
> +	 * SMMU that wants to support ARM_SMMU_OPT_KDUMP_ADOPT, try MEMREMAP_WC.
> +	 */
> +	if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_COHERENCY)))
> +		return -EOPNOTSUPP;

We already checked this in arm_smmu_kdump_adopt_strtab_2lvl() can it
change since?

> +
> +	/*
> +	 * Retest the span in case the L1 descriptor has been overwritten since
> +	 * the adopt. Reject this master's insert; panic or SMMU-disable would
> +	 * either lose the vmcore or cascade aborts. Do not try to fix it, as it
> +	 * would break all other SIDs in the same bus (PCI case). The corruption
> +	 * blast radius is already bounded to that bus range.
> +	 */
> +	if (span != STRTAB_SPLIT + 1) {
> +		dev_err(smmu->dev,
> +			"kdump: L1[%u] span %u changed since adopt (was %u)\n",
> +			arm_smmu_strtab_l1_idx(sid), span, STRTAB_SPLIT + 1);
> +		return -EINVAL;
> +	}
> +
> +	size = (1UL << (span - 1)) * sizeof(struct arm_smmu_ste);
> +
> +	table = devm_memremap(smmu->dev, base, size, MEMREMAP_WB);

Why do we use devm_memremap() here but memremap() in the rest of the
functions (even for the L1 ptr)?

> +	if (IS_ERR(table)) {
> +		dev_err(smmu->dev,
> +			"kdump: failed to adopt l2 stream table for SID %u\n",
> +			sid);
> +		return PTR_ERR(table);
> +	}
> +
> +	*l2table = table;
> +	return 0;
> +}
> +
>  static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>  {
>  	dma_addr_t l2ptr_dma;
>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>  	struct arm_smmu_strtab_l2 **l2table;
> +	u32 l1_idx = arm_smmu_strtab_l1_idx(sid);
>  
> -	l2table = &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)];
> +	l2table = &cfg->l2.l2ptrs[l1_idx];
>  	if (*l2table)
>  		return 0;
>  
> +	/* Deferred adoption of the crashed kernel's L2 table */
> +	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
> +		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[l1_idx].l2ptr);
> +		phys_addr_t base = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
> +		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
> +
> +		if (span && base)
> +			return arm_smmu_kdump_adopt_l2_strtab(smmu, sid, base,
> +							      span, l2table);
> +	}
> +
>  	*l2table = dmam_alloc_coherent(smmu->dev, sizeof(**l2table),
>  				       &l2ptr_dma, GFP_KERNEL);
>  	if (!*l2table) {
> @@ -2061,8 +2115,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>  
>  	arm_smmu_init_initial_stes((*l2table)->stes,
>  				   ARRAY_SIZE((*l2table)->stes));
> -	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)],
> -				      l2ptr_dma);
> +	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[l1_idx], l2ptr_dma);
>  	return 0;
>  }
>  
> @@ -4556,10 +4609,204 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> +static int arm_smmu_kdump_adopt_strtab_2lvl(struct arm_smmu_device *smmu,
> +					    u32 cfg_reg, phys_addr_t base)
> +{
> +	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
> +	u32 split = FIELD_GET(STRTAB_BASE_CFG_SPLIT, cfg_reg);
> +	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +	u32 num_l1_ents;
> +	size_t size;
> +	int i;
> +
> +	/*
> +	 * Only a coherent SMMU is supported at this moment. For a non-coherent
> +	 * SMMU that wants to support ARM_SMMU_OPT_KDUMP_ADOPT, try MEMREMAP_WC.
> +	 */
> +	if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_COHERENCY)))
> +		return -EOPNOTSUPP;
> +
> +	if (log2size < split || log2size > smmu->sid_bits) {
> +		dev_err(smmu->dev, "kdump: log2size %u out of range [%u, %u]\n",
> +			log2size, split, smmu->sid_bits);
> +		return -EINVAL;
> +	}
> +	if (split != STRTAB_SPLIT) {
> +		dev_err(smmu->dev,
> +			"kdump: unsupported STRTAB_SPLIT %u (expected %u)\n",
> +			split, STRTAB_SPLIT);
> +		return -EINVAL;
> +	}
> +
> +	num_l1_ents = 1U << (log2size - split);
> +	if (num_l1_ents > STRTAB_MAX_L1_ENTRIES) {
> +		dev_err(smmu->dev, "kdump: l1 entries %u exceeds max %u\n",
> +			num_l1_ents, STRTAB_MAX_L1_ENTRIES);
> +		return -EINVAL;
> +	}
> +
> +	cfg->l2.num_l1_ents = num_l1_ents;
> +
> +	size = num_l1_ents * sizeof(struct arm_smmu_strtab_l1);
> +	cfg->l2.l1tab = memremap(base, size, MEMREMAP_WB);
> +	if (!cfg->l2.l1tab)
> +		return -ENOMEM;

Same here (as below, sorry reviewing it as the code flows), we should
populate cfg->l2.l1_dma here to be consistent.

> +
> +	cfg->l2.l2ptrs =
> +		kcalloc(num_l1_ents, sizeof(*cfg->l2.l2ptrs), GFP_KERNEL);
> +	if (!cfg->l2.l2ptrs)
> +		return -ENOMEM;

We shuold ummap cfg->l2.l1tab before returning -ENOMEM here

> +
> +	for (i = 0; i < num_l1_ents; i++) {
> +		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
> +		phys_addr_t l2_base = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
> +		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
> +
> +		if (!span || !l2_base)
> +			continue;
> +
> +		if (span != STRTAB_SPLIT + 1) {
> +			dev_err(smmu->dev,
> +				"kdump: L1[%u] unsupported span %u (vs %u)\n",
> +				i, span, STRTAB_SPLIT + 1);
> +			return -EINVAL;

We leak kcalloc'd mem (l2.l2ptrs) here, also we should unmap cfg->l2.l1tab

> +		}
> +
> +		/*
> +		 * If the crashed kernel's l1 descriptors are deeply corrupted,
> +		 * blindly memremapping every l2 table here could lead to OOM.
> +		 *
> +		 * Defer the l2 memremap to arm_smmu_init_l2_strtab(), so peak
> +		 * memory is bounded by the kdump kernel's actual demand.
> +		 */
> +	}
> +
> +	return 0;
> +}
> +
> +static int arm_smmu_kdump_adopt_strtab_linear(struct arm_smmu_device *smmu,
> +					      u32 cfg_reg, phys_addr_t base)
> +{
> +	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
> +	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +	unsigned int max_log2size;
> +	size_t size;
> +
> +	/*
> +	 * Only a coherent SMMU is supported at this moment. For a non-coherent
> +	 * SMMU that wants to support ARM_SMMU_OPT_KDUMP_ADOPT, try MEMREMAP_WC.
> +	 */
> +	if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_COHERENCY)))
> +		return -EOPNOTSUPP;
> +
> +	/* Cap the size at what the kdump kernel itself would have allocated */
> +	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
> +		max_log2size =
> +			ilog2(STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES);

Looks like we'd never hit this if condition because we'd never support a
"linear" strtab if the HW supports ARM_SMMU_FEAT_2_LVL_STRTAB. Please
see arm_smmu_init_strtab:

static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
{
	int ret;

	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
		ret = arm_smmu_init_strtab_2lvl(smmu);
	else
		ret = arm_smmu_init_strtab_linear(smmu);
	if (ret)
		return ret;

	ida_init(&smmu->vmid_map);

	return 0;
}

> +	else
> +		max_log2size = smmu->sid_bits;
> +
> +	/* cfg->linear.num_ents is unsigned int, so cap log2size at 31 */
> +	max_log2size = min(max_log2size, 31U);
> +	if (log2size > max_log2size) {
> +		dev_err(smmu->dev, "kdump: unsupported log2size %u (> %u)\n",
> +			log2size, max_log2size);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * We might end up with a num_ents != sid_bits, which is fine. In the
> +	 * ARM_SMMU_OPT_KDUMP_ADOPT case, arm_smmu_write_strtab() is bypassed.
> +	 */
> +	cfg->linear.num_ents = 1U << log2size;
> +
> +	size = cfg->linear.num_ents * sizeof(struct arm_smmu_ste);
> +	cfg->linear.table = memremap(base, size, MEMREMAP_WB);
> +	if (!cfg->linear.table)
> +		return -ENOMEM;

We seem to skips initializing cfg->linear.ste_dma (it is populated in
arm_smmu_init_strtab_linear)

While the comment notes that arm_smmu_write_strtab() is bypassed in the
kdump case, leaving cfg->linear.ste_dma uninitialized seems like a 
ticking time bomb if any other part of the driver ever uses it.

> +	return 0;
> +}
> +
> +static void arm_smmu_kdump_adopt_cleanup(void *data)
> +{
> +	struct arm_smmu_device *smmu = data;
> +	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);

I'm worried about reading the HW register here, since this is a devres action, it
can run after arm_smmu_device_remove() or arm_smmu_device_shutdown()
(which would call rpm_put()). Please see __device_release_driver[1]:

	pm_runtime_put_sync(dev); <--- HW turned off

	device_remove(dev);

	if (dev->bus && dev->bus->dma_cleanup)
		dev->bus->dma_cleanup(dev);

	device_unbind_cleanup(dev); <--- This is where devm_release runs
	device_links_driver_cleanup(dev);

Thus, even if we call rpm_get() here it would make no sense as the 
register contents would've been lost. Can we rely on some SW state
here? smmu->features & 2LVL or maybe add an fmt in cfg? 

> +	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
> +
> +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> +		kfree(cfg->l2.l2ptrs);
> +		if (cfg->l2.l1tab)
> +			memunmap(cfg->l2.l1tab);
> +	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
> +		if (cfg->linear.table)
> +			memunmap(cfg->linear.table);
> +	}
> +}
> +
> +static int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
> +{
> +	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
> +	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
> +	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
> +	phys_addr_t base = base_reg & STRTAB_BASE_ADDR_MASK;
> +	int ret;
> +
> +	dev_info(smmu->dev, "kdump: adopting crashed kernel's stream table\n");

Nit: Should this be dev_info? If everything goes right, the user doesn't
need to know. dev_dbg seems more appropriate. It should only be a warn or 
err if adoption fails (which is in place).

> +
> +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> +		/*
> +		 * Both kernels run on the same hardware, so it's impossible for
> +		 * kdump kernel to see the support for linear stream table only.
> +		 */
> +		if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)))
> +			ret = -EINVAL;
> +		else
> +			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
> +							       base);
> +	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
> +		/*
> +		 * In case that the old kernel for some reason used the linear

Nit: This sounds a little judgemental, what if the HW only supports
linear table? Let's drop the "for some reason" part.

> +		 * format, enforce the same format to match the adopted table.
> +		 */
> +		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
> +		if (!ret)
> +			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;

IIRC, this should NOT be set if we selected the linear format.
Looking at arm_smmu_init_strtab(), if the HW supports 2-level tables,
the driver unconditionally selects it. What is the expected scenario
where the previous kernel would have allocated a linear table on 2-level
capable hardware? IMO, it is a bug if we see linear fmt with this
feature set. Am I missing something?

> +	} else {
> +		dev_err(smmu->dev, "kdump: invalid STRTAB format %u\n", fmt);
> +		ret = -EINVAL;
> +	}
> +
> +	if (ret) {
> +		arm_smmu_kdump_adopt_cleanup(smmu);
> +		goto err;
> +	}
> +
> +	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
> +				       smmu);
> +	/* devm_add_action_or_reset ran the cleanup upon failure */
> +	if (ret) {
> +		dev_warn(smmu->dev, "kdump: failed to set up cleanup action\n");
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	dev_warn(smmu->dev, "kdump: falling back to full reset\n");
> +	memset(&smmu->strtab_cfg, 0, sizeof(smmu->strtab_cfg));
> +	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
> +	return ret;
> +}
> +
>  static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  
> +	if ((smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
> +	    !arm_smmu_kdump_adopt_strtab(smmu))
> +		goto out;
> +
>  	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
>  		ret = arm_smmu_init_strtab_2lvl(smmu);
>  	else
> @@ -4567,6 +4814,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
>  	if (ret)
>  		return ret;
>  
> +out:
>  	ida_init(&smmu->vmid_map);
>  
>  	return 0;
> -- 
> 2.43.0
> 

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/base/dd.c#L1350
