Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496338;
	b=o8SLr7PcAX2zxdsV5ffhoqQ5/+5HuGtUk0SBpkgaNjMHcfue1iaGkTPIjbwQDZoh9pPe
	 L3m5LuhrNPUe859M1xVNywZW/v8jl5+KW5cJLgy6cL5skRBhE7AZzO+Wi4R/r4tntdM5l
	 ZTWa84wFxBD3OxTynlsuKcXvBuxscBNLIty+p1WmX4aUspNhdXTFc87f/N24gFvkruBEU
	 sL67+7IXa8Nc13CM86WBWVp343zQ/y352CH6qnMXMqMntxhNJTdeVm6JStDA6/hoa1k5m
	 mM2p22HG2zS4J3nE8HdtBNp1YG+Y04UhAikO1oTXqKfxemz5JUUObHpxrqCTrUbbobQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496338;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=QCLY6GzZNwTavS5eEWpjuyaCz72Jc6PbdiGpZVL3/WU=;
	b=Z7zgvPrVJX3NuvW51t8vk6bsEewReuybXhKCX1wz7Ylbgkrs+Jnn3U5NnuS91q47cdkS
	 p1Lk1qPt00Qzu+KYXWIz4BDYwT5qXaEYgyTtkpooA8zueyoaTpd/5kvE1kYsd73gBPS7j
	 5bB6yqojIIgc5vM46bf3QFpU1Eq1nOuBxngGrt6AojitYDQZsz9hActmlthoxXIWJ7Hue
	 09OoOcSE0B/RSzfodYxdSomdOcx7vGRq/Kvr8oXe02VhpfQkg34KS/1eSUy1cDiakGcDP
	 lBnTlkUn+ZMn4/hStlQmacDnogxkXtrvVDxY+ZUu3GHChQa5DiGiFr4q5I3xJFV0TQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pXwQV6sC;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6529F606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6529F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pXwQV6sC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B51021516;
	Thu, 12 Nov 2026 07:12:13 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0979B3F632;
	Thu, 12 Nov 2026 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794496336; bh=VUYCKd/6I3o8DDZIe1DPj0Ia3oaTfMkE4oKSORe90Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXwQV6sCFE1/rL3XViBxlz3MUQNRaAoqu6UaRvE2bfiv6870CUX6SbHpdJs69bCE9
	 z48jlwSnW7eUgD5EoMLvo9Sw1kc/IaRxypLlzKNfeDAoA6xAInX4J9L2kJuyfc1QUC
	 Cnz27NxSlAWisbYfFuK0fLkkeLDexlVej/g9KUls=
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
Subject: Re: [PATCH 8/8] KVM: arm64: Stop leaning on __kvm_inject_sea() for abort injection
Date: Thu, 12 Nov 2026 15:12:08 +0000
Message-ID: <avXXSLhMCQVOvv4G@LeoBrasDK>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261104192124.3932743-9-oupton@kernel.org>
References: <20261104192124.3932743-1-oupton@kernel.org> <20261104192124.3932743-9-oupton@kernel.org>
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

On Wed, Nov 04, 2026 at 11:21:24AM -0800, Oliver Upton wrote:
> KVM's handling of local abort injection is, politely stated, a giant
> fscking mess. At surface level, things look somewhat innocuous: inject
> an SEA and directly update ESR_EL1 with the correct FSC afterwards. But
> this is broken for a couple reasons.
> 
> For one, on implementations with FEAT_DoubleFault2 KVM may inject the
> SEA as an SError depending on the falue of SCTLR2_EL1.NMEA, meaning that
> the eventual non-SEA abort is incorrectly taken to the SError vector.
> 
> AArch32 is also quite bitrotted. No surprise. The FSR value is written
> to IFSR not DFSR, when a prefetch abort is injected. So while DFSR is
> aliased to ESR_EL1 architecturally, fixing up ESR_EL1.FSC after
> injection has no effect on IFSR.
> 
> Finally, injecting aborts into non-LPAE relics may use an invalid value
> for xFSC.FS, as KVM unconditionally uses the LPAE/VMSAv8-64 format.
> 
> Fix the first two by tearing the whole mess, adding __kvm_inject_abort()
> for injecting non-SEA aborts which takes the desired FSC from the
> caller. Fix the third one by selecting a fault status value based on the
> LPAE-ness of the guest.
> 
> Cc: stable@vger.kernel.org
> Fixes: fff97df2a0bd ("KVM: arm64: Route SEAs to the SError vector when EASE is set")
> Fixes: 2937aeec9dc5 ("KVM: arm64: Handle DABT caused by LS64* instructions on unsupported memory")
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> ---
>  arch/arm64/kvm/inject_fault.c | 133 +++++++++++++++++++---------------
>  1 file changed, 76 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index aa2011cc0d5a..89c7890b8743 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -102,12 +102,32 @@ static bool effective_sctlr2_nmea(struct kvm_vcpu *vcpu)
>  	return __effective_sctlr2_bit(vcpu, SCTLR2_EL1_NMEA_SHIFT);
>  }
>  
> -static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
> +static void __inject_abt64(struct kvm_vcpu *vcpu, bool iabt, u32 iss, unsigned long addr)
>  {
> -	unsigned long cpsr = *vcpu_cpsr(vcpu);
> -	bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
> -	u64 esr = 0, fsc;
> -	int level;
> +	u64 esr;
> +	u8 ec;
> +
> +	if (vcpu_mode_priv(vcpu))

Maybe I am getting this wrong, but this line was previously:
-	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)

