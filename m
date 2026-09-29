Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA57538D88
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699505; cv=none; b=ICcpbWn08sp37Cvesd7tVGA02uBuQB4IHjRadnwEs+31KDN5hxAhkptMpiACrmjRgeERmoDHfVmliR1PnhPkXD0244BmN4Qr4/X1WYLqrPQrkx8tr0YKvqATeeqKe1nk+LQQP/k4z9eanUt07m25ApvMSWHeswSo3JSeQKpWhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699505; c=relaxed/simple;
	bh=ACkbBal0nlT1sxSxF2JEsy4COwHihI5bTLwhlQYWO1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Efuw3Ekw1rzXIe/ZiWQNusdff2njwMajgrEWafHk1cXxLnWUHXIEZs5pIccZljgOOEf53dtY0vjCzc4ksQ1PZOrhow9fWbxQmTe4t4SmKJAGGi8hwDPXHx3O9mEhLVXH/YzzDDF8pcGnMWKl3XYgKxbNh7GoA8AsVGMf0coVuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b30fVjaF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b30fVjaF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49e6425f96eso52655e9.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790699501; x=1791304301; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2FO00La5ZtkB/p1RA8QGR+OID5CnVwwV2duHKQoCTfQ=;
        b=b30fVjaFSJIXchzO/H/0nNWDhI/lYpT3c81gaZN4MYBDSih16M3g2M9/zu+RHEY5QQ
         gmmLYSGvgSsY+dHtciKVzQzerjHd8TaBrMKDY/4sqAgtn4oxEKXgx/p4NUqRG8VBn+yB
         xFi5RJJ33hfBIfpeEDv4pA2w7TzlN1qphW/cguk259MDx+GngWo9pXJ+gxqyLSirQ1+n
         DlmRGKDCGGg4tZoyNXKbF9VjPp7L1Vf1ltPh6Z/rB7DQ4HnwkV8/x6PzpWAuxsbJtYms
         AqsTFOcZ27nzpxwRnEIFyET/JCPhTYb2rDHbVtCIY12awVSNi4yihFESA4jmJ04kREXY
         E5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699501; x=1791304301;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2FO00La5ZtkB/p1RA8QGR+OID5CnVwwV2duHKQoCTfQ=;
        b=iUxekcdz8tFuQPn7Bci1es3Q5iB26niot6FwP2zRfJd3HWkoKBqKKKH2MJN88S2dOU
         espCL/ahPTUE9OV9ZVkUQzkUt9I/Uu5wIcyYtEUXzNwAUAB4NCW3WEmHuGdYi/qnhbdf
         aCALh2RGDmlUN1CBTDzDbZbA8Jchc2g4T1w0yLz/vk2ukk9pyw/9rbeOMsO1Y68RzlfJ
         gH/dvtDSD9r3V/sO0vIZIcKDSw3uczBwig87/5dCSxV8IHsmhR8bioVVQOWCxssK/irR
         3LkVeT/Zyw9GmZ2IoAAD/ghtWBE49+8lz1f9XK3xQZr7g4GQqKxspWqD0XTm2rK68jlU
         lMMg==
X-Forwarded-Encrypted: i=1; AKwUvByP6dSOjK/uQe81wblfbsJO3m/HCfzMmwIzdxpRF9Ltwx0xSSr89ZZfIC1A8ayA50WnoN7By+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++naMud3E7e1nag1W0YreJ8d+tDMtki0Ru5e/0aRDqBQ32ZKU8K+
	8slI2iOiKDGE2fFkRzH4Hb65iKB/247QKbBBrz8GorAxPfi9VBtwisKTrIE6KVQdaw==
X-Gm-Gg: AYBFou1tw9tEuyYZoeGfuVxgQhfdjtCJqkKeqQKjo5hDU01RTmhaucy0tfQHkSFE9CC
	kBHMrj63sVwT4zQFRUQ3wJf/aywuwFYffGj1gkPLsSt/RUtsaDeLySk4Jozm1RDytdT/fF6868G
	9FmqBHKeIQVKIskpVhTKKrlNegFBU1fZPxm41/BAOdyqAORplP4vkzi7yVO840CDpPSkhFdTfb9
	9o6XYfd8twKAbl04IcE48UAWlSD6NKl5hHCfEEP8tpc2aoIHfUaORtTidP9TLVDY3JYZnSmmetV
	FTQ9L7f1xPp8g4jV9Coy04oF6ycukg0aJA/n/oksG5pHEypglm67h+tNr4ShsUcr3d6DyC5yPu9
	29RYNwuA7MiH50zDmxYYHla7Ky4qXeOn+jMxbAs+xFFoq3iCWWdXho3aHl26RJr8SiGdIFNuhFq
	e0IueoH3VN1ezD95YwdyTUfEq+BjGL+mlTBGVlnEa7HSvD6dKxsSDj+7WsnNKvEN0BSoUhYHEmg
	SfPUOw1LtucN2VER/gTDED3Om5mUHvrQkWIkotxLKyI3Lm22nz/frT7sTMbnGIUKI/6TQ==
