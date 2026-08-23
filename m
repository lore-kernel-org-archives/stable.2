Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262238A70A
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787490537; cv=none; b=QSfR1qCVoTfSXfhH8hEEawM5NuUs4ARBs1vj9v1YXYiq6xpBYrhWn0izsjILjmVylcEw6VGbGKAsnkTzKcrbKOi0cj/7/6ce0k3zrsusb+H7ON3ugojesqIf+4msO2ZnRtKXmTtk7uuw42Hw7MMkUIQfB3rnVQfkPX+mJi4bE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787490537; c=relaxed/simple;
	bh=QwSlor6ZBT9naXQJZiyTDy6/r99S+cQX+TWRSaM9zNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTwxUeKEgOcqQeJah5rqLL2tZdh1BB0hLhwwalfxrUFE1HDMDS1SlV9n6QIIx5GsgHJoszHfFqyKD3LGcKfeDhGaQPdyupBI/clrMewKPMsTauPzR6dJ4oxGNt9+ryM6nW4EfZfvs7AWXCaQEFTBKtO/VyQOteNudbRueoqvggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=mzs2lyKg; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="mzs2lyKg"
Received: from fedora (p4270056-ipxg00p01tokaisakaetozai.aichi.ocn.ne.jp [153.201.103.56])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67ND8382016116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 23 Aug 2026 22:08:40 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=lnCsHY1q94l80IWkygsX/4MFTm27V9+kp/eqzu5PAIo=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1787490520; v=1;
        b=mzs2lyKgEGHLwsgnSYBP74nZMX+7q8N8qK+cWMlbbpjE+dEqvS5CQzxVuR61Km2J
         5g/tASKJiHDMg+I0uabVffDJBDpBjmCbEmbI7USID4No50iDaOAp7B0PmKrhKd+B
         mg0Lz1QMclHfxSJf+QhhnT0BAkbjytNZi8Iyk6rqmYHoS1mamPQo56774gZHA6Bs
         G+4rctOC63a3UUwGfxrq7XBpoGxqy4HmcNiq6KfMwJJ2DEuXnEYVUlHbl6d7w5nf
         CKvHMvhVts+67vfsCkLeaCaktpAdNo5lD70OD+3rtnhdJzJISE90quCeL72Smx+6
         FFk0mqj3NOWaZ+eRKeRvog==
From: Kenta Akagi <k@mgml.me>
To: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Sasha Levin <sashal@kernel.org>,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v2 6/8] KVM: x86/mmu: Split out TDP MMU page fault handling
Date: Sun, 23 Aug 2026 22:07:49 +0900
Message-ID: <20260823130751.2880-7-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823130751.2880-1-k@mgml.me>
References: <2026072557-gem-defensive-a757@gregkh>
 <20260823130751.2880-1-k@mgml.me>
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
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 84 ++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 479f43859612..8c1061b2f12f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4015,7 +4015,6 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			     bool prefault, int max_level, bool is_tdp)
 {
-	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.mmu);
 	bool write = error_code & PFERR_WRITE_MASK;
 	bool map_writable;
 
@@ -4047,31 +4046,20 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		return r;
 
 	r = RET_PF_RETRY;
-
-	if (is_tdp_mmu_fault)
-		read_lock(&vcpu->kvm->mmu_lock);
-	else
-		write_lock(&vcpu->kvm->mmu_lock);
+	write_lock(&vcpu->kvm->mmu_lock);
 
 	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva))
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
@@ -4119,6 +4107,56 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
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
+	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva))
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
@@ -4134,6 +4172,12 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
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
2.51.2

