Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571789;
	b=v43/NdVYY9mci3zHmbI/5jSjkmMuimA02I98f9G9h5jgD+Wy2G9gy+OZmYS2v1S2rOv+
	 j8bXOS2w+TvuVIN17G+d8O0BWboQugYLfp1kpeaUFpdja/+IzoyNzl6PzBjK0Tehwjx56
	 SH3IxOKb8zkxLX4vCEsKZTyrPeNcvhT1D7NJLRmS2QfbVesGI+IkHYspUtPy/2cQyYU8n
	 tk8yFG6op1Pppj0EH34K7SpLsbmJbEAAySMLJXOR3DJWkCK2B/o8CR5y5pJFfdesHrL91
	 SV6I1lSMKJyAW4PJLkoF+0QP1DWB4XgDU5rC+2Ak0+ulRfMysJMe5bQ53v+cBg3WUEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571789;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=2G+piNO/0Q80N5pPAqfiUGw2eEMQVAldj94yU7VhUZM=;
	b=ISS/xRDjKqmUhO5aT17W09i/g4ByOKUKU5BAxOlbtdfFO2xxGKl3e4c2bYPdAoP5DV+W
	 qSbHid8GIaYjn5qpDmqF8xW32KZsSLDfBL3MrQfBKXCE/n6WYww/WwHXqYCEp4nUvnmF/
	 kRe5kr8qBur6qa3FnOCCa+C+saKlhOVLtqTbK02DWzkH/nhoSZaC4HXr4azsEcFU0xvDP
	 clA86oD7yM8jCDydGBfct8TlNCZ+vBEsTGgezklQd89lIOlvFr4EaWeJ8eHlYrz4qtAmg
	 TzkzFiT19aGsNjMsJKNVwcUY438qP6GtKz2+hu24OCgBjZVBOgnYjDk3MQ7BfilJnRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GhEzHD1s;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0FB606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A0FB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GhEzHD1s
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD832F;
	Fri, 13 Nov 2026 04:09:39 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84FD33F673;
	Fri, 13 Nov 2026 04:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794571782; bh=drBmT0h2GElfkVIvcl3FbjsfB/gjaDmjLdB/XjWCtYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhEzHD1s1S/hn7S9o823Z9Kml/Bn07QRPiUMge5k85YJ/zjq84E3dfp1sZYlSVZIT
	 d2+JPKSCiQWkZgF20aWrqhok+c1RlK9XV9BNhIAo1OKRgLE8zAJGkESws76JC4RWb8
	 NOIMYjbTKyj4apvi/6QIyJbnM+i7JP5AafbM99iY=
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
Date: Fri, 13 Nov 2026 12:09:35 +0000
Message-ID: <avb9_21JEsS6-lz3@LeoBrasDK>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <avY8IUOoxScjsisA@kernel.org>
References: <20261104192124.3932743-1-oupton@kernel.org> <20261104192124.3932743-9-oupton@kernel.org> <avXXSLhMCQVOvv4G@LeoBrasDK> <avY8IUOoxScjsisA@kernel.org>
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

On Thu, Nov 12, 2026 at 02:22:25PM -0800, Oliver Upton wrote:
> On Thu, Nov 12, 2026 at 03:12:08PM +0000, Leonardo Bras wrote:
> > > -static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
> > > +static void __inject_abt64(struct kvm_vcpu *vcpu, bool iabt, u32 iss, unsigned long addr)
> > >  {
> > > -	unsigned long cpsr = *vcpu_cpsr(vcpu);
> > > -	bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
> > > -	u64 esr = 0, fsc;
> > > -	int level;
> > > +	u64 esr;
> > > +	u8 ec;
> > > +
> > > +	if (vcpu_mode_priv(vcpu))
> > 
> > Maybe I am getting this wrong, but this line was previously:
> > -	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
> > 
> > but vcpu_mode_priv() does not test exactly the same thing, it would test:
> > vcpu_mode_is_32bit(), tested in is_aarch32, &&
> > cpsr_mode > PSR_AA32_MODE_USR, not tested above, ||
> > *vcpu_cpsr(vcpu) & PSR_MODE_MASK != PSR_MODE_EL0t
> > 
> > This last line is testing the exact opposite of what was here. 
> > Is that another fix?
> 
> No, it's equivalent. What we had here before was inscrutable. If we're
> taking an exception from 32-bit into a 64-bit EL1, the only way we get
> there is from a 32-bit EL0, so this short-circuited it to xABT_LOW.
> 
> If there's no exception level change, xABT_CUR. Otherwise, xABT_LOW.
> 

Ah, I see. Thanks for helping me understand :)

