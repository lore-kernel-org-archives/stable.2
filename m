Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.188.11.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012060;
	b=2gv1jxDStlSkyf2IDcvrtoeCHSSU5MdojkSoJcXwdQ/W5kqEcxsZ/dgrc+YA9xHrcJ4Q
	 qSD8LAsrxpDUPrjaGljaoZ+HiEdnNcHB8RjwCNOZupmFw5go7/SHhwBwKqai5wBig7rOT
	 8ELQgiKiORrlCmZeOGbkzALWCOJcnrJybrRsAMEeq9pqMJIq5sle0botZFgfimrj2o/04
	 RXkxR4nFoctiwJyyL6dMKT989uR2OVvsM2McfxNAIug14EMJwiS6GCfhATdEAhLfmKlAH
	 IHj0yaD72ZYke1hj5/f7WhAJ7a+1kuP/vAgXlc6my1zOWK+4iojAPm+9bVezPTqlMVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012060;
	h=DMARC-Filter:DKIM-Signature:Received:X-Virus-Scanned:X-RRZE-Flag:
	 X-RRZE-Submit-IP:Received:From:To:Cc:Subject:In-Reply-To:References:
	 User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=nV1O6jvV7LY84nmyWvTeb3FZb9IncqxS3F8jpRloohk=;
	b=NyY5PxrxDZqnhDl3hRxCVv09Vjbm+c0vmBEKTdO0zhO44AqI10zx1CA8+2apdOeArPPD
	 Y1DgcYWwBWO5BJiDNrXnnQ/BSKpYyADrd7OXmsm+0h4ydWcIeXBVBQChjar6Hm8AtMfTh
	 Bz8OaviZSTJAQwpO+Gj4Km26qHKAk1v2BXlmCnnYcIazLjkYCbTfv/3g+jg6jRUSJiX+1
	 5VwGJ/fsi5F7lVpFbqURHfrR8fR3vMCXuae18snMGHPzEo2L9oQWqUxG0Wa2w3hT6WgVt
	 7fsxG8p2o3o+r6jVNJcZV8+eFlm8Bh7eOYJs4wLUbzcRr6NwJ1/B8G+tohvrlq+S9XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fau.de;
	spf=pass smtp.mailfrom=fau.de;
	dkim=pass header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=XVzbMVpL;
	arc=none smtp.remote-ip=131.188.11.21
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D060A2608;
	Wed, 18 Nov 2026 14:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC5D060A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=XVzbMVpL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1795012049; bh=nV1O6jvV7LY84nmyWvTeb3FZb9IncqxS3F8jpRloohk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=XVzbMVpLS0l21PdU1UrLo6qa5n5nJURXRUjkvdjgVEmnHTJFU8iodHSziacY9VHGS
	 t2HmIyq98BqtfM7s6ch/h15TFlHdNMEnOLmFl91exGNxTrEWsgWkrM6gO8nH54aeUi
	 DxD6G+yAbzkoSDOcVm7phlcBbl3uEnmZP4bi02nCkBlYmsWwQzMYrnUSTPlVSqoDXb
	 LeCMCEs4St4+v119DuF24wHaIh5tMhdoLgYaegoKVAnAdoM0JxtfZJMu+EqVT2L80i
	 avoZMyImbN4EqJhKWX/wGHNhGIxpxCFP8K5W+Wm6dqDbCIngYMen31tvxBIpoy6SOL
	 WLcEuB7zQOOXg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4jV3pT4tyFzPjlr;
	Wed, 18 Nov 2026 15:27:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:385
Received: from localhost (unknown [IPv6:2001:620:618:5b8:2:80b3:0:385])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18FgheTGs5bb6/Cj/sYgy4rpAX9+EqkDi0=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4jV3pQ4jwyzPjjf;
	Wed, 18 Nov 2026 15:27:26 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  John Fastabend <john.fastabend@gmail.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
In-Reply-To: <20261117172341.3152407-1-ryan.roberts@arm.com>
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
User-Agent: mu4e 1.12.12; emacs 31.1
Date: Wed, 18 Nov 2026 15:27:25 +0100
Message-ID: <871p8ib4fm.fsf@fau.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Ryan Roberts <ryan.roberts@arm.com> writes:

> The BPF verifier can accept programs with unsafe speculative paths by
> inserting BPF_NOSPEC instructions instead of rejecting them. It relies
> on those instructions to prevent execution of the unsafe paths.
>
> The arm64 JIT implements BPF_NOSPEC with a speculation barrier, but the
> interpreter calls barrier_nospec(), which falls back to a no-op on
> arm64. Programs executed by the interpreter therefore lack the
> Spectre-v1 barriers assumed by the verifier. Contrary to the code
> comment, kernel-wide SSBD does not provide this protection, since it
> mitigates Spectre v4 rather than Spectre v1.
>
> Rename spec_bar() to barrier_nospec() so that the interpreter and other
> callers receive SB if supported, or DSB NSH followed by ISB otherwise.
>
> Defining barrier_nospec() would also add barriers to the generic
> copy_from_user() and copy_from_user_iter() paths. These are unnecessary
> on arm64: its uaccess primitives mask user pointers so that they cannot
> address kernel memory even when an access_ok() check is mispredicted.
>
> Introduce user_access_may_speculate_kernel_addr(), defaulting to true,
> and have arm64 return false. Then update the uaccess sites to call
> barrier_nospec() conditionally on the macro.
>
> Cc: stable@vger.kernel.org
> Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks! Tested that this prevents the attack (just recovery of OOB
value, did not aim for real secret) on Cavium ThunderX2 (no FEAT_SB) as
expected.

