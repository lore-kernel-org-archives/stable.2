Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646087;
	b=ONK+XO9fstYsCJQYY9nHWxvPXsVV66jPY28EQolebbkF7TWE7UMotxuEtTUOMfDse+r6
	 fP0q2oqV8crtUXMrEq1cWbcvNeTh/Y612mvstidJrU0LtUv2doOynFStDOTCbBEJ1S1E2
	 jWyO1EXsqdMVYc9LAb4FAqsq2ZA/BX8iKMo6g+wfqunTu09hQ9GnPNezEMY791NSWt8l3
	 b1U63XnDuz8hT0BeZ3UGUm/KL8iO6HQ6l9E9UjKpZ/UVYMR39Guz5yB5e5oTGwDlSpD49
	 5WS0G5Z9UdXkdoRAXd3qF/yq6RCk1mQ6imoGYZdgpCrAx5JsZFkqoyEqzDtNqbE+0Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646087;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+7eQOKRTJo3SLTBv1Jd05JmL/1qkaOFv7kkY51zdPi8=;
	b=dVy8OkqJAXS8v7cfTKgEIJxGkgwRGqq2HSPio2DRzIfJH8b7H9YtQBanRyUeXfCMmrSd
	 01W6Itl6zlA5u+ArdzUHpzJDaZtxM8UtBAddq+BJMo890Rk5a8wLdsTmZPnmz8JMlnLo4
	 Ai8rg7ist8JZh5XtZCNyh1UgBRHGj1N4grEIymOgeYZN8RwgAxzjq70NSsR/ahy1e6qOk
	 yMZASnzXcXTJX3XoH8hGKG2ALtqxG57wpnNq8LR/l8aBtxnye1CMNni/XDYFHryC2+R9C
	 jG74x0qQpbHeDy+lbYvK5j8na0eTPy+H5z+sMdORiGCdFsp74Dc4HxFNYNqFfPmoEQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XS55ov+z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18591606A31E;
	Wed, 25 Nov 2026 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XS55ov+z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2211F000E6;
	Wed, 25 Nov 2026 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646086;
	bh=+7eQOKRTJo3SLTBv1Jd05JmL/1qkaOFv7kkY51zdPi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XS55ov+zqWoVcnX4hPssMBTYab88z/dEVQhSp3UYfJX8JimTbKs5+14jIjxvktxOv
	 CmlOhqWq9d1GIPrDcgOgRzNHTg8A3LxMHspSf/h5cRwVX6dtsWLHSuoOpPTMx8BvPT
	 oq2zzO3tNyTrWvrlilSG99kw0BF0O/NLxKEbdUCu1ilDUwNsfHqdzGfK/A5S2m421W
	 T2sXkbyk++z1LuqN9xr2ENeAhfGOHOfH9RHjWJR/foZBRcfqGR5TYBkVN9XlqsMIN5
	 cdGugAAMR9VWpn0gbVllfwqz2SQq8YbbzPeRJjEEOnozWftq+AqrVFTPeVxGLKQ4RZ
	 NW+RVHKlnx0SA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:03 +0100
Subject: [PATCH 05/21] mm/hugetlb: free surplus folios of other nodes on
 free
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
Message-Id: <20261125-hugetlb_fixes_2-v1-5-db27fd2f71a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4706; i=david@kernel.org;
 h=from:subject:message-id; bh=TlH3URFqdFZZwxSAcYE/TmvkYUeArrst3wv1uC1N/aE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1QuVaQ35Nxa47v6yKM3ry7+KD2/+/fnD4kF0r/sc
 mRls38od5SyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjAR86sM/8uXxx5IUmJRTX7w
 t1Xwv872I9vuthqXPZlyhuetpMv0Fc8YGV5vluE/H3auWvxGi+Gfnh95bAW7+B4bmR1iXz2DY6I
 jOxMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Surplus hugetlb folios are accounted per node, but reservations are
global. When free_huge_folio() frees a hugetlb folio whose node doesn't
have any surplus folios, we currently keep it as a free hugetlb folio.

However, we might then have surplus folios on other nodes that are no
longer required for the global reservations.

