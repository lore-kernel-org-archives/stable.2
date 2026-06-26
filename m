Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220213F411B
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473186; cv=none; b=eJIFTGpyZE4KSt0bdVMm8bExrNYZkjiyckp9l1g8ikY/+TFxFOdGXEeWPgenourX5isoxNs4XpErrVh8WBGyUeF2wkwO+kBqv+whVdQdTh6QDIUuHRVSEBfBBxjLOBjlZpRiDmKx7C3e42ua0idiE7oXCAsFbs+qHnTmOLmuZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473186; c=relaxed/simple;
	bh=Bn9GqcfmYnlmatsEnDI7YinIXwkuTGmu/BMxuOuybSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhYtdkknLhrJeQfwFY/dwbtMTB8Sg74uRfU2jDia2Ud3cW9BXXc60WycjH6hvSLFRhwEweYgQGvo87zBHTStSLgk+dESNThXPoIGWpo2yY/W+TMuK46JllMszHalqqbmpycaFOtZ2pXMqx+DnZuWBboVco9YJ6Ky7a6v7y81a7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7YSLF1D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbRXLpLu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7YSLF1D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbRXLpLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTWYGkQfMagiJ9l0zZ4MqOhwkIaxx9WRDrNgyQm3MDw=;
	b=A7YSLF1DPboAX1E4oTwZ2VCB8GVxhg6A++yDWcuRBkM4+rxTmu557TPnGTOhOYkZXVgmFD
	ANQl2R0RpYuW6sEskaRpQ8mcf/jVesddnoVZvu/cEdOrpdMZCrGJEBqIBgBPf/XlabHNMK
	uLs/+Wf4FCLiw+iR6olnIqY1p8o2IFY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-TZNZYnpFN6ubCQLT751Pmg-1; Fri, 26 Jun 2026 07:26:23 -0400
X-MC-Unique: TZNZYnpFN6ubCQLT751Pmg-1
X-Mimecast-MFC-AGG-ID: TZNZYnpFN6ubCQLT751Pmg_1782473182
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4924583c7baso10228215e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473182; x=1783077982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTWYGkQfMagiJ9l0zZ4MqOhwkIaxx9WRDrNgyQm3MDw=;
        b=UbRXLpLuy8X02dNpzUpWlwRfN9SSLiDmiyD+Ok+K/7Xe83jmL7IF3hpQY4gPUT4a+F
         OlO+6QtSfpNRxwcClVxzx73LBU2YP5Q81M6EMZfPCW8S9/4oeG3iT26EeJUPqiWCNDhB
         OJFAccE+3qX3BA6f4yrQ5AnIu57XV64be25j4JxWZCbgj4XE8tQAZB6M4V3qRc/MvhbV
         g2nGWVyrS37Lz+76Dp//5nJTiDFVbJGGFZD5T5lby+FA33xvQhzknkVviAeOt+dXm3To
         uuxtcgP8EQ7nQNFWqMEnEvc/M47PhUY1JK/q5KHCcn+N9wGMTpGfL0EHiSas47gYfCQ+
         MArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473182; x=1783077982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTWYGkQfMagiJ9l0zZ4MqOhwkIaxx9WRDrNgyQm3MDw=;
        b=iqlX/cDRPqeGErn8BS7bUCgVB0htJEmeqQYDOoFj6aYJ3ehvnUI4bGsmAsszvSNc0y
         Ku66RcSEhHIH1Mw7R0wcgJjAMe/Wh1KVkvuSnfcvpoilAJfou4xgfRxCAtCtiY/uGDNk
         UyCTAvVUhMw/Zo9O1T7WulGsUg3+yAIB5aUy5pJJvtt7HU5UfF/+uez74Tk8iKe0vphM
         scPYI2nNtFX75m1edRIMqMyc5IuYvnehUxbSGvtumkB5Qijk9kik9JHpSIkEJRuFTqfy
         EdUOngACHjfh/oBXpiueCnmGI9flgYT/DqYnCcIiYIvm7cN9ToQYI2JdHJa5FA2j3nj7
         XZZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dTIimG+6L+mQ8ojT80ueVzin/IQ6BvmVXhWque/34QguvWgoHL1qAEKVih3pCj6y8xGQ4edE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAUHVn478wksVF2kECVR+7ThjpBwrnQJA8wHOF7EMVSiGoOZsT
	VtJw1BRnf0PtpMlpdjqNrcALEasijEYhg0CePIyb3Va1/PH8HzcILRWQvt3XJxWH5sPUs9hqEoh
	FcGLDFqZF0ABmuAL48iIauaecGI0Hal9VTtaHcgyNKPl9C9x12lJj0NXlGg==
X-Gm-Gg: AfdE7clUhqdY8JPZQPWcYS1Zooyntoe1UYFLWElTHna6wIRBkJSDYUgRexS/4x2ygMu
	MShL4dlSM67cP67jAk1XLtWFbrT72AK5Kl3Jl89oVxaAvpLl7tj6xkAgEiEySq3iLYB5QUJpzHr
	VP+9Ltf01AlOpgSfNW1htoR0CR2kqewOWnVQ2KLs2NSPuj9JvM9ov9hJWrn4Bj/JqnKL0MCGoQf
	fhdK6V47jK/wZ6JMJH+8tvsyMLN4hNya/lpPK+l9cS7dOhjJCmcpEYh1ZPjXif3rzjMz+bZf7Q+
	ay++otyYahuH+vNYrVl7qx+PqDJanPi1BrZHJuJEx0zieKqpnThXjWfnPSYtkfO3JuTL1jCaRxx
	7k9cp+Bb9jWadR02YnNj2CTNlmuFkYVncCmLAPkpGS9hrYzwwu88tOQam18OzcoSraNMHGw7kKi
	TNFBMp3XLelMLRdIjY
X-Received: by 2002:a05:600c:154a:b0:490:b8e6:be40 with SMTP id 5b1f17b1804b1-49266881b0dmr95277065e9.21.1782473181593;
        Fri, 26 Jun 2026 04:26:21 -0700 (PDT)
X-Received: by 2002:a05:600c:154a:b0:490:b8e6:be40 with SMTP id 5b1f17b1804b1-49266881b0dmr95276645e9.21.1782473181210;
        Fri, 26 Jun 2026 04:26:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fe949csm84033585e9.5.2026.06.26.04.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15.y 5/8] KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
Date: Fri, 26 Jun 2026 13:26:03 +0200
Message-ID: <20260626112606.1778248-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112606.1778248-1-pbonzini@redhat.com>
References: <20260626112606.1778248-1-pbonzini@redhat.com>
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

