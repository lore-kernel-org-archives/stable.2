Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1300A3F9288
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473244; cv=none; b=RCI3EhsCBKXvU+GDNSnWJiZNVsBCzfiWdfUDZtU8RTS7rbNrNlfouS8rCoZCcKlkC6IBAKJ7Pfb5RSOQmJnmt/IYYodiCHlwlx3Ij5/Vwzc3TgRV+qmvRfyBe4525Y80qQqFlXdV70Yl8/lFJyS5RJYT//ilbufhT58cuzSncfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473244; c=relaxed/simple;
	bh=zrZRur3PlxVd4scQAFPMiU5+1bb51w14SebEHkON5Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMCQtFcZel0Pwr2Ej4nPTdg8XOIpVv6DgveV9dxArbPOpOxbtag0K5Q/GMGhOb390B9qIy1ve0kL44cgXjSKU4SQfIB3OwOTAL9nb1mUe5mOACt0mC6b5SlfdVhertkzAHcYGaLLXb9MNmOKAtmSFh0K1xWyx/rkF9gAIMtMsps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCVrd60J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/S8oduZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCVrd60J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/S8oduZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owW0Mm1rq1iudIe3Fa3UoAHb7LLdv4HPLcf4Kd+DmKU=;
	b=CCVrd60JBbkz2z1wmVRbsX0uKSvLqEkPE+8BHfLkvzF/h/Rnk2IIRy6W4vjqe97NjJFI2A
	hOHYaZ305pDMZwT07/eHbZon/6CuK2m5pkjbG+W8PZx/AkyWVAl3kb7FYmbvfkC4ZSaPvo
	he1Bm6+MuNQYEiqNFcoTAT+FrqUR3tg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-1l62rjr5MuWlHqWGkjGTvA-1; Fri, 26 Jun 2026 07:27:18 -0400
X-MC-Unique: 1l62rjr5MuWlHqWGkjGTvA-1
X-Mimecast-MFC-AGG-ID: 1l62rjr5MuWlHqWGkjGTvA_1782473238
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46db5d470bfso587534f8f.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473237; x=1783078037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owW0Mm1rq1iudIe3Fa3UoAHb7LLdv4HPLcf4Kd+DmKU=;
        b=R/S8oduZK0+6yxrSh8+DlZ8BeBJd0PPU/+2C9v/DUj5U8T1JVeePS1VLNolYjV0sSJ
         u5xkxfWl6CVB/oKeMZ6WSCVTZNGMo7ycflNZ2VUH6DbzTWi3P5vl/UlrOAAhTvenlkc+
         3kM+ROVFX9zVjooml1YEW4A7u/ptYkFhdQ2olJGLYTSjy1WE48lw2rCWSeVhATWuD6TB
         7bVjYtKwrRJ0bDXqdd78juxZ53G6U0Qb1wwjDL4XV5IWQaYPQD5PwIs0QVyoscky6BWS
         NqfplAcscRkbLZ7QTV20M+VA5k2/6Bs9Ne3Hny9SUIZdHRp8ufFGhGJ3lAI7rmJLSOLs
         RTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473237; x=1783078037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=owW0Mm1rq1iudIe3Fa3UoAHb7LLdv4HPLcf4Kd+DmKU=;
        b=sXvLleqWf9qp86XdWO5HUDPWSqrF4pNBdNv9Z5xc3aHJdX3SuAy3SdIixgfq2StQag
         ncrfu3pp3PFjPipH1QVRtoRUegXLz1NQcmG6SA54jneraDfJYUuEwFZXdc1gCfU5WLA0
         Z/N85C2CzedUMduDxcmdkKKlMDl6SJpB0qQik8g6sADyE1PBfq9E6xHlnPHPAulUGDxJ
         bZZY3dY9AYV2FDgYAA59ouzcAkoskLELIr4ZrQbfG4yFEm7mCk8Sfl4EhAB1YLJ0g7VS
         C5BRrsG4QALnQ1QovT9OEsyRsmNEhiS69sPgiOow09S7h1OnbRKVXX5sc3Jf/ADYEwqT
         hE6A==
