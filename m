Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110130;
	b=nQN4S135q5Cse4DOrDzVK7+d8JIYa0ibsHKDno5TP3aczctlz7aJ8NChFK7RH9TtxuHg
	 iYBeZctA24XHb8qGevYY0Ii03NGl3gok8Yw8qnz3tsXpCmOfnUKETWHH6vFoOm4jhbd69
	 W3KktXVY9UzJVpSa/gmDzSBEmSRB3a9JJmcxxpmbN3E0StqMMMlVoDellRSBXyqxl/Pn0
	 VjAo13kDmEMwZU3CbfavxVdVGwwu/icI09AX5RWLPrdvjGVU2iQiYO34mYMpFXCmBJ1L3
	 KwY6WaKUzbZ+tcR4BKT7aIMIBixk/3DOftFCE6Db1ObpRdM6Beggrcd69/M+APuU2/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110130;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bHLY+JVLBLI6/sbAMJPPkKcoTxvXtY408uYK2DIs4mw=;
	b=z5xvvYtjpPgqyuK/jqtC1pMqNTK5AxgjaP52JzVfFWXS4imdEwjTvrd0NHQna/dZMNdt
	 tTYc325RLF1ZIRI2FvaxBopdtdtzABg2bVTRrh28qS2uLOIfkaJxKPQhZlL+KvCiVh8fs
	 I3PrStMQABHRLLWrt+Xp54EqbjnVnRriSxGMHUoiEoPiCZGbQeLtYpvpzyFx2H2D/WgSN
	 F3KUTUg8BC6pYWYDQRBidrjtDq9JEDobhg8KrFJBsnucsUJ0Cz4m415eNfzrrBEUXI00c
	 AB5Ff1jJHYy6RWAL61tvSgvYQnBWjY2RHpCUg9yyPn6K4kXc/JLTtih63fiE8ZOL8Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMvT3fcu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC8606A338;
	Tue, 27 Oct 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMvT3fcu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC781F031E1;
	Tue, 27 Oct 2026 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110130;
	bh=bHLY+JVLBLI6/sbAMJPPkKcoTxvXtY408uYK2DIs4mw=;
	h=From:Date:Subject:To:Cc;
	b=UMvT3fcudQyZWnu/X8gt1lNPuuWdi/CZqStupv+uHetutR/ebau0z41E4qrIIwU+w
	 E11MmFGS9k6G/ISAEOMZRMlzC5aN4pLpG7yaEo5/rLylWzlFJfGI4F3X/H9NIWahe4
	 dBuR29fyeXfPDHCEKlZ4L12qBjgvhIkIVLGOP+Ixl6G6n0ndu5fliVWJagJdt4rOAz
	 bPC0yxC59k8jl0YQS6uPjxA1fWBPElmN990Q/ly4L+AoGG+I7lGN4LfyHO4pRbMOQL
	 S1fE+2mQberzh5ufoDs25teeqCh9R3Zpk3+oFfPr3rNrG485JyxKMqK9uEeJswXsF6
	 rHUjezlAYirkg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 27 Oct 2026 14:08:26 +0000
Subject: [PATCH v2] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
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
Message-Id: <20261027-fix-proc-pid-maps-missing-vmas-v2-1-2791cc9fc95f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNQQ6CMBBFr2K6dgytIODKexhCahlhorTNjGk0h
 LtbSVy+n/z3FiXIhKLOu0UxJhIKPoPZ75SbrB8RaMisTGFOujA13OkNkYODSAPMNgrMJEJ+hDR
 bAdfUxaBL1M62KksiY35sgWuXeSJ5Bf5svaR/619dQUTus6TfrEmDBlciurK6tcemvjyQPT4Pg
 UfVrev6BdDcmEK7AAAA
X-Change-ID: 20261027-fix-proc-pid-maps-missing-vmas-c870d14e1ca9
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, SJ Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, ljs@kernel.org, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12409; i=ljs@kernel.org;
 h=from:subject:message-id; bh=TJGHfA1a5exDR5ZzJu2Pc0i7YDzL8DX0C/1gx1QVqRc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIebMhbx+D7d+/S7sOsRqw7Hi8tubbi99ZlST99bVr1V
 Er38Ql97ChlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBE5j9l+J/xbUYJm4G//Cpe
 9beW52Zk3J6Ym73I9fbDvZnhm/72f/jE8Fc2MHdBynueE1Vvf5or/2X8PuHoA+G5Ck/0lv+au+V
 0x242AA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Reading /proc/PID/maps under per-VMA locks can skip continuously mapped
