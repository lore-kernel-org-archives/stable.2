Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794635635;
	b=cyksv8qvr5LU292HnT27gnO3lZvSyyC1ObP16h+UXdxVoUUgtOlof7lRubyt8Huo56K5
	 8thRGpUBKVPr5Pir7vh6xftyitXuoYAqOjtVbGalNLKNAVs70vLscvNeAbOumuOZf10Ik
	 r83ZrRlkl8aP305Jq2RpJBP1/S9KhqKBmQpOB4fIQfcL2AM7R9WmijTF+Ia6FadCBFCU7
	 ktyyxN5S6nMgdQ8DLxMk0nyg+UT+c598GE5LJtXwkJoeFLzIxo+IFMF0+Jvr322viaUU0
	 4Hd1cqdd4AH0TTmoxYBo2qnlvzMOyx5/yU1ZhIfFAvCdS3sUhtU1cn2sjcUXoAj731g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794635635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FmMwO0w87fdXeOxEYTgSpJTzGstYLRm3a6PfF/BMWDs=;
	b=ukAhTmGXEPhN/6kHObJTM0U42sKlqGisaEGi9jEuULqo9C3NriCrTTr5gFDjRSIvSUWB
	 wmjqZ54ieUZultGMX3rafOht7gek7Uu2m2aGDbLxuMx7T+T3IB0g4dX4CDEtZBGWqcH+N
	 7WfrLtYBVwC+fwBFDms9QYqEnkLjxvUc1V9AiJzxQBFk/OMPQ1YOHAQdvKHzTgWWXChcg
	 wFMlPEQ5kRcsKmGABXJfQjOZco78HMR7677/wSPKHESYJ7P+KEtjwg7XPej2NsKxE7MNT
	 WLhjE8X6OatdtUwrZ9IVVI/EaN0e4xgoBNvx0nlztWfShjWy5+x9CDyQIPZG/5uk7PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mi+YzcPq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A564606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mi+YzcPq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB921F000C4;
	Sat, 14 Nov 2026 05:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794635634;
	bh=FmMwO0w87fdXeOxEYTgSpJTzGstYLRm3a6PfF/BMWDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mi+YzcPqMMFK8lpf4PX2oWIAMyAYEkclxOltNzPhLIaSAfg+0G/HnR1wkep9w3tl4
	 z9R1UYhWvflS83jTN7gcjkgDlvRf7BkjWOpaacyP7bpaoYubic1adKa+gLWVLYbSR6
	 T9dtA4BtcXsrQhjTWJO4UXGhM2RziU+OB3kQ7TL7pXj8i/aWJvpBn+0T3HAbYm/xoG
	 Sh0YDde7xSvXLUtakY967Q6vtHRkjKsYaUqus3vbESF0unv4SY9/BRPWqo4fXYl6iA
	 8bei+yhy8o1bMhmwXAdSZBZ0Q5pmVAYTL24KnQBYb/LVdRd4QbGWw9DWZ8oUbLrVZv
	 VsjPthuqYIKHw==
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
Subject: [PATCH 5.10.y] fork: take mmap_lock before copying mm_struct
Date: Sat, 14 Nov 2026 00:53:52 -0500
Message-ID: <20261114055337.3174933-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202604-failed-5.10-ef694e2d2101@kernel.org>
References: <20261109202604-failed-5.10-ef694e2d2101@kernel.org>
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
[ sashal: Adjusted dup_mm() failure handling for existing uprobe cleanup in dup_mmap() to avoid a double unlock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/fork.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index c39de3ee8f537..93da8037f1ed1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -478,11 +478,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
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
@@ -493,11 +489,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	/* No ordering required: file already has been exposed. */
 	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
 
-	mm->total_vm = oldmm->total_vm;
-	mm->data_vm = oldmm->data_vm;
-	mm->exec_vm = oldmm->exec_vm;
-	mm->stack_vm = oldmm->stack_vm;
-
 	rb_link = &mm->mm_rb.rb_node;
 	rb_parent = NULL;
 	pprev = &mm->mmap;
@@ -608,7 +599,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
 	dup_userfaultfd_complete(&uf);
-fail_uprobe_end:
 	uprobe_end_dup_mmap();
 	return retval;
 fail_nomem_anon_vma_fork:
@@ -636,7 +626,7 @@ static inline void mm_free_pgd(struct mm_struct *mm)
 #else
 static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	mmap_write_lock(oldmm);
+	mmap_assert_write_locked(oldmm);
 	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
 	mmap_write_unlock(oldmm);
 	return 0;
@@ -1375,10 +1365,18 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
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
@@ -1397,7 +1395,10 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
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

