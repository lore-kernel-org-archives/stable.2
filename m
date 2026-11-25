Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589016;
	b=flObjlQFj6WCE3aaAeFfzASFJaP6deK5WtDZwPkZs/8dMiMZH3k9d5QwCTC3Z0Bky1rM
	 vgz3SU7Xy0rofnePHkLvw/L4zZ/Bdw5Hc+bOuZwqWMC7UcjU5+5XetI20FWDuQ5Sg3qSE
	 FE2/UmkQRGRIREvRnUU4jm4cgwsKKtI6a2TUUm9Iu/CgizsqIrDiEvlvYYMXZnOKnXXkw
	 FvM5c8riQTXNtbGJr5aF6gqTzVQrYx+uKkJ+f/vE3X/lZHZL6dMx5c2XjcuQ3aMJRBWRL
	 REjy9q/rlwTfFt6zgYfxbbZ5NGPUJ2/ryyna7rlrXj2nzVtLCqhqTZSi71iwg00rn1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589016;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sOC+NeNZnZIKWwtBoQTV3yfW3nKhuxBUNehzhh53VYI=;
	b=diNy3nRdvSl2wKTf/WhtfKIehdegYPJJUqv7bvp5qmvL8lrXdX/w1wLLfsqHiaOqFvEV
	 +XyrPTnKUJaE1osP7uZsQotJY7wFlxixWRtBCSqIFGD0zitV6N6SY+iBuJ2sNdw/6dUo/
	 3/k41Vd/IIirSxL6ZKimWC0NyH93BJv60yT1YnOWynbJ6jYBCxtWv0Y7V+GJnv1Gq1jQW
	 WTz3fICXeilZlhXfJN1v2jJQAqsGOH1mwAyjrzFnR62tpwdyEbt9utpcg9c/55HAcGAbN
	 AIJiEG0AJ1deIoDWUo8rdR6ezptqfpOTb3zK50iLwpG6jZXhdjCtB5ynr09jpXmJnRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7VoTffn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB7606A32D;
	Wed, 25 Nov 2026 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7VoTffn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F241F000E6;
	Wed, 25 Nov 2026 06:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795589015;
	bh=sOC+NeNZnZIKWwtBoQTV3yfW3nKhuxBUNehzhh53VYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U7VoTffnQGWxx2j/1VY2FCQiQA8641iaxbGA9oRIzUgTfY8EjY2JNbVxfJQeO5h2e
	 Iz18iZx+3qHXxxuSGX+E2toieae/uYNbEGdpZ/N7vhlQz8vR888jx6KHeGg6QwlN6O
	 ubZB8f/8989+2cA2Fi0T3cLTvDmZXES7V2PMFZ5YEMFGELdXTo42AESNlF9AcNpTYX
	 adVeBsEf+yhkaZLVM+1XRLubzL6KLrNzwVMNpBEXejJvyz3x2ZBZojimq41WaudO3G
	 ciJ4bvz736Pj68C6MFDDBMDokkMpoFKTrtGh0CYiUKuksBQEQBRwTBLSUfp6u65X9i
	 l6n2CpAq2THBA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 24 Nov 2026 23:43:13 -0700
Subject: [PATCH v3 2/2] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when cross compiling
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
Message-Id: <20261124-x86-no-march-native-on-non-x86_64-v3-2-268354149c5f@kernel.org>
References: <20261124-x86-no-march-native-on-non-x86_64-v3-0-268354149c5f@kernel.org>
In-Reply-To: <20261124-x86-no-march-native-on-non-x86_64-v3-0-268354149c5f@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Julian Braha <julianbraha@gmail.com>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=nathan@kernel.org;
 h=from:subject:message-id; bh=pE4J5z4PIx85VL9R2WLR9Mor+YWdntAS7QdpD+4R0WM=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDNlszZ1+zXq+E3Wmy66+9Cct50GqBrPNgdy400l68/lkp
 C4Y2j/oKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABNx7Gf4n5pqKWZ96fnlJU3P
 9j+LFtHvuF7Yq+qS5a3Btt6q6LbbX4b/nnODHs/T4m1+n3KYc+rOkDnXVu8tmr/18N89vd3du2O
 v8QEA
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

While this should obviously be fixed in the compiler [2], this does not
help currently released toolchains that have this issue. As a simple
workaround that makes sense regardless of the toolchain issue, only
allow CONFIG_X86_NATIVE_CPU to be enabled when CONFIG_CROSS_COMPILING is
not set (i.e., it is known that the host and target architectures are
the same).

Cc: stable@vger.kernel.org
Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
Link: https://github.com/llvm/llvm-project/commit/e13ada6a3b236f505b24501d456dec2518e4944c [1]
Link: https://github.com/llvm/llvm-project/issues/243260
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/Kconfig.cpu | 1 +
 1 file changed, 1 insertion(+)

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

-- 
2.56.1

