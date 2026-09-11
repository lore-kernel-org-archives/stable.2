Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA103D331A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123300; cv=none; b=YDGvqHUASKK+qkHS7580rIZp0lINXZHYAqwYIacfL71aBMcmRGA+zH6DKOE/TNkeY2kCEWbeQEGW9fr+lUU/WSRaI42VfegnAtlJ7Rhm98lcVBZxXwB9fnh5fW9gv0WgcU8e/LUVEy8aGIaBfWgUAAm8ftaK32moLGa704lS98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123300; c=relaxed/simple;
	bh=ViqOHT4hhSvK8sa+7rAbMvxw5Msqnr+mVdIEVh4VQqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtmpI1RH6Z2gMhF7cJlp2sHQ4lHIcVUpW9AqAeJUdHRQz5hfWBgJZdjPZ5uy4ZPQASfzCC+gPLirv0nPMXQG5fTLCHz0yWwmZiPhj3fC/o8beo7/D9oPdlfohnOhzGHNCSgE/uMbWdkwLwJgpRa5XicAoPVNE/mUeeHRIuF07B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrQ7IrbX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrQ7IrbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FB01F00893;
	Fri, 11 Sep 2026 10:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123298;
	bh=l53+f0u94qG0585c2Lb2cy5Aor55Sv/Mi0mnuKI0z48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CrQ7IrbXqxSCs0YjP6jykMlBP9bwAGu4HTkvvOQ3HHmCxecFDmWSJ8OFkoXafhKHh
	 6fVelshjry4pwlHix+NAhEE0FNiNfiWprqQyUWIN8VKg5pBJ4T8ElY+27GocTbg7FK
	 Ct0U6G5wLjGVWH68RLLM7+bSQJyyZAH/luDlE/1eIFkimLrcj8lSAkhkhn88Q2xkZg
	 kq+VNaVWDM6Kt6+8JDmLODe0k77GjTQRZbV54vYhqAN+5u+rjLhaU9ZHd1zx/kJ7YK
	 tSjNvxR3TnZLQuBNLDoB1qqSUdLQgrAYUtyc5N9S9dYGSPrQo0BVOjIEcECU/dWdCr
	 AOSE2BVH2mBeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/7] KVM: x86: Move tdp_enabled from kvm_host.h to mmu.h
Date: Fri, 11 Sep 2026 06:41:30 -0400
Message-ID: <20260911104136.194961-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090906-angling-trickily-a20c@gregkh>
References: <2026090906-angling-trickily-a20c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit af0dbcaaa2bbc90ba8e6f696be725c4522face08 ]

Relocated the declaration of tdp_enabled into mmu.h, and opportunistically
hoist tdp_mmu_enabled up to the top so that the two are co-located.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-9-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: a4b8acd428ba ("KVM: x86: Always initialize EFER reserved bits on vendor initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  2 --
 arch/x86/kvm/mmu.h              | 12 ++++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6db5b5f79df9b..891c47a5607fd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2148,8 +2148,6 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
 
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 
-extern bool tdp_enabled;
-
 /*
  * EMULTYPE_NO_DECODE - Set when re-emulating an instruction (after completing
  *			userspace I/O) to indicate that the emulation context
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e1bb663ebbd58..016a9fe60222e 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -7,6 +7,12 @@
 #include "x86.h"
 #include "cpuid.h"
 
+extern bool tdp_enabled;
+#ifdef CONFIG_X86_64
+extern bool tdp_mmu_enabled;
+#else
+#define tdp_mmu_enabled false
+#endif
 extern bool __read_mostly enable_mmio_caching;
 
 #define PT_WRITABLE_SHIFT 1
@@ -261,12 +267,6 @@ static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
 	return smp_load_acquire(&kvm->arch.shadow_root_allocated);
 }
 
-#ifdef CONFIG_X86_64
-extern bool tdp_mmu_enabled;
-#else
-#define tdp_mmu_enabled false
-#endif
-
 int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn);
 
 static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
-- 
2.53.0

