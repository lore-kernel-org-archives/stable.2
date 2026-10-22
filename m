Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792632633;
	b=uxxkO7gJloRPhHRKDgjquGNepVH5PD+/ZLQvvKCXJrXeVvzO0URZP3wam67oSRgutxVW
	 pDKn4H6O869gP8V2/PvghWOcRUDGwElg/f4fExfhKVMJ57Jy0grEP6E9HO1T1fGikzuMO
	 FxltGIUGduUxa8V0W9W7HVthcwJ3ruqDziNcdmHWRceQafr+7Oy/+ZcgTqfM7U+im9RI7
	 nFqX/Ua4EDw9h+ATYS1bvCQ8ySJmnhEi7wYL6QFkI0Yv/exCb+Ytv814+jbNzrRrJLjRk
	 6tYCWyTk2gteFp13BitRV9TQLSxk34OdAySISJnPDZTIBZcghcs0sZ4C6uAehN6B8ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632633;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Hbq8nep18myzU4hDPnJq+/jLKXtD1hmEjcgVGbCPFHs=;
	b=l8tiknXRcg1+bqCTsmdbZXl9fW3T71lMhHxaj9R4aufTun3OgA2zMEcqhSMln20Qyokv
	 ic2DATuiiKSnmzA2LT6B+Ldx+yNrYoF8ORQGy2cFd7xeMxl9GjkWGnnIyT1qCaKotP1Xs
	 oHxVTIPAMO25g9XEfby2G2Y7d3xoxLjVvViBjogH8YzVJsPkszzrHeGkHm8Woip5Iz0ll
	 jb3IEPYdMMp1M4kDkS81zCdAShjyo8C6Jhx2Wjs8hUC5Xmx+W3wr8CYf8ntNnehs2n+W4
	 jUGOvutrM8LDdz4nHJzRRH3a4Z8EIcTho4APNCNEgAOMwYGMozKOTXUJuMwyPVe5MvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4+Pfo8k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A015606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4+Pfo8k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33F41F000C1;
	Thu, 22 Oct 2026 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792632633;
	bh=Hbq8nep18myzU4hDPnJq+/jLKXtD1hmEjcgVGbCPFHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R4+Pfo8kDii2ZLBMB9L7D1VIf9USOi7ZxRU/4pX2PqUJLntwtr5pXROuIppADSQuJ
	 9M/QybcH2eV3c1N67VBnW0YSqQ7fIFWAuWEbzojQjT5kHw4FBRasxlyXOSB0g4Msym
	 nn1S9bQBDZiKiwEMuhMV1UI7L+75JCWBTE488B504mbJVebl5KZgCFGAgVBPU04thL
	 zP9emyFlcEFDbeQozqXwj1xRiGNukK92XCIyOVT1g4T6HugEIn4wkIF2aIzDK4a9gO
	 Q6oOSlBimaI/sh+Wuc0RpIjiJ2dv51yXrO70r1tK6YHtRK1ZzAJyiiVVtoCRBxjJz/
	 bqFSDhcC8k4RQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] futex: Fix mm reuse handling for FUT_OFF_MMSHARED
Date: Wed, 21 Oct 2026 21:30:31 -0400
Message-ID: <20261022012951.694863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102124-demotion-lapped-3d24@gregkh>
References: <2026102124-demotion-lapped-3d24@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit 3267512ad1c2cc0c7768c5b014dc2cceb398a801 ]

A FUT_OFF_MMSHARED futex is a shared futex that refers to an MM.
It is possible for a process to wait on a shared futex with a different MM
because a FUT_OFF_INODE waiter can be requeued onto a FUT_OFF_MMSHARED
futex by another process.
This can cause FUT_OFF_MMSHARED waiters on a freed MM to consume
wakeups intended for a newly allocated MM at the same address.

Fix it by keying FUT_OFF_MMSHARED using a unique 64-bit per-MM ID.
Leave private futexes as before to avoid influencing the performance of the
hotpath.

(Multi-threaded processes typically implicitly use FUT_OFF_MMSHARED by
setting clear_child_tid such that it points into anonymous memory, which
causes mm_release() in a multi-threaded mm to perform FUTEX_WAKE.)

