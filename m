Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594230;
	b=bVKRnjpHjsVH775oHLayDGfBBD91ITDWsEUs+uigTr4KMRI4GPAsE0J9iHKZkk/NMfWI
	 DyKjbKLARmchyTuYaO3Ef+tuOWZ3vHLwypjGB5w8w2SE4SVa1Cd90zqG3tNRJs9gBZIqR
	 NQ1fZRrHQj5PVJ/TPgZDlbwSHHjdtIo+OhtWMGXrTpDpRsvmyY4FUYGAYXPs9N0+xK7p7
	 1CVfY9RhGNfkbfUErGfG7Dhas4kryMXwfFdyVNYGWrW4yMEgF3+wRwY/o4ShnczF9tUBT
	 6aqAVh4lSqoNLTIN1VQUjqbLp/vxc3PVnzz2rJrt6cLvfRboJptnZbrOlA9UpDu6DGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594230;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gEmZYkKRuGStdrZ58CF2CeEnhOHYJIve1QUs7ePE6Q8=;
	b=hETshGCp6FSR7MZ4kq1T1tZZe4ia/H+FtW+sr0Jzxc55ZlWTVE4kAouDsnRjEgcjy8xK
	 i802OjnV26oye8jA5/rdw3XQykJULsQHiLSMNaJDhmWM0ifP/gqjGJ0GhJ2joHna4nfUk
	 em7VJ4EU5JCoodWSo/kTMkH5qw6ziUKy5i5hvRn9KGyOaBjUvb/N4z+bFenAIwNblx/Z+
	 q6rsOJzjo+8XqKkagmd4fEHzsL9ndffZlt5W4eMJqv4KPpCZl7usJt7WAEsBQxvvNBJe+
	 MFYrGx9pgiw5bOhHL2BVs52YjWPIzjEKBr7yMpjUYKGpyZkd15BfFASFwtYQ32XVMCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Mt2h6zVq;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B3606A32D;
	Fri, 13 Nov 2026 18:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A4B3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Mt2h6zVq
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3313F143D;
	Fri, 13 Nov 2026 10:23:46 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C34D83F673;
	Fri, 13 Nov 2026 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794594229; bh=Uye60IuEv5YKw+O9A3I4dFufgEY3c8/N5h8UyJOLmU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mt2h6zVqGLFJ09H6KRxU3dWwcBUHVZ0UIrb2oB+psHtGR8Fgywu9/53rH37KaPtt9
	 OAIAwjxuiznfuOXIsODnqH8ROdqXBTWZ6/Y6KcsnL9CJ1wP6L8ITW4MzQcJq7vay23
	 b35sNlOniksb+h0Ij0p81WdnxukdtVy5qeDGUlm0=
Date: Fri, 13 Nov 2026 18:23:44 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Rui Qi <qirui.001@bytedance.com>
Cc: will@kernel.org, mark.rutland@arm.com, ardb@kernel.org, song@kernel.org,
	dylanbhatch@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: module: Use text-poke for late PLT/veneer
 emission
Message-ID: <avdVsAOC_fpoDNDr@arm.com>
References: <20261111073906.652400-1-qirui.001@bytedance.com>
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
In-Reply-To: <20261111073906.652400-1-qirui.001@bytedance.com>

Thanks Rui for respinning.

On Wed, Nov 11, 2026 at 03:39:06PM +0800, Rui Qi wrote:
> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> index fb9b88eebeb1..4a1a47f8ba1a 100644
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -6,6 +6,7 @@
>  #define __ASM_MODULE_H
>  
>  #include <asm-generic/module.h>
> +#include <asm/text-patching.h>
>  
>  struct mod_plt_sec {
>  	int			plt_shndx;
> @@ -29,6 +30,21 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
>  u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
>  				void *loc, u64 val);
>  
> +/*
> + * Write a relocation value to @place within a module.  While the module
> + * is MODULE_STATE_UNFORMED the destination is writable and a direct store
> + * is used; once the module is fully formed the region is read-only and
> + * executable, so the write is routed through the text-poke API.
> + */
> +#define module_write_place(place, val, mod) do {			\
> +	__typeof__(*place) __val = (val);				\
> +									\
> +	if (mod->state == MODULE_STATE_UNFORMED)			\
> +		*(place) = __val;					\
> +	else								\
> +		aarch64_insn_copy(place, &(__val), sizeof(*place));	\
> +} while (0)

A nit here, I'd move this macro to asm/text-patching.h since
asm/module.h is pulled in by linux/module.h. Even better if you could
make this a function (either static inline or out of line).

> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -76,11 +76,13 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
>  	int i = pltsec->plt_num_entries;
>  	int j = i - 1;
>  	u64 val = sym->st_value + rela->r_addend;
> +	struct plt_entry entry;
>  
>  	if (is_forbidden_offset_for_adrp(&plt[i].adrp))
>  		i++;
>  
> -	plt[i] = get_plt_entry(val, &plt[i]);
> +	entry = get_plt_entry(val, &plt[i]);
> +	module_write_place(&plt[i], entry, mod);

Sashiko reported PLT exhaustion/overrun and ADRP corruption when
relocations are reapplied after unloading and reloading a target module:

https://sashiko.dev/#/patchset/20261111073906.652400-1-qirui.001@bytedance.com

These look like existing problems, only exposed now because we no longer
get the ROX fault. I think they can be addressed in separate follow-up
patches. This patch still fixes the fault on the first application.

However, could we include a bounds check before writing the PLT entry,
maybe with a WARN_ON_ONCE? Once late writes use text-poke, retrying
after slot exhaustion can overwrite memory beyond .plt.

Thanks.

-- 
Catalin
