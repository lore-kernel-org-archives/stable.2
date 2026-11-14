Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616301;
	b=U4x7gIxvNfeSdW4Rrs5mBF30//Yimoz5cUNji+dmNfWtMQHSrKjSobGg14f9fTXAOO3A
	 UIE8GPqxmzIFxROXNE3OmvHU2y2QzXlcrjrcOmJdaEgvy9/Js7I1yVeQOdh2GlS7XMfQo
	 3y081cjN6WDGOs+e+ugjmI/l5dBVHxJluzYOy4q/XLcDMsZkhmU/Huzrn/+eVWgK8aXIP
	 OEJXAJXwwNrgPt0j+bk4i15NzimAqJxwQO3ZzgUa6b2bg2hzb1qpP0lc+oB2cIxRo+80G
	 Wv6nxYFqsZjUpcoUfFSipZyOsT0AjAGycuiEtMG7Acfv/G6mbuXTzbxxexLU7jNIXTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616301;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nWFJU6jG2nUMaqkeyLP3XCyQiCaq/xk6DozgGya/SAU=;
	b=fyQQ0h1M9Vkph7EQ4NRdI+B97AXnh1hI9JTMvtzfYOxXbQM+qeVdoZuvBrzN49qDNFiJ
	 8auomO+zCAehsLG4MtRM/8p4r8WQTCbNvl/TZF09vQJQqG9hzSaD0URdUs2dLDw7MjKRL
	 kFKtYDf+x9scESuqEIApRQzizVkzx8MxtDNq1Ffv1LW9NGIjvXsELkMZ/6LK298UMXmaA
	 hy/EPXXX8lpL6V6fDyVt818xkN0BhZVVfYwGI68CHXUgbESrGFQm0ehx5SPIXGICrTEdu
	 oOgOWcOp4d4nUgHPv2mUmtZzmNaAuHcLSwh4teXXiJsLHqKrb2F+qJY5qez2Y2+Pm/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMYaxWkO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA1606A886;
	Sat, 14 Nov 2026 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMYaxWkO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF691F000C4;
	Sat, 14 Nov 2026 00:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616301;
	bh=nWFJU6jG2nUMaqkeyLP3XCyQiCaq/xk6DozgGya/SAU=;
	h=From:Date:Subject:To:Cc;
	b=NMYaxWkOsZ5OMtX2IWuSRS7ohG7e+p4s0tg5fR5BZ4XxHMPiaipIoELxuCioerXY4
	 EGvAIcvR6vMXnGHMOEDUOQci62r5mSo3Rwfg2yN/Ds0H87ZG5ZKgrn2LJo5gmleD02
	 tFnlAdcsSjH7besKfiMWJkB00RoYhWrrEMmZYx2KRwikBtNkuGrnOAdMhxZfNvtJb7
	 +v9tIdkCEB4b/UBBmcTB6UQzkvMXf+9wosJ0nVTzfqmt53+ndo+bCEIdp08AyjTwuD
	 xB66YqTxQlL0KOjEdm+amiLhkoXyUWVWc6cOb3owunZ5NsaP8jmK6a4HNT20B7QgSA
	 XVyk/meUmfmSg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 13 Nov 2026 17:31:34 -0700
Subject: [PATCH] x86/build: Do not allow X86_NATIVE_CPU to be enabled on
 non-x86_64 hosts
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yWNUQqDMBAFryL73YUmkRh6lVIkxlW30E1JVATx7
 sb2c+bBvB0yJaYMj2qHRCtnjlJA3SoIk5eRkPvCoO/aKqUMbs6iRPz4FCYUP/NKGKUouabW1ui
 cNqarnW/6Bkrnm2jg7ffxfP05L92bwnyF4ThOEKG5RYUAAAA=
X-Change-ID: 20261113-x86-no-march-native-on-non-x86_64-88233b48a7d7
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878; i=nathan@kernel.org;
 h=from:subject:message-id; bh=eywPKAu/kU8DQhuF328zoSAitB85AxpSw0zyNWVg8h8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnfVz+f82PxgaNrppb4WrLuXaDId33OyXkvT4q3tc1/U
 x+q9jrnVkcpC4MYF4OsmCJL9WPV44aGc84y3jg1CWYOKxPIEAYuTgGYiEYdw3+3Euklt08v3unG
 f2v1xwbd6VtuW/H/1NjDtVvzvsUSC55rDP+MEgs4U1d+PPDB6F3Z49unRLnWdmn+3v9r6alNbfM
 Df/BxAgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When cross compiling x86_64 from an aarch64 machine using clang with
CONFIG_X86_NATIVE_CPU enabled, there may be a slew of warnings from each
.c file, which makes it nearly impossible to find real issues.

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

Internally, clang expands '-march=native' into a list of target features
to enable based on the detected CPU. The x86 part of the clang driver
notes

  // FIXME: Reject attempts to use -march=native unless the target matches
  // the host.

which was first added by the initial '-march=native' support in clang in
2009 [1] (other architecture drivers appear to have a similar problem).

Due to the lack of validation that the host CPU is an x86_64 CPU,
'-march=native' is expanded using the aarch64 host CPU's target
features, which are unrecognized by the x86 backend.

While this should obviously be fixed in the compiler, this does not help
currently released toolchains that have this issue. As a simple
workaround, only allow CONFIG_X86_NATIVE_CPU to be enabled when
targeting and running on an x86_64 host.

Cc: stable@vger.kernel.org
Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
Link: https://github.com/llvm/llvm-project/commit/e13ada6a3b236f505b24501d456dec2518e4944c [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 6e7a366f0798..4043b7227e36 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -216,7 +216,7 @@ config RUSTC_HAS_APXF
 
 config X86_NATIVE_CPU
 	bool "Build and optimize for local/native CPU"
-	depends on X86_64
+	depends on X86_64 && $(success,test "$(shell,uname -m)" = "x86_64")
 	depends on CC_HAS_MARCH_NATIVE
 	depends on !RUST || RUSTC_HAS_APXF
 	help

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20261113-x86-no-march-native-on-non-x86_64-88233b48a7d7

Best regards,
--  
Cheers,
Nathan

