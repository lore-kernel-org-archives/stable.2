Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BA35F5F3
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917948; cv=none; b=fPhsieewjOqLj1P+bN769RuRrH1SQ0cfosSxyJ2C5iCDvJd1BFfia5SzxEUPyL/FChSH0OacAeer9V7MLw92YWH8AbwILyW2uUwE2nNvmfPK6YjET2l+kvXsY8gDCD9T+gJo5xg+VC+bAT7ehQ3DVnX0IxvEUSY0REkleVUpXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917948; c=relaxed/simple;
	bh=s7fFFa2eJMQ3eN2H7XJtrr9mTMWELH78gjwCpiFzx3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pomGW4v9v5EJ0iPBjAiVKBmT8Tb1D9Q1LWyYqYdzOau8q+i7avSbht3EjZfsrHaEr2u/yCDJPqTaHw2d3epr7Js0k7E3tTSHLNFyswJCgwrMOyCjDEWMQdhcoQwPPHguQpSmnb1237wv+EIDQ2wPjET/XL7OgVd67itbFWx3O5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXqJEDuZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXqJEDuZ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca5d2474c7so15895825ad.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782917946; x=1783522746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdTrJVjmaGZK4bIS2S2vPN6p/bM+L67mDpK1aprSBRM=;
        b=TXqJEDuZ7xZywme017TCxO/5G6+HTXbZYufwiGR3OY7M+3r6av7QNPhMSIxMlOlYK4
         hivoDXUC6VlOesI2kt3/TSN/dwxvfx0f5YPIWme7sw4zO7wRiCS9x6RVwG6A/122CBvZ
         1OfJnk/3CeZY4KfIDnFMTu3b314zFZwKroL0RREaPaMVYlTxnkPzZ1PlwquJBBrRE6lk
         YdI79RFB0LyMFo+V3KOahH1fTsyev1cP2DviV9B43HiRlEZn/yr6e7CSg8q96cnOKwCC
         xQO9ntHdd5jk9+7VHOfDTVy0czZNgQMeSb6BHO2Sd1wDgGcj2TRSsF0OSwEOKFwNdcNJ
         B5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782917946; x=1783522746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdTrJVjmaGZK4bIS2S2vPN6p/bM+L67mDpK1aprSBRM=;
        b=C7pMT3apalzBNuFZfKX5heAirGxiMxQCUp7SlKxFTxCVBvr7z2l8ieq/CCPvw1mI2M
         ObX/62/pV9xxCDB0tAOJwmnrQwsfRqfU5flSZ6AEkIZy3dZe0XXsiUwBX5mgmNh27yYn
         Bl6jCike+gS6ekMggtVbSG4oYNsXs5nAeMkHOG/NbM8+VSkKtPRdG+T5L9b6cHU7mGod
         rntrTyXVwK7r6Bv7Z74WlU99PLEVW1W3LsNHBd2kCagEsYVmeki6l0KaXex/Ml2aF25a
         ZhwFKF/T9n4XMjOy7Czk5vE82GheMCq0rmzS+nD7sZG28x6l7C/tN/uY7bKRRs4RtRhO
         rv4g==
X-Forwarded-Encrypted: i=1; AHgh+RpPnxjL79+T3T6n8BqcxJHlP0ArQLTr82HOoPQnFPymOp20ON5FnxRu6SjyBTVdJU1oz36Iyjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVK2ZN4aERlXRWzpYwlI2cmoa/jeMNLUFSYv2oYGmiHjvKP//
	34K/efMiaudIPmUcAeEyI6xJt3BVLXmUOklPIpM+68jl3kV3lEU75vFBzEg3xnLuIn8x3ab4uKb
	RUJel0g==
