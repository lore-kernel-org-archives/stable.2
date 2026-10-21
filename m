Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594196;
	b=aX7vKxsaF08wO7GxGLddxWNxjqNpdsmbmNebCNVeHQGFItjcDr0b0StCBcIhNqtpV3x4
	 4sdFgX0G3RNrAxx50Yk2rjp112Z9yNMDas0OJfaEBrT+CWJ8Dw/UNiLjAAPpaxiKDGFes
	 HrVMSRU/Hs/y7wz86D6Kf9eJvAN3DalfoRyP8SHYAZUK9MHNvlv1DZeTlkSSbmQjcHa/V
	 adD6Lhn3Gt+Ec5WDaRg/qJ8I5Qtm6h5HDlwK/L5ZsxaEc2IinnqW2SDkhClNVUcV/V7RA
	 IAdD9+OdgupNOt4d9RasrrRu63AhufXvtT8dGx6M3zpYt21vnY+8IcAZUZiW6vW5bzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594196;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X2hENNfRiF2uoR+SMOF7BzwT1TpYZMXmSwXuImCE7N8=;
	b=QWgZHcUmAyWMpBkTCjbklORbQQW/gsKS5QZP3Rr3D4x4sJt44Wzs9WzB1my6NEsb1E+d
	 OUWPNepKFyz6+JgF5FG6exv1HVJvcLr55IxIJuKEcmmb2noZPAjAQikdvbI+Tq+QMENmo
	 jnB00C4JSHHWfqyYD0wvOtU3jxLuiZJs3qDytnGbhx0gKSYrURL8xwyZbQBOrptN4JdqM
	 gQJL0CjBOFi5pjRMg4/0W0qA2JDeHboYx+200OSbJG9cfdvhv0ZybM/daRvz8tTL0H4wp
	 qAJV6QRlOEGWIk0H+MbnbbnWqwDiuHGYCwPq/4R/mlRurIJOInSQL97ZmmlOnx2tYog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hVbHSgwh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B1606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hVbHSgwh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5E71F000C1;
	Wed, 21 Oct 2026 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594196;
	bh=X2hENNfRiF2uoR+SMOF7BzwT1TpYZMXmSwXuImCE7N8=;
	h=Subject:To:Cc:From:Date;
	b=hVbHSgwhCNSduDOJJvTbCWxXFoplCHWoHbWsyAtqW9FiqBK8WL9ALjKUUm4IbN2fY
	 G7qawGZuTxH5vvc9GiY+CLcjjshga0OI8eBdWele617mqNiWzgY3WiCrPwuQEav/OH
	 eAXRg5fvECnjHs+3TT5wue29SxXOLP50w1vxKpc0=
Subject: FAILED: patch "[PATCH] futex: Fix mm reuse handling for FUT_OFF_MMSHARED" failed to apply to 6.18-stable tree
To: jannh@google.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:40:23 +0200
Message-ID: <2026102123-unrated-shading-f030@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3267512ad1c2cc0c7768c5b014dc2cceb398a801
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102123-unrated-shading-f030@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3267512ad1c2cc0c7768c5b014dc2cceb398a801 Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Sep 2026 18:31:32 +0200
Subject: [PATCH] futex: Fix mm reuse handling for FUT_OFF_MMSHARED

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

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 18ed18d5cbc1..a895d8c69d66 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -23,28 +23,32 @@ struct task_struct;
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
 		/* unsigned int node; */
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
 		/* unsigned int node; */
 	} private;
