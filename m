Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009744;
	b=CxgeJn+SYLAJ3LirQY0mqq1YgSnZnY8E1XLhse6r7eHlygzc2ufcS+PBq6FXwdgfALM4
	 a7aEOWpSpokNQH538fiYGd6ElwPr6lyk46FhD2ikZOxf4ALsENbnxu+iFEefmtYoKG/+0
	 HCu6jsKcRqo39iict8nPy5YvsVpKfPaGKx3SJ39FB6JxF7klpij8vLvkTNGOumv+1/kwK
	 ozarkfXreDNHpEurrKnOrmCt6jP5ecy6p3AkVLKc6+RRLQEhXC0w9yY+MAaOH1ijAGlbT
	 DAbD+4yT4dFplvrDZ2fPKCAix2sDcgx+5cSZrYRFFsCVhpMdyOk3Zx+QEyjC3pc+yLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009744;
	h=DMARC-Filter:Received:Received:Content-Transfer-Encoding:
	 Content-Type:DKIM-Signature:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP;
	bh=SfGH3q4DwUa0O9JB4FrX4MsCXETnXfEH/YKr5mSj8mw=;
	b=4dLUBA0q2LXU0uVB+h3MCBmxpk64NXo8M7YQxeKiadZX78IJP4OfOqCJlvUPPZafczk0
	 cTQZOoj71Uz13OlSqyK2tbnLztlppLA18ItfXb7IBDB31cfQMTmN/7QhnhL9U3gEF/6fS
	 yaNy/bK7h3vkMQtMVMEP/WMvZgy6oKr5e98il+LaYTpWf7aNr4P1Xz5ieuHRCgn+tttUe
	 uFy2iUV0pO+yezCGyjMp0tOYGHLrG0H5Jz3CfKL6yjqBIp7GgK8Rnua9lOiTAunqCgNMO
	 uVvGfP60oKOZtGB8EhZBGoNGv1kr7SCM+M+Ujg2KUznuTigkpfNXQffPniB1tqVjXig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=k9deF7rN;
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD5606A337
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7DD5606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=k9deF7rN
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id 39C8F101832;
	Wed, 18 Nov 2026 16:48:58 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id 1D2AA101327;
	Wed, 18 Nov 2026 16:48:58 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795009737; h=from:subject:to:date:message-id;
	bh=nOzdHmsohVFcM8p2j4kv7WrOpffuECO3EFYafF82PKY=;
	b=k9deF7rNMAF6GDrrHPE1kJQasMO1QAQtez7dF7PIZXFidwg6/m1HtKk3pOF4XKRpgCKr412gHGg
	a646k8Gkji6LqyWSrH8XNmFDZurx1dDR18UE1Lqoxz1wsz8jHW9Jpgai5o/X2VqfhiPbL+xoaLzne
	67zFtvUcFbFvCqm7c6UJH+ARGDtkvQe7D6jGD0kSRzWdnlaGBXnITbn3zle86KI6Rs44Q80Wf+UWO
	7VcVWHyFkTNBPMWIgkg6iuFtYcKssBTxgDkYb6zhKHVinkGt1h6jlCvW7vdPPPIL7wTqVBHyARmJ5
	pH6XZTowVm+33dYAsNAtE6fbxBGrXnvx+Ilw==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 16:48:57 +0300
From: Artem Novikov <naa@amicon.ru>
To: <lvc-patches@linuxtesting.org>, <stable@vger.kernel.org>
CC: <pchelkin@ispras.ru>, <rrv@amicon.ru>
Subject: [PATCH 5.10 v6 5/5] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Wed, 18 Nov 2026 16:48:50 +0300
Message-ID: <20261118134851.203854-6-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118134851.203854-1-naa@amicon.ru>
References: <20261118134851.203854-1-naa@amicon.ru>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Paolo Bonzini <pbonzini@redhat.com>

commit 81ccda30b4e83d8f5cc4fd50503c44e3a33abfeb upstream.

A linked page with the expected GFN can have a different role.
Direct and indirect shadow pages use different reverse-map GFN
accounting. Reusing a child whose role has changed can leave a stale
reverse map after the child is freed.

