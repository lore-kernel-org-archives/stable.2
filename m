Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28146AF04
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773989; cv=none; b=VmavYUEaBgqVD6uuEtrzhGu2YsFIPr4OcV/HTJiEmvuOl2owdVT/jca+W35y6aMnJ4fMPcz4dVEd8FOcpddJVsaEujXGeT9LGXYnCU3cynWHz2gSe2Dz2u17OS1gZErK5ejyFWI40xxPoCvCKY/tu1RbIYV1mo513DBKpuz0zOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773989; c=relaxed/simple;
	bh=80T/bwEq6sKK5poFteAmHatb8eiWGiNk+jSNW/a9wlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1TzshOesi3JCpiaQj/YQ004CUN/BiaaPxVmNyv2tj+vO2L5pCNJ10mCu4Rg/aAUS+xzWqeG3NabEV6hQDlP0nsa86P066OOKfjdd8bcpPeFiU3MMiTIijjBgODsVEJdXIoov60rQv5ymyqopwKbOrw2QnPF0c1lM3bU2BmLqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxgMx3An; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxgMx3An"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695FA1F00893;
	Wed, 30 Sep 2026 13:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773978;
	bh=7jWshTgfc5US/uMD1hyCFpR5JWNffH4KKFF1r3oEYII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HxgMx3Ansp9PLbbj4t1Ypz5Cea9wQA2zjJy4mrzhTwx2DQC3baHOsy9b2LOG/1S4r
	 CE/3RopP7QBSbaqfYoD/Rn5jxHomXC4/yilQ1oiX76zpsPyjoX0MuCdgjKw04IQkC4
	 9cqNTbDf8w57m7kuUjm/URxgo+MuJQVUKzKU83B9q41fHFw7rkDfUNN8Fo4lf8EpuA
	 xUf+oBE86a/tX2oAfhPdyzCQ0ioekMWF9pcImIbTbVIFZYX/AM3P4gsbBaBm1DyGB4
	 jhKN6gmIi16XfouJWXuHsftVXX59UeH8APpeguIjeCsI7WDzTzUwK1yafje/yMFRwg
	 7YJKY/4ljPTOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/8] KVM: x86: Move IRQ-related helper declarations from kvm_host.h => irq.h
Date: Wed, 30 Sep 2026 09:12:48 -0400
Message-ID: <20260930131256.1728861-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092945-unzip-pluck-7c40@gregkh>
References: <2026092945-unzip-pluck-7c40@gregkh>
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
index 2dfd6199a10c6..cb07b2b8093db 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2462,12 +2462,7 @@ enum {
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
index 3e6c671a8dc26..c1485c3e691c4 100644
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
index ed28cf6b6efc2..cec7eb646a1e3 100644
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

