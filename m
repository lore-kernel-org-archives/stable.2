Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84E3B637C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781003; cv=none; b=rfghNFybw53Tyi/k552p+FSLxvMmJnjMdJxgGoGkgbKqD0lKA4hOqxGxwY9L0s9SXDaSWs6kpCo7azb8AtfmsZgOLBFJozY12S7+DQlYOPleN/8/oUHGiFE+3AI1bYY9jJ3xHi0uhSQ2xNFrVnHd0AoMWUmd5ndAQlCL0oQNkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781003; c=relaxed/simple;
	bh=6xk0seWRDJmqihGfcZYYrCptTVX4OFJfVW1+IoDPaGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnHI/jSbzKA4Gd+tJ910vfqCSVqyIHCpKMdc53O7LEZ9I+6o9JRqTpsC8qtF5DAQScp4ELqguLpDOgAXulr6kAcZBIfkOiyYiau79Rfqnik5NjqhDqczHxShFGQj1eVU23VJVHVKyAXwE66+A8MJS+2wwti8WHo1KFUUE1A1fKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW0ON50M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW0ON50M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06B81F00893;
	Wed, 30 Sep 2026 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780999;
	bh=2LZlEQMc9DsKwt33jKuirtSLtsOea9SANkMV5a8vcog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aW0ON50Md7ln1IPSsC9WA07V93yhWuvQXTRLb1om9iyjUQ6XIQMA1liq1qFrPiIKN
	 ioqNqe4bRjBE3geMFMKXBSwG6kCZZYjlfQ1ET67HRPrKBSXm7rhVTQ+9Y/1hJn5Wvf
	 4142rTGBEadg4hDAsA+XvnNmy+fvZCSEh96nGyA6jYvuKwuRj3mBq2fHeugx6vIytF
	 ck28m9LyScpZ1yRmwvgaqc/wHnL3yQoo+NRJRR6WoOynVY5Ed0DJTKtdcqNcIsn4wu
	 ZlrZWsice8kKfOAsCvceDlqFDii4Hz30CB7wHpb4XbH10KnjuKUO5w+T3Sz2nST9FP
	 73BHfLO8NxRnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] KVM: x86: Move IRQ-related helper declarations from kvm_host.h => irq.h
Date: Wed, 30 Sep 2026 11:09:53 -0400
Message-ID: <20260930150957.2359214-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092945-breath-candle-8e2c@gregkh>
References: <2026092945-breath-candle-8e2c@gregkh>
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
index 03866683ac336..5f1ed8f88ec7c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2379,12 +2379,7 @@ enum {
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
index 34f4a78a7a010..1a84ea31e7fd2 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -112,6 +112,12 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
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
index 66b8955a1658e..df54df7ae2013 100644
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
index bc5aa7456aac9..69b96a6d76202 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -11,6 +11,7 @@
 #include "x86.h"
 #include "cpuid.h"
 #include "hyperv.h"
+#include "irq.h"
 #include "mmu.h"
 #include "nested.h"
 #include "pmu.h"
-- 
2.53.0

