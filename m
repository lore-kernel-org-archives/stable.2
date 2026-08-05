Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1A446EC94
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934941; cv=none; b=nNHj7Bt4TSt0Gbq0PU6muHA4+1aRFWO17jar2xW5axUzjK+WyCYzoCL3SPXI5hkihAC3Ep6zrbaNdkrOtmkHa5SDpVJZeATJPfpfZA/2Mi8b7ytFCFSuONf6LWdPEg/3ijeARiPUnkwyGE1CpWph0UJkWBljzL/wqiWVExKFZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934941; c=relaxed/simple;
	bh=JHrJLJsurOFTQ3bBMaq34RC8HheLTkhL1B4VZQQjVGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F78A3lse/iDy72LqbEUC7fVP0nmVjCgXBCx172ickSmIvABE3/pGs4dx6GsETF160FKX4N20cV+MWmYaylAOdAWGsWpCj992+e3gjb+HXBJ4FiT5dxxW8drPE0S68UrnxK3w44r8xbvUH18QCBKQ8u112Uor3mgbioVdCM0oZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H+TKGHtm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H+TKGHtm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E7A143D;
	Wed,  5 Aug 2026 06:02:11 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A72A3F632;
	Wed,  5 Aug 2026 06:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785934935; bh=JHrJLJsurOFTQ3bBMaq34RC8HheLTkhL1B4VZQQjVGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+TKGHtmbXFbI/COjQw2c0m/qoI+oTvx71DCcAgStqzXQ5/hu3zz+AcC4gClmR0pR
	 azuGdxXkHVOenaVihzhqRyl4ZdMa+xUZcXlCFZwfqxo5tEOP6fWp5culbufbXbmOo1
	 VGqP9Z/jXNeMueZxl22H2fqzTDUaYI6HyxWbBNXA=
Date: Wed, 5 Aug 2026 14:02:03 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
	ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org,
	david@kernel.org, james.morse@arm.com, ljs@kernel.org,
	maz@kernel.org, peterz@infradead.org, ruanjinjie@huawei.com,
	ryan.roberts@arm.com, stable@vger.kernel.org,
	vladimir.murzin@arm.com, will@kernel.org,
	yang@os.amperecomputing.com
Subject: Re: [PATCH v2 02/20] arm64: percpu: Fix this_cpu_and() mask
 generation
Message-ID: <anM0S1jVmwO0mqEt@J2N7QTR9R3>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-3-mark.rutland@arm.com>
 <20260805101416.454a49b6@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805101416.454a49b6@pumpkin>

On Wed, Aug 05, 2026 at 10:14:16AM +0100, David Laight wrote:
> On Tue,  4 Aug 2026 18:04:45 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > The arm64 implementation of this_cpu_and(pcp, val) is built in terms of
> > ANDNOT operations, which requires the 'val' argument to be bitwise
> > negated. The bitwise negation is not implemented correctly, with two
> > bugs described below.
> > 
> > (1) The bitwise negation is performed as '~val' rather than '~(val)'.
> >     This won't always generate the expected value when 'val' is an
> >     expression.
> > 
> >     For example, for this_cpu_and(pcp, 1 - 1):
> > 
> >     * 'val'    is  '1 - 1'   ===> (int) 0x00000000
> >     * '~val'   is '~1 - 1'   ===> (int) 0xfffffffd
> >     * '~(val)' is '~(1 - 1)' ===> (int) 0xffffffff
> > 
> >     ... and thus bit[1] of 'pcp' would be preserved unexpectedly by the
> >     ANDNOT operation.
> > 
> > (2) The bitwise negation is performed on 'val' before it has been cast
> >     to (at least) the width of 'pcp'. This won't always generate the
> >     expected value for the upper bits.
> > 
> >     For example, for this_cpu_and(pcp, zero), where 'pcp' is a u64 and
> >     'zero' is a u32:
> > 
> >     * 'zero'           ===> (u32) 0x00000000
> >     * '~(zero)'        ===> (u32) 0xffffffff
> >     * '(u64)~(zero)'   ===> (u64) 0x00000000ffffffff
> >     * '~((u64)(zero))' ===> (u64) 0xffffffffffffffff
> > 
> >     ... and thus bits[63:32] of 'pcp' would be preserved unexpectedly by
> >     the ANDNOT operation.
> > 
> > Fix these issues by adding brackets around 'val', and by casting 'val'
> > to an appropriately-sized type before bitwise negation.

> > diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> > index 63bbfd4944a37..31193bcf89a2b 100644
> > --- a/arch/arm64/include/asm/percpu.h
> > +++ b/arch/arm64/include/asm/percpu.h
> > @@ -206,13 +206,13 @@ PERCPU_RET_OP(add, add, ldadd)
> >  	_pcp_protect_return(__percpu_add_return_case_64, pcp, val)
> >  
> >  #define this_cpu_and_1(pcp, val)	\
> > -	_pcp_protect(__percpu_andnot_case_8, pcp, ~val)
> > +	_pcp_protect(__percpu_andnot_case_8, pcp, ~(u8)(val))
> >  #define this_cpu_and_2(pcp, val)	\
> > -	_pcp_protect(__percpu_andnot_case_16, pcp, ~val)
> > +	_pcp_protect(__percpu_andnot_case_16, pcp, ~(u16)(val))
> 
> I don't think the (u8) or (u16) casts are needed.

They're not strictly needed, but I added them for consistency with the
other cases.

> They force the high 24/16 bits to be ones, but the asm should
> ignore those bits (or possible even prefer they be zeros).

For 'sz' bits, the asm for this op only cares about val[sz-1:0], and
val[63:sz] is immaterial. There's no preference.

> They might also force the compiler to emit code to mask the high bits.

If __percpu_andnot_case_##sz() gets outlined, sure. When
__percpu_andnot_case_##sz() is inlined (which we expect in almost all cases
today), the compiler has visibility that bits [63:sz] are unused, and won't
generate redundant code.

That's a minor redundancy, not a functional issue. If we're worried about that,
we can have __percpu_andnot_case_##sz() take its argument as a u##sz (which TBH
we probably should anyway).

For example, see the code generated for:

| void this_cpu_and_u8__0xf0(u8 __percpu *p) 
| {
|         this_cpu_and(*p, 0xf0);
| }

At this point in the series, GCC 15.2.0 generates:

