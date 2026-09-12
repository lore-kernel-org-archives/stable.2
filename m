Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6E13D53C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 03:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789184920; cv=none; b=DRX1TxHQ4wzTo+Joh3YJd3egAcsAe0gLpgHYoYchViGnqtQQCotBDqOD+jWISB1QXzdfIUMvtpM8gx76LbRXFV29CJ4JxK4lBSoAUsReoJ+GPYEuejo2Br2gqaf1buGx0cigUCFpqT99aQ4Z4Ll/h6sRIAhR/Wfe91Y2VJEEpNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789184920; c=relaxed/simple;
	bh=uYFJnnnm2NR9mXD5b/fiPbuo/WUiVhKYOc1vVeIcaro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmamkQIxmgONtpXIrVL5T4EiFmXikKPvAtp8g9Cokv4jUV0agpWwIr2o6B6Rby+BplO+D4EKqMAjzOk+vGb2WBIqKDEfT3wqw3GA44RVRwZFWUoTwSxAKiKZoAs3buN/rforKdNVtVLPZpPnzVsxHB6ivUzK81+YhPXvcAk8uro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LD2AAdjF; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LD2AAdjF"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9103228ef53so17106396d6.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789184918; x=1789789718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SE/qOas+/SI2EvNxtEJVx4SSxOPMNxV+dkdmLC2H+E=;
        b=LD2AAdjFCN0FPQA8tvBoez0vdfwDEQZQCk8JOq11DdDmz1R+Ia0Xcj7+Gn7EN63vom
         RGDIduyByP5MUffxetSnY78Am+ZOWhrR1MkhPW1i3r0nMDmi49GD3ivE63x3b2nOUZAO
         lGB5igjWUC7nSmDzmzLUQy61TnGGXyXSN7UcwTdC+g4aGfKXLFgIbeqBBvN/KEFGCMqN
         b25Q4aiJ1CVNKZe2ne8qKqwfXLcP63fpy54ZL96e4f9ztTWDtNqvDSLzxngwQ1uQlfVL
         XyE9Q3VwG6YeUs4Y4+ranF5CNmAZ/DGbbvfS4B0dL36cl342FvrQu9HuOVYDtJ9UdZOO
         YtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789184918; x=1789789718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5SE/qOas+/SI2EvNxtEJVx4SSxOPMNxV+dkdmLC2H+E=;
        b=pfjWe8bj/9hD624VPmm3BkjoSUkTXp7xg+BdVUes5grb/DkYHE42INEqMqlbFFoj9K
         e4w81cO9kZDLOo6Ur1TZREq3tCNqI1RYz4fWRR/G4gjSm0Hj96rw8JjC9ZEunrAVhGfA
         EVJQ9C3sXAYDr/WTieNI8PMON54+DEaLhVJlF9Zbt9TUdeZrRX0CkrTHAgWFdYVT/8g9
         xM0BXcdb0Vv0NeLskD/y0Lth2MCLPBhzbBuSwWrXH3pDT8nLHCoyOUYorzBgkQHtd36l
         DTXgTusq5f6fy8PKrg93oIHy8kIYD76DLwrNLNRAXj9tYbshVoFIpcUxoE3o+gGjxDeK
         4Juw==
X-Forwarded-Encrypted: i=1; AKwUvByR6FhFTXC1lSMFkRtkgX+PIy5+tNBgW1y7Q9yCNnBZsnElacd65aeOnr4AlB2VZG0NSLkpfPg=@vger.kernel.org
X-Gm-Message-State: AFuF++lKSfkSN9BeER0VVAUFj/jrzQTVZlA+Qx2t+7A22klB6ejZ/rjm
	CVU5639XG5Seq8UsVgO9GSKLJRyAg0XQkEuYZCyUZFltXvkLqFP4M9O+fpiyHocgPQo=
