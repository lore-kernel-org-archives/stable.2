Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5963A9D94;
	Thu, 15 Oct 2026 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051529; cv=none; b=eNdgeSMXKvat12s+fDOM7R5zqpEbxA4KhYFYf7d9FzEAc7F0KOC7xgdhGAcMwvm8QbTHGKGUv/duagjQ8P/05JWfq3OnRqbaBI35BPUm2pH9m5KLfSkF5v/qS0qif7Zw0Iax2JNUCxehMtWW8ONRWWGCdIRiL4XSpWPo9EZAgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051529; c=relaxed/simple;
	bh=rqHIWpdSyDSrgCAkJsAPcj3VuB/Mfkl1u6QFtmz4ek4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HqWC2vI22R36P/YLw4yns1YK+vIeCa0vGWvFRGpn6NbAUSGKRpTdmo4n/5gGlmH4kod4Sbnj8WlJDX7OHo7x4XgdL+7cEB5ws86wCSY2RbugnwnCYmdy+sb8l4lxkHI9Pj5w/n02OwAQgsQimqcbVX6NqswIOsOypPWuK6/ZPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P0L+h1Pq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xebLc5Td; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P0L+h1Pq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xebLc5Td"
Date: Thu, 15 Oct 2026 08:05:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792051526;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hizciGezkNVmQYGYbBprMjy2D4s67nJXBhT12Tp8D2Q=;
	b=P0L+h1Pq3GxupHBmgU3pO5XTYcDhPVYdUsbE/ZiJbR6bsxmVXBUFNU6uakEhfshHCBYcsX
	EEpjMDQk7JwcGeOg7kr59WNlCLyjrNNdFvTjREFIcgGC7kI8dgeoMmBXTTbsqLwzpat8eR
	EJX+79fXhk0/Irywt501l9m5SeAZFrplSIiccukVhe8zrsPmVtnMnfnom2rSOo2LfUypq5
	MqkLbSSeYBZzcBgXvoKIWMhB8sKfkhQAIX1E5DoFlki4K4HAmrB5y7wFakVgkvYLwxb9ba
	mBGBpcz/Muk0itbgY6DTgwiolWhVqLn4p0AQIMdmraGpWPT3I7BtDojKFsMwuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792051526;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hizciGezkNVmQYGYbBprMjy2D4s67nJXBhT12Tp8D2Q=;
	b=xebLc5Tdm5zXsF+2w5cZj+ShoiwyaoZvAXGlNmaHENWutJk43M3yfBzakq3BYg+UPrWDg+
	LeW4L8Uw2YzbOUCg==
From: "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] futex: Fix mm reuse handling for FUT_OFF_MMSHARED
Cc: Jann Horn <jannh@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260929-futex-mmshared-fix-v1-1-262b1ffeb3d0@google.com>
References: <20260929-futex-mmshared-fix-v1-1-262b1ffeb3d0@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179205152504.2666988.5711075487071894551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     3267512ad1c2cc0c7768c5b014dc2cceb398a801
Gitweb:        https://git.kernel.org/tip/3267512ad1c2cc0c7768c5b014dc2cceb39=
8a801
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Tue, 29 Sep 2026 18:31:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 14 Oct 2026 15:11:48 +02:00

futex: Fix mm reuse handling for FUT_OFF_MMSHARED

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
Closes: https://lore.kernel.org/r/CAG48ez0dLBpc3QtbAhMMVNHwHL94iHh2G+h-=3DBVF=
R4dDuzZr1g@mail.gmail.com/
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260929-futex-mmshared-fix-v1-1-262b1ffeb3d0@=
google.com
Cc: stable@vger.kernel.org
---
 include/linux/futex.h       | 19 +++++++------
 include/linux/futex_types.h |  2 +-
 kernel/futex/core.c         | 51 +++++++++++++++++++-----------------
 3 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 18ed18d..a895d8c 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -23,28 +23,32 @@ struct task_struct;
  *  01 : Shared futex (PTHREAD_PROCESS_SHARED)
  *	mapped on a file (reference on the underlying inode)
  *  10 : Shared futex (PTHREAD_PROCESS_SHARED)
- *       (but private mapping on an mm, and reference taken on it)
+ *       (but private mapping on an mm)
 */
=20
-#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inode */
-#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm */
+#define FUT_OFF_INODE    1 /* We set bit 0 if shared key identifies an inode=
 */
