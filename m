Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930613;
	b=D4f5mtqJ9Ji+hE3z2cce0+dbWKMEgVSxAfDz9P+1M9YPubRSaNfbFrNbAzS/6th2wEkr
	 H33uvHRG19lb0ZGiN+1v+Bf+FJM9SDuOm9pLxRos62OUaXdnRuyebdNZCSx2oMoTBwtxW
	 LfQpOo7dqrnhsOQmDunSCpMqmvmzR6BJvaXf6VrE5BnteUgXrsdj+6tvzuPZHuhGK4ZZA
	 rJ8uZr52TPeLjmCTZ+YUijnneHWo5c5CUI86yTHvq4roVY5DCUXaYyqJmx4d267ZMiCG2
	 mviauyZDGcLgzgfvqFC739wPW9f+kd0piFZfyu8cxMF+W1eOg5uT7fhPPSAkvxyOg1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hss8CMdUJlf/6WFGnheIgi73dz4MTpQCYfKabF+VIfc=;
	b=GXGVMhUf81DYPVyMSCDoOSMREqVI+QoKVPoNUVdRfiWwfLAoVQXyppAeJHNQ1FN7zR0G
	 hOCXTlu9Xe9dkiRD9eeLCpJrNaG9DDb1neuaJnv8nNMqMpfddGW3h9suuac/6QGEpKMD4
	 NwikTxgXNVZA2lQQW6GQAUWfMi/5OIcQyRP6206CApiuEHnueoplq+F7bsJ/fCsEscP+I
	 xPBygQwei0IUI9a72oXEo2sWOIdzLmPoCCZImeDOTWoEMmTRNT5rYl6BMwAgnjA/qnLHR
	 CO6nlnLeI2jVcuka4JDAI8bcnNxFMBvi89ys8KPjlRXZQHaMle13dGEGPLqMLBVliRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASWgsdHw;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3B606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC3B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASWgsdHw
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso49485a12.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 18:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793930612; x=1794535412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hss8CMdUJlf/6WFGnheIgi73dz4MTpQCYfKabF+VIfc=;
        b=ASWgsdHwisTH46fTFqCyya8LlfSIKWbCuiz/7bjc/1cTLVfP0bYx/o6dRA9f4io12h
         hYfQMj6bhQT2HAbi8kuBdc0ixh+/Lz+/CoSrjMzExKYiLuBROaWUuqqEaeDuPg7lG+qu
         N0lGuQTr7eM/YxnZNnb211fTaC+nMZXkJEcTWM4iH4CEJTp7aCvmDRKrhCfONWA2s5CN
         9v3IvXdTGelAfFmRlTwUKNOZkHGx/kB0TfQ5hXZBC3elKThccoS91WD1t3JORhmjccGw
         XadSyMyBCR5KiD7bPEqsq1a9S12RzD1VVtsg6yIQwv5s4i1rhXmXt0kYGD9/mJGqNTNO
         fxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793930612; x=1794535412;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hss8CMdUJlf/6WFGnheIgi73dz4MTpQCYfKabF+VIfc=;
        b=y4Um8Qz8gym7Iwgtgtc4UKo+0NXMDRKNrP+G8reGTEYwbtZx3DkWQ33g5sdg9PPC+S
         Tk9VX0lrMYB7RYm1FwRN8+wHXDBWO9bOlLP80gHkjStkQMT7Pn9a5LwSGxdUWTkzZH5r
         gKfYr7YccOQDsDnUrn2YCxr2Cx6MmXuzLK0nRku646Z1YjAgY7MhvcYhZFA626/IaWw5
         EpMSbfDvCS9TFrrmT6OnhEYqBe+cNtDvQCi51Ph22yBtikpjJyOpBoMaWucf969oU5il
         gkaWMjm1gBaKHMA7CVdLB8fq2Eqq6ROAlVAg1ZB11ZaH5lLh77Nzfkb/uu6bvxoY9a/d
         oUXA==
X-Forwarded-Encrypted: i=1; AL+hErG60J1E146TiXO42x3wGfSM7LZryzchnKahqX5MLw+Fh4g3P/bHH99Kw5awNNgJBbx7gRZUIpQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8piUZAaZTDrmWlU5XyWGn6QdrdfqNPcqszwngiMYpb7t9LGbog
	O3F9vzXo7zyG95/o3/cbISnSWHPie9zT+oC9T2lEjlR91blanwsW04fz
