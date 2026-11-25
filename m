Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599304;
	b=IwoVRiZboftj3wHbCh105FdrEKL7dbOzarYmdTVUa2D1jVu0AEsdxYCztoINc70F91+J
	 jqWUvhIutTqhFHDGE6IN5oczxUbuY9XaJAEcWL2zlybHh5oo5mvVdNY0iDTagNPzqPeoU
	 Iv6rV0aY6MPX50tsW6wZhEtMn+6SvOZ4IfkYm0u0kJXHXX/iDy7L6iP8uFtJbJMLwp6Ck
	 2Z3R47D88TF0XWILPSrfefxF7WVv6At6W9A2VwAM60QyJZhrLD38S5Lz34lcBFou6KsfE
	 v+ahUFHS1CJALdE5pvBPbcJw1JWEr2SsY3qOIm1vgg8gER0jKRV2iJ/PYrQLDQrmo7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599304;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yCSqfAyZ77JuVMThAw7Ur0h8HFHWK4ACsCjE0QWCzwg=;
	b=0DasA/1qWIubAKykoSOEQPWeg5ckoBjlLLRTsvGMhQgC53TkG+IVXqqvZ2K7rvt16Aco
	 kohQme3Lp24H2FOThiKkDP0R0qxeXjsSd4nZuaTm+SchrIm1ZZ15D393VxtPbOwpJtg82
	 SxiA9lOhxANexannT0wAAzVJlKY46EzUllj/976jSIlo4rnkmr/zChvqqdQLLydyB/5k3
	 vQz/BOLyF9tMu5b2DhI3MKN/hHmXCdjQMa2MtOTzYhu9zVaklo2/YODKXSdZ838Ip5Jvx
	 98P1rSzNQMeWaQii+otKyPDOtRDCKH6AtIJY8nIdWqPfsPP7DbXK5ck3BE2hmPjTukg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feyuTSRC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72F60A2602;
	Wed, 25 Nov 2026 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feyuTSRC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A345B1F0157A;
	Wed, 25 Nov 2026 09:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599304;
	bh=yCSqfAyZ77JuVMThAw7Ur0h8HFHWK4ACsCjE0QWCzwg=;
	h=From:Date:Subject:To:Cc;
	b=feyuTSRCDIFwJfcvIyqA4WAGMf28HakKlbSbIUQcq6cfvVJYjJKNKtTdcDrgAzWCB
	 sDfo5hxKUHsyyGhQUvGBTS8OB+d1wv4KEk8bLRbHPf0teKL0aoyfffe0X+thSgIMrp
	 8LlwtdR+K8ncRYL2rPe9Y+t4id1KFW5Wtt+EJD1Lgi/d491msN30yBGGMoj1IxLhvv
	 I8Tsw1sJBfGXrF2Cden4kHFJtaYmGoTYebQjRuN7m76kfm8xe6W/BKrm/kg//0cJIm
	 cYu8x0gTw6fO8phOYqvjnLsjROqsxlGkfUsXuHQl6RmOi69Izd/x9s838k7h8fgcYP
	 UtLOPvWlU8++Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 10:34:46 +0100
Subject: [PATCH v2] mm/rmap: avoid reusing batched TLB flush generations
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
Message-Id: <20261125-rmap-v2-1-0ba817662eac@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/zWNyw6CMBBFf6WZNTW2VKxd+R+GRR8D1AeQKRIN6
 b8bIC5vcu45CySkiAkMW4BwjikOPRgmCwa+s32LPAYwDORRVkLIktPLjvzilFM+yEbrCgoGI2E
 TP5vmVu87vd0d/bR+V6KLaRrou3VmsXJ/pdqVs+CCYxm80la5kzxfH0g9Pg8DtVDnnH8CzE3pq
 wAAAA==
X-Change-ID: 20261123-rmap-9b4b4cd2f886
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Ying Huang <huang.ying.caritas@gmail.com>
Cc: linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
 linux-riscv@lists.infradead.org, stable@vger.kernel.org, 
 Kirk Swidowski <swidowski@google.com>, 
 Huang Ying <ying.huang@linux.alibaba.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9870; i=david@kernel.org;
 h=from:subject:message-id; bh=sApNn04IkF2jKBCWWGPIU/uCfVggM+RnRjuZROPKlQ0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZVu96VMz56tLPuyfWsXodiBXVibxde2V75HHDpbs1Z
 vBGi7Nf7ihlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiq1YzMvRJVWmnrEj+8yH/
 SczZpnotJTX5Ywn+n4rs/qwN4c6vyGJk+MKY0rvF82+qY8C+c3J3VTN0wkQutq3jYKxOXj1jS74
 6HwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

