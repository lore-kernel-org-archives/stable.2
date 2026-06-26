Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE939AD39
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496006; cv=none; b=fI1JX74WOazmABIDhINA+9aIOFJdS2TrXUZl4lg2vD0GbaDeNwXs08LktSR5w1HR+Vw48SVSBtnQDMrJ20aO+lz7CCp6SATOKWfoe3iGRMW4Hv93OxK1igzmtu8Uh0Njrp/xLmJ2qetGgOAAAJJUlMmT5QNw7g8DQQ1590JnClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496006; c=relaxed/simple;
	bh=Bn9GqcfmYnlmatsEnDI7YinIXwkuTGmu/BMxuOuybSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1aoPLq1wLc15o6rzVgs9ZL4FxCUa0GKzkSGs+34zVzvurkf7AQWJj7qEWMnecvbuBbzYwB+sx8XbdXXa0pqjUyvxbcIlizGSUPttFd1MpXYWwfMyNaCbxS+xzK/GnVOj6KYZYa1WJzYXwJo4X8r5woQZbvUEEA56I+y9kF/Jr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWzuh93I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT+D4aY+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWzuh93I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT+D4aY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782496000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTWYGkQfMagiJ9l0zZ4MqOhwkIaxx9WRDrNgyQm3MDw=;
	b=IWzuh93ItjFhVmvotx+v7kfKWn8hIbmhPNXnuz2FfgkEfOHshmwKvMALjcQMhaZKjqrrbh
	ijOd3rQG8rY8sk+ErHisd/YnS93FsKRk576gn0nXTo+8PLDUiI0sb/4lcaip4XxbL8sMDh
	uMOkK5Wa7zzFeeMWU5ULBvCU1lBMQ6w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-OZGsG7g_P62pQZg3SRbHTg-1; Fri, 26 Jun 2026 13:46:39 -0400
X-MC-Unique: OZGsG7g_P62pQZg3SRbHTg-1
X-Mimecast-MFC-AGG-ID: OZGsG7g_P62pQZg3SRbHTg_1782495997
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490e547f3cfso16389035e9.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782495997; x=1783100797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KTWYGkQfMagiJ9l0zZ4MqOhwkIaxx9WRDrNgyQm3MDw=;
        b=AT+D4aY+cs5YeuB2NPjQhvqtzSS/9SueRDXADWQoY5eBF4CS5qPzOwbKv6shKcS53G
         poIOFHQAoHpvCJ+feVl3n0Xtm3aoDIvm4yauhWa/hS17Wq+22NNliAozAKcU0FapJf+e
         mN2cvpuN+W5XAAQdcvq0AE5xWjNy4S3pEO8xCd/gtRsoiK1iDzxkE52DYU2vmbNkneXb
         LHVpCO/ETY8m9ZLQvMcM0fZZjtXB6S+19CQXkd7c8Sioj/bcOVSxyavt5J/wSuvvsgNc
         mqGewqmo3c0RY4DuyNHQ61BXBR+QriAg+jpWust7VXaDHcPrJNeaVrqVXxKhZPaD/kqd
         sELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495997; x=1783100797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KTWYGkQfMagiJ9l0zZ4MqOhwkIaxx9WRDrNgyQm3MDw=;
        b=dByIC7zUAyXmYMXW6Dco7VS2lTGpEVHamXelXDwca6e8hsJ/w3ZUY4MkNdhl3xVl3n
         CkTwVavCyEFYvnBMtTrHbNJENu0cWvtumPFuyqJKBitpB9FchZ9WJoaj/5N0zd0vV5jx
         ondFXfBRVdOsQZQZ0dsw1pTY08MfXq2nO/03pyRa2kirL45KyLIMsBZ5qNZCkx1mY5Ef
         PBWIUaHY00qD8qOOMlYpwm/DQfYJuMnFgHEiSHgzUUCsGMLfeAavkustJnm9c6QWrwGm
         GAQD+U6V1DeAnt54osAN1hE11Kk3CUaMCsWgwwav572J/lx17ogFY719sfj/BVwVhKBy
         Qung==
