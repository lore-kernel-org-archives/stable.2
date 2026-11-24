Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523191;
	b=M4aPajWK5yDKvunYC7PTKYoZM4+yfaQE/pwJVokraa76gK1kF5et9BB380NbV+GK5EcE
	 ILAqYvZFr709Ngn59vq2mJhbUX4FWQp67iY74md7+4AKm+19f9UeEC6Bj3hOLFQXvHk4B
	 aHt5wlmvnpYKD3G758nauFK9UhzKGASuzBZHQVYRDB0BX86I1cGHZRwru04WwhDra90DR
	 wxSHwqAxfgxyC02N2GaXzxSysvCxoRF600GXx1lSOgS5PqgqwTOzhjUEPh04PayipfYjn
	 bIkyNZEGf+ZsTHuY+5AU9lCw6mhm1xpmz+oCrkMb+DoqoVO/MiRJoY3rb2bG2woRpoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523191;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hFysRZm2paHUdFhCRfxcIIS3foCC4VVjBtTGE4wazrs=;
	b=FOA/3AOCYT9FKLn1gm94ejKghR2diAr2Z3TWPLzKpBuCQWbgJ70Mk8mL1/9VmHbzQLE5
	 Clq7sfAKxoZ6ICBDbqbkVrIDOj39qEwLL8kmtKLya5iKp9XY0qC16QaLQBU0bbTuA64ZI
	 DTUjKIx1KCJq3eiQ88XOJBNFgXR6IO0klrdUpDAfpVWpkAua8j+qZpB6e+/idVIlDVAkY
	 HFmfOSUAPekahetImsCB3BJlVdAMdstYD5z+p/LU/GUzI/dqb42Y8Jm58JvcEkRzgPXoX
	 2FQWSBtjyfToB4+7C5PqlDO3VFxutKvXeihOTdLEporrj/XMs9Rik2E5EwgNll3Fm9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODYY2RNK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA0606A321;
	Tue, 24 Nov 2026 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODYY2RNK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE851F000CA;
	Tue, 24 Nov 2026 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795523191;
	bh=hFysRZm2paHUdFhCRfxcIIS3foCC4VVjBtTGE4wazrs=;
	h=From:Date:Subject:To:Cc;
	b=ODYY2RNKjzu8jIgwkOLEBWkI77tStWgeqsEe6+Fug+OOqm4I+MnvOdewXjZ01AdNR
	 rGEacdmM7g2Rlh+Khr0lENI7/5lPw4OJS0sA0ukU8opq2iSTzH6quEaYJvtwDqD5kZ
	 y7LLmpFR3CsNqMKxwOs7tdDfQ/nV0TECOu02fyC0A63QUMymFsXJhZj4k0HYTJ9rhv
	 Jfyrw6b+L90rtNr56yIATV4IGxnIO+5TiOfNIXy/cm7cdrbt1mSNMBCjiqTrHyrQjW
	 mIu/dw4Ql2YSTDmpIjwbcsfUO0STGJV3EaqfK9LUKOQmG8Bhu5HMuU6DCXj44bZYc+
	 oDW+jQbBuu2Ug==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 12:26:19 +0000
Subject: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
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
Message-Id: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MUQqDMAwA0KuEfBswRRz0KmMfWRq3sLWVFsQh3
 n3gO8A7sFtz6xjhwGabd68FI/AAqG8pLyNPGAHDGGbmMNGWhZpJom/VD+WcWl1J+q8oPWXimyZ
 WXkYcANdmi+9Xfn+c5x+YxNA5bAAAAA==
X-Change-ID: 20261124-vma-read-lock-mmdrop-async-ba417cd1c1f0
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Jann Horn <jannh@google.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 ljs@kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5120; i=ljs@kernel.org;
 h=from:subject:message-id; bh=lD6iWKFGqf6N+AjnDoi6ykJCOhX6nhAXibYpUbFGOlA=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZmwq+8LBPaZ8ZXcf0QiFoasyWXyqcPqelREUYmqR/X
 GOa0WzWUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgIlYtDD8FSnwOv8uqWPe8S+3
 k2wj+dmmn2Dma1u98+IJB/+w/TXnkxn+GcvvdDoqdXSTtEcG++foH9Ps7i7NuesU9U2U5+3JZcr
 tnAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to
per-VMA locks") open-codes a lock_next_vma() implementation that does
roughly the same thing in bpf_iter_task_vma_find_next(), only without
fallback to an mmap_lock.

This is because bpf_iter_task_vma_find_next() can be called from
non-sleepable contexts.

However, lock_vma_under_rcu() gave no guarantee as to which contexts it is
safe to be called from, and indeed it turns out this assumption is unsafe.