X-Forwarded-Encrypted: i=1; AHgh+Rogkv97gUgGLv3zJ7ckIldfVzWnO10QiIWa+K1NdNH7JRcVJsWDzHguNgnfxL8b8whdPg72ETE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRAFKWXEgDQhv06PdSfoyPwGPK36kBexDYvuCZpzXkOYxYPZY+
	tp2msHUZdG74R2MiGgDDiqdl/9PQ8q9JzVCwFVTahu6N+EBvVo20JoO3iVmQAm9+unac5e/MpEL
	uXqWgiJebxSGp1JOVOyNNiA4mimaR6gB8Hxl0uqhWL3H5k0z2UjwsUPSZVQ==
X-Gm-Gg: AfdE7clxcR8vHRe3mruffGVV6l5q0pEPhnevZaKuI2HvHZjYbsf8LZgglpt8IjsoYQM
	owfGq0L1wHaw4HaOAIEYRJhn8kjiwmHWRG+DhLkUjk5IGBDowZg/gkKvKOFIXs8eys15Rts1aXC
	+6BhbSjSVZGOipTpmZEZVHRVwyn7N765yDKrl8slby5ER07XvLAIpUpyA4UcG8ipS2/hFED+6SC
	PIddd3+BsOG90b3bB1tsysT776lnFhuTwm1DIDZo7at42/cbMZLaHeYrIb/H6maAabWIS6NZPQs
	AqtwHOY4HioZ8ughCqkRmxZeIwl1/vE+W8UkFi4kLe0l3ykSWl7H+Xmh8eIkKWqV/SEj7VJDwLa
	NJGjJLINGWuSJWJ2veE7jl9O/P5CT5ubbOetXHrZmkwo6jFWUudlg4L//BwSxipFGvFVaHcFYXW
	FcmfzZ2ZfBFwn5quj0
X-Received: by 2002:adf:e009:0:10b0:46d:d6c1:8386 with SMTP id ffacd0b85a97d-46dd6c184a0mr7431125f8f.47.1782473237537;
        Fri, 26 Jun 2026 04:27:17 -0700 (PDT)
X-Received: by 2002:adf:e009:0:10b0:46d:d6c1:8386 with SMTP id ffacd0b85a97d-46dd6c184a0mr7431086f8f.47.1782473237061;
        Fri, 26 Jun 2026 04:27:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee0189esm25095423f8f.9.2026.06.26.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:27:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH 5.10.y 14/17] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Fri, 26 Jun 2026 13:26:31 +0200
Message-ID: <20260626112634.1778506-15-pbonzini@redhat.com>
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
 arch/x86/kvm/mmu/mmu.c  | 34 ++++++++++++++--------------------
 arch/x86/kvm/mmu/spte.h |  5 +++++
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 47c5c3613b68..b669a847e007 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -176,6 +176,8 @@ static struct percpu_counter kvm_total_used_mmu_pages;
 static void mmu_spte_set(u64 *sptep, u64 spte);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
 
 #define CREATE_TRACE_POINTS
 #include "mmutrace.h"
@@ -1067,19 +1069,6 @@ static void drop_spte(struct kvm *kvm, u64 *sptep)
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
-	--kvm->stat.lpages;
-	kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
-			KVM_PAGES_PER_HPAGE(sp->role.level));
-}
-
 /*
  * Write-protect on the specified @sptep, @pt_protect indicates whether
  * spte write-protection is caused by protecting shadow page table.
@@ -2131,7 +2120,8 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
+	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
@@ -2209,12 +2199,16 @@ static void __link_shadow_page(struct kvm_vcpu *vcpu,
 
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
index 667f207d3d09..01fd29c91141 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -203,6 +203,11 @@ static inline bool is_executable_pte(u64 spte)
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