Fixes: 222993395ed3 ("futex: Remove pointless mmgrap() + mmdrop()")
Closes: https://lore.kernel.org/r/CAG48ez0dLBpc3QtbAhMMVNHwHL94iHh2G+h-=BVFR4dDuzZr1g@mail.gmail.com/
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260929-futex-mmshared-fix-v1-1-262b1ffeb3d0@google.com
Cc: stable@vger.kernel.org
[ sashal: adapted futex ID handling to direct mm_struct storage initialized by mm_init() because the dedicated per-MM futex infrastructure is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/futex.h    | 14 ++++++++----
 include/linux/mm_types.h |  3 +++
 kernel/fork.c            |  3 +++
 kernel/futex/core.c      | 49 +++++++++++++++++++++-------------------
 4 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85c..09f757f14d01f 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -23,26 +23,30 @@ struct task_struct;
  *  01 : Shared futex (PTHREAD_PROCESS_SHARED)
  *	mapped on a file (reference on the underlying inode)
  *  10 : Shared futex (PTHREAD_PROCESS_SHARED)
- *       (but private mapping on an mm, and reference taken on it)
+ *       (but private mapping on an mm)
 */
 
-#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inode */
-#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm */
+#define FUT_OFF_INODE    1 /* We set bit 0 if shared key identifies an inode */
+#define FUT_OFF_MMSHARED 2 /* We set bit 1 if shared key identifies an mm */
 
 union futex_key {
+	/* For FUT_OFF_INODE */
 	struct {
 		u64 i_seq;
 		unsigned long pgoff;
 		unsigned int offset;
 	} shared;
+
+	/* For FUT_OFF_MMSHARED or private */
 	struct {
 		union {
-			struct mm_struct *mm;
-			u64 __tmp;
+			struct mm_struct *mm; /* for private */
+			u64 mm_seq; /* for FUT_OFF_MMSHARED */
 		};
 		unsigned long address;
 		unsigned int offset;
 	} private;
+
 	struct {
 		u64 ptr;
 		unsigned long word;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ce3370823f9c7..91c10d8b00c02 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -849,6 +849,9 @@ struct mm_struct {
 		 */
 		int mm_lock_seq;
 #endif
+#ifdef CONFIG_FUTEX
+		atomic64_t futex_unique_id;
+#endif
 
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/kernel/fork.c b/kernel/fork.c
index 73e8a6b430a05..396a1d4b05e59 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1299,6 +1299,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
+#ifdef CONFIG_FUTEX
+	atomic64_set(&mm->futex_unique_id, 0);
+#endif
 
 	if (current->mm) {
 		mm->flags = mmf_init_flags(current->mm->flags);
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 660d7061740b8..8fb54800ce0ad 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -151,39 +151,27 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 }
 
 /*
- * Generate a machine wide unique identifier for this inode.
+ * Generate a machine wide unique identifier for this object (inode or mm).
  *
  * This relies on u64 not wrapping in the life-time of the machine; which with
  * 1ns resolution means almost 585 years.
- *
- * This further relies on the fact that a well formed program will not unmap
- * the file while it has a (shared) futex waiting on it. This mapping will have
- * a file reference which pins the mount and inode.
- *
- * If for some reason an inode gets evicted and read back in again, it will get
- * a new sequence number and will _NOT_ match, even though it is the exact same
- * file.
- *
- * It is important that futex_match() will never have a false-positive, esp.
- * for PI futexes that can mess up the state. The above argues that false-negatives
- * are only possible for malformed programs.
  */
-static u64 get_inode_sequence_number(struct inode *inode)
+static u64 get_object_id(atomic64_t *object_seq)
 {
-	static atomic64_t i_seq;
+	static atomic64_t last_assigned_seq;
 	u64 old;
 
-	/* Does the inode already have a sequence number? */
-	old = atomic64_read(&inode->i_sequence);
+	/* Does the object already have a sequence number? */
+	old = atomic64_read(object_seq);
 	if (likely(old))
 		return old;
 
 	for (;;) {
-		u64 new = atomic64_add_return(1, &i_seq);
+		u64 new = atomic64_add_return(1, &last_assigned_seq);
 		if (WARN_ON_ONCE(!new))
 			continue;
 
-		old = atomic64_cmpxchg_relaxed(&inode->i_sequence, 0, new);
+		old = atomic64_cmpxchg_relaxed(object_seq, 0, new);
 		if (old)
 			return old;
 		return new;
@@ -206,7 +194,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
  *
  *   ( inode->i_sequence, page->index, offset_within_page )
  *
- * [ also see get_inode_sequence_number() ]
+ * [ also see get_object_id() ]
  *
  * For private mappings (or when !@fshared), the key is:
  *
@@ -358,8 +346,8 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 			goto out;
 		}
 
-		key->both.offset |= FUT_OFF_MMSHARED; /* ref taken on mm */
-		key->private.mm = mm;
+		key->both.offset |= FUT_OFF_MMSHARED;
+		key->private.mm_seq = get_object_id(&mm->futex_unique_id);
 		key->private.address = address;
 
 	} else {
@@ -394,7 +382,22 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 		}
 
 		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
-		key->shared.i_seq = get_inode_sequence_number(inode);
+		/*
+		 * This relies on the fact that a well formed program will not
+		 * unmap the file while it has a (shared) futex waiting on it.
+		 * This mapping will have a file reference which pins the mount
+		 * and inode.
+		 *
+		 * If for some reason an inode gets evicted and read back in
+		 * again, it will get a new sequence number and will _NOT_ match,
+		 * even though it is the exact same file.
+		 *
+		 * It is important that futex_match() will never have a
+		 * false-positive, esp. for PI futexes that can mess up the state.
+		 * The above argues that false-negatives are only possible for
+		 * malformed programs.
+		 */
+		key->shared.i_seq = get_object_id(&inode->i_sequence);
 		key->shared.pgoff = page_to_pgoff(tail);
 		rcu_read_unlock();
 	}
-- 
2.53.0

