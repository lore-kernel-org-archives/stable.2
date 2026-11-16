Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794803456;
	b=otEYTUUrG5SIS4LgIDK9IInCje8gfKtx9fGAF2IU3IC1mXLZ/I0cT7PSxNw4WOdAJx2y
	 sA9HJ5CUCPTuC0o2UFmPVL2wm5aEl3NN6q9vT23tUto4VTcyoibWpM4TqJc28DkYvrDkf
	 G6PhtmZiatsvKYOmhlQ919c5gHGqqZtbutVWnM519lm1L1X8PpgWNXm5++W4HQeFot9Jn
	 XSrKJ6NPGQcp/gJVW7LwU1aMD6pW6F23508GsoV7x17Y6JtGp6xGgSdpPBJZw5c+4B6oS
	 kRAaNxjUT0S9HVb3dbpxn1wC/ue/dH8Bq8YPUSM1nR0rbvXJdBpj73INxGamGdiSISg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803456;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=C2F8XmMQBpvU9tOSLyw0S9t+s3HjR8DCgLXTbQAMCKc=;
	b=DMw85+gqK+mG0yNxkdZVumNBOnlfyod+DOOUrJG+yAUMiKkr9Nklhoq3tO38xD+SmqqF
	 Uz9dTyXj1Y4UdlKAPeAxG5EqiIoG4NdDgfw48ONLtV5GhQFf5JSTvCYMbUkfWXA0AaRUw
	 vI6TvbmKqyeobtaxi541OkIU+O9lES/45Nd1OJJhGFAnAwikNO5hbgDt67v8JT5ScHHBg
	 aV0c29t4F9CKOt5mhxviZh6Y2uuHXdI1Eys9rsjmrjq3cl5uujzvFflHfANAvliHkwbKG
	 Y3WIoKtZDAG98R6lqcS0axoM4SesO7uEF9xaH0hsb36Q0q2LVUbtWfz9ceIZHklDdsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eTyw/UfJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26D606A31F;
	Mon, 16 Nov 2026 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTyw/UfJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6544E1F000C4;
	Mon, 16 Nov 2026 04:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794803455;
	bh=C2F8XmMQBpvU9tOSLyw0S9t+s3HjR8DCgLXTbQAMCKc=;
	h=From:Date:Subject:To:Cc;
	b=eTyw/UfJ/KiNzafSsG0UnX1Oa0ESGdI8qkbO8u+ZrQxYmdu+GfnDIG27Wqh+TWjc/
	 R2bFpLAVNpEqFD7vIoIjh8H3+WoowH7a+mHQUD9AMwTas+GfUGluRrdPRFaBpL1Mzc
	 Tqe0IjiZ+M6Fx2F15VC3IEHba8U4m309PfpTgFl9vUpERXN35K9nIJfpZNm2ZmPBN6
	 29G04BuIwjv59HislwBXaO4/onFY/6gHjJDopV+GxKlU+DHhAOvYeg69SzOGpGLEzI
	 Af9IdmsAVQt/HDli2+6GSz52s6bvkcsWJb/ecXI4YRez+bLw1oRas9lnwDq25xGhlr
	 Oln7L69dEvl0Q==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sun, 15 Nov 2026 21:30:43 -0700
Subject: [PATCH v2] x86/build: Do not allow X86_NATIVE_CPU to be enabled
 when compile testing
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
Message-Id: <20261115-x86-no-march-native-on-non-x86_64-v2-1-fb3f9634b1bc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/5WOTQ7CIBSEr9Kw9plCG4quvIdpDNBniz9gAElN0
 7sL9QQuv5nJzCwkoDcYyLFaiMdkgnE2A9tVRE/SjghmyExYzTiltIFZcLAOntLrCayMJiE4myV
 brAtvQQjWNKoVshs6knteHq9m3jbO/Y/DW91Qx1JcEpMJ0fnPdiLRkvtnL1GgoJUWqj7wger2d
 Edv8bF3fiT9uq5fBmweJeUAAAA=
X-Change-ID: 20261113-x86-no-march-native-on-non-x86_64-88233b48a7d7
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3262; i=nathan@kernel.org;
 h=from:subject:message-id; bh=axCYzJiLRr+d6BQAO+BEztS8pV1010PYKmReuIhKqzQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFm/2r4L+Fp/k3ax01kTtV/3bHmUhMV+/Tp+/9Sy3m3q3
 1V/+TN3lLIwiHExyIopslQ/Vj1uaDjnLOONU5Ng5rAygQxh4OIUgIlYhDH8j1Gvk077unKuauft
 zCymBT+/+mTGPTqwzEfPItzwavrMvYwMLellt9UY+Kau3c51XlLgT1jw/rPzK1Vn1u9Y065tzT+
 bDQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When cross compiling x86_64 from an aarch64 machine using clang with
CONFIG_X86_NATIVE_CPU enabled (such as when using allmodconfig), there
may be a slew of warnings from each .c file, which makes it nearly
impossible to find real issues.

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
workaround that makes sense regardless of the toolchain issue, only
allow CONFIG_X86_NATIVE_CPU to be enabled when CONFIG_COMPILE_TEST is
not set (i.e., the user intends to run the kernel, not just build it),
which will exclude it from allmodconfig.

Cc: stable@vger.kernel.org
Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
Link: https://github.com/llvm/llvm-project/commit/e13ada6a3b236f505b24501d456dec2518e4944c [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Rather than checking if host == target, just make X86_NATIVE_CPU
  depend on !COMPILE_TEST, which makes sense anyways (Borislav)
- Link to v1: https://patch.msgid.link/20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org
---
 arch/x86/Kconfig.cpu | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 6e7a366f0798..32d22cbf55bf 100644
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

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20261113-x86-no-march-native-on-non-x86_64-88233b48a7d7

Best regards,
--  
Cheers,
Nathan

