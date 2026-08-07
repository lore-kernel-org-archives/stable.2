Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F0477295;
	Fri,  7 Aug 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117412; cv=none; b=Ac5UAK4hlsE1hn6KHUOkQQ/T4BMHMrcqVwWB/vZmsx1gAAdEotutZ6ASITYnaqLzB7PnbnXRiSUJPPqmVGNeQYod45ltUDxHWAflXfMjjnwb45jm4Zi2fhKRe33nyfftThu2wcYFrhVzhC9TXU+JmRHUIrXJ8lV1ga9WSe4JHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117412; c=relaxed/simple;
	bh=TO0kvB1OAPSKiaZLH18B9ea4rcw+T+bBVp4XMedX6XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXMWyRxVUrlfEtMYzHCLJwu2Po6Ug9IsZcT2lI8dNLdIUDQPHPObx7pPpUhLab9HHdzRFgyfGFPkbO6kGsdZVnyBtHitgTGzTTJ/+wZSH0Xv5jrsJaImY6FbCrC9bPeOmrHGeHY40pHUzD8kMRKMbZVD4A4O18evZbkTniKIWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a363P9dq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a363P9dq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786117411; x=1817653411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TO0kvB1OAPSKiaZLH18B9ea4rcw+T+bBVp4XMedX6XI=;
  b=a363P9dqVBejDwEpEP/2Ud52gcGBLjnoAE6nRAuAcroE8whDgJOGG5KE
   /9PWcM+Qmx3WlNt89vbx4qxXaYOQeD8tdQFsBFvdxo/S2dlcAlj0Gquw1
   TvrtIE3183sNiyCcbMBetz1zUdzrVCau1b1FNz1RDTP6g/uoG+Hw0fOgH
   e52qbTfDF+gJYR8GMfSE1cthX0bFwqd4JxxbGpz3Sp89miHu3FJ2rBzkB
   bb7N8Iz6Ipn9XC4kkXKiqUeimczrHwiwHyLct6iJ14zVtf+cOrgRhO0nK
   aCyEGsAIZZH6wWKQp1c40L2Q/y9ZRCsQM+RMYqd0cBU5aEOy7CcUFuPAy
   w==;
X-CSE-ConnectionGUID: 5dew9daVSwiZ3rrUi93P5Q==
X-CSE-MsgGUID: nucQwhfWTrKOI1ChKerdFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="109520475"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="109520475"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 08:43:30 -0700
X-CSE-ConnectionGUID: aRRHcWwMQl+7t03s1BppJw==
X-CSE-MsgGUID: Jgcnn8/sSdqiMvD/j+wp0A==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287100890"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2026 08:43:29 -0700
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
Subject: [PATCH v2] x86/build/64: Prevent native builds from generating APX instructions
Date: Fri,  7 Aug 2026 15:17:15 +0000
Message-ID: <20260807151715.7247-1-chang.seok.bae@intel.com>
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
opportunistically emit APX instructions when the build host supports APX
since the commit.

But the kernel is not yet prepared to use APX internally. For example,
there is no context-switch support for general in-kernel use of the
extended GPRs.

Explicitly disable APX when building with -march=native.

For C, GCC 14 and Clang 18 both support disabling APX with -mno-apxf,
whose availability can be detected via cc-option.

For Rust, APX must be explicitly disabled because any backend supporting
APX may otherwise emit APX instructions with target-cpu=native. Pass
features=-apxf through the generated JSON to avoid unstable-feature
warnings.

Support for this gating also depends on the Rust/LLVM combination. Rust
1.88 introduced the `apxf` feature option, but versions prior to 1.93 may
emit an `apxf` attribute which LLVM 23 or later can interpret. Restrict
native Rust builds accordingly.

Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
Reported-by: Omar Avelar <omar.avelar@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Cc: <stable@vger.kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
---
V1 -> V2:
 * Use the JSON generator, and specify Rust/LLVM versions (Miguel Ojeda)
 * Lean into cc-option simply, and add a review tag (Nathan Chancellor)
 * I also ended up adding Fixes: just for easy backporting.
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
index 598f178102ee..866912ed2ec7 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -161,6 +161,11 @@ else
 
 ifdef CONFIG_X86_NATIVE_CPU
         KBUILD_CFLAGS += -march=native
+        # Prevent the compiler from generating APX instructions. The kernel is
+        # not yet prepared for general in-kernel APX use.
+        KBUILD_CFLAGS += $(call cc-option,-mno-apxf)
+
+        # generate_rust_target.rs handles Rust APX gating
         KBUILD_RUSTFLAGS += -Ctarget-cpu=native
 else
         KBUILD_CFLAGS += -march=x86-64 -mtune=generic
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 3bf296581a88..e0f9714ebdea 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -224,6 +224,11 @@ fn main() {
             features += ",+harden-sls-ijmp";
             features += ",+harden-sls-ret";
         }
+        if cfg.has("X86_NATIVE_CPU") {
+            // Prevent the backend from generating APX instructions. The kernel is not yet prepared
+            // for general in-kernel APX use.
+            features += ",-apxf";
+        }
         ts.push("features", features);
         ts.push("llvm-target", "x86_64-linux-gnu");
         ts.push("supported-sanitizers", ["kcfi", "kernel-address"]);
-- 
2.53.0

