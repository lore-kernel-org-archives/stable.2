Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3763F4DD9
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473195; cv=none; b=rW88kg5Y4r4d33rO+A6fEw2EUJ8wsUABwxTx2MbwhrzszN37tHNcNPzkLI770ic1pwN2PsDSZtxUnLq2PuySXR6xCaw3y/eL6KN6p96du2I66YXjooMiTG/oLmRuCRyzUvY3Z7bWMjqeRBd4x8jk/742OSBWJr9ydI3J1/mXFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473195; c=relaxed/simple;
	bh=dbaeFFQtxdnMo9jIBLCGDWuk/OqK+lsi+FKlSN8eZ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzry+xMrwV9mCt9RK1su1FIIHvRBQMJbBNiW2i87K2JS04ooXG6L11ZVrqY9wj3fnn16poT5gkgTmZL43MOwQ5rkuy69OOcdoEQ8WdCXRVC/X7kY8fsxs5OX/5RZfTfc29Se5oXoyNSHOlnl54QaThgwmwk7mdyESe2vyLv9Ymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFrL/s9r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sE8xim5V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFrL/s9r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sE8xim5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRgxNYJQINFwul+gy8TKvzRStBufovMG7KMJxD2zUic=;
	b=QFrL/s9ruL2BaFIs2q8m2F7gndBNxumX9oIRO7edJ9iQr0BDmV2LvibKBViIEQ1l2Q2MLX
	rPTWSXlPdGJmp2jvJOfsa49NszI1cM9lAzZC2a8ngCV8GkRHfAKVc8Y/Q2fLoAsCEiDZKP
	kQw5iNiEs4ooamerWkkYVpVedTYYyv4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-19l8iRVHOSe8ygDUOkM3Lg-1; Fri, 26 Jun 2026 07:26:32 -0400
X-MC-Unique: 19l8iRVHOSe8ygDUOkM3Lg-1
X-Mimecast-MFC-AGG-ID: 19l8iRVHOSe8ygDUOkM3Lg_1782473191
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46dc84ca722so510768f8f.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473191; x=1783077991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRgxNYJQINFwul+gy8TKvzRStBufovMG7KMJxD2zUic=;
        b=sE8xim5VowHO/Fbr3QqSUR8+SHsMWpnSf+/5a/o7oM8WcbQXVvQtwtHt7Zzb3aqUpY
         e9sqjfIMU6X1fgQZeetlcTefwGmEO/Hao+8nk+QKYOxsE2u8jHOc9winJWTGeWBGe4Mw
         kDsfukfpdsYDeTZ6npTkJoQYRUuMrfpRyUBTMAPWAwKY/4rITGhFrI0hsUwFblNPjBYp
         jY31JLIXq96onURdAKc+QV1cx/eeLNKRYuitWauDGtWaj0KvWEg1xSxAbOzVGSBCXE16
         4aefwaK8b9HZLzlbJIXK6ntu3CiWPrFPjr6Kp1ZG8FT53kfHUX61Kv7Ituph7r/iN9/o
         IGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473191; x=1783077991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lRgxNYJQINFwul+gy8TKvzRStBufovMG7KMJxD2zUic=;
        b=HOY49lj5rxuLZHQdk7z6uTERCdgybAalyJbhMH4ZmP1Bdqm0JRUZDIx5rS6bNOQgdd
         tU9ZCJ0PqRHLYaxE7hhC6de4ioba0BEEyFK1Wkt3qMaO8loHlSmSCsdJnK0vBZSDHdjy
         lfV0hNhZBrnMydUF5rdvTsf/Zpa4iUpVU/jPoJhWbcu7489f39ufMDTo7ntJmpsIm3eK
         XLRTW2vFwosFYGsirOneDOZOhx2jIRFugaCg8OvWkLiPOjVXcImpHhyLa83BWUqKbb3g
         +rnU021exrlrPiMI4S/Ax10bC/oi7/7M3zm7DqU1CSqMlr5ocND8W2VIY4M2poCc+f9Z
         ZKvw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9UJcDrXSV3CP+hk1d8HozQnIgQ2Gxw9+O1p+ivpYqJTBUH/7xwkaMKCTwIC07NB31LTsvNgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm56j8zSoXT1EZXuKckIWbc8kPjhSTD5DZ7/VZs/4mIj22mVCF
	BQxVA7mxdDoW853KtqcgyPelE16iNVRdNl1ovgblCy9C1r1pbqItmNOkk6d3sxeh8CAnLHxEgeC
	d3GzHcrejq500WSnspJF/7nQBJdijiz8QNb42+29m9lu62rWMXdVl2xL7pg==
