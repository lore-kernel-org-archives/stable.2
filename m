Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993716;
	b=4r843/u1IPwTvDIyfoRyAvKPWkMfyEw+2K8kBm4WOXZmoXUX2qrPLoloX0WEam0skZlV
	 9QeCpjaJcc1we7/f6SjKulfHg8RaKhxKLYAQDgtbRTqGwghOFlAEm0JH1UyvaFqyVoXsc
	 GIHiGDpTRVaDNSJgM5IcQHmuYAPwLKzl1IR4/im+S0Bow2p5bVExTcxUJ7tM6y6oh85Z1
	 woYFGiu9uYTb9XVtiEtY/wfLSNTuD0dvsphA3ThXZvRxlM+R9Bcag9DlbGaKGMZWr/Crv
	 oPYk+Azr/FB07KTt7cv7PcZnYGhw4a0C1ON9hhR4THUUrs9lYFvs2eL5A55nz82nHNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993716;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wS0Us7CQpCD0WTbwehZzt06gr0ePGvS25DDYj5+ZQAw=;
	b=VGd+wCmh1UuckoigRmAjVtQ6iLiwu5P8e2odo052EqwKcRAjiWSOtzY6w2AS/G5KDBCN
	 qnS1tx5nl9rVH2HID7m0r1vKvI+2CRhna6Q60PUxuSnwMWysYm6VhTpCtN7zfY2Zv6Agj
	 XKzUCU5VBgmebDBFNA4dF2ImmqCHwI+zCIALe0CAqX2iC9pP7DMen3qZYcJ1smXJg0B3z
	 /IWsu56bRxHM898pEnyvr4S5gi9T8AhRGpfdkJSzpiIwDInFGH3jMV0J4H9zMTtiRAOBz
	 whRZXExhm4sBLgalq73TA3uoKzbDsj9vRCgNxqw77xFDsVPPBp3+EVKthq4m6gIfcDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoqhNNdt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638B606A31C;
	Wed, 18 Nov 2026 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoqhNNdt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5251F000D2;
	Wed, 18 Nov 2026 09:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794993716;
	bh=wS0Us7CQpCD0WTbwehZzt06gr0ePGvS25DDYj5+ZQAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VoqhNNdt+V+c8FvWfmPUoV8DESgpKxJPPFDfvnbSUzCnRwkfjncKSSHF36coBnaXf
	 MXiSi/bQXgvTNCS4lmgbsMIO+YxRvaKQ71jTWgaTEc3asD0HEcIKDaDmZNMMJS+/Y0
	 xd0uHtGTqreiHIGW2YG4Mq/1KxxbHTeqmfpWVIt+XzYlO01FozY3VZOlasGCNBJZhD
	 yFjA3weMIh7XTbo3IfLIyKGG2kiI708zwyHbEUNSiCe90JLIvSObaNzdtLDxH1eQW6
	 nXh5hJTnq84nsv6ajy74a6XalBnCO+zQWM1B/fUVNf/x+jVvZy+IZwcs3Hfx38JlMr
	 r8wV9PDi4n/0w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 18 Nov 2026 10:20:39 +0100
Subject: [PATCH 4/4] RFC: mm/vmscan: unlock unmapped folios only after the
 deferred TLB flush
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
Message-Id: <20261118-file_folio_flush-v1-4-e9e739ed14e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16608; i=david@kernel.org;
 h=from:subject:message-id; bh=2kxKir3pFctf+HjAbEk4CCWEoO4hFl+Fq7j1hctv2ho=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+5v5cYS19JNiyZOKRw68MF1S49vLOFY8J+Tip8phaX
 s2KG9Y1HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzEPZmR4XRufufVz1adGZMX
 GMf/0/1++MCXF7tkvVvNykLvPZ973omR4axn0arYuM2fNgSaBPL9lT86JetldLrZweVbev8+URS
 r4QcA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

try_to_unmap() with TTU_BATCH_FLUSH zaps the PTEs, transfers the PTE
dirty bit to the folio and defers the TLB flush. Until the TLB is
flushed, other CPUs might still access the folio through stale TLB
entries.