address ranges during concurrent VMA splits or merges. This violates the
guarantee in Documentation/filesystems/proc.rst:

"If there is something at a given vaddr during the entirety of the
life of the smaps/maps walk, there will be some output for it."

lock_next_vma() reuses a tree iterator across calls under RCU. The iterator
remembers the range of its last entry. When its node is replaced,
mas_next_slot() walks the tree again at the last index of that range, then
advances past the entry containing that index. If VMA boundaries changed,
this can skip a range that has not been reported:

- A lookup finds [A, C), then mprotect() splits it into [A, B) and [B, C)
  before vma_start_read() locks the first VMA. The reader reports [A, B),
  but the iterator still covers [A, C). The next call starts from B yet
  advances past C, omitting [B, C).

- The reader reports [A, B) and unlocks it. A concurrent mprotect() then
  merges it with [B, C). On the next call, the iterator resumes at B - 1,
  which now belongs to [A, C), and advances past C. Again, [B, C) is lost.

Checking the mmap_lock sequence only within the next call misses writers
that completed before that call began. Also, a NULL result is currently
accepted without validation, so a race can terminate the walk early.

Even a fresh lookup can skip a mapping. Suppose it finds a gap before
[B, C). A writer inserts an adjacent VMA at the end of that gap, then
merges it into [B, C), replacing the node. The lookup resumes at the old
gap's last index, now inside the merged VMA, and steps past it. The
original [B, C) remains mapped throughout. Repeating the forward lookup
is insufficient: another merge can make it skip the same mapping again,
returning the same later VMA or NULL.

The fresh-lookup race also affects /proc/PID/smaps, numa_maps and
smaps_rollup. Resetting the iterator after gathering each VMA's statistics
does not prevent a merge during the next lookup. Fixing lock_next_vma()
also prevents omitted entries and incomplete rollup statistics.

Tie VMA iterator state with the current mm and the write generation at the
point of last mm speculation in vma_rcu_iter, whose values we call 'rvmi'.

This allows us to neatly abstract the existing priv->iter logic alongside
query_vma_find_by_addr() which uses its own VMA iterator.

Then, provide helpers that act on the rvmi - vma_rcu_iter_[maybe_changed,
may_have_skipped]() to determine whether any VMAs may have
been altered since last mm speculation.

Additionally introduce vma_range_is_empty(), used by
vma_rcu_iter_may_have_skipped(), to determine conclusively whether VMAs
exist in a set range, needing to be traversed.

Original fix generated by an LLM and sent by Josef Bacik in private, then
amended by David Hildenbrand, and Lorenzo Stoakes added additional
abstraction.

Fixes: 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under per-vma lock")
Fixes: ea3085dd7a4e ("fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} under per-vma lock")
Fixes: 0e985559d72a ("proc/task_mmu: read proc/pid/smaps_rollup under per-vma lock")
Fixes: d9d1c2d81797 ("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks")
Cc: stable@vger.kernel.org
Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Note that I decided it's best to defer any VMA iterator stuff to a
follow-up - with the abstractions added it's clear what's going on and
easier for backporting.
---
v2:
* Took over the patch to make David's life easier :)
* Introduced vma_rcu_iter tying the VMA iterator, mm and sampled mm seqnum
  together, and update lock_next_vma() + callers to use it.
* Moved the sequence out of proc_maps_locking_ctx and the "must initially
  be odd" requirement out of the header into vma_rcu_iter_init().
* Added vma_rcu_iter_maybe_changed() and vma_rcu_iter_may_have_skipped()
  to replace the open-coded speculation checks.
* Converted vma_range_is_empty() to use a VMA iterator to be consistent.
* Added Fixes: tag for d9d1c2d81797 (PROCMAP_QUERY), as per Jose.

