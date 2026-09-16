Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963D4D0A05;
	Wed, 16 Sep 2026 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601209; cv=none; b=E5D751v60JLaRUeEvbiDdIv2niku6dN/d3jxIJuqTca1jYq041tBM0+vNOBC5NqlcrW9tNnBUc1rONUsDzAaQ1A4pMcY2/ChUbf7z+NniP9uFPK2BY9E213KCdcxF4wRFtTDukO3as200ezUYBgUZSut+qEcZ6++tUD9R4/GQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601209; c=relaxed/simple;
	bh=IENOVcYtYsbWwSqusBc7BQfxm1iixDKMq7rNodyy1DM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSIgxkfDu9RPhy5Tf6W/7AA1ib5NW20j81MlUYvykryTLlcRix1uUTDQS+X3NNaQWdfX3GGkYxIz2vXxK6cf1eY9Y+ulWe+oZA8NzmmngVnixpvXd9hht+uMRT02eAHab0znw55rfV96wJEY/DhfdToL5X+lO6+1ZYVtOrgLBvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3TnrklC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3TnrklC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789601209; x=1821137209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IENOVcYtYsbWwSqusBc7BQfxm1iixDKMq7rNodyy1DM=;
  b=C3TnrklCrKzoW3nWRQTWGOGLIm37t9AeykLPORiKCKyrq/cMXK42Sram
   9QYvRj9r8N4Rw9fTrmPJ9SxvwNTkXbyMtzC0jrmWbXqCnfx1mdcnQQ9pe
   Xkr8TsY6G2zWslbAr7Up7V/uASrU+D92wviV6iEv+4+0UKNI6DJZBKqd3
   yrHg/E3q7auQf5KHW7xsUqZNH1Qn4YtxggAwJASq8uJuqNMf2tqDd9wS6
   1Y3VUx/fmh5D5EhkccCV7JRDRBqKgMLi6E64m/42F1OY6eHHS3PpcGmAJ
   AZC8wkydoLsBGxmP5CQ9PWbjnDoq2AYfgNil+zJ1uA1nZ13PS1cGV9IMk
   w==;
X-CSE-ConnectionGUID: rFtaU3pdQA+hHw7tTknu5w==
X-CSE-MsgGUID: Y3Mn/XwvTtOb1E4MzOgJxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90008527"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90008527"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 16:26:48 -0700
X-CSE-ConnectionGUID: M9kAp7mCScKqJ296OMLjmw==
X-CSE-MsgGUID: 1Fj8XpchQQiTMPSOCo9kvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273457098"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 16 Sep 2026 16:26:47 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	rust-for-linux@vger.kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	ojeda@kernel.org,
	nathan@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	chang.seok.bae@intel.com,
	Omar Avelar <omar.avelar@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] x86/build/64: Prevent native builds from generating EGPR use
Date: Wed, 16 Sep 2026 23:00:03 +0000
Message-ID: <20260916230003.1144622-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Omar reported this broad concern to me, when resolving a separate issue
with his custom module. CONFIG_X86_NATIVE_CPU=y allows builds to
opportunistically emit instructions using %r16-%r31 (EGPRs) when the
build host supports APX since the commit:

  ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")

But the kernel is not yet prepared to use new registers internally. For
example, there is no context-switch support for general in-kernel use.

Explicitly disable EGPR use when building with -march=native.

For C, since GCC 14 and Clang 18, both compilers support suppressing EGPR
use with -mno-apx-features=egpr, whose availability can be detected via
cc-option.

For Rust, pass features=-apxf through the generated JSON to avoid
unstable-feature warnings [1]. Note Rust only accepts the option to
disable APX instructions entirely or not.

Support for this gating also depends on the Rust/LLVM combination. Rust
1.88 introduced the `apxf` feature option, but versions prior to 1.93 may
emit an `apxf` attribute to the backend that only LLVM 23 or later can
interpret. Restrict native Rust builds accordingly.

Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
Reported-by: Omar Avelar <omar.avelar@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://github.com/rust-lang/rust/issues/139284 [1]
---
V2 -> V3:
 * Specify to avoid EGPR use for C compilers.
 * Add a link to track Rust APX support (Miguel Ojeda)
 * Clarify the commit in the changelog (Miguel Ojeda)
 * Then, collect Ojeda's Ack tag
 * Massage changelog and comments

Test for the C compiler sub-option:
 * Ensured apx-features= from the sample code [1], first
 * Earliest versions for the native builds were chosen to check EGPR emits.
 * Check EGPR strings appearance from kernel builds, like before [2].
   Nothing was found.
 * Note PUSH2 as new instructions are not much found, either. But
   regardless of the amount of APX bring-up to legacy GPR use,
   mno-apx-features=egpr seems to just be fine for avoiding EGPR use

[1] https://gcc.gnu.org/git/?p=gcc.git;a=tree;f=gcc/testsuite/gcc.target/i386
[2] https://lore.kernel.org/all/fbbe2b57-19de-4480-b0c6-f44a6007a38f@intel.com/
---
 arch/x86/Kconfig.cpu            | 11 +++++++++++
 arch/x86/Makefile               |  5 +++++
 scripts/generate_rust_target.rs |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index e4654388d794..6e7a366f0798 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -204,10 +204,21 @@ config CC_HAS_MARCH_NATIVE
 	# usage warnings that only appear wth '-march=native'.
 	depends on CC_IS_GCC || CLANG_VERSION >= 190100
 
+config RUSTC_HAS_APXF
+	# The kernel isn't ready for in-kernel APX instructions. Without
+	# explicit frontend gating of APX, the backend may emit those
+	# instructions in native builds.
+	#
+	# Rust 1.88 added the `apxf` feature option, but versions before 1.93
+	# emit an `apxf` target attribute that only LLVM 23+ can interpret.
+	def_bool (RUSTC_VERSION >= 108800 && RUSTC_LLVM_MAJOR_VERSION >= 23) || \
+		 RUSTC_VERSION >= 109300
+
 config X86_NATIVE_CPU
 	bool "Build and optimize for local/native CPU"
 	depends on X86_64
 	depends on CC_HAS_MARCH_NATIVE
+	depends on !RUST || RUSTC_HAS_APXF
 	help
 	  Optimize for the current CPU used to compile the kernel.
 	  Use this option if you intend to build the kernel for your
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 598f178102ee..8af6b80cffdd 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -161,6 +161,11 @@ else
 
 ifdef CONFIG_X86_NATIVE_CPU
         KBUILD_CFLAGS += -march=native
+        # Prevent the compiler from generating EGPR use. The kernel is
+        # not yet prepared for general in-kernel use.
+        KBUILD_CFLAGS += $(call cc-option,-mno-apx-features=egpr)
+
+        # generate_rust_target.rs handles Rust APX gating.
         KBUILD_RUSTFLAGS += -Ctarget-cpu=native
 else
         KBUILD_CFLAGS += -march=x86-64 -mtune=generic
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 3bf296581a88..7687b0dd5474 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -224,6 +224,11 @@ fn main() {
             features += ",+harden-sls-ijmp";
             features += ",+harden-sls-ret";
         }
+        if cfg.has("X86_NATIVE_CPU") {
+            // Prevent the backend from generating APX instructions. The kernel is not yet prepared
+            // for general in-kernel EGPR use.
+            features += ",-apxf";
+        }
         ts.push("features", features);
         ts.push("llvm-target", "x86_64-linux-gnu");
         ts.push("supported-sanitizers", ["kcfi", "kernel-address"]);
-- 
2.53.0