Require the linked child to match both the GFN and the whole role.
Compare against the same role used for cache lookup. The role includes
the access bits, so the shared replacement path also handles access
changes on a direct child.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://www.cve.org/CVERecord?id=CVE-2026-53359
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[Apply the comparison where the 5.10 page allocator builds its role.
 Keep the original role calculation and root lookup.]
Signed-off-by: Artem Novikov <naa@amicon.ru>
---
Backport fix for CVE-2026-53359

 arch/x86/kvm/mmu/mmu.c         | 43 +++++++++-------------------------
 arch/x86/kvm/mmu/paging_tmpl.h |  2 --
 2 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cace229921ebf625286cbdb8b57ace2c8df71f10..18bd96ab6666e4a9987cd88a326cffb62522eaac 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2028,7 +2028,8 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 					     gva_t gaddr,
 					     unsigned level,
 					     int direct,
-					     unsigned int access)
+					     unsigned int access,
+					     struct kvm_mmu_page *linked)
 {
 	bool direct_mmu = vcpu->arch.mmu->direct_map;
 	union kvm_mmu_page_role role;
@@ -2052,6 +2053,10 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 		role.quadrant = quadrant;
 	}
 
+	/* Keep the parent SPTE if it already links the requested page. */
+	if (linked && linked->gfn == gfn && linked->role.word == role.word)
+		return NULL;
+
 	sp_list = &vcpu->kvm->arch.mmu_page_hash[kvm_page_table_hashfn(gfn)];
 	for_each_valid_sp(vcpu->kvm, sp, sp_list) {
 		if (sp->gfn != gfn) {
@@ -2183,20 +2188,16 @@ static struct kvm_mmu_page *
 kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu, struct kvm_shadow_walk_iterator *it,
 		     gfn_t gfn, bool direct, unsigned int access)
 {
-	struct kvm_mmu_page *sp;
+	struct kvm_mmu_page *linked = NULL;
 	u64 spte;
 
 	drop_large_spte(vcpu, it->sptep);
 	spte = *it->sptep;
-
-	if (is_shadow_present_pte(spte)) {
-		sp = to_shadow_page(spte & PT64_BASE_ADDR_MASK);
-		if (sp && sp->gfn == gfn)
-			return NULL;
-	}
+	if (is_shadow_present_pte(spte))
+		linked = to_shadow_page(spte & PT64_BASE_ADDR_MASK);
 
 	return kvm_mmu_get_page(vcpu, gfn, it->addr, it->level - 1,
-				direct, access);
+				direct, access, linked);
 }
 
 static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
@@ -2227,28 +2228,6 @@ static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
 		mark_unsync(sptep);
 }
 
-static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
-				   unsigned direct_access)
-{
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep)) {
-		struct kvm_mmu_page *child;
-
-		/*
-		 * For the direct sp, if the guest pte's dirty bit
-		 * changed form clean to dirty, it will corrupt the
-		 * sp's access: allow writable in the read-only sp,
-		 * so we should update the spte at this point to get
-		 * a new sp with the correct access.
-		 */
-		child = to_shadow_page(*sptep & PT64_BASE_ADDR_MASK);
-		if (child->role.access == direct_access)
-			return;
-
-		drop_parent_pte(child, sptep);
-		kvm_flush_remote_tlbs_with_address(vcpu->kvm, child->gfn, 1);
-	}
-}
-
 /* Returns the number of zapped non-leaf child shadow pages. */
 static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			    u64 *spte, struct list_head *invalid_list)
@@ -3271,7 +3250,7 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		return INVALID_PAGE;
 	}
-	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
+	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL, NULL);
 	++sp->root_count;
 
 	spin_unlock(&vcpu->kvm->mmu_lock);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 95b5476ab150ff8660cbe0c9c8ead2c073916c3e..9daf9029081161f3dddb0375019f823967dc29ad 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -708,8 +708,6 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		if (it.level == level)
 			break;
 
-		validate_direct_spte(vcpu, it.sptep, direct_access);
-
 		sp = kvm_mmu_get_child_sp(vcpu, &it, base_gfn, true,
 					  direct_access);
 		if (sp) {

