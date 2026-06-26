Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E513F58CD
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473213; cv=none; b=RaHqeQxhJNObFTpREqI0zftRM7KQc/JPDKiLH6z/A8rQyknTv2OhV8sV1wHMYTQW3BcIot9iUFbU9iwoOEciYKf+y5HR5w32+v4NbU0GFCEn82I7+lIfWHSxnc2cb2WqgXnALep9KKdJVcEleFdqdHgTcFXrroKZ9Nb6UZNHbZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473213; c=relaxed/simple;
	bh=hm1d5HfYmLvZEG3jBh5ZSp16HGGdwgQTufSKNBQkAjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMVLjiuJHKVmycKRehrTXPJFgd2xAG2S/xXaRFnCU5e5jb9pGejQ2PvJ/AmLevdmgOG1gjBh+Atb7SQ2YJHaixCIkxGMlGWs3n66OTUk7IC5XTW2QxNP0sWps+MyOKNGP+mZxAg3MauW/coc7luXdLsXdK2sABaYP3YRDL/7Znw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agWY2bFG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Suacvc0x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agWY2bFG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Suacvc0x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7jUj/WYhpwqBuo+wix2BnJk6EgwJ/lk0dvKuGJAH7g=;
	b=agWY2bFG7hUGX57+G51NKAPRphoPctx4rRuRpcVQ+j69Qq7GI8LoMoEQ1SR6l3FC4V/pjc
	P99HF+tRfWaxP3UaWgGmROk8TjJvkBFrgZgPvl43tHKvb1gjo5MaTU0soeJgttbCERGqIq
	IS+J6oHsvcjgqxSPpT1Z0+uJUPK2ceU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-FTjjKzK-PMuI2PHNUy4xoQ-1; Fri, 26 Jun 2026 07:26:47 -0400
X-MC-Unique: FTjjKzK-PMuI2PHNUy4xoQ-1
X-Mimecast-MFC-AGG-ID: FTjjKzK-PMuI2PHNUy4xoQ_1782473206
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49245e10b73so5153525e9.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473206; x=1783078006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7jUj/WYhpwqBuo+wix2BnJk6EgwJ/lk0dvKuGJAH7g=;
        b=Suacvc0xXWW9xTg5ENJmYkLRpZUBmKbztwr3fks4P+LcgHliCQEi91Ey1kmN/uRJS/
         PIenF56olbNTRyHqxlDm5bo+Nte3e+k3fqrWsMi65jA6IQ/zLPHH139tltGRtyP5U7DA
         QB8yqdS4tsTHrjveLOmj1wj7ZNFFqeKdtY54iFG1G5R4/wwm2CizJpQjOZxKdOMGbkuI
         0g0Q7w6UYG13GnX+g0xyMJf8dEvo+orQFWrx9Zr9CvX6yIOAUIb+6sf8AXBrwZSxFIXZ
         rLTbE9Zblasxo60ZpxhRNZfFFgTFA7p4Nkg8+9zXGOWUTTsLvoMJoXgZyF67SuVglNZl
         NKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473206; x=1783078006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7jUj/WYhpwqBuo+wix2BnJk6EgwJ/lk0dvKuGJAH7g=;
        b=AgaNhfi+aNjSADB2IrYEhbHDv/z2ERqaHJg4tDH2Rmh0GJauKMHoKPxFIbcll42IPV
         qLBLIhosXJKZmxeSYiEXHda8RZns7JpvFis+qlzb/aWvxJEKr8waKpIeEGC290mU5/1L
         yIxf8wMeOb2p8NGG9fgLX+sEmloqVQ9YTkCeX1iu+bFrcE85nXX1gGr6lZS8jq+UEhNd
         BIEpAYfmKKgdAIdVjNe9MZ1+bKHHQBhsNk0SuwsxAX/hrQvtJoS6T3ptWs1aWFCpNTgq
         tm+uFuqzEbvbUdnx1D9vokcHwbuO61JfiyQOM7XEcuQaRNmbnmVA4krkKwINlm2FjEC3
         UNwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jhyWRAPxmd7JxPxmr7FIzwfRON/o2tFNeG8admQtVPFc4ndp+G1blz8AOIIDXYawNqM7o0qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JqbBcn0Cr+A3fHU5tNP+jXX52q3sgwJTYbx4LLTz9zS+IHzl
	S/En4te9PJ94ZAJYrtjIVlR37wmZUi+v7Dq4+A0aNokQPioQpkxk3Crt2uhHKOS43HpmjAtlpvj
	Vq7W6nGtSNKAtsfkYmiORiWzLQmQ+ryCptXoEUJBKHG1iC0gW3QBeZR34zA==