X-Gm-Gg: AfdE7ckjT3n8ZieyZiqQ6YLQpFSb/F7+xIcJRm+TIk4UngFVINU/wrwyOoCetz8oFnN
	tcpFlHs+Yyt/Q3eVHgtHdziDw/d98A6WQ5rdq8m1mKoQiVTOXPTt4KsF8WQYpcVNcKKr912XHTq
	AiLRQ9+stQZ5ceciftW4yIK7e41IhbpnFPW+3fqBSPvaoSkmxfp944FYDUg5vVgfLb7ap44kqVT
	yu2bEw0DA+t6lG6Pf9j3Yx6ahh+Ae8JJER/DGsK/Lu3X2J1FBE270T6XU6nJbu/kpNzv3t2mAVT
	M2dqTqo87KJyA82IHer6GvSDMgJtNZlRNSUTtQnGf/Br+fdUB2e2TdPl/cdoXz2GZqPG5hBQjDU
	C1XPM2u38bX1Vo8rl/A+n3Sxs69WauNQtLDXJTEv3H6N1IocQWbvvsnmw+dgsiQZyFM96a6V4Lt
	0wFRo+aIYvHoHIqHK3
X-Received: by 2002:a05:6000:4692:b0:46e:6210:bd8d with SMTP id ffacd0b85a97d-46e6210be90mr5567868f8f.17.1782473190802;
        Fri, 26 Jun 2026 04:26:30 -0700 (PDT)
X-Received: by 2002:a05:6000:4692:b0:46e:6210:bd8d with SMTP id ffacd0b85a97d-46e6210be90mr5567833f8f.17.1782473190408;
        Fri, 26 Jun 2026 04:26:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46cf775a4f0sm17875733f8f.17.2026.06.26.04.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	James Houghton <jthoughton@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Alexander Graf <graf@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Filippo Sironi <sironi@amazon.de>,
	Ivan Orlov <iorlov@amazon.co.uk>
Subject: [PATCH 5.15.y 8/8] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:26:06 +0200
Message-ID: <20260626112606.1778248-9-pbonzini@redhat.com>
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
index e9dbe3e7ec62..9a3020648c8b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5883,13 +5883,19 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		pfn = spte_to_pfn(*sptep);
 
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
-		if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
+		if (sp->role.direct && is_gfn_in_memslot(slot, sp->gfn) &&
 		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
 							       pfn, PG_LEVEL_NUM)) {
 			pte_list_remove(kvm, rmap_head, sptep);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 956a568c2dc2..559564bb6af7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1311,6 +1311,11 @@ int kvm_request_irq_source_id(struct kvm *kvm);
 void kvm_free_irq_source_id(struct kvm *kvm, int irq_source_id);
 bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args);
 
+static inline bool is_gfn_in_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return gfn >= slot->base_gfn && gfn < slot->base_gfn + slot->npages;
+}
+
 /*
  * Returns a pointer to the memslot at slot_index if it contains gfn.
  * Otherwise returns NULL.
@@ -1331,7 +1336,7 @@ try_get_memslot(struct kvm_memslots *slots, int slot_index, gfn_t gfn)
 	slot_index = array_index_nospec(slot_index, slots->used_slots);
 	slot = &slots->memslots[slot_index];
 
-	if (gfn >= slot->base_gfn && gfn < slot->base_gfn + slot->npages)
+	if (is_gfn_in_memslot(slot, gfn))
 		return slot;
 	else
 		return NULL;
-- 
2.54.0

