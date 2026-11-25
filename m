Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589012;
	b=Wok3BwlStx/UcyxbfkYkPFaUPW03fNXcRgF1/uyGA8msGBuiTLPkzMUtxOfcnM29JleV
	 AyW/8iJr1GUyEZA+4DmR052ZM98alzsRwOxGq6DK/TCiXfBkeuq8sfhbZblIiShwAi99S
	 2oIzO8mWbrXUYk3hKAwuhdDrvxqWF69FaBxUnYnlwuZYhh97A7EUHYy3aFI/LTyvYy/bR
	 5QeA7SptdoBCCOemRKBAMFCOYYSm0NQNIFvO2WeBow8bfYCH5Z4gLVRQPOIyUtS5oPIre
	 sAgNhvZn7RpI6Xddnmc+A2hAqUPC07sJ3C68TpuftFsnpZy7x01BeofAWprJlXr3K2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589012;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AKC2tkDm00sEM5kiM7oiH6yWOlLbOjMsx2e0QI8ecJQ=;
	b=D5WLTLaoIgFli4M3IIJkmGhhbM/MOtJQmkVoFC8o1gOzLj2m1VFcrM/ymCbvyfd9T3bm
	 tdSsZjYnUXUJjBJiooA+xHtZTSmzFDzhujn+9A+UGQOOGpYxAxzC3p425kXXESiCpeu4Y
	 qLZ7a0Tu0OVHWryGyakp4OV6iFgDsj/wdGLc2oVi1/27tv8/kmKTFSZbDvKLhNtIis6Pr
	 K5WNqQk14ZB2SXhlw39NbiS0xTqstLIl0Vd50TrY8l7BNt9vROCMlC7tu4m+6o5djBzy7
	 UsNJr+PZvBkKNP7uIdtXs9Y4GV9HlKeTujavGzjtiEpnD/hHhQgM1Hfmov2Q64Mj83A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bdvf+s33;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D3606A326;
	Wed, 25 Nov 2026 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bdvf+s33
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0744D1F000C6;
	Wed, 25 Nov 2026 06:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795589012;
	bh=AKC2tkDm00sEM5kiM7oiH6yWOlLbOjMsx2e0QI8ecJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Bdvf+s33CkKn+4Ga6bHVw8r+eiybmiKYC1IP10NJhJ6SyJSGcXtuSUUdCHXJhdXhB
	 pT9ZQDs4nzgftdvJG8ZoHOUJexXqcsVmFYJW9TjTwEScmljdlVItY1T+shMPuSkFuZ
	 MeIbSjJ9PeNduyTL9KsM2HF1GQg4FBkfdqiY9DN79saQb7yeyyaC3ip4uP/pzAYFLT
	 p2d7luBGqw0szosl7tvKod+Lk73HowCjwIAbtoCeLGhu2SdLAQpc6rl6oX5hvL3+H8
	 IydMJTaFnTxzMkG8BtpBUMqmyADv++DVURVjc+luneI9TTMgXAJNfXfWHsZ7SQDQou
	 ArsCqbe6LkYoA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 24 Nov 2026 23:43:12 -0700
Subject: [PATCH v3 1/2] kbuild: Introduce CONFIG_CROSS_COMPILING
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
Message-Id: <20261124-x86-no-march-native-on-non-x86_64-v3-1-268354149c5f@kernel.org>
References: <20261124-x86-no-march-native-on-non-x86_64-v3-0-268354149c5f@kernel.org>
In-Reply-To: <20261124-x86-no-march-native-on-non-x86_64-v3-0-268354149c5f@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Julian Braha <julianbraha@gmail.com>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, stable@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3026; i=nathan@kernel.org;
 h=from:subject:message-id; bh=WCPVykomrLHR2RSfrqFhfpH7aLiC+e0g58OYuf5iZwc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDNlszZ3vjqzbIPH9xMXrJgKM91qDrvxdNSXsaUjTr/vul
 7ZGd0W0d5SyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJlOxnZHjnVLro6uZDDLsE
 wwqVOLO25pn8uFg3b6VqcFJS8rUjuY6MDM+3cRgus+X62WJr/U2XZWFmlllK6rrjEi57pk3P/Mq
 wjh8A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

There are times where decisions may want to be made within Kconfig when
cross compiling. Introduce a small script to call '$(HOSTCC) -v' and
'$(CC) -v' and compare the first part of the target triples to see if
they match.

This check is cheap but approximate, as Kconfig does not have all the
information available such as endianness and bit width for the target to
pass along to compiler. For example, a user building for x86 with a
compiler that can build both with '-m32' / '-m64' may have
CONFIG_CROSS_COMPILING set depending on the default value of the
toolchain and what's being targeted. Should this become problematic in
the future, the logic can be expanded to cover these corner cases but
for now, keep the implementation simple and cover the majority of cases.
Leave some informational prints to make it easy to debug future reports
with

  $ make ... run-command KBUILD_RUN_COMMAND='$(srctree)/scripts/check-cross-compiling.sh "$(HOSTCC)" "$(CC) $(CLANG_FLAGS)"'

Cc: stable@vger.kernel.org # dependency of future change
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 MAINTAINERS                      |  1 +
 scripts/Kconfig.toolchain        |  3 +++
 scripts/check-cross-compiling.sh | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..fb76f9e82f65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14454,6 +14454,7 @@ F:	scripts/Kbuild*
 F:	scripts/Makefile*
 F:	scripts/bash-completion/
 F:	scripts/basic/
+F:	scripts/check-cross-compiling.sh
 F:	scripts/clang-tools/
 F:	scripts/container
 F:	scripts/dummy-tools/
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
index 000000000000..4c1e6a061b3b
--- /dev/null
+++ b/scripts/check-cross-compiling.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+HOSTCC="$1"
+CC="$2"
+
+get_target() {
+    "$@" -v 2>&1 | grep -o 'Target: \([^-]\+\)'
+}
+
+if ! hostcc_target=$(get_target $HOSTCC); then
+    echo >&2 "$0: Could not get target for HOSTCC!"
+    exit 1
+fi
+
+if ! cc_target=$(get_target $CC); then
+    echo >&2 "$0: Could not get target for CC!"
+    exit 1
+fi
+
+echo "HOSTCC: '$hostcc_target'"
+echo "CC: '$cc_target'"
+
+if [ "$hostcc_target" = "$cc_target" ]; then
+    exit 1
+fi

-- 
2.56.1