X-Gm-Gg: AfdE7cncQJurRblFNarc2xAqrUyP37MGZEmaaSil5m9Qv+VKpPBldjhjXqaFHJcHc+S
	SocXx7gWSsPvS5arfuxtO3o0PdNVmDXEuTZYmLuprz7QJXNMfskKRIquGG8D7gD6lqqn1MOdpXn
	YBUf/1X57miKidiT9Ylo4HLM1mRVSW3c9LfuOW2tkOosLmbzy2UdqxuCxwWrQXZm1huwO9q4lSC
	Fo7VhVYCwGMdzU+40hMsfBwwaJdFxkitAX092JRISG5Zw8dbGB/4Eg1ZQXhb2jQwiziHBLf/jXr
	S8JgDuif4j4z+sasU/GAETeYLageBA8qdclZ8/NRlj9q58lvXVo9D6NF/gfp4VKcuc78IS7jTPx
	VivATwD8MEx+WaHRwLXbLBYHOMui8I3Q4GFx2FVpd0cc2+rOaHP9sR+aBnRcr0OUeCzs5uOsDDL
	2zGGmxhZF8P5vO+9vz
X-Received: by 2002:a05:600c:c04b:10b0:492:418b:b5e1 with SMTP id 5b1f17b1804b1-492668b02damr73052485e9.37.1782473205630;
        Fri, 26 Jun 2026 04:26:45 -0700 (PDT)
X-Received: by 2002:a05:600c:c04b:10b0:492:418b:b5e1 with SMTP id 5b1f17b1804b1-492668b02damr73052005e9.37.1782473205153;
        Fri, 26 Jun 2026 04:26:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269071e49sm71464395e9.10.2026.06.26.04.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Ben Gardon <bgardon@google.com>
Subject: [PATCH 5.10.y 04/17] KVM: x86/mmu: Ensure MMU pages are available when allocating roots
Date: Fri, 26 Jun 2026 13:26:21 +0200
Message-ID: <20260626112634.1778506-5-pbonzini@redhat.com>
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

From: Sean Christopherson <seanjc@google.com>

commit 6e6ec58485746eb64487bd49bf5cd90ded3d2cf6 upstream.

Hold the mmu_lock for write for the entire duration of allocating and
initializing an MMU's roots.  This ensures there are MMU pages available
and thus prevents root allocations from failing.  That in turn fixes a
bug where KVM would fail to free valid PAE roots if a one of the later
roots failed to allocate.

Add a comment to make_mmu_pages_available() to call out that the limit
is a soft limit, e.g. KVM will temporarily exceed the threshold if a
page fault allocates multiple shadow pages and there was only one page
"available".

Note, KVM _still_ leaks the PAE roots if the guest PDPTR checks fail.
This will be addressed in a future commit.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210305011101.3597423-7-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c     | 50 +++++++++++++++-----------------------
 arch/x86/kvm/mmu/tdp_mmu.c | 23 ++++--------------
 2 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a506c0818e77..9b1f63b5e86e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2440,6 +2440,15 @@ static int make_mmu_pages_available(struct kvm_vcpu *vcpu)
 
 	kvm_mmu_zap_oldest_mmu_pages(vcpu->kvm, KVM_REFILL_PAGES - avail);
 
+	/*
+	 * Note, this check is intentionally soft, it only guarantees that one
+	 * page is available, while the caller may end up allocating as many as
+	 * four pages, e.g. for PAE roots or for 5-level paging.  Temporarily
+	 * exceeding the (arbitrary by default) limit will not harm the host,
+	 * being too agressive may unnecessarily kill the guest, and getting an
+	 * exact count is far more trouble than it's worth, especially in the
+	 * page fault paths.
+	 */
 	if (!kvm_mmu_available_pages(vcpu->kvm))
 		return -ENOSPC;
 	return 0;
@@ -3219,16 +3228,9 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
 {
 	struct kvm_mmu_page *sp;
 
-	spin_lock(&vcpu->kvm->mmu_lock);
-
-	if (make_mmu_pages_available(vcpu)) {
-		spin_unlock(&vcpu->kvm->mmu_lock);
-		return INVALID_PAGE;
-	}
 	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
 	++sp->root_count;
 
-	spin_unlock(&vcpu->kvm->mmu_lock);
 	return __pa(sp->spt);
 }
 
