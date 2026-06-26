Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41C3F20EF
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473074; cv=none; b=sYdhrICURPeRQgitIs5kDLmp3cR+hmhCRL9tpc5YYaTHMxCOJ7hoDCZA78xRnQ5tqNAMWtb0FXXdx4vQe77h1gmTXz/Q+OjSUsFHcqL3VADJleD7900EZOowoNlzanZDsoWiRd+tSnMeSHlnfuTimhNV2judDgzUk9nQoy8HMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473074; c=relaxed/simple;
	bh=zvFrns79aj9c24kACaQvFLIPdfxn5F03fJA54sqo/Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1pashR1NbYwOD2CGkrnoR+oxNAbpJrKPN5cModk7hLjacNxBe1ZV4IJGRpLA6VTAkUMr/g11RAbhya1OKzlE+m3tgnlIH1sN3MF3H63Sfh54MaEwtE3cJOZIKKTD9QfMSzLGWl/zcg6wVT2l7R6Kvw23LLmWMKKyqTVikXgLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4bWUuTi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=plOj4Aey; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4bWUuTi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="plOj4Aey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NCgXQP8MBrTLQHgZqlchtRiyNKOElomA9/Al3COIg9o=;
	b=J4bWUuTi3K5hXWMuFYK/YFrdNUsnThydEnFb9IABbPIq+CQ8RWzWWsJZIWPAKLn0I+7Am5
	GxnDO7GooRkv+ASjAicCXAlaMf3STHhM+TI7dkyThlNYCNdbzcaMgT/Akq2VPRZuRkaev3
	un7n25MQtfXRuhLqjB4xJMux7U/wqJo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-3I3AVAiYODGT0gYjuUQoQw-1; Fri, 26 Jun 2026 07:24:31 -0400
X-MC-Unique: 3I3AVAiYODGT0gYjuUQoQw-1
X-Mimecast-MFC-AGG-ID: 3I3AVAiYODGT0gYjuUQoQw_1782473070
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490afe64f26so4355005e9.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473070; x=1783077870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NCgXQP8MBrTLQHgZqlchtRiyNKOElomA9/Al3COIg9o=;
        b=plOj4AeylDaGaB4fOLkVFTHklWW/ZRksINUWZOEFkeBscfLN9ZcZOXm9JYAwBLC15Q
         8NPlnf/gdD2nitQ7m7UjTBjsJbOnQdWZQ1SYrjhbwHIs7QmqkDC2fYGx3tp7W9tUeFMb
         DgwYlH2P/0ob4tRbpAodyCCLZT1XPunADpuiPUG0DkOVWS4ETPp3BATr+sInmO0dHWdc
         M0eurxyrRpMTr6NzlUt29oi6aOGYEhB+xA+YhZll9jWr/G3WmiWusAs6p4ogcQ0UmHG/
         b7FmGjVHKpx3xylFYu2gxdLBArWutoq8yPaif5+BWbjpmjEbnPh6SCxR/M0sGeBIMDCg
         MtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473070; x=1783077870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCgXQP8MBrTLQHgZqlchtRiyNKOElomA9/Al3COIg9o=;
        b=p4dlN/Gg4zI+PuZOnq/f/FmNbq3T0pnqa6FRvzPjbigHElCOVOSolF0OyUoRmHFmTg
         Wr8/gvjPg63wC3uh96hvX9EtNiLgppqMY+Ebyy80mMleJJV/2MGVREIQZgTPhq7gjLhR
         4IYqrVf5v+13HJjnHmjQl6lljIggpKtxl83RxbOjtDUMvK6LAQbbcDPJ0B+waX4Ae1ov
         j9I/mMWRHntB3QnKzZuaSYKlPRMweZSkSnydTLoKM+HJrKOfgAk7J4VDWHEebk4bs8X9
         vOzNEr2raJwI61s4AHC5qsifOH9EWWTFt3iTxRw3OyupQ9k9WOrPyNFy7InK0g6QTbGK
         rF0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+VXE4a2PDzXbFiaiH46mugtUYatDfVBLfRUiZP00AiBpv7C7NR0ZHoRBz/U2R88ERzCPZlgBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+8L80AUeUyF9NEGdNyFL2fumPRqbbgzUsJZ1ib+S6+3bmF5v
	9icFGp5v71QeHmaMeMHCfabzMHezCVwaJQmVBNHMTQxif1FAm+yputFTIh1Oxg44MVY/ltsEIb6
	ouqdZM0AE8ND0vE5nSNOo2QCUrd2JxN74ktHKA6B1qOg23m43E7w5XMnpyg==