Since commit 9bbffee67ffd ("mm: fix a UAF when vma->mm is freed after
vma->vm_refcnt got dropped"), this call chain is possible on x86:

lock_vma_under_rcu()
  -> vma_start_read()
    -> mmdrop()
      -> __mmdrop()
        -> mm_free_pgd()
          -> pgd_free()
            -> pgd_dtor()
              -> spin_lock(&pgd_lock)

Thus, a plain spin_lock() can occur when lock_vma_under_rcu() is
called. Since bpf_iter_task_vma_find_next() can be called in softirq
context, this can deadlock, for example:

pgd_alloc()
  -> spin_lock(&pgd_lock)
    <softirq>
    bpf_iter_task_vma_next()
      -> lock_vma_under_rcu()
        ...
	  -> spin_lock(&pgd_lock) [ DEADLOCK ]

Alexei Starovoitov also pointed out that a BPF program attached to
trace_contention_end() can similarly cause a deadlock:

  pgd_alloc()
    spin_lock(&pgd_lock)
      queued_spin_lock_slowpath()
        trace_contention_end()          <- pgd_lock is held
          tp_btf/contention_end prog
            bpf_iter_task_vma_next()
              lock_vma_under_rcu()
                vma_start_read()
                  mmdrop(other_mm)      <- last put takes pgd_lock again

Resolve the issue by having vma_start_read() use mmdrop_async() instead of
mmdrop() so the work is deferred to a work queue.

Make mmdrop_async() an internal mm function, defined in mm/internal.h, to
avoid abuse elsewhere (kernel/fork.c includes this header, so still retains
access).

Commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on
failure") accounted for the fact that the RCU lock had to be dropped for
this operation, which is no longer applicable.

For the sake of a backported fix, retain this behaviour, however drop the
RCU lock last and remove the now irrelevant comment.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to per-VMA locks")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/DN267JUKDRNS.2VMV07CQ58R4X@gmail.com/
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 kernel/fork.c  | 16 ----------------
 mm/internal.h  |  3 +++
 mm/mmap_lock.c | 21 ++++++++++++++++++---
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5efceb8d58a7..4d5866c83481 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -744,22 +744,6 @@ void __mmdrop(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
 
-static void mmdrop_async_fn(struct work_struct *work)
-{
-	struct mm_struct *mm;
-
-	mm = container_of(work, struct mm_struct, async_put_work);
-	__mmdrop(mm);
-}
-
-static void mmdrop_async(struct mm_struct *mm)
-{
-	if (unlikely(atomic_dec_and_test(&mm->mm_count))) {
-		INIT_WORK(&mm->async_put_work, mmdrop_async_fn);
-		schedule_work(&mm->async_put_work);
-	}
-}
-
 static inline void free_signal_struct(struct signal_struct *sig)
 {
 	taskstats_tgid_free(sig);
diff --git a/mm/internal.h b/mm/internal.h
index de4593b3e3b6..cc95019c7e4b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1671,4 +1671,7 @@ static inline bool can_spin_trylock(void)
 /* char-mem.c */
 bool file_is_dev_zero(const struct file *file);
 
+/* mmap_lock.c */
+void mmdrop_async(struct mm_struct *mm);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 073c5125b424..28b387fe543a 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -306,11 +306,10 @@ static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	 */
 	other_mm = vma->vm_mm; /* use a copy as vma can be freed after we drop vm_refcnt */
 
-	/* __mmdrop() is a heavy operation, do it after dropping RCU lock. */
-	rcu_read_unlock();
 	mmgrab(other_mm);
 	vma_refcount_put(vma);
-	mmdrop(other_mm);
+	mmdrop_async(other_mm);
+	rcu_read_unlock();
 
 	return NULL;
 }
@@ -560,6 +559,22 @@ void __mm_reset_vma_seqcounts(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(__mm_reset_vma_seqcounts);
 
+static void mmdrop_async_fn(struct work_struct *work)
+{
+	struct mm_struct *mm;
+
+	mm = container_of(work, struct mm_struct, async_put_work);
+	__mmdrop(mm);
+}
+
+void mmdrop_async(struct mm_struct *mm)
+{
+	if (unlikely(atomic_dec_and_test(&mm->mm_count))) {
+		INIT_WORK(&mm->async_put_work, mmdrop_async_fn);
+		schedule_work(&mm->async_put_work);
+	}
+}
+
 #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
 #include <linux/extable.h>
 

---
base-commit: 913390e679e23e3a45643028ee7f992889094051
change-id: 20261124-vma-read-lock-mmdrop-async-ba417cd1c1f0

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