X-Received: by 2002:a05:600d:8487:20b0:49f:e8bf:c6e with SMTP id 5b1f17b1804b1-4a00e44f039mr810245e9.1.1790699501078;
        Tue, 29 Sep 2026 09:31:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:5882:1599:48ff:7c0e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5049419sm4740891f8f.14.2026.09.29.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:31:39 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Sep 2026 18:31:32 +0200
Subject: [PATCH] futex: Fix mm reuse handling for FUT_OFF_MMSHARED
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-futex-mmshared-fix-v1-1-262b1ffeb3d0@google.com>
X-B4-Tracking: v=1; b=H4sIAOPnu2oC/yXMUQqDMBCE4avIPndBIxrTq5Q+aBx1BbVktQji3
 Zvq4zcw/0GKIFB6JgcFfEVlmSOyR0J+qOceLG00mdSUqTOOu23FztOkQx3Qcic7W1+VeWGdRVZ
 QPH4C4nxFX+/bujUj/Pov0Xn+ALW1xdV2AAAA
X-Change-ID: 20260929-futex-mmshared-fix-7c8635797e15
To: Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790699495; l=7765;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=ACkbBal0nlT1sxSxF2JEsy4COwHihI5bTLwhlQYWO1I=;
 b=Fk/TfOftOkeMqQKaGdIKYO5VZnfh6TA3w/IH4chtdUxhXSFH09I+KJPkevzvWTsxHJehUL4os
 1WpxJmf9cYpB4TiEUhrZ9qrcmTb7UrVI4kw/SIBRPIK7F/aPAftiLot
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

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

Cc: stable@vger.kernel.org
Fixes: 222993395ed3 ("futex: Remove pointless mmgrap() + mmdrop()")
Closes: https://lore.kernel.org/r/CAG48ez0dLBpc3QtbAhMMVNHwHL94iHh2G+h-=BVFR4dDuzZr1g@mail.gmail.com/
Signed-off-by: Jann Horn <jannh@google.com>
---
I've added a stable tag since, due to clear_child_tid, this can
probably be used to prevent pthread_join() from completing in
another process or to brute-force the addresses of pthread
instances in other processes.
---
 include/linux/futex.h       | 19 ++++++++---------
 include/linux/futex_types.h |  2 ++
 kernel/futex/core.c         | 51 +++++++++++++++++++++++++--------------------
 3 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 18ed18d5cbc1..7eb645e49dd4 100644
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
@@ -152,11 +156,6 @@ static inline void futex_set_vdso_cs_range(struct futex_mm_data *fd, unsigned in
 static inline void futex_fixup_robust_unlock(struct pt_regs *regs) { }
 #endif /* !CONFIG_FUTEX_ROBUST_UNLOCK */
 
-
-#if defined(CONFIG_FUTEX_PRIVATE_HASH) || defined(CONFIG_FUTEX_ROBUST_UNLOCK)
 void futex_mm_init(struct mm_struct *mm);
-#else
-static inline void futex_mm_init(struct mm_struct *mm) { }
-#endif
 
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
index a061f54b606d..3593d8a328e9 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -437,45 +437,51 @@ struct hrtimer_sleeper *futex_setup_timer(ktime_t *time, struct hrtimer_sleeper
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
-		u64 new = atomic64_inc_return(&i_seq);
+		u64 new = atomic64_inc_return(&last_assigned_seq);
 		if (WARN_ON_ONCE(!new))
 			continue;
 
 		old = 0;
-		if (!atomic64_try_cmpxchg_relaxed(&inode->i_sequence, &old, new))
+		if (!atomic64_try_cmpxchg_relaxed(object_seq, &old, new))
 			return old;
 		return new;
 	}
 }
 
+/*
+ * This relies on the fact that a well formed program will not unmap
+ * the file while it has a (shared) futex waiting on it. This mapping will have
+ * a file reference which pins the mount and inode.
+ *
+ * If for some reason an inode gets evicted and read back in again, it will get
+ * a new sequence number and will _NOT_ match, even though it is the exact same
+ * file.
+ *
+ * It is important that futex_match() will never have a false-positive, esp.
+ * for PI futexes that can mess up the state. The above argues that false-negatives
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
@@ -681,8 +687,8 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 			goto out;
 		}
 
-		key->both.offset |= FUT_OFF_MMSHARED; /* ref taken on mm */
-		key->private.mm = mm;
+		key->both.offset |= FUT_OFF_MMSHARED;
+		key->private.mm_seq = get_object_id(&mm->futex.unique_id);
 		key->private.address = address;
 
 	} else {
@@ -2053,13 +2059,12 @@ static void futex_robust_unlock_init_mm(struct futex_mm_data *fd)
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

---
base-commit: 6f8319e3e9a44dd537d17f41565a8453c560a581
change-id: 20260929-futex-mmshared-fix-7c8635797e15

Best regards,
--  
Jann Horn <jannh@google.com>

