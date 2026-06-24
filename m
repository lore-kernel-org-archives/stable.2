Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156602566F7;
	Wed, 24 Jun 2026 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293820; cv=none; b=hfc9dhXm6R0bhu+c0+J/a3mXnDn79gY9rpAB75D4yVmX/tRw0xxVR3k7LFcyX+4181qWbtIJn4qwNr3GNyktTI3KVZHKg5GlqOicKdu1t+5ORiYQI7PSz2sGmZb3PeY7xVHZFGEol24HR0F0q+Q6SCABwOlXgqgWLkWny6Avgy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293820; c=relaxed/simple;
	bh=cJB/GKjhRZ+tDueeEz/z4J/26HBUnbytnrhU3IDn0QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5Kjj5LPpnrhgTD19J5TbCYrwUI71B47IhIlWQ4wBXBbJIlm+ROJ6GRkXidJlPEHdsRsJIn3gWN/1QrKAr8M+HdvimKWyWV0YvqaT7mb5jhvEx9Y/ZIADUj+jQVRpknv+VyphweDMX2whDoRq2h157ej75Rwzlr9xaLo2Ydl1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABwJ1mYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABwJ1mYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A611F00ACA;
	Wed, 24 Jun 2026 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782293811;
	bh=XywJu8jRVPBxeqs9rzmHag+3ezAMWumDSW8GspGo/YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ABwJ1mYUI9+vP81/vgxFSbY8CiLWrAs4yA6jJ/jSjUQ48IVGwavUp1cWmtPvBEx8O
	 3L3mLCWih2znE5U3TNCpefjVZDF2uzJ04Kb5eRwp6A8R+1sacjfa3sanWBYyMcuZD3
	 OIqHB9TLt9UoNXdsqAU8+fTG6Q68KqyHrWtcIz3oo2gSM3nnfnqV0Jn09rcxWBjktY
	 yA5ufg5sZaXSbfHX11B4z80Km2ZRBI+ia/1dYIUUjvm/CijGqHsRa78zY4CYnKrzRG
	 C4mNPkUPcF/wQq5bXCUGA3blB5hj05bR+uUnSoqD5I7iv357xWsKZy96jTYRGeM/vx
	 tOgCaxJQBYThw==
Date: Wed, 24 Jun 2026 11:36:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Disable jump tables for clang
Message-ID: <ajulLtY29HtgWokg@gmail.com>
References: <20260623-x86-boot-compressed-disable-jt-clang-v1-1-575fccd58107@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623-x86-boot-compressed-disable-jt-clang-v1-1-575fccd58107@kernel.org>


* Nathan Chancellor <nathan@kernel.org> wrote:

> After a recent upstream LLVM change to start generating jump and lookup
> tables in switch statements in more instances [1], linking the
> compressed x86 boot image when CONFIG_KERNEL_ZSTD is enabled fails with:
> 
>   ld.lld: error: Unexpected run-time relocations (.rela) detected!
> 
> Dumping the relocations in misc.o, which is the only file influenced by
> CONFIG_KERNEL_ZSTD in the decompressor, shows dynamic relocations to
> some string constants, which correspond to the string literals in the
> switch statement in handle_zstd_error():
> 
>   Relocation section '.rela.data.rel.ro' at offset 0x277b0 contains 31 entries:
>       Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>   0000000000000000  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 73a
>   0000000000000008  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
>   0000000000000010  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
>   0000000000000018  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
>   ...
> 
> This optimization is problematic for the decompressor environment, as it
> is built as -fPIE without any explicit absolute references (as described
> at the top of misc.c) while not applying any dynamic relocations, hence
> the linker assertion. To opt out of this optimization, which is of
> little value in this special early boot code, disable jump tables in the
> decompressor when building with clang. This mirrors the other x86
> startup code in arch/x86/boot/startup.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2165
> Link: https://github.com/llvm/llvm-project/commit/fa02a6ed66b1700c996b49c96c6bc0eb014c9518 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/x86/boot/compressed/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 07e0e64b9a98..1c0d29e3eeba 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -31,6 +31,7 @@ KBUILD_CFLAGS += -Wundef
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>  cflags-$(CONFIG_X86_32) := -march=i386
>  cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
> +cflags-$(CONFIG_CC_IS_CLANG) += -fno-jump-tables

So, shouldn't we just use -fno-jump-tables for *all* compilers,
like we do in arch/x86/boot/startup/Makefile?

The point wouldn't be to just work around any Clang
jump-table optimization complications alone, but also
to synchronize the build options of very early code and such.

Thanks,

	Ingo
