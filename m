Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D22F7EED
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496006; cv=none; b=nR95/8uMg+btVvHkEF5qI7yK/JuDXPfpwQle8fvmyddDsSzVj6KryxzEqZYHKO8zpuMwIsW1rKn2zKB3m9k4iIhVpkSPzUGo5KNMNqI1FWbfs/juDUBoOfU7/9MTB/Jqe74uUGV+bzJTLmZ3UqjzzDP2TKfsS8pUeuVQca40TzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496006; c=relaxed/simple;
	bh=pr9hHRFoDK6zdHpI5/umjPgHQzWee7O0TXNLYn6a/sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8hNQf8026fiwMq1LZ/1v96czKclzkCW1kRjUkvy9aN80wEJEj84qdK2FlHIuDX7hj+OTcPs8HFkvuqd4HItubhDGHzc0N9LKLBXkFpuNljdQBJUQBeJr4bOPv3dVAmXG1hM7+usR2BgNy+bvo8mCICSUDRYCqznqvjafVBDdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6lxcskm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lhbNkRAv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6lxcskm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lhbNkRAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782496001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HW1A4dPfWYNXrJ3gwDxBImVPF8usp091lzW4s8alceY=;
	b=A6lxcskmEeL5UYL8riIDuHHP6YRrFU05dVDHAJ/1xcKjy2wWxfmaEcFs4FRzMK3KR3hVfr
	oE+6XvCIX/yDeJ+LBvPIbrBFkbgYevdk9OtkY2Cr4RorzkjwWf+UNd2iJzG67AUkJOE09L
	i8kbaTs3QObM0B/DA35A+vlbBHss5VY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-un57d-UpNByUTYLOFxdF3A-1; Fri, 26 Jun 2026 13:46:40 -0400
X-MC-Unique: un57d-UpNByUTYLOFxdF3A-1
X-Mimecast-MFC-AGG-ID: un57d-UpNByUTYLOFxdF3A_1782495999
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b0682d2fso9418995e9.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782495999; x=1783100799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HW1A4dPfWYNXrJ3gwDxBImVPF8usp091lzW4s8alceY=;
        b=lhbNkRAvZ0NgvNjJNu7LajcGuu17MQUxVoVHKaUb7JHgNTTb0uFS5SN7dejc1Sa7Lm
         V+LBr07h3cCVtt7cwOBHHanNaYkK7XPIRDTR3EtN1MHlTDAS+prIc8DWdMYzM1Zt2ZxX
         Bt3+zH02cvuoFYxqjY9K0giT0nZR/gbnomiV3ijFy/tb+dWq8+kas2kZkis/PS3QPr64
         NMpcXxPAdECn/AULjqIC7urs8/qfGal0TlxHg6Bu5/jrf2Q24I52dru7YWDwGFQyQI1A
         DcquNgo6dsHLh7pcZ2JFWnK3yZaAoFLOCW+mhn3YlfbWgqr4Ino+JYa2cRQzbTfwUWUx
         nCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495999; x=1783100799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HW1A4dPfWYNXrJ3gwDxBImVPF8usp091lzW4s8alceY=;
        b=pN+qb564VHVwbwSeqsxCUnH85wOMoELvryOx+M9hT+3rHDUofttcheNyCoE4wXIkv3
         05MS82jprrVmS26akkZTOiyt1KTrLicN4G9WAscE+k/1nDHVzKOPMWYz8NifgjuE8Als
         LBzAWRabhViffJwpzIS0QM10U5CwmkIbXjzUeGXgats2Ves+Q4OVgc5D7H9TwkkK+BP8
         hsGKfH10qAhWbXTFiL7h0TDxltPIxwLsoeyw86tBf/rFCHx9bOCvdPFC7BCTz76z40rP
         4H99IGmzBWvriYnc1UDAN4Yi84W0CppECqB7J3Adru6/TnoxnBYhceM3tZTyXYgnKAPE
         br/A==
