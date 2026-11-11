Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399414;
	b=Lqc2EuhnRWWP1KY0U/8bTQHVfOoOWh1+VCFArtT6sC+As2ihvLLxV3MhJpDnHOvpHQKt
	 conboMTJSp6xjb8LxErQ3k/JYFhMeyjKm7Laa7G8LMeZqONURN0NLf2JqH/4zOUMBvDFS
	 s+iY17lowZfitMH5/I8l8CSjXQ7Kpz7pCzYDXpQMk10aBgcH6L5r81iS08gRa0bdcQapX
	 dDUyCBBRlBCcyYxOK1DINU5qGa8M31dJ/zukE1S+sOhEZxn0yRyPNO5fh9mDuL81SWN8q
	 LG1Ve9pQjGJSAq0tZlYVmsHRpS2dOphV3Z3v9y5KPl4ODTFEpOWhvvibMIz0sCUtjOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399414;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=UhyhIOX7imp5mBWbRK2/NSiFHVImK/OE1OBipxfe6bs=;
	b=iSGf4pSFvxzUtFdCSkwqVVm7to1axlXDFCHuU16VjG+OP67N9zycuU+7EBCaqOjAjL5I
	 2b5D7Sjt7L0WlE0dPfOLMGRp1q+PqSzfKzCYOCGat2xraM9jdiQYcQiAtYlnsxlCW/a4h
	 tA2W0wk9+B9HzkX++CRDzF09f4ouKIpYq1wDYb/V2EVBvnSeve6nqyK3sOGuxw8Vk1i2P
	 4cuNpUdKz7bSPPYnjOdMQmRwRgD/G9W8ny4JiePKo7Qp3rMfuS0mVMkEb6aDCSGQi2YeZ
	 okofbRtMjXoz+Sosi+8l1zB/lKX37Jl2ZW6E6OUiwm5D/pucMyufXrwRXAQrMP2MvTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZndW6QmP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95673606A886
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95673606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZndW6QmP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C425C1576;
	Wed, 11 Nov 2026 04:16:49 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24CFC3F632;
	Wed, 11 Nov 2026 04:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794399412; bh=6o9WL3LbxwWjRuuSAZAU1s3uvYxMlarF7UOOA3mk1BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZndW6QmPdIppTYfh2pC54oryPfzVs1WfZyMXbgnBc548WdsvM6/u3Pq4B1V4p1cjH
	 L6V+KqBATxFayX6yKj7IRI4J2DO1VJtMYm7XhqQXLGegvaBNWaNWXD6KLbbelGxS1q
	 EPxirp0ysXRkPtV0JlzoBEh4zgIh7g0UGmE6TVls=
From: Leonardo Bras <leo.bras@arm.com>
To: Oliver Upton <oupton@kernel.org>
Cc: Leonardo Bras <leo.bras@arm.com>,
	kvmarm@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH 7/8] KVM: arm64: nv: Enforce sysreg visibility before evaulating guest traps