+
 	struct {
 		u64 ptr;
 		unsigned long word;
@@ -152,11 +156,10 @@ static inline void futex_set_vdso_cs_range(struct futex_mm_data *fd, unsigned in
 static inline void futex_fixup_robust_unlock(struct pt_regs *regs) { }
 #endif /* !CONFIG_FUTEX_ROBUST_UNLOCK */
 
-
-#if defined(CONFIG_FUTEX_PRIVATE_HASH) || defined(CONFIG_FUTEX_ROBUST_UNLOCK)
+#ifdef CONFIG_FUTEX
 void futex_mm_init(struct mm_struct *mm);
 #else
 static inline void futex_mm_init(struct mm_struct *mm) { }
-#endif
+#endif /* !CONFIG_FUTEX */
 
 #endif /* _LINUX_FUTEX_H */
diff --git a/include/linux/futex_types.h b/include/linux/futex_types.h
index d320c0571f0c..34b16f2828e7 100644
--- a/include/linux/futex_types.h
+++ b/include/linux/futex_types.h
@@ -85,10 +85,12 @@ struct futex_unlock_cs_ranges { };
  * struct futex_mm_data - Futex related per MM data
  * @phash:	Futex private hash related data
  * @unlock:	Futex unlock VDSO critical sections
+ * @unique_id:	Unique ID of the MM, for FUT_OFF_MMSHARED futexes
  */
 struct futex_mm_data {
 	struct futex_mm_phash		phash;
 	struct futex_unlock_cs_ranges	unlock;
+	atomic64_t			unique_id;
 };
 #else  /* CONFIG_FUTEX */
 struct futex_sched_data { };
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 095f9fe440e3..a240638f69e5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -439,12 +439,35 @@ struct hrtimer_sleeper *futex_setup_timer(ktime_t *time, struct hrtimer_sleeper
 }
 
 /*
- * Generate a machine wide unique identifier for this inode.
+ * Generate a machine wide unique identifier for this object (inode or mm).
  *
  * This relies on u64 not wrapping in the life-time of the machine; which with
  * 1ns resolution means almost 585 years.
- *
- * This further relies on the fact that a well formed program will not unmap
+ */
+static u64 get_object_id(atomic64_t *object_seq)
+{
+	static atomic64_t last_assigned_seq;
+	u64 old;
+
+	/* Does the object already have a sequence number? */
+	old = atomic64_read(object_seq);
+	if (likely(old))
+		return old;
+
+	for (;;) {
+		u64 new = atomic64_inc_return(&last_assigned_seq);
+		if (WARN_ON_ONCE(!new))
+			continue;
+
+		old = 0;
+		if (!atomic64_try_cmpxchg_relaxed(object_seq, &old, new))
+			return old;
+		return new;
+	}
+}
+
+/*
+ * This relies on the fact that a well formed program will not unmap
  * the file while it has a (shared) futex waiting on it. This mapping will have
  * a file reference which pins the mount and inode.
  *
@@ -458,24 +481,7 @@ struct hrtimer_sleeper *futex_setup_timer(ktime_t *time, struct hrtimer_sleeper
  */
 static u64 get_inode_sequence_number(struct inode *inode)
 {
-	static atomic64_t i_seq;
-	u64 old;
-
-	/* Does the inode already have a sequence number? */
-	old = atomic64_read(&inode->i_sequence);
-	if (likely(old))
-		return old;
-
-	for (;;) {
-		u64 new = atomic64_inc_return(&i_seq);
-		if (WARN_ON_ONCE(!new))
-			continue;
-
-		old = 0;
-		if (!atomic64_try_cmpxchg_relaxed(&inode->i_sequence, &old, new))
-			return old;
-		return new;
-	}
+	return get_object_id(&inode->i_sequence);
 }
 
 /**
@@ -683,8 +689,8 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 			goto out;
 		}
 
-		key->both.offset |= FUT_OFF_MMSHARED; /* ref taken on mm */
-		key->private.mm = mm;
+		key->both.offset |= FUT_OFF_MMSHARED;
+		key->private.mm_seq = get_object_id(&mm->futex.unique_id);
 		key->private.address = address;
 
 	} else {
@@ -2055,13 +2061,12 @@ static void futex_robust_unlock_init_mm(struct futex_mm_data *fd)
 static inline void futex_robust_unlock_init_mm(struct futex_mm_data *fd) { }
 #endif /* !CONFIG_FUTEX_ROBUST_UNLOCK */
 
-#if defined(CONFIG_FUTEX_PRIVATE_HASH) || defined(CONFIG_FUTEX_ROBUST_UNLOCK)
 void futex_mm_init(struct mm_struct *mm)
 {
+	atomic64_set(&mm->futex.unique_id, 0);
 	futex_hash_init_mm(&mm->futex);
 	futex_robust_unlock_init_mm(&mm->futex);
 }
-#endif
 
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
 {