X-Forwarded-Encrypted: i=1; AFNElJ94rk3HvoHVnEpBUMkfQ/XwlI2q9Xeyqfu46YjDh3xu+LzEoLLaigg/YBJF44zmutuaDDGw5j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaLFo5kDZ4mwDkCay2SbG9uLQkb1rikxMzVPTG7AZ26v719c4L
	B2y8pPN7DEyPsCUeUcu8w9aRRxnQSWVtLOpQXQICcEAoYTTcVopPyMnmcGrabwq6CoYcNFR24Yk
	FcJLtv5MenUVkVWyOcM+VbUuQdlvvrLSxfXgHQUrhWcX/Ws3TDP/s1XqUt28rXvMSQg==
X-Gm-Gg: AfdE7cldQgC3ft0ZwmoQnjBP4K7PXG80Bl43CXVsYxlTdFBTAScRuJmxWVauF9RlaRe
	IVMmcQad6F0vIvC6p34DzcKhJtlL8gq9QKUTT49j1zM+1sqr3Ua7uSsby/vijJx09Mw97oaxbkF
	vKg0rVU6vfqzDH6z1hLre4U4ZliwITB+93GIctJLctDduUzmhhHJeJmb1rrcPbfNG6Nw5d0BAGO
	egia7Pi0QDzoMf865XRZktKkCfIlqzWaJm1EBQdnAFhDX4D3K02vg/lI3V0+Q/JhWJvZqBPJoQ+
	drIDt1EeBJ1k6h/LzjUES2eShQnT45H6j7irbp459VPzH+ZjLsvAk8XmAs8Qy6fUorWbPZAUkpu
	hbVsnKHBvJXQkLKlhn64+lbd8Qgbnn3z477LO5qglpF4DJ3ZzkpdiYNyhnQy7JS9mshQ+v6cTgm
	NhR5yEv45AP9U/1Ekh
X-Received: by 2002:a05:600c:3b19:b0:490:3c15:7146 with SMTP id 5b1f17b1804b1-4926687e6eamr125279755e9.19.1782495998813;
        Fri, 26 Jun 2026 10:46:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3b19:b0:490:3c15:7146 with SMTP id 5b1f17b1804b1-4926687e6eamr125279385e9.19.1782495998429;
        Fri, 26 Jun 2026 10:46:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e3d6ba143sm13847784f8f.33.2026.06.26.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH 5.15.y v2 6/8] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Fri, 26 Jun 2026 19:46:17 +0200
Message-ID: <20260626174620.1819772-7-pbonzini@redhat.com>
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

From: Sean Christopherson <seanjc@google.com>

commit 0cb2af2ea66ad8ff195c156ea690f11216285bdf upstream.