However, reclaim unlocks folios it keeps and removes folios it frees
from the page-cache / swap-cache before performing the deferred TLB
flush.

Stale writable TLB entries are currently handled by flushing them right
after try_to_unmap() if the folio is dirty, so writes through stale TLB
entries cannot get lost, but they are also not batched.

Stale read-only TLB entries, on the other hand, are problematic:

 (1) A page fault can map a new page-cache folio, or swap in a new folio
     once reclaim removed the old one from the swap-cache (e.g., a clean
     swap-cache folio, or a dirty folio mapped by clean PTEs after
     synchronous swap-out to zram or zswap). Modifications of the new
     folio (e.g., through write() or page table mappings) are then not
     visible to CPUs that still read the old folio.

 (2) A CoW fault in a MAP_PRIVATE mapping can copy a page-cache folio
     that reclaim kept. Writes go to the new anon folio, while other CPUs
     still read the old folio.

 (3) Invalidation (e.g., invalidate_inode_pages2()) can remove a folio
     that reclaim kept from the page-cache without flushing the TLB, as
     the folio is no longer mapped. A page fault can then map a new
     folio while other CPUs still read the old folio.

This can be reproduced easily by swapping out an anon memory range with
MADV_PAGEOUT, reading it back in, and swapping it out again
(MADV_PAGEOUT) while one thread keeps reading the range and another
thread writes to pages as soon as reclaim removed the folios from the
swap-cache. The first thread will occasionally read the old content.

Fix it by reclaiming folios in batches of up to 64 folios:

 (a) Lock each folio, check whether we want to reclaim it, and unmap it.
     Keep the folio locked if any deferred TLB flush is pending after
     unmapping it, otherwise unlock it right away.

 (b) Flush the TLB once, and unlock all folios that are still locked.

 (c) Lock the folios again, one at a time, to try reclaiming them.
     Activate folios that are still or again mapped, and skip folios
     that are under writeback or poisoned by now, or that somebody else
     holds locked.

As others might map or unmap folios while they are unlocked, we might
now activate or reclaim some folios that we would previously have kept
or activated, which is fine.

Keeping folios locked until the TLB flush makes sure that nobody can
remove them from the page-cache / swap-cache, copy them or start
writeback. Page faults will either wait on the folio lock, or find the
old folio and map it again, which is fine.

Unlocking folios before trying to reclaim them makes sure that we never
hold more than one folio lock while performing I/O or waiting on the
filesystem.

The idea of unlocking folios and locking them again using a trylock
before trying to reclaim them was inspired by [1] from Zhang Peng.

As nobody can start writeback before the TLB flush, we no longer have to
flush stale writable TLB entries right after try_to_unmap(), so remove
the try_to_unmap_flush_dirty() call and batch these flushes as well.
This effectively enables batching TLB flushes of stale writable TLB
entries, which is what [1] tried to achieve.

We must not wait for a folio lock, a folio flag or I/O while keeping
other folios locked, as that could deadlock. So flush the TLB and unlock
the batch early before waiting for writeback (legacy memcg), and before
allocating swap space would perform synchronous discard I/O
(folio_alloc_swap() now returns -EBUSY if allocation failed but retrying
with synchronous discard might help).

Allocating swap space can otherwise only sleep when allocating memory
for the swap table, which cannot enter direct reclaim or compaction,
as reclaim runs with PF_MEMALLOC.

We'll limit batching to 64 folios for now; the limit mostly matters for,
e.g., MADV_PAGEOUT and DAMON that can pass more, or when reclaim splits
large folios.

Note that khugepaged and batched (async) folio migration already keep up
to HPAGE_PMD_NR (e.g., 512 with 4 KiB pages) small folios locked after
unmapping them with a deferred TLB flush; migration even allocates new
folios, possibly entering direct reclaim, before flushing the TLB and
unlocking them. Both also call MMU notifiers while keeping other folios
locked, just like we do now.