+#define FUT_OFF_MMSHARED 2 /* We set bit 1 if shared key identifies an mm */
=20
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
@@ -152,11 +156,10 @@ static inline void futex_set_vdso_cs_range(struct futex=
_mm_data *fd, unsigned in
 static inline void futex_fixup_robust_unlock(struct pt_regs *regs) { }
 #endif /* !CONFIG_FUTEX_ROBUST_UNLOCK */
=20
-
-#if defined(CONFIG_FUTEX_PRIVATE_HASH) || defined(CONFIG_FUTEX_ROBUST_UNLOCK)
+#ifdef CONFIG_FUTEX
 void futex_mm_init(struct mm_struct *mm);
 #else
 static inline void futex_mm_init(struct mm_struct *mm) { }
-#endif
+#endif /* !CONFIG_FUTEX */
=20
 #endif /* _LINUX_FUTEX_H */
diff --git a/include/linux/futex_types.h b/include/linux/futex_types.h
index d320c05..34b16f2 100644
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
index 095f9fe..a240638 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -439,45 +439,51 @@ struct hrtimer_sleeper *futex_setup_timer(ktime_t *time=
, struct hrtimer_sleeper=20
 }
=20
 /*
- * Generate a machine wide unique identifier for this inode.
+ * Generate a machine wide unique identifier for this object (inode or mm).
  *
  * This relies on u64 not wrapping in the life-time of the machine; which wi=
th
  * 1ns resolution means almost 585 years.
- *
- * This further relies on the fact that a well formed program will not unmap
- * the file while it has a (shared) futex waiting on it. This mapping will h=
ave
- * a file reference which pins the mount and inode.
- *
- * If for some reason an inode gets evicted and read back in again, it will =
get
- * a new sequence number and will _NOT_ match, even though it is the exact s=
ame
- * file.
- *
- * It is important that futex_match() will never have a false-positive, esp.
- * for PI futexes that can mess up the state. The above argues that false-ne=
gatives
- * are only possible for malformed programs.
  */
-static u64 get_inode_sequence_number(struct inode *inode)
+static u64 get_object_id(atomic64_t *object_seq)
 {
-	static atomic64_t i_seq;
+	static atomic64_t last_assigned_seq;
 	u64 old;
=20
-	/* Does the inode already have a sequence number? */
-	old =3D atomic64_read(&inode->i_sequence);
+	/* Does the object already have a sequence number? */
+	old =3D atomic64_read(object_seq);
 	if (likely(old))
 		return old;
=20
 	for (;;) {
-		u64 new =3D atomic64_inc_return(&i_seq);
+		u64 new =3D atomic64_inc_return(&last_assigned_seq);
 		if (WARN_ON_ONCE(!new))
 			continue;
=20
 		old =3D 0;
-		if (!atomic64_try_cmpxchg_relaxed(&inode->i_sequence, &old, new))
+		if (!atomic64_try_cmpxchg_relaxed(object_seq, &old, new))
 			return old;
 		return new;
 	}
 }
=20
+/*
+ * This relies on the fact that a well formed program will not unmap
+ * the file while it has a (shared) futex waiting on it. This mapping will h=
ave
+ * a file reference which pins the mount and inode.
+ *
+ * If for some reason an inode gets evicted and read back in again, it will =
get
+ * a new sequence number and will _NOT_ match, even though it is the exact s=
ame
+ * file.
+ *
+ * It is important that futex_match() will never have a false-positive, esp.
+ * for PI futexes that can mess up the state. The above argues that false-ne=
gatives
+ * are only possible for malformed programs.
+ */
+static u64 get_inode_sequence_number(struct inode *inode)
+{
+	return get_object_id(&inode->i_sequence);
+}
+
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
@@ -683,8 +689,8 @@ again:
 			goto out;
 		}
=20
-		key->both.offset |=3D FUT_OFF_MMSHARED; /* ref taken on mm */
-		key->private.mm =3D mm;
+		key->both.offset |=3D FUT_OFF_MMSHARED;
+		key->private.mm_seq =3D get_object_id(&mm->futex.unique_id);
 		key->private.address =3D address;
=20
 	} else {
@@ -2055,13 +2061,12 @@ static void futex_robust_unlock_init_mm(struct futex_=
mm_data *fd)
 static inline void futex_robust_unlock_init_mm(struct futex_mm_data *fd) { }
 #endif /* !CONFIG_FUTEX_ROBUST_UNLOCK */
=20
-#if defined(CONFIG_FUTEX_PRIVATE_HASH) || defined(CONFIG_FUTEX_ROBUST_UNLOCK)
 void futex_mm_init(struct mm_struct *mm)
 {
+	atomic64_set(&mm->futex.unique_id, 0);
 	futex_hash_init_mm(&mm->futex);
 	futex_robust_unlock_init_mm(&mm->futex);
 }
-#endif
=20
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long a=
rg4)
 {
