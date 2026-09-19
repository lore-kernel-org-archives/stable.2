Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB3016F288;
	Sat, 19 Sep 2026 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789795952; cv=none; b=HhAPsBEdAbM9y0c+Xd084rWotjcMiAmAAiORt04JluFmAj6/JIjHgUNRr2qeivSwb4jQSU+rNO0JZ5SjHryZABRn61HdK4IEC2qBYXwsxQf4rHMRdIpYD6iEFXY4xmNSK8Cfmo+mhkCd50u85DcFnY2jmeKRXmdoK7rj1WgCpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789795952; c=relaxed/simple;
	bh=4A4g8E/94IeZz64wUX3jkkEDhfzm9SSK2/uRX4TZ6f4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NvVcYLGflzpo4Dsxk5r+sPdO4di88hP3PMQoVgBpsuUvuTU2quVwgdExvzO91aNSmKDeUWMWHXmnAoA8KfduoxDZX4qsFb+M4UoJ/Qz37LwaKCWAW5ihmSyB4HAUezrwJZmc08Aq43UPPNN3+FnEL9RZsx3C2vVI8z8jyk5kzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FEUttQhs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/fC751Rd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FEUttQhs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/fC751Rd"
Date: Sat, 19 Sep 2026 05:32:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789795949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bh4/Pvt+6PM+GRHdHym4RUzbWHoaJ0JCApvTw4ywPM=;
	b=FEUttQhsodwMUsmiqhLoH4053fUbHQeTqYGA6bVg8lMSVNo5w0BcMkSLAtCqrwAa1JnnEZ
	ln7MvYxZ2eN7dKoJ5s54xgLtbIAo/kDenr4V61kklqMMBVRi3sOt7kq6d6lqjlrL//ZJOk
	Ropnfou6LgFyLo2OO3XLYOiYsChDLuTWERclp4otIIR2bAlFfxjTKVqqIhoktIx5LYNCmT
	loAjjNwleko60go6uMOa4F6YF2DEtn50PcSmOGcyQUGq6wkywWCBjESV0Ovj+OXrYNLCHk
	csotkHxXe3+4YsT2tuCQSjQl17ZBepHr+ySlynVCBzvG7NMETlUffHcBrM9dGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789795949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bh4/Pvt+6PM+GRHdHym4RUzbWHoaJ0JCApvTw4ywPM=;
	b=/fC751RdXgy2q2NVwhUahqNBvOACz3lj0f/qWihw43m1oTAMHqJnGbCj3NF8li23dTvu95
	6hTx6/0RkApV8wAA==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/build/64: Prevent native builds from generating
 EGPR use
Cc: Omar Avelar <omar.avelar@intel.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Nathan Chancellor <nathan@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260916230003.1144622-1-chang.seok.bae@intel.com>
References: <20260916230003.1144622-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178979594725.2819794.8429178653655710718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     63edf5a009ae366369a1b484cd9ae4ee7c51946c
Gitweb:        https://git.kernel.org/tip/63edf5a009ae366369a1b484cd9ae4ee7c5=
1946c
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Wed, 16 Sep 2026 23:00:03=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 18 Sep 2026 21:43:38 -07:00

x86/build/64: Prevent native builds from generating EGPR use

Omar reports that CONFIG_X86_NATIVE_CPU=3Dy allows builds to opportunistically
emit instructions using %r16-%r31 (EGPRs) when the build host supports APX
since the commit:

  ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to local=
ly optimize the kernel with '-march=3Dnative'")

But the kernel is not yet prepared to use new registers internally. For
example, there is no context-switch support for general in-kernel use.

Explicitly disable EGPR use when building with -march=3Dnative.

For C, since GCC 14 and Clang 18, both compilers support suppressing EGPR
use with -mno-apx-features=3Degpr, whose availability can be detected via
cc-option.

For Rust, pass features=3D-apxf through the generated JSON to avoid
unstable-feature warnings, see

  https://github.com/rust-lang/rust/issues/139284

Note Rust only accepts the option to disable APX instructions entirely or not.

Support for this gating also depends on the Rust/LLVM combination. Rust
1.88 introduced the `apxf` feature option, but versions prior to 1.93 may
emit an `apxf` attribute to the backend that only LLVM 23 or later can
interpret. Restrict native Rust builds accordingly.

Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to =
locally optimize the kernel with '-march=3Dnative'")
Reported-by: Omar Avelar <omar.avelar@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260916230003.1144622-1-chang.seok.bae@intel.=
com
---
 arch/x86/Kconfig.cpu            | 11 +++++++++++
 arch/x86/Makefile               |  5 +++++
 scripts/generate_rust_target.rs |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index e465438..6e7a366 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -204,10 +204,21 @@ config CC_HAS_MARCH_NATIVE
 	# usage warnings that only appear wth '-march=3Dnative'.
 	depends on CC_IS_GCC || CLANG_VERSION >=3D 190100
=20
+config RUSTC_HAS_APXF
+	# The kernel isn't ready for in-kernel APX instructions. Without
+	# explicit frontend gating of APX, the backend may emit those
+	# instructions in native builds.
+	#
+	# Rust 1.88 added the `apxf` feature option, but versions before 1.93
+	# emit an `apxf` target attribute that only LLVM 23+ can interpret.
+	def_bool (RUSTC_VERSION >=3D 108800 && RUSTC_LLVM_MAJOR_VERSION >=3D 23) ||=
 \
+		 RUSTC_VERSION >=3D 109300
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
index 598f178..8af6b80 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -161,6 +161,11 @@ else
=20
 ifdef CONFIG_X86_NATIVE_CPU
         KBUILD_CFLAGS +=3D -march=3Dnative
+        # Prevent the compiler from generating EGPR use. The kernel is
+        # not yet prepared for general in-kernel use.
+        KBUILD_CFLAGS +=3D $(call cc-option,-mno-apx-features=3Degpr)
+
+        # generate_rust_target.rs handles Rust APX gating.
         KBUILD_RUSTFLAGS +=3D -Ctarget-cpu=3Dnative
 else
         KBUILD_CFLAGS +=3D -march=3Dx86-64 -mtune=3Dgeneric
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 3bf2965..7687b0d 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -224,6 +224,11 @@ fn main() {
             features +=3D ",+harden-sls-ijmp";
             features +=3D ",+harden-sls-ret";
         }
+        if cfg.has("X86_NATIVE_CPU") {
+            // Prevent the backend from generating APX instructions. The ker=
nel is not yet prepared
+            // for general in-kernel EGPR use.
+            features +=3D ",-apxf";
+        }
         ts.push("features", features);
         ts.push("llvm-target", "x86_64-linux-gnu");
         ts.push("supported-sanitizers", ["kcfi", "kernel-address"]);
