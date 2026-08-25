Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066134908B3
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671994; cv=none; b=m8WIwcxk/B5U6l++sI9pGCTszDOjwDKNCp+cSPohBee9QPxj4pmvBXIy/kuWylDVPKGpksByf8uazjzwQ3R0lRmX8tUbWwNxa9aNz3muYyDfgOlQ7hgcU8UX+Q7UV0OO+5xoGtmaUGnrHnoc+deENwng/N65lYVbjV5Wl7sdaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671994; c=relaxed/simple;
	bh=tDcRDFPfDiTkzMjIWTZR1CvlLQQ+SzGHSKVTCtqx2x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2bm9gOCHA1gPkw02M7mMVz25lYVbdSsv+80FVEg9OLniLfSaW/oufeEFtFgwsnAp+JZrlEetFMOyLaOiL0g+hHtwRJ9esrjxdcDIRENqeWT75dFcqvyC4xLuEeZ8SbIX+xiIuO5GX4a5FRDYMD+tJnLIFoW9h2lIMQYVqnpxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWeHk4nu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWeHk4nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB9B1F00AC4;
	Tue, 25 Aug 2026 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787671992;
	bh=rSTSQjP1uFWFxTusOOrVe+TtmpICXhQjuT2+CLNW9BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kWeHk4nua4gZxRy4qpot4xwPGJG+WUV9SNKJvw6XUYhmdsNB1PU4KPthUiVwFd/y5
	 r4KOenmUZ4w7/okVLKza21UHaTj+GAk0RrJ16CJsbR+bG7BJA6F6RiyDZf5t1k/G3d
	 6jnAI09yETZh+9L3N6A24tC09IiDThFUAW/VvQ60YwxeJNXdQ53yOlw0BRZfsxH0zT
	 A3etsmZFS5WyKer0BL6s0iOGPCXx53gDdXrT+NruZB5DwJSGR9ulcpUNm96uoYoUU/
	 WMOXicb6M7d/RFwiPIiQivL1kqfeY7JrxV6rtDl85NDasvwsKQ+g8KBC+zg8cmqrvu
	 EHFhPWuBFwQEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/3] futex: Make futex_mm_init() void
Date: Tue, 25 Aug 2026 11:33:08 -0400
Message-ID: <20260825153310.4065884-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082406-engaged-statistic-82bb@gregkh>
References: <2026082406-engaged-statistic-82bb@gregkh>
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
Stable-dep-of: bde023808364 ("futex: Fix race on the initial mm->futex.phash.ref allocation")
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