mm->tlb_flush_batched packs a 15-bit pending and a 15-bit flushed
counter into one atomic_t, and resets both once pending gets large.
flush_tlb_batched_pending() updates flushed with a cmpxchg() against the
value it read before flushing.

If the counters get reset and reach that same value again while
flush_tlb_mm() is running, the cmpxchg() succeeds and unmaps that
happened in the meantime are considered flushed. A later zap can then
skip the flush and leave stale writable TLB entries behind.

Use two separate counters, never reset pending, and let the flusher
simply store the pending value it read before flushing. To keep pending
from wrapping around to flushed, pull flushed to pending - 1 once
pending is more than INT_MAX ahead.

Preventing the wrapping is primarily required because
try_to_unmap_flush() as called from migration and reclaim code does
*not* go through flush_tlb_batched_pending(), as it does not iterate
MMs. So if nothing in the MM triggers flush_tlb_batched_pending(), there
would be a problem.

As the separate counters are no longer read atomically together, we must
read "flushed" before "pending" (acquire/release), so a reader can never
pair a just moved-forward "flushed" value with an older "pending" value.

We'll leave the barrier() between clearing the PTE and incrementing
"pending" alone for now: it should be a smp_mb__before_atomic(), but
existing arch code (x86: inc_mm_tlb_gen(), arm64: dsb(ishst) before the
TLBI, riscv: fully-ordered xchg() in ptep_get_and_clear()) implies a
barrier. This should be cleaned up or documented separately.

As dup_mm() copies the counters using memcpy() while they can get
updated concurrently, a newly forked child could end up with "flushed"
being "pending + 1" and we could skip a later flush in the child. In
theory, this might have been possible before (load tearing), but two
separate counters make that easier to trigger. So let's just reset them to
0 during fork(). Put it into the existing init_tlb_flush_pending() and
rename the function to make the name better match the wider scope.

Note: if a flusher stalls between reading "pending" and storing it,
while "pending" advances by an exact multiple of 2^32, the counters
could compare equal and we could miss a flush. The same applies to a
writer that stalls while moving "flushed" forward.

That is irrelevant in practice: both hold the PTL, so without PREEMPT_RT
they cannot get preempted, and wrapping within the ~20s soft lockup and
RCU stall timeouts would require more than 200 million batched unmaps
per second on a single mm, which is impossible in practice. Even with
PREEMPT_RT or long vCPU preemption, we would need minutes of unmap and
refault churn while the stalled task stays off the CPU, which is highly
unlikely and not a realistic attack vector.

This effectively adds 4 bytes to mm_struct. However, on common 64-bit
configs it fits into the existing padding, leaving the size unchanged.

[ david: use atomic_t instead of atomic64_t, reset counters during fork(),
         adjust description ]

Fixes: 5ee2fa2f0636 ("mm/rmap: fix potential batched TLB flush race")
Cc: stable@vger.kernel.org
Reported-by: Kirk Swidowski <swidowski@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- Reset counters during fork()
- Adjust description
- Pick up tags (thanks!)
- Link to v1: https://patch.msgid.link/20261124-rmap-v1-1-e3dc48a4b527@kernel.org
---
 include/linux/mm_inline.h |  6 +++-
 include/linux/mm_types.h  |  3 +-
 kernel/fork.c             |  2 +-
 mm/rmap.c                 | 70 +++++++++++++++++++++--------------------------
 4 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ab69b9930893f..71fa0596ff6f7 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -551,9 +551,13 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 
 void pfnmap_track_ctx_release(struct kref *ref);
 
-static inline void init_tlb_flush_pending(struct mm_struct *mm)
+static inline void mm_init_tlb_flush(struct mm_struct *mm)
 {
 	atomic_set(&mm->tlb_flush_pending, 0);
+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+	atomic_set(&mm->tlb_flush_batch_pending, 0);
+	atomic_set(&mm->tlb_flush_batch_flushed, 0);
+#endif
 }
 
 static inline void inc_tlb_flush_pending(struct mm_struct *mm)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1ed35d258d2e3..9f51a0ec67451 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1407,7 +1407,8 @@ struct mm_struct {
 		atomic_t tlb_flush_pending;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 		/* See flush_tlb_batched_pending() */
-		atomic_t tlb_flush_batched;
+		atomic_t tlb_flush_batch_pending;
+		atomic_t tlb_flush_batch_flushed;
 #endif
 		struct uprobes_state uprobes_state;
 #ifdef CONFIG_PREEMPT_RT
diff --git a/kernel/fork.c b/kernel/fork.c
index 77d6c8fc38c66..63014f5fef42f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1109,7 +1109,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p)
 	mm_pasid_init(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
-	init_tlb_flush_pending(mm);
+	mm_init_tlb_flush(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
 	mm->pmd_huge_pte = NULL;
 #endif
diff --git a/mm/rmap.c b/mm/rmap.c
index 65646ed6fc453..038435994b99a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -731,22 +731,12 @@ void try_to_unmap_flush_dirty(void)
 		try_to_unmap_flush();
 }
 
-/*
- * Bits 0-14 of mm->tlb_flush_batched record pending generations.
- * Bits 16-30 of mm->tlb_flush_batched bit record flushed generations.
- */
-#define TLB_FLUSH_BATCH_FLUSHED_SHIFT	16
-#define TLB_FLUSH_BATCH_PENDING_MASK			\
-	((1 << (TLB_FLUSH_BATCH_FLUSHED_SHIFT - 1)) - 1)
-#define TLB_FLUSH_BATCH_PENDING_LARGE			\
-	(TLB_FLUSH_BATCH_PENDING_MASK / 2)
-
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 		unsigned long start, unsigned long end)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
-	int batch;
 	bool writable = pte_dirty(pteval);
