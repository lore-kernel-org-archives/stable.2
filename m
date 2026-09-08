Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE64B4889;
	Tue,  8 Sep 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905662; cv=none; b=Ox7HbkpO8/GBA+S1DHJ8HyQLQS5xhHGWnQvywxqddQmd0TudWSVIMJuawnoo31I5rmvzyFM8GC4BV2sd+p31RogJ4FI8BFyGxznCba3TEG5J/bjzddMausM6e4jxEqtOMd9ae4Ai648ZTXUJqW8M+6HcMtzEV48kgsTuXnjyg4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905662; c=relaxed/simple;
	bh=/Gbbbl5DsNf6Sl6ZIKHJRLMh+EXYfejrdwZQTjky4Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSruS+PPlk5v91QIiBz417xt2Wl/Rzc94cjYVhk8NzRHCPNWKXB+k3TGHyHxFgQsMrRo/q+Hpe8mYT8H17Y1TADacWAZBd/1aZSzYuCqUq2NKZvRgTFEs5xlSOT81LXeH1AyuIPQ/B1INh9Pb+UtHMuEtrBkxl9mZ3m8fBQtgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WKOnYHS4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WKOnYHS4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WL8PR1cF+IzCQiYcl+pyURrUEtax4ylV5QBL0aKIFYs=; b=WKOnYHS4MCh0/HHRCOJHvvOo7Q
	0e/ppqBYETeu2qyt7V/9LDwfjozo7msFkHSz6dUlFt0AYcgkl4lu4zyHI5am9ihctAIfOxSp0p5zh
	CWvZv2iZfDJO/EvUAUMgy4DA5u2oJiJ2KCSdxG9JTOr5pzrvtDH0YipbqQT3aRSQTIHEBiY4eLgPR
	IZfzyoiweKmSzqwUTlqFkB7CatgTlfV0DJc8VAkc9x/MLoKq+PZnA+bP35bB1aSbvXqPCCLIlqVhz
	ycYU+V4hy8kSHA4eRo6aRm/3lILtmhyxXp/29iyCXQWWAYSoOoAL1N0CmhmBfccf1UUTH6tcQhnew
	+hrtAiDg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x444k-0000000E7Aw-0bsi;
	Tue, 08 Sep 2026 22:13:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5859F300EA2; Wed, 09 Sep 2026 00:13:57 +0200 (CEST)
Date: Wed, 9 Sep 2026 00:13:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/cfi: Fix FineIBT hash offset in cfi_get_func_hash()
Message-ID: <20260908221357.GY4120091@noisy.programming.kicks-ass.net>
References: <20260831-b4-x86-cfi-fineibt-func-hash-v1-1-6ffc0af5c4ec@gmail.com>
 <CADAM+B2jgDiyShSSXYoUG36C7yVpjx2NrhP6tOHeDjB0h+GvTA@mail.gmail.com>
 <CAADnVQLu-XiLxz_k02YK9xCgM8guoszby3O_m00_vdq5X8-w5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLu-XiLxz_k02YK9xCgM8guoszby3O_m00_vdq5X8-w5A@mail.gmail.com>

On Tue, Sep 08, 2026 at 09:37:46AM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 8, 2026 at 6:22 AM Soheil Hassas Yeganeh
> <soheil.kdev@gmail.com> wrote:
> >
> > On Mon, Aug 31, 2026 at 10:49 AM Soheil Hassas Yeganeh
> > <soheil.kdev@gmail.com> wrote:
> > >
> > > The switch of the FineIBT preamble from "subl $hash, %r10d" to the
> > > shorter "subl $hash, %eax" moved the hash immediate from offset 7 to
> > > offset 5 of the preamble. fineibt_preamble_hash was updated to match,
> > > but the open-coded offset in cfi_get_func_hash() was missed and it
> > > still reads the hash at offset 7.
> > >
> > > cfi_get_func_hash() is used by the BPF JIT to give a struct_ops
> > > trampoline the CFI hash of the stub function it stands in for. With
> > > FineIBT the trampoline now gets the upper half of the real hash
> > > followed by the first two bytes of the next instruction, so the first
> > > indirect call from the kernel into a struct_ops program,
> > > tcp_init_congestion_control() calling ->init() of a BPF congestion
> > > control for example, fails the FineIBT check and the kernel dies with
> > > a CFI failure.
> > >
> > > Move the FineIBT preamble template and its offset defines above
> > > cfi_get_func_hash() and use fineibt_preamble_hash there, so every
> > > reader of the preamble shares one definition of its layout. The
> > > CFI_FINEIBT arm is only built with CONFIG_FINEIBT, the only
> > > configuration in which cfi_mode can take that value.
> > > cfi_get_func_arity() does not need the same treatment: the __bhi_args
> > > call whose displacement it reads still ends at the function address.
> > >
> > > Fixes: 85a2d4a890dc ("x86,ibt: Use UDB instead of 0xEA")
> >
> > Gentle ping on this one. To recap: since 85a2d4a890dc the FineIBT preamble
> > stores the hash at +5, but cfi_get_func_hash() still reads it at +7, so BPF
> > struct_ops trampolines are emitted with a wrong hash and the first indirect call
> > through them (e.g. a bpf tcp_congestion_ops .cong_control) hits a FineIBT #CP.
> >
> > We have large scale panics when we use BPF congestion control.
> > Happy to respin if a different shape is preferred (e.g. moving the
> > offset next to
> > the preamble definition), but this seemed like the best way to fix the issue.
> 
> Looks fine to me. I guess it will go via tip tree?

Yes, I'll pick it up. Thanks!
