Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794635169;
	b=BB50zxrrgpvGNUunwFbMr7XbNamn1rUehI/fRc1jbw/xp4kG21xmbw2iMqeeH9E6EQkc
	 /eYBLCTuSf+x4BLVt5ChBMmfGk3/S6lSiuUr2dK7Qqnun+GJm8MvgSmZUqokvzTswi6gc
	 VbzkPu9xyjuxCH6iSF6bmF7931vzPao6rYPdGkiqHEV/GC5zzIU0wlC+So1Wy7uv0IbZ0
	 6CXQWltEbxQSnvlCSafU8st/l2Cw3HeaxTDDL1hWxQzUYZsmpKhiwcoHVBquIf3+/drep
	 dw+KMVEJRb4sIdMHigzE8PI88pzvC+OtKFKTm1GLjsb8hbLD0LSIf+Mg+dt0Dcun8Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794635169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SaBoJxFtgEE5TteqGNDMjUW+Z4PmuN7DRirHn6mRlWA=;
	b=AXxpNMKG8uYfqlP4spRFA4SkhxcjHZdrL585OXl2ML5ZbhOO4qnnLE2ve43TunJ6mWOU
	 TM0i9Fdfm6wmq2U8JD2cRYFB93HpyqNtQTMbuohOYsHx9MDJES9tlXgZSxCgq7f4w8YQN
	 OxFKuODUUkoZ8ZzVxziXSlmTJbXSnbbPzhRbDmfyhx73HV1QVqp/ObQk5Iia3NA8HFUjT
	 2tvtJ84rdPkv6Kf+zK2xRRUZbZitnka/B8QQXAHYaxkmahSV/3qjc+lWnmiHdFzvVQvDy
	 oZIPG1/SI9Ev4NHqI6W/J0do5yDKNVaej5zs+M+MnnAj6CBg010R5TWS4/jfgGOxD9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7pgftlJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D70606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7pgftlJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4231F000C4;
	Sat, 14 Nov 2026 05:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794635169;
	bh=SaBoJxFtgEE5TteqGNDMjUW+Z4PmuN7DRirHn6mRlWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O7pgftlJcgcx14cupXJgMp/x+LXZgk681484qBNlP8TA5InnF8E9PU1r7J6NxNB0R
	 z61r3v023EG2Lta1GfXsMqf0N1oWKOL1GEnIfnvBxrEEur21FlVXYpZvfhNc384JcK
	 YzLNNYcdyS1RWOhWU4B08ENG3kpcMjcK4HzWvHhBAI+Jo8lKUX74KZoutNlz+0J6PU
	 uVmCbO741Iykuic8oi1a7++0pJh+egwlMApZSWZJA5MKialUswAxY5Ok9auF9s6i35
	 u6xIOAgS9C7dKuiOaxzC93VRqEdafEwp0k0+hJjWUDAwqPnxDH0Hg1t+uD7vrLxjOI
	 UV5PG+P56dGhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Harry Yoo (Meta)" <harry@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	SJ Park <sj@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fork: take mmap_lock before copying mm_struct
Date: Sat, 14 Nov 2026 00:46:06 -0500
Message-ID: <20261114054550.3140816-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202104-failed-5.15-ef694e2d2101@kernel.org>
References: <20261109202104-failed-5.15-ef694e2d2101@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit ef694e2d210111cc08c52fd25da9ab130170bfa3 ]

dup_mm() copies the parent's mm_struct before dup_mmap() takes the
mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
and newer heap mappings, causing later brk() requests to fail.

Other operations (e.g., PR_SET_MM) on the parent's mm_struct can similarly
cause inconsistencies.

As a simple and robust fix, grab the parent's mmap_lock earlier. This
way we don't need to update individual mm fields in dup_mmap() and
keep missing ones. Stop updating the 4 existing members (total_vm, data_vm,
exec_vm, stack_vm), as that is now no longer required.

Keep releasing the parent's mmap_lock in dup_mmap(), before
userfaultfd completion, to avoid moving the userfaultfd handling into the
caller. This should get cleaned up later.

Move uprobe_start_dup_mmap() to preserve the lock ordering.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-2-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Adjusted caller cleanup to avoid a second uprobe release after dup_mmap() has already released it. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/fork.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 87c08297fbee6..1f7f0f9c821c8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -501,11 +501,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	unsigned long charge;
 	LIST_HEAD(uf);
 
-	uprobe_start_dup_mmap();
-	if (mmap_write_lock_killable(oldmm)) {
-		retval = -EINTR;
-		goto fail_uprobe_end;
-	}
+	mmap_assert_write_locked(oldmm);
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
@@ -516,11 +512,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	/* No ordering required: file already has been exposed. */
 	dup_mm_exe_file(mm, oldmm);
 
-	mm->total_vm = oldmm->total_vm;
-	mm->data_vm = oldmm->data_vm;
-	mm->exec_vm = oldmm->exec_vm;
-	mm->stack_vm = oldmm->stack_vm;
-
 	rb_link = &mm->mm_rb.rb_node;
 	rb_parent = NULL;
 	pprev = &mm->mmap;
@@ -628,7 +619,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
 	dup_userfaultfd_complete(&uf);
-fail_uprobe_end:
 	uprobe_end_dup_mmap();
 	return retval;
 fail_nomem_anon_vma_fork:
@@ -656,7 +646,7 @@ static inline void mm_free_pgd(struct mm_struct *mm)
 #else
 static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	mmap_write_lock(oldmm);
+	mmap_assert_write_locked(oldmm);
 	dup_mm_exe_file(mm, oldmm);
 	mmap_write_unlock(oldmm);
 	return 0;
@@ -1467,10 +1457,18 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm)
 		goto fail_nomem;
 
+	uprobe_start_dup_mmap();
+	if (mmap_write_lock_killable(oldmm)) {
+		free_mm(mm);
+		goto fail_uprobe;
+	}
+
 	memcpy(mm, oldmm, sizeof(*mm));
 
-	if (!mm_init(mm, tsk, mm->user_ns))
-		goto fail_nomem;
+	if (!mm_init(mm, tsk, mm->user_ns)) {
+		mmap_write_unlock(oldmm);
+		goto fail_uprobe;
+	}
 
 	err = dup_mmap(mm, oldmm);
 	if (err)
@@ -1489,7 +1487,10 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	mm->binfmt = NULL;
 	mm_init_owner(mm, NULL);
 	mmput(mm);
+	return NULL;
 
+fail_uprobe:
+	uprobe_end_dup_mmap();
 fail_nomem:
 	return NULL;
 }
-- 
2.53.0

