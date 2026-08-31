Received: from mta0.migadu.com (out-226.mta0.migadu.com [91.218.175.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F837646E
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157871; cv=none; b=UnU+vMfWQngj7o4OEQiV635IlRMykS+bHI8XGu3W0YvQxTk0DtcPtGR0WTwELcykTkEU0wWzu84wgOLDZqX9YMrMyfLxggNpUdLbTaomno+opaw61g6/pDVewegH6RITn/vTHh1QcXXfuvcIRUFc8IzwB3lbm1W3z491aJGD8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157871; c=relaxed/simple;
	bh=8KAnISRXhR5+YkdYI9P7YjmvktPG6VGXMnSy1CkxcSE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mKcXGvPxgROzAlZDs7zxoc7Kk0A7+5FMWtL1KMiI401tzGvsdzty1M+mwi51yHYEOPbLabxtLf5yPBFD4f0SvHv1sDtsbYERilh1dEvzxrI1SA1wYSS0y8vrhuanUieugqG7EO+W8PSwnHALM9dtbsUwRb9kBRt+AqWh0CtdfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=weiSUaaP; arc=none smtp.client-ip=91.218.175.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="weiSUaaP"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8KAnISRXhR5+YkdYI9P7YjmvktPG6VGXMnSy1CkxcSE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788157867; v=1; x=1788762667;
 b=weiSUaaP/K+rC52wvZoVLBPGai23Zo+cTaAzacNnmGb0B1n/Y+hCMu4QRzs80kOIbHdjJYsk
 RBzo0g3XEv6xCjMvM6xMhlHAmdmM1wgj49UnFxtMW2azVxFn0N6A4rFuecFzlr1eNu11QhGWFFC
 Sqs11ZPi5aIxajcYH4ik5cf0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7136dd4160f950d1;
	Mon, 31 Aug 2026 06:30:57 +0000
X-Mizu-Trace-ID: 7136dd4160f950d1
X-Migadu-Flow: FLOW_OUT
Message-ID: <354b192a-52f4-44fb-9034-5df51a92dd3e@linux.dev>
Date: Mon, 31 Aug 2026 14:30:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, zengchi@kylinos.cn, stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Preserve memslot arch flags on
 KVM_MR_FLAGS_ONLY
To: Zeng Chi <zeng_chi911@163.com>, zhaotianrui@loongson.cn,
 maobibo@loongson.cn, chenhuacai@kernel.org
References: <20260828094825.357630-1-zeng_chi911@163.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260828094825.357630-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/28 17:48, Zeng Chi 写道:
> From: Zeng Chi <zengchi@kylinos.cn>
> 
> kvm_arch_prepare_memory_region() computes new->arch.flags, i.e. whether
> a memslot is KVM_MEM_HUGEPAGE_CAPABLE or KVM_MEM_HUGEPAGE_INCAPABLE, only
> for KVM_MR_CREATE and KVM_MR_MOVE, and returns early for every other
> change.  But the generic code allocates a zeroed memslot for every
> change and never copies old->arch, so after a KVM_MR_FLAGS_ONLY update,
> e.g. toggling KVM_MEM_LOG_DIRTY_PAGES for live migration, the active
> memslot has arch.flags == 0.
> 
> With both flags clear, fault_supports_huge_mapping() falls through to
> the alignment check on the HVA range alone, which no longer verifies
> that the GPA and HVA have the same offset within a PMD.  A memslot that
> was marked KVM_MEM_HUGEPAGE_INCAPABLE because of a GPA/HVA offset
> mismatch can then be mapped with PMD entries on read faults, and since
> kvm_map_page() aligns the gfn and the pfn independently, the guest ends
> up accessing the wrong host pages, exactly the "d -> f, e -> g" case
> described in the comment above the check.
> 
> Carry the arch flags over from the old memslot for KVM_MR_FLAGS_ONLY,
> as the GPA, HVA and size are guaranteed to be unchanged for that case.
> 
> Fixes: 7ab6fb505b2a ("LoongArch: KVM: Optimization for memslot hugepage checking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>  arch/loongarch/kvm/mmu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index e104897aa532..4ca7c6ea8f08 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -383,6 +383,16 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm, const struct kvm_memory_slot
>  	hva_t hva_start;
>  	size_t size, gpa_offset, hva_offset;
>  
> +	/*
> +	 * The generic code allocates a fresh, zeroed memslot for every change,
> +	 * so the arch flags computed below must be carried over when only the
> +	 * userspace flags change, e.g. when dirty logging is toggled.
> +	 */
> +	if (change == KVM_MR_FLAGS_ONLY) {
> +		new->arch = old->arch;
> +		return 0;
> +	}
> +
>  	if ((change != KVM_MR_MOVE) && (change != KVM_MR_CREATE))
>  		return 0;
>  	/*

I verified this on a Loongson-3A6000 host with a KVM selftest that uses
a GPA/HVA offset-mismatched memslot and toggles dirty logging: the
unpatched kernel maps the wrong host pages into the guest after the
toggle, and with this patch the mapping stays correct.

Tested-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Tao Cui <cuitao@kylinos.cn>