v1:
https://lore.kernel.org/r/20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org
---
 fs/proc/internal.h        |  1 +
 fs/proc/task_mmu.c        | 13 +++++-----
 include/linux/mmap_lock.h | 22 ++++++++++++++---
 mm/mmap_lock.c            | 61 ++++++++++++++++++++++++++++++++++-------------
 4 files changed, 72 insertions(+), 25 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 623bb43ede55..1d95ff577a06 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -393,6 +393,7 @@ struct proc_maps_private {
 	struct inode *inode;
 	struct task_struct *task;
 	struct vma_iterator iter;
+	struct vma_rcu_iter rvmi;
 	loff_t last_pos;
 	struct proc_maps_locking_ctx lock_ctx;
 #ifdef CONFIG_NUMA
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 74ffa5c99b8e..22361607020d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -165,7 +165,7 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 		return vma_next(&priv->iter);
 
 	unlock_ctx_vma(lock_ctx);
-	vma = lock_next_vma(lock_ctx->mm, &priv->iter, last_pos);
+	vma = lock_next_vma(&priv->rvmi, last_pos);
 	if (!IS_ERR_OR_NULL(vma))
 		lock_ctx->locked_vma = vma;
 
@@ -270,7 +270,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	 */
 	if (last_addr && !addr_is_sentinel(last_addr))
 		*ppos = last_addr = priv->last_pos;
-	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
+	vma_rcu_iter_init(&priv->rvmi, mm, &priv->iter, (unsigned long)last_addr);
 	hold_task_mempolicy(priv);
 	/*
 	 * If seq_file had to flush its collected data right after m_next() set
@@ -520,6 +520,7 @@ static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ct
 	struct mm_struct *mm = lock_ctx->mm;
 	struct vm_area_struct *vma;
 	struct vma_iterator vmi;
+	struct vma_rcu_iter rvmi;
 
 	if (lock_ctx->mmap_locked)
 		return find_vma(mm, addr);
@@ -527,8 +528,8 @@ static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ct
 	/* Unlock previously locked VMA and find the next one under RCU */
 	unlock_ctx_vma(lock_ctx);
 	rcu_read_lock();
-	vma_iter_init(&vmi, mm, addr);
-	vma = lock_next_vma(mm, &vmi, addr);
+	vma_rcu_iter_init(&rvmi, mm, &vmi, addr);
+	vma = lock_next_vma(&rvmi, addr);
 	rcu_read_unlock();
 
 	if (!vma)
@@ -1421,7 +1422,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 	rcu_read_lock();
 	reset_lock_ctx(lock_ctx);
 
-	vma_iter_init(&priv->iter, mm, 0);
+	vma_rcu_iter_init(&priv->rvmi, mm, &priv->iter, 0);
 	vma = proc_get_vma(m, &pos);
 	if (unlikely(!vma))
 		goto empty_set;
@@ -1470,7 +1471,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 			reset_lock_ctx(lock_ctx);
 			/* Resume from the last position. */
 			pos = last_vma_end;
-			vma_iter_init(&priv->iter, mm, pos);
+			vma_rcu_iter_init(&priv->rvmi, mm, &priv->iter, pos);
 		}
 		vma = proc_get_vma(m, &pos);
 	}
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 11b3ffef3966..9ccbbcbd7aca 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -17,6 +17,13 @@ extern int rcuwait_wake_up(struct rcuwait *w);
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
 
+/* Tie a VMA iterator to mm write lock state at iterator initialisation. */
+struct vma_rcu_iter {
+	struct mm_struct *mm;
+	struct vma_iterator *vmi;
+	unsigned int mm_wr_seq;
+};
+
 DECLARE_TRACEPOINT(mmap_lock_start_locking);
 DECLARE_TRACEPOINT(mmap_lock_acquire_returned);
 DECLARE_TRACEPOINT(mmap_lock_released);
@@ -509,6 +516,16 @@ static inline void vma_mark_detached(struct vm_area_struct *vma)
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 					  unsigned long address);
 
+static inline void vma_rcu_iter_init(struct vma_rcu_iter *rvmi,
+		struct mm_struct *mm, struct vma_iterator *vmi,
+		unsigned long addr)
+{
+	vma_iter_init(vmi, mm, addr);
+	rvmi->mm = mm;
+	rvmi->vmi = vmi;
+	rvmi->mm_wr_seq = UINT_MAX; /* Start odd so changed by default. */
+}
+
 /*
  * Locks next vma pointed by the iterator. Confirms the locked vma has not
  * been modified and will retry under mmap_lock protection if modification
@@ -516,9 +533,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
  * Returns either a valid locked VMA, NULL if no more VMAs or -EINTR if the
  * process was interrupted.
  */
-struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
-				     struct vma_iterator *iter,
-				     unsigned long address);
+struct vm_area_struct *lock_next_vma(struct vma_rcu_iter *rvmi,
+				     unsigned long from_addr);
 
 static inline void vma_assert_can_modify(struct vm_area_struct *vma)
 {
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 83b7d3ded0dc..834bbf86e004 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -13,6 +13,8 @@
 #include <linux/trace_events.h>
 #include <linux/local_lock.h>
 
+#include "internal.h"
+
 EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
 EXPORT_TRACEPOINT_SYMBOL(mmap_lock_acquire_returned);
 EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
@@ -428,21 +430,53 @@ static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_struct *mm
 	return vma;
 }
 
-struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
-				     struct vma_iterator *vmi,
+/* Is there no VMA in [start, last]? */
+static bool vma_range_is_empty(struct mm_struct *mm, unsigned long start,
+		unsigned long last)
+{
+	VMA_ITERATOR(vmi, mm, start);
+
+	return !vma_iter_load(&vmi) && vma_iter_end(&vmi) - 1 >= last;
+}
+
+/* Might the VMA tree have been modified since last mm speculation? */
+static bool vma_rcu_iter_maybe_changed(const struct vma_rcu_iter *rvmi)
+{
+	return (rvmi->mm_wr_seq & 1) || /* Odd implies write-lock. */
+	       mmap_lock_speculate_retry(rvmi->mm, rvmi->mm_wr_seq);
+}
+
+/* Could the VMA iterator have skipped a VMA due to the tree changing? */
+static bool vma_rcu_iter_may_have_skipped(const struct vma_rcu_iter *rvmi,
+		unsigned long from, unsigned long to)
+{
+	return vma_rcu_iter_maybe_changed(rvmi) &&
+	       !vma_range_is_empty(rvmi->mm, from, to);
+}
+
+struct vm_area_struct *lock_next_vma(struct vma_rcu_iter *rvmi,
 				     unsigned long from_addr)
 {
+	struct mm_struct *mm = rvmi->mm;
+	struct vma_iterator *vmi = rvmi->vmi;
 	struct vm_area_struct *vma;
-	unsigned int mm_wr_seq;
-	bool mmap_unlocked;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
 retry:
-	/* Start mmap_lock speculation in case we need to verify the vma later */
-	mmap_unlocked = mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
+	/* Only trust the iterator's position if the tree cannot have changed. */
+	if (vma_rcu_iter_maybe_changed(rvmi)) {
+		vma_iter_set(vmi, from_addr);
+		mmap_lock_speculate_try_begin(mm, &rvmi->mm_wr_seq);
+	}
 	vma = vma_next(vmi);
-	if (!vma)
-		return NULL;
+	if (!vma) {
+		/* No reason to fallback if nothing left in range. */
+		if (!vma_rcu_iter_may_have_skipped(rvmi, from_addr, ULONG_MAX))
+			return NULL;
+
+		rcu_read_unlock();
+		goto fallback;
+	}
 
 	vma = vma_start_read(mm, vma);
 	if (IS_ERR_OR_NULL(vma)) {
@@ -471,14 +505,9 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
 	 * installed ahead of it. Otherwise we might observe a gap that should
 	 * not be there.
 	 */
-	if (from_addr < vma->vm_start) {
-		/* Verify only if the address space might have changed since vma lookup. */
-		if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr_seq)) {
-			vma_iter_set(vmi, from_addr);
-			if (vma != vma_next(vmi))
-				goto fallback_unlock;
-		}
-	}
+	if (from_addr < vma->vm_start &&
+	    vma_rcu_iter_may_have_skipped(rvmi, from_addr, vma->vm_start - 1))
+		goto fallback_unlock;
 
 	return vma;
 

---
base-commit: 33dbd62d6ff310b8cce8c70101639a6eddbb1b52
change-id: 20261027-fix-proc-pid-maps-missing-vmas-c870d14e1ca9

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