There are a couple more comments below:

> Thanks,
> Oliver
> 
> > > +		ec = iabt ? ESR_ELx_EC_IABT_CUR : ESR_ELx_EC_DABT_CUR;
> > > +	else
> > > +		ec = iabt ? ESR_ELx_EC_IABT_LOW : ESR_ELx_EC_DABT_LOW;
> > > +
> > > +	esr = FIELD_PREP(ESR_ELx_EC_MASK, ec) | FIELD_PREP(ESR_ELx_ISS_MASK, iss) |
> > > +	      ESR_ELx_IL;
> > > +
> > > +	vcpu_write_sys_reg(vcpu, addr, exception_far_elx(vcpu));
> > > +	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
> > > +}
> > > +
> > > +static void inject_abt64(struct kvm_vcpu *vcpu, bool iabt, u32 iss, u64 addr)
> > > +{
> > > +	pend_sync_exception(vcpu);
> > > +	__inject_abt64(vcpu, iabt, iss, addr);
> > > +}
> > > +
> > > +static void inject_sea64(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
> > > +{
> > > +	u8 fsc;
> > >  
> > >  	/*
> > >  	 * If injecting an abort from a failed S1PTW, rewalk the S1 PTs to
> > > @@ -116,7 +136,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
> > >  	 */
> > >  	if (kvm_vcpu_abt_iss1tw(vcpu)) {
> > >  		u64 hpfar = kvm_vcpu_get_fault_ipa(vcpu);
> > > -		int ret;
> > > +		int ret, level;
> > >  
> > >  		if (hpfar == INVALID_GPA)
> > >  			return;
> > > @@ -137,28 +157,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
> > >  	else
> > >  		pend_sync_exception(vcpu);
> > >  
> > > -	/*
> > > -	 * Build an {i,d}abort, depending on the level.
> > > -	 * Report an external synchronous abort.
> > > -	 */
> > > -	esr |= ESR_ELx_IL;
> > > -
> > > -	/*
> > > -	 * Here, the guest runs in AArch64 mode when in EL1. If we get
> > > -	 * an AArch32 fault, it means we managed to trap an EL0 fault.
> > > -	 */
> > > -	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
> > > -		esr |= (ESR_ELx_EC_IABT_LOW << ESR_ELx_EC_SHIFT);
> > > -	else
> > > -		esr |= (ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
> > > -
> > > -	if (!is_iabt)
> > > -		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
> > > -
> > > -	esr |= fsc;
> > > -
> > > -	vcpu_write_sys_reg(vcpu, addr, exception_far_elx(vcpu));
> > > -	vcpu_write_sys_reg(vcpu, esr, exception_esr_elx(vcpu));
> > > +	__inject_abt64(vcpu, iabt, fsc, addr);
> > >  }
> > >  
> > >  void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr)
> > > @@ -174,31 +173,41 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
> > >  	kvm_inject_sync(vcpu, esr);
> > >  }
> > >  
> > > -#define DFSR_FSC_EXTABT_LPAE	0x10
> > > -#define DFSR_FSC_EXTABT_nLPAE	0x08
> > > -#define DFSR_LPAE		BIT(9)
> > > -#define TTBCR_EAE		BIT(31)
> > > +#define DFSR_FS_4			BIT(10)
> > > +#define DFSR_FS_3_0			GENMASK(3, 0)
> > > +#define DFSR_FS_EXTABT_nLPAE		0x08
> > > +#define DFSR_FS_EXCL_ATOMIC_nLPAE	0x15
> > 
> > Maybe I am reading the wrong place, but in M.d, I see:
> > DFSR.FS = 0b10101
> > IMPLEMENTATION DEFINED fault (Unsupported Exclusive access fault).
> > 

^

> > > +#define DFSR_FSC			GENMASK(5, 0)
> > > +#define DFSR_FSC_EXTABT_LPAE		0x10
> > 
> > Wouldn't this be STATUS bits instead of FSC?
> > (Maybe FSC got renamed STATUS in the meantime)
> > 

^


Thanks!
Leo
