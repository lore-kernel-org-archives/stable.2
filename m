Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE81212FAD
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671997; cv=none; b=nK1xe8NcTpLdnIxMKaGbjJh6KXwtNy7AifBaoUeAHMoZb3m8ZhfMAEISXIOcRIU6TVBa4KEQt6D5BnYQd70tt5jFNrP6aH7FRbJfqHX2s84ONc4AgHLsdlzWCA4ki2CQweG6CDbMXomXMh/hyBfKibtETVVKQq21xgmxustSNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671997; c=relaxed/simple;
	bh=t2W2kOAWL2q8Ns5J2Aq0KB1MztshE/8TC4URFPJduAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3HTJ0S3wuo138bxsZIBg/U9YInP0l/1DXQ5pUka7xTwyhqGeogq9l2LS6qStCQ1QuUUtIAjUL45p6lK7c00Nl0TiffnSqKvy7cZh0wpTPuEkEfNkQIdM/ht6EDfOKHVnL/NrO1BktwV0IZZG4+Solzdc7IDkTCqKPJMmUUSkNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV8PnwIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV8PnwIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117971F00AC4;
	Tue, 25 Aug 2026 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787671995;
	bh=a4LJOegN9TCCBfnw8edQKpZJIiE4Xeryw3RuQ3h/rdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IV8PnwIKBRUuJYamjnW3Inhpe/P+JBx2Eu5byKLxla08T9itDfL+2u3voldncdRKI
	 UmossG5FKBnIMP3kSkIn7DXWjNUodhWebxzR0g1uRmsFHvqUq/A3YaF+ezxJzR1EI5
	 mjFaZ1a+/VT7BjthpEIxnRb7YU2Nd68NYhKa0FFgd0ZRXwNEE/x9TOvqjYQQtmYVTg
	 EnOYhJE+Rkx9jYbypJlDOACRTFFFbgH/rDYRPUpcAL03guA4+yydeKsxoYf/5QBaqA
	 N5hocjL1zDASinpZK+xZucr4/dkfiV+yy1f/WWaGwD3QlbKGLHG9rB4rjyA+88YHcb
	 t6rvuALhNXD2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] futex: Make futex_mm_init() void
Date: Tue, 25 Aug 2026 11:33:12 -0400
Message-ID: <20260825153313.4066171-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082454-obligate-cultivate-908c@gregkh>
References: <2026082454-obligate-cultivate-908c@gregkh>
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
index 91f1512a1d312..ccddeba6790a4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1062,6 +1062,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
+	futex_mm_init(mm);
 
 	mm_flags_clear_all(mm);
 	if (current->mm) {
@@ -1074,11 +1075,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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
@@ -1105,8 +1103,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_free_id(mm);
 fail_noid:
 	mm_free_pgd(mm);
-fail_nopgd:
-	futex_hash_free(mm);
 fail_mm_init:
 	free_mm(mm);
 	return NULL;
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index fde558fd2bd60..f43d8c9e28a66 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1747,7 +1747,7 @@ static bool futex_ref_is_dead(struct futex_private_hash *fph)
 	return atomic_long_read(&mm->futex_atomic) == 0;
 }
 
-int futex_mm_init(struct mm_struct *mm)
+void futex_mm_init(struct mm_struct *mm)
 {
 	mutex_init(&mm->futex_hash_lock);
 	RCU_INIT_POINTER(mm->futex_phash, NULL);
@@ -1756,7 +1756,6 @@ int futex_mm_init(struct mm_struct *mm)
 	mm->futex_ref = NULL;
 	atomic_long_set(&mm->futex_atomic, 0);
 	mm->futex_batches = get_state_synchronize_rcu();
-	return 0;
 }
 
 void futex_hash_free(struct mm_struct *mm)
-- 
2.53.0