X-Forwarded-Encrypted: i=1; AFNElJ+QrWVZ+4f7t3Qyd43Ka0/ByQqQ9wEDkQoHy1b5vkhEIsNgmGnVB/n3vAQ47trtpQsJl7bZu4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PqFM2nkV2wsfdQalw+B4un8TLXjvyBOM6EGQlxDAxnTjOsWa
	SUJGVgAFcMdkqRPFMUSrIktdfl4TxsB0O3bH6G8kkCozzauWPuP/nT45lVLbR9S+sgIUm3j0X8M
	t+OOrFyKpp0nPFcc/YbFKaHwGBZlVKA0psTAI7rz6bSXi2MOUsTL1O+HDYQ==
X-Gm-Gg: AfdE7cl3koJlbBsBQhfYUPqA09m51FumesEgOvgMdBRxj+tuao0NoGSA38pzjAIxKDB
	pS2p9OMp/tTNYouOoJP8hMFvriN7ECfY33fuI+2lgar/HdpJq5skD2W/CqiLUVdzwItJQT6zumq
	2B8Nl4K3mfxbwN3djrd7FlLKkZm6rHA0LotoSE72clM73gWfR9mORdUjFSMaXIuxvVSAgpxMTbt
	L+uTy7VccVfa10Mgp2QtWK8rJDrkiG8fMIiTpOCzyJ43wtk1i3rtmbVceOF8hid/gWagMXvU6ZG
	X8gBaMG4KJTt0GHkU/KxhPPg+DKItboSSZ692I6AbmhDhbagDW0xeTxXjwu5N0DY76f8ZMqZkKH
	5TFTcbHSWmbB/amzXK1Uig+VjSAlONZ/oKApyEM1Y+Usyrn1WngYfRkNBDC35IKtm2bXDH07OOf
	oQzU6hgmZB2+dZiQfW
X-Received: by 2002:a05:600c:3b17:b0:490:b7e6:bd1d with SMTP id 5b1f17b1804b1-49266874055mr120894265e9.16.1782495996649;
        Fri, 26 Jun 2026 10:46:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3b17:b0:490:b7e6:bd1d with SMTP id 5b1f17b1804b1-49266874055mr120893985e9.16.1782495996248;
        Fri, 26 Jun 2026 10:46:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4701835b625sm362275f8f.36.2026.06.26.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15.y v2 5/8] KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
Date: Fri, 26 Jun 2026 19:46:16 +0200
Message-ID: <20260626174620.1819772-6-pbonzini@redhat.com>
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

commit 0cd8dc739833080aa0813cbd94d907a93e3a14c3 upstream.

Before allocating a child shadow page table, all callers check
whether the parent already points to a huge page and, if so, they
drop that SPTE.  This is done by drop_large_spte().

However, dropping the large SPTE is really only necessary before the
sp is installed.  While the sp is returned by kvm_mmu_get_child_sp(),
installing it happens later in __link_shadow_page().  Move the call
there instead of having it in each and every caller.

To ensure that the shadow page is not linked twice if it was present,
do _not_ opportunistically make kvm_mmu_get_child_sp() idempotent:
instead, return an error value if the shadow page already existed.
This is a bit more verbose, but clearer than NULL.

Finally, now that the drop_large_spte() name is not taken anymore,
remove the two underscores in front of __drop_large_spte().

Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         | 49 +++++++++++++++++++---------------
 arch/x86/kvm/mmu/paging_tmpl.h | 29 +++++++++-----------
 2 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dbc18d4cc572..d58be2e698f7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1179,26 +1179,16 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
 		rmap_remove(kvm, sptep);
 }
 
-
-static bool __drop_large_spte(struct kvm *kvm, u64 *sptep)
+static void drop_large_spte(struct kvm *kvm, u64 *sptep)
 {
-	if (is_large_pte(*sptep)) {
-		WARN_ON(sptep_to_sp(sptep)->role.level == PG_LEVEL_4K);
-		drop_spte(kvm, sptep);
-		return true;
-	}
+	struct kvm_mmu_page *sp;
 
-	return false;
-}
+	sp = sptep_to_sp(sptep);
+	WARN_ON(sp->role.level == PG_LEVEL_4K);
 
