Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546623;
	b=H9dV44hm5ojAk4LSsTGx7fylftCAQeLUi5kb/effs190Z11kFU9O75/cb22ACWYWdliU
	 cSlBj3jk8LwbBdLrrgkdYu1KO+KegisSVP4q7FcEASAevzPw6st1THd+vlRbzoANXdWSW
	 +7LYXheezf8M/4T6cHg7jSSCJIISesOZy71c6ugN2ACtlMwJNPbq46Sr4ZMWAGsFBn+j/
	 Ct342ZtPHSzPilv+oJ8wseZh4hr1DDxeQEcPcXIZJKWTzTADgWsJSKIef+DupbcsPYBSX
	 ukY/KhhvMS97CO0cbBVFit0vLKyKaBCEDhPq2L4RT4TuBtnJqgfJux8KepCclq0F/BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546623;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=K75Fomuhl/TeDSAhojtFFsF9TENIiJs0NQdhbNDZn+8=;
	b=4pVcSWlPlo0lY3LdLGzWMp8l3dWUknFFnPcK8sRkej7vjZEmgnzWMYtpTESrFq4Vy7eb
	 Gxxs6vXeV9cwIT6+WW9yr98N/JK/lVx/j5p8Jj+pCKvj1cDqgnLLlTslRAvVehnnFcOeY
	 fC5CmPzbWV3kfSGcf7sNLcSvHiSAGerGRZu2XxPVRQdmw6x5QWZJkohwUXNAU3dZhwxcK
	 fx0diwrVh8zWd2omih9JHKp5H4p3EjTCqxbUu2Q5bJOSanKSPu8mfZy8NztCFZVz8bNEN
	 BGflzd7IngruFyxU7ZDFBaOiyhASO8HXMsSwPFY5BPYuDuF7DJbsnpXOidu9hIdx9hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D3dPwe1/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83431606A31E;
	Tue, 24 Nov 2026 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3dPwe1/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6135A1F000D0;
	Tue, 24 Nov 2026 18:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546622;
	bh=K75Fomuhl/TeDSAhojtFFsF9TENIiJs0NQdhbNDZn+8=;
	h=From:Date:Subject:To:Cc;
	b=D3dPwe1/1qD1ZZgtB2coXTHOK1EaWGzIMeeU4TukjN+rtf5chKTy+Br7BuJctDfT0
	 dLN89Kpf9dQINhB28PCvc3lQGwlyGRmczLhATl3VsJJZ3iOY+zjQw6K7rBE0BfEt1z
	 6lm7b0KKUpb7LZU2EWw6/e8NGK9eeV49VpzAEJQlkbwsI+gKa/6FsDVYHiXUW3ioGV
	 mYeTqpbEYFNeAiDKNnjwLMvuuaycvPu8y9HD0sEJDAkIMsw5sQDP1Q6BndT0MCnzOG
	 qBVhPcG1CW9fZlfUJUzoiMEM8cFz/ibu8WSjYSwDNERaJFTeE0BfIkVH7fcUELy/MV
	 rrANpkd8sVdPA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 18:56:46 +0000
Subject: [PATCH v2] mm/vma: drop mm asynchronously in vma_start_read()
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
Message-Id: <20261124-vma-read-lock-mmdrop-async-v2-1-8139b5cf24bb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/43NTQqDMBBA4auEWTvFCVrRVe9RXKTJRIM/kUkJF
 fHupZ6g27f43gGJJXCCTh0gnEMKcYVO6UKBHc06MAYHnQJd6juRrjAvBoWNwznaCZfFSdzQpH2
 1+DIVNdaRJV9CoWAT9uFz4c++UDCG9I6yX69Mv/oXmwkJdd34tvV1TY4fE8vK8y3KAP15nl9ea
 lnIxQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5425; i=ljs@kernel.org;
 h=from:subject:message-id; bh=+GlkRGCdNbNl6lPRsAZ0GstxY0HQDDSVM2C8Wjvm9gk=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZ735h09sQtFmBeXrXw5mxXfOCP9XkSc/Y/p157addx
 rcdv0u96ChlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEhBYyMixZuUTd+eS+hMP3
 MzaI8sfytiYvrJHZLFhgfmyNeOSdxMcM/1SkTs3heCliXSxXf8zjqcvU6wsXyalc/jT/7WX2aeu
 kVnMCAA==
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

Remove the now-defunct comment on the 'heavy operation', but leave
examining that to a follow up.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to per-VMA locks")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/DN267JUKDRNS.2VMV07CQ58R4X@gmail.com/
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
v2:
* Put the rcu_read_unlock() back where it was, a follow-up can address
  anything else here.

v1:
https://lore.kernel.org/r/20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org
---
 kernel/fork.c  | 16 ----------------
 mm/internal.h  |  3 +++
 mm/mmap_lock.c | 19 +++++++++++++++++--
 3 files changed, 20 insertions(+), 18 deletions(-)

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
index 073c5125b424..d28bbc3ba734 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -306,11 +306,10 @@ static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	 */
 	other_mm = vma->vm_mm; /* use a copy as vma can be freed after we drop vm_refcnt */
 
-	/* __mmdrop() is a heavy operation, do it after dropping RCU lock. */
 	rcu_read_unlock();
 	mmgrab(other_mm);
 	vma_refcount_put(vma);
-	mmdrop(other_mm);
+	mmdrop_async(other_mm);
 
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

