Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94C3F825F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473231; cv=none; b=abqTPEbgCllSAkb4w477NkdX+J0CwSab+sdbJe6DGvMu1QAw5iPBaKlVw21Mb+Z+aYhnrNCjVrbtHCjKNOdbjLqLrnIuTl415sDOA6lLXNEfmBr17VQWkqMo1cfu75SfVgadvB/p+rJ8/DCdhxJVDQIOtHCiKtoCjY3Pzkw3OZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473231; c=relaxed/simple;
	bh=4LAo5cntnJrzKevnVfmCzD2yJX4HzEXg19LINgkx9SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHD/kfPgEeyb7Z0zYwK6IKBVynrsiQDslt2Y+T4cfQKnr8Z8uLvBA2UEtI4WTT1adP8Jy1zmU+qhT0INYZ399jfJwRmsTZwbFRA7Tedccv0V1K0ckd0GbcTSMqRzK+T/FCOGhZiGm6VH47ZXMs0GdgsAuaIreToqsozoVEQJaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCPTAJRZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTU6my05; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCPTAJRZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTU6my05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plvs3uX60jFPn0//6lOYkBMC2oyKDTuSMPh8BGjsZZ0=;
	b=QCPTAJRZYg1DMUEEvoFadtgto0kQLa8Jpa1ysCC4GBZFQkA1pFBeksHgXw7dvuuBxC2v73
	x+fRKc28zYEpo5mSsI+bu4qZkA8Uppu4tRk/BXJPULvazeaopvgnNvD+6gXxOvQHDpCbbQ
	b1VNxyfieCOjs77e4NaLvMei1DaZyvA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-lgV7zp-aM0qQgaSByhOolg-1; Fri, 26 Jun 2026 07:27:05 -0400
X-MC-Unique: lgV7zp-aM0qQgaSByhOolg-1
X-Mimecast-MFC-AGG-ID: lgV7zp-aM0qQgaSByhOolg_1782473224
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4924725bec9so5257775e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473224; x=1783078024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plvs3uX60jFPn0//6lOYkBMC2oyKDTuSMPh8BGjsZZ0=;
        b=GTU6my05Mg8ox/ONyHJxNNCNQP3zctMwiQYs3YIKGnyqyBhFJid2ZuGDfiyaWw/1pQ
         NwDPdv2sAsJfKq7YgqUOo4MXkHfW/ARWP4BQ3EswUZ5+Ko701WaAxF7unEAys0YPooYY
         J8jD04KKcGoZZYNBgGSBl4Hy7mC/ybM2j4Khd/UifgyxoVcxih2uFGruU1yqiU/S62JG
         epEBzZZ3eehKrULZCA/QkXlXrS54b7dj6JZQv7Z/vZfHBGnG8XluDCTNBAS5DsxVPOm5
         FZj/L17gk6/bvqEvSMisObPVSFEr+cI4YKcsy+Y6XjnSRiB76601s7x/ajhDhqUVhI/s
         ddRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473224; x=1783078024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plvs3uX60jFPn0//6lOYkBMC2oyKDTuSMPh8BGjsZZ0=;
        b=dWrPynCd3Dp1/hlF8Hntw4PW+Epx5qpBSk51E8a8x1hqsrUp/1Skr8ItMBIRGTgynj
         vEBcLRap5qQh9JF9FTNc9Wafcmm6WBCI2PbtlIxaUd7I6V6Vr+S2dYCn44wki+7IuKjQ
         8GwoRSLDjWqv4btDjlsj/qm1YvRQkiQqwCs7/9sVPqP5LG7L8S/5KIkgf2yyke8Ra9xy
         +V2U5Rbl4L8WJfL7rYwnvlFIKHnhmh5C+iKFR8OqnCgKZZW+/VHZtLmcwFrS0Y2cmsHU
         ukdN6ef0ACkxmFPrI38+YEV5Km1EGJtdeBamf9ytGjUQFCj+bkwYecaf/28Upe1DRJUA
         AXYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mmW4s0NsX+LJDEqPeQb41ONj1hojp7T5dJ45lMp1JNwGc54WY0vOFVoFWkZUl/1y5+n++Hgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFPqL67iNgxk7ab33/j+6cDPcVOO/A4TJ/SYYE1Ou0oEIhskQ
	5zzO5qXBswWPkliiA9lLg3+fy9/qdemJOKhgJypJ1qR19EIKOQgmRbBIl3quqZRdnAX1oFbDqvJ
	Rd5ugfO4FU2AmbM8uhJmtsy/uUjTB7UG9zELdG9mHxTcfYQLOSShAAM4XHw==
