Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A2426ECA
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703876; cv=none; b=jt+fSPnrVt3vj0U4PpafRZVtnLDKLZF3Obk+DSsngqOnYyEgFXpJ3YoIKNxZ35vmbLlXeevKGKUBrx3qu9t8DqH99y0pYkSs1XfVmWzvDVlZqqTRrkZ/51gKIuWLRXhTOHtzGSyv/FDGnmPF178UVRmcAqAQqDLr8tPxqizNi78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703876; c=relaxed/simple;
	bh=LsO7zA0G4uLWnVK+TL3P/peaWj8a+BRoQN9m2cBF1Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUgWLBUzTwha3ofqL+8XpCSwrxUXKYP7peMSMur8ofHQB+BkxkdKsy4/arPbjQZUHmHlUiAOIwL5l8iqVTKrlvUEPDGQlwz+LGKIYXK4jK/2ePhPLBlTuBFXQt/q3AfS99QByXVmS83oXKY8uaaDw8B/A4orOj9Tzt3bggLE5Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bx7MAfFA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7WFI3pE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bx7MAfFA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7WFI3pE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781703873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QJl+hDovUiXZ4Ag+ltyN8lVqypCjKaoOPuqMMQq8Ud0=;
	b=bx7MAfFA5hOBnFG/IWBuJnUl24RQvt2fyDOQaqLNRyu1K37nnzQFXywM2s+zO93WkPWu33
	klbDMUnxLwlGWiuXPafEfxMjjxQxQqrpVgTisjJJ3K8CcyzyGa++P7J1IJvuFZImdbc5Ns
	+NL/gKWoZt69ZUxRyA5obHIGZkQjGrQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-jiIp4yyxNQCLpXaZNsly7w-1; Wed, 17 Jun 2026 09:44:32 -0400
X-MC-Unique: jiIp4yyxNQCLpXaZNsly7w-1
X-Mimecast-MFC-AGG-ID: jiIp4yyxNQCLpXaZNsly7w_1781703871
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5aa63daf1a6so3290137e87.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781703871; x=1782308671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJl+hDovUiXZ4Ag+ltyN8lVqypCjKaoOPuqMMQq8Ud0=;
        b=J7WFI3pEWwsupeGaHBSAJ5ZBJsjpzDSHpRU5rboZwfu8TOtaX42a48Xo/bpIT5gryP
         tpXXy82Gcf6FXCAUAkJe5MG8wHtEgFFENqKPh3Ty1SxFjYTMcXkMc1TNN7GMYY0EVdzw
         uJf3y0FlvnLYZh4vWkMygAJ4nIocqQHh5FNkHWPFED7m/laoqE4d4j3pJ+Znl/1awm3z
         Xl7v4pzRJ4B2hU9f09uvJqWGJ1qAYc4qeenqw/83f0f4TMBfM0lnR7GOcmXDIevzxGDc
         Brs5s+g9lmTIyfp9nk2JpeXQZETCwwmgMzVpxxGS3GdErT1y/MM+9x7z/PgVapSpdTIZ
         ho7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781703871; x=1782308671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJl+hDovUiXZ4Ag+ltyN8lVqypCjKaoOPuqMMQq8Ud0=;
        b=d65O1TshC1MPUVVgQezXRGIhE/OsXaYgRJJBnAFK2/CXqD8Gn8o8WHGQyFjNja2W4o
         xQbf69qhfiq9ZKcXG+nuRcV6pruHVeeJgkKOePniB9pdr702wyn2THPWK2BH+exFIH0C
         5sW4K40aRYn3AsmgCkaiLAmjD3l/UUb2VQskemP6bkkEG+buktlfLWPaZ1hnD6cr0npy
         /3H+QIY2Qci0Z8+UhRglvP2yi3AE7yV+YjK9YtQ9X96l4yQ7NOLfZPvzb9KgQDnV26HV
         aBGiYYuNXs0br0KsnIJ45dqa7Nleju5SB+Lff0k8J9h/m8IWNetMfvzW8sgJ3iyfF0jI
         GiTw==
