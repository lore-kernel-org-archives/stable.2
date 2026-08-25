Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3B3D45F7
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670592; cv=none; b=nuERCoDsCTaQ3GHZ2lUaw7y6B+MOj6Xh+cJPaKWRlLXeMukx3TYB9wOB4pfafmCyzKLlsYd+hNsBc5hRBW9k76PzFVw++AlyhmggURz/gok/2zbCsEdHsMP6OtWt9tcyxpRYwqt10TQU6ne5g7xeuk5rUiVwbrgIw88YOPQwLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670592; c=relaxed/simple;
	bh=eTtoLDO0X2tL6IGPikJ5fOl1esotQFNoDj+An8OC9Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUtyhE3Z6WRwjzpB34DMjRsbYfPaXPbn3xvXVWIWSXL05g+3HEF+69vToln4avb0ZFnZbGZoePjYB/oHub+wMNOS3KegjVUhvjzQQwastzWo9NnNUdcqWrucKbqtbrSX0fP07QjYZyQ2MDbenKctDRW5psxXwUxR+TdULfaV0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGPJ2Ek7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGPJ2Ek7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C6C1F000E9;
	Tue, 25 Aug 2026 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787670589;
	bh=veJ0TVM41N4pCX+O/Wmh2IVWKr0X5/WYaPX6Um2ob6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UGPJ2Ek7lNIH4N2D//ZRR4ULsfGDailRDemTwd9gabkYyiNRK998ut8Hy/knltmYf
	 gZGTOU4FqXrKFGQ5tzs//4Y8gaEuknIe87S2DcfWLOnnNRLZX/YC6PfWkoXQs89XeY
	 2BluJBepGZ/FLiFywen13sfp73NJudsnM8H3RzEzs/jNl43t5j04IoaQvyZLaucuuq
	 F1OeAfejA2+5fjIQbG2h+o92qzfNNcQYP3dt4Yy2skU2ANyjLm43x1c1Lj81VDB0dd
	 6j91aSHcgaBc3PGZWmE8Y4VLD4qBHRz/3HtB2OKkqApJ2Z+qM3tgQZcT9F/o+TTPkn
	 w2qp38J6Pt8kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] futex: Make futex_mm_init() void
Date: Tue, 25 Aug 2026 11:09:46 -0400
Message-ID: <20260825150947.4024767-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082454-wharf-swapping-5328@gregkh>
References: <2026082454-wharf-swapping-5328@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit d7b3f52c861f54ba2fff15696d3798277fb4c19f ]

Nothing fails there. Mop up the leftovers of the early version of this,
which did an allocation.

While at it clean up the stubs and the #ifdef comments to make the header
file readable.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260602090535.356789395@kernel.org
Stable-dep-of: 1c7efabfbaf7 ("futex: Avoid private hash use-after-free on final put")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/futex.h | 28 +++++++++++-----------------
 kernel/fork.c         |  8 ++------
 kernel/futex/core.c   |  3 +--
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 9e9750f049805..87559766319e1 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -85,22 +85,20 @@ int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
-int futex_mm_init(struct mm_struct *mm);
-
-#else /* !CONFIG_FUTEX_PRIVATE_HASH */
+void futex_mm_init(struct mm_struct *mm);
+#else  /* CONFIG_FUTEX_PRIVATE_HASH */
 static inline int futex_hash_allocate_default(void) { return 0; }
 static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
-static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
-#endif /* CONFIG_FUTEX_PRIVATE_HASH */
+static inline void futex_mm_init(struct mm_struct *mm) { }
+#endif /* !CONFIG_FUTEX_PRIVATE_HASH */
 
-#else /* !CONFIG_FUTEX */
+#else  /* CONFIG_FUTEX */
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
 static inline void futex_exec_release(struct task_struct *tsk) { }
-static inline long do_futex(u32 __user *uaddr, int op, u32 val,
-			    ktime_t *timeout, u32 __user *uaddr2,
-			    u32 val2, u32 val3)
+static inline long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
+			    u32 __user *uaddr2, u32 val2, u32 val3)
 {
 	return -EINVAL;
 }
@@ -108,13 +106,9 @@ static inline int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsig
 {
 	return -EINVAL;
 }
-static inline int futex_hash_allocate_default(void)
-{
-	return 0;
-}
+static inline int futex_hash_allocate_default(void) { return 0; }
 static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
-static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
+static inline void futex_mm_init(struct mm_struct *mm) { }
+#endif /* !CONFIG_FUTEX */
 
-#endif
-
-#endif
+#endif /* _LINUX_FUTEX_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 5a4623b058a20..ded98330429d0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1106,6 +1106,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
+	futex_mm_init(mm);
 
 	mm_flags_clear_all(mm);
 	if (current->mm) {
@@ -1118,11 +1119,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 		mm->def_flags = 0;
 	}
 
-	if (futex_mm_init(mm))
-		goto fail_mm_init;
-
 	if (mm_alloc_pgd(mm))
-		goto fail_nopgd;
+		goto fail_mm_init;
 
 	if (mm_alloc_id(mm))
 		goto fail_noid;
@@ -1149,8 +1147,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_free_id(mm);
 fail_noid:
 	mm_free_pgd(mm);
-fail_nopgd:
-	futex_hash_free(mm);
 fail_mm_init:
 	free_mm(mm);
 	return NULL;
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 6b3121c734bb5..cfaa96c009320 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1750,7 +1750,7 @@ static bool futex_ref_is_dead(struct futex_private_hash *fph)
 	return atomic_long_read(&mm->futex_atomic) == 0;
 }
 
-int futex_mm_init(struct mm_struct *mm)
+void futex_mm_init(struct mm_struct *mm)
 {
 	mutex_init(&mm->futex_hash_lock);
 	RCU_INIT_POINTER(mm->futex_phash, NULL);
@@ -1759,7 +1759,6 @@ int futex_mm_init(struct mm_struct *mm)
 	mm->futex_ref = NULL;
 	atomic_long_set(&mm->futex_atomic, 0);
 	mm->futex_batches = get_state_synchronize_rcu();
-	return 0;
 }
 
 void futex_hash_free(struct mm_struct *mm)
-- 
2.53.0