Tested-by: Luis Gerhorst <luis.gerhorst@fau.de>

> ---
>  arch/arm64/include/asm/barrier.h | 6 +++---
>  arch/arm64/include/asm/uaccess.h | 3 +++
>  arch/arm64/kernel/proton-pack.c  | 2 +-
>  include/linux/uaccess.h          | 7 ++++++-
>  kernel/bpf/core.c                | 9 +--------
>  lib/iov_iter.c                   | 3 ++-
>  6 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 9495c4441a46..088ee29d36f4 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -40,9 +40,9 @@
>   */
>  #define dgh()		asm volatile("hint #6" : : : "memory")
>
> -#define spec_bar()	asm volatile(ALTERNATIVE("dsb nsh\nisb\n",		\
> -						 SB_BARRIER_INSN"nop\n",	\
> -						 ARM64_HAS_SB))
> +#define barrier_nospec() asm volatile(ALTERNATIVE("dsb nsh\nisb\n",		\
> +						  SB_BARRIER_INSN"nop\n",	\
> +						  ARM64_HAS_SB) : : : "memory")
>
>  #define gsb_ack()	asm volatile(GSB_ACK_BARRIER_INSN : : : "memory")
>  #define gsb_sys()	asm volatile(GSB_SYS_BARRIER_INSN : : : "memory")
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 9f5bd9c69c24..6fd03dc1ae76 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -174,6 +174,9 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
>  	return safe_ptr;
>  }
>
> +/* __uaccess_mask_ptr() prevents speculative accesses to kernel addresses. */
> +#define user_access_may_speculate_kernel_addr() false
> +
>  /*
>   * The "__xxx" versions of the user access functions do not verify the address
>   * space - it must have been done previously with a separate "access_ok()"
> diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> index 3bcf86154d95..c96e93eca3b9 100644
> --- a/arch/arm64/kernel/proton-pack.c
> +++ b/arch/arm64/kernel/proton-pack.c
> @@ -559,7 +559,7 @@ static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
>  	 * could mis-speculate branches and bypass a conditional barrier.
>  	 */
>  	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386))
> -		spec_bar();
> +		barrier_nospec();
>
>  	return SPECTRE_MITIGATED;
>  }
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 67cdb0a4f583..5a1fa4f48c77 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -50,6 +50,10 @@
>   #define mask_user_address(src) (src)
>  #endif
>
> +#ifndef user_access_may_speculate_kernel_addr
> +#define user_access_may_speculate_kernel_addr() true
> +#endif
> +
>  /*
>   * Architectures should provide two primitives (raw_copy_{to,from}_user())
>   * and get rid of their private instances of copy_{to,from}_user() and
> @@ -179,7 +183,8 @@ _inline_copy_from_user(void *to, const void __user *from, unsigned long n)
>  		 * lead to nasty side effects *after* the copy is
>  		 * finished:
>  		 */
> -		barrier_nospec();
> +		if (user_access_may_speculate_kernel_addr())
> +			barrier_nospec();
>  	}
>  	instrument_copy_from_user_before(to, from, n);
>  	res = raw_copy_from_user(to, from, n);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0b8456f2dce9..abd938d310bb 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2250,14 +2250,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>  	/* ST, STX and LDX*/
>  	ST_NOSPEC:
>  		/* Speculation barrier for mitigating Speculative Store Bypass,
> -		 * Bounds-Check Bypass and Type Confusion. In case of arm64, we
> -		 * rely on the firmware mitigation as controlled via the ssbd
> -		 * kernel parameter. Whenever the mitigation is enabled, it
> -		 * works for all of the kernel code with no need to provide any
> -		 * additional instructions here. In case of x86, we use 'lfence'
> -		 * insn for mitigation. We reuse preexisting logic from Spectre
> -		 * v1 mitigation that happens to produce the required code on
> -		 * x86 for v4 as well.
> +		 * Bounds-Check Bypass and Type Confusion.
>  		 */
>  		barrier_nospec();
>  		CONT;
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index fa4fe2e92383..abd27189beff 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -60,7 +60,8 @@ size_t copy_from_user_iter(void __user *iter_from, size_t progress,
>  		 * lead to nasty side effects *after* the copy is
>  		 * finished:
>  		 */
> -		barrier_nospec();
> +		if (user_access_may_speculate_kernel_addr())
> +			barrier_nospec();
>  	}
>  	to += progress;
>  	instrument_copy_from_user_before(to, iter_from, len);