X-Gm-Gg: AfdE7cnMQhXcTe3sseSvgrkN6zdbTjYgt/QCXRxXChfqIWv7VZUKidTRyFVty03prc3
	WcC2Y5qw0Xh2f52jMhsch4qa22vkL8C0ZPdwMVbo2Z7NdYy56yGBd5kl1nNsaNaQqHlAL8wrYEj
	M8Ixj/PKJtzmfbRNXac/uuf3MTsPe73bf6LNkFfLu/a+UKieius1eO7TxT7ugtPYYaNBInzNIYi
	Ol0so24oXdIrrhB4SDXFLqwXfS9Jv82x7lUbDT/wdGi1xes5z6fr28R82N2jtnqghr5DJf/D3eD
	DzHdGArtlcyWcD5yjR+/yM64OVfGKNt6Xh8o0LB82W/7JqUy/1gWM8NldRwbBtIHLUK6s2PX/bF
	Td64ZaBKJihTpJ3uUadMkH1TQ7Z6ARyn4aoDtA4zYDHW6j1SuJnwx+UdU9amJqnhRGHvL3Wg0D9
	WAkcit3URUP4FaXl3F
X-Received: by 2002:a05:600c:4e45:b0:492:4948:bfce with SMTP id 5b1f17b1804b1-4926fc45f89mr6531795e9.16.1782473223776;
        Fri, 26 Jun 2026 04:27:03 -0700 (PDT)
X-Received: by 2002:a05:600c:4e45:b0:492:4948:bfce with SMTP id 5b1f17b1804b1-4926fc45f89mr6531135e9.16.1782473223302;
        Fri, 26 Jun 2026 04:27:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fef710sm127137345e9.7.2026.06.26.04.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:27:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH 5.10.y 10/17] KVM: x86/mmu: Derive shadow MMU page role from parent
Date: Fri, 26 Jun 2026 13:26:27 +0200
Message-ID: <20260626112634.1778506-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
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
index 6db07ebeb695..e4759156a2dc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2023,35 +2023,17 @@ static void clear_sp_write_flooding_count(u64 *spte)
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
 	bool need_sync = false;
 	bool flush = false;
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
@@ -2088,22 +2070,22 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 
 	++vcpu->kvm->stat.mmu_cache_miss;
 
-	sp = kvm_mmu_alloc_page(vcpu, direct);
+	sp = kvm_mmu_alloc_page(vcpu, role.direct);
 
 	sp->gfn = gfn;
 	sp->role = role;
 	hlist_add_head(&sp->hash_link, sp_list);
-	if (!direct) {
+	if (!role.direct) {
 		/*
 		 * we should do write protection before syncing pages
 		 * otherwise the content of the synced shadow page may
 		 * be inconsistent with guest page table.
 		 */
 		account_shadowed(vcpu->kvm, sp);
-		if (level == PG_LEVEL_4K && rmap_write_protect(vcpu, gfn))
+		if (role.level == PG_LEVEL_4K && rmap_write_protect(vcpu, gfn))
 			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn, 1);
 
-		if (level > PG_LEVEL_4K && need_sync)
+		if (role.level > PG_LEVEL_4K && need_sync)
 			flush |= kvm_sync_pages(vcpu, gfn, &invalid_list);
 	}
 	trace_kvm_mmu_get_page(sp, true);
@@ -2115,6 +2097,54 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
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
@@ -2897,8 +2927,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		if (is_shadow_present_pte(*it.sptep))
 			continue;
 
-		sp = kvm_mmu_get_page(vcpu, base_gfn, it.addr,
-				      it.level - 1, true, ACC_ALL);
+		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
 
 		link_shadow_page(vcpu, it.sptep, sp);
 		if (is_tdp && huge_page_disallowed &&
@@ -3227,13 +3256,18 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
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
@@ -3256,8 +3290,8 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		for (i = 0; i < 4; ++i) {
 			MMU_WARN_ON(VALID_PAGE(mmu->pae_root[i]));
 
-			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
-					      i << 30, PT32_ROOT_LEVEL);
+			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), i,
+					      PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
 		mmu->root_hpa = __pa(mmu->pae_root);
@@ -3323,8 +3357,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				return 1;
 		}
 
-		root = mmu_alloc_root(vcpu, root_gfn, i << 30,
-				      PT32_ROOT_LEVEL);
+		root = mmu_alloc_root(vcpu, root_gfn, i, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 25d4484c78aa..d5facee0db60 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -667,8 +667,9 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
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
@@ -726,8 +727,8 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
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

