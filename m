Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DB53438BF
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394750; cv=none; b=a2TAfWKo7VmC1kMv3VtP4Na5RhJEgG9h0KNNeE2UEDgXhfE8nyuWWnNbWOfxT2PtPkop9M/1K4OLtOlk9jMoKO3dG4CviPACBka62qCxTS5DvqVrVDwqYpiov4bWmES0XHjuK7Y9ekSfR9kAGtFcMCse+/se4Bm2Rw3yV+rtr2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394750; c=relaxed/simple;
	bh=KkZL3kZjlzIKZDczsKUqHdtUtCFsETbMqyj175b7mTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKPwuzkKBra0DXncuXrInDEda0iFEBsXKQdlzcGsCVWd9lC4V6yqjHQ1OvM+A/p5hPq+CziXetkbpTmrngRcIflqPbk6LjuNAvfSY8PxVc6C6hsWvODNtfXExP0RxwpdCLTaeA7ai0ZER1PTI5EkZth9td/0TqcDB43jkYXqXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kl9GGNH0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kl9GGNH0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9091B2309;
	Tue,  2 Jun 2026 03:05:43 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD7C83F632;
	Tue,  2 Jun 2026 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780394748; bh=KkZL3kZjlzIKZDczsKUqHdtUtCFsETbMqyj175b7mTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kl9GGNH0LnDyLs5hJh70fo+fntDxJSbU2Yh7BKyfzbFXGHXr6zUg7scfVNhUXhJ6R
	 Tp5b86PaKl4aa1R0+OHqUW2VZoiwL2z7hFbRPTGwyJS4O/emX/3sQWJUpn62KB2TO+
	 I+SiFLWoFYfwTYzfDP/8n5OD6HQLahyViUhrFJj4=
Date: Tue, 2 Jun 2026 11:05:32 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: nv: Fix handling of XN[0] when !FEAT_XNX
Message-ID: <c6ygqahq5cnk7b3q2hyy7aiagmnvytizp7sksjqz6qo57ghifa@ruflsb5snx2s>
References: <20260602072759.37885-1-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602072759.37885-1-oupton@kernel.org>

On Tue, Jun 02, 2026 at 12:27:59AM -0700, Oliver Upton wrote:
> XN has already been extracted from its bitfield position so using
> FIELD_PREP() on the mask that clears XN[0] is completely broken, having
> the effect of unconditionally granting execute permissions...
> 
> Fix the obvious mistake by manipulating the right bit.
> 
> Cc: stable@vger.kernel.org
> Fixes: d93febe2ed2e ("KVM: arm64: nv: Forward FEAT_XNX permissions to the shadow stage-2")
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_nested.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 091544e6af44..f5d4eb925198 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -131,7 +131,7 @@ static inline bool kvm_s2_trans_exec_el0(struct kvm *kvm, struct kvm_s2_trans *t
>  	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
>  
>  	if (!kvm_has_xnx(kvm))
> -		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
> +		xn &= BIT(1);
>  
>  	switch (xn) {
>  	case 0b00:
> @@ -147,7 +147,7 @@ static inline bool kvm_s2_trans_exec_el1(struct kvm *kvm, struct kvm_s2_trans *t
>  	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
>  
>  	if (!kvm_has_xnx(kvm))
> -		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
> +		xn &= BIT(1);

I think using 0b10 here can improve styling consistency very slightly,
but either way,

Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>

>  
>  	switch (xn) {
>  	case 0b00:
> 
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
> -- 
> 2.47.3
> 
