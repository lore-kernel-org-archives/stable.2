Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42853414406
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123290; cv=none; b=pUyXSBMBKiEdSkHYQGpdT7XRiJYfjjQJXRA3Kq5nv4iPF5j5EF4j7c6aDsQHil9hA1pHLA+GO7GZTEzOjnoAOoiAux7NXfDuObgVuHuW2lfO+MdGPDX38RJswTZonmJ1jmndnZTPmEpaEEXOqR8RZMxSS5joQkooRFDB2V4h5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123290; c=relaxed/simple;
	bh=fNb32DBTJMkHIwiaRUwNbyarWPnt3kPm1TfJjxf3aYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go8JU3qsSE+HDHtO6blAxF9bukOl7mgiYtCL+Pemi9zthU245GxdzNYML+4DVkszODbqcUHXhQAUY5mAz/yveiVtSoIfVLGxGoMHJ3UWiNWyV0mOZlRrnH8MXmxCKJW+xxDxu6C7jMXvaT8VbI0V21tLwyL7WRNhaJTJ1uncoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAtqEGMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAtqEGMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822E81F00898;
	Fri, 11 Sep 2026 10:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123288;
	bh=LBTwocCtB3n3xWzCFlO/DVU4AEnLyVR45HriFcQRqvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mAtqEGMbFSOo0pfuCSEY4ZbbcBLMa+OwQlyoBwLbISNH8HBdNBRXwn2cnNPiXaBye
	 FmC7MHQqrDQmHv6JyWgzxEpCAD++8+Y7qBuWkWWT0WFXxiRh3i+gvyzQU/i+Sg6+v2
	 2jDS951/wJkWXyEvHTrgx2CbKr5+4DMhiB37JmlKZSGDju59tWNkdKQEkoLDHbjD8v
	 OwH6nt0ruQbTX7kVLekFYexGCtBmnSlazn9/bAdwuPqWZw5o9IRMNzDDscvhxj/32B
	 SyPIjAPrYs4WfWrr3NmgZoQjhpuvPU3LTE9epwPmoTxlnHf5yxAk0dSDKtBD59ADaE
	 BwVqaMuqJI1ZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/9] KVM: x86: Swap the include order between x86.h and mmu.h
Date: Fri, 11 Sep 2026 06:41:17 -0400
Message-ID: <20260911104123.189614-3-sashal@kernel.org>
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

[ Upstream commit febae924e83017834994054916dd612266aa1e5d ]

Invert the include ordering between x86.h and mmu.h, and move
mmu_is_nested() to mmu.h where it belongs (mmu_is_nested()'s placement in
x86.h was solely responsible for the existing ordering), so that x86.h is
not included by most KVM internal headers (but includes them).

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-8-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e62392bf39eb ("KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu.h | 6 +++++-
 arch/x86/kvm/x86.h | 6 +-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e1bb663ebbd58..f9e137cc831fe 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -4,7 +4,6 @@
 
 #include <linux/kvm_host.h>
 #include "regs.h"
-#include "x86.h"
 #include "cpuid.h"
 
 extern bool __read_mostly enable_mmio_caching;
@@ -300,6 +299,11 @@ static inline void kvm_update_page_stats(struct kvm *kvm, int level, int count)
 	atomic64_add(count, &kvm->stat.pages[level - 1]);
 }
 
+static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.mmu == &vcpu->arch.guest_mmu;
+}
+
 static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct kvm_mmu *mmu,
 				      gpa_t gpa, u64 access,
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 138d2cfe5ead8..e5ece3eeb4f16 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -6,6 +6,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/mce.h>
 #include <asm/pvclock.h>
+#include "mmu.h"
 #include "regs.h"
 #include "kvm_emulate.h"
 #include "cpuid.h"
@@ -210,11 +211,6 @@ static inline bool x86_exception_has_error_code(unsigned int vector)
 	return (1U << vector) & exception_has_error_code;
 }
 
-static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.mmu == &vcpu->arch.guest_mmu;
-}
-
 static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
 {
 	return kvm_is_cr4_bit_set(vcpu, X86_CR4_LA57) ? 57 : 48;
-- 
2.53.0

