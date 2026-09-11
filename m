Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD513E2ADB
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123289; cv=none; b=OyA+VvkU/K4hsy+MtK/N5YVOSAvBbhoSsH/nMAlN/rEF3psGVkHnuxoDe7ffGVfEVt6q1w0101MK0Nvkg4g8+9prx4mLNbR9A8lXIyV8pzdj568cjR4zU57/tzMDmdj4lGnvPZ80Ko9BKTVQkxNwc/La0gFpzwyfu81xOm3u4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123289; c=relaxed/simple;
	bh=hGqwF+5h+lpSvFoCSv9rXaUdzwwPiVbi72TRl5HOaJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3B4k2gvsBDgiza3Xr0cKcdbjaYqpWmLwNVfElbuF9WeMfT5atDnS2sDUSDoEriyz+d8InOukVxw4NEv2tr/hi8lr+050v+4EoSD6fKMfV7oqTVRlvHiqHC8Quk3ga8JOw0D4/9auiN0hwX/1rqY84GghKROG+8waS5O+YiEjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V95RjozZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V95RjozZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA9B1F00893;
	Fri, 11 Sep 2026 10:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123287;
	bh=HecUnSiwYBfoudvSs/t3IKwLdhjIAuD7aUvRhdhUnHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V95RjozZ5OZwyJvB9t59/MEHJ9lcFgXfO0TbrZk+RZIYbZSIc6PeaSK1iVBCeabHx
	 OzLhIx0Xa2CYWbL7wRrUAXVXA957blEPj4WHoNoKLSscP+DLFSkegsQaQlKGutBygU
	 JOZh/u/uZ1yLKLqSuGslqyGQiESUGlVYKTf/zknYkMNZARIWApWMpLNYWHcrI8Q0lt
	 YGJWPEn3PIGICV0cPt+0Z95zsJlGqXXWYi00xoKozj/Iiv85DiXNw5JlsVJJPsY7a5
	 DU2AxQTCLFRy66pLg7GTebuq4jJAQd4sYmHN4rxy8Vn/nemVoQHrQTQXx5RqkLk4Sk
	 4oG+N9w7ueYag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/9] KVM: x86: Move kvm_caps and kvm_host_values to asm/kvm_host.h
Date: Fri, 11 Sep 2026 06:41:16 -0400
Message-ID: <20260911104123.189614-2-sashal@kernel.org>
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

[ Upstream commit 9d2180ac561f9f7e73ec2b8f1834dfd0920c8e2e ]

Relocate the kvm_caps and kvm_host_values struct definitions and their
associated global variable declarations to asm/kvm_host.h to allow for a
variety of cleanups in x86.h and mmu.h, and to establish a (hopefully)
maintainable rule that asm/kvm_host.h's role is to define common
structures (and declare any associated globals), and anything needed by
arch-neutral KVM.

While it would be lovely to trim kvm_host.h down to the point where it
*only* holds things needed by arch-neutral and/or non-KVM code, multiple
attempts to do just that have failed miserably.  Trying to "hide" code
from arch-neutral KVM is too restrictive (and ultimately pointless), and
KVM x86 itself also needs a place to define common structures and their
globals, e.g. to avoid inconsistent header include chains and/or misplaced
helpers.

E.g. as pointed out by Kai, it's weird that x86.h, which is a kitchen sink
of sorts, includes regs.h, but not mmu.h.  Literally the only reason that
x86.h doesn't include mmu.h is that mmu.h references kvm_host, which is
currently defined in x86.h.  As a result of odd include ordering, the
very clearly MMU-specific helper mmu_is_nested() lives in x86.h, not mmu.h

"Fix" the kvm_host dependency so that x86.h can be the "central" include
everyone expects it to be, and set KVM x86 on the path to having somewhat
sensible "rules" for what goes where:

  - asm/kvm_host.h holds "common" structure definitions and associated key
    global variables, and things that are referenced by arch-neutral KVM.
  - <thing>.{c,h} holds relevant declarations and definitions.
  - x86.{c,h} is the kitchen sink for everything else.