Date: Wed, 11 Nov 2026 12:16:28 +0000
Message-ID: <avRcnIB6O-_wnDHr@LeoBrasDK>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104192124.3932743-8-oupton@kernel.org>
References: <20261104192124.3932743-1-oupton@kernel.org> <20261104192124.3932743-8-oupton@kernel.org>
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
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026 at 11:21:23AM -0800, Oliver Upton wrote:
> Not all sysregs / system instructions can be described by FGUs. Of
> these, there are some which may be not implemented for the VM (e.g. MTE
> cache maintenance instructions) yet intersect with valid trap bits for
> the VM (HCR_EL2.TPCP).
> 
> This is annoying to deal with since most of our UNDEF infrastructure is
> built around traps being RESx for unimplemented features. Test the
> visibility of the sys_reg_desc to avoid injecting traps for non-existent
> system registers into the guest hypervisor.
> 
> Cc: stable@vger.kernel.org
> Fixes: a7484c80e5ca ("KVM: arm64: Allow userspace to request KVM_ARM_VCPU_EL2*")
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> ---
>  arch/arm64/kvm/emulate-nested.c | 24 +++++++++++++++++++++---
>  arch/arm64/kvm/sys_regs.c       | 18 ++++++++++--------
>  arch/arm64/kvm/sys_regs.h       |  4 +++-
>  3 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
> index d04ac5203454..46dc658b041b 100644
> --- a/arch/arm64/kvm/emulate-nested.c
> +++ b/arch/arm64/kvm/emulate-nested.c
> @@ -2546,12 +2546,13 @@ static bool check_fgt_bit(struct kvm_vcpu *vcpu, enum vcpu_sysreg sr,
>  	return !(kvm_get_sysreg_res0(kvm, sr) & BIT(tc.bit));
>  }
>  
> -bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
> +bool triage_sysreg_trap(struct kvm_vcpu *vcpu, const struct sys_reg_desc **r)
>  {
>  	enum vcpu_sysreg fgtreg;
>  	union trap_config tc;
>  	enum trap_behaviour b;
>  	bool is_read;
> +	int sr_index;
>  	u32 sysreg;
>  	u64 esr;
>  
> @@ -2559,6 +2560,7 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
>  	sysreg = esr_sys64_to_sysreg(esr);
>  	is_read = (esr & ESR_ELx_SYS64_ISS_DIR_MASK) == ESR_ELx_SYS64_ISS_DIR_READ;
>  
> +	*r = NULL;

In the caller, desc is already NULL, and here we are overwriting as NULL 
again. Is it needed here?

(For some reason it looks weird to me that the first thing we do with a 
parameter is to clean it's contents here)

>  	tc = get_trap_config(sysreg);
>  
>  	/*
> @@ -2569,6 +2571,11 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
>  	if (!tc.val)
>  		goto local;
>  
> +	if (tc.sri) {
> +		sr_index = tc.sri - 1;
> +		*r = kvm_sys_reg_idx_to_desc(esr_sys64_to_sysreg(esr), sr_index);

IIUC sr_index is used only in this block, maybe we could make it local to 
it?

> +	}
> +
>  	/*
>  	 * If a sysreg can be trapped using a FGT, first check whether we
>  	 * trap for the purpose of forbidding the feature. In that case,
> @@ -2595,6 +2602,18 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
>  	if (is_hyp_ctxt(vcpu) && !vcpu_is_host_el0(vcpu))
>  		goto local;
>  
> +	/*
> +	 * Certain sysregs and system instructions could be UNDEF for the VM
> +	 * but lack a corresponding FGU description and intersect with a valid
> +	 * trap bit for the VM. Test the visibility the sysreg (if we have a
> +	 * sys_reg_desc) before determining the effects of the guest
> +	 * hypervisor's traps.
> +	 */
> +	if (*r && sysreg_guest_hidden(vcpu, *r)) {
> +		kvm_inject_undefined(vcpu);
> +		return true;
> +	}
> +
>  	switch ((enum fgt_group_id)tc.fgt) {
>  	case __NO_FGT_GROUP__:
>  		break;
> @@ -2666,7 +2685,7 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
>  		goto inject;
>  
>  local:
> -	if (!tc.sri) {
> +	if (!(*r)) {
>  		struct sys_reg_params params;
>  
>  		params = esr_sys64_to_params(esr);
> @@ -2697,7 +2716,6 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
>  		return true;
>  	}
>  
> -	*sr_index = tc.sri - 1;
>  	return false;
>  
>  inject:
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 7f7a197a9ad6..7c8277de0494 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -5407,6 +5407,15 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
>  		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
>  }
>  
> +const struct sys_reg_desc *kvm_sys_reg_idx_to_desc(u32 encoding, int sr_idx)
> +{
> +	/* System registers have Op0=={2,3}, as per DDI487 J.a C5.1.2 */
> +	if (sys_reg_Op0(encoding) == 2 || sys_reg_Op0(encoding) == 3)
> +		return &sys_reg_descs[sr_idx];
> +	else
> +		return &sys_insn_descs[sr_idx];
> +}
> +
>  /**
>   * kvm_handle_sys_reg -- handles a system instruction or mrs/msr instruction
>   *			 trap on a guest execution
> @@ -5418,22 +5427,15 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
>  	struct sys_reg_params params;
>  	unsigned long esr = kvm_vcpu_get_esr(vcpu);
>  	int Rt = kvm_vcpu_sys_get_rt(vcpu);
> -	int sr_idx;
>  
>  	trace_kvm_handle_sys_reg(esr);
>  
> -	if (triage_sysreg_trap(vcpu, &sr_idx))
> +	if (triage_sysreg_trap(vcpu, &desc))
>  		return 1;
>  
>  	params = esr_sys64_to_params(esr);
>  	params.regval = vcpu_get_reg(vcpu, Rt);
>  
> -	/* System registers have Op0=={2,3}, as per DDI487 J.a C5.1.2 */
> -	if (params.Op0 == 2 || params.Op0 == 3)
> -		desc = &sys_reg_descs[sr_idx];
> -	else
> -		desc = &sys_insn_descs[sr_idx];
> -
>  	perform_access(vcpu, &params, desc);
>  
>  	/* Read from system register? */
> diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> index 50214271b24a..d8ae21578665 100644
> --- a/arch/arm64/kvm/sys_regs.h
> +++ b/arch/arm64/kvm/sys_regs.h
> @@ -263,10 +263,12 @@ int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
>  int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
>  			 const struct sys_reg_desc table[], unsigned int num);
>  
> -bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index);
> +bool triage_sysreg_trap(struct kvm_vcpu *vcpu, const struct sys_reg_desc **r);
>  
>  int kvm_vcpu_finalize_sys_regs(struct kvm_vcpu *vcpu);
>  
> +const struct sys_reg_desc *kvm_sys_reg_idx_to_desc(u32 encoding, int sr_idx);
> +
>  #define AA32(_x)	.aarch32_map = AA32_##_x
>  #define Op0(_x) 	.Op0 = _x
>  #define Op1(_x) 	.Op1 = _x
> -- 
> 2.47.3
> 

In general terms, I like that the change makes it easier to understand the 
function.

Thanks!
Leo