This can be reproduced with two NUMA nodes, nr_hugepages=1 on node 0 and
nr_overcommit_hugepages=1:

 (1) Allocate the single hugetlb folio on node 0 from the pool.
 (2) With MPOL_BIND to node 1, mmap(MAP_SHARED) a hugetlb memfd that
     needs a single folio. This will reserve + allocate a surplus folio
     on node 1.
 (3) Free the folio from (1).
 (4) With MPOL_BIND to node 0, fault in the folio of the memfd, which
     consumes the reservation and allocates node 0's free folio, and
     immediately punch a hole, freeing the folio without restoring the
     reservation. Node 0 has no surplus folios, so the folio is kept.

The pool ends up with a free surplus folio on node 1 that nobody
reserved:

  HugePages_Total:       2
  HugePages_Free:        2
  HugePages_Rsvd:        0
  HugePages_Surp:        1

Let's fix it by freeing a surplus folio of another node when
free_huge_folio() keeps a folio whose node has no surplus folios, using
the same rule as for the folio's own node: the free folios cover all
reservations without it.

With this fix, the surplus folio is already freed in (3), as the two
free folios then exceed the single reservation, and we correctly end up
with a single free folio on node 0 and no surplus folios.

Note that the freed surplus folio might have been required by a task
that was bound to that node. But we don't care about that: reservations
are inherently not NUMA aware, and anybody who needs guarantees on
specific nodes has to preallocate, like QEMU does, for example.

This has low urgency.

Fixes: 7893d1d505d5 ("hugetlb: Try to grow hugetlb pool for MAP_PRIVATE mappings")
Cc: <stable@vger.kernel.org>
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c67f9bc3fa3bc..0f3db932266d7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -142,6 +142,8 @@ static void hugetlb_unmap_range(struct mmu_gather *tlb,
 				unsigned long end, struct folio *folio,
 				zap_flags_t zap_flags);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
+static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
+		nodemask_t *nodes_allowed, bool acct_surplus);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -1760,6 +1762,7 @@ void free_huge_folio(struct folio *folio)
 	struct hstate *h = folio_hstate(folio);
 	int nid = folio_nid(folio);
 	struct hugepage_subpool *spool = hugetlb_folio_subpool(folio);
+	struct folio *surplus_folio = NULL;
 	bool restore_reserve;
 	unsigned long flags;
 
@@ -1808,19 +1811,35 @@ void free_huge_folio(struct folio *folio)
 		folio_clear_hugetlb_temporary(folio);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_hugetlb_folio(h, folio, true);
+		return;
 	} else if (h->surplus_huge_pages_node[nid] &&
 		   h->free_huge_pages >= h->resv_huge_pages) {
 		/* Free this surplus folio that is not required globally. */
 		remove_hugetlb_folio(h, folio, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_hugetlb_folio(h, folio, true);
-	} else {
-		mod_node_page_state(folio_pgdat(folio), NR_HUGETLB,
-				    -(long)pages_per_huge_page(h));
-		arch_clear_hugetlb_flags(folio);
-		enqueue_hugetlb_folio(h, folio);
-		spin_unlock_irqrestore(&hugetlb_lock, flags);
+		return;
 	}
+
+	mod_node_page_state(folio_pgdat(folio), NR_HUGETLB,
+			    -(long)pages_per_huge_page(h));
+	arch_clear_hugetlb_flags(folio);
+	enqueue_hugetlb_folio(h, folio);
+
+	/*
+	 * This is not a surplus folio on this node, but we might have surplus
+	 * folios on other nodes that are no longer required, as reservations
+	 * are global and surplus folios are per node. So free another folio
+	 * instead.
+	 */
+	if (h->surplus_huge_pages &&
+	    h->free_huge_pages > h->resv_huge_pages)
+		surplus_folio = remove_pool_hugetlb_folio(h, &node_states[N_MEMORY],
+							  /* acct_surplus= */ true);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
+	/* We might be in atomic context, but freeing might need vmemmap pages. */
+	if (surplus_folio)
+		update_and_free_hugetlb_folio(h, surplus_folio, true);
 }
 
 /*

-- 
2.56.1