X-Received: from plbbi9.prod.google.com ([2002:a17:902:bf09:b0:2bf:195a:2b9d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74b:b0:2c7:fc03:fcf0
 with SMTP id d9443c01a7336-2ca91151163mr8962085ad.17.1782917946247; Wed, 01
 Jul 2026 07:59:06 -0700 (PDT)
Date: Wed, 1 Jul 2026 07:59:05 -0700
In-Reply-To: <20260701110547.764083-3-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701110547.764083-1-kirill@shutemov.name> <20260701110547.764083-3-kirill@shutemov.name>
Message-ID: <akUrORhAmRur-lHP@google.com>
Subject: Re: [PATCH v5 2/3] x86/insn-eval: Add insn_assign_reg() helper
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Laight <david.laight.linux@gmail.com>, Andi Kleen <ak@linux.intel.com>, 
	Dan Williams <djbw@kernel.org>, Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> KVM's instruction emulator has a small helper, assign_register(), that
> writes a value into a sub-register with x86 partial-register-write
> semantics: 1- and 2-byte writes leave the upper bits of the destination
> untouched, 4-byte writes zero-extend to 64 bits, 8-byte writes overwrite
> the full register.
> 
> The TDX guest #VE handler needs the same logic for port I/O emulation
> to get 32-bit zero-extension right.  Rather than copy-pasting the
> helper, lift it to <asm/insn-eval.h> as insn_assign_reg() so both can
> use it.
> 
> Add <asm/insn.h> to the header's includes so it builds standalone in
> callers that have not pulled it in transitively.
> 
> No functional change.
> 
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Cc: stable@vger.kernel.org # prerequisite for the following 32-bit port I/O zero-extension fix
> ---
>  arch/x86/include/asm/insn-eval.h | 30 ++++++++++++++++++++++++++++++
>  arch/x86/kvm/emulate.c           | 26 ++++----------------------
>  2 files changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
> index 4733e9064ee5..0c87759816d3 100644
> --- a/arch/x86/include/asm/insn-eval.h
> +++ b/arch/x86/include/asm/insn-eval.h
> @@ -9,6 +9,7 @@
>  #include <linux/compiler.h>
>  #include <linux/bug.h>
>  #include <linux/err.h>
> +#include <asm/insn.h>
>  #include <asm/ptrace.h>
>  
>  #define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
> @@ -46,4 +47,33 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
>  
>  bool insn_is_nop(struct insn *insn);
>  
> +/*
> + * Write @val into *@reg with x86 partial-register-write semantics: a 1-
> + * or 2-byte write leaves the upper bits of the destination untouched; a
> + * 4-byte write zero-extends to 64 bits (matching IN[BWL], MOV[BWL]

The placement of the "(matching IN[BWL], MOV[BWL] etc.)" blurb is confusing.  I
*think* you're trying to say this behavior matches that of MOVB, MOVW, and MOVL
instruction mnemonics, but the blurb is buried in the snippet that specifically
describes the 4-byte write behavior.

FWIW, I think giving examples does more harm than good, because the behavior isn't
instruction specific, it's architectural behavior that applies to all writes to
GPRs, as defined in "3.4.1.1 General-Purpose Registers in 64-Bit Mode".  E.g. for
a MOV instruction that sign-extends a 32-bit immediate to a 64-bit registers, it's
not that the instruction is exempt from the normal GPR semenatics, it's that the
instruction performs a 64-bit write to the destination even though the source is
only 32 bits.

And the B/W/L terminology isn't architectural, it's AT&T syntax.  E.g. trying
to encode "movl" with NASM yields "error: instruction expected, found `movl dword'".
Yes, the kernel uses AT&T syntax for assembly, but I think this helper should very
explicitly document that it's emulating architectural behavior.

> + * etc.); an 8-byte write overwrites the full register.
> + *
> + * @reg need not be 8-byte aligned: KVM's instruction emulator points
> + * into the middle of a register slot to address the high-byte
> + * registers (AH, CH, DH, BH).  Use narrow stores for the sub-word
> + * cases so that the access width matches @bytes.
> + */
> +static inline void insn_assign_reg(unsigned long *reg, u64 val, int bytes)
> +{
> +	switch (bytes) {
> +	case 1:
> +		*(u8 *)reg = (u8)val;
> +		break;
> +	case 2:
> +		*(u16 *)reg = (u16)val;
> +		break;
> +	case 4:
> +		*reg = (u32)val;

IMO, it's worth keeping a short comment here, because even with the explanation
above, I suspect most people will think the code is buggy.  E.g.

		/* As above, zero-extend 4-byte writes on 64-bit CPUs. */
		*reg = (u32)val;

> +		break;
> +	case 8:
> +		*reg = val;
> +		break;
> +	}
> +}
