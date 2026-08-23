Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761873A4523
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787490533; cv=none; b=USLBT6EdcO6zpKcMT8ZjvtfnB6KnLFzLTmMoExmPHE2yKHQZETYFWxhm4xRW93NKzI8hlTvIYPg72jbvmIoZazkNc5ry7E+jSLIepbjS+0bm1B5Q5hSii6gYkVasIzFqhyzNJz/JI4v7JnC6L/H4RmoVmDoXj6z1GKse0Nzk1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787490533; c=relaxed/simple;
	bh=dI2cYlXIirYVjlXhFtNFpyJLUEatbRCChfjPMjv6ztE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe+1pOyyHnUKMfv34EEVUvn1U8py8ld7BZEUqbBkZVjH6DJzTkL/1MTWLfEBD2TqPtVVeqqRXnsAbWOt1f514Zl1C2St4f1zH1rFr/iAxR4W4V4xIVYk8Eq7PeS3/4LYSBHRqDDnty2eL6SgTAobFUP+OVMUOm3l0MjKcXjy4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=EwtTjjGM; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="EwtTjjGM"
Received: from fedora (p4270056-ipxg00p01tokaisakaetozai.aichi.ocn.ne.jp [153.201.103.56])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67ND8384016116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 23 Aug 2026 22:08:40 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=jw0fbRtg/KfA0Zs/1oR8mHGd6nVvYy2UCZbxFt/A8h4=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1787490520; v=1;
        b=EwtTjjGMB6bBgBFOpD6aI7GupCPAVIb8TsMYjvNL8CokVzPaaGejb+FQW4nHF03i
         SHJU7m98JcIJcuZAYj5p6wOPj4YxHuUAS8Bx9D4082kguvtAkU57iQ1FVwadWZjk
         jkyh66apVBdCx78BRYDRLAHKz3Au2K32C5uHsF5cJEVzVvLFT5UUUJjQi92CUOfR
         r2ShEoj6l5iOtO+bez0BF5JkbAgVCHRqoviaKUMEvWF1v5YmVPdQQbRfR8YnH2uX
         SpwEbeE9426hkxbggupCorxZ8GYVp72WcDCyTjU94PI/lmiK/eos9kuBi6evmG0Q
         pnbrnLURTupikUPxbTUPNw==
From: Kenta Akagi <k@mgml.me>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Hyunwoo Kim <imv4bel@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v2 8/8] KVM: x86: Check for invalid/obsolete root *after* making MMU pages available
Date: Sun, 23 Aug 2026 22:07:51 +0900
Message-ID: <20260823130751.2880-9-k@mgml.me>
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

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 2abd5287f08319fa35764566b15c6e22cb1068db ]

Check for a "stale" page fault, i.e. for an invalid and/or obsolete root,
after making MMU pages available for the shadow MMU.  If reclaiming shadow
pages zaps an in-use root, i.e. marks it invalid, then KVM will attempt to
map memory into an invalid root.  On its own, populating an invalid root is
"fine", but because child shadow pages inherit their parent's role, any
children created during the map/fetch will be created as invalid pages,
thus violating KVM's invariant that invalid pages are never on the list of
active MMU pages.

Note, the underlying flaw has existed since KVM first started tracking
invalid roots in 2008 (commit 2e53d63acba7, "KVM: MMU: ignore zapped root
pagetables"), but the true badness only came along in 2020 (Linux 5.9)
with the invariant that invalid shadow pages can't be on the list of
active pages.

Note #2, inheriting role.invalid when creating child shadow pages is also
far from ideal; that flaw will be addressed separately.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Fixes: f95eec9bed76 ("KVM: x86/mmu: Don't put invalid SPs back on the list of active pages")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[backport note: upstream passes struct kvm_page_fault to is_page_fault_stale();
 here individual parameters are used, as is_page_fault_stale() was
 backported with that interface in the preceding commit]
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c         |  9 +++++----
 arch/x86/kvm/mmu/paging_tmpl.h | 10 ++++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 019e24a76a96..8c381cf61e21 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4045,16 +4045,17 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r))
 		return r;
 
-	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva))
-		goto out_unlock;
-
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
 
+	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
+	}
+
 	r = direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
 		       prefault, is_tdp);
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index c67b51bc666e..fd3f2c5bb7ed 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -923,16 +923,18 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 			walker.pte_access &= ~ACC_EXEC_MASK;
 	}
 
-	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva))
-		goto out_unlock;
-
 	kvm_mmu_audit(vcpu, AUDIT_PRE_PAGE_FAULT);
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
+
+	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
+	}
+
 	r = FNAME(fetch)(vcpu, addr, &walker, error_code, max_level, pfn,
 			 map_writable, prefault);
 	kvm_mmu_audit(vcpu, AUDIT_POST_PAGE_FAULT);
-- 
2.51.2

