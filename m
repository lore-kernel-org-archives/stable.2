Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA1A2C21C4;
	Wed, 24 Jun 2026 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294707; cv=none; b=S9iHZ3lkzOsSppjRwcYu/6v9FpyzHn3rpRT9f3leC5Pz7TLyaSBAWQIikMmp3Z5v2K9Bkdul+0sDwzuY1BntIMBRxsqcf9EINPUzgmNjIUydsffesSGYxpQmazfw59H89g4X2o4K6A9ZALY5TLZmFaGosmuRechbEtp5t48OmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294707; c=relaxed/simple;
	bh=OnVJjASkjBS04BEvcsUoJNkxKxPHaGpospyGHejIlXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvy8BMkMC+n2aFk2LJ2pioHFfk19HONDvLj/uOd+8SXVR93s0nTRF6UTUU6gKb8Dn5OesHesuTKVUJEZmmQKcbNNrDvgeWM2BIhvoHAH1AlGRqgecDpPQO1t1A4QlUqzT6hrG9Rn5MefenIxJ8m8sykJZhXLCp7pnfWzc7Mbs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZYpc2CR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZYpc2CR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3382D1F000E9;
	Wed, 24 Jun 2026 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782294706;
	bh=Rb3cCcFftDpI9YdiqlNkG1vVa+kHhS9ohmmv6xsxugg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mZYpc2CRassvmuu1HXN3WOfiOdmt2h88fr/IqNWaoYtM5RuqiPGlJBpH7vKhQ7dHr
	 LlQzrOZkS9idrMLrqt405wTFsaW4uIYADmNKPgHkugKB4QF3zwoFJSpV1bL3FFUMce
	 jbr0dgMHnx9SZWpFY5TvungTqcnZQzBMgd1tspoTGxkG4DUuTA0E0ZB8K/Yolnrocp
	 nNSFDC5unupddZWoPTiOw4wHKkYQn3ntGjy0fzZqsP+Jz2bFVc1DI9VpckHGozzV93
	 WDLogqr9ZFq3wniixVaH7QZPyVmeKu5+CweSrSFjDeFNxylX/LXVQww2deFm9TlxOl
	 aEQWJ/kwS/BUw==
Date: Wed, 24 Jun 2026 11:51:36 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Disable jump tables for clang
Message-ID: <ajuoqIk4tSV7CmFC@gmail.com>
References: <20260623-x86-boot-compressed-disable-jt-clang-v1-1-575fccd58107@kernel.org>
 <ajulLtY29HtgWokg@gmail.com>
 <20260624093848.GA48970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624093848.GA48970@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jun 24, 2026 at 11:36:46AM +0200, Ingo Molnar wrote:
> > 
> > * Nathan Chancellor <nathan@kernel.org> wrote:
> > 
> > > After a recent upstream LLVM change to start generating jump and lookup
> > > tables in switch statements in more instances [1], linking the
> > > compressed x86 boot image when CONFIG_KERNEL_ZSTD is enabled fails with:
> > > 
> > >   ld.lld: error: Unexpected run-time relocations (.rela) detected!
> > > 
> > > Dumping the relocations in misc.o, which is the only file influenced by
> > > CONFIG_KERNEL_ZSTD in the decompressor, shows dynamic relocations to
> > > some string constants, which correspond to the string literals in the
> > > switch statement in handle_zstd_error():
> > > 
> > >   Relocation section '.rela.data.rel.ro' at offset 0x277b0 contains 31 entries:
> > >       Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> > >   0000000000000000  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 73a
> > >   0000000000000008  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
> > >   0000000000000010  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
> > >   0000000000000018  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
> > >   ...
> > > 
> > > This optimization is problematic for the decompressor environment, as it
> > > is built as -fPIE without any explicit absolute references (as described
> > > at the top of misc.c) while not applying any dynamic relocations, hence
> > > the linker assertion. To opt out of this optimization, which is of
> > > little value in this special early boot code, disable jump tables in the
> > > decompressor when building with clang. This mirrors the other x86
> > > startup code in arch/x86/boot/startup.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Closes: https://github.com/ClangBuiltLinux/linux/issues/2165
> > > Link: https://github.com/llvm/llvm-project/commit/fa02a6ed66b1700c996b49c96c6bc0eb014c9518 [1]
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > >  arch/x86/boot/compressed/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > > index 07e0e64b9a98..1c0d29e3eeba 100644
> > > --- a/arch/x86/boot/compressed/Makefile
> > > +++ b/arch/x86/boot/compressed/Makefile
> > > @@ -31,6 +31,7 @@ KBUILD_CFLAGS += -Wundef
> > >  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> > >  cflags-$(CONFIG_X86_32) := -march=i386
> > >  cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
> > > +cflags-$(CONFIG_CC_IS_CLANG) += -fno-jump-tables
> > 
> > So, shouldn't we just use -fno-jump-tables for *all* compilers,
> > like we do in arch/x86/boot/startup/Makefile?
> > 
> > The point wouldn't be to just work around any Clang
> > jump-table optimization complications alone, but also
> > to synchronize the build options of very early code and such.
> 
> I'm sitting on a patch to unconditionally disable jump-tables for
> x86_64:
> 
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/syscall

In particular:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/syscall&id=76612388fe7aa41a8eb88f890d451bc17255eda0

> I need to fix the robot fallout and then actually post this.

That's perfect, thanks!

	Ingo
