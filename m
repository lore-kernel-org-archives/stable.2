Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B13BCD12
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774419; cv=none; b=GVucZzJ3whZFK+GpOBdX7v0UoStjHHWvIZF2l7UYaNziXFNqnkFJopGPXCnuJlenbueeIBbTBNFGNFWM5IoFPsWgAey+MOxQBR151vEJIryO4AaWgzsVXf8rmDIICdkgwgFc60NpviqovoSajhOMpLmw/PBp8gpjsMjYySrJdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774419; c=relaxed/simple;
	bh=4x5tyTCFInq2SceqD6s2qeXR43VKuPf6Tz/2uxsbZYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXuCLY1r9y5wdFMLUqjhuOmvtNAIlYTuC2bZNcl+kmD8N6lnf9nBD7aymTG5+zv3OHk0tmwCXoGE786wI2kWIVhog6G83xM9hnv0YSY/klY4rPSmPDKhpxIjKHYn2uIiVG8rrONTofztgUUlgdZL7oTwi0fhQNIItMRL82qkJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=HYaIRQVt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H2U/cnXW; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HYaIRQVt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2U/cnXW"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 534C87A0773;
	Wed, 30 Sep 2026 09:20:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 30 Sep 2026 09:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790774411; x=1790860811; bh=5O0l5ob037
	v08A7N18/QP0qsd9GVpkGWVWPX/Xjg+aU=; b=HYaIRQVtQVVZoyi08X0/H6bsrk
	RBRkAF7lduCLxk7/5EhrM8duG3IiWJfsxL518cWgANMhWpCEEAExxdULWfsGYZpa
	jhNhQr5x3cd55QzVaagpVtWA48W1+9exHRJI+IYb1vVrme2FVHr8YJocl3PapU7G
	5bAQo4Ys3+RpsKq6SP0t5YZAxj6IC/hu2ujv5H+X1SwX6WUmJOZo073ooTx8jCtL
	997VDxX2zejsWsbqMQ+lmPQtzvPr0HLAi7cf49QmkIJbM+ev7hy1crDOyOLi0G1g
	A4IUX6zVUOjW44zf0LkMCNYz6Ur0Zf/fh/9VsDkWcUFS8sM8OIgQoigKgJ8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790774411; x=1790860811; bh=5O0l5ob037v08A7N18/QP0qsd9GVpkGWVWP
	X/Xjg+aU=; b=H2U/cnXWyE4+U1fNGihoBWymw2rtrhiDRMm0XiURLyzZJuL3dUC
	U7Z/5btOQnOagW64CLtxF5TU3V3FL2I3PrHdb7Q4yhK1iRjUNNaKZHtMVvfubSI8
	vqY+id9ZdLFNL/BdaMf74saHFqPRC8VKl7bcrpE75P3FxFtj5bITV4AKroYlnSvO
	jw8MEvYO688gno6MweV03m7cl1HTXfoqufMleWRvna2qyVMA9SP//bR1aheoO3H+
	GG7JJVNLDb4XxuT4fPHdlgXD2L10S5z4BqRuwScn+Ptp+RTHdL4jB5kCHPKe1dhR
	TCpYc4bgR3BbTXTgUuulFCWo18NVEWWAiYg==
X-ME-Sender: <xms:iwy9ak5N0WwL_o6jAp6sUUrrOWV-gguWxJ78_tWr2cYgne-e5KWJgQ>
    <xme:iwy9anc7KHurlYpcqJ38KBz9uKbDiFi3HxHzF0NoKxIxfIFINHJ14lJVC2x-TGHMc
    7F6cXq37emZElMfMS0yYLZSTZcVqT7DWbJMAU_7q58eW2P_OA>
