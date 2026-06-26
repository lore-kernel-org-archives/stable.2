Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877073F88BE
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473238; cv=none; b=C7kjYWm+wBPn4ahgldy+Sq8+NnkxjrlbJ5MHbgf8lY76rcvpcaZ9RL0lJ/uqOtbY5Av0QcIl6MXTh9g+VwJZ0uEXNR0uVcigjoc3ZIdumWucbSSTKKLSYa9qzsvvleEYvOyES1iWAQnGruRZLAAffdXIt36fcVxhEA3ou6DePHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473238; c=relaxed/simple;
	bh=XKqcae9+Don1b55+R5JA19jiHll4kjMqKowe4S6YavQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe3a80iIhAmN/TcOrCD9nGBsFgfYhv2MqIqnlmf4xu2e/vy7QK1Xnvtgm34dixa7NiMWXf2mnvdsa6CrY5Ho84828yT8VjAMqYkOtq9h8vvBVk04T1iUuwpE7UrmJIW7BBFDR5eqhBvkgnoXPLtTJ4vvRr99Hnrg0hgrmQUgqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0H5A7NC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTL2aVBs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0H5A7NC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTL2aVBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWvS5GCqW407fjbCc5yPHkkipazXCaeN7akeVks2xPw=;
	b=f0H5A7NCdGm5wcbGH/7apXW8MUVgaKSUyt4J5pHXL/ZCVnPzuRvl5P0TKp0IdnNI1c1+Pq
	WsRYN8fXME4yWYVNhzUwbEwPeRvThL4nFOrLSXrqvXHMUA8IjULY9+0Sk9pqxWoNdoE75g
	90lcQHMqmDTYwKS0e9KATI1PU/K1cxQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-gBKEC7IjPwSdJymUVrEncg-1; Fri, 26 Jun 2026 07:27:14 -0400
X-MC-Unique: gBKEC7IjPwSdJymUVrEncg-1
X-Mimecast-MFC-AGG-ID: gBKEC7IjPwSdJymUVrEncg_1782473233
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46c90c8fd42so614652f8f.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473233; x=1783078033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWvS5GCqW407fjbCc5yPHkkipazXCaeN7akeVks2xPw=;
        b=LTL2aVBs5W0DwEzl0aN4NpqDRswLaBUsw0/aDK4ywv/AHBBJxNA8yg5iCOCrc3d2/t
         MW42PKYZ09vzLQQ5yaO1UCIlUO19I6FcsC8MCzfWTrah0jl1tiljIT/FvrTZYEvWWKg4
         rUDm2iHXK5tP6Ng2JE5bzFzAq4sQn3t2xI3BjHmWjC8R5BbM4f2wqI8ky6HBJHAecs8J
         H7CC9RG5ID87ARPtwWq/r9ktivfrEdkJtNJRmZKG58FzamRjgxB+RhzF+7DQGgoAtrrW
         K0ul7JKATaVINDkMqRpN1P0/vgZodwt64gUhRQrI/o8VJ7doTXfAejxVXXj3Ko1bKW+q
         dShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473233; x=1783078033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWvS5GCqW407fjbCc5yPHkkipazXCaeN7akeVks2xPw=;
        b=p3FxUjJp9p1+4ryIY0vxq3hzMaMcTAl6Op++8qGx8ovb0kqamRU9CZ83m6Tibyf4zW
         zFXYDgxhj3YZONJuNTEXmbOMs1c4FFsQTNRR6wk3C6Il91A9S+vU5obuIF5HpoIXKTlb
         8r2RnIWu33BVXKSTas2gsV4vc5fdKkIfpBMd5tvWHwIbnHpSxrGFogJxdTdJIfrhZgJm
         /UuxMKx/REJ3r3HAJYNxwETWtIRJY4ap47rL4qaO7uXfpVxcbCPlv/Xe23DshsPwAaAu
         3xb/eEjblX0grd9t+Sj/S1cVMpeSYKIRSCi63/S2XAA7Z6NP3OyMz8pTA9ERZpz5z/uz
         uCRQ==