X-Gm-Gg: AfdE7ck/ljMLhIe2IPvZDl11J5c2tEIoe+8jwhgFoFUsncpY3WwkWj6DLKuDi+vTBC+
	G797ZXpsk8GETN0NZOSf9P1qutbPOqq7lcsCiRQxyzCKURc/1kIWaGemnSVo4s/WUupJ9bE+k0+
	G3C7aSD8YLL2CU7iFX+oCp3IlHpWhJMFe299I8XWA/hWMal57Uo8fp6bM+zx4lrdoDelPPWGp0v
	N4b+N5pREPeNU57PXQmkqR0qeEdAMUrMxhs8igvTf8qcvyHSkcNmijkl7wfQ0jv7PDqmP02SfJs
	HlhHfeRwMlI9Z4Cgkv+Pvn1FzzNWG6vC68FNly31OvUy8h9i99shvxDfdgEyUHFn/Opzze8iuBv
	XyyamEqNR2GWfM2y13tv5DrEoogdGjPDJdd6oO69XYDYSULmo3+Z4ECQqFHyccpU2oA2gLkpd4L
	SoMozdwfPA/7ymhKBl
X-Received: by 2002:a05:600c:1551:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-492664241a4mr82249255e9.13.1782473069795;
        Fri, 26 Jun 2026 04:24:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1551:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-492664241a4mr82248925e9.13.1782473069405;
        Fri, 26 Jun 2026 04:24:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c2954efsm31905345e9.2.2026.06.26.04.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:24:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	James Houghton <jthoughton@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Alexander Graf <graf@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Filippo Sironi <sironi@amazon.de>,
	Ivan Orlov <iorlov@amazon.co.uk>
Subject: [PATCH 6.6.y] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:24:25 +0200
Message-ID: <20260626112425.1777712-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit ef057cbf825e03b63f6edf5980f96abf3c53089d upstream.

When recovering hugepages in the shadow MMU, verify that the base gfn of
the shadow page is actually contained within the target memslot, *before*
querying the max mapping level given the shadow page's gfn.  Failure to
pre-check the validity of the gfn can lead to an out-of-bounds access to
the slot's lpage_info (which typically manifests as a host #PF because the
lpage_info is vmalloc'd) if the guest creates a hugepage mapping (in its
PTEs) that extends "below" the bounds of a memslot.

When faulting in memory for a guest, and the size of the guest mapping is
greater than KVM's (current) max mapping, then KVM will create a "direct"
shadow page (direct in that there are no gPTEs to shadow, and so the target
gfn is a direct calculation given the base gfn of the shadow page).  The
hugepage recovery flow looks for such direct shadow pages, as forcing 4KiB
mappings when dirty logging generates the guest > host mapping size case.
When the 4KiB restriction is lifted, then KVM can replace the shadow page
with a hugepage.

