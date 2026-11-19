Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795061842;
	b=e4/XNHvmiwJ7WKxr4BF2XPrYiJGc2xqeCRmR5MUrXbh2j562m+RQEBhuH148xGxXn0NQ
	 1hcnnAGjZ1NvBARG/81yCGkMnXQlUWU5CASjHhl4FYxQ41W8DwyEywb/ET8bEYgkFE+Nz
	 qnhifc8DDbEh0nADp9R4H3KAG2eprg6hyn8rnMRM3PAg1CU/uvndJeJI7iAPKhK1LdN0/
	 46VL1026tglQ2jPGUoBC+zzRJpYHzVc45eH06g4na2of+twaMbucAARt5y1+iyW12whc0
	 cwxf5r3dUyY0klZs4f6UPIxVO/+MwqlUBmnDJvRz6KgKUwyKC7rxczxa6gVuEk1wdKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795061842;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bime9q+xt/mMyBljVd8JNlkAWoM91LP/FgSUS7yT3ek=;
	b=kKqeHev/vWQuv0xYgLkvkvmx5X7NfmvCHAd8ir7m0+xXbTQd5tywn3qp5f3/xv7vkE6v
	 wxvlEvQVtuf1iHC5V/yMun7N0MsgeUTBIYbZAbo9Lsb16KmfgC88xF2I4iQBDJe9KVH4Z
	 +9QnHI1VvuByy6dbrzlZ1RCuT2tj4iP0fhSFA8Nfyi1cA//1f9Qq95/QvevqdCfrvRlCk
	 jIsImuspAswT3gmfo4D4IYik+CK/+s9sWKBSxosjEguuaCpzUral8qpQIBh3NZPmleDGH
	 zpcXIafBnaR68yiM7q36Jq43jT9WtuoCvNn1B/dOoWBYWGXAAZUTvtb67jf5soP/+Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hB4mqCxl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC9606A326;
	Thu, 19 Nov 2026 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hB4mqCxl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6301F000C4;
	Thu, 19 Nov 2026 04:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795061842;
	bh=bime9q+xt/mMyBljVd8JNlkAWoM91LP/FgSUS7yT3ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hB4mqCxlbre1uxuf/1qmW6YA6JfyokrzDz1UjD7wtFh1PQudHZTk7DrSZ4tjUgkqz
	 D136E46di7e139AmptrOn51NWoCU/EJSGnOD9o3+1bnwpxzf5qtCRQfAUTj1O6+UGx
	 cFJlsX0cF8NyFKuQO67dQ6p/sQoR+8NRLX/rRufXSS9BVwgqYdQRh13/2r7aame2H6
	 RCstza6l9RuGTdHsId4ci17KiFmsF7sB+eAi/jqNCcSxNnZuNPh63Acln7fKTLOg2v
	 ZIMGpY4pKdF61CaQzOQ1OFH8xDllWo1HHcsyC2KWp41M+kEmsXKsFuIKJCtBnCx35U
	 epDWiXFaaYjoQ==
Date: Wed, 18 Nov 2026 21:17:17 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <20261119041717.GB1218811@ax162>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com>
 <20261116130159.GA1327949@ax162>
 <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
 <20261116223628.5a6139a7@pumpkin>
 <20261118072848.GA325225@ax162>
 <20261118090035.15ced20c@pumpkin>
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
In-Reply-To: <20261118090035.15ced20c@pumpkin>

On Wed, Nov 18, 2026 at 09:00:35AM +0000, David Laight wrote:
> On Wed, 18 Nov 2026 00:28:48 -0700
> Nathan Chancellor <nathan@kernel.org> wrote:
> >   $ make ARCH=... LLVM=1
> > 
> > is generally all you need to do nowadays.
> > 
> 
> That requires that you also get the correct clang on $PATH.
> I'm sure I remember that not being as easy as it might seem.

Since

  e9c281928c24 ("kbuild: Make $(LLVM) more flexible")

in 5.18, you can pass a full prefix to clang, which can help ensure you
are using the right toolchain since the build will error if you do not
point it to the right path:

  $ make -skj"$(nproc)" ARCH=arm64 LLVM=/doesnt/exist/bin/ mrproper defconfig
  make[3]: /doesnt/exist/bin/clang: No such file or directory
  make[3]: /doesnt/exist/bin/clang: No such file or directory
  /bin/sh: line 1: /doesnt/exist/bin/clang: No such file or directory
  make[4]: *** [scripts/Makefile.host:114: scripts/basic/fixdep] Error 127

I use that when I am building with the kernel.org toolchains because
they live on disk in my home folder then I have clang tip in my path
that I can use with just LLVM=1.

-- 
Cheers,
Nathan
