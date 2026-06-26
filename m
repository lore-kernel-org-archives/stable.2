Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018C3F54DF
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473212; cv=none; b=ZFpRTZpwPAY/6GYIVU8iMLAjLnPRe1pmf06L6uCNVCcdzJorT3ydjlVsHjFG6bnvuLdh2bjCq2wI1vr9Bhq090zqhznEuXOzsrXO0za2Ccb0xlfXBHQWnHk7p2SpM/MhHMPF/a/5pw4O8U8GD437nPiXj3eHAYOO0jelnNg1pMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473212; c=relaxed/simple;
	bh=fVYzX+DFEMOOtjXuljJSpcQQr6EITNpG4e35Ay/tXgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3k0odC1180YkocldIJc1r4+49AlSfMTPck8KLzYOWSiJaPDeZjeAlVpSMlePix6gcnxYsmN2y+e1Sd49j/Cx+n78GgoyMCTd8+fFvqa6XJS2g4F0NUxyOC1dga7lSsBJl/VE3c/gCljdVWqe/KDT5cnyQDf72ydYg/6Sw6XWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4rbIwDz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pqOEQkU3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4rbIwDz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pqOEQkU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLyXhRB0+TjwWO0S+Bba2JPEw5RTj/XtkcPn+Gkl/Gc=;
	b=E4rbIwDzI8PfgnLOdXTglsGV7cBEYXQvMqWepVlZByvlZGF40s63a0n9Ia3Bc/1KTPuVd4
	HUJA4hnKGzvoRKg01WmZ4EYf6yLVPHDmhx6PX+HFuA5fp3+I9VpiI4O+DHLEfTVmxzmigc
	6Su+9vvM4CkJwAc90u5nbNhzmsUW6YU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-dQvAyn1RPdKzQ1aFEnjraw-1; Fri, 26 Jun 2026 07:26:44 -0400
X-MC-Unique: dQvAyn1RPdKzQ1aFEnjraw-1
X-Mimecast-MFC-AGG-ID: dQvAyn1RPdKzQ1aFEnjraw_1782473203
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4924583c7baso10231985e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473203; x=1783078003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLyXhRB0+TjwWO0S+Bba2JPEw5RTj/XtkcPn+Gkl/Gc=;
        b=pqOEQkU35iCo3z39MQM41LNpm4c4Bla7+yFFuoB+x0hzdDDs5VHTEMQbEFxczmwXYO
         zBWdClEqa8MzkMJAdsMuKBcn0Heszf0QsTK+dcTCirPQZpXurTXb2WIkujwYaG6AHiDu
         ds8Da7xb9wtIE69OuDRvZpZedhbNkbgIKvDsNROEwP4nkaBdG9i4zIelX2sDrYoIz58H
         Pyq+J8nrsLowtD7pbXy3EWev0uov9dU9JPBMYg+mbpAlvyTq9USbEnmqg1/eLYd7mrG3
         NjcSsL9jCCad/yhXZAKyLsI2oFTxgmiJGrgURn1QDdC1/hbZgQu6/uBTF/ze/8bmJHyV
         tUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473203; x=1783078003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLyXhRB0+TjwWO0S+Bba2JPEw5RTj/XtkcPn+Gkl/Gc=;
        b=tM87exq6V+k4xF3rjK3d0QAF3Dikm9/KvUSy47vBthcuSPzjgaBwahTDLrMko014m6
         EnUlItxQH+Qo+cyECanqKPT1Tcm+gEOkIoWGqoiBmvhhNGce3HNJFoGNWwKxmsNoAQRq
         gCIK8z0MFoNrmO8Pyi61GE9MSDzfUKwurUyBzqMliIVaQTbsiuEFPNM2/bYHDgy/rsHz
         dChtpJ73SbdzNVixLgOlEPbhS5zRsKabhjchqeIUlqRh9Lw8+cFG8YuZY0FFDWSHshh/
         ocAE56HFkU/VCg2gvlrSA7unlFLELFU6+uHvFteet1Zs2gfktWnpZHK6hvHHyUAtRQEn
         PtPw==
X-Forwarded-Encrypted: i=1; AFNElJ8QlFIYBMitmMDN4coP8SNi1pkMP2IUn8Q0/9QKMMAPFs2Te633+dl2IPaj0VcE8CVOU6TkLVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqhbspa5FMUrEBMg/auZSKDAOK0KPziV8BRb8uouqGzYsrGBbT
	/re7zGVH7kyz/lO77Kaa15pLjrmIW7riJwo0imEpVkom+5XhwmNbawSQWeAawDgz5veWt2hDs9C
	nOQcrXaoFYH/UFToDaxD0PRrILqakh+Vu9KIHgGbKZldMfXhPf8muxpZIzQ==
