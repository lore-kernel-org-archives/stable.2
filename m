Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795943B4A8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123292; cv=none; b=JHS6/BQTekr2Ll2xUPchQ/7ilo/iAZdbI4csi7KgOkNMZX3svQKYyytxgoalpWwuX6loS+7m/iIINBKgtPMqx6YF8KZeL7UaCOG4GMV24+TTzCWaZVuhXLK38RKBzMQwUr5zihtfMO7AMcf7NAepDH+1CsFfIOqtDPPijGDXxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123292; c=relaxed/simple;
	bh=S4gQUwDbeA4VBGI/u69zyOcyWUqPUh4LBE0nobf8ab8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1wz9r7FSs/rlMisBCvtlPlwkzmAaCG6t2aW6Jnju9lY7zD2d3+LCifkSkLsixHblXYLNwr5aODCQlzLvoKSXNGx4csukf3VyycttIAWCrupMqMoxtyRcdUmx4/KKprayLGBqS3PxrRkvAsKCZfryBxvyEQsmwf/ux+o8TqBZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8er18R3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8er18R3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9F41F000FF;
	Fri, 11 Sep 2026 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123290;
	bh=hwr0UgVWGpmWxFjHtKvb6P3gRj8NoytphTHJ3k8ScBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z8er18R3MldkK5/6qOVuB8yPwRH7k8yoKsoizQ84goRQXJHaYXs5RCX3SXVI1VULA
	 +F4fA6ZRsPbkKABSnVih0OLfwPSmh0YaTV9EPAiOdg6nh0vPW5L/ShkA0tasoIq5iE
	 B2rdVotvisH0P7/okgMb3Vo4Pzt9ebDxqVE/Bbfu6cLz+Fzdw2F6eO3hEF9xGEgfUy
	 McZ7vx9Rgei28bKP2ax91y1iflC9xtZ0Qe/ikneN7T9JvEsu2/Nzqd6+L1bBNm5hj7
	 NGZPl74I4WMHYpvjJxPWzDQcLjVjDLmYwcDUiEMfREFiKylWPy1bwO3rSGM8dGVG2A
	 oyJpd+UZrnJzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 5/9] KVM: x86: Move kvm_{load,put}_guest_fpu() to fpu.h
Date: Fri, 11 Sep 2026 06:41:19 -0400
Message-ID: <20260911104123.189614-5-sashal@kernel.org>
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

[ Upstream commit c392e508ffb0792b9e974ce65b10f5363aefc719 ]

Move the kvm_{load,put}_guest_fpu() helpers to fpu.h in anticipation of
moving the bulk of KVM's MSR handling code out of x86.c.  KVM needs to
load and put the FPU when accessing MSRs that are managed via XSTATE,
a.k.a. the so called "FPU".

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-12-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e62392bf39eb ("KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/fpu.h | 26 ++++++++++++++++++++++++++
 arch/x86/kvm/x86.c | 24 ------------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/fpu.h b/arch/x86/kvm/fpu.h
index f898781b6a068..6b7b628f530da 100644
--- a/arch/x86/kvm/fpu.h
+++ b/arch/x86/kvm/fpu.h
@@ -3,8 +3,34 @@
 #ifndef __KVM_FPU_H_
 #define __KVM_FPU_H_
 
+#include <linux/kvm_host.h>
+
+#include <trace/events/kvm.h>
+
 #include <asm/fpu/api.h>
 
+/* Swap (qemu) user FPU context for the guest FPU context. */
+static inline void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
+{
+	if (KVM_BUG_ON(vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
+		return;
+
+	/* Exclude PKRU, it's restored separately immediately after VM-Exit. */
+	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, true);
+	trace_kvm_fpu(1);
+}
+
+/* When vcpu_run ends, restore user space FPU context. */
+static inline void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
+{
+	if (KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
+		return;
+
+	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, false);
+	++vcpu->stat.fpu_reload;
+	trace_kvm_fpu(0);
+}
+
 typedef u32		__attribute__((vector_size(16))) sse128_t;
 #define __sse128_u	union { sse128_t vec; u64 as_u64[2]; u32 as_u32[4]; }
 #define sse128_lo(x)	({ __sse128_u t; t.vec = x; t.as_u64[0]; })
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ba61dc1b082ee..6c27b4aa98743 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -139,8 +139,6 @@ static void kvm_vcpu_ioctl_x86_get_sregs2(struct kvm_vcpu *vcpu,
 					  struct kvm_sregs2 *sregs2);
 
 static DEFINE_MUTEX(vendor_module_lock);
-static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
-static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
 
 struct kvm_x86_ops kvm_x86_ops __read_mostly;
 
@@ -11901,28 +11899,6 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-/* Swap (qemu) user FPU context for the guest FPU context. */
-static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
-{
-	if (KVM_BUG_ON(vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
-		return;
-
-	/* Exclude PKRU, it's restored separately immediately after VM-Exit. */
-	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, true);
-	trace_kvm_fpu(1);
-}
-
-/* When vcpu_run ends, restore user space FPU context. */
-static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
-{
-	if (KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
-		return;
-
-	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, false);
-	++vcpu->stat.fpu_reload;
-	trace_kvm_fpu(0);
-}
-
 static int kvm_x86_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
 	/*
-- 
2.53.0

