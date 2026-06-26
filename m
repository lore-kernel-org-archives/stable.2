Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107273E023E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473054; cv=none; b=lAbrQTtDfit5ThN3xBuuoT2jlinGkP3gxHtIG6+6tKTiIdfyCV9END+ZEy5fvImBwTpdzNwvGLEjWoLr0QIrBDnowOZoxv7fprUcY0G55zVZ6OiwHicWtW/LSVufFVDVYpZvq5L1AXNhfnwOKgJI82wgxaHB2EO+hj3sJYt4gxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473054; c=relaxed/simple;
	bh=zvFrns79aj9c24kACaQvFLIPdfxn5F03fJA54sqo/Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dB7O0NNYvAeor2ftqH0jrCpamB2cdO51nDinkOsfvXXsELIdKm5WTZsd0y45DIBXuwSykpgeJ89kBNpS+9SyZN6/xxcXA7xcja+n9l0wiv5Gpp/zTb/MyTC8dz7rnQqc1jxqi++pRH/qI9KDcrgshzg0TUlGbRh3tJWvynLcYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNGA8jmH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUyoxkZp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNGA8jmH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUyoxkZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NCgXQP8MBrTLQHgZqlchtRiyNKOElomA9/Al3COIg9o=;
	b=aNGA8jmHr1Y+2FvURwYVcI7JbvbYH1EhT5MvTepI9npZt4F88Ru01i3UaIPoMvVSyoNkY7
	8hpdSPTs8PWURX0SJuztHUH8TOmFhJSzsd26vb4zx12VntYnzCkXXzcH/1UBRX7RnxiIY1
	SCJd1reBuKDmnoAx1FHNA7lx8eJR7j0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-4AKPd-pHO6Cl2zoyBisY6A-1; Fri, 26 Jun 2026 07:24:10 -0400
X-MC-Unique: 4AKPd-pHO6Cl2zoyBisY6A-1
X-Mimecast-MFC-AGG-ID: 4AKPd-pHO6Cl2zoyBisY6A_1782473050
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490bae3a39bso5640215e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473049; x=1783077849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NCgXQP8MBrTLQHgZqlchtRiyNKOElomA9/Al3COIg9o=;
        b=TUyoxkZpy08PPzmmoc57XtiGMdqiWKgs2cydi5mnYJnI5OPRErZtByrVkkRDrD7SFC
         ylt10wssA9xfuoaiBmPbZaTbbFrf1w0SlRGLKRfNVtpp4kuAsSn0eT9jF1qKcQ+iZTbv
         hMjLlEg4RaxtpgrdeRIXtKZqOjYGtU1pF/aV/n2IxEuH9ZY7PSWPy++t21wSbv1cL3rD
         vLsKaZCmwWm0hctnEwhIIqT3JgAaH1Nj4IsjXIXU+Sqirep0kPejK7o5hFxU8OwWhNsP
         O8c7Mv97SFX/y0BB6MTQdR/a1asHbrbhMMjME/sR3cDMeI6rFTc2ZclcOK/a1vIYRm5Y
         q9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473049; x=1783077849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCgXQP8MBrTLQHgZqlchtRiyNKOElomA9/Al3COIg9o=;
        b=LZ44L9HeeGpkpQdGYru0UO1XOJwCdjz9OZz0zXpNxIPzn6fdLulsb2ugn68dTE0x97
         BdgFvX/L3mYrZUcy7cDqwey1+h4P1vgwslObH+qKm+aZe/rVqQEqaG0KmVgiRorzN999
         6Am73ODZau8uJ8ZRil3izi+wFVZmlIiXXUXsWRpB5XhYHVf4RToJQhbLMb2ojefKxqi8
         p7spE31ryXbdlK2MAWeh/pnoJCHQQzIGNwuzuuofKT5LmQQq2afzawI1bMXA1id4Ls47
         VVVKcbtzNVb2q8vN9PkJkYIxwkS7v9yGBdEzFxG9K19f29cmbdo7Du+ykyyb8PMt3xhi
         bdXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8h8D6wTfOalcWro120R4MQdSuAxsEl6cq1uhXjp89/nkfrIUKfEz8mGCjMp0K2wwJSWNhf9/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQOSHhDdKXvaCqdagxuKSXFu8VpbIGqHQF4cUbmxw5Q7oy/af
	klzCLgxD0KR12cIOu8ISUjPKzFxoojOdp3g1+mvXBjAfNNbzzOJIY1ZJ9WZmJF4W2slNV/x2qN6
	lyAY2mSJbHFnaHhMfO1PxOsanel76kc/gL/m9b3j1+xbe6VZDwjJ6CDk1Bg==
X-Gm-Gg: AfdE7clpsK1UyBRZ/8H4qFe3/IjyiSkDuBkfv2awA2nWecBjnzIZaE01tTP8lf0Bcgk
	6NCOD7i9m0Wn4P9EApTabKiwy+PFAKNYYG4Z8w+JrE/jB4R9EBbKU/TiYfuFjCX5clIWIe/JujO
	s+hdQhifkz0EZfLSCinGdcrd1An/67lDoRI7FIJUkzGP/8DNuqJJQg5fmRQkzKrWC3HVUZMdqKc
	KDtTT/Mlilcw6p6W5BchyPUBh4gBKaQgZYet99GkxpvrNRIj9+zNaJ/t8k+oFh8cVcqYhe8NxS8
	lGe6lWv2cTbAixNydZXLh2d/5Wg6YDLaSJ7pzQqYA1/qRBqC9yX3SYBAx/7denwTq05r65UMjns
	uY/2dbKgZBWccZCrYCVfGnepMYFqNXrMcxwI0B6eJsFku3nRMzKgS48u8Z+l9HhqX5MZf941bP/
	Vh0NO2/XcUW7BIvF4F
X-Received: by 2002:a05:600c:34ca:b0:492:463d:b2af with SMTP id 5b1f17b1804b1-4926689f461mr83759525e9.31.1782473049491;
        Fri, 26 Jun 2026 04:24:09 -0700 (PDT)
X-Received: by 2002:a05:600c:34ca:b0:492:463d:b2af with SMTP id 5b1f17b1804b1-4926689f461mr83759005e9.31.1782473049047;
        Fri, 26 Jun 2026 04:24:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269002511sm70776235e9.8.2026.06.26.04.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:24:08 -0700 (PDT)
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
Subject: [PATCH 6.12.y] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:24:05 +0200
Message-ID: <20260626112405.1777340-2-pbonzini@redhat.com>
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

