Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272826;
	b=GEkfF5rUMop4b4ZCklPgZoshAkwCdEHBp6hWpZWyctBUBLEaoeuF0oEeVx4roqVWD4Ix
	 0PEvMdLer9lV9Y1ple8kkW4zlqGWK8yKePisBE35t2clHpUN5pcZ0ktXeoOcLlDjv2wXe
	 co9SVV2z5cuGgqriwcozUCA/ue51hJ1wzM2uW5PNqqyjgqYspc6itrvRHeSnjfAtQODMF
	 suJ61B4AYvGylEwCbi3FOQg4sfT5wkgkeq3jzRc6XQRp2NmKNnp52UWftmNuDhnLiUM70
	 p/GNMzCdbRKUrplmtHSxnunW6G82WSU0vQBAlI9tkf9iZ7qhY5C6Fc12pNn8OObLsAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nRgxPyfxGPAewG1rA76kiwUDDZlz01yQM5soIyUZy4g=;
	b=ZirNDqhv/o9mzWlMb1QROsGzqt24zTnNumEjpb8u8ngDuTb4Hgk6LJLNIbC4/Sd+ngFv
	 o0uoMNLsrzA7GAOav+g2FGE76BeOdC1YNHZqAD+00P0WXbSIuE+/tE5dq/9h6oW2DJRSy
	 9oRFQA4T/XYjCSN7bbiBxbTJcqq5UgUxp893CC6ooQUQs2aYjnqGC83T4F5ynsRBt5TxO
	 ER/cn9NP5M7qMWENxZ+cazKDjB8ESnrQRdT4lcOELYdXVL8ioN5BKEYZsLWP9H+Qi4c1r
	 LaX1EQ9C5VVxqa5dt1SypoSK62Y0agME5Nc5SC86taAAKp6tYm6M32pxw9e3Y9joH6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTqS7hqZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702BE606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTqS7hqZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EAA1F0089F;
	Tue, 10 Nov 2026 01:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272826;
	bh=nRgxPyfxGPAewG1rA76kiwUDDZlz01yQM5soIyUZy4g=;
	h=From:To:Cc:Subject:Date;
	b=hTqS7hqZp6RpokEH9ayl+Q+4TawfXqxxJKhGi8hR/wQ/tqk2FREIgisUj8pTNDanE
	 xUFgGSNT/BuTJOQbcmQtPPlsZEqeDuDGFAuIcMTeRP84nm0BW8ols5RxAItxU+u7fv
	 o6jH+7KLkqJ8SOs5CJn9/8YwEhaMqUMKgj1bUC4dKmRyg9IAkbAaTgVbJyDyXCRl5O
	 Ahz6nQke8pDek5Dc1yexCFDCQsl0bYx69f6j8d/p8Qeb+wI9uTvZZhS7UYJdB4/vdi
	 U2pOLAag0vEy8uxM6D6X/ao1QqFVQ27yZb1WUblAWd+G1HCJZG44odnUnzb+bQPkN6
	 SzJun67ZzoW5g==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	ljs@kernel.org,
	riel@surriel.com,
	vbabka@kernel.org,
	baohua@kernel.org,
	pfalcato@suse.de,
	harry@kernel.org,
	kas@kernel.org,
	sj@kernel.org,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fork: take mmap_lock before copying mm_struct" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:07:03 -0500
Message-ID: <20261109200703-failed-6.12-ef694e2d2101@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ef694e2d210111cc08c52fd25da9ab130170bfa3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200703-failed-6.12-ef694e2d2101@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ef694e2d210111cc08c52fd25da9ab130170bfa3 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:31 +0100
Subject: [PATCH] fork: take mmap_lock before copying mm_struct

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
---
 kernel/fork.c | 20 ++++++++++++++------
 mm/mmap.c     |  8 +-------
 mm/nommu.c    |  2 +-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8b108ed371529..5efceb8d58a78 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1533,12 +1533,19 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm)
 		goto fail_nomem;
 
+	uprobe_start_dup_mmap();
+	if (mmap_write_lock_killable(oldmm)) {
+		free_mm(mm);
+		goto fail_uprobe;
+	}
+
 	memcpy(mm, oldmm, sizeof(*mm));
 
-	if (!mm_init(mm, tsk))
-		goto fail_nomem;
+	if (!mm_init(mm, tsk)) {
+		mmap_write_unlock(oldmm);
+		goto fail_uprobe;
+	}
 
-	uprobe_start_dup_mmap();
 	err = dup_mmap(mm, oldmm);
 	if (err)
 		goto free_pt;
@@ -1557,9 +1564,10 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	mm->binfmt = NULL;
 	mm_init_owner(mm, NULL);
 	mmput(mm);
-	if (err)
-		uprobe_end_dup_mmap();
-
+	if (!err)
+		return NULL;
+fail_uprobe:
+	uprobe_end_dup_mmap();
 fail_nomem:
 	return NULL;
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 148ba01c03739..7618e72766a52 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1713,8 +1713,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, 0);
 
-	if (mmap_write_lock_killable(oldmm))
-		return -EINTR;
+	mmap_assert_write_locked(oldmm);
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
@@ -1725,11 +1724,6 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	/* No ordering required: file already has been exposed. */
 	dup_mm_exe_file(mm, oldmm);
 
-	mm->total_vm = oldmm->total_vm;
-	mm->data_vm = oldmm->data_vm;
-	mm->exec_vm = oldmm->exec_vm;
-	mm->stack_vm = oldmm->stack_vm;
-
 	/* Use __mt_dup() to efficiently build an identical maple tree. */
 	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
 	if (unlikely(retval))
diff --git a/mm/nommu.c b/mm/nommu.c
index 91ab65afda705..6c6f953296746 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1887,7 +1887,7 @@ subsys_initcall(init_admin_reserve);
 
 int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	mmap_write_lock(oldmm);
+	mmap_assert_write_locked(oldmm);
 	dup_mm_exe_file(mm, oldmm);
 	mmap_write_unlock(oldmm);
 	return 0;
-- 
2.53.0