The shadow MMU computes GFNs for direct shadow pages using sp->gfn plus
the SPTE index. This assumption breaks for shadow paging if the guest
page tables are modified between VM entries (similar to commit
aad885e77496, "KVM: x86/mmu: Drop/zap existing present SPTE even
when creating an MMIO SPTE", 2026-03-27).  The flow is as follows:

- a PDE is installed for a 2MB mapping, and a page in that area is
  accessed.  KVM creates a kvm_mmu_page consisting of 512 4KB pages;
  the kvm_mmu_page is marked by FNAME(fetch) as direct-mapped because
  the guest's mapping is a huge page (and thus contiguous).

- the PDE mapping is changed from outside the guest.

- the guest accesses another page in the same 2MB area.  KVM installs
  a new leaf SPTE and rmap entry; the SPTE uses the "correct" GFN
  (i.e. based on the new mapping, as changed in the previous step) but
  that GFN is outside of the [sp->gfn, sp->gfn + 511] range; therefore
  the rmap entry cannot be found and removed when the kvm_mmu_page
  is zapped.

- the memslot that covers the first 2MB mapping is deleted, and the
  kvm_mmu_page for the now-invalid GPA is zapped.  However, rmap_remove()
  only looks at the [sp->gfn, sp->gfn + 511] range established in step 1,
  and fails to find the rmap entry that was recorded by step 3.

- any operation that causes an rmap walk for the same page accessed
  by step 3 then walks a stale rmap and dereferences a freed kvm_mmu_page.
  This includes dirty logging or MMU notifier invalidations (e.g., from
  MADV_DONTNEED).

The underlying issue is that KVM's walking of shadow PTEs assumes that
if a SPTE is present when KVM wants to install a non-leaf SPTE, then the
existing kvm_mmu_page must be for the correct gfn.  Because the only way
for the gfn to be wrong is if KVM messed up and failed to zap a SPTE...
which shouldn't happen, but *actually* only happens in response to a
guest write.

That bug dates back literally forever, as even the first version of KVM
assumes that the GFN matches and walks into the "wrong" shadow page.
However, that was only an imprecision until 2032a93d66fa ("KVM: MMU:
Don't allocate gfns page for direct mmu pages") came along.

Fix it by checking for a target gfn mismatch and zapping the existing
SPTE.  That way the old SP and rmap entries are gone, KVM installs
the rmap in the right location, and everyone is happy.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Fixes: 6aa8b732ca01 ("kvm: userspace interface")
Reported-by: Alexander Bulekov <bkov@amazon.com>
Reported-by: Fred Griffoul <fgriffo@amazon.co.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20260503201029.106481-1-pbonzini@redhat.com/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c  | 33 ++++++++++++++-------------------
 arch/x86/kvm/mmu/spte.h |  5 +++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d58be2e698f7..6c9656b8062e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -188,6 +188,8 @@ static struct percpu_counter kvm_total_used_mmu_pages;
 static void mmu_spte_set(u64 *sptep, u64 spte);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
 
 struct kvm_mmu_role_regs {
 	const unsigned long cr0;
@@ -1179,18 +1181,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
 		rmap_remove(kvm, sptep);
 }
 
-static void drop_large_spte(struct kvm *kvm, u64 *sptep)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = sptep_to_sp(sptep);
-	WARN_ON(sp->role.level == PG_LEVEL_4K);
-
-	drop_spte(kvm, sptep);
-	kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
-			KVM_PAGES_PER_HPAGE(sp->role.level));
-}
-
 /*
  * Write-protect on the specified @sptep, @pt_protect indicates whether
  * spte write-protection is caused by protecting shadow page table.
@@ -2187,7 +2177,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
@@ -2265,12 +2256,16 @@ static void __link_shadow_page(struct kvm_vcpu *vcpu,
 
 	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
 
-	/*
-	 * If an SPTE is present already, it must be a leaf and therefore
-	 * a large one.  Drop it and flush the TLB before installing sp.
-	 */
-	if (is_shadow_present_pte(*sptep))
-		drop_large_spte(vcpu->kvm, sptep);
+	if (is_shadow_present_pte(*sptep)) {
+		struct kvm_mmu_page *parent_sp;
+		LIST_HEAD(invalid_list);
+
+		parent_sp = sptep_to_sp(sptep);
+		WARN_ON_ONCE(parent_sp->role.level == PG_LEVEL_4K);
+
+		mmu_page_zap_pte(vcpu->kvm, parent_sp, sptep, &invalid_list);
+		kvm_mmu_remote_flush_or_zap(vcpu->kvm, &invalid_list, true);
+	}
 
 	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 31d6456d8ac3..31d03d15415c 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -267,6 +267,11 @@ static inline bool is_executable_pte(u64 spte)
 	return (spte & (shadow_x_mask | shadow_nx_mask)) == shadow_x_mask;
 }
 
+static inline struct kvm_mmu_page *spte_to_child_sp(u64 spte)
+{
+	return to_shadow_page(spte & PT64_BASE_ADDR_MASK);
+}
+
 static inline kvm_pfn_t spte_to_pfn(u64 pte)
 {
 	return (pte & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
-- 
2.54.0

