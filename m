Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618634;
	b=Jsrj9aIPCP08drozUevBscGRj8X5+DtJ5cNXOkdOd0vYgQf+pjEeBBXLMY1PZMVOo0pI
	 ExbYNwyEZUn6LHqxE08q37wQMZk6nxGzFOJADBlaUm/BdHKKmF9rWa7zLyb3F64p5Rj/+
	 qPCGuAD2RTYHi85p5+Yd6hg/4ar1IM+BVctopEHaZYjzYBOXE2HPJ4YyzktiNSlu7B0+6
	 FLk8P0rXxgsONn4OeYJK8IY4/BSEogOJcRIOErjpujN6O+2p9BQ/CJ+GPCOGsziFCayig
	 srkorNg2Dc+WfI8woJRdh1p45vadXW4fo5MuruKfMZiqUpmRgCsiF3M92gakqf3WZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TrtzwFC2MJ3MXz1a7nEp/CaReB20pxFPJV8io7LGo3U=;
	b=PQZMSHs2wn8+L0T62SvWUuk46VOpiFbCffeOvInnp8Uex8v71VoYAFo7DetiAu3rY4Ia
	 YunXAnYlwoHQ0+zclQGXTZ/y2YxTCxsKzaaK2Se2nvNqkSGBjWbxKBdKYmyo2YvpXTnvV
	 LyQAAOI5iq36SjwOVp6RnYB2zf7rD3V48t5Na3SLCuc5poRA1HrG0pKKX6SLeRdIWD4bk
	 bzK0MsP3lVVHsCGsoV60RDao+ezDsJ0T90o516t88xVI+xR2/QtHITVhtywu6xn5QCSaA
	 KNNR07kNd8+gueiNeXLjFdAYJmA4lfuk3B0a4jRtIs4flch7hqE97DWsnA3yKeyTaPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BX+dgKvW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8A606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BX+dgKvW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647751F000C4;
	Wed, 21 Oct 2026 21:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618633;
	bh=TrtzwFC2MJ3MXz1a7nEp/CaReB20pxFPJV8io7LGo3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BX+dgKvWULMRxhSbnP4YOMzzgbilKhb1sppEXtLBldnCgTk65tUacNpllJNWnYUH5
	 ILSSM1vwpQowlNkznB1h12NIRwHrXiIsbnfc3qCUu/VVNFoYWLOs/eMSdIBbm6tzaF
	 SwfsW0XcVtjQOvsMj7E/ATa0LV1HlrawvzrTJ+KKZKOlYwrVar6H9ZG3iIZ0ZGMM64
	 Ir8xh+4gcXPsT8VF0KnUlckxADMwkt8tFaB+PgXTAzsKbhUBX3kiJVY4prXAeAVf37
	 XKW0dvDnLst7Hm+/rq9IS2IpUs0UMHLM1FV6vOk9UA39c4xB4JHLXbvViNhVSHFeoa
	 QWkiOBXhoQZ7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] futex: Fix mm reuse handling for FUT_OFF_MMSHARED
Date: Wed, 21 Oct 2026 17:37:12 -0400
Message-ID: <20261021213616.407071-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102123-alumni-imprudent-06f0@gregkh>
References: <2026102123-alumni-imprudent-06f0@gregkh>
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
[ sashal: Replaced futex_mm_data infrastructure with a direct mm_struct field initialized in mm_init(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/futex.h    | 14 +++++++-----
 include/linux/mm_types.h |  3 +++
 kernel/fork.c            |  3 +++
 kernel/futex/core.c      | 47 ++++++++++++++++++++--------------------
 4 files changed, 39 insertions(+), 28 deletions(-)

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
index f9a280a27e5ca..3deb3f1d5ad26 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -945,6 +945,9 @@ struct mm_struct {
 		 */
 		seqcount_t mm_lock_seq;
 #endif
+#ifdef CONFIG_FUTEX
+		atomic64_t futex_unique_id;
+#endif
 
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/kernel/fork.c b/kernel/fork.c
index c0ecb097aa1d2..81a8a7d3a5bd3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1304,6 +1304,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
+#ifdef CONFIG_FUTEX
+	atomic64_set(&mm->futex_unique_id, 0);
+#endif
 
 	if (current->mm) {
 		mm->flags = mmf_init_flags(current->mm->flags);
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index c37d2263c21fe..fa6ea7e235b13 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -153,39 +153,27 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
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
@@ -208,7 +196,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
  *
  *   ( inode->i_sequence, page->index, offset_within_page )
  *
- * [ also see get_inode_sequence_number() ]
+ * [ also see get_object_id() ]
  *
  * For private mappings (or when !@fshared), the key is:
  *
@@ -362,8 +350,8 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 			goto out;
 		}
 
-		key->both.offset |= FUT_OFF_MMSHARED; /* ref taken on mm */
-		key->private.mm = mm;
+		key->both.offset |= FUT_OFF_MMSHARED;
+		key->private.mm_seq = get_object_id(&mm->futex_unique_id);
 		key->private.address = address;
 
 	} else {
@@ -398,7 +386,20 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 		}
 
 		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
-		key->shared.i_seq = get_inode_sequence_number(inode);
+		/*
+		 * This relies on the fact that a well formed program will not unmap
+		 * the file while it has a (shared) futex waiting on it. This mapping will have
+		 * a file reference which pins the mount and inode.
+		 *
+		 * If for some reason an inode gets evicted and read back in again, it will get
+		 * a new sequence number and will _NOT_ match, even though it is the exact same
+		 * file.
+		 *
+		 * It is important that futex_match() will never have a false-positive, esp.
+		 * for PI futexes that can mess up the state. The above argues that false-negatives
+		 * are only possible for malformed programs.
+		 */
+		key->shared.i_seq = get_object_id(&inode->i_sequence);
 		key->shared.pgoff = folio->index + folio_page_idx(folio, page);
 		rcu_read_unlock();
 	}
-- 
2.53.0

