Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DCD351C20;
	Fri, 25 Sep 2026 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333574; cv=none; b=er7+r69f4yubM8TdyqejJ6CIlDhkVdNCw0L5k0kKTx2MFoONm17xTjQB85Q09wd55Vfs+x567A+7pwrSqqff1goXOht02iel7+offyOOlvBZm5g23F1cfbp6YB1COewkYeaZq2qTFb7TDawHC7mWxqW10Acye0AdGGm+70VnvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333574; c=relaxed/simple;
	bh=5CuDEdL9d8TbbYaEEXIEL/IwPXE3DV7YkxY7DhU4+yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbKH4WXAlSLWWcBQSxkjaY9LmGYQD2uGFd505He+pprnqRoAlwuiC/iqi9nKy8hWflLFZXDfZ2d08M6evH3gaUGbTJmhCSWMQZpSNU5oXd+UOIwOJLDrbOHOx26BTnmCRPysLWp810i1Lb8SJWyLKNli033GqwJvM6+miVeAhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ve6g2dxA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ve6g2dxA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D17B4169C;
	Fri, 25 Sep 2026 03:52:47 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8C633F86F;
	Fri, 25 Sep 2026 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790333571; bh=5CuDEdL9d8TbbYaEEXIEL/IwPXE3DV7YkxY7DhU4+yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ve6g2dxAVpq6FXJMw7XDuiNFz6ragF4OO1ORyYsq8r1qvZZ9WS0+JKSDH9FRYQ1aR
	 vHmRGkjra7jR0Wp8TUIWIZlxngRg/GI9oKE3bfbWugeGxss4Nn8Ut3W0WW8CXcfaCQ
	 I7yaQUXem5BGCdyt0Ym4YfDTytnrUFd63uJhyESg=
Date: Fri, 25 Sep 2026 11:52:43 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <kees@kernel.org>
Cc: Ben Cressey <ben@cressey.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>, kexec@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: kexec: mark machine_kexec() __nocfi
Message-ID: <arZSe8hNnRPM5FqY@J2N7QTR9R3.cambridge.arm.com>
References: <20260924-arm64-kexec-nocfi-v1-1-bbae2e2eadc8@cressey.dev>
 <202609241804.BB23BF10@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202609241804.BB23BF10@keescook>

On Thu, Sep 24, 2026 at 07:14:52PM -0700, Kees Cook wrote:
> On Thu, Sep 24, 2026 at 10:42:30PM +0000, Ben Cressey wrote:
> > With CONFIG_CFI=y the kCFI check on this call loads a type hash from
> > kern_reloc - 4. arm64_relocate_new_kernel is SYM_CODE_START and carries
> > no hash. Its copy also sits at the start of the control page, which is
> > all that TTBR0 maps at this point, so the load faults and the kernel
> > oopses after "Bye!" instead of entering the new kernel:
> > [...]
> > arm64_relocate_new_kernel cannot be given a type hash, since the linker
> > script asserts that the relocation code starts at that symbol and a
> > hash would have to precede it. Mark machine_kexec() __nocfi instead, as
> > commit e2f8216ca2d8 ("arm64: Set __nocfi on swsusp_arch_resume()") did
> > for the same pattern on the hibernate path and commit 2114796ca041
> > ("x86/kexec: Mark machine_kexec() with __nocfi") did on x86.
> 
> I think e2f8216ca2d8 made a mistake here; using SYM_TYPED_FUNC_START
> wouldn't have been tautological: the defense is making sure that the
> indirect call itself can't be used with a bad pointer. 

It wasn't a mistake as such; it was a temporary bodge which wasn't
followed up with a complete fix. See:

  https://lore.kernel.org/linux-arm-kernel/aXOZ1vsFvQRkxK9x@J2N7QTR9R3.cambridge.arm.com/

We knew the more complete fix was to use SYM_TYPED_FUNC_START(), but
that was a bigger job, and (unfortunately) no-one followed up with the
complete fix.

If someone's happy to do that (as you have tried below), let's do that
and remove the existing bodge for swsusp_arch_resume(), and do the right
thing here.

Mark.

