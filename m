Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861921;
	b=I4pZPZbewnimNxVJVlHGVazlnodo26wep33vOp/1qQykOqiDtupgGY7uaKefEjVEK6qa
	 HUaQHVmZ0Q7uPNRLYMQhDTRM1YZDI3EETPipwMggIR8L8t5vGiHGrgXdZOS84T/Jin/K6
	 j/ZsBL2ANmLnzgTWcH5/Ji4FMRP7fk2ur2/O1rICmC8oV1vm3aN6BmfTFRgEHbX+2Sk/V
	 s9l297XT694RA2VX8qEbbsbH9z4fRyPox4URkJX/6meO8xUJIlXvv8KKXIE977x6CJffa
	 fyk3eXHfDLo2he3M5iHvQsCTVXpF9AIx0swsRRUz9YmPNFbvxiru9lOH7Z9KJ7PIJew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861921;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i74bkDZDW2utys7XBRaw8ZBdMRzIuwI/mGYldrQ8McI=;
	b=xHKCadvZBDHGbA2ggI0Fx3jhlEl88QNtHJ7RbNdCvBqzLJbC6TTFsPMgTYe93YiVZmSH
	 peHe7w/cBsxrfmabUejOVGpUGGY9h8v54MkN0LKPSUtbABuxrPvRgtrhZy+AKRU3QgJFd
	 Bh7AHViuNhKzQFTjoj2/1ocf2oaeUJwja+bTn9qp3xnc7PLEi2gaKTGdZn1wujpHZK4tb
	 6CB+tUAQBrThP2yJ7fTA2sMyMVFt7BXLo6IrBsyXfG8h17SNjEdJzGEdJPQV36UU9Psrq
	 v1w1k8xb7BMqb+mgfbKpGYFEkPYVHqd4P3mKFjrwsnyYUgEcfaeB4G/1tysWozO3KNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Topt6J5Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5970606A882;
	Mon, 16 Nov 2026 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Topt6J5Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079221F000C4;
	Mon, 16 Nov 2026 20:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794861921;
	bh=i74bkDZDW2utys7XBRaw8ZBdMRzIuwI/mGYldrQ8McI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Topt6J5YLjpoEdU0G7nd51NYyv9gldy85Wfl2RY+5bzO9TFA/nLEPSFGzVfVGII3u
	 sYUZwD8bmbLiQQHcBBJE4NVQ/as9wlHsXad2eOP6NHdWGMr1+42PhKSRhqwuiqH4VO
	 AMW+j9F0rbAExTOqhX+235UAe0vhGPjFQk5CXW+VvTXrwnAnApKDEcO/R6BK9ZZnVl
	 4xAVMMx1HIb5XRVSIRqicT3ixlZpEyPLoxLUeUwmkVg8tLgN3+ebqeGptFQ1nIKcsJ
	 72MEQYR18cDN5B1FRUHnqoTvVt9NlT7iwuTh/SezDln9X6RXAgvL/3+vOFfoeyIeTl
	 mvAPrEZaBbA8A==
Date: Mon, 16 Nov 2026 13:45:17 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <20261116204517.GB1037705@ax162>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com>
 <20261116130159.GA1327949@ax162>
 <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
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
In-Reply-To: <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>

On Mon, Nov 16, 2026 at 07:48:34AM -0800, Linus Torvalds wrote:
> On Mon, 16 Nov 2026 at 05:02, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Mon, Nov 16, 2026 at 10:40:01AM +0100, Ingo Molnar wrote:
> > > Can we just limit the feature to when host == target, ie. to not
> > > work it around in such a crude fashion?
> >
> > That was my v1 but Boris didn't like it:
> >
> >   https://lore.kernel.org/20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org
> 
> Well, that is admittedly very crude and hacky.

I guess that's one way to describe it.

> Maybe we should have some config variables that depend on HOSTCC, and
> detect it *that* way. It does appear that we don't have any model for
> cross-compiling in the Kconfig setup, but maybe  we should..
> 
> I'd actually love to have support for making the compiler itself part
> of Kconfig, so that the gcc-vs-clang could be *in* the .config file
> rather than being an external thing to it.

I guess you mean having CC and HOSTCC and friends as values in Kconfig?

> I've mentioned that before, and the problem has typically been that we
> end up depending on 'CC' outside of the Kconfig scripts and
> independently of the current config.
> 
> The recent work to move the compiler flags into Kconfig itself may
> have lessened some of those dependencies, but there's probably still
> lots of small details.
> 
> But for the whole "cross-compile", maybe we can just say that
> X86_NATIVE_CPU depends on '$CC' being the same as '$HOSTCC'.

Unfortunately, that would not for the LLVM case that the commit message
brings up since HOSTCC == CC (we switch targets using '--target'),

> Or even do '$(CC) -v" and '$(HOSTCC) -v' and check for 'Target' being
> the same, and having a CONFIG_CROSSCOMPILE thing for that?

Hmmm, not a bad idea. That does seems to work based on my initial tests,
which would probably be the most generic way to solve this? I am not
sure I want to extrapolate '-march=native' out of x86 right now since I
think architecture maintainers should have the option to support it or
not. However, this would at least lay the ground work for generically
abstracting it (hopefully making Boris happy) and allowing it to still
be enabled in the allmodconfig case (hopefully making Ingo happy) while
still resolving my original issue.

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 6e7a366f0798..4643b3482d94 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -217,6 +217,7 @@ config RUSTC_HAS_APXF
 config X86_NATIVE_CPU
 	bool "Build and optimize for local/native CPU"
 	depends on X86_64
+	depends on !CROSS_COMPILING
 	depends on CC_HAS_MARCH_NATIVE
 	depends on !RUST || RUSTC_HAS_APXF
 	help
diff --git a/scripts/Kconfig.toolchain b/scripts/Kconfig.toolchain
index 2acbd40a38f1..ac2e3de50ac0 100644
--- a/scripts/Kconfig.toolchain
+++ b/scripts/Kconfig.toolchain
@@ -32,6 +32,9 @@ config CLANG_VERSION
 	default $(cc-version) if CC_IS_CLANG
 	default 0
 
+config CROSS_COMPILING
+	def_bool $(success,$(srctree)/scripts/check-cross-compiling.sh "$(HOSTCC)" "$(CC) $(CLANG_FLAGS)")
+
 config AS_IS_GNU
 	def_bool $(success,test "$(as-name)" = GNU)
 
diff --git a/scripts/check-cross-compiling.sh b/scripts/check-cross-compiling.sh
new file mode 100755
index 000000000000..fd1af38926a9
--- /dev/null
+++ b/scripts/check-cross-compiling.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+hostcc="$1"
+cc="$2"
+
+get_target() {
+    "$@" -v 2>&1 | grep -o 'Target: \([^-]\+\)'
+}
+if ! hostcc_target=$(get_target $hostcc); then
+    echo >&2 "Could not get target for HOSTCC!"
+    return 1
+fi
+if ! cc_target=$(get_target $cc); then
+    echo >&2 "Could not get target for CC!"
+    return 1
+fi
+
+test "$hostcc_target" != "$cc_target"
-- 
Cheers,
Nathan