X-Gm-Gg: AfdE7cm2QY6KcQ/8yxZJ04E9selaxMvZ58aktEBKQ6DWqoxwVobg8jLLNBJA70pkpTs
	wr98YhkgKDRgnMlJxoIx/0zCtF2b2c7VysZ1loU0sHkncPxl0zL9UdaVvVOg0M04R85TSnvAkX0
	RfClAlZQ7U6pYQmjHXSx5dYedpoXuX97teGTjb73R0z7W81hU2zm1pBMiGxPBgOWXQfHiowWJzT
	0/6fSj8F6akvv5WfSjMoZ1Fe9oic9P1sF+YaBpZykqeTJ7quu2jSLxIBX109XkGSG09Kx7nLCuK
	YMGTm70/hIccZuxSphIOEJnCztMvUbwWFP3bRfGD+B4RsP1qJlvOamIb3kvHSvUkk/nBYanlATr
	0362doVVrPB2MMulkTlm6qohowKTm+ZGoicWcu/6TrxTegf3DfBgPfymDUYuFaf7ow8udXUrHy+
	MHkpNfaGOmPKi8alG2
X-Received: by 2002:a05:600c:68ca:b0:492:67df:3dfa with SMTP id 5b1f17b1804b1-49267df3e34mr59369915e9.34.1782473202950;
        Fri, 26 Jun 2026 04:26:42 -0700 (PDT)
X-Received: by 2002:a05:600c:68ca:b0:492:67df:3dfa with SMTP id 5b1f17b1804b1-49267df3e34mr59369545e9.34.1782473202445;
        Fri, 26 Jun 2026 04:26:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e3d6ba143sm11199784f8f.33.2026.06.26.04.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10.y 03/17] KVM: x86/mmu: Allocate pae_root and lm_root pages in dedicated helper
Date: Fri, 26 Jun 2026 13:26:20 +0200
Message-ID: <20260626112634.1778506-4-pbonzini@redhat.com>
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

commit 748e52b9b7368017d3fccb486914804ed4577b42 upstream.

Move the on-demand allocation of the pae_root and lm_root pages, used by
nested NPT for 32-bit L1s, into a separate helper.  This will allow a
future patch to hold mmu_lock while allocating the non-special roots so
that make_mmu_pages_available() can be checked once at the start of root
allocation, and thus avoid having to deal with failure in the middle of
root allocation.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210305011101.3597423-6-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 84 +++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 508acf26e30c..a506c0818e77 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3307,38 +3307,10 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * the shadow page table may be a PAE or a long mode page table.
 	 */
 	pm_mask = PT_PRESENT_MASK;
-	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL)
+	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
 		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
 
-	/*
-	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
-	 * tables are allocated and initialized at root creation as there is no
-	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
-	 * on demand, as running a 32-bit L1 VMM is very rare.  Unlike 32-bit
-	 * NPT, the PDP table doesn't need to be in low mem.  Preallocate the
-	 * pages so that the PAE roots aren't leaked on failure.
-	 */
-	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL &&
-	    (!mmu->pae_root || !mmu->lm_root)) {
-		u64 *lm_root, *pae_root;
-
-		if (WARN_ON_ONCE(!tdp_enabled || mmu->pae_root || mmu->lm_root))
-			return -EIO;
-
-		pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-		if (!pae_root)
-			return -ENOMEM;
-
-		lm_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-		if (!lm_root) {
-			free_page((unsigned long)pae_root);
-			return -ENOMEM;
-		}
-
-		mmu->pae_root = pae_root;
-		mmu->lm_root = lm_root;
-
-		lm_root[0] = __pa(mmu->pae_root) | pm_mask;
+		mmu->lm_root[0] = __pa(mmu->pae_root) | pm_mask;
 	}
 
 	for (i = 0; i < 4; ++i) {
@@ -3372,6 +3344,55 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	u64 *lm_root, *pae_root;
+
+	/*
+	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
+	 * tables are allocated and initialized at root creation as there is no
+	 * equivalent level in the guest's NPT to shadow.  Allocate the tables
+	 * on demand, as running a 32-bit L1 VMM on 64-bit KVM is very rare.
+	 */
+	if (mmu->direct_map || mmu->root_level >= PT64_ROOT_4LEVEL ||
+	    mmu->shadow_root_level < PT64_ROOT_4LEVEL)
+		return 0;
+
+	/*
+	 * This mess only works with 4-level paging and needs to be updated to
+	 * work with 5-level paging.
+	 */
+	if (WARN_ON_ONCE(mmu->shadow_root_level != PT64_ROOT_4LEVEL))
+		return -EIO;
+
+	if (mmu->pae_root && mmu->lm_root)
+		return 0;
+
+	/*
+	 * The special roots should always be allocated in concert.  Yell and
+	 * bail if KVM ends up in a state where only one of the roots is valid.
+	 */
+	if (WARN_ON_ONCE(!tdp_enabled || mmu->pae_root || mmu->lm_root))
+		return -EIO;
+
+	/* Unlike 32-bit NPT, the PDP table doesn't need to be in low mem. */
+	pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (!pae_root)
+		return -ENOMEM;
+
+	lm_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (!lm_root) {
+		free_page((unsigned long)pae_root);
+		return -ENOMEM;
+	}
+
+	mmu->pae_root = pae_root;
+	mmu->lm_root = lm_root;
+
+	return 0;
+}
+
 static int mmu_alloc_roots(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.mmu->direct_map)
@@ -4846,6 +4867,9 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 	int r;
 
 	r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->direct_map);
+	if (r)
+		goto out;
+	r = mmu_alloc_special_roots(vcpu);
 	if (r)
 		goto out;
 	r = mmu_alloc_roots(vcpu);
-- 
2.54.0