X-ME-Received: <xmr:iwy9aivSzN8in7JrQ-xM3tUVTnf-54xrM6a3OLEqd60IRVxgyQbWhhxLF8I0-GDeKM8Q2D2pZQJSf8_5JSR5FBPKRBFeG3tOD_HKoMbG3gM>
X-ME-Proxy-Cause: dmFkZTGxwgnoQc/KuwJsq229Z4K+WZBQlom/M5aETAmvpQUZrVfqSiLenVviU4GX3t7Otf
    yEsXuuM7OKKtQXuEAUzv3Z3A1Hq5VK8M51/2w28tXzLoo2cHd175X8e5p7MzcLqm1IMHHT
    mtN+HrTlPKnR8ulxdwFMT5u2yc/GQwtbbFNMdOA+Nwc2MRtohBbqwwdZvEP8CVPB3YlFmy
    zyxvyzUfOr3fRYe3llAYzkkDsWxf2US9TX4naRdDO9XU5lKo1Pger3qDtWw2bBmKHyU4Jr
    OeKZYbx5/SH1aLRVfm8szAKoEFTubizL1oBzFhHOjZJR3Stwf7+4pQPonUCW+dpqEJSyEK
    bLw6+sF+jm4byAfBhP2Ey25hnUXr+vHzzKsjvuWznreQrb8wxzpFRwrPvsJrSX5KqXzlGB
    GGBZEdkeDBHRPELfFXhDlDWzxrjXACjYBssetTBNq1Np34CSks/aNawTfBV+5YdMQcmIad
    E2RmyT1zW0NU5WkD2ca5hUyD8EIonF1kwBVjUVKLFT5tclI+MLseJd3TosyGGvvc2aBaSA
    Aq6o3QlDPL4VllG+vrpv0/xtvlz5SxjmD+TYB9FSRhUsvWyx12YreWYWEcizOvN8W5LP7c
    pVq/MlKnxb431yFWOGlRePDbTSZtTl8ne4hKLauY0NSxOzvq1UAy5shBt5RA
X-ME-Proxy: <xmx:iwy9avnvqoOoY2oumSbsiyR3vI6AbpT-ZRG0133JtrHj373bJADk8A>
    <xmx:iwy9atTwhpR448WcpemSSdyV-p_jhueT5YcsQACRaPgBVW6uQQCYQg>
    <xmx:iwy9atKAracrow5nBP61m5fBuav2szlp-JsTum5Yj1p1zRbFLxjxqQ>
    <xmx:iwy9avGmJKF4uScwsM999TFnFd2v9yCsi5daB-LpeXwGYSF8rFKF9g>
    <xmx:iwy9alvSspzu1gxlDb0P9f_ulAOmr0N7DTC535gWnnWFHNCtA9bcd0lk>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:20:10 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:20:05 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.12.y 5/5] KVM: SEV: Read start/end indices of PSC
 requests exactly once per #VMGEXIT
Message-ID: <2026093000-tug-pedigree-54ec@gregkh>
References: <2026091709-diffusive-reforest-aa65@gregkh>
 <20260917160835.967199-1-sashal@kernel.org>
 <20260917160835.967199-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917160835.967199-5-sashal@kernel.org>

