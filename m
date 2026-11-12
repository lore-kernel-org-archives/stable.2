Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522267;
	b=bMQ2EGmUdPZNnbGxEahfRU+LLlI/pXmknZM+G45HtGV44QXwI6Hsgnns3Hiu97NQrZ+R
	 BiToZo0xve4YP4ds1ZnvyXeTua6qv5375u70NvLlg5ezZppTfx1+b9SrnIFz3wVVuSmEH
	 PAcSipaJegTpw1qB9/q2M9D15mGvi3wUC8Y6ucrMlBO3omAA6CGNPo4Kr7lMFrQoKwz6+
	 01s3zWprTJiuyRqQDnj/UZh+zkRXu/vTj0Os9KCViwiQ2JhqUn+0p8J55HGNCSykjf8WL
	 HwqBvbuvEzOdGpcgQ9wEKIc2JZoz9XSE7dB3YXULy8ORjEjdGJjvT7On1ED5V8dd06g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522267;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7FayPK/pGf2zT+BfrUKWRiW6uC1vgz+HaFeSIlSFsq4=;
	b=NGtFEYrD9xrjg22/sMFjCnsPfldnUUKdPGe8BS3xjXwfsbvl3Y4nH/WK4Wi8hmIlQfkb
	 qkLjvWALv2cNrb72HXnWjDzOHRjjrXdd7DvbW/ECmB8e6+gtjngB0hQikfFaBYmkT350W
	 +GnzoRlZosr3A/bCQWnfIxDuwGAB4vH2770h671WgWkCTGijVAiR+Ge8XBfh1gQpsto2m
	 KMiXHbxmjgFmHF9g7sFvMdQ0mbivBVasVfM/QB4iBMt/ZukVXPye+Jigkn+G/5ZFiwObJ
	 eBqZuhfajTLUX5a4cXFqvHxoVlucCNcCCGEwqyy0i3eQhSz4bqOuIsPe1Q1xaYPX4lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8vWLn5k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C50606A31C;
	Thu, 12 Nov 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8vWLn5k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683271F000C5;
	Thu, 12 Nov 2026 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522267;
	bh=7FayPK/pGf2zT+BfrUKWRiW6uC1vgz+HaFeSIlSFsq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i8vWLn5klVkd3LCjSungb5kBKE9oiC8ViLRZ/01fWAObXV7Sz6d2wzOPz7WP54gZ3
	 6BmxGsvJAkb7fijW056g2zB7AOaoea/YntE2Qs/bnE1C0o7tKWYTALZuuCB4PacyKk
	 eYfMGilb6z4vqj7PSjj2XsxW4iVxZ0MHAFO3OGpbLl3fqWfBM2F7cOZH+f5h0auK3x
	 tOiC1Bu8rb8/VRzinO8X7evmwpdHTjuaCnWjkdfmZKVtx6KIHC4sgmbRilloCNyzof
	 eacY6a22reioQyylJoWPxzQbgRR9qSlqCkRziOrD9b08VNol3z7qYFK3Gm2i3oNOLP
	 WTI7ZKSBxJvmA==
Date: Thu, 12 Nov 2026 14:22:25 -0800
From: Oliver Upton <oupton@kernel.org>
To: Leonardo Bras <leo.bras@arm.com>
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH 8/8] KVM: arm64: Stop leaning on __kvm_inject_sea() for
 abort injection
Message-ID: <avY8IUOoxScjsisA@kernel.org>
References: <20261104192124.3932743-1-oupton@kernel.org>
 <20261104192124.3932743-9-oupton@kernel.org>
 <avXXSLhMCQVOvv4G@LeoBrasDK>
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
In-Reply-To: <avXXSLhMCQVOvv4G@LeoBrasDK>

