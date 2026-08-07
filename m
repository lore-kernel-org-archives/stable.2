Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC94B048E;
	Fri,  7 Aug 2026 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082648; cv=none; b=hw4ZlPEG2BOj3cY+Ha5cRmg3SDMl91nqK9e1UJGVVSr7orRAKEH3hCsyHlrA6G7vAjX5JZEwn4PVIYm6bePBto6ftmukqAioGqc5onC6Q0EaoqQKB24mJxwX1D6GY1zi8Y4ZcDUDt+/lvfSJUoMcoPnfTvFhd7dbCPNdxGKImB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082648; c=relaxed/simple;
	bh=IlJZaZ2WZ7o4u45iLCx2MD1wOiRK2yGX2ATcdJ4yBK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srKOb8oGQK+VRfdTJHfsYlhmLu88+82OeNyVNtiUXxdJn2mly/TXqIcH6GW5mAzwD60xwZzsXs3gfSrOYBC9qnwsKkuiNW5b9jT61VkrC/JtDtWsFOQ2aZnWLFYhuDBts7rx29dFpKv6Q/FI1OnML3OKovCxGKXC1/cnikGyLXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=puHPNeY6; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="puHPNeY6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786082637; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=yqA9uEaX/yhIeyV1YZPHnHNbAaZG66dAM7Bq/SvCoOY=;
	b=puHPNeY6nkj1OSx0Co2jeCNd6WiL2AMtIJyrhGNgmCD2m4b285yetMn7OPSPsA/x5UTxVkAzqQHKNyb0QwMwB4MuBFJEFOw2K3FGEfuGDpQcpoqmDYDUUKwt/SLxSYtt+mJH1zwXDLPKzh+Fun5bGNSkfxugUw/Py1CYb/r9lRY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X8VqP35_1786082635;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X8VqP35_1786082635 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Aug 2026 14:03:56 +0800
Date: Fri, 7 Aug 2026 14:03:54 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Hyunwoo Kim <imv4bel@gmail.com>, ljs@kernel.org, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/8] KVM: arm64: Handle VNCR TLB invalidation race
 with vcpu_put() VNCR unmapping
Message-ID: <gtllob7dx4ta36eo2j42gtyefnooyh4la2iw6wwq3dbepefljv@baqgna7cqpwt>
References: <20260806091026.620700-1-maz@kernel.org>
 <20260806091026.620700-6-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806091026.620700-6-maz@kernel.org>

On Thu, Aug 06, 2026 at 10:10:23AM +0800, Marc Zyngier wrote:
> While VNCR TLB invalidation always occurs under the MMU lock,
> vcpu_put() doesn't, while it unmaps the VNCR page.
>
> The problem is that the invalidation evaluates vncr_tlb::cpu to
> decide whether an unmapping needs to take place (cpu != -1) before
> performing it. On the other hand, this_cpu_reset_vncr_fixmap()
> unconditionally unmaps if L1_VNCR_MAPPED is set.
>
> These two obviously can race, with a TOCTOU pattern on the TLBI
> path, and a BUG_ON() on the vcpu_put() path. And the two can end-up
> calling vncr_fixmap(-1), with extra lethal effects.

...

>  static void this_cpu_reset_vncr_fixmap(struct kvm_vcpu *vcpu)
>  {
>  	if (!host_data_test_flag(L1_VNCR_MAPPED))
>  		return;
>
> -	BUG_ON(vcpu->arch.vncr_tlb->cpu != smp_processor_id());
>  	BUG_ON(is_hyp_ctxt(vcpu));
>
> -	clear_fixmap(vncr_fixmap(vcpu->arch.vncr_tlb->cpu));
> -	vcpu->arch.vncr_tlb->cpu = -1;
> +	/*
> +	 * Unconditionally unmap the local VNCR if we have lost the race
> +	 * against a concurrent TLBI. Otherwise we could end-up running
> +	 * another vcpu with VNCR still mapped if the TLBI thread is
> +	 * preempted between the exchange and the clear_fixmap().

NICE CATCH.

I thought about the remain changed code path in this patch
and they have MMU lock w/ preemption disabled. This is one
trick racing.

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

> +	 *
> +	 * Note that we do not care about the TLBI nuking the fixmap behind
> +	 * the back of an running vcpu. This will only generate a fault and
> +	 * possibly a retranslation.
> +	 */
> +	if (unmap_l1_vncr(vcpu->arch.vncr_tlb) == -1)
> +		clear_fixmap(vncr_fixmap(smp_processor_id()));
>  	host_data_clear_flag(L1_VNCR_MAPPED);
>  }
>
> @@ -995,8 +1019,7 @@ u16 get_asid_by_regime(struct kvm_vcpu *vcpu, enum trans_regime regime)
>  static void invalidate_vncr(struct vncr_tlb *vt)
>  {
>  	vt->valid = false;
> -	if (vt->cpu != -1)
> -		clear_fixmap(vncr_fixmap(vt->cpu));
> +	unmap_l1_vncr(vt);
>  }
>
>  static bool vncr_tlb_intersects(struct vncr_tlb *vt, u64 addr,
> @@ -1452,7 +1475,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
>  		vt->hpa = pfn << PAGE_SHIFT;
>  		vt->hpa_writable = writable;
>  		vt->valid = true;
> -		vt->cpu = -1;
> +		atomic_set(&vt->cpu, -1);
>
>  		kvm_make_request(KVM_REQ_MAP_L1_VNCR_EL2, vcpu);
>  		kvm_release_faultin_page(vcpu->kvm, page, false, vt->wr.pw && vt->hpa_writable);
> @@ -1583,8 +1606,6 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
>  	if (vt->wr.nG && get_asid_by_regime(vcpu, TR_EL20) != vt->wr.asid)
>  		return;
>
> -	vt->cpu = smp_processor_id();
> -
>  	if (vt->hpa_writable && vt->wr.pw && vt->wr.pr)
>  		prot = PAGE_KERNEL;
>  	else if (vt->wr.pr)
> @@ -1599,7 +1620,8 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
>  	 * FIXME: WO doesn't work at all, need POE support in the kernel.
>  	 */
>  	if (pgprot_val(prot) != pgprot_val(PAGE_NONE)) {
> -		__set_fixmap(vncr_fixmap(vt->cpu), vt->hpa, prot);
> +		atomic_set(&vt->cpu, smp_processor_id());
> +		__set_fixmap(vncr_fixmap(atomic_read(&vt->cpu)), vt->hpa, prot);
>  		host_data_set_flag(L1_VNCR_MAPPED);
>  	}
>  }
> --
> 2.47.3
