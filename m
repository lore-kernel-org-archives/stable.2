Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493D17DFE7;
	Wed, 24 Jun 2026 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339466; cv=none; b=MUpEhrvHz6lkcgQl1FUsheIg5yk/WAl+s+TvdAOhkUHMK75w588dE6TGcCqWyL1a61xfqA9iBmRZsdHxY7dVGz0L4lkkBxYI/hVXCqH34+zQyFV/DaG12EdOCqk8B5tqZ2Vb+ifOmmFqjdhBjVf0fZVVpOul58caNYkjmY/9K2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339466; c=relaxed/simple;
	bh=KGAEoNXM+X6r7G1OLOqYkfq4XezrCJ4j5qUYzl34gis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSHzdgtf5Tg5wM0/wOp5UpOfrkicUPKzuRPR5DmJSlD0uPZhV2/doFhQSwoKn1Z0n8LJ/bMODU5am9INsHIgnWkEdSw9Vnx+gaQMGrcvVE+JQ0oaC4Vl0I2FdKk0ZAzStXMFqIZpoTKqVRhFXU7ygWF15R6vkeEm9FYM7F9N15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThqsPopR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThqsPopR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ED41F000E9;
	Wed, 24 Jun 2026 22:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339465;
	bh=7r/QIb+MyviZ0cvAfiTnrfO+nnLRPdOlocQP+SmLxBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ThqsPopRFrXgXUpjCAdXsN5b+LL6eXvZh2bZit3FOqs6/3TGQbkmi47W5MqH7QL9F
	 6L5YzEW8XXAAfHUWOwm8oQPUYigAAhXRkbiGzSJ0dBU91jmFfMj1yKUxrp2Nl4/+az
	 cjUMrWV/eS5roZ+x2ejGWlcphJHk+GVcaetC/ErZq2uMfg4fGCyQ6WnhJRu96A5wEA
	 Fn9HODxixwGvUFYKr01Goh3+R+64T0OzwkvXNReIl40BhkXWiLer5twMmg8wWGMoSP
	 k8LN4TDHyteHqXz5lmvHBr1MKmyco73Sy6Uh27jVvOErHavqSIJqvse6PXtS9bYkpN
	 uD6vHkQotuamA==
Date: Wed, 24 Jun 2026 15:17:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Disable jump tables for clang
Message-ID: <20260624221739.GA7516@ax162>
References: <20260623-x86-boot-compressed-disable-jt-clang-v1-1-575fccd58107@kernel.org>
 <ajulLtY29HtgWokg@gmail.com>
 <20260624093848.GA48970@noisy.programming.kicks-ass.net>
 <ajuoqIk4tSV7CmFC@gmail.com>
 <ajupfkcZTTxGP2dG@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajupfkcZTTxGP2dG@gmail.com>

On Wed, Jun 24, 2026 at 11:55:10AM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> 
> > > I'm sitting on a patch to unconditionally disable jump-tables for
> > > x86_64:
> > > 
> > >   https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/syscall
> > 
> > In particular:
> > 
> >   https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/syscall&id=76612388fe7aa41a8eb88f890d451bc17255eda0
> 
> Side note: since arch/x86/boot/compressed/Makefile constructs
> its own KBUILD_CFLAGS, so a change to that Makefile will still
> be required to universally apply -fno-jump-tables and work
> around this Clang optimization in the decompression code.

Right. I had intentionally kept my change scoped to clang to be less
controversial but in the face of Peter's series, it makes sense to do it
for all compilers like Ingo suggested. I have no preference for how we
proceed here. I don't mind sending a v2 with something like

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 07e0e64b9a98..06934f9691d6 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -27,6 +27,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(CC_FLAGS_DIALECT)
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
+KBUILD_CFLAGS += -fno-jump-tables
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
--

Another option would be Peter folding that diff into his series then
once it lands, I could send this patch to the stable team with most of
this patch's justification intact with a note that the equivalent change
has been applied to mainline under a different justification. Just let
me know what you all would prefer.

-- 
Cheers,
Nathan