Cc: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260613000329.732085-7-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e62392bf39eb ("KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h | 44 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h              | 45 ---------------------------------
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6db5b5f79df9b..6df6b47360dd0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -315,6 +315,50 @@ enum x86_intercept_stage;
 struct kvm_kernel_irqfd;
 struct kvm_kernel_irq_routing_entry;
 
+struct kvm_caps {
+	/* control of guest tsc rate supported? */
+	bool has_tsc_control;
+	/* maximum supported tsc_khz for guests */
+	u32  max_guest_tsc_khz;
+	/* number of bits of the fractional part of the TSC scaling ratio */
+	u8   tsc_scaling_ratio_frac_bits;
+	/* maximum allowed value of TSC scaling ratio */
+	u64  max_tsc_scaling_ratio;
+	/* 1ull << kvm_caps.tsc_scaling_ratio_frac_bits */
+	u64  default_tsc_scaling_ratio;
+	/* bus lock detection supported? */
+	bool has_bus_lock_exit;
+	/* notify VM exit supported? */
+	bool has_notify_vmexit;
+	/* bit mask of VM types */
+	u32 supported_vm_types;
+
+	u64 supported_mce_cap;
+	u64 supported_xcr0;
+	u64 supported_xss;
+	u64 supported_perf_cap;
+
+	u64 supported_quirks;
+	u64 inapplicable_quirks;
+};
+extern struct kvm_caps kvm_caps;
+
+struct kvm_host_values {
+	/*
+	 * The host's raw MAXPHYADDR, i.e. the number of non-reserved physical
+	 * address bits irrespective of features that repurpose legal bits,
+	 * e.g. MKTME.
+	 */
+	u8 maxphyaddr;
+
+	u64 efer;
+	u64 xcr0;
+	u64 xss;
+	u64 s_cet;
+	u64 arch_capabilities;
+};
+extern struct kvm_host_values kvm_host;
+
 /*
  * kvm_mmu_page_role tracks the properties of a shadow page (where shadow page
  * also includes TDP pages) to determine whether or not a page can be used in
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 9de577ef9c974..138d2cfe5ead8 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -12,48 +12,6 @@
 
 #define KVM_MAX_MCE_BANKS 32
 
-struct kvm_caps {
-	/* control of guest tsc rate supported? */
-	bool has_tsc_control;
-	/* maximum supported tsc_khz for guests */
-	u32  max_guest_tsc_khz;
-	/* number of bits of the fractional part of the TSC scaling ratio */
-	u8   tsc_scaling_ratio_frac_bits;
-	/* maximum allowed value of TSC scaling ratio */
-	u64  max_tsc_scaling_ratio;
-	/* 1ull << kvm_caps.tsc_scaling_ratio_frac_bits */
-	u64  default_tsc_scaling_ratio;
-	/* bus lock detection supported? */
-	bool has_bus_lock_exit;
-	/* notify VM exit supported? */
-	bool has_notify_vmexit;
-	/* bit mask of VM types */
-	u32 supported_vm_types;
-
-	u64 supported_mce_cap;
-	u64 supported_xcr0;
-	u64 supported_xss;
-	u64 supported_perf_cap;
-
-	u64 supported_quirks;
-	u64 inapplicable_quirks;
-};
-
-struct kvm_host_values {
-	/*
-	 * The host's raw MAXPHYADDR, i.e. the number of non-reserved physical
-	 * address bits irrespective of features that repurpose legal bits,
-	 * e.g. MKTME.
-	 */
-	u8 maxphyaddr;
-
-	u64 efer;
-	u64 xcr0;
-	u64 xss;
-	u64 s_cet;
-	u64 arch_capabilities;
-};
-
 void kvm_spurious_fault(void);
 
 #define SIZE_OF_MEMSLOTS_HASHTABLE \
@@ -416,9 +374,6 @@ fastpath_t handle_fastpath_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
 fastpath_t handle_fastpath_hlt(struct kvm_vcpu *vcpu);
 fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu);
 
-extern struct kvm_caps kvm_caps;
-extern struct kvm_host_values kvm_host;
-
 void kvm_setup_xss_caps(void);
 
 /*
-- 
2.53.0