-static void drop_large_spte(struct kvm_vcpu *vcpu, u64 *sptep)
-{
-	if (__drop_large_spte(vcpu->kvm, sptep)) {
-		struct kvm_mmu_page *sp = sptep_to_sp(sptep);
-
-		kvm_flush_remote_tlbs_with_address(vcpu->kvm, sp->gfn,
+	drop_spte(kvm, sptep);
+	kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
 			KVM_PAGES_PER_HPAGE(sp->role.level));
-	}
 }
 
 /*
@@ -2197,6 +2187,9 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+		return ERR_PTR(-EEXIST);
+
 	role = kvm_mmu_child_role(sptep, direct, access);
 	return kvm_mmu_get_page(vcpu, gfn, role);
 }
@@ -2264,13 +2257,21 @@ static void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
 	__shadow_walk_next(iterator, *iterator->sptep);
 }
 
-static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
-			     struct kvm_mmu_page *sp)
+static void __link_shadow_page(struct kvm_vcpu *vcpu,
+			       struct kvm_mmu_memory_cache *cache, u64 *sptep,
+			       struct kvm_mmu_page *sp)
 {
 	u64 spte;
 
 	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
 
+	/*
+	 * If an SPTE is present already, it must be a leaf and therefore
+	 * a large one.  Drop it and flush the TLB before installing sp.
+	 */
+	if (is_shadow_present_pte(*sptep))
+		drop_large_spte(vcpu->kvm, sptep);
+
 	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
 
 	mmu_spte_set(sptep, spte);
@@ -2281,6 +2282,12 @@ static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
 		mark_unsync(sptep);
 }
 
+static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
+			     struct kvm_mmu_page *sp)
+{
+	__link_shadow_page(vcpu, &vcpu->arch.mmu_pte_list_desc_cache, sptep, sp);
+}
+
 static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 				   unsigned direct_access)
 {
@@ -3039,11 +3046,9 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		if (it.level == level)
 			break;
 
-		drop_large_spte(vcpu, it.sptep);
-		if (is_shadow_present_pte(*it.sptep))
-			continue;
-
 		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
+		if (sp == ERR_PTR(-EEXIST))
+			continue;
 
 		link_shadow_page(vcpu, it.sptep, sp);
 		if (is_tdp && huge_page_disallowed &&
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index cc70cbb3f261..0f68f5afa642 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -698,15 +698,13 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		gfn_t table_gfn;
 
 		clear_sp_write_flooding_count(it.sptep);
-		drop_large_spte(vcpu, it.sptep);
 
-		sp = NULL;
-		if (!is_shadow_present_pte(*it.sptep)) {
-			table_gfn = gw->table_gfn[it.level - 2];
-			access = gw->pt_access[it.level - 2];
-			sp = kvm_mmu_get_child_sp(vcpu, it.sptep, table_gfn,
-						  false, access);
+		table_gfn = gw->table_gfn[it.level - 2];
+		access = gw->pt_access[it.level - 2];
+		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, table_gfn,
+					  false, access);
 
+		if (sp != ERR_PTR(-EEXIST)) {
 			/*
 			 * We must synchronize the pagetable before linking it
 			 * because the guest doesn't need to flush tlb when
@@ -735,7 +733,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		if (FNAME(gpte_changed)(vcpu, gw, it.level - 1))
 			goto out_gpte_changed;
 
-		if (sp)
+		if (sp != ERR_PTR(-EEXIST))
 			link_shadow_page(vcpu, it.sptep, sp);
 	}
 
@@ -761,15 +759,14 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 
 		validate_direct_spte(vcpu, it.sptep, direct_access);
 
-		drop_large_spte(vcpu, it.sptep);
+		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn,
+					  true, direct_access);
+		if (sp == ERR_PTR(-EEXIST))
+			continue;
 
-		if (!is_shadow_present_pte(*it.sptep)) {
-			sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn,
-						  true, direct_access);
-			link_shadow_page(vcpu, it.sptep, sp);
-			if (huge_page_disallowed && req_level >= it.level)
-				account_huge_nx_page(vcpu->kvm, sp);
-		}
+		link_shadow_page(vcpu, it.sptep, sp);
+		if (huge_page_disallowed && req_level >= it.level)
+			account_huge_nx_page(vcpu->kvm, sp);
 	}
 
 	ret = mmu_set_spte(vcpu, it.sptep, gw->pte_access, write_fault,
-- 
2.54.0