@@ -3241,16 +3243,9 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 
 	if (vcpu->kvm->arch.tdp_mmu_enabled) {
 		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
-
-		if (!VALID_PAGE(root))
-			return -ENOSPC;
 		mmu->root_hpa = root;
 	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
-		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level,
-				      true);
-
-		if (!VALID_PAGE(root))
-			return -ENOSPC;
+		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level, true);
 		mmu->root_hpa = root;
 	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
@@ -3258,8 +3253,6 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 
 			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
 					      i << 30, PT32_ROOT_LEVEL, true);
-			if (!VALID_PAGE(root))
-				return -ENOSPC;
 			mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
 		mmu->root_hpa = __pa(mmu->pae_root);
@@ -3295,8 +3288,6 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 
 		root = mmu_alloc_root(vcpu, root_gfn, 0,
 				      mmu->shadow_root_level, false);
-		if (!VALID_PAGE(root))
-			return -ENOSPC;
 		mmu->root_hpa = root;
 		goto set_root_pgd;
 	}
@@ -3315,6 +3306,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 
 	for (i = 0; i < 4; ++i) {
 		MMU_WARN_ON(VALID_PAGE(mmu->pae_root[i]));
+
 		if (mmu->root_level == PT32E_ROOT_LEVEL) {
 			pdptr = mmu->get_pdptr(vcpu, i);
 			if (!(pdptr & PT_PRESENT_MASK)) {
@@ -3328,8 +3320,6 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 
 		root = mmu_alloc_root(vcpu, root_gfn, i << 30,
 				      PT32_ROOT_LEVEL, false);
-		if (!VALID_PAGE(root))
-			return -ENOSPC;
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
@@ -3393,14 +3383,6 @@ static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int mmu_alloc_roots(struct kvm_vcpu *vcpu)
-{
-	if (vcpu->arch.mmu->direct_map)
-		return mmu_alloc_direct_roots(vcpu);
-	else
-		return mmu_alloc_shadow_roots(vcpu);
-}
-
 void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 {
 	int i;
@@ -4872,7 +4854,15 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 	r = mmu_alloc_special_roots(vcpu);
 	if (r)
 		goto out;
-	r = mmu_alloc_roots(vcpu);
+	spin_lock(&vcpu->kvm->mmu_lock);
+	if (make_mmu_pages_available(vcpu))
+		r = -ENOSPC;
+	else if (vcpu->arch.mmu->direct_map)
+		r = mmu_alloc_direct_roots(vcpu);
+	else
+		r = mmu_alloc_shadow_roots(vcpu);
+	spin_unlock(&vcpu->kvm->mmu_lock);
+
 	kvm_mmu_sync_roots(vcpu);
 	if (r)
 		goto out;
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 073514bbb5f7..5cba2e85ce04 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -152,22 +152,21 @@ static struct kvm_mmu_page *alloc_tdp_mmu_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 	return sp;
 }
 
-static struct kvm_mmu_page *get_tdp_mmu_vcpu_root(struct kvm_vcpu *vcpu)
+hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 {
 	union kvm_mmu_page_role role;
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_page *root;
 
-	role = page_role_for_level(vcpu, vcpu->arch.mmu->shadow_root_level);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	spin_lock(&kvm->mmu_lock);
+	role = page_role_for_level(vcpu, vcpu->arch.mmu->shadow_root_level);
 
 	/* Check for an existing root before allocating a new one. */
 	for_each_tdp_mmu_root(kvm, root) {
 		if (root->role.word == role.word) {
 			kvm_mmu_get_root(kvm, root);
-			spin_unlock(&kvm->mmu_lock);
-			return root;
+			goto out;
 		}
 	}
 
@@ -176,19 +175,7 @@ static struct kvm_mmu_page *get_tdp_mmu_vcpu_root(struct kvm_vcpu *vcpu)
 
 	list_add(&root->link, &kvm->arch.tdp_mmu_roots);
 
-	spin_unlock(&kvm->mmu_lock);
-
-	return root;
-}
-
-hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
-{
-	struct kvm_mmu_page *root;
-
-	root = get_tdp_mmu_vcpu_root(vcpu);
-	if (!root)
-		return INVALID_PAGE;
-
+out:
 	return __pa(root->spt);
 }
 
-- 
2.54.0

