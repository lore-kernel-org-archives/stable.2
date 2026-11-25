Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646167;
	b=RTupVzVTH7EIkAHZucXw/8a280iSortKyjBPyHyNV96t/yBiVYdiZB57p7BBDnZyb7ER
	 FWEJqHerSj6ueR1pAU+bknahH/J3dlXQdhxvlefmOqrcoK+T5Id92ZQUzcthXYg6nHzeg
	 ZgZKl99wO5BhGU4IuCnT2+dXC3hryUIqj1HR+JczTD6xYFqfusiHJNsrmmeOx0EYwUzuh
	 7VEu6bggoPb3pfVOPaQcKnOUAWyxrB+FVWKmnVL1Ib/S0wquSWffxTrzgOBksK1Rd1IJG
	 aKDQypmwZCsEVV9X7mdj6uOzFaAeL6Yp0OdIXyOjGt0gKCjdwCGuifKwNkO23GPEC/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646167;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=p1rYByMhz0KjcnKxiH/WuOpBmwN+k1Zzr7v4FN4dO+g=;
	b=cZTr8wwP1LK1ll20/gl5q56ECp9y1dIVYcbFfLavpFPr7fnT0QuAhIGyjOOHlrEkZhum
	 GKu0W0sYIgL6RQIuxvPpAwRJrfWNxGmIoHvQoEiUHoq0h+2JAuYnEWNWXQrO0tJbCNNn2
	 GAwK6FyQ6TL9pA5vGCvNT0iIblM5BB8UATCdviIbCzqbRa/fMC03Ce784/dF+rmDinZr/
	 fl4gYK6zjlv1Mhh43q5T1WVnZJ++R20fQ7h8A3SWxo5KKc7vIvRLxWOCPakJuP4TdvaNE
	 NOMX4RcJUVeSMVs2sB6qD/ggHcIxkJnXdLtcr5QG/PXMYBCvfeabGfKeCvLzzfLWg2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1yDptkd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06178606A321;
	Wed, 25 Nov 2026 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1yDptkd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AFC1F000C4;
	Wed, 25 Nov 2026 22:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646166;
	bh=p1rYByMhz0KjcnKxiH/WuOpBmwN+k1Zzr7v4FN4dO+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T1yDptkdGkhkS4DIxHYWR8qc1deBMKJOGNiY/8Xr9dtoAjuu7hzpJcLvYs/dh5moW
	 aM53gd1HM9rf9K8UIiY+slvhsN2H5X1EvzGOHbSPaBv6wlo7/VANCAznNVbD3oTer8
	 EsLOZULLTDbrBDytJ/eDRNyUjkvmA5jZdsuvtKJIIqmOfbnpIRoPAVYCM/cov6t8m7
	 vIni4++pC828MD8grzV/M/r0dGpUPl4/8MWkeddfXXSn+4AjOjKbHwN4tfkCDdM4fD
	 S06jjQJHPI8hYCdvtWSWmcHddQODiIkcAsjmMpJefrliTd/utiosAWJKwkEAjYuhSu
	 bnsDBqlJ1C1IQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:08 +0100
Subject: [PATCH 10/21] mm/hugetlb: only check PMD table sharing for
 PMD-sized folios
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
Message-Id: <20261125-hugetlb_fixes_2-v1-10-db27fd2f71a8@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3518; i=david@kernel.org;
 h=from:subject:message-id; bh=HG9FVeHkf3r0GJ2DWJD6urls2DRbMkH6Rwt8+2D/97s=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1R6m1me+71ZUHJi1ga2I7lVS1vbHrv2XazSX/Xyl
 P008Xq5jlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACZi9ofhnyVj/g+BQ2/zX7y9
 6fytvlqwhNVJNVlJ49bB5mJPTd6fyxkZdkbM+L3vy4qZibnTnlteatu/4sedOKblnZ1dBrxldq9
 7GQA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

hugetlb_pmd_shared() reads "pt_share_count" from the ptdesc of the page
table that maps a hugetlb folio, independent of the folio size, to tell
whether that page table is shared. Only PMD tables have a valid
"pt_share_count"; for other folio sizes, such as 1 GiB folios on x86
that are mapped by a PUD table, we read whatever another user of the
union left behind.

As a result, such folios might be reported as shared in smaps and as not
exclusively mapped in pagemap, and mbind(MPOL_MF_MOVE) and
migrate_pages() might skip them.

Let's fix it by adding hugetlb_folio_maybe_mapped_shared(), which
combines folio_maybe_mapped_shared(), documented to not care about page
table sharing, with a check for PMD table sharing only for PMD-sized
folios, and using it in the affected callers.

This has low urgency.

Fixes: ca1a47cd3f5f ("mm/hugetlb: fix hugetlb_pmd_shared()")
Cc: <stable@vger.kernel.org>
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c      |  6 ++----
 include/linux/hugetlb.h | 16 ++++++++++++++++
 mm/mempolicy.c          |  2 +-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d2a524c6ad4b9..41b280ab7b19d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1211,8 +1211,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 
 	if (folio) {
 		/* We treat non-present entries as "maybe shared". */
-		if (!present || folio_maybe_mapped_shared(folio) ||
-		    hugetlb_pmd_shared(pte))
+		if (!present || hugetlb_folio_maybe_mapped_shared(folio, pte))
 			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
 		else
 			mss->private_hugetlb += huge_page_size(hstate_vma(vma));
@@ -2131,8 +2130,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 		if (!folio_test_anon(folio))
 			flags |= PM_FILE;
 
-		if (!folio_maybe_mapped_shared(folio) &&
-		    !hugetlb_pmd_shared(ptep))
+		if (!hugetlb_folio_maybe_mapped_shared(folio, ptep))
 			flags |= PM_MMAP_EXCLUSIVE;
 
 		if (huge_pte_uffd(pte))
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0d5414392d870..49dad5ae57512 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1386,6 +1386,22 @@ static inline bool hugetlb_pmd_shared(pte_t *pte)
 }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE
+static inline bool hugetlb_folio_maybe_mapped_shared(struct folio *folio,
+		pte_t *ptep)
+{
+	if (folio_maybe_mapped_shared(folio))
+		return true;
+	return folio_size(folio) == PMD_SIZE && hugetlb_pmd_shared(ptep);
+}
+#else /* !CONFIG_HUGETLB_PAGE */
+static inline bool hugetlb_folio_maybe_mapped_shared(struct folio *folio,
+		pte_t *ptep)
+{
+	return true;
+}
+#endif /* CONFIG_HUGETLB_PAGE */
+
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
 
 #ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6f800fb961aec..229efcdb2c7db 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -833,7 +833,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	 * cannot easily detect if a folio is shared.
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) ||
-	    (!folio_maybe_mapped_shared(folio) && !hugetlb_pmd_shared(pte)))
+	    !hugetlb_folio_maybe_mapped_shared(folio, pte))
 		if (!folio_isolate_hugetlb(folio, qp->pagelist))
 			qp->nr_failed++;
 unlock:

-- 
2.56.1

