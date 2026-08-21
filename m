Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F4397E96
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323810; cv=none; b=BorD4wl7puup6ma+2EhFDGBp17ADs2E2kxjjCxDnYkkQrxpkGVwUQp3DDUpqZv0HVH7F6FkLGeL2yK3p67eNEOc3Sq9h/mys3slNdJayVlMNCDLpSC5/y3YzLr+N50WzNzZ6/RO6h21dOrC1Qfc64cC3bq1ehExktTzeGM7/Wso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323810; c=relaxed/simple;
	bh=3ccu2HigfgWBB9U+SNgXKO8NWiZvt5CXi/rwUSTZJRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edXhPUc+dfw5idNcw+T+uBUqIs1BSnGbUOWncOpWwVJztPOWKwEMgP+CHUns/LqRwlyDBZ8hTxvj4A0oJOt/uKBiHuMs6JtBXF26hU9kYmWOZ2dcORXg7L9T168XyPtBjdA28pPXSCxfJCOlF4vt6SUf18ul79raQ6eqYteVwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SFgF1uUo; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SFgF1uUo"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-936623c6dd3so137067085a.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787323807; x=1787928607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YBxF99leEnpt7qYGsswqI3Af5X25GbnSBysudSQY9XU=;
        b=SFgF1uUo2s1on3oIidEsRW/f/moAJnQBVLhefgVWSbRKyaSBVxYfxgfh40eLa9Rzwf
         IiV8IeZceZyVgZjJKjzDGUjlbqu07svw1GhnBjpI7lpPLv8R1iy6qGDDk81TNJMZ7B4H
         sz7jhTgWujVe3L4Uh2Gl7I5e5vQ075r5S8IHv1W2DnpHJyamk2T204Czm4lk1wclhno6
         ZDdeytzxKS8qxi6NXrpUVdY+MYXglPUhU8Sm6KcDX8427iO/R3WKTkFcGrvF6ATruwqS
         TNdUhUIw+hTLnhhkv2kRWwjKHU9XZh1r6KJ/vMVcG10pXUVYkPqqGz2TSHXe24CJG07W
         5H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787323807; x=1787928607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YBxF99leEnpt7qYGsswqI3Af5X25GbnSBysudSQY9XU=;
        b=mmpBAlQfcXkoTG3GwkAnXwjm+JAYVzJghI+YFSRCXraQeSKmMpdShBS3W9MQ9eOsLh
         7Dg4aEa9YcO7IQNaHb8gWJeuDcKwO5ZBy4lAJScnK/fmuMt/JF79WINHvDqiy2uJsMEw
         0g+d3RxXBepdzh8EoYu/YSySw8Vb/nfZC5oIiJkKFRczEJyF3gNVRD3KVlsTfQxXWPeM
         Yb5a/LoYrv0fdjxI067UH6GhC0TRjgueAYIm7opNoOS2NEk7SkhkegX6AxZJ0esU4b5X
         yeUIp+PeMn+M992mb1Yz34pWQSpoIUvI0ePP0HjlVWGDkdrLQ9cYnwbvnvPZXKhcaF+4
         y+aw==
X-Forwarded-Encrypted: i=1; AHgh+RpjQkrgheRfIMYyLMm3Zv85KtesLQ+h9Z8NYaHU/GbLAKr70UjRpDbKrj9ZmyRGUe8bEHexRpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV8BaN/9SymZb2NkOhePBtmhen0GfU0KFXs2Kq0fxPYFj+SUPK
	Wxj5LtkZY5XVj0SSQDasn1yeupZE711sYJSHKBXn3H9oOjaKMSTL81+gM8ptn0RBzck=
X-Gm-Gg: AR+sD116Va1XAkFBOYyXrkfxppT6c2mqhiRCLgUhpbb111shj4jgqvAMjcn9vgTZxat
	2a2iwaFd83jpkggZ1geK0TtMRfLZRocuLZYccFFUhSGY+fm35o7bwzHOxifHQimEQSgDjbnNdSW
	T9dhXPWzoVC6q5z4LlfKuQRHOcuXlDTh3ZDtgEOQF/XDzx6C6nZtfn5VUSF3BpBHmHWacCvBiJH
	lT8t+V++pf5wQHG8NiA2xsRyxxN/hQSIfXLEzwMUO++xc3EmJ+GFQJ/Z0znuEbdfgZEELt4zfc9
	HZFbMjQ9vhkNeQQ3uK/kLdXTbiNKLWZ5dPE2lywRUKxKXaEiaFRjna9Pap1/4iIAKL+KYbGwYC/
	mYMwIXT85UU+K8vnC447Gr+8d+2GsppEqi7cYKNfEdzeU3X8zsqZQ//qdIdQgk2eb47Zk9GCHfp
	vWSOiAMFLFfZIyvjtA67ZYPoDGyPrPTk1k1z+U+ujR5sAsOnamJfZAdGPCTGHsMXw7AL8/azpzd
	Ma6eVJaCBJ0pwsGEt9F9LUmRg8gHrxzz1UzTrdOf+hWC4Y1nx83cjWO1apQ
X-Received: by 2002:a05:620a:44d1:b0:936:e84a:b983 with SMTP id af79cd13be357-9373977c305mr408285485a.6.1787323807059;
        Fri, 21 Aug 2026 07:50:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720493f35sm609512385a.9.2026.08.21.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:50:06 -0700 (PDT)
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
Subject: [PATCH 1/2] mm/mempolicy: use vm_normal_folio_pmd() in queue_folios_pmd()
Date: Fri, 21 Aug 2026 10:49:46 -0400
Message-ID: <20260821144947.167382-2-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821144947.167382-1-gourry@gourry.net>
References: <20260821144947.167382-1-gourry@gourry.net>
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
queue_folios_pte_range() already does with vm_normal_folio().  The huge
zero PMD moves ahead of the lookup, since vm_normal_folio_pmd() returns
NULL for it and its ACTION_CONTINUE would be lost.

mbind(MPOL_MF_STRICT) over a PMD mapped VM_PFNMAP region now returns 0
rather than -EIO.  The PTE loop already returned 0 there.

Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f1aba551f9f1..85803c845965 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -650,7 +650,8 @@ static inline bool queue_folio_required(struct folio *folio,
 	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
 }
 
-static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
+static void queue_folios_pmd(pmd_t *pmd, unsigned long addr,
+			     struct mm_walk *walk)
 {
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
@@ -661,13 +662,15 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 			qp->nr_failed++;
 		return;
 	}
-	folio = pmd_folio(pmdval);
-	if (folio_is_zone_device(folio))
-		return;
-	if (is_huge_zero_folio(folio)) {
+	if (is_huge_zero_pmd(pmdval)) {
 		walk->action = ACTION_CONTINUE;
 		return;
 	}
+	folio = vm_normal_folio_pmd(walk->vma, addr, pmdval);
+	if (!folio)
+		return;
+	if (folio_is_zone_device(folio))
+		return;
 	if (!queue_folio_required(folio, qp))
 		return;
 	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
@@ -700,7 +703,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
-		queue_folios_pmd(pmd, walk);
+		queue_folios_pmd(pmd, addr, walk);
 		spin_unlock(ptl);
 		goto out;
 	}
-- 
2.55.0