Keep code churn to a minimum. Some follow-up cleanups and optimizations
make sense, in particular:

 (1) Cleanly separate the stages of shrink_folio_list() (see the TODO).

 (2) Avoid unlocking and locking folios again that do not require a TLB
     flush. But only if it's worth it and doesn't make the code too
     ugly.

 (3) Remove the remaining try_to_unmap_flush() calls before freeing
     folios; we only free folios that we flushed already or that we
     never unmapped.

 (4) Remove the now-unused try_to_unmap_flush_dirty() infrastructure.

[1] https://lore.kernel.org/linux-mm/20261031-batch-tlb-flush-v6-0-190539839eec@tencent.com/

Fixes: 72b252aed506 ("mm: send one IPI per CPU to TLB flush all entries after unmapping pages")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/internal.h |   5 ++
 mm/rmap.c     |   5 ++
 mm/shmem.c    |   2 +-
 mm/swap.h     |   5 +-
 mm/swapfile.c |   7 ++-
 mm/vmscan.c   | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 6 files changed, 165 insertions(+), 14 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8a204f7352364..0d89968648b37 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1253,6 +1253,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
+bool try_to_unmap_flush_pending(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
 #else
 static inline void try_to_unmap_flush(void)
@@ -1261,6 +1262,10 @@ static inline void try_to_unmap_flush(void)
 static inline void try_to_unmap_flush_dirty(void)
 {
 }
+static inline bool try_to_unmap_flush_pending(void)
+{
+	return false;
+}
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 3935eed23a361..399cba0395742 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -731,6 +731,11 @@ void try_to_unmap_flush_dirty(void)
 		try_to_unmap_flush();
 }
 
+bool try_to_unmap_flush_pending(void)
+{
+	return current->tlb_ubc.flush_required;
+}
+
 /*
  * Bits 0-14 of mm->tlb_flush_batched record pending generations.
  * Bits 16-30 of mm->tlb_flush_batched bit record flushed generations.
diff --git a/mm/shmem.c b/mm/shmem.c
index 5cb628cc9c6bb..3757bc1208068 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1936,7 +1936,7 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 		folio_mark_uptodate(folio);
 	}
 
-	ret = folio_alloc_swap(folio);
+	ret = folio_alloc_swap(folio, /* may_sync_discard= */ true);
 	if (!ret) {
 		bool first_swapped = shmem_recalc_inode(inode, 0, nr_pages);
 		int error;
diff --git a/mm/swap.h b/mm/swap.h
index d5bf21f517dce..b77c8a071a0a8 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -243,7 +243,7 @@ extern int swap_retry_table_alloc(swp_entry_t entry, gfp_t gfp);
  *
  * folio_put_swap(): does the opposite thing of folio_dup_swap().
  */
-int folio_alloc_swap(struct folio *folio);
+int folio_alloc_swap(struct folio *folio, bool may_sync_discard);
 int folio_dup_swap(struct folio *folio, struct page *page);
 void folio_put_swap(struct folio *folio, struct page *page);
 
@@ -363,7 +363,8 @@ static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t entry)
 	return NULL;
 }
 
