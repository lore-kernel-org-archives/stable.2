Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573B46AA90
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439782; cv=none; b=QMueKfpZmw+iKY2CceVs3JnBVRi8VUUx15JAG02mq25va3PUDwjCowtpu96ooCyrckrTYvC60cxD5d3oaEMXp1LT23voR5bzuIp/DBU9dRSDCHY+8v/zpUrmiSiJLv5qFSvLQNlSFO7JiNdHhzJNK7KE7s+rZMXfU5aOSXx/T20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439782; c=relaxed/simple;
	bh=kncE08z3do/DRc3WImBIe++d/SfeW1XtS1oGyMaBNDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om7OqGycFVIyqLebUiy5axH67Gk3crThvF1mTigsoYYzhJHK+iEnrZl6WL1k6naTsGv+9eSy9ifVCAkBJMYLp5B/1CTahB36cJlDdZq+g16X8m/sIAEoCDh8382If1dC0nasrOoeV0MUXpJPgkeJffmhpnG75SGmvi92h5V6Lok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILl1FTfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILl1FTfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338F61F00AC4;
	Thu, 30 Jul 2026 19:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439778;
	bh=gMVcqIfaFm7GRpmUs86dEXXPF/2inMKqJKzfuhLLaPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ILl1FTfya3d+RZ26PwrWfF2wPGkj5sLgrVoe71cbPp2qvra0+lbKdPj1XAyKAxKss
	 9ajZReSHw/PNjJ1V+j4jX5SKIldoRqqI4QO5mlVppPavc15qm+IaHWqdkNSKUgIYp1
	 fjx0jtuQ8wdthubeZh/o3Il6Hf+SXlvUQWRullbQk+wlGktMR79uHixAPOpnGbl9wf
	 cqJ+4i4rwP4vOFGH1w2a4X15z/WX7mV+8GWpa6KTrh2+xamOSwHViWhq3IJ2nYR0hJ
	 PWigLoiyfTeqgW9npy6qKCxb4ODa76q4+TksCWwiIn0RulI+562PDspt9scsR4Z7pC
	 KVUqqum1B+RTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] KVM: x86/mmu: Split out TDP MMU page fault handling
Date: Thu, 30 Jul 2026 15:29:32 -0400
Message-ID: <20260730192933.3123642-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730192933.3123642-1-sashal@kernel.org>
References: <2026072557-gem-defensive-a757@gregkh>
 <20260730192933.3123642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Matlack <dmatlack@google.com>

[ Upstream commit 9aa8ab43b38146029de807a8ff2696f51e15b226 ]

Split out the page fault handling for the TDP MMU to a separate
function.  This creates some duplicate code, but makes the TDP MMU fault
handler simpler to read by eliminating branches and will enable future
cleanups by allowing the TDP MMU and non-TDP MMU fault paths to diverge.

Only compile in the TDP MMU fault handler for 64-bit builds since
kvm_tdp_mmu_map() does not exist in 32-bit builds.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20220921173546.2674386-9-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 84 ++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e52940bf1892..04e814816b17 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3997,7 +3997,6 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			     bool prefault, int max_level, bool is_tdp)
 {
-	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.mmu);
 	bool write = error_code & PFERR_WRITE_MASK;
 	bool map_writable;
 
@@ -4029,31 +4028,20 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		return r;
 
 	r = RET_PF_RETRY;
-
-	if (is_tdp_mmu_fault)
-		read_lock(&vcpu->kvm->mmu_lock);
-	else
-		write_lock(&vcpu->kvm->mmu_lock);
+	write_lock(&vcpu->kvm->mmu_lock);
 
 	if (!is_noslot_pfn(pfn) && mmu_invalidate_retry_hva(vcpu->kvm, mmu_seq, hva))
 		goto out_unlock;
 
-	if (is_tdp_mmu_fault) {
-		r = kvm_tdp_mmu_map(vcpu, gpa, error_code, map_writable, max_level,
-				    pfn, prefault);
-	} else {
-		r = make_mmu_pages_available(vcpu);
-		if (r)
-			goto out_unlock;
-		r = __direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
-				 prefault, is_tdp);
-	}
+	r = make_mmu_pages_available(vcpu);
+	if (r)
+		goto out_unlock;
+
+	r = __direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
+			 prefault, is_tdp);
 
 out_unlock:
-	if (is_tdp_mmu_fault)
-		read_unlock(&vcpu->kvm->mmu_lock);
-	else
-		write_unlock(&vcpu->kvm->mmu_lock);
+	write_unlock(&vcpu->kvm->mmu_lock);
 	kvm_release_pfn_clean(pfn);
 	return r;
 }
@@ -4101,6 +4089,56 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 }
 EXPORT_SYMBOL_GPL(kvm_handle_page_fault);
 
+#ifdef CONFIG_X86_64
+static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa,
+				  u32 error_code, bool prefault, int max_level)
+{
+	bool write = error_code & PFERR_WRITE_MASK;
+	bool map_writable;
+
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	unsigned long mmu_seq;
+	kvm_pfn_t pfn;
+	hva_t hva;
+	int r;
+
+	if (page_fault_handle_page_track(vcpu, error_code, gfn))
+		return RET_PF_EMULATE;
+
+	r = fast_page_fault(vcpu, gpa, error_code);
+	if (r != RET_PF_INVALID)
+		return r;
+
+	r = mmu_topup_memory_caches(vcpu, false);
+	if (r)
+		return r;
+
+	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
+	smp_rmb();
+
+	if (kvm_faultin_pfn(vcpu, prefault, gfn, gpa, &pfn, &hva,
+			 write, &map_writable, &r))
+		return r;
+
+	if (handle_abnormal_pfn(vcpu, 0, gfn, pfn, ACC_ALL, &r))
+		return r;
+
+	r = RET_PF_RETRY;
+	read_lock(&vcpu->kvm->mmu_lock);
+
+	if (!is_noslot_pfn(pfn) && mmu_invalidate_retry_hva(vcpu->kvm, mmu_seq, hva))
+		goto out_unlock;
+
+	r = kvm_tdp_mmu_map(vcpu, gpa, error_code, map_writable, max_level,
+			    pfn, prefault);
+
+out_unlock:
+	read_unlock(&vcpu->kvm->mmu_lock);
+	kvm_release_pfn_clean(pfn);
+	return r;
+}
+#endif
+
 int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		       bool prefault)
 {
@@ -4116,6 +4154,12 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			break;
 	}
 
+#ifdef CONFIG_X86_64
+	if (is_tdp_mmu(vcpu->arch.mmu))
+		return kvm_tdp_mmu_page_fault(vcpu, gpa, error_code, prefault,
+					      max_level);
+#endif
+
 	return direct_page_fault(vcpu, gpa, error_code, prefault,
 				 max_level, true);
 }
-- 
2.53.0

