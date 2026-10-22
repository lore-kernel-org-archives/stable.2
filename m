Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678263;
	b=Jactq60xnfZDdgd3rkSsWi/z5gSurAAizZZj3g6BsU2lHOWjN1f+mGYhqZUemolTa0pN
	 c7nJn4YUQszJI22g/cdqr/eU8V+A+KlIKeTcjZ8CP9FzX8Zd2gKe38YBvr2V2ne8Gf38a
	 0z0gy2P5ZHT1tz1zvRE8v0KXBWNS9QmVbUOwEWC+tAeZhL9rOXb7m8h4jGX0NTnWKFaF1
	 UaPlDmvHmwRkH+5zwBiJTOfr8ElRpUZF+GVRxcruA0brBWmdocInibwhmTV8tItSEu9K8
	 fxkFRet4q3313+cUlraVXArGpLxhDG9VgycwyVKSxu9jUbVp2Srqth4bi8B4TZ1f4Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2+e/7zBHiQXMizSwIoPX6myblp/Mg4u1G+wu1Bb+70Y=;
	b=FLM1tVqzOX3Ta+9vUjqvYAZ9v9cbJhRtdsTeqsDlYjZaWX7p0tE7PxrD1YUWLmmRf1Yq
	 rlNTs2AhXf9ZvNwkSE/DwEBjE/cZACXfi287JwNcmu38DenQlOIeHU8Q9Cn8elkO6Msrm
	 EVhu/UetK0RheB12LF1rUh8BloBd43pOMUQIeALkkTCVpUqpE3PYVSNeBCSaMsEObarg+
	 GwV91jPl0aQ+38JVI/j2NCkwV1UFIqbDCljSAWB27Y9OVZwaag3s81mBll6Lr8VW6goC4
	 cFgVTCaArCI+R5xodaTY9oFVoJ2RzIekEaB8Y5r2yBgPjxdGrlk5yCGRe03yfnn4M1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BkkN/rkw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B42606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkkN/rkw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618751F000C1;
	Thu, 22 Oct 2026 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678262;
	bh=2+e/7zBHiQXMizSwIoPX6myblp/Mg4u1G+wu1Bb+70Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkkN/rkwRo4mM0qjUHgy1oiqv1ekuvnKMUqdI6VEp4FQFPbq905CtzdnhBxYWSiv5
	 3MxNPcsOYcjNowMT4WzDx5DvvDerXJr1PfkME4ha8uyB89a3ugDTXz7C4fdW5ggjvw
	 9sshMsPL3dFvlnSUqej2Z4HFXnmYp+yfttJAf13RDqwka39HhZublv0qyq+3XHHtlI
	 H5JXQ76cmNEUmmszBux85zETkO0BGxCF2MvnqHz6jkCsm9aRKPhrVKAHJqe+FElKWs
	 5H+i9go4z+xJ3DxF5dL5xK7DF0QxgH2NtWoS24k2zkItSEjMAhtv1CTiRetrDFCbtc
	 7tm4Ugv7dDAVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] futex: Fix mm reuse handling for FUT_OFF_MMSHARED
Date: Thu, 22 Oct 2026 10:11:00 -0400
Message-ID: <20261022140852.1448344-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102125-drum-yard-404f@gregkh>
References: <2026102125-drum-yard-404f@gregkh>
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
[ sashal: Moved futex unique-ID storage from futex_mm_data directly into mm_struct. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/futex.h    | 14 ++++++++----
 include/linux/mm_types.h |  4 ++++
 kernel/fork.c            |  3 +++
 kernel/futex/core.c      | 49 +++++++++++++++++++++-------------------
 4 files changed, 42 insertions(+), 28 deletions(-)

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
index 00a85b64e5241..8423ea56b337c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -578,6 +578,10 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
 
+#ifdef CONFIG_FUTEX
+		atomic64_t futex_unique_id;
+#endif
+
 #ifdef CONFIG_IOMMU_SUPPORT
 		u32 pasid;
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 83912c9e0c87c..c39de3ee8f537 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1050,6 +1050,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
+#ifdef CONFIG_FUTEX
+	atomic64_set(&mm->futex_unique_id, 0);
+#endif
 
 	if (current->mm) {
 		mm->flags = current->mm->flags & MMF_INIT_MASK;
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d772b8ab29817..d39fea1723fa6 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -417,39 +417,27 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
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
- * It is important that match_futex() will never have a false-positive, esp.
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
@@ -472,7 +460,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
  *
  *   ( inode->i_sequence, page->index, offset_within_page )
  *
- * [ also see get_inode_sequence_number() ]
+ * [ also see get_object_id() ]
  *
  * For private mappings (or when !@fshared), the key is:
  *
@@ -624,8 +612,8 @@ static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 			goto out;
 		}
 
-		key->both.offset |= FUT_OFF_MMSHARED; /* ref taken on mm */
-		key->private.mm = mm;
+		key->both.offset |= FUT_OFF_MMSHARED;
+		key->private.mm_seq = get_object_id(&mm->futex_unique_id);
 		key->private.address = address;
 
 	} else {
@@ -660,7 +648,22 @@ static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
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
+		 * It is important that match_futex() will never have a
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

