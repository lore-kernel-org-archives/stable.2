Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEED2F7EED
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495999; cv=none; b=S32a5PRNWh8GbIJrXnStoihrpIq+GpfFNpFB9yywhCXH6ZWaiPRmdHcTDV+zFCFzqfnjc3F1dweGqe2GCe7Dyu17NRHee/wmyns/4wOHAXOomtVkMaJW1RYHw+24BYFHfza3IO1JmhpcKo+5NwmAMdW/+Tt88Y+famf47QmQ0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495999; c=relaxed/simple;
	bh=tgrFkvweM437Fquqrwa4KCm69G5iUZbLcF3PNLMLmjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lprTJ5zyHqYix8EbEq9VR/HyccFUn+toQAtNKLn27oLFq4lmBbdDsrA/TQuOPvyeeNJAd1Dx9C6Y6pTn7CguXmbHAb7Rxpoz1YdJqZ5DjIsxypdhCmFOIarUiYIUyr3Got//pWlLiiAf1zZBBQIOgN07q8pTcb2ksF0bYfwvmXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZJ1PEVQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqBYdOWL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZJ1PEVQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqBYdOWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782495995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUQDcnBTlwfuL7EG+sT74DCe/C24lRRbqmUOGTx6aUw=;
	b=BZJ1PEVQx6JBG4YJlvkphocw3cK9QDuh1jclDqmOAze6Q8HwlEjI+0g3dqMtpkI2TSTNO8
	wHlZz8p0Hcf7K+6MmnnO23B7Z2RXui4r59732PLCbvfUyJBem9riEkOxbqp62hENbZW5DN
	NjwF1QNUqHBwqFA7fXuLasu2OvQmMpg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Tyj9yYL9Nv-ZB9eV9MZVKQ-1; Fri, 26 Jun 2026 13:46:32 -0400
X-MC-Unique: Tyj9yYL9Nv-ZB9eV9MZVKQ-1
X-Mimecast-MFC-AGG-ID: Tyj9yYL9Nv-ZB9eV9MZVKQ_1782495991
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46db5d470bfso854751f8f.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782495991; x=1783100791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUQDcnBTlwfuL7EG+sT74DCe/C24lRRbqmUOGTx6aUw=;
        b=iqBYdOWLN8n/zQ2EdIDd/TWI0qTg6QpX0XLWk2pEDd13df7WCQOtqoQVDi/cju5Ysy
         Qf+o9FcfFXvGAvziKy3udYrHyNXBLRXICHsAQBB+g3UvosQs/m9QDPsAugB/Z06ijd/8
         LBlJ8fwSM9FPuLbHjZIob0ZFiJc1X5AbdjcIoja6iT8lCngQHqBs+HowUtjf5RQk2nzP
         EJ8C1XzGrqaWCS18tiHxsG86QYgb0WCohiooHPdAqtTjwbYIedB8IJgHHcYpU18fn962
         LaqRavsDtcIkiVGMwc+2fuReV8ZxRkNF4D7C0n34vogKRsCO7FUlOO3OW75+JffSUKM/
         /lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495991; x=1783100791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUQDcnBTlwfuL7EG+sT74DCe/C24lRRbqmUOGTx6aUw=;
        b=CLjxJbIpT54yr9fe01jiyWMjkEimxcHFiXtvKfj5AAHiKJ5PGOmhRJZYhkC3bCirSe
         S4PB6JU3WqrjpjjHE5Z+vlc3eTauCD9U30+THYgwKJrUHKRmJ3/RkXa9fMxKckN6FzTJ
         5TSTU6pfIGaSZPlhYDdEGEShkkzQelzY7RI/8niSfTaORmNt8xDlSdfP61P1amzZ+iYc
         OsrqYpR+xYfY8jL/tpBrMw/dvowCpY5Qo72RqtoWVizJh7GJ6ufW7eI31FxE1nuQX1Wu
         MzYstIpdlPeOstbsFXF1hxUbp6cicyhPiYDB8j0qKpMZcwF25U7W0b8S3j2kaVUGXp8/
         LjOA==
X-Forwarded-Encrypted: i=1; AHgh+RpOw2RJqvbQHZb96Kwi5NorPqMzriICTQqAeQnmIETCga5TGB/2CyrBc9j3R93ROJr6hGf8ZLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMTscyqvOBXdIYIx0YxkhJOODJv5IatxdtCGlukQEVNz1Km2S
	dT9upf9H8qvz+dWhHMLPWH3vTunMKvtU0MgLL37QCg/LfQyRMqHJxVv8REwStA7JeFcGnhrMp9G
	mrIoKZxvissWiK8nc8p5RZk5kAoOV0F4zo9sWPZgMH1WXjHCs27FuHMqMuw==