On Thu, Nov 12, 2026 at 03:12:08PM +0000, Leonardo Bras wrote:
> > -static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
> > +static void __inject_abt64(struct kvm_vcpu *vcpu, bool iabt, u32 iss, unsigned long addr)
> >  {
> > -	unsigned long cpsr = *vcpu_cpsr(vcpu);
> > -	bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
> > -	u64 esr = 0, fsc;
> > -	int level;
> > +	u64 esr;
> > +	u8 ec;
> > +
> > +	if (vcpu_mode_priv(vcpu))
> 
> Maybe I am getting this wrong, but this line was previously:
> -	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
> 
> but vcpu_mode_priv() does not test exactly the same thing, it would test:
> vcpu_mode_is_32bit(), tested in is_aarch32, &&
> cpsr_mode > PSR_AA32_MODE_USR, not tested above, ||
> *vcpu_cpsr(vcpu) & PSR_MODE_MASK != PSR_MODE_EL0t
> 
> This last line is testing the exact opposite of what was here. 
> Is that another fix?

No, it's equivalent. What we had here before was inscrutable. If we're
taking an exception from 32-bit into a 64-bit EL1, the only way we get
there is from a 32-bit EL0, so this short-circuited it to xABT_LOW.

If there's no exception level change, xABT_CUR. Otherwise, xABT_LOW.

Thanks,
Oliver

> > +		ec = iabt ? ESR_ELx_EC_IABT_CUR : ESR_ELx_EC_DABT_CUR;
> > +	else
> > +		ec = iabt ? ESR_ELx_EC_IABT_LOW : ESR_ELx_EC_DABT_LOW;
> > +
> > +	esr = FIELD_PREP(ESR_ELx_EC_MASK, ec) | FIELD_PREP(ESR_ELx_ISS_MASK, iss) |
> > +	      ESR_ELx_IL;
> > +
> > +	vcpu_write_sys_reg(vcpu, addr, exception_far_elx(vcpu));
> > +	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
> > +}
> > +
> > +static void inject_abt64(struct kvm_vcpu *vcpu, bool iabt, u32 iss, u64 addr)
> > +{
> > +	pend_sync_exception(vcpu);
> > +	__inject_abt64(vcpu, iabt, iss, addr);
> > +}
> > +
> > +static void inject_sea64(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
> > +{
> > +	u8 fsc;
> >  
> >  	/*
> >  	 * If injecting an abort from a failed S1PTW, rewalk the S1 PTs to
> > @@ -116,7 +136,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
> >  	 */
> >  	if (kvm_vcpu_abt_iss1tw(vcpu)) {
> >  		u64 hpfar = kvm_vcpu_get_fault_ipa(vcpu);
> > -		int ret;
> > +		int ret, level;
> >  
> >  		if (hpfar == INVALID_GPA)
> >  			return;
> > @@ -137,28 +157,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
> >  	else
> >  		pend_sync_exception(vcpu);
> >  
> > -	/*
> > -	 * Build an {i,d}abort, depending on the level.
> > -	 * Report an external synchronous abort.
> > -	 */
> > -	esr |= ESR_ELx_IL;
> > -
> > -	/*
> > -	 * Here, the guest runs in AArch64 mode when in EL1. If we get
> > -	 * an AArch32 fault, it means we managed to trap an EL0 fault.
> > -	 */
> > -	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
> > -		esr |= (ESR_ELx_EC_IABT_LOW << ESR_ELx_EC_SHIFT);
> > -	else
> > -		esr |= (ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
> > -
> > -	if (!is_iabt)
> > -		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
> > -
> > -	esr |= fsc;
> > -
> > -	vcpu_write_sys_reg(vcpu, addr, exception_far_elx(vcpu));
> > -	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
> > +	__inject_abt64(vcpu, iabt, fsc, addr);
> >  }
> >  
> >  void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr)
> > @@ -174,31 +173,41 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
> >  	kvm_inject_sync(vcpu, esr);
> >  }
> >  
> > -#define DFSR_FSC_EXTABT_LPAE	0x10
> > -#define DFSR_FSC_EXTABT_nLPAE	0x08
> > -#define DFSR_LPAE		BIT(9)
> > -#define TTBCR_EAE		BIT(31)
> > +#define DFSR_FS_4			BIT(10)
> > +#define DFSR_FS_3_0			GENMASK(3, 0)
> > +#define DFSR_FS_EXTABT_nLPAE		0x08
> > +#define DFSR_FS_EXCL_ATOMIC_nLPAE	0x15
> 
> Maybe I am reading the wrong place, but in M.d, I see:
> DFSR.FS = 0b10101
> IMPLEMENTATION DEFINED fault (Unsupported Exclusive access fault).
> 
> > +#define DFSR_FSC			GENMASK(5, 0)
> > +#define DFSR_FSC_EXTABT_LPAE		0x10
> 
> Wouldn't this be STATUS bits instead of FSC?
> (Maybe FSC got renamed STATUS in the meantime)
> 
> 
> > +#define DFSR_LPAE			BIT(9)
> > +#define TTBCR_EAE			BIT(31)
> >  
> >  static void inject_undef32(struct kvm_vcpu *vcpu)
> >  {
> >  	kvm_pend_exception(vcpu, EXCEPT_AA32_UND);
> >  }
> >  
> > +static bool vcpu_trans_32bit_non_lpae(struct kvm_vcpu *vcpu)
> > +{
> > +	return vcpu_el1_is_32bit(vcpu) && !(vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE);
> > +}
> > +
> >  /*
> >   * Modelled after TakeDataAbortException() and TakePrefetchAbortException
> >   * pseudocode.
> >   */
> > -static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
> > +static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u8 status, u32 addr)
> >  {
> >  	u64 far;
> >  	u32 fsr;
> >  
> > -	/* Give the guest an IMPLEMENTATION DEFINED exception */
> > -	if (vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE) {
> > -		fsr = DFSR_LPAE | DFSR_FSC_EXTABT_LPAE;
> > +	if (vcpu_trans_32bit_non_lpae(vcpu)) {
> > +		/* Ensure status actually fits in DFSR.FS */
> > +		KVM_BUG_ON(status > 0x1F, vcpu->kvm);
> > +		fsr = FIELD_PREP(DFSR_FS_4, FIELD_GET(BIT(4), status)) |
> > +		      FIELD_PREP(DFSR_FS_3_0, FIELD_GET(GENMASK(3, 0), status));
> >  	} else {
> > -		/* no need to shuffle FS[4] into DFSR[10] as it's 0 */
> > -		fsr = DFSR_FSC_EXTABT_nLPAE;
> > +		fsr = FIELD_PREP(DFSR_FSC, status) | DFSR_LPAE;
> >  	}
> >  
> >  	far = vcpu_read_sys_reg(vcpu, FAR_EL1);
> > @@ -218,12 +227,28 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
> >  	vcpu_write_sys_reg(vcpu, far, FAR_EL1);
> >  }
> >  
> > +static void inject_sea32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
> > +{
> > +	if (vcpu_trans_32bit_non_lpae(vcpu))
> > +		inject_abt32(vcpu, is_pabt, DFSR_FS_EXTABT_nLPAE, addr);
> > +	else
> > +		inject_abt32(vcpu, is_pabt, DFSR_FSC_EXTABT_LPAE, addr);
> > +}
> > +
> >  static void __kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
> >  {
> >  	if (vcpu_el1_is_32bit(vcpu))
> > -		inject_abt32(vcpu, iabt, addr);
> > +		inject_sea32(vcpu, iabt, addr);
> >  	else
> > -		inject_abt64(vcpu, iabt, addr);
> > +		inject_sea64(vcpu, iabt, addr);
> > +}
> > +
> > +static void __kvm_inject_abort(struct kvm_vcpu *vcpu, bool iabt, u8 fsc, u64 addr)
> > +{
> > +	if (vcpu_el1_is_32bit(vcpu))
> > +		inject_abt32(vcpu, iabt, fsc, addr);
> > +	else
> > +		inject_abt64(vcpu, iabt, fsc, addr);
> >  }
> >  
> >  static bool kvm_sea_target_is_el2(struct kvm_vcpu *vcpu)
> > @@ -270,28 +295,25 @@ static int kvm_inject_nested_excl_atomic(struct kvm_vcpu *vcpu, u64 addr)
> >   */
> >  int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr)
> >  {
> > -	u64 esr;
> > -
> >  	if (is_nested_ctxt(vcpu) && (vcpu_read_sys_reg(vcpu, HCR_EL2) & HCR_EL2_VM))
> >  		return kvm_inject_nested_excl_atomic(vcpu, addr);
> >  
> > -	__kvm_inject_sea(vcpu, false, addr);
> > -	esr = vcpu_read_sys_reg(vcpu, exception_esr_elx(vcpu));
> > -	esr &= ~ESR_ELx_FSC;
> > -	esr |= ESR_ELx_FSC_EXCL_ATOMIC;
> > -	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
> > +	if (vcpu_trans_32bit_non_lpae(vcpu))
> > +		__kvm_inject_abort(vcpu, false, DFSR_FS_EXCL_ATOMIC_nLPAE, addr);
> > +	else
> > +		__kvm_inject_abort(vcpu, false, ESR_ELx_FSC_EXCL_ATOMIC, addr);
> > +
> >  	return 1;
> >  }
> >  
> >  void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
> >  {
> > -	unsigned long addr, esr;
> > +	bool iabt = kvm_vcpu_trap_is_iabt(vcpu);
> > +	unsigned long addr;
> >  
> >  	addr  = kvm_vcpu_get_fault_ipa(vcpu);
> >  	addr |= FAR_TO_FIPA_OFFSET(kvm_vcpu_get_hfar(vcpu));
> >  
> > -	__kvm_inject_sea(vcpu, kvm_vcpu_trap_is_iabt(vcpu), addr);
> > -
> >  	/*
> >  	 * If AArch64 or LPAE, set FSC to 0 to indicate an Address
> >  	 * Size Fault at level 0, as if exceeding PARange.
> > @@ -299,13 +321,10 @@ void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
> >  	 * Non-LPAE guests will only get the external abort, as there
> >  	 * is no way to describe the ASF.
> >  	 */
> > -	if (vcpu_el1_is_32bit(vcpu) &&
> > -	    !(vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE))
> > -		return;
> > -
> > -	esr = vcpu_read_sys_reg(vcpu, exception_esr_elx(vcpu));
> > -	esr &= ~GENMASK_ULL(5, 0);
> > -	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
> > +	if (vcpu_trans_32bit_non_lpae(vcpu))
> > +		__kvm_inject_sea(vcpu, iabt, addr);
> > +	else
> > +		__kvm_inject_abort(vcpu, iabt, ESR_ELx_FSC_ADDRSZ, addr);
> 
> The rest seems correct, and make easier to comprehend. :)
> 
> Thanks!
> Leo