but vcpu_mode_priv() does not test exactly the same thing, it would test:
vcpu_mode_is_32bit(), tested in is_aarch32, &&
cpsr_mode > PSR_AA32_MODE_USR, not tested above, ||
*vcpu_cpsr(vcpu) & PSR_MODE_MASK != PSR_MODE_EL0t

This last line is testing the exact opposite of what was here. 
Is that another fix?

> +		ec = iabt ? ESR_ELx_EC_IABT_CUR : ESR_ELx_EC_DABT_CUR;
> +	else
> +		ec = iabt ? ESR_ELx_EC_IABT_LOW : ESR_ELx_EC_DABT_LOW;
> +
> +	esr = FIELD_PREP(ESR_ELx_EC_MASK, ec) | FIELD_PREP(ESR_ELx_ISS_MASK, iss) |
> +	      ESR_ELx_IL;
> +
> +	vcpu_write_sys_reg(vcpu, addr, exception_far_elx(vcpu));
> +	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
> +}
> +
> +static void inject_abt64(struct kvm_vcpu *vcpu, bool iabt, u32 iss, u64 addr)
> +{
> +	pend_sync_exception(vcpu);
> +	__inject_abt64(vcpu, iabt, iss, addr);
> +}
> +
> +static void inject_sea64(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
> +{
> +	u8 fsc;
>  
>  	/*
>  	 * If injecting an abort from a failed S1PTW, rewalk the S1 PTs to
> @@ -116,7 +136,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
>  	 */
>  	if (kvm_vcpu_abt_iss1tw(vcpu)) {
>  		u64 hpfar = kvm_vcpu_get_fault_ipa(vcpu);
> -		int ret;
> +		int ret, level;
>  
>  		if (hpfar == INVALID_GPA)
>  			return;
> @@ -137,28 +157,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
>  	else
>  		pend_sync_exception(vcpu);
>  
> -	/*
> -	 * Build an {i,d}abort, depending on the level.
> -	 * Report an external synchronous abort.
> -	 */
> -	esr |= ESR_ELx_IL;
> -
> -	/*
> -	 * Here, the guest runs in AArch64 mode when in EL1. If we get
> -	 * an AArch32 fault, it means we managed to trap an EL0 fault.
> -	 */
> -	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
> -		esr |= (ESR_ELx_EC_IABT_LOW << ESR_ELx_EC_SHIFT);
> -	else
> -		esr |= (ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
> -
> -	if (!is_iabt)
> -		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
> -
> -	esr |= fsc;
> -
> -	vcpu_write_sys_reg(vcpu, addr, exception_far_elx(vcpu));
> -	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
> +	__inject_abt64(vcpu, iabt, fsc, addr);
>  }
>  
>  void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr)
> @@ -174,31 +173,41 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
>  	kvm_inject_sync(vcpu, esr);
>  }
>  
> -#define DFSR_FSC_EXTABT_LPAE	0x10
> -#define DFSR_FSC_EXTABT_nLPAE	0x08
> -#define DFSR_LPAE		BIT(9)
> -#define TTBCR_EAE		BIT(31)
> +#define DFSR_FS_4			BIT(10)
> +#define DFSR_FS_3_0			GENMASK(3, 0)
> +#define DFSR_FS_EXTABT_nLPAE		0x08
> +#define DFSR_FS_EXCL_ATOMIC_nLPAE	0x15

Maybe I am reading the wrong place, but in M.d, I see:
DFSR.FS = 0b10101
IMPLEMENTATION DEFINED fault (Unsupported Exclusive access fault).

> +#define DFSR_FSC			GENMASK(5, 0)
> +#define DFSR_FSC_EXTABT_LPAE		0x10

Wouldn't this be STATUS bits instead of FSC?
(Maybe FSC got renamed STATUS in the meantime)


> +#define DFSR_LPAE			BIT(9)
> +#define TTBCR_EAE			BIT(31)
>  
>  static void inject_undef32(struct kvm_vcpu *vcpu)
>  {
>  	kvm_pend_exception(vcpu, EXCEPT_AA32_UND);
>  }
>  
> +static bool vcpu_trans_32bit_non_lpae(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu_el1_is_32bit(vcpu) && !(vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE);
> +}
> +
>  /*
>   * Modelled after TakeDataAbortException() and TakePrefetchAbortException
>   * pseudocode.
>   */
> -static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
> +static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u8 status, u32 addr)
>  {
>  	u64 far;
>  	u32 fsr;
>  
> -	/* Give the guest an IMPLEMENTATION DEFINED exception */
> -	if (vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE) {
> -		fsr = DFSR_LPAE | DFSR_FSC_EXTABT_LPAE;
> +	if (vcpu_trans_32bit_non_lpae(vcpu)) {
> +		/* Ensure status actually fits in DFSR.FS */
> +		KVM_BUG_ON(status > 0x1F, vcpu->kvm);
> +		fsr = FIELD_PREP(DFSR_FS_4, FIELD_GET(BIT(4), status)) |
> +		      FIELD_PREP(DFSR_FS_3_0, FIELD_GET(GENMASK(3, 0), status));
>  	} else {
> -		/* no need to shuffle FS[4] into DFSR[10] as it's 0 */
> -		fsr = DFSR_FSC_EXTABT_nLPAE;
> +		fsr = FIELD_PREP(DFSR_FSC, status) | DFSR_LPAE;
>  	}
>  
>  	far = vcpu_read_sys_reg(vcpu, FAR_EL1);
> @@ -218,12 +227,28 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
>  	vcpu_write_sys_reg(vcpu, far, FAR_EL1);
>  }
>  
> +static void inject_sea32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
> +{
> +	if (vcpu_trans_32bit_non_lpae(vcpu))
> +		inject_abt32(vcpu, is_pabt, DFSR_FS_EXTABT_nLPAE, addr);
> +	else
> +		inject_abt32(vcpu, is_pabt, DFSR_FSC_EXTABT_LPAE, addr);
> +}
> +
>  static void __kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
>  {
>  	if (vcpu_el1_is_32bit(vcpu))
> -		inject_abt32(vcpu, iabt, addr);
> +		inject_sea32(vcpu, iabt, addr);
>  	else
> -		inject_abt64(vcpu, iabt, addr);
> +		inject_sea64(vcpu, iabt, addr);
> +}
> +
> +static void __kvm_inject_abort(struct kvm_vcpu *vcpu, bool iabt, u8 fsc, u64 addr)
> +{
> +	if (vcpu_el1_is_32bit(vcpu))
> +		inject_abt32(vcpu, iabt, fsc, addr);
> +	else
> +		inject_abt64(vcpu, iabt, fsc, addr);
>  }
>  
>  static bool kvm_sea_target_is_el2(struct kvm_vcpu *vcpu)
> @@ -270,28 +295,25 @@ static int kvm_inject_nested_excl_atomic(struct kvm_vcpu *vcpu, u64 addr)
>   */
>  int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr)
>  {
> -	u64 esr;
> -
>  	if (is_nested_ctxt(vcpu) && (vcpu_read_sys_reg(vcpu, HCR_EL2) & HCR_EL2_VM))
>  		return kvm_inject_nested_excl_atomic(vcpu, addr);
>  
> -	__kvm_inject_sea(vcpu, false, addr);
> -	esr = vcpu_read_sys_reg(vcpu, exception_esr_elx(vcpu));
> -	esr &= ~ESR_ELx_FSC;
> -	esr |= ESR_ELx_FSC_EXCL_ATOMIC;
> -	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
> +	if (vcpu_trans_32bit_non_lpae(vcpu))
> +		__kvm_inject_abort(vcpu, false, DFSR_FS_EXCL_ATOMIC_nLPAE, addr);
> +	else
> +		__kvm_inject_abort(vcpu, false, ESR_ELx_FSC_EXCL_ATOMIC, addr);
> +
>  	return 1;
>  }
>  
>  void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
>  {
> -	unsigned long addr, esr;
> +	bool iabt = kvm_vcpu_trap_is_iabt(vcpu);
> +	unsigned long addr;
>  
>  	addr  = kvm_vcpu_get_fault_ipa(vcpu);
>  	addr |= FAR_TO_FIPA_OFFSET(kvm_vcpu_get_hfar(vcpu));
>  
> -	__kvm_inject_sea(vcpu, kvm_vcpu_trap_is_iabt(vcpu), addr);
> -
>  	/*
>  	 * If AArch64 or LPAE, set FSC to 0 to indicate an Address
>  	 * Size Fault at level 0, as if exceeding PARange.
> @@ -299,13 +321,10 @@ void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
>  	 * Non-LPAE guests will only get the external abort, as there
>  	 * is no way to describe the ASF.
>  	 */
> -	if (vcpu_el1_is_32bit(vcpu) &&
> -	    !(vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE))
> -		return;
> -
> -	esr = vcpu_read_sys_reg(vcpu, exception_esr_elx(vcpu));
> -	esr &= ~GENMASK_ULL(5, 0);
> -	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
> +	if (vcpu_trans_32bit_non_lpae(vcpu))
> +		__kvm_inject_sea(vcpu, iabt, addr);
> +	else
> +		__kvm_inject_abort(vcpu, iabt, ESR_ELx_FSC_ADDRSZ, addr);

The rest seems correct, and make easier to comprehend. :)

Thanks!
Leo