But if KVM originally used a smaller mapping than the guest because the
range of memory covered by the guest hugepage exceeds the bounds of a
memslot, then KVM will link a direct shadow page with a gfn that is outside
the bounds of the memslot being used to fault in memory.  The rmap entry
added for the leaf mapping is correct and within bounds, but the gfn of the
leaf SPTE's parent shadow page will be out of bounds.

  BUG: unable to handle page fault for address: ffffc90000806ffc
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 100000067 P4D 100000067 PUD 1002a7067 PMD 10612f067 PTE 0
  Oops: Oops: 0000 [#1] SMP
  CPU: 13 UID: 1000 PID: 757 Comm: mmu_stress_test Not tainted 7.1.0-rc1-48ce1e26eace-x86_pir_to_irr_comments-vm #341 PREEMPT
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:kvm_mmu_max_mapping_level+0x79/0x2b0 [kvm]
  Call Trace:
   <TASK>
   kvm_mmu_recover_huge_pages+0x21b/0x320 [kvm]
   kvm_set_memslot+0x1ee/0x590 [kvm]
   kvm_set_memory_region.part.0+0x3a1/0x4d0 [kvm]
   kvm_vm_ioctl+0x9bf/0x15d0 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb7/0xbb0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f21c0f1a9bf
   </TASK>

Don't bother pre-checking the bounds of the potential hugepage, i.e. don't
check that e.g. sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level + 1) is also
within the memslot, as the checks performed by kvm_mmu_max_mapping_level()
are a superset of the basic bounds checks.  I.e. pre-checking the full
range would be a dubious micro-optimization.

Fixes: 9eba50f8d7fc ("KVM: x86/mmu: Consult max mapping level when zapping collapsible SPTEs")
Cc: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Alexander Bulekov <bkov@amazon.com>
Cc: Fred Griffoul <fgriffo@amazon.co.uk>
Cc: Alexander Graf <graf@amazon.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Filippo Sironi <sironi@amazon.de>
Cc: Ivan Orlov <iorlov@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c   | 18 ++++++++++++------
 include/linux/kvm_host.h |  7 ++++++-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a67d013fff4d..aab26f90c285 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6952,13 +6952,19 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		sp = sptep_to_sp(sptep);
 
 		/*
-		 * We cannot do huge page mapping for indirect shadow pages,
-		 * which are found on the last rmap (level = 1) when not using
-		 * tdp; such shadow pages are synced with the page table in
-		 * the guest, and the guest page table is using 4K page size
-		 * mapping if the indirect sp has level = 1.
+		 * Direct shadow page can be replaced by a hugepage if the host
+		 * mapping level allows it and the memslot maps all of the host
+		 * hugepage.  Note!  If the memslot maps only part of the
+		 * hugepage, sp->gfn may be below slot->base_gfn, and querying
+		 * the max mapping level would cause an out-of-bounds lpage_info
+		 * access.  So the gfn bounds check *must* be done first.
+		 *
+		 * Indirect shadow pages are created when the guest page tables
+		 * are using 4K pages.  Since the host mapping is always
+		 * constrained by the page size in the guest, indirect shadow
+		 * pages are never collapsible.
 		 */
-		if (sp->role.direct &&
+		if (sp->role.direct && is_gfn_in_memslot(slot, sp->gfn) &&
 		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
 							       PG_LEVEL_NUM)) {
 			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 04b81e2166d5..b4235e99f0a9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1745,6 +1745,11 @@ int kvm_request_irq_source_id(struct kvm *kvm);
 void kvm_free_irq_source_id(struct kvm *kvm, int irq_source_id);
 bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args);
 
+static inline bool is_gfn_in_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return gfn >= slot->base_gfn && gfn < slot->base_gfn + slot->npages;
+}
+
 /*
  * Returns a pointer to the memslot if it contains gfn.
  * Otherwise returns NULL.
@@ -1755,7 +1760,7 @@ try_get_memslot(struct kvm_memory_slot *slot, gfn_t gfn)
 	if (!slot)
 		return NULL;
 
-	if (gfn >= slot->base_gfn && gfn < slot->base_gfn + slot->npages)
+	if (is_gfn_in_memslot(slot, gfn))
 		return slot;
 	else
 		return NULL;
-- 
2.54.0

