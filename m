Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794634464;
	b=D3eSNiY2YtSq41aLIx1LttrKBQ0pK363df9gi4UGAUWYPsEoT6N0OjMdk/K6Qyj1/pXz
	 bAxpkV5lg3M5MT5caZyfJCgpaPFL3TgUnfIWrTvup2GUfWDnIrD8B7u/yz9p1rsDiDuF+
	 IADjuSLwgT8cDZzaawTFjuDwHXn45do1uc14FRSYziPupu0tq3l+cRZxm1/wk0lORB5rq
	 uBB5ApL+OPyLiWZIcs+mHsC4p7H3kdrFoyWuNghKYM2PyZrJTyuSOt/jGSllLfKsPn/hw
	 BEM9jTYYakpWRPGeYg0daSZYv2WFyKM5xNs25YO1sGpyBuzej1XX50m1rdFepBSlV1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794634464;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zPvbwgVC0WA/qfAih4aLx67Xfb+m0t2N5WaKKKP19ig=;
	b=MTwSTRzRP2xkvMRJMWt63GXNdfqDVte0owoEjYMTKzYIraga1kgy6fUwqqa+TB2Cboqq
	 N/9Q7OkLnvpneCFD5SmZrpeO3yK59W8v8ZH2MEUiKAqQu1N7X76TC4Hzpm7t4DyHTcSPV
	 b1yDyaCi58X7w13jmSDbJynmN5Mce3KWNaYnYgq2Wa6bHzOl80KvpD0+6cGL+/Nrvsr8J
	 9RB6lXyrZI/gd3kTrIKcQY/uFDNqj6mIHxDOSZWVVbpvQo5nz315MiXY+mpI1lpGgvBuE
	 DxKVXnQwA+RkTnZTgbRkX6OcV1bB0mrDE3ZNX352XjB8+XoRvPTyoUWAM+fDDaiNWEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5mFvHTX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9981606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5mFvHTX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490DC1F000C4;
	Sat, 14 Nov 2026 05:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794634464;
	bh=zPvbwgVC0WA/qfAih4aLx67Xfb+m0t2N5WaKKKP19ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c5mFvHTXf4wJizR7XCZQlotjwhjzHeraWuwY5SZayMTOOBj7rqpx1m5MGGpTw3hrg
	 9R+5v5a/0Hw4aBb9IqzoWR7yHn9OoWZ9PMSsJTPzJyZ/0AkT0/rXEyfdHeijzOYz6t
	 q03NUzGxm2tTdtQ/TeA6VnR1shkfSwpmqN2DZotY/rZkgzDKETQgfFF/moIVRJZLtK
	 R9EfQ6TSZqghVfM72jlTb8SBZk0pH5zXh+HjCeWXe4R3k9rl+ULs0KqDRGtlSW5Uly
	 hUlYIOgZ21AB9LRrMQqm18TGyG2t2nm1wdKGaMaTIA9LxG1xqNVLn+8R6bXJUv0BXC
	 z3t0//MI+FGRQ==
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
Subject: [PATCH 6.6.y] fork: take mmap_lock before copying mm_struct
Date: Sat, 14 Nov 2026 00:34:22 -0500
Message-ID: <20261114053403.3113729-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201122-failed-6.6-ef694e2d2101@kernel.org>
References: <20261109201122-failed-6.6-ef694e2d2101@kernel.org>
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
[ sashal: Adjusted failure handling because dup_mmap() already performs uprobe cleanup, avoiding a double unlock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/fork.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index fd10c6e0dcfa3..625f9bd101dbb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -655,11 +655,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	VMA_ITERATOR(old_vmi, oldmm, 0);
 	VMA_ITERATOR(vmi, mm, 0);
 
-	uprobe_start_dup_mmap();
-	if (mmap_write_lock_killable(oldmm)) {
-		retval = -EINTR;
-		goto fail_uprobe_end;
-	}
+	mmap_assert_write_locked(oldmm);
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
@@ -670,11 +666,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	/* No ordering required: file already has been exposed. */
 	dup_mm_exe_file(mm, oldmm);
 
-	mm->total_vm = oldmm->total_vm;
-	mm->data_vm = oldmm->data_vm;
-	mm->exec_vm = oldmm->exec_vm;
-	mm->stack_vm = oldmm->stack_vm;
-
 	retval = ksm_fork(mm, oldmm);
 	if (retval)
 		goto out;
@@ -782,7 +773,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
 	dup_userfaultfd_complete(&uf);
-fail_uprobe_end:
 	uprobe_end_dup_mmap();
 	return retval;
 
@@ -813,7 +803,7 @@ static inline void mm_free_pgd(struct mm_struct *mm)
 #else
 static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	mmap_write_lock(oldmm);
+	mmap_assert_write_locked(oldmm);
 	dup_mm_exe_file(mm, oldmm);
 	mmap_write_unlock(oldmm);
 	return 0;
@@ -1695,10 +1685,18 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
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
@@ -1717,7 +1715,10 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
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

