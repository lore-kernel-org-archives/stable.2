Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BAF3DAADB
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909361; cv=none; b=Hw+hKLDzsrDgQMaT5PhbTC6RH1Qjf3jSSTflusntOF7hFtU2s2P8scym3tKf++GgRNY9GuDPTD/VQpBD0NYOa8yB0pZagfOwB4DAtVPWzzqsdBNoxGpqTm2u3FX0glqGjUMznimBSGGndmAkwrMk+w1gI0A8FE+FLNf2vyASUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909361; c=relaxed/simple;
	bh=/pLxtUKvZEHpiFlf2XOuqPBUAkNkK7MFBJPdWemmLB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGw/VL15rk4gQuA3BzP4ikdQxf22iRlEI49xgjTe1homl6rhIbPT8rH/mTurTo0eUGfxSiKjFSC+236H+PDUBMzByV51Yjm3GrnXgrs8IdzHz0mytmS1nK2BcFB0INjnHpRkjxjELWnrK8pQdL51XX4WEyHbMS2Yf84Fj23pmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ishBI9Oa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ishBI9Oa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785909358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=myGrw8fGktwNQsvE5uYfJTAVudnST/W8PUvvhsvRQII=;
	b=ishBI9OacS9wSEg7IEa3g4hg4M/s9AybYfXAGwFYG/HU1MdpaLsF1DFAT0TSYEwiF8LgF5
	GHdor+kA6jVJ0aBcBHlVT8K2+UzJiqRBATsAu42aDI1SSfpV8Xz/tIPEUtXt1OONgyd6DN
	e42+xcOjI6bGgLYBYeZZpckTwAC/QeQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-52WWm8eOPpWFxk_xvF0GUw-1; Wed,
 05 Aug 2026 01:55:56 -0400
X-MC-Unique: 52WWm8eOPpWFxk_xvF0GUw-1
X-Mimecast-MFC-AGG-ID: 52WWm8eOPpWFxk_xvF0GUw_1785909355
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51D9219560AE;
	Wed,  5 Aug 2026 05:55:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.25])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EAC41800348;
	Wed,  5 Aug 2026 05:55:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: Peter Xu <peterx@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cedric Le Goater <clg@redhat.com>
Subject: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP policy check
Date: Wed,  5 Aug 2026 07:55:40 +0200
Message-ID: <20260805055544.1568534-1-clg@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Cedric Le Goater <clg@redhat.com>

The global THP sysfs policy (transparent_hugepage=never/madvise/always)
gates the huge fault dispatch path in __thp_vma_allowable_orders() for
all non-anonymous VMAs, including PFN-mapped device BARs (VM_PFNMAP).

DAX VMAs already bypass this check via an early return:

	if (vma_is_dax(vma))
		return in_pf ? orders : 0;

But "special huge" VMAs -- identified by vma_is_special_huge() -- do not
get this early return, even though they share the same fundamental
property: they map physical addresses directly into page tables and
involve no memory allocation, no compaction, no splitting, and no
reclaim. The THP policy has no meaningful effect on them.

This matters for VFIO PCI passthrough of large-BAR devices such as
NVIDIA H200 NVL GPUs (256 GB BAR each). The VFIO driver registers a
.huge_fault handler (vfio_pci_mmap_huge_fault) that dispatches to
vmf_insert_pfn_pmd/pud, and QEMU's vfio_region_mmap() aligns the BAR
mappings for huge page table entries. Both prerequisites are met, but
with THP=never or THP=madvise, __thp_vma_allowable_orders() returns 0
before reaching the "trust huge_fault handlers" code.

The result: each 256 GB BAR is mapped at 4 KiB granularity -- 67 million
page faults per GPU instead of a few thousand PMD/PUD faults. On hosts
with 8 GPUs (2 TB of BAR space), this causes VM boot times to degrade
severely, with 99.98% of CPU time spent in the VFIO BAR mapping path.

Configurations that trigger this:
  - transparent_hugepage=never on the kernel command line
  - The tuned cpu-partitioning profile (inherits network-latency, which
    sets transparent_hugepages=never via sysfs)
  - transparent_hugepage=madvise (the RHEL default), since VFIO VMAs
    lack VM_HUGEPAGE and QEMU does not call madvise(MADV_HUGEPAGE) on
    BAR mmap regions

Extend the existing DAX early return to also cover vma_is_special_huge()
VMAs. This is consistent with how vma_is_special_huge() is already
treated for supported_orders (grouped with DAX). The mm/Kconfig TODO
comment "Allow to be enabled without THP" also acknowledges this
coupling is wrong.

Cc: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Fixes: 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cedric Le Goater <clg@redhat.com>
---
 mm/huge_memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 58cabe6af33d031e48250e21db51506bc46c97b2..6dfef5500a054f09f9ece6df8bf7a0194624350f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -139,8 +139,12 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags, forced_collapse))
 		return 0;
 
-	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
-	if (vma_is_dax(vma))
+	/*
+	 * khugepaged doesn't collapse DAX or special huge VMAs, but page
+	 * fault is fine. These map physical addresses directly — the THP
+	 * policy is irrelevant for them.
+	 */
+	if (vma_is_dax(vma) || vma_is_special_huge(vma))
 		return in_pf ? orders : 0;
 
 	/*
-- 
2.55.0

