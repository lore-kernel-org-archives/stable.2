Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A233F58E6
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473210; cv=none; b=djP9VzXqmLBX9wBNjJikB2ToVfWs/gnVNfGt95hT7h61V74+YcgStfdQOxtqYbnmbfEc+PJfAsas1DebxzRfFgBoPtM+Y6c3ZR/pqDutwXN1p2bDdn3MMO4HzcE2Zv76gfzjK1FDj6szf24QSUwQ1xd+RqSMKLjgQEewH52oa3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473210; c=relaxed/simple;
	bh=U9xiOlPCxsFxaHbarkNuBhgU8OAUHm2+VUszRCkRVlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffczAyYy+Jn0VqfTvk+wnaUyr2M2z86gqg2NL225r49Lod3wL2UPxm9VUpri6jwK2UibStgGJyr+lO83XIMXVxhXOAL7EXSa4VTdFyVlvIoCzM8zTAJTsXlEvTcTP876XTyScI9DTjjpsV+cSD3sxyZtS7XvIIZRdUoSVy8mrRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCx1ODmw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uJD8J1kD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCx1ODmw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uJD8J1kD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bupm+7QjQV9vS8enNO4YwYZYh4Q3etkrvUknwmj0KyM=;
	b=UCx1ODmwoPRyf6L+ue0MTOnsm8/7dLOianaP0i2r8oMsojDsZ2hnyKmxIWpeHxu2HupUsZ
	dhKqoYPVU14GVjxHVozqgSW1JaKTOituGxDy3rqM2w6bXEEDSgPh8PKJaAidr4N8q0HIzT
	qmt8+h2RXnjgarQ0f8/FDGkxybZ00GU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Z2kdJs5OOcqp4ihaXQ5vlw-1; Fri, 26 Jun 2026 07:26:42 -0400
X-MC-Unique: Z2kdJs5OOcqp4ihaXQ5vlw-1
X-Mimecast-MFC-AGG-ID: Z2kdJs5OOcqp4ihaXQ5vlw_1782473201
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49243626f15so7453205e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473201; x=1783078001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bupm+7QjQV9vS8enNO4YwYZYh4Q3etkrvUknwmj0KyM=;
        b=uJD8J1kD8PA7S303ieTceDIOo2RhIVqEARUriqRyCPKKmZyzhnRVLz3Y3WYBPzm8gT
         jHxhkqbSFLtI0XCPFBdVwI707wTKwNiyAU7mn3NCUhAtciMzLO6SDrwYuVxbBr+jXhRk
         5Vrb0GHwNr17xwHlocfBRGY57gbGSAKUFYGY1ZYCQ4IrhtfgUHR8/KoACRn2bk4f9GAr
         5BWTTCKK+Jstd0LAr0IXGUpUlFReWygazIgYMcHgtl6WIOvvSWu+TlMPdV0eD0clwdQM
         c4BW8fWjP+joTgPvolJESJDNcNie56X2fACUi21hLptt9WNg9+ZyCEq3+zghPCDB5r+l
         d7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473201; x=1783078001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bupm+7QjQV9vS8enNO4YwYZYh4Q3etkrvUknwmj0KyM=;
        b=A3LSqXZZnEmA9IPgygnkyhH9KM4SXeTSJ9i94WTsTgTjqSK/8etefHVTo++W764WmS
         ZM2QYa6RnsJsxlWw/n96DhLyfisbOS3gse869vdiweHU7+Td1aq6PQnxUaxMfgTdz6QD
         IYkrnZMBfIhhrZqXXys+5+VvUwztyLEO2tvxU0bF39ThcqYRqnoJfY79LjsjnvmdPuPx
         jLV2WupY5qJp2uTRCCLLPNddQALtFK666Dq/PJE3Sf6GeodWT4bezbambjV/IXePbm/G
         XimS2cEb+pqBouM4BD3wJOiPJIXMnmRUsI1J39RNuACsabJOnKLQWjpkRCjk4CK0xfah
         H62w==
X-Forwarded-Encrypted: i=1; AFNElJ+eZaO6+Sz3cHEAZMSDr5hXQGk265hP1gmpstcbKonn6RBH75QBpvmd2a6dVCj9DC5SK8ZtVTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgcR8QzWFK8Z/S0GJPQXjAELbMJTc/v7SKG1eEdObBxgvB2AYD
	YQ09Mt4XkO4MP6CCGkWB/9ny3z+f5IftlHfQSo9t6dk+X7S5UamfoCY0eDelSbqn9uoT75otH6Z
	MWo7lbjTkMWdzM9YL9u2mUAMtceLU1UoAl5UkKniQ911E8vAHwG8ayS4G8w==
