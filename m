Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D82FF672
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011846; cv=none; b=NGCdFQlmYHmnxeIn5KM0RwAblE8mb+cw2/AL/oGa4WjyJLycbIXKTODI8ZGC9DN/P2g5qwRXTbOfuPRMs83Fs5v+5p5xT2iMeQRcyRsRmbhp8OVCLAd+XtGgCJYxW4DtZqt4rOFr7V0gS+SQJJD6lrsheMcIxlm385zhKRDaneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011846; c=relaxed/simple;
	bh=XaLduez5YfnL+jR4/n7fJz93AdeD63NFCK1NlX5SdD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ofz64XIrZF8tOCahykmiSuW8KiS93TIFsOMseNmABaXypvmn4nuFDwPQYej+OWF24SQ6Nlc0snSo3UlVBC6+zO8PTw2V9/AYvR23KtQbohZJAKmDpHq9qr2OuKdzzE98UqWnpSSYUebuZ61st3Z2Eh0eORmrTafy7btaez6cue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e7ZlhmWY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e7ZlhmWY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF0A3153B;
	Thu,  6 Aug 2026 03:23:58 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68B6F3F632;
	Thu,  6 Aug 2026 03:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786011842; bh=XaLduez5YfnL+jR4/n7fJz93AdeD63NFCK1NlX5SdD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7ZlhmWYzW1T+51f6Fnb10Kr9fgREylca9XwHKFhL8f/znEeri1N3rbL/2jIY0QlP
	 QBXtGjSq2JiLQTBtXSS1zwaIY7iXYRkchuiEUCuwcScARK6kjU8htuOJSuzSPjEgpx
	 sdfF7+72O/kx0N7x1OT5WlBvr27xE1MOu+LayIHg=
Date: Thu, 6 Aug 2026 11:23:57 +0100
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
Message-ID: <anRgvaej7exNu8H5@J2N7QTR9R3>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-3-mark.rutland@arm.com>
 <20260805101416.454a49b6@pumpkin>
 <anM0S1jVmwO0mqEt@J2N7QTR9R3>
 <20260806092815.082c6b2a@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806092815.082c6b2a@pumpkin>

On Thu, Aug 06, 2026 at 09:28:15AM +0100, David Laight wrote:
> On Wed, 5 Aug 2026 14:02:03 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Aug 05, 2026 at 10:14:16AM +0100, David Laight wrote:
> > > On Tue,  4 Aug 2026 18:04:45 +0100
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > >  #define this_cpu_and_8(pcp, val)	\
> > > > -	_pcp_protect(__percpu_andnot_case_64, pcp, ~val)
> > > > +	_pcp_protect(__percpu_andnot_case_64, pcp, ~(u64)(val))  
> > > 
> > > This one still isn't right.
> > > If val is a signed int with a negative value then it is sign extended
> > > before being inverted.
> > > 	val             (int)0x80000000
> > > 	(u64)(val)   0xffffffff80000000
> > > 	~(u64)(val)  0x000000007fffffff
> > > Something like ~(u64)((val) + 0u) will DTRT.  
> > 
> > As above, where have you got that idea from?
> > 
> > AFAICT, a smaller signed type *should* be sign extended, and that must
> > happen before bitwise negation, since that bitwise negation is to cancel
> > out the NOT part of the ANDNOT operation.
> >  
> > Think:
> > 
> >     'pcp'                    is (u64) 0x0123456789abcdef
> >     'val'                    is (int) 0x800000000
> >     '(u64)(val)'             is (u64) 0xffffffff80000000
> >     'pcp & (u64)(val)'       is (u64) 0x0123456780000000
> > 
> >     '~(u64)(val)'            is (u64) 0x000000007fffffff
> >     'pcp ANDNOT ~(u64)(val)' is (u64) 0x0123456780000000
> 
> The problem tends to arise with (u8)128 << 24 which is signed even
> though that is never intended.

Never intended by whom?

The expression '(u8)128 << 24' has int type. If an int is passed into a
u64 function parameter, it will be sign extended to 64 bits. If that's
passed into a binary expression against a u64, it will be sign extended.
That's the way __this_cpu_and() evaluates its argument too.

This is no different from calling any other function. If that caller
doesn't want the int value sign-extended to 64 bits to match the 64-bit
argument type, the caller needs to cast to an unsigned type.

See:

| void some_callee(u64 arg);
| 
| void some_caller(u8 arg)
| {
|         some_caller(arg << 24).
| }
|
| u64 some_inline_and(u8 arg)
| {
|         u64 lhs = 0x0123456789abcdef;
|         return lhs & (arg << 24);
| }
|
| void outline___this_cpu_and_expr(u64 __percpu *p)
| {
|        __this_cpu_and(*p, (u8)128 << 24);
| }

Generated code:

| <some_caller>:
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        lsl     w0, w0, #24           // left-shift 24
|        mov     x29, sp
|        sxtw    x0, w0                // sign-extend from 32-bit to 64-bit
|        bl      some_callee
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret
|
| <some_inline_and>:
|        lsl     w0, w0, #24           // left-shift 24
|        mov     x1, #0xcdef
|        movk    x1, #0x89ab, lsl #16
|        sxtw    x0, w0                // sign-extend from 32-bit to 64-bit
|        movk    x1, #0x4567, lsl #32
|        movk    x1, #0x123, lsl #48
|        and     x0, x0, x1
|        ret
|
| <outline___this_cpu_and_expr>:
|        mrs     x2, tpidr_el1
|        ldr     x1, [x0, x2]
|        and     x1, x1, #0xffffffff80000000
|        str     x1, [x0, x2]
|        ret

> To my mind sign extension prior to and/or operations is almost
> certainly unexpected.

As above, I disagree. I think you're starting from an incorrect
assumption about how these should work.

Having sign extension here is is entirely consistent with the usual way
type promotions are applied. It's the semantic of the __this_cpu_*()
operations that should match the this_cpu_*() operations.

Applying an arbitrarily different rule here doesn't help, and would be a
bug. I am not going to change this.

Mark.
