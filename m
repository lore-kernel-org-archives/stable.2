Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822007;
	b=op9vEkO6QUWNDJVUKNtMDEpHZBVGRQzIG5mYLyUBgZ71KA5bFDAlRQgMg+P9gdyjLWok
	 0tI1zO1UnZVz8IIwB1VldXUvzvMDWKxX/bISBi4LcN4X28e+U4SlaXVzp4jcwbmskGYTd
	 mzfu8HtINbqsxV/A+QxCFpnX73DOO6gRfaU8xMMC8SD51UNJ+FSGhb6yBvBRGfoQv79ZW
	 6wjjTU+S9syI2HhSCUQh+f1Q5lJTcTyfWsDayzWpwwGmlftYYGdBFgcKQzl5oLzjMdu78
	 BgT4/e+NbXbT+aD6Lud5GgtzebSKjeamhl40tkD/2Lqt1DUUJIT+xwnSW9sGqOMrtJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822007;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=XQ+OBeDeOmk+ytQmg9fDb33P5Vaxo9hGwNAAAF0nKHA=;
	b=BJdEZhmft/7VZKQH2zRXYbgL2oaTcD7LWTVkchPVP1rIoPf9eJ1fkR6Z6nMdfPGsdac/
	 3UGfLSDdK1zKjVIMaTAnX4ie1uP51E+LIGN8iQE5Yj5J2L4v5X269UvWGHgL8+qH6FKc+
	 pD/ejf9nxXlfmwUfNZXbmBsNtrZdfLxlspTjcdMor/Ct1ea3YHUWg+helOOadIwPCdqvc
	 1QLiTlqKrDBRJQdBVmOIIMZf2u+fmF/Wx4skfbgq7bmITfidqmwOGy4kcEEBpP7YUe7XI
	 gQOzdaDGDAO5jUh9LMpf9YK94naM8OoiNeMDOTO9KWAiJx3jfWx0nF6prwVry/fRrfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=js4XJazp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20215606A31C;
	Mon, 16 Nov 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=js4XJazp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E701F000C4;
	Mon, 16 Nov 2026 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822006;
	bh=XQ+OBeDeOmk+ytQmg9fDb33P5Vaxo9hGwNAAAF0nKHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=js4XJazpaZKaaHhd/OMdq+l1uFyYnDLi8LdQmgKphxcYcapgoXB1xBOZVl5XMhfxy
	 QOehX/xsmZuvuwRNzHXpWylLTdMHS+vi+5fgWODyZcmAbUy/rAUY+zJS54mvAxEQBi
	 MHiRaz5SXWZqrSawXkns+P8pJy+xgulEw4awxc3fpm1xcwJkgIGK50meal2QcKysvL
	 SPet0fyrFf66wI2xxuf6mW3jy9tXDT1MsCu66AAoMsVoYYeOG5yvHiAC7vtIz/b8rj
	 UlGMdTUQBC+UQvEUNZwC+fobpJG6mCCEsO7UCscm1AFx1K1lRTMt1SYYsPpkGdXhP5
	 WCa+m/g5cD2ew==
Date: Mon, 16 Nov 2026 10:40:01 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <avrPcQ4sOkgJPbkZ@gmail.com>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>


* tip-bot2 for Nathan Chancellor <tip-bot2@linutronix.de> wrote:

> which was first added by the initial '-march=native' support in clang in 2009¹
> (other architecture drivers appear to have a similar problem).  Due to the lack
> of validation that the host CPU is an x86_64 CPU, '-march=native' is expanded
> using the aarch64 host CPU's target features, which are unrecognized by the x86
> backend.
> 
> While this should obviously be fixed in the compiler, this does not help
> currently released toolchains that have this issue. As a simple workaround that
> makes sense regardless of the toolchain issue, only allow CONFIG_X86_NATIVE_CPU
> to be enabled when CONFIG_COMPILE_TEST is not set (i.e., the user intends to run
> the kernel, not just build it), which will exclude it from allmodconfig.
> 
>   ¹https://github.com/llvm/llvm-project/commit/e13ada6a3b236f505b24501d456dec2518e4944c
> 
> Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org
> ---
>  arch/x86/Kconfig.cpu | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 6e7a366..32d22cb 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -217,6 +217,7 @@ config RUSTC_HAS_APXF
>  config X86_NATIVE_CPU
>  	bool "Build and optimize for local/native CPU"
>  	depends on X86_64
> +	depends on !COMPILE_TEST

I really don't like this patch. People *do* use this feature,
and it's good to have it enabled in allmodconfig.

Another problem is that this turns off most automated x86-on-x86
build testing of CONFIG_X86_NATIVE_CPU in essence, at least for the
typical configs that CI farms test, just to make much more rare
types of cross-builds a bit more convenient...

Can we just limit the feature to when host == target, ie. to not
work it around in such a crude fashion?

Thanks,

	Ingo