X-Gm-Gg: AfdE7ckRTHXIGQqnFKOfLWvWAJs6URNTXc7juOf1GumtRZ2qvsY5GhxT0xqyjuUxkO/
	lbkxGnVjR+19AiUJ+7UTVnvcGVkfKwzHrQ/H8i0IloKgl7xBewsKylSGuFXp1YWuQwoaRMhoEJC
	IdwVil5vMrYUUIkKj0guV8fpubtZ9OtzgNeq600PQKqs8H6FJ6nrPMM//A+3Dop4BzBWhGiFjOx
	jJTV8/CPPvsX6D26h1DdVZdYMa482CyNuuj2TYwj2FmtNxXnzF0gRipDsnA0MrHmUJaZVD3QFlF
	u00GJukq3NbG/658NJQEHu7al1plv82W0Em+abJ0YpSu5jXDBQfkCNODQVBkSQx4YDYgTq08f31
	n4j1NR5So/dF3djLGYuHpkHjl/K6/+fZOki/t6kWKz/NVMXWT9Of2Vo74B0IWUL9JWQvd5L5Jll
	VRaaHtYEAdi7GAoRsu
X-Received: by 2002:a05:600d:644a:20b0:490:a298:acf7 with SMTP id 5b1f17b1804b1-49266899f6dmr72107705e9.17.1782473200859;
        Fri, 26 Jun 2026 04:26:40 -0700 (PDT)
X-Received: by 2002:a05:600d:644a:20b0:490:a298:acf7 with SMTP id 5b1f17b1804b1-49266899f6dmr72107295e9.17.1782473200328;
        Fri, 26 Jun 2026 04:26:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492691f60bcsm74298495e9.1.2026.06.26.04.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10.y 02/17] KVM: x86/mmu: Allocate the lm_root before allocating PAE roots
Date: Fri, 26 Jun 2026 13:26:19 +0200
Message-ID: <20260626112634.1778506-3-pbonzini@redhat.com>
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

commit ba0a194ffbfb4168a277fb2116e8362013e2078f upstream.

Allocate lm_root before the PAE roots so that the PAE roots aren't
leaked if the memory allocation for the lm_root happens to fail.

Note, KVM can still leak PAE roots if mmu_check_root() fails on a guest's
PDPTR, or if mmu_alloc_root() fails due to MMU pages not being available.
Those issues will be fixed in future commits.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210305011101.3597423-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 64 ++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c2c76419af0c..508acf26e30c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3307,21 +3307,38 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * the shadow page table may be a PAE or a long mode page table.
 	 */
 	pm_mask = PT_PRESENT_MASK;
-	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
+	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL)
 		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
 
-		/*
-		 * Allocate the page for the PDPTEs when shadowing 32-bit NPT
-		 * with 64-bit only when needed.  Unlike 32-bit NPT, it doesn't
-		 * need to be in low mem.  See also lm_root below.
-		 */
-		if (!mmu->pae_root) {
-			WARN_ON_ONCE(!tdp_enabled);
+	/*
+	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
+	 * tables are allocated and initialized at root creation as there is no
+	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
+	 * on demand, as running a 32-bit L1 VMM is very rare.  Unlike 32-bit
+	 * NPT, the PDP table doesn't need to be in low mem.  Preallocate the
+	 * pages so that the PAE roots aren't leaked on failure.
+	 */
+	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL &&
+	    (!mmu->pae_root || !mmu->lm_root)) {
+		u64 *lm_root, *pae_root;
 
-			mmu->pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-			if (!mmu->pae_root)
-				return -ENOMEM;
+		if (WARN_ON_ONCE(!tdp_enabled || mmu->pae_root || mmu->lm_root))
+			return -EIO;
+
+		pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+		if (!pae_root)
+			return -ENOMEM;
+
+		lm_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+		if (!lm_root) {
+			free_page((unsigned long)pae_root);
+			return -ENOMEM;
 		}
+
+		mmu->pae_root = pae_root;
+		mmu->lm_root = lm_root;
+
+		lm_root[0] = __pa(mmu->pae_root) | pm_mask;
 	}
 
 	for (i = 0; i < 4; ++i) {
@@ -3343,30 +3360,11 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 			return -ENOSPC;
 		mmu->pae_root[i] = root | pm_mask;
 	}
-	mmu->root_hpa = __pa(mmu->pae_root);
-
-	/*
-	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
-	 * tables are allocated and initialized at MMU creation as there is no
-	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
-	 * on demand, as running a 32-bit L1 VMM is very rare.  The PDP is
-	 * handled above (to share logic with PAE), deal with the PML4 here.
-	 */
-	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
-		if (mmu->lm_root == NULL) {
-			u64 *lm_root;
-
-			lm_root = (void*)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-			if (!lm_root)
-				return -ENOMEM;
-
-			lm_root[0] = __pa(mmu->pae_root) | pm_mask;
-
-			mmu->lm_root = lm_root;
-		}
 
+	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL)
 		mmu->root_hpa = __pa(mmu->lm_root);
-	}
+	else
+		mmu->root_hpa = __pa(mmu->pae_root);
 
 set_root_pgd:
 	mmu->root_pgd = root_pgd;
-- 
2.54.0

