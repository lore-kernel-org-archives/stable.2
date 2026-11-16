Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809153;
	b=nv3aLjaOaskDoE7yLOr6OBYf7fRJ0UmDXEzJMKd9GDR3mmSDbjPTeidq1SZff/eFa5eQ
	 BREBsHvrSL4/RXh77dp/+/5bFXw1Cw3MUq/9MkkziBy/EOFyFyGQz3NXNV2CIgCGMvdxA
	 jDnu6rQec8UnjHkWvnurbRp5nHBBpOuppgmamNd2MjxVZH2weIXEAb09G9b9ZEtog6so1
	 TYN6FDLUJooFd+zTwl7NJjZmWiT1TFWCUIHI6+UVQkDZ2jFM6spFyKjrgFNWLGZRW4Kci
	 ygyFTFMTVLFzoHRTbztjeMSFD2x8V1xQYLRm4JD75IxxCUY5F0QD9vLpN9iLyJxEzDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809153;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:MIME-Version:Message-ID:Robot-ID:Robot-Unsubscribe:
	 Precedence:Content-Type:Content-Transfer-Encoding;
	bh=O198CPW1uAaL8ZuxNOIKDhpKphZLHhNKDxw7j7vMfOo=;
	b=Z1zJ0sHc8Tt4SfFwkD3Di0BcZUCVeeX9LBnzV56D967Egc/VnpJXqnG3CqaZs02WwxlE
	 2YIgxIO4djdPFjRPWsSQcQJY+V511dF3Zqzg7/P7bdkMdbwaUTwyUPC5kcnFyHdrvli3Y
	 vrRUr2BBcdcUGE34KmLtPcrUP7DfSP3GhFEsCkOLiTDhqvIWAhwWitfOVrP7W+NomSoeG
	 YqFmCQL+YMWLVxf9ySer6eNEH8Hvu1yMWN8u23b+H8nMBLExRGFM2JVk1G8kxXeDaV4D9
	 9MrXNyrB+inXcP29fVIHc+S/A1gb9zbPAg7S8471WpOiA9RAScmdK5eC0GFWFJgRB8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=yLgzdbZL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="uYm9K/rO";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AC606A89D;
	Mon, 16 Nov 2026 06:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 730AC606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=yLgzdbZL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uYm9K/rO
Date: Mon, 16 Nov 2026 06:05:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794809144;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=O198CPW1uAaL8ZuxNOIKDhpKphZLHhNKDxw7j7vMfOo=;
	b=yLgzdbZLo6s4eX0dYmJgnFHNgOgkmg+6Uy9Y369zL4hMf1h9EONOX8SYw+K9l4WRDvX7jQ
	cRboULpnu4gYpsFDTYKaiEcROPyFsbeG3Vsa87crbIY1qsbo3/suMdLfCodx6Y7zTETi/X
	tYdpsq7vJgE9oLIfE68kSF/iyAnk8a/AsDVNh8gIIHX4B/YhS9cEfJqFsTduR0sCe8jSgY
	Fk1scsT3rS0QYeoAIKGmT91zkGFB0OZN3/DAu/Nt4az/rZIGaF/5gPVtxixnKoGQalKck3
	EvzHkZ0SnJx8I72d+D7PMYrSoQAs3+FVDcIUGl7VdP9ddt1DxIxV4BRBj+EbiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794809144;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=O198CPW1uAaL8ZuxNOIKDhpKphZLHhNKDxw7j7vMfOo=;
	b=uYm9K/rOnJDc8qlYX6z+HlrUs7vZHVhITkDOaFNpzr8+bufoxacZwrLqM/jjoyvtKpbxx1
	j6Uuz70Fk4vgqXBQ==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2946884aff3d0e67227df3b4d3bcd9c3357a3b78
Gitweb:        https://git.kernel.org/tip/2946884aff3d0e67227df3b4d3bcd9c3357=
a3b78
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Sun, 15 Nov 2026 21:30:43 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 15 Nov 2026 20:43:50 -08:00

x86/build: Do not allow X86_NATIVE_CPU to be enabled when compile testing

When cross compiling x86_64 from an aarch64 machine using clang with
CONFIG_X86_NATIVE_CPU enabled (such as when using allmodconfig), there may be
a slew of warnings from each .c file, which makes it nearly impossible to find
real issues.

  '+crc' is not a recognized feature for this target (ignoring feature)
  '+fp-armv8' is not a recognized feature for this target (ignoring feature)
  '+lse' is not a recognized feature for this target (ignoring feature)
  '+neon' is not a recognized feature for this target (ignoring feature)
  '+sha2' is not a recognized feature for this target (ignoring feature)
  '+sha3' is not a recognized feature for this target (ignoring feature)
  '-rand' is not a recognized feature for this target (ignoring feature)
  '-sme' is not a recognized feature for this target (ignoring feature)
  '-sme2' is not a recognized feature for this target (ignoring feature)
  '-sve' is not a recognized feature for this target (ignoring feature)

Internally, clang expands '-march=3Dnative' into a list of target features to
enable based on the detected CPU. The x86 part of the clang driver notes

  // FIXME: Reject attempts to use -march=3Dnative unless the target matches
  // the host.

which was first added by the initial '-march=3Dnative' support in clang in 20=
09=C2=B9
(other architecture drivers appear to have a similar problem).  Due to the la=
ck
of validation that the host CPU is an x86_64 CPU, '-march=3Dnative' is expand=
ed
using the aarch64 host CPU's target features, which are unrecognized by the x=
86
backend.

While this should obviously be fixed in the compiler, this does not help
currently released toolchains that have this issue. As a simple workaround th=
at
makes sense regardless of the toolchain issue, only allow CONFIG_X86_NATIVE_C=
PU
to be enabled when CONFIG_COMPILE_TEST is not set (i.e., the user intends to =
run
the kernel, not just build it), which will exclude it from allmodconfig.

  =C2=B9https://github.com/llvm/llvm-project/commit/e13ada6a3b236f505b24501d4=
56dec2518e4944c

Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to =
locally optimize the kernel with '-march=3Dnative'")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20261113-x86-no-march-native-on-non-x86_64-v1=
-1-cbc8b096d1c4@kernel.org
---
 arch/x86/Kconfig.cpu | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 6e7a366..32d22cb 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -217,6 +217,7 @@ config RUSTC_HAS_APXF
 config X86_NATIVE_CPU
 	bool "Build and optimize for local/native CPU"
 	depends on X86_64
+	depends on !COMPILE_TEST
 	depends on CC_HAS_MARCH_NATIVE
 	depends on !RUST || RUSTC_HAS_APXF
 	help
