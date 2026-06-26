Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9A3FA5FC
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473251; cv=none; b=lXbEDmAdJwML69B7BPwdf2yyzd1DAYNj6kkaZKlZB+qlXOGnQyYB+yX3b0qg+lCMgMVEI2JvIBIwne5Lqpv+ykVRuhlkO7ezMukUtbm6eun09uP6XNVjkqz2Ov4Di0NGQIBHs/qXiXal5c94Xmvf/G2KKwGX57PhJp443VYQUuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473251; c=relaxed/simple;
	bh=E1C3BPJ0p8jD2trwUlWOiL20YlY9EiZVRd4Sg/13Z/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJBVYdt3KUctb39fy/tuilMny6Y4KMxBPQL+i0IfNhHod7CeksembcD14wt3Z6V/di/mmUEi82R7kbtu9JdCZc3Jvm87S18Xon5f6jXr7ASAl0olHbD2zpSJxaxkNwZm0xQWOO4RTDKunRMrr2wKWYUxNB1iVZlgPaWIDJLsYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfekGbUT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZnTqrSs0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfekGbUT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnTqrSs0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LOKYXeF8DV1xTMTuzANqPLbadSyXms7qeYO6RbZUFw=;
	b=cfekGbUTcCLfW+TQWeqtiriD2jgwDXKjsxbc+oxvzRuVwJQ/f6ok9J8M/5Rse+FOOAzQCr
	mhbMLjmiK6F5pBuKhGPMzcGvWNusu1IpKugPbZIystGhw9hX345YqS98KY7Q2qto+QbCVP
	2mXjdhVhpED6m/i2SPFDO35hYaldL00=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-DagIWJ9EOzmCX3j-JQ-ChA-1; Fri, 26 Jun 2026 07:27:27 -0400
X-MC-Unique: DagIWJ9EOzmCX3j-JQ-ChA-1
X-Mimecast-MFC-AGG-ID: DagIWJ9EOzmCX3j-JQ-ChA_1782473247
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4642a5651d4so712234f8f.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473246; x=1783078046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LOKYXeF8DV1xTMTuzANqPLbadSyXms7qeYO6RbZUFw=;
        b=ZnTqrSs0H78PY4C9L+mU/231Bi8XpLFPFEm0hpa2jUwESA6Lq/PknQ165qAYShPBPS
         r+6++kUTp4bFyGA/bzWNzj4h6xfYh6SQjEhLe8T+JMMTZJnkOzk6ewLOrxGLPctA769E
         9EDAzvCkh/lrmogxfj0PhDz1H3weas1ZIdnYYACS+GhM92nJ9M3WWMe3+rp4KHkVUNBF
         50Tl/iWhgZBcWqRa0vLHYU0eYIa0gQ7IvVVV63u85U0wDgFhRzdqlYyU/b6ALkQDdDZS
         PnymttaoUQkOLyMtDYVJqvpBleOP8FxKDOVIAUSPCtBHVzfHUgZrYCG42eeasns7lTrZ
         gNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473246; x=1783078046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LOKYXeF8DV1xTMTuzANqPLbadSyXms7qeYO6RbZUFw=;
        b=Mx7ntynzXnJhfl4XS1qI30G1AThnWvzbJznpOlAbU9uIZK8Uo1rHbDmyKzw33ey4sz
         XTxdp0MnsvOJjEiN0M3GlSSENA+LWPf1C6s1YeeNa0atKQ+4g+K1XyF1JGgUCZc2/P0b
         CZfvjuUSYIxJQ+lAjTVSB/hKij2Ot+tR/PEXDj2FSK8kl8TFJMgbBsmzFMNPBkxihW/W
         TVW27KxGENMUAD+/bufx9eDxYdtshkJz213c8RNa6eSFasBdS0O5Ev6rm9H65DU/HxN1
         bmLK5Y30w8jQCMC1KcF4rZYlLsaEy4JFZA4EzFFBEIVu76owGgsDI6bTAq+lm0B6yE9o
         Iw/A==
X-Forwarded-Encrypted: i=1; AHgh+Rq4kAK7adI3UarJh7qQXq+9id2N3OHRmou80068zThcQhBZJDSkBrmlp+sT6frPKmw0eH7Afsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHGTOzP3bslZjbfrZ/t/zSAhcQEK6jO8mOgrvAhv1rTjW61qAO
	NBRrMbOH0CU/6YjHKfdvFm+7xppbbm+FeBcq+t2UZsMYl0ZH5HqVDTzBPD/0PRXOc8/TDeCjRsD
	RLonyNKpGdPwoa3/D3mzlod0e2IBjGELmjnt46uTVK9KXpQIJ7Fv/jXyoRw==
X-Gm-Gg: AfdE7cmkelMe9H1s0AouFOFVsrWNyHO3yIYSIP2ngpRKL2TYyKAgNjLiWCjaWi6d18W
	42WzadvLkJZKnR3LdxJCfx9INEBnGB7KsA9epPwFQTKXCBOK+r37Kq8rkz0e6wZsz9xHXtHk7X+
	MAyNxzYZy2RLihIaQKiWJko/clcEPf25g/McqZOHpvVb+DtVO3uce9N/Cslg5LAiJOxi8vLuxhk
	YpqJD0TiwaArGwGafk6zvC8luymp7YXsOSB+FTAA/hmxq7tGoHSwPhZsJYnq7ZiphptmgfkSjWg
	fVRjOpeZDr4JF6Sl2y1ZMliNB/FceuY9bJ0tTvCJ3HoyHoUuHNKsT73du4xbTYU7FaDyRUlbXPA
	gfkur//T2lTvwHW7amVhRzbkyUaA1GwUSXA/uw/s7lK5A4aNdv+oVG/d5nJTC1uRw/2OHCfybB1
	LKZkTtVXZ0upODF/uJ
X-Received: by 2002:a05:6000:4308:b0:45e:891c:648e with SMTP id ffacd0b85a97d-46dbf023548mr10491106f8f.8.1782473246506;
        Fri, 26 Jun 2026 04:27:26 -0700 (PDT)
X-Received: by 2002:a05:6000:4308:b0:45e:891c:648e with SMTP id ffacd0b85a97d-46dbf023548mr10491054f8f.8.1782473246043;
        Fri, 26 Jun 2026 04:27:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e3d6ba143sm11204309f8f.33.2026.06.26.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:27:25 -0700 (PDT)
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
Subject: [PATCH 5.10.y 17/17] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:26:34 +0200
Message-ID: <20260626112634.1778506-18-pbonzini@redhat.com>
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
 arch/x86/kvm/mmu/mmu.c   | 19 +++++++++++++------
 include/linux/kvm_host.h |  5 +++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 39186d695269..b7e8618d3df5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5659,13 +5659,20 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
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
+		    !kvm_is_reserved_pfn(pfn) &&
 		    (kvm_is_zone_device_pfn(pfn) ||
 		     PageCompound(pfn_to_page(pfn)))) {
 			pte_list_remove(rmap_head, sptep);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6b8b562407a0..b737604a676e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1092,6 +1092,11 @@ int kvm_request_irq_source_id(struct kvm *kvm);
 void kvm_free_irq_source_id(struct kvm *kvm, int irq_source_id);
 bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args);
 
+static inline bool is_gfn_in_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return gfn >= slot->base_gfn && gfn < slot->base_gfn + slot->npages;
+}
+
 /*
  * search_memslots() and __gfn_to_memslot() are here because they are
  * used in non-modular code in arch/powerpc/kvm/book3s_hv_rm_mmu.c.
-- 
2.54.0

