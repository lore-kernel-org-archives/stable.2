Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638523;
	b=L9d5RZ549WmvjmEJkOQoUe97YaQI2/MhPVwEkwwOJ0AsQoZzDLLUL7U0SNcgqKd//4Bw
	 6VjjGOa8HQU37UAPjcRBWg278+khgTyuwa9TmMKTlCniNzZkTrWhnACEeF+lmlypBe9nb
	 apPPBeaj1RRltoLx0jep2NCIjgavD6KIf0h3Tq3lAcYx3L1HLrCi4qinKQcaIb1XRZ1xb
	 cv+7NTkucxKE6wOY6smc5hWXyTvDiTEj8R5m3jG9HljMYk9bb8kFHm9qjOL+LVc1vIjxZ
	 cxdnHc9c9poUnVexDWdZwH+xm/E0Eg93n9LcZnRmrwF17dwt/tbV6M9TCpmicVmdvqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638523;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=mlda20IdlBMocoURp9TWLKJ60Nes7uXkahJoHZw/DJ8=;
	b=0x2a/t0vJRhwbeWsufFfLSLh7VC0Rox5TY9PvLjK1JE94PNRY95g2UCFL2ShLNnGw/IC
	 aNDrYlOo3zo5AmALtiCIVWjLKARunEEXHmi8+A6dLxkW+iYL+zjg5q0+ZySiSFqdytl65
	 AB+Xp8XvWUgW4obKgaaEOSDDsHeK89GSly2rxGsyepChucjIgXniR12+9258w+Kzk+X27
	 wGmgu1wSINqiL6rsQYmW/lF6rGQn56N+rDeLQifLIR00Nvl6GdY2dOZRjhRght7FfGdU7
	 8pyRdQFTXqXOqhKqFJZDFEHN8KwEc+9DzvJUCa0F0lYKjXkUn6Uy6zIoZSMDVWABdVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiG1zZbi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA53606A31E;
	Wed, 25 Nov 2026 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiG1zZbi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2F81F000C0;
	Wed, 25 Nov 2026 20:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795638523;
	bh=mlda20IdlBMocoURp9TWLKJ60Nes7uXkahJoHZw/DJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DiG1zZbiN1Nq+gt8o+cgdM/UN1yJvF1qwZse1G7KAnup1sujHnyoFtzcOWe3ZZWTR
	 EdhpB1HDHsmI7s9wz3CNpzV2hozro1iLh1e6FG6B5Nq7Vf5IW10LVGAYtsG2+Y2tEm
	 c5zT0hOpzYoM4m8xsxZOAEUMhGGLm9CQqx84ELTXx35rFZSl1zSDA0gjcKp1YaTdqb
	 j7/gjZRyeJ+FOFyxzQzuRMUCZ3jYFXxGzw+XUcLC0mKFLdZcC2W6+dgqEMWZxtHRvE
	 o94HB+WULzeZOXt+XQp1GlKbbTEPuJh/pusich2ZIqHAw+KzhuixEZ0YSLVDwZoHRR
	 WI2/16RJgbdUQ==
Date: Wed, 25 Nov 2026 13:28:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nicolas Schier <nsc@kernel.org>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Julian Braha <julianbraha@gmail.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-kbuild@vger.kernel.org,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] kbuild: Introduce CONFIG_CROSS_COMPILING
Message-ID: <20261125202837.GB3625068@ax162>
References: <20261124-x86-no-march-native-on-non-x86_64-v3-0-268354149c5f@kernel.org>
 <20261124-x86-no-march-native-on-non-x86_64-v3-1-268354149c5f@kernel.org>
 <25eaa926-c244-40a5-b7b9-e5182e601446@t-8ch.de>
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
In-Reply-To: <25eaa926-c244-40a5-b7b9-e5182e601446@t-8ch.de>

On Wed, Nov 25, 2026 at 11:27:10AM +0100, Thomas Weißschuh wrote:
> The expansion to bit width and endianess will be a lot of busy-work.
> See the CC_CAN_LINK infrastructure.

Yeah, fair enough.

> We already have host-architecture detection in kbuild through
> scripts/subarch.include. So CC_HAS_MARCH_NATIVE could depend on
> $(ARCH) = $(SUBARCH), after exporting SUBARCH. Or maybe give the
> variable a better name, like HOSTARCH.
> 
> This would avoid the introduction of a new, not-really-correct flag
> and also the whack-a-mole that Boris complained about.

Ah, thanks a lot for reminding me about SUBARCH! In looking around, I
noticed that Kbuild already checks if SRCARCH = SUBARCH and exports
cross_compiling=1 in that case, which means this patch should just
become

diff --git a/scripts/Kconfig.toolchain b/scripts/Kconfig.toolchain
index 2acbd40a38f1..a8b5258eac7e 100644
--- a/scripts/Kconfig.toolchain
+++ b/scripts/Kconfig.toolchain
@@ -97,6 +97,9 @@ config RUSTC_CLANG_LLVM_COMPATIBLE
 	  LTO) require the same LLVM major version to work properly. For best
 	  compatibility it is recommended that the exact same LLVM is used.
 
+config CROSS_COMPILING
+	def_bool $(success,test "$(cross_compiling)" = "1")
+
 config ARCH_HAS_CC_CAN_LINK
 	bool
 
--

unless we did not want the separate symbol, in which case patch two
could just become

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 6e7a366f0798..b40aaff6867d 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -217,6 +217,7 @@ config RUSTC_HAS_APXF
 config X86_NATIVE_CPU
 	bool "Build and optimize for local/native CPU"
 	depends on X86_64
+	depends on $(success,test "$(cross_compiling)" = "")
 	depends on CC_HAS_MARCH_NATIVE
 	depends on !RUST || RUSTC_HAS_APXF
 	help
--

-tip folks, preferences?

-- 
Cheers,
Nathan