+	unsigned int pending, flushed;
 
 	if (!pte_accessible(mm, pteval))
 		return;
@@ -755,23 +745,21 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 	tlb_ubc->flush_required = true;
 
 	/*
-	 * Ensure compiler does not re-order the setting of tlb_flush_batched
+	 * Ensure compiler does not re-order the pending count update
 	 * before the PTE is cleared.
 	 */
 	barrier();
-	batch = atomic_read(&mm->tlb_flush_batched);
-retry:
-	if ((batch & TLB_FLUSH_BATCH_PENDING_MASK) > TLB_FLUSH_BATCH_PENDING_LARGE) {
-		/*
-		 * Prevent `pending' from catching up with `flushed' because of
-		 * overflow.  Reset `pending' and `flushed' to be 1 and 0 if
-		 * `pending' becomes large.
-		 */
-		if (!atomic_try_cmpxchg(&mm->tlb_flush_batched, &batch, 1))
-			goto retry;
-	} else {
-		atomic_inc(&mm->tlb_flush_batched);
-	}
+	atomic_inc(&mm->tlb_flush_batch_pending);
+
+	/*
+	 * If no flusher ran for a long time, "pending" could wrap around and
+	 * catch up with "flushed". Move "flushed" forward to prevent that.
+	 */
+	pending = atomic_read(&mm->tlb_flush_batch_pending);
+	flushed = atomic_read(&mm->tlb_flush_batch_flushed);
+	if (unlikely(pending - flushed > INT_MAX))
+		/* Pairs with atomic_read_acquire() in flush_tlb_batched_pending() */
+		atomic_set_release(&mm->tlb_flush_batch_flushed, pending - 1);
 
 	/*
 	 * If the PTE was dirty then it's best to assume it's writable. The
@@ -805,25 +793,29 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
  * if required. This will cost one additional flush per reclaim cycle paid
  * by the first operation at risk such as mprotect and mumap.
  *
- * This must be called under the PTL so that an access to tlb_flush_batched
- * that is potentially a "reclaim vs mprotect/munmap/etc" race will synchronise
+ * This must be called under the PTL so that an access to the batch counters
+ * that is potentially a "reclaim vs mprotect/munmap/etc" race will synchronize
  * via the PTL.
  */
 void flush_tlb_batched_pending(struct mm_struct *mm)
 {
-	int batch = atomic_read(&mm->tlb_flush_batched);
-	int pending = batch & TLB_FLUSH_BATCH_PENDING_MASK;
-	int flushed = batch >> TLB_FLUSH_BATCH_FLUSHED_SHIFT;
+	/*
+	 * Read flushed before pending. Pairs with atomic_set_release() in
+	 * set_tlb_ubc_flush_pending(), which updates flushed without a flush.
+	 */
+	const int flushed = atomic_read_acquire(&mm->tlb_flush_batch_flushed);
+	const int pending = atomic_read(&mm->tlb_flush_batch_pending);
 
-	if (pending != flushed) {
-		flush_tlb_mm(mm);
-		/*
-		 * If the new TLB flushing is pending during flushing, leave
-		 * mm->tlb_flush_batched as is, to avoid losing flushing.
-		 */
-		atomic_cmpxchg(&mm->tlb_flush_batched, batch,
-			       pending | (pending << TLB_FLUSH_BATCH_FLUSHED_SHIFT));
-	}
+	if (pending == flushed)
+		return;
+
+	flush_tlb_mm(mm);
+	/*
+	 * Only set "flushed" equal to "pending" after flushing the TLB.
+	 * Racing flushers that store an older value can only cause an extra
+	 * flush.
+	 */
+	atomic_set(&mm->tlb_flush_batch_flushed, pending);
 }
 #else
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,

---
base-commit: 1c1815d259fc11f14cfd80f8cc37fc067bf6c69e
change-id: 20261123-rmap-9b4b4cd2f886

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