X-Forwarded-Encrypted: i=1; AFNElJ8J1TlCiYjj4kKlW+y6H6yb02S19imvm4sGiKH3xxQblc9lI0sD+Ui08pFH9YsnHbzNU/NRfHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB40d2qfL4HhkQtcPQ93fkEIPfwzCyiY4CmjizYB3ZhrweVQEu
	pK/F0GP3n0hrkawmgN8cHPXZiEqG6mOAjIcl96AA25Sx+JUvVM/V05/Lz+lNlEM8Eq0Arn7i6Kn
	iWN85VtPlb/mrRZSwqBizcou5n4T6Amj2HtmsrjunVl+/I8c34DuYSLmrKQ==
X-Gm-Gg: AfdE7clkUBTzTfvlIplq2GKmGGh2ACj9t8/Y7+BsvHu8Oky4bczxX9F9Qu6BJJYVHJK
	q2uQYx7kmjmgylwHVNaIFmxAOsCnac+aqWxwGsGT+g6rmVtkwu9/R6jB+1gceIglYhI3cyomBfY
	q+dDwca6n6YZ+kGN09UyltyaOAfl+zlk7GJ9JutrTNdw847uIbimLgJsb9q22i218nMy9k3d0Sq
	5TSlBane+dG6XpKyVQ3VE6EPnCGjdl9yP1FSeRot4htyw6QfuBwV7IcUmIHCEQVtK3vxGnE3bTD
	nzKeMhdlNnMUHw5ZV/8OkuY25tcLQ6Epb37x59RDsxvd/KRuszG8zqyjwXSU3BefskDsl9IqJ3O
	ZvUn5TCNIQ3sgxW53RAidlw12hWuKfFPFwObNBed1oQV4lSxqVU/05njRfa5nprO87+MIaNsW/n
	D/7Pj0D1fmqjSV5WbY
X-Received: by 2002:a05:6512:a8a:b0:5aa:6c89:72d8 with SMTP id 2adb3069b0e04-5ad47ed0087mr1044638e87.19.1781703870517;
        Wed, 17 Jun 2026 06:44:30 -0700 (PDT)
X-Received: by 2002:a05:6512:a8a:b0:5aa:6c89:72d8 with SMTP id 2adb3069b0e04-5ad47ed0087mr1044625e87.19.1781703870076;
        Wed, 17 Jun 2026 06:44:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1baba7sm4418601e87.83.2026.06.17.06.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:44:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org,
	David Matlack <dmatlack@google.com>,
	James Houghton <jthoughton@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Alexander Graf <graf@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Filippo Sironi <sironi@amazon.de>,
	Ivan Orlov <iorlov@amazon.co.uk>
Subject: [PATCH] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Wed, 17 Jun 2026 15:44:27 +0200
Message-ID: <20260617134427.440112-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

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
index c13b80fe3125..26ed97efda91 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7360,13 +7360,19 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
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
 		    sp->role.level < kvm_mmu_max_mapping_level(kvm, NULL, slot, sp->gfn)) {
 			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 27498e990dff..ab8cfaec82d3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1815,6 +1815,11 @@ void kvm_unregister_irq_ack_notifier(struct kvm *kvm,
 				   struct kvm_irq_ack_notifier *kian);
 bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args);
 
+static inline bool is_gfn_in_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return gfn >= slot->base_gfn && gfn < slot->base_gfn + slot->npages;
+}
+
 /*
  * Returns a pointer to the memslot if it contains gfn.
  * Otherwise returns NULL.
@@ -1825,7 +1830,7 @@ try_get_memslot(struct kvm_memory_slot *slot, gfn_t gfn)
 	if (!slot)
 		return NULL;
 
-	if (gfn >= slot->base_gfn && gfn < slot->base_gfn + slot->npages)
+	if (is_gfn_in_memslot(slot, gfn))
 		return slot;
 	else
 		return NULL;
-- 
2.54.0

