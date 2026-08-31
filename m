Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904433B9935;
	Mon, 31 Aug 2026 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215249; cv=none; b=OqqIEKNfhBRYRk98q/gt/nO+HnxdYIwi0+2r97AOgifFxsfwkMJO62WtXucqxU/Qzqlx/xDaRrlyQEeUKcTIODA6cScIlfOK1b5qRP+VeOK+FvJg968eZs6XP2Eu0SaifUlzC9qIBjKPTacGoyGbTxKR/Hl9xrO4Gxtxy1b0ao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215249; c=relaxed/simple;
	bh=6oo89sq1e5N95tbas6tgL3DxcdgEVw64/H8U3kE7PzU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e3NNWQTzAPETllmwsZrvoCN7mYH+rvg/UK19fG+/YejsAA6o4pyITjJ8fUoX7Q7jq3unw3Mn/tM2jMdX7K5jmblCYoa8ATn8osRv0jf4qKOJjsENS3O9zA5/ilaQgHc/SX0XDD5OlwRougUpEPpfKAK2myZTZoQ4A8KDU9yOFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B+9NZgEl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=amjPOCCb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B+9NZgEl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="amjPOCCb"
Date: Mon, 31 Aug 2026 22:27:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788215245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDGGUbyfoSkp70iDKtZIub3eQ2OYAGu0OydE6xJYb0E=;
	b=B+9NZgElWxvXE5DgrEZQNsZZ1L8g54d/ZCsoXM8eoEaLq2W1aXnYO/wB4uxVSJUyEXCCcD
	4RsYWoa8ttWdyBbkQ84mkh4hGxjKntN7fgASbmOqxXbfmKtZ9MVIYAkPP/BD/B9raF6cDD
	sTwnJPjKwt18aFPsgRQOpZxs004KTEJPdjuM+C6fsThxQLckuFsBk1HkWhtRQlDnNmkhjt
	mWfYHwBptQah2LFBSjsTTl6kNWy7vVjQ0oQu0HdNszmbSznxieBR7IXfW4msAoyg6w2Pgp
	oZUAUPbVnSn9TVMGO11Ay/3B61DcvhtjXXn+SMdroSSR2DMj7x8MtQtoRBeeMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788215245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDGGUbyfoSkp70iDKtZIub3eQ2OYAGu0OydE6xJYb0E=;
	b=amjPOCCbP5W4sNmLKw/qGQjSEzz73H405GTLos9xk0GrTXyrXw/b5V+uaqgyle46jb+Oin
	nfXjcP6sslJO/mAw==
From: "tip-bot2 for Lorenzo Stoakes (ARM)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/pat: Allocate split page tables as kernel
 page tables
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Vishal Moola <vishal.moola@gmail.com>, Atish Patra <atishp@meta.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260813-cpa-fixes-v2-4-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-4-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178821524388.3717435.5145521479628547195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     83a2490f0f1e173bb10f0d076a546cf1cd36f609
Gitweb:        https://git.kernel.org/tip/83a2490f0f1e173bb10f0d076a546cf1cd3=
6f609
Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
AuthorDate:    Thu, 13 Aug 2026 12:01:27 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 31 Aug 2026 15:17:53 -07:00

x86/mm/pat: Allocate split page tables as kernel page tables

PTEs are allocated directly without going through the standard page table
allocation routines such as pte_alloc_one_kernel() when splitting a large
page in CPA in __split_large_page().

This means the page table constructor is never called nor is the page table
marked as a kernel page table.

The former results in the folio associated with the page table not being
marked as a page table (__pagetable_ctor() is never called thus neither is
__folio_set_pgtable()) nor are statistics updated to reflect
it (lruvec_stat_add_folio() is never called).

The latter issue of failing to mark the page table as a kernel page
table (ptdesc_set_kernel() is never called) is far more problematic.

Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
tables") kernel page table freeing has been batched and since the
subsequent commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries
for kernel address space") IOTLB cache entries for kernel page tables have
been invalidated upon being freed.

Since split page tables are freed without this invalidation, the IOTLB can
contain stale entries for them.

Resolve the issue by using the ordinary PTE allocation API at split time.

This results in these kernel page tables invoking a page table constructor,
and thus requires a page table destructor.

Since page table destructors are not always present (early allocated direct
map page tables are not marked as such), conditionally call
pagetable_dtor_free() if the PG_table folio flag for the ptdesc is set.
Otherwise, free the page table via pagetable_free().

Regardless of which path is taken page tables marked as kernel page tables,
which now includes split page tables, take the correct route through
pagetable_free_kernel().

There is a user-visible side effect in that split page tables will appear
in nr_page_table_pages in /proc/vmstat (as do other kernel page tables
allocated after early boot), however this is a positive change.

This issue started being markedly problematic after commit
5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables") so
choose this as the Fixes target.

[ dhansen: changelog tweaks for tip style ]

Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Vishal Moola <vishal.moola@gmail.com>
Tested-by: Atish Patra <atishp@meta.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260813-cpa-fixes-v2-4-39b4ff90f91d@kernel.org
---
 arch/x86/mm/pat/set_memory.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index cb5d6d6..4652487 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -441,7 +441,15 @@ static void __cpa_collapse_large_pages(struct cpa_data *=
cpa)
=20
 	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
 		list_del(&ptdesc->pt_list);
-		pagetable_free(ptdesc);
+		/*
+		 * Only early alloc'd direct map should not be flagged PG_table
+		 * here and those shouldn't be collapsed. However be abundantly
+		 * cautious and handle the !PG_table case too.
+		 */
+		if (PageTable((ptdesc_page(ptdesc))))
+			pagetable_dtor_free(ptdesc);
+		else
+			pagetable_free(ptdesc);
 	}
 }
=20
@@ -1134,11 +1142,10 @@ set:
=20
 static int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
-		   struct ptdesc *ptdesc)
+		   pte_t *pbase)
 {
 	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc =3D 1;
-	struct page *base =3D ptdesc_page(ptdesc);
-	pte_t *pbase =3D (pte_t *)page_address(base);
+	struct page *base =3D virt_to_page(pbase);
 	unsigned int i, level;
 	pgprot_t ref_prot;
 	bool nx, rw;
@@ -1238,20 +1245,20 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte,=
 unsigned long address,
 static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 			    unsigned long address)
 {
-	struct ptdesc *ptdesc;
+	pte_t *pte;
=20
 	spin_unlock(&cpa_lock);
 	if (cpa->init_mm_read_locked)
 		mmap_read_unlock(&init_mm);
-	ptdesc =3D pagetable_alloc(GFP_KERNEL, 0);
+	pte =3D pte_alloc_one_kernel(&init_mm);
 	if (cpa->init_mm_read_locked)
 		mmap_read_lock(&init_mm);
 	spin_lock(&cpa_lock);
-	if (!ptdesc)
+	if (!pte)
 		return -ENOMEM;
=20
-	if (__split_large_page(cpa, kpte, address, ptdesc))
-		pagetable_free(ptdesc);
+	if (__split_large_page(cpa, kpte, address, pte))
+		pte_free_kernel(&init_mm, pte);
=20
 	return 0;
 }
