Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323984;
	b=ccJe+csxbeunaIaeq/5f0haXi4oTiowEG/G40wF8ESLvFm6/mqHH7yBXnmjOVRp1fMLp
	 ikUnijQAA2nvxPOgCksu1QKZTrI2cfz8PrPyIfIhwhmtQo4FnqA/SmTzo1CZ1SGj4eWO7
	 kWVd5slyHSgGUj2SzNaU+6w8q8zD2E/XnDU59Qukf+fUsQ/JHErn+1OvYSsHSGk3H9qeH
	 PhOnzv71gg5dukkiWEkSYkkUuB5QpND1DyCyxm5i/A285C7wdyvXWn96dAtM+/EQq9eiT
	 mEg+ZUD6xIJA9Ddn88pgOdPdPFS7fKxIttAAcFLzGYkCV4T318hdkHLbvLttaxF2hYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323984;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jkT0R3xzSk1k0xVZerf1wG7TP4osNpZIjJLZLTNovb0=;
	b=mUATlcmSs5SBIych3VqGYjeLX+A2Yl1+qJpc8ZjoSWZEeUyW17ZduKfzc7yOtJcLq/ek
	 LVAivJd3aH/gw7KxhNmWbIGRVWRDzJ1Klp24xM7wZzO5vDvFBWg4lyNQ56vPKopLyrX1L
	 UIZ/EchNxCjm+2lxqRHh6i/H7Fw+KO0zJ8Yqm/FzheGKu9wc8VOm7Xd97Jn5g9+oOGSmb
	 GWfH614jDW2V+RhY4ZjoyA6NPJg3SLCixivNcVsO8CXIDgwVycRSUdmosGRw+w1j1I2o7
	 f8i3X6pQtGsWkl5toJ8dVhKRuNgyhOjp8I47klafxFZ7gK3ZQ2k/tECHHKWA3FqBwog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzvDGfYM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C041606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzvDGfYM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A41C1F0089F;
	Tue, 10 Nov 2026 15:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323983;
	bh=jkT0R3xzSk1k0xVZerf1wG7TP4osNpZIjJLZLTNovb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DzvDGfYMJddmEP9pbdUUSntK77exMAAj7sT/l+xPk7kY/NG4LAdr5extRjDAgyPF6
	 x4+cjN/LxFYgFHDbg5RHS3ncBEHqYd8U8HVzog1eAcqW6vVgKIQQ7tpc6+k+lt7VZG
	 XBC22R7oImPy/x75I+xvfZ5c3ZcjWz+eHBzTNjZjfq+2x2dLMs/8fU6OS7ZAIhHh/r
	 wrILIitgkStN2Q8bcxoQtHvpXGzyI/v460K2nO21dWqFrZWuzwJaaU41RQqxHsfdUO
	 34Tk8GraZUTiOB9rD95SpLxy6sIPpLkbxUvslAdPjlP3N2dgSLahWOmQSgwmAzGD+3
	 FVox+bTHJ4UJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: VMX: Make handle_bus_lock_vmexit() a shared helper
Date: Tue, 10 Nov 2026 10:19:41 -0500
Message-ID: <20261110151928.2074971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051725-failed-6.12-326fa2c9b4d3@kernel.org>
References: <20261107051725-failed-6.12-326fa2c9b4d3@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiaoyao Li <xiaoyao.li@intel.com>

[ Upstream commit 326fa2c9b4d3e6cab58c139eb55aaabd7179192e ]

Move handle_bus_lock_vmexit() from vmx.c to main.c to make it a shared
helper so that TDX can use it for Bus Lock VM exit handling as well.
Rename it to add vt_ prefix to reflect that it is a helper for both VMX
and TDX.

Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://patch.msgid.link/20260819094903.3060020-8-xiaoyao.li@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ sashal: Replaced to_vt() with to_vmx() to access exit_reason in the existing vCPU structure. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/common.h |  2 ++
 arch/x86/kvm/vmx/main.c   | 12 ++++++++++++
 arch/x86/kvm/vmx/vmx.c    | 13 +------------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 27beb9d431e00..86d6753a0d867 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -31,4 +31,6 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
 }
 
+int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu);
+
 #endif /* __KVM_X86_VMX_COMMON_H */
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 8a922ce0d19c4..089a544cba862 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -3,10 +3,22 @@
 
 #include "x86_ops.h"
 #include "vmx.h"
+#include "common.h"
 #include "nested.h"
 #include "pmu.h"
 #include "posted_intr.h"
 
+int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
+	 * VM-Exits. Unconditionally set the flag here and leave the handling
+	 * to .handle_exit() callback.
+	 */
+	to_vmx(vcpu)->exit_reason.bus_lock_detected = true;
+	return 1;
+}
+
 #define VMX_REQUIRED_APICV_INHIBITS				\
 	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
 	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8e23e901a7593..a5614dd74e8cf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6051,17 +6051,6 @@ static int handle_encls(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_X86_SGX_KVM */
 
-static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
-	 * VM-Exits. Unconditionally set the flag here and leave the handling to
-	 * vmx_handle_exit().
-	 */
-	to_vmx(vcpu)->exit_reason.bus_lock_detected = true;
-	return 1;
-}
-
 static int handle_notify(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
@@ -6144,7 +6133,7 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[EXIT_REASON_VMFUNC]		      = handle_vmx_instruction,
 	[EXIT_REASON_PREEMPTION_TIMER]	      = handle_preemption_timer,
 	[EXIT_REASON_ENCLS]		      = handle_encls,
-	[EXIT_REASON_BUS_LOCK]                = handle_bus_lock_vmexit,
+	[EXIT_REASON_BUS_LOCK]                = vt_handle_bus_lock_vmexit,
 	[EXIT_REASON_NOTIFY]		      = handle_notify,
 };
 
-- 
2.53.0