X-Gm-Gg: AYBFou0Iku4bLrmKMbK8mx07/c881FHTZWqNoZ3uSnQRzhsOSXrS4dmJNBafvpp8lD6
	CdG17YYAyXYU0KSU4ysYuNKMdMbihHOIL+tdOtYV+w4e0vBmXIsTuMMFMKjMWjxXiYRbEBEmVDS
	25hoQEzXqt7pQJT63Knip62HzwCDu7LQRj6XqPPRP0HUUxqS0HNRIk2z5+Il4SHeMfVKaXd8C5n
	b4JzWlG3/SBEaObTSFcUlI1KGujcSdLfshBJzEhdErP4OwG7dQB52vItvFrFo+9EPRNtWs5OBXx
	mWH4iuB328m9ayux41b5yXxFWq52G3WJOGLntM3nKvZh3kWxV4CU1KNaS4hlPdDXhwx9kmOmURX
	Um1hSVS/s1iF0+U3Z4tuBcF+rD2noXV0z1N4ZDaXJM2i+FDJf/LgJU63FO0smVZ/YmcIVUxHSg1
	LpMYnMmtrBTxd7eNYq14BWD6bjviguWEbpMPT5i1QKsgjy//sXMNlCGwUb00YDSlCcUEwr28Xsq
	nV4xxBpSeldszHWPFRQN6kqZmnhQGLf6Qh4v305wEsebaKIZlZC8EI5qxtNhIqY5mOwfrGMofB2
	edvMOYGE4ey3n+9wxmFnHX8Cyw==
X-Received: by 2002:a17:90b:3846:b0:3ab:9f1a:3825 with SMTP id 98e67ed59e1d1-3b0db6218d4mr1002747a91.4.1793930611582;
        Thu, 05 Nov 2026 18:03:31 -0800 (PST)
Received: from localhost ([2001:19f0:8000:3bef:5400:6ff:fef9:667])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32baf86sm5589983a91.17.2026.11.05.18.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 18:03:30 -0800 (PST)
Date: Fri, 6 Nov 2026 10:03:16 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: SeungJu Cheon <suunj1331@gmail.com>, anup@brainfault.org, 
	atish.patra@linux.dev
Cc: tjytimi@163.com, inochiama@gmail.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, andrew.jones@linux.dev, 
	pbonzini@redhat.com, seanjc@google.com, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] KVM: riscv: Only fast-path dirty-log write faults on
 host-writable leaves
Message-ID: <au01Qocxd1gsXs42@inochi.infowork>
References: <20261017030927.345454-1-suunj1331@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017030927.345454-1-suunj1331@gmail.com>