X-Forwarded-Encrypted: i=1; AHgh+RoP2t4tcsvNph2W7i6f/bjmK40XG28Xs+t/IqRuPE7JuA4L+I4/DtIrGMBmvRZtfMcYDgIKZzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSghO7am3FGrmW0iRReJP8vK4CeIH48tsvb/87i2dx62z3Y7LI
	YLmC8GqeYK8RAW+i6Ry1a26BSMU60TUqKwOfzZ9NDC9Q+SPkz9tq25XS8ZED+9hOSrXsZjpiVUE
	V6UDd60WggO/hNUFikyP/OlPorcT84Uhnby5tH4TqZcz6cCg+XfF6Zp8VNw==
X-Gm-Gg: AfdE7cnNH2y6cSyjGt4gxFRy2bVjt8Gvl27bMFpkCWJCj9k9RlMVuoshU3ikT0t+i04
	eYCim5bS8zXR1NVKdny1ZKJydvhoLQc8hKh8rS8cJRVUojuiqaejyDGwoYHiP3zSto6dmchbIkr
	0oxNpyZHc8V/s0mJd6Aes5V9BFbmSAuR+q6ZnHSS2FIypfcu7TtD/tqo/KN7s5R6Nf0tamKmF7i
	dG0lKG/ictDEk7POGUzFWNfdPCT5wvtlB12u8LmfVMXyn/+NYW1Kqa5cFvjlqCAYNyuEBNpdI8v
	UXaotdvuIXZaq2SZSFSuR3KvQsK+xr1wWTBWEoYwXYCzpsnPtp0HQJPq+DKO09m77e0JKMxEhkQ
	w3XcqsSWJaO/bDEhbBjuSGS4+xBtlVy2eTWaF4s1ICCfvv4bbGXCFDbJCgfAxj2FbVsLDy/Vv6v
	Uu2XrRSQwiCtXtJSRg
X-Received: by 2002:a5d:5f4c:0:b0:441:1e8e:d8fd with SMTP id ffacd0b85a97d-46dc12dfa46mr9183564f8f.29.1782473232663;
        Fri, 26 Jun 2026 04:27:12 -0700 (PDT)
X-Received: by 2002:a5d:5f4c:0:b0:441:1e8e:d8fd with SMTP id ffacd0b85a97d-46dc12dfa46mr9183481f8f.29.1782473232001;
        Fri, 26 Jun 2026 04:27:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d998esm23376169f8f.24.2026.06.26.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:27:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10.y 13/17] KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
Date: Fri, 26 Jun 2026 13:26:30 +0200
Message-ID: <20260626112634.1778506-14-pbonzini@redhat.com>
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
 arch/x86/kvm/mmu/mmu.c         | 51 +++++++++++++++++++---------------
 arch/x86/kvm/mmu/paging_tmpl.h | 29 +++++++++----------
 2 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5df1cd5bff1b..47c5c3613b68 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1067,27 +1067,17 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
 		rmap_remove(kvm, sptep);
 }
 
-
-static bool __drop_large_spte(struct kvm *kvm, u64 *sptep)
+static void drop_large_spte(struct kvm *kvm, u64 *sptep)
 {
-	if (is_large_pte(*sptep)) {
-		WARN_ON(sptep_to_sp(sptep)->role.level == PG_LEVEL_4K);
-		drop_spte(kvm, sptep);
-		--kvm->stat.lpages;
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
+	--kvm->stat.lpages;
+	kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
 			KVM_PAGES_PER_HPAGE(sp->role.level));
-	}
 }
 
 /*
@@ -2141,6 +2131,9 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+		return ERR_PTR(-EEXIST);
+
 	role = kvm_mmu_child_role(sptep, direct, access);
 	return kvm_mmu_get_page(vcpu, gfn, role);
 }
@@ -2208,13 +2201,21 @@ static void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
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
@@ -2225,6 +2226,12 @@ static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
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
@@ -2923,11 +2930,9 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
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
index d5facee0db60..250b4b0f6b68 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -661,15 +661,13 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
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
@@ -698,7 +696,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		if (FNAME(gpte_changed)(vcpu, gw, it.level - 1))
 			goto out_gpte_changed;
 
-		if (sp)
+		if (sp != ERR_PTR(-EEXIST))
 			link_shadow_page(vcpu, it.sptep, sp);
 	}
 
@@ -724,15 +722,14 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 
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

