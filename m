Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BB515980
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789649; cv=none; b=VpUBO99OG3gwkrQS/bstwzvm2awb9bdI/D+VHH1ti+JbT71C8J9HukIieNl8waDwh434TO3IVo+hW3NUt6Z54XKiapIbcKTujYO6lJVOwJ+dlsD5Y50IuCzPrRiXII7nqTFtrgs6z8XDiyAQKNVUp2B2nIsFIYGI7DhqcVrxsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789649; c=relaxed/simple;
	bh=7LCD/WYe5cqxaKTxqlYTJ9l5db0QRnAw6+tWRFjOXrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6Acju+11t1SSfdJDpiXMvdpYDq1j+P8rcVvmMjfuZEbvtJUlFPJC39BDNWfROqLkSC1EE0kWZk3kbUEljvpK5O75fCnt95kdjTX5QusgC7XqPG/RwHjxPZqVD8skwHPlAwvNy1dgsHpLJLAPswlJGh9cF7dfFu4WV9hIO0kRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr6NDIfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr6NDIfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DC81F00899;
	Wed, 30 Sep 2026 17:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789648;
	bh=K54Fr/jhmy9VRG8oM0rRGXfecmVBADLi3UQcQLRtioM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dr6NDIfbDMNLKRmMLAhQyDzMlJuehTAnShhQY7JNyH0jZ27RvNuCheD8BduIcF/td
	 W08rw6wLNLDvOZ7iUOZlp9KGWfZ/wQkF13zrAR2Ql3Uy8DU8qobXRabXOVokkSqdsl
	 P2k+7OgZX3ICXpDlzg0WNWI1AUPvP+y4RVVAjakOg/xrcZUDDqe9iHoEprrag0DblF
	 wA/xON/j7nk7DYLBUHkFAGJPWzgEbaS/ANDzQonUplkUs1wnM4KPVcCkKvQ8aL0B6d
	 M56MSQB8Crkb/vTUAkg35F6NE/H+vQFD2CJpoCvnwYWOvm250icLIYNfJc3lIpfiFo
	 S8hveerfnZN1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] KVM: x86: Move IRQ-related helper declarations from kvm_host.h => irq.h
Date: Wed, 30 Sep 2026 13:34:01 -0400
Message-ID: <20260930173405.3642305-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092946-ahoy-spring-2e69@gregkh>
References: <2026092946-ahoy-spring-2e69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 0bdd2d6d7328a7debcf138a7d6ef95d01a26b1b8 ]

Move the function declaration for APIs to get/query pending IRQs from
kvm_host.h to irq.h, as the APIs are only used by KVM x86 code.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-25-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h | 5 -----
 arch/x86/kvm/irq.h              | 6 ++++++
 arch/x86/kvm/svm/nested.c       | 1 +
 arch/x86/kvm/vmx/nested.c       | 1 +
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index bb04de781b69d..2f76afa2f138a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2288,12 +2288,7 @@ enum {
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
 #endif
 
-int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
-int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
-int kvm_cpu_has_extint(struct kvm_vcpu *v);
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
-int kvm_cpu_get_extint(struct kvm_vcpu *v);
-int kvm_cpu_get_interrupt(struct kvm_vcpu *v);
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 
 int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index 76d46b2f41ddc..8cc1e9d293e8a 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -96,6 +96,12 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 	return mode != KVM_IRQCHIP_NONE;
 }
 
+int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
+int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
+int kvm_cpu_has_extint(struct kvm_vcpu *v);
+int kvm_cpu_get_extint(struct kvm_vcpu *v);
+int kvm_cpu_get_interrupt(struct kvm_vcpu *v);
+
 void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_inject_apic_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_apic_nmi_wd_deliver(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 2d81f1cb4ca7b..17a53f5d17416 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -23,6 +23,7 @@
 
 #include "kvm_emulate.h"
 #include "trace.h"
+#include "irq.h"
 #include "mmu.h"
 #include "x86.h"
 #include "smm.h"
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 5a5da0009bda0..d21ce49ac8d74 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -10,6 +10,7 @@
 #include "x86.h"
 #include "cpuid.h"
 #include "hyperv.h"
+#include "irq.h"
 #include "mmu.h"
 #include "nested.h"
 #include "pmu.h"
-- 
2.53.0