On Sat, Oct 17, 2026 at 12:09:26PM +0900, SeungJu Cheon wrote:
> The dirty-log write fault fast path sets _PAGE_WRITE without checking
> whether the backing page is host-writable. A read fault can install
> a read-only mapping to the shared zero page. A subsequent guest write
> then takes the fast path and writes into the zero page instead of
> going through the slow path to break CoW.
> 
> Use RSW bit 9 to record host writability before dirty logging forces
> the mapping read-only. Preserve this bit across write-protection and
> fall back to the slow path when it is clear.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-174168@kernel.org/
> Fixes: 7705be59eb2d ("KVM: riscv: Fast-path dirty logging write faults")
> Cc: stable@vger.kernel.org # 7.2+
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
> Testing:
> 
> 1. HiFive Premier P550
> 
>    A selftest makes the guest read an untouched page, then write to
>    it with dirty logging enabled. Before the fix, the write corrupts
>    the host zero page. After the fix, CoW allocates a private page
>    and the zero page stays zero.
> 
>    dirty_log_perf_test -v 3 -b 256M -i 3 shows no noticeable
>    regression (14-21s per iteration before and after).
> 
> 2. QEMU (-cpu rv64,h=true)
> 
>    The same selftest reproduces the zero-page corruption before the
>    fix and passes after it.
> 
> This patch applies on top of the Accessed-bit fix [1].
> 
> [1] https://lore.kernel.org/all/20261016101458.221648-1-suunj1331@gmail.com/
> 
>  arch/riscv/include/asm/kvm_gstage.h |  5 ++++-
>  arch/riscv/kvm/gstage.c             |  5 ++++-
>  arch/riscv/kvm/mmu.c                | 15 +++++++++++++--
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
> index aaf080ba1b77..0d19ad6d7dfe 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -35,6 +35,9 @@ extern unsigned long kvm_riscv_gstage_max_pgd_levels;
>  #define kvm_riscv_gstage_pgd_xbits	2
>  #define kvm_riscv_gstage_pgd_size	(1UL << (HGATP_PAGE_SHIFT + kvm_riscv_gstage_pgd_xbits))
>  
> +/* RSW bit 9: the host mapping behind this leaf is writable. */
> +#define KVM_GSTAGE_PTE_HOST_WRITABLE	BIT(9)
> +
>  static inline unsigned long kvm_riscv_gstage_gpa_bits(unsigned long pgd_levels)
>  {
>  	return (HGATP_PAGE_SHIFT +
> @@ -61,7 +64,7 @@ bool kvm_riscv_gstage_try_update_pte(struct kvm_gstage *gstage, u32 level,
>  int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
>  			      struct kvm_mmu_memory_cache *pcache,
>  			      gpa_t gpa, phys_addr_t hpa, unsigned long page_size,
> -			      bool page_rdonly, bool page_exec,
> +			      bool page_rdonly, bool page_exec, bool host_writable,
>  			      struct kvm_gstage_mapping *out_map);
>  
>  bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index be70607a33ea..d9bfd0c6d5fd 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -207,7 +207,7 @@ static void kvm_riscv_gstage_update_pte_prot(struct kvm_gstage *gstage, u32 leve
>  int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
>  			      struct kvm_mmu_memory_cache *pcache,
>  			      gpa_t gpa, phys_addr_t hpa, unsigned long page_size,
> -			      bool page_rdonly, bool page_exec,
> +			      bool page_rdonly, bool page_exec, bool host_writable,
>  			      struct kvm_gstage_mapping *out_map)
>  {
>  	bool found_leaf;
> @@ -246,6 +246,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
>  			prot = PAGE_WRITE;
>  	}
>  
> +	if (host_writable)
> +		prot = __pgprot(pgprot_val(prot) | KVM_GSTAGE_PTE_HOST_WRITABLE);
> +
>  	found_leaf = kvm_riscv_gstage_get_leaf(gstage, gpa, &ptep, &ptep_level);
>  	if (found_leaf) {
>  		/*
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 042d1e3b3547..196cde6c40cd 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -586,6 +586,12 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fast(struct kvm *kvm,
>  			break;
>  		}
>  
> +		/* Let the slow path handle host-side write protection and CoW. */
> +		if (!(pte_val(old_pte) & KVM_GSTAGE_PTE_HOST_WRITABLE)) {
> +			ret = false;
> +			break;
> +		}
> +
>  		if (!dirty_marked) {
>  			mark_page_dirty_in_slot(kvm, memslot, gfn);
>  			dirty_marked = true;
> @@ -630,6 +636,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
>  	bool is_hugetlb;
>  	bool unused = false;
>  	bool writable;
> +	bool host_writable;
>  	unsigned int vma_pageshift;
>  	gfn_t gfn = gpa >> PAGE_SHIFT;
>  	struct vm_area_struct *vma;
> @@ -714,6 +721,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
>  	if (is_error_noslot_pfn(hfn))
>  		return -EFAULT;
>  
> +	host_writable = writable;
> +
>  	/*
>  	 * If logging is active then we allow writable pages only
>  	 * for write faults.
> @@ -739,10 +748,12 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
>  	if (writable) {
>  		mark_page_dirty_in_slot(kvm, memslot, gfn);
>  		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
> -						vma_pagesize, false, true, out_map);
> +						vma_pagesize, false, true, host_writable,
> +						out_map);
>  	} else {
>  		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
> -						vma_pagesize, true, true, out_map);
> +						vma_pagesize, true, true, host_writable,
> +						out_map);
>  	}
>  
>  	if (ret)
> -- 
> 2.52.0
> 

I guess this fix miss a part:

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 53bb25a5a60b..1b35ab980a10 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -761,7 +761,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 
 out_unlock:
 	kvm_release_faultin_page(kvm, page,
-				 unused || (ret && ret != -EEXIST), writable);
+				 unused || (ret && ret != -EEXIST), host_writable);
 	write_unlock(&kvm->mmu_lock);
 	return ret;
 }

Regards,
Inochi
