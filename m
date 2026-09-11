Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9633D331A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123302; cv=none; b=M38klxDHTEovouN/T0/7MqZFCW0UVGC3qjRAn+o/ppfEHncRgoLc7KnC1GPyhjN0doec/IqKv8SwWnLR4Fs24a+KBR7IlcHpPDZLMIteCsaSHqd1DNgL+XGXz3B9CsXNIFYo7bmSmDdL4V1icGYo9drcjek97l76XTmPXMQ3KpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123302; c=relaxed/simple;
	bh=RSoNhCO3jyAWEiiqkDN+QbSY773w017M9JIs+Wx7sWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dczciIMtUMRRdsUsy06C0/ifFBK3Y3fz3v9dAjuF61JuSQI2HFoL1FWJxYtCPGyyPRaHCzZAGF1clRtSCjP5exhSRtflnN6DHS3UjVAu++7KcJJQye41Z01/YkMZzWCA+5m1DoglhkFtUG1jT0/Hwkr3C4sPCY2hm7mJbzsLqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx7NKV2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx7NKV2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F1A1F00898;
	Fri, 11 Sep 2026 10:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123300;
	bh=VSiniyk9kUYsUU/njl7dtqF+s5krht8u74n0Oku4FLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bx7NKV2e9O0eTvkigynRI94o5IhSLdtyjZfoqwhVWVvJm/KHUMBwWvHBeXg+xOMUO
	 J1GP84uvGyzb9eGrdG5j/+fSOkg0Zra8JJRdXS+gf4PtOykXprBz6GKH5xBMa/ZOIP
	 mU0XA+4MKoXddlMnpHcfRIxThyqKKooXrlFwlNjAzc2n/NZsJJbthRH0XaZ+/+hsgZ
	 biLN+HUWTJUL/I3eYpBx0jLxY93wToN8kVMvL+0IMGl6ZaJqHYzWFwAJ4BSfBTnlNI
	 XRGD/LNuS5Cd5V5xKddX469fMxL/NYb0qWLsFOlsiEL0EI9svy3+OU92UmLQwXAFc2
	 JAEgtt19+dRdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/7] KVM: x86: Move kvm_{load,put}_guest_fpu() to fpu.h
Date: Fri, 11 Sep 2026 06:41:32 -0400
Message-ID: <20260911104136.194961-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104136.194961-1-sashal@kernel.org>
References: <2026090906-angling-trickily-a20c@gregkh>
 <20260911104136.194961-1-sashal@kernel.org>
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
Stable-dep-of: a4b8acd428ba ("KVM: x86: Always initialize EFER reserved bits on vendor initialization")
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
index 5cec74e1afc86..894b6b5b125ec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -137,8 +137,6 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
 static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
 
 static DEFINE_MUTEX(vendor_module_lock);
-static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
-static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
 
 struct kvm_x86_ops kvm_x86_ops __read_mostly;
 
@@ -11899,28 +11897,6 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
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