| <this_cpu_and_u8__0xf0>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mrs     x1, sp_el0
|        mov     x29, sp
|        ldr     w2, [x1, #8]
|        add     w2, w2, #0x1
|        str     w2, [x1, #8]
|        mov     w3, #0xf       // <------ Low 8 bits only!
|        mrs     x2, tpidr_el1
|        add     x0, x0, x2
| 1:     ldxrb   w5, [x0]
|        bic     w5, w5, w3
|        stxrb   w4, w5, [x0]
|        cbnz    w4, 1b
|        ldr     x0, [x1, #8]
|        sub     x0, x0, #0x1
|        str     w0, [x1, #8]
|        cbz     x0, 2f
|        ldr     x0, [x1, #8]
|        cbnz    x0, 3f
| 2:     bl      preempt_schedule_notrace
| 3:     ldp     x29, x30, [sp], #16
|        autiasp
|        ret

> Actually the (u16) cast is wrong for (s8)128.
> That is tricky to fix, maybe:
> 	~(sizeof(val) == 1 ? (u8)(val) : (val))
> (Remember ?: promotes its operands to int.)

I do not follow, and I think you are wrong.

My understanding is that the value arguments to a this_cpu_*() operation
should be subject to the usual type promotion rules. For a u16 'pcp' and
an s8 'v', 'pcp & v' should result in sign-extension of v, and
this_cpu_and(pcp, v) should do the same.

What makes you believe the semantic you propose is correct, and the
semantic I've implemented is wrong? Is there some documentation?

Tvhe semantic youe propose doesn't match what __this_cpu_and() does, and
it doesn't match what this_cpu_and() does on x86_64.

Note how __this_cpu_and() behaves. For the following test case:

| void outline_and__u16__s8_128(u16 __percpu *p)
| {
|         s8 v = 128;
|         __this_cpu_and(*p, v);
| }
| 
| void outline_and__s16__s8_128(s16 __percpu *p)
| {
|         s8 v = 128;
|         __this_cpu_and(*p, v);
| }

For arm64 this generates:

| <outline_and__u16__s8_128>:
|        mrs     x2, tpidr_el1
|        ldrh    w1, [x0, x2]
|        and     w1, w1, #0xffffff80
|        strh    w1, [x0, x2]
|
| <outline_and__s16__s8_128>:
|        mrs     x2, tpidr_el1
|        ldrh    w1, [x0, x2]
|        and     w1, w1, #0xffffff80
|        strh    w1, [x0, x2]
|        ret

... where '(s8)128' is sign-extended to (at least) 16 bits.

Note that LDRH and STRH only use the low 16 bits of the register, the
upper bits of the AND are irrelevant.

Note that for x86, those tests generate:

|	andw   $0xff80,%gs:(%rdi)

... which is clearly sign-extending to 16 bits.

> >  #define this_cpu_and_4(pcp, val)	\
> > -	_pcp_protect(__percpu_andnot_case_32, pcp, ~val)
> > +	_pcp_protect(__percpu_andnot_case_32, pcp, ~(u32)(val))
> 
> The (u32) cast isn't needed (and has pretty much no effect).

As above, this is for consistency. I agree it happens to do nothing.

> >  #define this_cpu_and_8(pcp, val)	\
> > -	_pcp_protect(__percpu_andnot_case_64, pcp, ~val)
> > +	_pcp_protect(__percpu_andnot_case_64, pcp, ~(u64)(val))
> 
> This one still isn't right.
> If val is a signed int with a negative value then it is sign extended
> before being inverted.
> 	val             (int)0x80000000
> 	(u64)(val)   0xffffffff80000000
> 	~(u64)(val)  0x000000007fffffff
> Something like ~(u64)((val) + 0u) will DTRT.

As above, where have you got that idea from?

AFAICT, a smaller signed type *should* be sign extended, and that must
happen before bitwise negation, since that bitwise negation is to cancel
out the NOT part of the ANDNOT operation.
 
Think:

    'pcp'                    is (u64) 0x0123456789abcdef
    'val'                    is (int) 0x800000000
    '(u64)(val)'             is (u64) 0xffffffff80000000
    'pcp & (u64)(val)'       is (u64) 0x0123456780000000

    '~(u64)(val)'            is (u64) 0x000000007fffffff
    'pcp ANDNOT ~(u64)(val)' is (u64) 0x0123456780000000
    
See:

| void outline_and__u64__int_0x80000000(u64 __percpu *p)
| {
|         int v = 0x80000000;
|         __this_cpu_and(*p, v);
| }
| 
| void outline_and__s64__int_0x80000000(s64 __percpu *p)
| {
|         int v = 0x80000000;
|         __this_cpu_and(*p, v);
| }

For which GCC 15.2.0 generates the following:

| <outline_and__u64__int_0x80000000>:
|        mrs     x2, tpidr_el1
|        ldr     x1, [x0, x2]
|        and     x1, x1, #0xffffffff80000000
|        str     x1, [x0, x2]
|        ret
| 
| <outline_and__s64__int_0x80000000>:
|        mrs     x2, tpidr_el1
|        ldr     x1, [x0, x2]
|        and     x1, x1, #0xffffffff80000000
|        str     x1, [x0, x2]
|        ret

Likewise on x86 this generates:

|	andq   $0xffffffff80000000,%gs:(%rdi)

Mark.
