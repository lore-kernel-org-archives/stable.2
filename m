Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794687948;
	b=1q6Fm4lv3s7V2Kzhx3HsYkoLuojw7ktiBoIsytDRnGgXCCvG0mH3ggpW4o+SiRKvjNMt
	 Jz4HozAAHBbLbGVRYpFO0bEzuny/PNJnAuFsXAEw3T0Es+Nrx1dEZE9CkhnVOYTLTRRmV
	 IZV8CaX7zqSzlLde4YCiGEe1Pvgw7TCgpXB3tjPLegnIqiaFv1ao58RRbJF+jgkc9aVhh
	 ysaElTQsNXPE9xwSFxHOr505vfgAL0JlPiiGGjfzqziyXzy55VMotb0KUF6SvrCIwNQtf
	 73HPd955sWTKiVqM6ADZszabCOs5rkDRA0ZJ0dfEbrrg8AbvJEoY4bKTBNvyx9h+gIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794687948;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vRrAXztdODnH1CKdqe/Log9jwTdTF6QE5zhsHAVoEhY=;
	b=4mywGrl5T2HZNdOGdUOC6mB6CvYV1lUGVx8cVWiDPXXqLwEpxoouhPayRFKqB49QL/8H
	 MHJ06rq3IXfQ5/Pr5XEsPSBBImxf0iG4zG1ndg2PQ2JXN9KNoq7pF1HStByzP1h3Bf1MB
	 SpxFKwLJOrLGQD9vLIaJlwbcJfHK1+GWpxFpEFdEUpeWwtkaSsOingVMeKLtIKcNgfrg/
	 BRIgbZmYmGiIkN4GpdkqTogZP/5c9zSJWOke8DTdwAIRwiL2UVbwnc7kuG4GtDNBDvGlg
	 OQMWk+JFX20RHFVnebRwMoFJR56l8mIPi1mO1Zugm0X+oGXEbIIqfdR7W38wip/8pig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17941606A327;
	Sat, 14 Nov 2026 20:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17941606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 881E540E0140;
	Sat, 14 Nov 2026 20:25:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ixGd063xhOPR; Sat, 14 Nov 2026 20:25:41 +0000 (UTC)
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23FAF40E021B;
	Sat, 14 Nov 2026 20:25:28 +0000 (UTC)
Date: Sat, 14 Nov 2026 12:25:24 -0800
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/build: Do not allow X86_NATIVE_CPU to be enabled on
 non-x86_64 hosts
Message-ID: <20261114202524.GBavjDtC9Z3j7PrV3Y@fat_crate.local>
References: <20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org>

On Fri, Nov 13, 2026 at 05:31:34PM -0700, Nathan Chancellor wrote:
> When cross compiling x86_64 from an aarch64 machine using clang with
> CONFIG_X86_NATIVE_CPU enabled, there may be a slew of warnings from each
> .c file, which makes it nearly impossible to find real issues.
> 
>   '+crc' is not a recognized feature for this target (ignoring feature)
>   '+fp-armv8' is not a recognized feature for this target (ignoring feature)
>   '+lse' is not a recognized feature for this target (ignoring feature)
>   '+neon' is not a recognized feature for this target (ignoring feature)
>   '+sha2' is not a recognized feature for this target (ignoring feature)
>   '+sha3' is not a recognized feature for this target (ignoring feature)
>   '-rand' is not a recognized feature for this target (ignoring feature)
>   '-sme' is not a recognized feature for this target (ignoring feature)
>   '-sme2' is not a recognized feature for this target (ignoring feature)
>   '-sve' is not a recognized feature for this target (ignoring feature)
> 
> Internally, clang expands '-march=native' into a list of target features
> to enable based on the detected CPU. The x86 part of the clang driver
> notes
> 
>   // FIXME: Reject attempts to use -march=native unless the target matches
>   // the host.
> 
> which was first added by the initial '-march=native' support in clang in
> 2009 [1] (other architecture drivers appear to have a similar problem).
> 
> Due to the lack of validation that the host CPU is an x86_64 CPU,
> '-march=native' is expanded using the aarch64 host CPU's target
> features, which are unrecognized by the x86 backend.
> 
> While this should obviously be fixed in the compiler, this does not help
> currently released toolchains that have this issue. As a simple
> workaround, only allow CONFIG_X86_NATIVE_CPU to be enabled when
> targeting and running on an x86_64 host.
> 
> Cc: stable@vger.kernel.org
> Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
> Link: https://github.com/llvm/llvm-project/commit/e13ada6a3b236f505b24501d456dec2518e4944c [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/x86/Kconfig.cpu | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 6e7a366f0798..4043b7227e36 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -216,7 +216,7 @@ config RUSTC_HAS_APXF
>  
>  config X86_NATIVE_CPU
>  	bool "Build and optimize for local/native CPU"
> -	depends on X86_64
> +	depends on X86_64 && $(success,test "$(shell,uname -m)" = "x86_64")
>  	depends on CC_HAS_MARCH_NATIVE
>  	depends on !RUST || RUSTC_HAS_APXF
>  	help

This looks like a whack-a-mole-y fix to me. Especially if the other arches
would have the same problem.

So wouldn't a more generic fix checking

	native arch == target arch

somewhere in the makefile be better?

Thx. 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
