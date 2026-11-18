Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993705;
	b=Fx5CVNFimDVUYnLFSb6YpOhO77fyihJpehX6uTTcS0eyreOFznCGEVb8vxUAff892hZF
	 vmpX7+vzDxRJ0v9TnIJ/s4Lnz6P9Yt8QUSzdK2Ix5RzaGGkjaBN3BmOY45F4OC+YOFaex
	 n91efU+lFTJegdVu92pgZLdCGfzGVl0g40Th56WHe/AtdhbA2VtuoSIgVOnlit1mM4T+a
	 NVPl+8atdavYtr6At+R7k4NCUMYQTF6VLAsHwjvj/K19phZcxZEPfarNl1gDAsZJC1uUg
	 K3NgnWRVgKkCyNcJVOEmf9yHufr30/3JgWCGgdLhl+SnKYkpJZdXfHarAjuC69/pyHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993705;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+A+DaVuQhI2BpuaRmABmCIOJxadlMBJlLIpCJggjeU4=;
	b=F5zpFTAjkCiLAboIJqNDAMgH1qzUQyk8FeGrZicsPQ0701rKdTBxdoPpWE10Y5Be54Ap
	 qvvv54oT1g04OOpDKRmll83bl6RW3fl4LjR5AIUy1Ct00jaO0DC32dpjzrC4m9p9IMF47
	 /98zwNERtpvVQ7Lxw5y3IJFkrmhSS+r2NhlrkwreW03O8QdF/rzKHOruD1cqEzAMrC6ch
	 3blP4VuudEI6FT/LlQ/0jQ+FpDf7kS71eOk+xELZ0PNco9XzWNQG5mNwvxfD6F3HcF7C5
	 bR2gKEW5nwqm57HMKE1g0pmdzX7Ea6UnTtpHGa1gGgACZrCIyvpOzziBzx/lbjL4taw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgJTmamX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F3606A31C;
	Wed, 18 Nov 2026 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgJTmamX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0FC1F000C5;
	Wed, 18 Nov 2026 09:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794993704;
	bh=+A+DaVuQhI2BpuaRmABmCIOJxadlMBJlLIpCJggjeU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HgJTmamXcwBkMFxTwdykgx7KqlV4Ktekk+Qe4xLRjXPqboOoKSeqoYV1GFf0OMUF5
	 JtAOInPU+60WggS4ut7zIKa/dJvBCN15zcdvLrgv9vkstJvQztZ//S/nbx+Be6iJ1C
	 6bCELygGMS95/1npJTaM+YkIKoIlPq/peyKQ6HFiIoZ7oMAhfHRk5tyW32CiA4KwEb
	 cDGHj6o/mpIlqUubU4B5a8o0cIR603JITxUdlkNzYSYuKJkYaraWeIaUYThmJSWaFO
	 G9KEPEIIfhfk+6wnnqOO6c+6+3om+zsg/F8BNc3Wwv/ZJa/HGwIzq0J3DYwpHIDxnE
	 7D9oYQZyeWB0w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 18 Nov 2026 10:20:38 +0100
Subject: [PATCH 3/4] RFC: mm/rmap: don't defer TLB flushes when unmapping
 lazyfree folios
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
Message-Id: <20261118-file_folio_flush-v1-3-e9e739ed14e0@kernel.org>
References: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
In-Reply-To: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, 
 =?utf-8?q?Cenk_Y=C4=B1lmaz?= <cenk@deepfinresearch.com>, 
 Zhang Peng <zippermonkey@icloud.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
 Mel Gorman <mgorman@suse.de>, Sasha Levin <sasha.levin@oracle.com>, 
 Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
 Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3960; i=david@kernel.org;
 h=from:subject:message-id; bh=ONBH5D/i+VTsWjjM57E4YzlaWuBVMuDrbAIt1Zwyipg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+5v4UllTgfdLg97P48S/GDg/BkpdPNQRcjoud3dYSY
 d/ptG5CRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABM5k8nIMCNpsWeVtukXplm7
 ZQ/8WtQY7W/U837tdJfDh1NulV1WamZkONY+qdhs6qULUu8dA04+OKP1Xuowy+WuuzzsysLVq0+
 28AMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

When reclaim discards a lazyfree folio, it clears the PTE but delays the
TLB flush. Until flushed, mapping a new folio into the now-none PTE
can leave some CPUs still reading from the old folio while others
already write to the new folio.

This is hard to trigger in practice and would mostly look like a weird
use-after-free bug in an allocator that uses MADV_FREE, but it can be
reproduced reliably with three threads pinned to different CPUs:

(1) Thread A populates the pages, MADV_FREE's them and then
    MADV_PAGEOUT's them.
(2) Thread B reads all pages to keep TLB entries cached and verifies the
    content of pages published by thread C.
(3) Thread C waits until mincore() indicates that a page is no longer
    present, writes a new value to it, and publishes it to thread B.

Thread B can then read the old value after the new folio was mapped and
the content updated.

One way to handle it would be adding conditional flushes to
do_anonymous_page(), migrate_vma_insert_page(), UFFDIO_COPY and
UFFDIO_MOVE ... essentially anywhere we install new anonymous folios,
which would mean that these places flush quite frequently on concurrent
reclaim.

To perform targeted flushes, we'd have to keep some PTE markers behind,
which is also rather nasty and not an easy fix.

So let's not defer the TLB flush for lazyfree folios, which includes
folios in VM_DROPPABLE mappings.

To avoid flushing if the folio was redirtied or has additional
references, perform all non-deferred TLB flushes only once we know that
we won't restore the PTEs, right before removing the rmap.

The downside is that we no longer batch TLB flushes when discarding
lazyfree folios, which harms performance, but is the right thing to do
for now.

Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/rmap.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 09c33b9ec5850..3935eed23a361 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2228,6 +2228,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long nr_pages = 1, end_addr;
+	bool flush;
 	unsigned long pfn;
 	int ptes = 0;
 
@@ -2253,6 +2254,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		nr_pages = 1;
+		flush = false;
 
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
@@ -2339,11 +2341,18 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * architecture must guarantee that a clear->dirty
 			 * transition on a cached TLB entry is written through
 			 * and traps if the PTE is unmapped.
+			 *
+			 * If we don't defer the flush, we flush only once we
+			 * know that we won't restore the PTEs below. We never
+			 * defer the flush for lazyfree folios: if we discard
+			 * them, the PTE will be none, and a page fault could
+			 * map a new folio while stale TLB entries still exist.
 			 */
-			if (should_defer_flush(mm, flags))
+			if (!folio_test_lazyfree(folio) &&
+			    should_defer_flush(mm, flags))
 				set_tlb_ubc_flush_pending(mm, pteval, address, end_addr);
 			else
-				flush_tlb_range(vma, address, end_addr);
+				flush = true;
 			if (pte_dirty(pteval))
 				folio_mark_dirty(folio);
 		} else {
@@ -2402,6 +2411,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			add_mm_counter(mm, mm_counter_file(folio), -nr_pages);
 		}
 finish_unmap:
+		if (flush)
+			flush_tlb_range(vma, address, end_addr);
 		folio_remove_rmap_ptes(folio, page, nr_pages, vma);
 		if (vma_test_any_mask(vma, VMA_LOCKED_MASK))
 			mlock_drain_local();

-- 
2.56.1