X-Gm-Gg: AfdE7cnbG+oGiDv24c6ceSzG2aDRqTwbWvq1x9spAw2eF2zL3GD246zudhB3aFKrfVp
	YKtLaxLDXv9m0LyTJc+Td693ka1IxRPf7HAvO1NKM77AG9tW69EJs2AEbcSbJ3kw6/Qsm3GZYTS
	CRXTGR3jOD2vDywwscDQH9m34vfN5rapDy+1kb6c5oXlOJHzeUlkuS/p2XDH0ky3gz0OySQA/WH
	1PDH660qEAzKr+KS1IyW+WB8Ad2G73ghFwinZ6F3dGrsey2LP5k2gDo/GWsyzRc5ZN2Suq1fzeh
	RfL4A9XuUbRTKkaNe2gqewdRw41W9Lt7SoD3ZF3n7bF8WSrM08URELez33tZibXT0U7b1t8O5KZ
	1yd41UfqM32NMHjgwE6q3aFkniYVYvF/ZWOR9Y0SaxAhIOx8qeVhw6DxAgipfvHDg/4E3D3jzWT
	kSuyvhPOw7QpZSsVhb
X-Received: by 2002:a05:6000:2c0f:b0:460:1f32:628d with SMTP id ffacd0b85a97d-46dbf5e5d4bmr13255385f8f.11.1782495990830;
        Fri, 26 Jun 2026 10:46:30 -0700 (PDT)
X-Received: by 2002:a05:6000:2c0f:b0:460:1f32:628d with SMTP id ffacd0b85a97d-46dbf5e5d4bmr13255350f8f.11.1782495990427;
        Fri, 26 Jun 2026 10:46:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46caa798f43sm24258223f8f.8.2026.06.26.10.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH 5.15.y v2 3/8] KVM: x86/mmu: Derive shadow MMU page role from parent
Date: Fri, 26 Jun 2026 19:46:14 +0200
Message-ID: <20260626174620.1819772-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626174620.1819772-1-pbonzini@redhat.com>
References: <20260626174620.1819772-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 2e65e842c57d72e9a573ba42bc2055b7f626ea1f upstream.

Instead of computing the shadow page role from scratch for every new
page, derive most of the information from the parent shadow page.  This
eliminates the dependency on the vCPU root role to allocate shadow page
tables, and reduces the number of parameters to kvm_mmu_get_page().

Preemptively split out the role calculation to a separate function for
use in a following commit.

Note that when calculating the MMU root role, we can take
@role.passthrough, @role.direct, and @role.access directly from
@vcpu->arch.mmu->root_role. Only @role.level and @role.quadrant still
must be overridden for PAE page directories, when shadowing 32-bit
guest page tables with PAE page tables.

No functional change intended.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-5-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         | 99 ++++++++++++++++++++++------------
 arch/x86/kvm/mmu/paging_tmpl.h |  9 ++--
 2 files changed, 71 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index bd7650380ad9..3a5ed9670377 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2070,33 +2070,15 @@ static void clear_sp_write_flooding_count(u64 *spte)
 	__clear_sp_write_flooding_count(sptep_to_sp(spte));
 }
 