X-Gm-Gg: AYBFou3WLeu2WCw0sRpG+UB5FYnjIBDEUYJbIQsLekqJpjsEgs1q6VzcntfmLiv/852
	pnBl0Sp1Z3s4NhFt/q1ZYI6iHTQvYZE4J3NhpXg0IgGvrMHj75VEzdkTDgzN02y5WrSQm3kvzCO
	ZlmKvS55VKAe9DI7Z6g5RhSsiu98HlEtoj0lkpF02tVGvYacN32l+vtrGz8Ppz+/W9aSudayXJP
	wtjUcMCldsxJhlHEc2OBK/d19sjpNBAmu5QgROWGyv+Ny3pu0sxxBsB9mYuxBlGxkSrJJTfJIH/
	v5E2I0Y22YyB0tOjRTPOG0eWCEH95lCHvH2KVcH7Ce0WBFbhYeHgzmkoAN/Vv0sPjpNDgZAmmNF
	bws0Z4DZzafsBHjkWtcqLURSH88/IndkqGkKJ/SLLj1XkjByjUS3TEsYCPyqJQYUNfKt1cxr4iC
	MO+waV3RIDAB00A4HFvH1yePRSUsd9wIfKj25A8kouJfrry5tFhRH8YvjytdHdUN7/xEVOC+Wj/
	HGzn/7VVKlLxsOdA/b7h9k+cBadJ/J1vELRuebFCG5tBnLvGcPw6KVZnsi6
X-Received: by 2002:a05:6214:29ef:b0:912:289:647f with SMTP id 6a1803df08f44-912121145f1mr108338996d6.33.1789184918116;
        Fri, 11 Sep 2026 20:48:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f494620sm36252476d6.28.2026.09.11.20.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 20:48:37 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	peterx@redhat.com,
	jgg@ziepe.ca,
	sashiko-bot <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] mm/mempolicy: use vm_normal_folio_pmd() in queue_folios_pmd()
Date: Fri, 11 Sep 2026 23:48:32 -0400
Message-ID: <20260912034833.2952750-2-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912034833.2952750-1-gourry@gourry.net>
References: <20260912034833.2952750-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmap a VM_PFNMAP region whose ->huge_fault installs a PMD through
vmf_insert_pfn_pmd() - a vfio-pci MMIO BAR does this - then

	mbind(p, len, MPOL_BIND, &mask, maxnode, MPOL_MF_STRICT);

With a stand-in module for the driver:

  BUG: unable to handle page fault for address: fffff96dc0000008
  RIP: 0010:queue_folios_pte_range+0xaf/0x440
   walk_pgd_range+0x52b/0xaf0
   __walk_page_range+0x6a/0x1d0
   walk_page_range_mm_unsafe+0x193/0x230
   queue_pages_range+0x64/0xa0
   do_mbind+0x25e/0x640

queue_folios_pmd(), inlined above, calls pmd_folio() on that PMD.  The pfn
is raw MMIO with no memmap entry, so the folio lands in unpopulated
vmemmap.  Neither guard stops the walk:

  walk_page_test()         skips VM_PFNMAP, but queue_pages_walk_ops
                           supplies ->test_walk, so it never runs
  queue_pages_test_walk()  honours vma_migratable(), but only while
                           MPOL_MF_STRICT is clear

A VM_MIXEDMAP vma needs neither flag, being vma_migratable(), so plain
mbind(MPOL_MF_MOVE) reaches this too - and there the bad folio carries on
into migrate_folio_add() and folio_isolate_lru().  mshv_vtl_low is such a
mapping.

Use vm_normal_folio_pmd() and skip on NULL, as the PTE loop in
queue_folios_pte_range() already does with vm_normal_folio().  On the NULL
path, retain ACTION_CONTINUE handling for the huge zero PMD.

mbind(MPOL_MF_STRICT) over a PMD mapped VM_PFNMAP region now returns 0
rather than -EIO.  The PTE loop already returned 0 there.

Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mempolicy.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2ad0a5f18280..8fc8a975657e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -667,7 +667,8 @@ static inline bool queue_folio_required(struct folio *folio,
 	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
 }
 
-static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
+static void queue_folios_pmd(pmd_t *pmd, unsigned long addr,
+			     struct mm_walk *walk)
 {
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
@@ -678,13 +679,14 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 			qp->nr_failed++;
 		return;
 	}
-	folio = pmd_folio(pmdval);
-	if (folio_is_zone_device(folio))
-		return;
-	if (is_huge_zero_folio(folio)) {
-		walk->action = ACTION_CONTINUE;
+	folio = vm_normal_folio_pmd(walk->vma, addr, pmdval);
+	if (!folio) {
+		if (is_huge_zero_pmd(pmdval))
+			walk->action = ACTION_CONTINUE;
 		return;
 	}
+	if (folio_is_zone_device(folio))
+		return;
 	if (!queue_folio_required(folio, qp))
 		return;
 	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
@@ -717,7 +719,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
-		queue_folios_pmd(pmd, walk);
+		queue_folios_pmd(pmd, addr, walk);
 		spin_unlock(ptl);
 		goto out;
 	}
-- 
2.55.0