On Thu, Sep 17, 2026 at 12:08:35PM -0400, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit ce6ea7b33e0075335b1eb3b227a21a98e3196e41 ]
> 
> Rework Page State Change (PSC) handling to read the guest-provided start
> and end indices exactly once, at the beginning of the request.  Re-reading
> the indices is "fine", _if_ the guest is well-behaved.  KVM _should_ be
> safe against concurrent guest modification of the indices, but there is
> zero reason to introduce unnecessary risk.
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20260501202250.2115252-14-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-ID: <20260529183549.1104619-14-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kvm/svm/sev.c | 86 +++++++++++++++++++++++-------------------
>  arch/x86/kvm/svm/svm.h |  1 +
>  2 files changed, 49 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 66aab76b8a9c1..4ea8f2287d435 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3724,7 +3724,7 @@ struct psc_buffer {
>  	struct psc_entry entries[];
>  } __packed;
>  
> -static int snp_begin_psc(struct vcpu_svm *svm);
> +static int snp_do_psc(struct vcpu_svm *svm);
>  
>  static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
>  {
> @@ -3757,6 +3757,7 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
>  		guest_psc->entries[idx].cur_page = entry.pagesize ? 512 : 1;
>  	}
>  
> +	sev_es->psc.cur_idx = idx;
>  	guest_psc->hdr.cur_entry = idx;
>  }
>  
> @@ -3772,37 +3773,19 @@ static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
>  	__snp_complete_one_psc(svm);
>  
>  	/* Handle the next range (if any). */
> -	return snp_begin_psc(svm);
> +	return snp_do_psc(svm);
>  }
>  
> -static int snp_begin_psc(struct vcpu_svm *svm)
> +static int snp_do_psc(struct vcpu_svm *svm)
>  {
>  	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
>  	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
>  	struct kvm_vcpu *vcpu = &svm->vcpu;
>  	struct psc_entry entry_start;
> -	u16 idx, idx_start, idx_end, max_nr_entries;
>  	int npages;
>  	bool huge;
>  	u64 gfn;
> -
> -	if (!user_exit_on_hypercall(vcpu->kvm, KVM_HC_MAP_GPA_RANGE)) {
> -		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
> -		return 1;
> -	}
> -
> -	/*
> -	 * GHCB v2 requires the scratch area to reside within the GHCB itself,
> -	 * and PSC requests are only supported for GHCB v2+.  Thus it should be
> -	 * impossible to exceed the max PSC entry count (which is derived from
> -	 * the size of the shared GHCB buffer).
> -	 */
> -	max_nr_entries = (sev_es->ghcb_sa_len - sizeof(struct psc_hdr)) /
> -			 sizeof(struct psc_entry);
> -	if (WARN_ON_ONCE(max_nr_entries > VMGEXIT_PSC_MAX_COUNT)) {
> -		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
> -		return 1;
> -	}
> +	u16 idx;
>  
>  next_range:
>  	/* There should be no other PSCs in-flight at this point. */
> @@ -3811,21 +3794,8 @@ static int snp_begin_psc(struct vcpu_svm *svm)
>  		return 1;
>  	}
>  
> -	/*
> -	 * The PSC descriptor buffer can be modified by a misbehaved guest after
> -	 * validation, so take care to only use validated copies of values used
> -	 * for things like array indexing.
> -	 */
> -	idx_start = READ_ONCE(guest_psc->hdr.cur_entry);
> -	idx_end = READ_ONCE(guest_psc->hdr.end_entry);
> -
> -	if (idx_end >= max_nr_entries) {
> -		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
> -		return 1;
> -	}
> -
>  	/* Find the start of the next range which needs processing. */
> -	for (idx = idx_start; idx <= idx_end; idx++) {
> +	for (idx = sev_es->psc.cur_idx; idx <= sev_es->psc.end_idx; idx++) {
>  		entry_start = READ_ONCE(guest_psc->entries[idx]);
>  
>  		gfn = entry_start.gfn;
> @@ -3862,7 +3832,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
>  		guest_psc->hdr.cur_entry++;
>  	}
>  
> -	if (idx > idx_end) {
> +	if (idx > sev_es->psc.end_idx) {
>  		/* Nothing more to process. */
>  		snp_complete_psc(svm, 0);
>  		return 1;
> @@ -3877,7 +3847,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
>  	 * ranges/operations and can be combined into a single
>  	 * KVM_HC_MAP_GPA_RANGE exit.
>  	 */
> -	while (++idx <= idx_end) {
> +	while (++idx <= sev_es->psc.end_idx) {
>  		struct psc_entry entry = READ_ONCE(guest_psc->entries[idx]);
>  
>  		if (entry.operation != entry_start.operation ||
> @@ -3920,6 +3890,46 @@ static int snp_begin_psc(struct vcpu_svm *svm)
>  	BUG();
>  }
>  
> +static int snp_begin_psc(struct vcpu_svm *svm)
> +{
> +	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
> +	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
> +	u16 max_nr_entries;
> +
> +	if (!user_exit_on_hypercall(svm->vcpu.kvm, KVM_HC_MAP_GPA_RANGE)) {
> +		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
> +		return 1;
> +	}
> +
> +	/*
> +	 * GHCB v2 requires the scratch area to reside within the GHCB itself,
> +	 * and PSC requests are only supported for GHCB v2+.  Thus it should be
> +	 * impossible to exceed the max PSC entry count (which is derived from
> +	 * the size of the shared GHCB buffer).
> +	 */
> +	max_nr_entries = (sev_es->ghcb_sa_len - sizeof(struct psc_hdr)) /
> +			 sizeof(struct psc_entry);
> +	if (WARN_ON_ONCE(max_nr_entries > VMGEXIT_PSC_MAX_COUNT)) {
> +		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
> +		return 1;
> +	}
> +
> +	/*
> +	 * The PSC descriptor buffer can be modified by a misbehaved guest after
> +	 * validation, so take care to only use validated copies of values used
> +	 * for things like array indexing.
> +	 */
> +	sev_es->psc.cur_idx = READ_ONCE(guest_psc->hdr.cur_entry);
> +	sev_es->psc.end_idx = READ_ONCE(guest_psc->hdr.end_entry);
> +
> +	if (sev_es->psc.end_idx >= max_nr_entries) {
> +		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
> +		return 1;
> +	}
> +
> +	return snp_do_psc(svm);
> +}
> +
>  /*
>   * Invoked as part of svm_vcpu_reset() processing of an init event.
>   */
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 912262c7dc8a2..145993b976228 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -233,6 +233,7 @@ struct vcpu_sev_es_state {
>  	/* SNP Page-State-Change buffer entries currently being processed */
>  	struct {
>  		u16 cur_idx;
> +		u16 end_idx;
>  		u16 batch_size;
>  		bool is_2m;
>  	} psc;
> -- 
> 2.53.0
> 
> 

series did not apply