-static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
-					     gfn_t gfn,
-					     gva_t gaddr,
-					     unsigned level,
-					     bool direct,
-					     unsigned int access)
+static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu, gfn_t gfn,
+					     union kvm_mmu_page_role role)
 {
 	bool direct_mmu = vcpu->arch.mmu->direct_map;
-	union kvm_mmu_page_role role;
 	struct hlist_head *sp_list;
-	unsigned quadrant;
 	struct kvm_mmu_page *sp;
 	int collisions = 0;
 	LIST_HEAD(invalid_list);
 
-	role = vcpu->arch.mmu->mmu_role.base;
-	role.level = level;
-	role.direct = direct;
-	if (role.direct)
-		role.gpte_is_8_bytes = true;
-	role.access = access;
-	if (!direct_mmu && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
-		quadrant = gaddr >> (PAGE_SHIFT + (PT64_PT_BITS * level));
-		quadrant &= (1 << ((PT32_PT_BITS - PT64_PT_BITS) * level)) - 1;
-		role.quadrant = quadrant;
-	}
-
 	sp_list = &vcpu->kvm->arch.mmu_page_hash[kvm_page_table_hashfn(gfn)];
 	for_each_valid_sp(vcpu->kvm, sp, sp_list) {
 		if (sp->gfn != gfn) {
@@ -2114,7 +2096,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 			 * Unsync pages must not be left as is, because the new
 			 * upper-level page will be write-protected.
 			 */
-			if (level > PG_LEVEL_4K && sp->unsync)
+			if (role.level > PG_LEVEL_4K && sp->unsync)
 				kvm_mmu_prepare_zap_page(vcpu->kvm, sp,
 							 &invalid_list);
 			continue;
@@ -2152,14 +2134,14 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 
 	++vcpu->kvm->stat.mmu_cache_miss;
 
-	sp = kvm_mmu_alloc_page(vcpu, direct);
+	sp = kvm_mmu_alloc_page(vcpu, role.direct);
 
 	sp->gfn = gfn;
 	sp->role = role;
 	hlist_add_head(&sp->hash_link, sp_list);
-	if (!direct) {
+	if (!role.direct) {
 		account_shadowed(vcpu->kvm, sp);
-		if (level == PG_LEVEL_4K && rmap_write_protect(vcpu, gfn))
+		if (role.level == PG_LEVEL_4K && rmap_write_protect(vcpu, gfn))
 			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn, 1);
 	}
 	trace_kvm_mmu_get_page(sp, true);
@@ -2171,6 +2153,54 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	return sp;
 }
 
+static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct, unsigned int access)
+{
+	struct kvm_mmu_page *parent_sp = sptep_to_sp(sptep);
+	union kvm_mmu_page_role role;
+
+	role = parent_sp->role;
+	role.level--;
+	role.access = access;
+	role.direct = direct;
+
+	/*
+	 * If the guest has 4-byte PTEs then that means it's using 32-bit,
+	 * 2-level, non-PAE paging. KVM shadows such guests with PAE paging
+	 * (i.e. 8-byte PTEs). The difference in PTE size means that KVM must
+	 * shadow each guest page table with multiple shadow page tables, which
+	 * requires extra bookkeeping in the role.
+	 *
+	 * Specifically, to shadow the guest's page directory (which covers a
+	 * 4GiB address space), KVM uses 4 PAE page directories, each mapping
+	 * 1GiB of the address space. @role.quadrant encodes which quarter of
+	 * the address space each maps.
+	 *
+	 * To shadow the guest's page tables (which each map a 4MiB region), KVM
+	 * uses 2 PAE page tables, each mapping a 2MiB region. For these,
+	 * @role.quadrant encodes which half of the region they map.
+	 *
+	 * Note, the 4 PAE page directories are pre-allocated and the quadrant
+	 * assigned in mmu_alloc_root(). So only page tables need to be handled
+	 * here.
+	 */
+	if (!role.gpte_is_8_bytes) {
+		WARN_ON_ONCE(role.level != PG_LEVEL_4K);
+		role.quadrant = (sptep - parent_sp->spt) % 2;
+	}
+
+	return role;
+}
+
+static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
+						 u64 *sptep, gfn_t gfn,
+						 bool direct, unsigned int access)
+{
+	union kvm_mmu_page_role role;
+
+	role = kvm_mmu_child_role(sptep, direct, access);
+	return kvm_mmu_get_page(vcpu, gfn, role);
+}
+
 static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
 					struct kvm_vcpu *vcpu, hpa_t root,
 					u64 addr)
@@ -3013,8 +3043,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		if (is_shadow_present_pte(*it.sptep))
 			continue;
 
-		sp = kvm_mmu_get_page(vcpu, base_gfn, it.addr,
-				      it.level - 1, true, ACC_ALL);
+		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
 
 		link_shadow_page(vcpu, it.sptep, sp);
 		if (is_tdp && huge_page_disallowed &&
@@ -3408,13 +3437,18 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
 	return ret;
 }
 
-static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
+static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 			    u8 level)
 {
-	bool direct = vcpu->arch.mmu->mmu_role.base.direct;
+	union kvm_mmu_page_role role = vcpu->arch.mmu->mmu_role.base;
 	struct kvm_mmu_page *sp;
 
-	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
+	role.level = level;
+
+	if (!role.gpte_is_8_bytes)
+		role.quadrant = quadrant;
+
+	sp = kvm_mmu_get_page(vcpu, gfn, role);
 	++sp->root_count;
 
 	return __pa(sp->spt);
@@ -3448,8 +3482,8 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		for (i = 0; i < 4; ++i) {
 			WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
-			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
-					      i << 30, PT32_ROOT_LEVEL);
+			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), i,
+					      PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK |
 					   shadow_me_mask;
 		}
@@ -3557,8 +3591,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 			root_gfn = pdptrs[i] >> PAGE_SHIFT;
 		}
 
-		root = mmu_alloc_root(vcpu, root_gfn, i << 30,
-				      PT32_ROOT_LEVEL);
+		root = mmu_alloc_root(vcpu, root_gfn, i, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index a1811f51eda9..cc70cbb3f261 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -704,8 +704,9 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		if (!is_shadow_present_pte(*it.sptep)) {
 			table_gfn = gw->table_gfn[it.level - 2];
 			access = gw->pt_access[it.level - 2];
-			sp = kvm_mmu_get_page(vcpu, table_gfn, addr,
-					      it.level-1, false, access);
+			sp = kvm_mmu_get_child_sp(vcpu, it.sptep, table_gfn,
+						  false, access);
+
 			/*
 			 * We must synchronize the pagetable before linking it
 			 * because the guest doesn't need to flush tlb when
@@ -763,8 +764,8 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		drop_large_spte(vcpu, it.sptep);
 
 		if (!is_shadow_present_pte(*it.sptep)) {
-			sp = kvm_mmu_get_page(vcpu, base_gfn, addr,
-					      it.level - 1, true, direct_access);
+			sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn,
+						  true, direct_access);
 			link_shadow_page(vcpu, it.sptep, sp);
 			if (huge_page_disallowed && req_level >= it.level)
 				account_huge_nx_page(vcpu->kvm, sp);
-- 
2.54.0

