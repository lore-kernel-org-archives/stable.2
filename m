Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056919;
	b=lI/tUqUiyUpFca4xr4vRQgkpYZtjjTVmzjS3CAI0KvJBCx7KadfIpDx97JKvg3VEMVoB
	 aLXehIi3z0XNnQD001YE6XVMkETJpJZUhh6NNlP+JYI6lWyd6DyV6L84gR9059+FHAqKD
	 egxuYhdM0+74+8ov02l0FuckyqpoDk+Qf60PYnZYE4Echb6AY2tknLrFBzA3O/Wf4V4dK
	 Bln4vLxYkKbXU6qFOQ0T6y7tPivTL190tzzMC2F252sv0jEZt7/yj0hOL468ve/zpA7F3
	 yFLYgpKT9iWmJIY70LuxokT0Y6Glu4EPt3UMLKkY4EP1h6KrxNXlU4Blu+mRE3TzDlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056919;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+MnAvX+qI+mYQxA2fVfQg376k8J/xzQVFinnmk0GIyE=;
	b=yF4W9GZyTasdzEUqYBagfgYtY5QPbFjyai5xXprA+JxgayHcSZqk0Pc9AA45zcAVNrAx
	 4glp97VabxoMTmnLGsxk4653wuSxbWqQt2qoT+zBB5qekWAotafhesdBO2TAWiDufwvry
	 Hbtp99hmbyr2NK/u98ySep0lnDDla64/ZsT5LHzaTeYt+BAU8wbr8qXHhzCh7d3vl3Gse
	 iBq72I/OVQnU7PggkFkFRb3VUgbLzge8RDv1q9xLC5bXiFvmZ3gZP98HExNOlY+RgJXkR
	 58mL/WjtS5FGYvqaj2TARYCqs4U6pBcWaqUG8VZPPm7EzhgjGtP4HDAJdPGym8Lc1Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eh+x/TWR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5A606A31D;
	Mon, 26 Oct 2026 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eh+x/TWR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C2A1F031E0;
	Mon, 26 Oct 2026 23:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056918;
	bh=+MnAvX+qI+mYQxA2fVfQg376k8J/xzQVFinnmk0GIyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eh+x/TWRFS/iJ1o5pPJTPgSPhjIqgQS3EpnhiXcdC9m89yLc/rPs+Ad+DvKTl1fG9
	 NRD+KHiMvg3Fzyf/Biyf6XapfStao2hkfGuVGecEOmPxP8jclyVfkwrKJruvRdUs+b
	 jgvMBNz+MQPmFzhlPEUeSLiIlV1kPYlpWFUelDXGXk0JoUAD6JwZqJlTU62Nccn1oR
	 Ish/vEaxWz1T3FoN8J0XkU0rKmk3p37d0dFOsvpnab3UoD9KeVrVEvHAMpSewlf2oV
	 k4+XinYlqn4Ci8QY+xQlfrqejBbu4gtWkoxgMIe7o06wca6Os8beRZYY8j96gLJLvQ
	 h/YnvNHUxuzcw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:33 +0100
Subject: [PATCH 13/46] mm/huge_memory: fix truncate racing with PMD zapping
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
Message-Id: <20261027-fixes_core-v1-13-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=david@kernel.org;
 h=from:subject:message-id; bh=lNkOF7790rj6TmUsBd+4scX6XFv84q64jJb19qNwUOE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/yUmPX2heKb2tWBnBHR7/sl4lR76kT65hrKpod8
 jbVfk5yRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABNx8mb4H170dtHjpOPPY/IK
 t/y9WbzDQ3XOugP26i8L/Wec3XLw5QVGhgv5CutulWXVTX7GdSZnmW4UC+tXA8OLM+w6eS23l7s
 EsQAA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
If this was the last mapping, truncation can skip unmapping the folio
and proceed without waiting for the PMD lock, racing with dirtying.

ifs_set_range_dirty() can oops if MADV_DONTNEED races with
ftruncate() on XFS, when we get the folio set dirty after it was found
to not be mapped anymore.

Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
matching the PTE zap path. This keeps the folio mapped while updating
its state, so truncation must wait for the page table lock.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify comment and description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b31a425c7a32..eda020dd6e33f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2495,6 +2495,14 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 {
 	const bool is_device_private = folio_is_device_private(folio);
 
+	/* Transfer young+dirty while the folio is still mapped. */
+	if (is_present && !folio_test_anon(folio)) {
+		if (pmd_dirty(pmdval))
+			folio_mark_dirty(folio);
+		if (pmd_young(pmdval) && likely(vma_has_recency(vma)))
+			folio_mark_accessed(folio);
+	}
+
 	/* Present and device private folios are rmappable. */
 	if (is_present || is_device_private)
 		folio_remove_rmap_pmd(folio, &folio->page, vma);
@@ -2504,12 +2512,6 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 	} else {
 		add_mm_counter(mm, mm_counter_file(folio),
 			       -HPAGE_PMD_NR);
-
-		if (is_present && pmd_dirty(pmdval))
-			folio_mark_dirty(folio);
-		if (is_present && pmd_young(pmdval) &&
-		    likely(vma_has_recency(vma)))
-			folio_mark_accessed(folio);
 	}
 
 	/* Device private folios are pinned. */

-- 
2.43.0