> Fixing this correctly isn't so bad: it just needs to decouple the
> entrypoint from the page address.
> 
> But, barring that, what I don't like here (and with x86) is that it
> covers the entire function, so _all_ indirect calls go unprotected.
> 
> Can you pull the call out into an inline helper so that the other
> indirect call (cpu_soft_restart) doesn't lose coverage?
> 
> -Kees
> 
> P.S.
> 
> Doing the whole SYM_TYPED_FUNC_START change (below, only build tested)
> is larger, but maybe things besides KCFI will want things before the
> entry point?
> 
>  arch/arm64/include/asm/kexec.h      |    2 ++
>  arch/arm64/kernel/machine_kexec.c   |   13 +++++++++++--
>  arch/arm64/kernel/relocate_kernel.S |   14 +++++++++-----
>  arch/arm64/kernel/vmlinux.lds.S     |    5 +++--
>  4 files changed, 25 insertions(+), 9 deletions(-)
> 
> 
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 892e5bebda957..0be042ec22c1f 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -100,6 +100,8 @@ void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
>  		      unsigned long arg0, unsigned long arg1,
>  		      unsigned long arg2);
>  
> +void arm64_relocate_new_kernel(struct kimage *kimage);
> +
>  int machine_kexec_post_load(struct kimage *image);
>  #define machine_kexec_post_load machine_kexec_post_load
>  #endif
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 8f9bc2327dc85..1cf4cb135ee2b 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -136,9 +136,18 @@ int machine_kexec_post_load(struct kimage *kimage)
>  	kimage->arch.ttbr1 = __pa(trans_pgd);
>  	kimage->arch.zero_page = __pa_symbol(empty_zero_page);
>  
> +	/*
> +	 * The whole .kexec_relocate.text section is copied to the control
> +	 * page, but arm64_relocate_new_kernel is not required to be the first
> +	 * thing in it. Allow for whatever precedes it (e.g. a landing pad,
> +	 * a kCFI type hash, etc) by carrying its offset within the section
> +	 * across the copy.
> +	 */
>  	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
>  	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
> -	kimage->arch.kern_reloc = __pa(reloc_code);
> +	kimage->arch.kern_reloc = __pa(reloc_code) +
> +		((unsigned long)arm64_relocate_new_kernel -
> +		 (unsigned long)__relocate_new_kernel_start);
>  	rc = trans_pgd_idmap_page(&info, &kimage->arch.ttbr0,
>  				  &kimage->arch.t0sz, reloc_code);
>  	if (rc)
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index af1d720209764..81540c09a3db8 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -432,6 +432,7 @@ ASSERT(swapper_pg_dir - tramp_pg_dir == TRAMP_SWAPPER_OFFSET,
>  ASSERT(__relocate_new_kernel_end - __relocate_new_kernel_start <= SZ_4K,
>         "kexec relocation code is bigger than 4 KiB")
>  ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is broken")
> -ASSERT(__relocate_new_kernel_start == arm64_relocate_new_kernel,
> -       "kexec control page does not start with arm64_relocate_new_kernel")
> +ASSERT(arm64_relocate_new_kernel >= __relocate_new_kernel_start &&
> +       arm64_relocate_new_kernel < __relocate_new_kernel_end,
> +       "kexec relocation entry point is outside the copied region")
>  #endif
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 1cf4cb135ee2b..90302efebb426 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -202,7 +202,7 @@ void machine_kexec(struct kimage *kimage)
>  		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
>  			0, 0);
>  	} else {
> -		void (*kernel_reloc)(struct kimage *kimage);
> +		typeof(arm64_relocate_new_kernel) *kernel_reloc;
>  
>  		if (is_hyp_nvhe())
>  			__hyp_set_vectors(kimage->arch.el2_vectors);
> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> index 6cb4209f5dab5..e3e575c57fe12 100644
> --- a/arch/arm64/kernel/relocate_kernel.S
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -8,6 +8,7 @@
>   * Pasha Tatashin <pasha.tatashin@soleen.com>
>   */
>  
> +#include <linux/cfi_types.h>
>  #include <linux/kexec.h>
>  #include <linux/linkage.h>
>  
> @@ -32,11 +33,14 @@
>   * new image to its final location.  To assure that the
>   * arm64_relocate_new_kernel routine which does that copy is not overwritten,
>   * all code and data needed by arm64_relocate_new_kernel must be between the
> - * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
> - * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
> - * safe memory that has been set up to be preserved during the copy operation.
> + * symbols __relocate_new_kernel_start and __relocate_new_kernel_end.  The
> + * machine_kexec() routine will copy that whole region to the kexec safe
> + * memory that has been set up to be preserved during the copy operation,
> + * and enter it at arm64_relocate_new_kernel's offset within it.
> + *
> + * It is called indirectly, through the copy, so it needs a kCFI type hash.
>   */
> -SYM_CODE_START(arm64_relocate_new_kernel)
> +SYM_TYPED_FUNC_START(arm64_relocate_new_kernel)
>  	/*
>  	 * The kimage structure isn't allocated specially and may be clobbered
>  	 * during relocation. We must load any values we need from it prior to
> @@ -98,4 +102,4 @@ SYM_CODE_START(arm64_relocate_new_kernel)
>  	mov	x2, xzr
>  	mov	x3, xzr
>  	br	x28				/* Jumps from el1 */
> -SYM_CODE_END(arm64_relocate_new_kernel)
> +SYM_FUNC_END(arm64_relocate_new_kernel)
> 
> 
> -- 
> Kees Cook
