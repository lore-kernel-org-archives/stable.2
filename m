Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646056;
	b=YdvcLY9p12HLfFi0YoRwml/gV0RA2Lq1Jwbkxp/qnraK1V0Lgn7qwPXcxlb9U+Kk7vqB
	 AcIJz4KljvOqV5sKBfmPUP/wM1PvqNatoaa+fmvx32wL8g6itPjst1b6etyxK4/F9KiSZ
	 N/YwqAfLRU/+DyUkWqVQtUqfgMSNo70OBvoLdXqafi15AMr5vCLKlsHI9vQXNOrU6AMh7
	 i15gUWTqRqpjQzGyYZmjqpA4d21dLKWHgO4UNdOl0A5egOeibkCdv406PSu+NifWnbHp7
	 7SgXQ470XBuiNCcrHUsQY6+XN5d8Ygy0ubP0Ifh2KUCEmbCqk0ju3m2ljTR8PYowgSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646056;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=g5KTQLxud4MM88RXDo3FqSzAoKZXRdMPuy6ADShQWPo=;
	b=C3+3HhZbTFdTZL6d8T+L+VhLv6RIYj6QWxIJ5wUlkF+y5ewnmfDnS0caPHwBbUbK4ZM1
	 /zG8vJlQOgQKzsgGCxeC+6ayki4abTR0qZofk9SrvrIa+xqoKzZ0nGd+6aF5Jm37hZrm4
	 kMC2b3A1UIsCF0kdrYuFit8BPLAxcCcsddKDAyk8zuxbcEdZIkxJfcRokK1udbsbUIJU1
	 XR1u+PoLzGCN+OgHz76wzDb9xc8IybmxPCJv5/CSL2FkJe49ui584dLpRsOki5ig12YSl
	 o7Wl6j7WucsmhPHeD9bK6zoekxn/lZbaGWjADI10YzMWl0udRziHWp1pSfh37gogqBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jI5dNcyg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EADE606A31E;
	Wed, 25 Nov 2026 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jI5dNcyg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1366B1F000C0;
	Wed, 25 Nov 2026 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646055;
	bh=g5KTQLxud4MM88RXDo3FqSzAoKZXRdMPuy6ADShQWPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jI5dNcygw5JoHLVr+WCQDJKd7cjgATNHsuB047VXIQSwE5Wroaou0wH/Y06E6IWmf
	 2C8yqmvQhouk22jdODytR75khiQ+WYidt1INQOlwmiLiO7Va1wZqNdCDzWXXGnr6ke
	 8xz4ms0wuo7Ahslp5Su/GBkhg/qgHWFgUDgWXlmJGlW9S0gGQJpPgtG1bxdm0pjhcW
	 MVJ62H52VxGvieCjbr8SgQjk3dYZ1tTM18QI+x5G0gKJ0UT8d1IRdlS7BuqKOzMaG2
	 x1O2md1lea8SQSF/54d4BjiDSXMhDQCPiKM6GFk3hI2UJLZztiOxN38Kb15mum01Rl
	 U3EBQoj312yJg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:01 +0100
Subject: [PATCH 03/21] mm/hugetlb: always mark new page cache folios
 migratable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-hugetlb_fixes_2-v1-3-db27fd2f71a8@kernel.org>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Mike Kravetz <mike.kravetz@oracle.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Dave Airlie <airlied@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>, 
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>, 
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
 "Kirill A. Shutemov" <kirill@shutemov.name>, 
 Sasha Levin <sasha.levin@oracle.com>, 
 Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3980; i=david@kernel.org;
 h=from:subject:message-id; bh=rib6Mtfo04qKbnTXQh7KiSe8aQC79Zys4RDoI0uBy/0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk5TnOi/oVNpx+3aUwfZlJe2+7C4RFkts3KdrLwh6y
 DDLZdaLjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACbinMXIMG2NX7nPvVc2M9j7
 Fad17/3Yr/jyP0u/pNv/E9OtxcuvlDD8dyl6myodaaiTtn9mtWj6f5dg1fyDc82qn0/V2RG4/8E
 XZgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

hugetlb_no_page() and hugetlb_mfill_atomic_pte() only set
hugetlb_migratable for a new folio once they installed the PTE.

If they back out after adding the new folio to the page cache, for
example because the PTE changed or is no longer empty, the folio will
stay in the page cache without the migratable flag set.

Later faults will find it as an existing folio and never reset the flag.
Such a folio can never be isolated for migration, which breaks memory
offlining, alloc_contig_range(), longterm pinning and memory failure
handling.

Worse, if the folio is not longterm pinnable, because it resides in
ZONE_MOVABLE or CMA, memfd_pin_folios() and the longterm GUP path retry
forever on -EAGAIN. memfd_pin_folios() cannot even be killed, which will
be fixed independently.

Let's fix it by setting hugetlb folios migratable whenever (1) a new
anon folio gets mapped; or (2) a new folio was added to the page cache,
like hugetlbfs_fallocate() already does.

This has low urgency.

Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during migration")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d57964914e18a..c67f9bc3fa3bc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5953,12 +5953,11 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 {
 	const bool pagecache_folio = vmf->vma->vm_flags & VM_MAYSHARE;
 	u32 hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
-	bool new_folio, new_anon_folio = false;
+	bool folio_locked = true, new_anon_folio = false;
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
-	bool folio_locked = true;
 	struct folio *folio;
 	pte_t new_pte;
 
@@ -5978,7 +5977,6 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	 * Use page lock to guard against racing truncation
 	 * before we get page_table_lock.
 	 */
-	new_folio = false;
 	folio = filemap_lock_hugetlb_folio(h, mapping, vmf->pgoff);
 	if (IS_ERR(folio)) {
 		if (!hugetlb_pgoff_valid(mapping, vmf->pgoff, /* partial= */ false))
@@ -6048,7 +6046,6 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		}
 		folio_zero_user(folio, vmf->real_address);
 		__folio_mark_uptodate(folio);
-		new_folio = true;
 
 		if (pagecache_folio) {
 			int err = hugetlb_add_to_page_cache(folio, mapping,
@@ -6069,6 +6066,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 				goto out;
 			}
 			filemap_invalidate_unlock_shared(mapping);
+			folio_set_hugetlb_migratable(folio);
 		} else {
 			new_anon_folio = true;
 			folio_lock(folio);
@@ -6151,11 +6149,10 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	}
 
 	/*
-	 * Only set hugetlb_migratable in newly allocated pages.  Existing pages
-	 * found in the pagecache may not have hugetlb_migratable if they have
-	 * been isolated for migration.
+	 * We must set hugetlb folios migratable whenever (1) a new anon folio
+	 * gets mapped; or (2) a new folio was added to the pagecache.
 	 */
-	if (new_folio)
+	if (new_anon_folio)
 		folio_set_hugetlb_migratable(folio);
 
 	if (folio_locked)
@@ -6646,6 +6643,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		if (ret)
 			goto out_release_nounlock;
 		folio_in_pagecache = true;
+		folio_set_hugetlb_migratable(folio);
 	}
 
 	ptl = huge_pte_lock(h, dst_mm, dst_pte);
@@ -6694,7 +6692,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
-	if (!is_continue)
+	if (!folio_in_pagecache)
 		folio_set_hugetlb_migratable(folio);
 	if (vm_shared || is_continue)
 		folio_unlock(folio);

-- 
2.56.1