-static inline int folio_alloc_swap(struct folio *folio)
+static inline int folio_alloc_swap(struct folio *folio,
+		bool may_sync_discard)
 {
 	return -EINVAL;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2d2df53fc51a9..242a361513301 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1732,16 +1732,19 @@ static int swap_dup_entries_cluster(struct swap_info_struct *si,
 /**
  * folio_alloc_swap - allocate swap space for a folio
  * @folio: folio we want to move to swap
+ * @may_sync_discard: whether we may wait for synchronous discard I/O
  *
  * Allocate swap space for the folio and add the folio to the
  * swap cache.
  *
  * Context: Caller needs to hold the folio lock.
  * Return: %0 on success, %-E2BIG if splitting the folio might allow swapout,
+ * %-EBUSY if allocation failed but retrying with @may_sync_discard might
+ * succeed,
  * %-ENOSPC if no global swap space is available, or %-ENOMEM if splitting
  * would not help.
  */
-int folio_alloc_swap(struct folio *folio)
+int folio_alloc_swap(struct folio *folio, bool may_sync_discard)
 {
 	unsigned int order = folio_order(folio);
 	unsigned int size = 1 << order;
@@ -1774,6 +1777,8 @@ int folio_alloc_swap(struct folio *folio)
 	local_unlock(&percpu_swap_cluster.lock);
 
 	if (!order && unlikely(!folio_test_swapcache(folio))) {
+		if (!may_sync_discard)
+			return -EBUSY;
 		if (swap_sync_discard())
 			goto again;
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index af7831643ecf5..11dbe19b170da 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1155,6 +1155,91 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
 	return false;
 }
 
+/*
+ * Maximum number of staged folios that shrink_folio_list() collects before
+ * it flushes the TLB.
+ */
+#define MAX_STAGED_FOLIOS	64
+
+struct staged_folios {
+	/* Locked folios, waiting for the TLB flush. */
+	struct list_head unflushed;
+	/* Unlocked folios, after the TLB flush (if required). */
+	struct list_head flushed;
+	/* Number of folios in the current batch. */
+	unsigned int nr_folios;
+};
+
+static bool staged_folios_empty(struct staged_folios *staged)
+{
+	return list_empty(&staged->unflushed) &&
+	       list_empty(&staged->flushed);
+}
+
+static void staged_folios_add(struct staged_folios *staged,
+		struct folio *folio, bool unmapped)
+{
+	if (unmapped && try_to_unmap_flush_pending()) {
+		/* Keep the folio locked until we flushed the TLB. */
+		list_add_tail(&folio->lru, &staged->unflushed);
+	} else {
+		folio_unlock(folio);
+		list_add_tail(&folio->lru, &staged->flushed);
+	}
+	staged->nr_folios++;
+}
+
+static void staged_folios_flush(struct staged_folios *staged)
+{
+	struct folio *folio;
+
+	try_to_unmap_flush();
+	list_for_each_entry(folio, &staged->unflushed, lru)
+		folio_unlock(folio);
+	list_splice_tail_init(&staged->unflushed, &staged->flushed);
+}
+
+static struct folio *staged_folios_next(struct staged_folios *staged,
+		struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	if (staged_folios_empty(staged))
+		return NULL;
+	/* Collect more folios until we have enough or there are no more. */
+	if (staged->nr_folios < MAX_STAGED_FOLIOS && !list_empty(folio_list))
+		return NULL;
+
+	/* Flush the TLB and unlock the folios that waited for the flush. */
+	staged_folios_flush(staged);
+
+	folio = list_first_entry(&staged->flushed, struct folio, lru);
+	list_del(&folio->lru);
+	/* We handed out all folios: start collecting again. */
+	if (list_empty(&staged->flushed))
+		staged->nr_folios = 0;
+	return folio;
+}
+
+static int staged_folios_alloc_swap(struct staged_folios *staged,
+		struct folio *folio)
+{
+	bool may_sync_discard = list_empty(&staged->unflushed);
+	int ret;
+
+	ret = folio_alloc_swap(folio, may_sync_discard);
+	if (ret != -EBUSY)
+		return ret;
+
+	/*
+	 * Don't wait for synchronous discard I/O while keeping other folios
+	 * locked: there is potential for deadlocks and long delays.
+	 */
+	staged_folios_flush(staged);
+	may_sync_discard = true;
+	return folio_alloc_swap(folio, may_sync_discard);
+}
+
 /*
  * shrink_folio_list() returns the number of reclaimed pages
  */
@@ -1166,6 +1251,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	struct folio_batch free_folios;
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(demote_folios);
+	struct staged_folios staged = {
+		.unflushed = LIST_HEAD_INIT(staged.unflushed),
+		.flushed = LIST_HEAD_INIT(staged.flushed),
+	};
 	unsigned int nr_reclaimed = 0, nr_demoted = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
@@ -1177,15 +1266,41 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	do_demote_pass = can_demote(pgdat->node_id, sc, memcg);
 
 retry:
-	while (!list_empty(folio_list)) {
+	/*
+	 * We take folios from folio_list to pre-process them (lock, check,
+	 * unmap). Then, they move to the staged(unflushed) list, from where
+	 * they move to the staged(flushed) list after a batched TLB flush
+	 * and after unlocking them. If no TLB flush is pending for a folio,
+	 * it moves to the staged(flushed) list directly.
+	 *
+	 * We then take folios from the staged(flushed) list to actually
+	 * reclaim them, or to activate them if they are still mapped.
+	 *
+	 * So we pre-process folios from folio_list until we collected a batch
+	 * of staged folios, or until there are no more folios to
+	 * pre-process. Then, we perform a single TLB flush and reclaim all
+	 * folios of that batch, before we pre-process more folios.
+	 *
+	 * Once all lists are empty, we are done.
+	 *
+	 * TODO: the stages of this algorithm should be cleanly separated.
+	 */
+	while (!list_empty(folio_list) || !staged_folios_empty(&staged)) {
 		struct address_space *mapping;
 		struct folio *folio;
 		enum folio_references references = FOLIOREF_RECLAIM;
 		bool dirty, writeback;
+		bool unmapped = false;
 		unsigned int nr_pages;
 
 		cond_resched();
 
+		folio = staged_folios_next(&staged, folio_list);
+		if (folio) {
+			nr_pages = folio_nr_pages(folio);
+			goto reclaim_staged;
+		}
+
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
 
@@ -1324,6 +1439,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			/* Case 3 above */
 			} else {
 				folio_unlock(folio);
+				/*
+				 * Don't wait for writeback while keeping
+				 * staged folios locked.
+				 */
+				staged_folios_flush(&staged);
 				folio_wait_writeback(folio);
 				/* then go back and try same folio again */
 				list_add_tail(&folio->lru, folio_list);
@@ -1382,7 +1502,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				    split_folio_to_list(folio, folio_list))
 					goto activate_locked;
 			}
-			ret = folio_alloc_swap(folio);
+			ret = staged_folios_alloc_swap(&staged, folio);
 			if (ret) {
 				int __maybe_unused order = folio_order(folio);
 
@@ -1401,7 +1521,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				}
 #endif
 				count_mthp_stat(order, MTHP_STAT_SWPOUT_FALLBACK);
-				if (folio_alloc_swap(folio))
+				if (staged_folios_alloc_swap(&staged, folio))
 					goto activate_locked_split;
 			}
 			/*
@@ -1455,21 +1575,36 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				flags |= TTU_SYNC;
 
 			try_to_unmap(folio, flags);
-			/*
-			 * Flush deferred writable TLB entries before we could
-			 * drop the folio lock and others could start writeback.
-			 */
-			if (folio_test_dirty(folio))
-				try_to_unmap_flush_dirty();
+			unmapped = true;
 			if (folio_mapped(folio)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked &&
 				    folio_test_swapbacked(folio))
 					stat->nr_lazyfree_fail += nr_pages;
-				goto activate_locked;
 			}
 		}
 
+		staged_folios_add(&staged, folio, unmapped);
+		continue;
+
+reclaim_staged:
+		if (!folio_trylock(folio))
+			goto keep;
+
+		/*
+		 * We failed to unmap the folio, or it was mapped again while it
+		 * was unlocked.
+		 */
+		if (folio_mapped(folio))
+			goto activate_locked;
+		/*
+		 * While the folio was unlocked, writeback might have started, or
+		 * it might have been poisoned.
+		 */
+		if (folio_test_writeback(folio) ||
+		    folio_contain_hwpoisoned_page(folio))
+			goto keep_locked;
+
 		/*
 		 * Folio is unmapped now so it cannot be newly pinned anymore.
 		 * No point in trying to reclaim folio if it is pinned.

-- 
2.56.1

