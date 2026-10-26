Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056995;
	b=gWA+Romqc6m/o2vldmEfoUkvYdhko1cWQ1Yn1BqAbOjT0ibZbR95my6kjgQcXBbcTImf
	 76AGhiUGokjXaudP3ggS4hBXz0TJDHhi3Sl9a/TbgYxs7R1IEEAtj2H32cJm8BkNOXJC9
	 2Aql7tsgz/g6gIC6aiZfghYQd+PivUUOfnYx8gQFUhcebiGAi5ONcWJ8VmlwC14Hs/STp
	 InQ7slg2JVQS1G0e5P/dkco9haYZUpxkZtcl/kcegiZ2U6JqbFuUtAmkCMXUKW4pHWutE
	 2fEUQUcEjEemQAFiDvRrDVWOpoDodjWJcom035SUHb3j/WD0M7GE5i7pQ46HWl8hyQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056995;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+1JYyOVK17L4M/YeGKfhk/Lxzr76gDTGDeCEv+yAeac=;
	b=1dsryFwg8vdWvQXN/qKI83lpZ1cdO+6+ilgnRhhmKbfVw+E+sEnc/UeDnDreccudzfe2
	 23W9mi8yrectwDpC3hlsZ9PNrHTgsCYF+C6WS6ts6Iv2JIyQiv05PB6kvg+mZH7wgZaFu
	 jXJCJtEpXu9ZtoEq3Jlaz+WBVQii/eapAjyx/WCKOBtPcyXlB4CSIEHpN766M9sPCwIvD
	 rpbAeGWLUNn372ktwZGeiFHUKlA1FEcXBcvcSN8UgPY99OZ8VqHyXG2LYcwuuOwW6JcoM
	 P2+ZyuqdMFcUmIreNAvEnRb4ulz7WCRusF2yJDOrSvcLYZGFqpuRnBsg3tw5ggr3oXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfqLS+Hl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892C606A31A;
	Mon, 26 Oct 2026 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfqLS+Hl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4086B1F01829;
	Mon, 26 Oct 2026 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056994;
	bh=+1JYyOVK17L4M/YeGKfhk/Lxzr76gDTGDeCEv+yAeac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XfqLS+HlbsjgMnNRoaz++2jtQC1Na277NB03VKlGtUyrHgM+UcBK81mvCEQXk6SEn
	 uoUWk/Y0LokQHfua8ALu7xo3TimdxKbFw+ync5x9x0414hpGK5euj90aDiThH/i2g6
	 gltMFd0YkJRSCGbzjhMIA1svIJg0OdjzS+VJrfdV55Ru5CcTX1Km3zOSH9bit+hmH0
	 nXtTvSU+BWI1pGaDlkzv7qX0PMn63J0KkAM5JF7EYYmHtIGdHKXb/weVqb341vnhNN
	 LtvoefAcxQzn7M5h/ljiIxS0k3AY0Dobha0DvHSvTN45tBuUaJN6bUn9HpN5iNYDaL
	 BChgtuF/TGxrw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:37 +0100
Subject: [PATCH 17/46] mm/khugepaged: preserve dirty bits when collapsing
 PTE-mapped THPs
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
Message-Id: <20261027-fixes_core-v1-17-6f74bec9a5bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036; i=david@kernel.org;
 h=from:subject:message-id; bh=/nGuewYAfnIDGwfYFGkywdM27AcdGHIuhx2sh7J1pmM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/6OOtCmHDt6RCT9t8MvwO2SXtqiyk4FhS5aFTuX
 MPD2Pu4o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgInszmf4Z8e1UOzQzKxPdqpf
 L849defDtaQtSYFsyhXzPZYxX3zefZDhn2bE7/KyvsKAtbrnVr0+WPQz3O36FpVnmdnVGpfN+PP
 n8AMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
bits to the folio. A shmem read fault can map a clean folio writable, so
a later store only dirties the PTE. Losing that dirty bit allows reclaim
to discard modified data.

The assumption that regular files are read-only is also obsolete since
commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse
for writable files"). In any case, transferring PTE dirty bits to the folio
when removing mappings (and while the folio is still mapped) is the right
thing to do.

Use get_and_clear_ptes() to collect the dirty bits and mark the folio
dirty before unmapping it. Update the comment.

This was reproduced with shmem using MADV_COLLAPSE followed by
MADV_PAGEOUT.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: adjust comment; simplify description; cover file-thp as well ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 04d9bb21ff524..dd17c3dae8006 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1995,9 +1995,10 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 		/*
 		 * Must clear entry, or a racing truncate may re-remove it.
 		 * TLB flush can be left until pmdp_collapse_flush() does it.
-		 * PTE dirty? Shmem page is already dirty; file is read-only.
 		 */
-		clear_ptes(mm, addr, pte, nr_batch_ptes);
+		ptent = get_and_clear_ptes(mm, addr, pte, nr_batch_ptes);
+		if (pte_dirty(ptent))
+			folio_mark_dirty(folio);
 		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
 		nr_mapped_ptes += nr_batch_ptes;
 	}

-- 
2.43.0

