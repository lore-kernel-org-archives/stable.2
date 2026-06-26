Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B18F3F44E2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473189; cv=none; b=GHcyli+YGiaBn+9/Cnc11+QAeIWs3jwnguOzV0TsT22nmE+PHHVPc/54gnWSGpsZaOBZ3v+wYDXTLR7wjYMOsOuHRFIH5SoWcYJ6SqoSlibnGh6XLNnjxzZIGwidWCoaTETV/ujG8oWi/g1XnncsE3wg7v4Rtc1+0WPVA6jkD0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473189; c=relaxed/simple;
	bh=pr9hHRFoDK6zdHpI5/umjPgHQzWee7O0TXNLYn6a/sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1x4AhQbUIUn5H363E+AJ+pJ8HN5f4BaIQ1JKMyyi25rdHZ+nNMj9z4jVnkrIfL3fVY+48RcTHHXwqHryLtfJAD2aSFR1UIRxhewdk32y7c4TDCnU83TDwMiHc/t/Y9nIETz3NkX0LjUoyP0iXm76krRyeB0RbReiYFiZ5biB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNxQjz3q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ao+pPhq0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNxQjz3q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ao+pPhq0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HW1A4dPfWYNXrJ3gwDxBImVPF8usp091lzW4s8alceY=;
	b=BNxQjz3qtyMwlSF6ajBavzxeaT/2ZippjDQRN90L3nkD/TQe9S73mzT3UHjMgv9MPcR+p0
	Gf4Cxye7Q6hl2rm709yxnIfrUWc7LCBcUyswKhmuRkIaVp6Z8wu0/6ckCorgW6CET4RiNy
	aEjh7z5iDuo8GzG9vLqm7YdNJLjo4hk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-m3LfPROSPI6aa5ALSk-ebQ-1; Fri, 26 Jun 2026 07:26:25 -0400
X-MC-Unique: m3LfPROSPI6aa5ALSk-ebQ-1
X-Mimecast-MFC-AGG-ID: m3LfPROSPI6aa5ALSk-ebQ_1782473184
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49246459bc4so6128885e9.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473184; x=1783077984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HW1A4dPfWYNXrJ3gwDxBImVPF8usp091lzW4s8alceY=;
        b=Ao+pPhq0Dllh7N+UAP0yZlLIZ71j0OU75amFY2iq7cVq/LwavoXVFxzgNvnPD+QgbH
         vMTnHns14hHV6k3P+9kkYjggo7X2dRRweUYiuF+PhZdjjRsVzjhCPaK6l/tfuK+S2gPj
         sPVgWNMFsNZX5z/w07Wq0qJULKEZh2T96WjM5JOlCRt042hcJvqzZH66+htO7XCXL0b8
         VUdmT+ghKGTRgek498N026JwqGQNEIlHav+Pc0TxbC8XJYbtPKI1Ha2xNEot8Kzj+5dB
         B4UOq9UgUUjoKqAYsirI60zotUH9VrFfqjkhmztXlS68cbD1OEBpS4PQGuysFLNXwqVb
         iYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473184; x=1783077984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HW1A4dPfWYNXrJ3gwDxBImVPF8usp091lzW4s8alceY=;
        b=iUA5brBpeINP+6/SXfJ4KquSvgySI/H0sKakotcTIqUENWFxgs4/r+CUJjuw/ZfZML
         tSSmQXPnQipc6BZj1vPdDq7S4E7n8F75+LK+DFsAm4GN8ako/WXrZFtKAezY/9p3yAHx
         Jwgy4JHzp42mbZcSkA3Huz+cKaxtUUxkFti5RqQMC4IHnanYJdHkYGf+j4V6jA/NzYRX
         UXt9aryU7G+cmInxSCzSo7bbyWmJugtFXNARcJ02dtC25HlNrhnoXnSQ6ptFbyWTRaBz
         VBRV0SKn9V65rYa8En9p93JtbmN5D9Z6VEFDqpehj63K/uIxi91P2QtuKZSF2Kn0X8TC
         9Fsw==
X-Forwarded-Encrypted: i=1; AFNElJ/ppmiMYfu+Slincq90aYNLWpKSUETVrnG66iZeK65ANdo4ROSV76R0E2m2yRHyJHqCHRnjqdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbZMXO+kw2FfAGI+He8vYqAguRsF0m0lCzKjdCehDZJd4WtoDa
	38KdlwXJtxZCIfrBbo0We/0uGS6/qKmFjY8aoAWWTGWrpLQPlZ9kDtMjTLvU+ZCySyhXRfD+oEI
	o4P4cieGJxVWOAhsgfrNAvabib59MGL53IbYBiXtBqlBNkkug7zwONLyt+KygDR6NNQ==
X-Gm-Gg: AfdE7ckIKRgXmkQ22bpYAQgEnStNBKDEEvBwDYQJ3qUiU3Ev8LBJQTnFaASJi6bp1b8
	83Cv7fm+QDmMBwiUVpxr8hLunYwEKgHjYZvKN8GCESFDJ/Hl1eB/eMWPy2WklPFuT/LCP2snJmT
	1OdEXnx1hGvP8/K+9x/xhW9dtNpYpKH7z5de4COKZ5kuf8iPKejDopXdzoo8lO2PGyfjIu4cWDJ
	k5hiaP7edr+8EKSEQZQB2Pl7jV2JfbX2CfUmBr+EBqMX9hsM5jA6oDl0OFLnLPOuwxY2jhX9ucu
	L0PQB161YdoSkU9SeQwmM77Fm1Dg1TjBb8CI2AVYoC1u0cZVwFCajyyuIONzVt0Xr68FhZmWha1
	M+mnIskg5tjO+CcXr2QvEx1hcAqLFGspALaPj7Bu/2M11xYKJcOSNFCqrbvI9Fp9xFo4odjhFpV
	KJOvKj5FlRNiQb72/k
X-Received: by 2002:a05:600c:a410:b0:490:be78:1861 with SMTP id 5b1f17b1804b1-49266862966mr89449975e9.4.1782473184347;
        Fri, 26 Jun 2026 04:26:24 -0700 (PDT)
X-Received: by 2002:a05:600c:a410:b0:490:be78:1861 with SMTP id 5b1f17b1804b1-49266862966mr89449445e9.4.1782473183955;
        Fri, 26 Jun 2026 04:26:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268ffe204sm73499415e9.7.2026.06.26.04.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH 5.15.y 6/8] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Fri, 26 Jun 2026 13:26:04 +0200
Message-ID: <20260626112606.1778248-7-pbonzini@redhat.com>
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

