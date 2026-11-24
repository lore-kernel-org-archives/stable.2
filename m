Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513162;
	b=iEPf4llBefp69gtMIXl64WbfpKGVcQbMINq+MW6lY8lwAUtmPJdxLi48SeiEDCfs1V9f
	 YxxdnL45alaECOKFxg++MyU069dN29BKP/7Tv2IPInAlfmQ+civisO5pU/H5rDdNNGETh
	 Hm2GHtLKmDZqROpY14x7yPYbjdh/mTubMTSNQi1q7CZ5i/NOWVuddCgiWcmSTWmG0T/1V
	 hqicNkd31HK0siYTudca56tWW9fyl8ryC2ggPyi3VkMPr0P5Xhuwb1yXOxRFquJJ+Vp22
	 eXPeJOaJhipmAoRSWMKhQn1ZwJLj2/fXLhZUonZyHyu1/D+FNjc3qwWXZFo6Ykcow8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513162;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=i1zYmnYkPR+QppMSA1qkt8iIgekTBwLhdACmYiJ7duw=;
	b=HM6z2c+hLQRcqvTiWPrSSw4pH4LWjm6DUj/Sc7mfo4N8UOqyZcU9Mhsv/td9lQvoEGLC
	 lBahfZdzYnOMKdd75cEOrGpatLuWx061+/CDc6Yoav+WrMyc96MWxLBbT2fE6npS0xIM3
	 baP+91dBVKT5ocx2qNJfNdq2clYoUcHrLcLl44yF8x+Bf0AtvaLav3HbAAX1AWiqBLoV1
	 zxApf5cNRsvNXVXHjSIzIR9nUHxFTjVReW4CUNTZvw5YLpmXuoxWyefS3vpajVA9KBbVi
	 xZUpd9t19VbKGSLdSN2yIZz1adPslvUkyPy9mjE8Hxx7snlKsNt4BmLjGyydTbreF0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTbgr2mb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869A606A321;
	Tue, 24 Nov 2026 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTbgr2mb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748031F000E1;
	Tue, 24 Nov 2026 09:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513162;
	bh=i1zYmnYkPR+QppMSA1qkt8iIgekTBwLhdACmYiJ7duw=;
	h=From:Date:Subject:To:Cc;
	b=YTbgr2mbFQvtLcFWiluIvcnSj4YXF/9Ynu1yYHUTLZwPE9myGc33zyIRazXZ0f4PT
	 06PotWNIX2iR9SGG/VoLRmNxHClPqsX4FqflHL3IBGgCPIWe2YzY/jv5xeaGpdMG5f
	 KfJaDY15bycehz6Uo5z3Vuc0xltqsQCnlmtnxSGgxa4idg9oWACxxNvUS+a4EQJmaA
	 tlUO5EQfHDkxZhCLR0pg5HHtNFIKFiLkVXM6DYE2miSDWq/1nzmeT+Mm33YyTJWRiH
	 NCdSO6jcvXZPHwDcE6ot1lEzA6MTtCtUTAgA9is/7AskW3C5+klmR+QKMuCG+Walmf
	 KvdJWKSExn4dQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 24 Nov 2026 10:39:11 +0100
Subject: [PATCH] mm/rmap: avoid reusing batched TLB flush generations
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
Message-Id: <20261124-rmap-v1-1-e3dc48a4b527@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/6tWKk4tykwtVrJSqFYqSi3LLM7Mz1OyUjDUUVBKz
 kjMS0/VzUxRslJQMjIwMjM0NDLWLcpNLNC1TDJJMklOMUqzsDBT0lFQKihKTcusABsTHQvhF5c
 mZaUml4D0KtXWAgBhcZqhaAAAAA==
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
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7781; i=david@kernel.org;
 h=from:subject:message-id; bh=lrNZviMbe0mYa8sui1Fk11Z8MN9F/3GTeY2Mnv2bxIg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJZox2f8vTHc91ay1G54XNV7N+dM5MVJb83v0qdu+hR9
 YlD271fdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRplpGhlfXtd2lPuUdO/5C
 4O+TxXb/cw7MYzD9osJUw5c4Ubvw3xGG/wVHL/uni5cJyF7/a/e9JrDn/mV/q91zdj60YytNfxB
 jyggA
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
TLBI, riscv: fully-ordered xchg() in ptep_get_and_clear()) imply a
barrier. This should be cleaned up or documented separately.

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

Fixes: 5ee2fa2f0636 ("mm/rmap: fix potential batched TLB flush race")
Cc: stable@vger.kernel.org
Reported-by: Kirk Swidowski <swidowski@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ david: use atomic_t instead of atomic64_t, adjust description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm_types.h |  3 ++-
 mm/rmap.c                | 70 +++++++++++++++++++++---------------------------
 2 files changed, 33 insertions(+), 40 deletions(-)

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

