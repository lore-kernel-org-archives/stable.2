Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7258543CEF5
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123290; cv=none; b=i6gKOLUsHZ0r43irwSpAwM/YN/qpkkPE/nWhdwc4hAornBc7Cf+Z1l61gw/Ozhzu8USO3hjV5fiV5MDrZDujazHjHzNZfsC5DIGM1W1KRQtFUX+cu4iy2A3X2FlEF3kLMdJ2Tjg0Dt5o0/H8QWQG1ZYMiRKucRHpa+UwbCIm07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123290; c=relaxed/simple;
	bh=0za5ZR+CKDq5+fLhBfbIqAGWJoGZ3Q7YS1LRIrc1Qqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlm5bfAicSLW6NHNGsjozWT0dFO3+kFpq05TFMbPD84VcSkrSN5VC67+LWTGYZA7XgL8unYFdVR5Sq2SEevfCmYl20Pn+KJeOYMlmFI+qqDmLxqI7ETox/k7P3/FF8e+1GhuDPcGZqXAmKD1vxbhNMklxVtzmpmx4EYVW/dkT0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtjqfdzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtjqfdzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6609C1F0089A;
	Fri, 11 Sep 2026 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123289;
	bh=MH8o8Qk/y00Z2oGLVH7Jfq+FRhKT3ny8S6c50xix4OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JtjqfdzTfTK3CgzPJ0HAA8smZQKDZi2pSJnsFGr1bved4e3U0WyMj9IckQss+HEL1
	 GCQTy4oBFt1iQOy9z4ZPrk7m1sBML3LOGvMXtuC9bx8+7HvSQOS8RqcIOXkxvzwoqw
	 xT2WQ0+uboQY7KumFHybWzV8qTb+94MparcznbVqiksnUthtwhNaei/9Ae0Zp5mRZo
	 gjynIL4k4ZzBZqPr/GJLKNJZ4CK06MBqxrq7QRhzd1Slj7o5lVgD+mYvUBaJd4Njf0
	 LF5kaoaL3HstVbUbpyUuetyUaZYcG8PruIKxV7Go85f8Dl8nRG/G11J2FQHHwjGfW3
	 c1okSXnxIf8zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 4/9] KVM: x86: Move eager_page_split to mmu.{c,h}
Date: Fri, 11 Sep 2026 06:41:18 -0400
Message-ID: <20260911104123.189614-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104123.189614-1-sashal@kernel.org>
References: <2026090914-waviness-supermom-9b84@gregkh>
 <20260911104123.189614-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit cde542b6526639571a848e1d70f8ff6817e40e4e ]

Move KVM's eager_page_split module param to the MMU, as it is very much an
MMU knob.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-10-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e62392bf39eb ("KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu.h     | 1 +
 arch/x86/kvm/mmu/mmu.c | 3 +++
 arch/x86/kvm/x86.c     | 3 ---
 arch/x86/kvm/x86.h     | 2 --
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index f9e137cc831fe..fc28c4ce90ef7 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -7,6 +7,7 @@
 #include "cpuid.h"
 
 extern bool __read_mostly enable_mmio_caching;
+extern bool eager_page_split;
 
 #define PT_WRITABLE_SHIFT 1
 #define PT_USER_SHIFT 2
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a61750f8e1e37..d479fe7d423d2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -115,6 +115,9 @@ module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0444);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(tdp_mmu_enabled);
 #endif
 
+bool __read_mostly eager_page_split = true;
+module_param(eager_page_split, bool, 0644);
+
 static int max_huge_page_level __read_mostly;
 static int tdp_root_level __read_mostly;
 static int max_tdp_level __read_mostly;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 55d064c89c148..ba61dc1b082ee 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -183,9 +183,6 @@ module_param(force_emulation_prefix, int, 0644);
 int __read_mostly pi_inject_timer = -1;
 module_param(pi_inject_timer, bint, 0644);
 
-bool __read_mostly eager_page_split = true;
-module_param(eager_page_split, bool, 0644);
-
 /* Enable/disable SMT_RSB bug mitigation */
 static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index e5ece3eeb4f16..b7e0f554f804f 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -414,8 +414,6 @@ extern int pi_inject_timer;
 
 extern bool report_ignored_msrs;
 
-extern bool eager_page_split;
-
 static inline void kvm_pr_unimpl_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	if (report_ignored_msrs)
-- 
2.53.0

