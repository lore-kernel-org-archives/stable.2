Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322799;
	b=1kgXhYUiiIJVqv7ZU78hvo6lQ6ApFAi/oqwYMaBoxFADKGl/7N8whiFirkQH7XBDZ3sF
	 cLDirDTOK1Ep0D1uhaoH7gZ6V1gnyEkC/PKJrOW8XDNzaIY0XjezQAiLsLDbn1yP/69j9
	 95Kw4D7h/0EHhQIT3DAo2NMn8Cl3YcQ6/ZDpA2vC5iVcJlE8TkrSgskSGrjAUbfoleMbi
	 1oei8ZAHW4v4VQI17tgylGn7Xl4OhdSyel/OnDfakbz4XfGtnkDRI3GjBEOu83CsHH5iD
	 iibCJSGtRq8GwuiZkPdVhESkKZ9isJSxULXibon4Jw9xGed9yPKVa2U5OB/6bMvYMQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322799;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hWy96pV9U6nh6faH0REJ6R8O8F8tMtOw8PWh9LX2R3I=;
	b=xJZvU4ZuWc+CjKMdbuC1s2D1JFSr/bZjx3LsZG+CQ0P2e6H5zOkPPTMwN/XXgbJoO9gw
	 8TVIMwEz1f7BoxOQb1M8Bbtn2MSEhMe0/q2HIq7mSb9BGFVHTvckSmVekWyCbCCnNrzdK
	 6PRWUFA9Rurnptn/NZRQVBYCQsnWy7v5MlARyoidfE7rZEFtvAEoV8K1u/MLsu3yDAsbp
	 WQ7F4TnbRJ0G9b8WdNJbTskdQcs8M6cjywqyq2wSZYlZ+19j1K1TIQy9B36YAkGoqqIDc
	 VXdpfjjintgLOGyO3t6kilAw/XWR5szFxgkF3P/vHNkmE2D5yl0z1gMhaOIvZQiUjgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ighiQjLr;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339E606A32A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 01:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2339E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ighiQjLr
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 194B41FC7;
	Thu, 29 Oct 2026 18:13:13 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42D8C3F7B4;
	Thu, 29 Oct 2026 18:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793322796; bh=/O1MlUidvn8myAgzejSuGI0XnhY3wORZf1yXNm2FiTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ighiQjLrwI7oYz1ieGEtJ+aGjHwlBQLuh93oENUgOPEkVwyuIeyNQXchfmGzH/+8T
	 H9kjC/8oEH/fRhoRcjqNWtHqNQu0rN4WBEUHeaDYnaQt4cqPuScv8uF8HV/9nZh/E2
	 8IW69T16XF3NrNX845VqpG5NV7CWGsQTO7R+j59Q=
Date: Fri, 30 Oct 2026 01:13:05 +0000
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Fuad Tabba <fuad.tabba@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH v3 5/5] KVM: arm64: nv: Correctly compute the effective
 TCR_EL1 for nVHE TCR_EL2
Message-ID: <jwc3vjqx2tw4cirgddkcdeon56fuefbge4u3mza3pmevix5xzl@svr26kj3okgb>
References: <20261029223732.103785-1-oupton@kernel.org>
 <20261029223732.103785-6-oupton@kernel.org>
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
In-Reply-To: <20261029223732.103785-6-oupton@kernel.org>

On Thu, Oct 29, 2026 at 03:37:32PM -0700, Oliver Upton wrote:
> It would appear that nVHE hypervisor support has a few warts which
> shouldn't come as a surprise. Several fields in TCR_EL2 for features
> supported in the VM (TCR_EL2.HA for example) are not correctly
> propagated to the effective value of TCR_EL1.
> 
> Forward fields in bulk from nVHE TCR_EL2 to the effective TCR_EL1,
> relying on config-based sanitisation to enforce the RESx behavior of
> unsupported features. Deal with the slightly annoying case where the
> E2H==0 bitfield names are not annotated by TTBR like they are in E2H==1.
> 
> Cc: stable@vger.kernel.org # v6.18+
> Fixes: d5bbb76f4474 ("KVM: arm64: nv: Expose hardware access flag management to NV guests")
> Fixes: 3606e0b2e462 ("KVM: arm64: nv: Add non-VHE-EL2->EL1 translation helpers")
> Signed-off-by: Oliver Upton <oupton@kernel.org>

Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>

> ---
>  arch/arm64/include/asm/kvm_nested.h | 38 ++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 0f899addafa8..27ec73da02c6 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -20,16 +20,36 @@ static inline u64 tcr_el2_ps_to_tcr_el1_ips(u64 tcr_el2)
>  	return (u64)FIELD_GET(TCR_EL2_PS_MASK, tcr_el2) << TCR_IPS_SHIFT;
>  }
>  
> -static inline u64 translate_tcr_el2_to_tcr_el1(u64 tcr)
> +#define __xlate_tcr_nvhe_to_vhe(nfld, vfld, nvhe, vhe)				\
> +	FIELD_MODIFY(VHE_TCR_EL2_##vfld, vhe, FIELD_GET(TCR_EL2_##nfld, *(nvhe)))
> +
> +#define __xlate_tcr_nvhe_to_vhe_field(fld, nvhe, vhe)				\
> +	__xlate_tcr_nvhe_to_vhe(fld, fld, nvhe, vhe)
> +
> +static inline u64 translate_tcr_el2_to_tcr_el1(u64 nvhe)
>  {
> -	return TCR_EPD1_MASK |				/* disable TTBR1_EL1 */
> -	       ((tcr & TCR_EL2_DS) ? TCR_DS : 0) |
> -	       ((tcr & TCR_EL2_TBI) ? TCR_TBI0 : 0) |
> -	       tcr_el2_ps_to_tcr_el1_ips(tcr) |
> -	       (tcr & TCR_EL2_TG0_MASK) |
> -	       (tcr & TCR_EL2_ORGN0_MASK) |
> -	       (tcr & TCR_EL2_IRGN0_MASK) |
> -	       (tcr & TCR_EL2_T0SZ_MASK);
> +	u64 vhe = VHE_TCR_EL2_EPD1 |			/* disable TTBR1_EL1 */
> +		  tcr_el2_ps_to_tcr_el1_ips(nvhe);
> +
> +	__xlate_tcr_nvhe_to_vhe(MTX,	MTX0,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe(TCMA,	TCMA0,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe(TBID,	TBID0,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe(HWU62,	HWU062,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe(HWU61,	HWU061,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe(HWU60,	HWU060,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe(HWU59,	HWU059,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe(HPD,	HPD0,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe(TBI,	TBI0,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe_field(	DS,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe_field(	HA,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe_field(	HD,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe_field(	TG0,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe_field(	SH0,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe_field(	ORGN0,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe_field(	IRGN0,	&nvhe,	&vhe);
> +	__xlate_tcr_nvhe_to_vhe_field(	T0SZ,	&nvhe,	&vhe);
> +
> +	return vhe;
>  }
>  
>  static inline u64 translate_cptr_el2_to_cpacr_el1(u64 cptr_el2)
> -- 
> 2.47.3
> 
