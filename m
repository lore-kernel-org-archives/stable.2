Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633466;
	b=j/QcHaIlZX47FRIpMnkfPFCIJThORO71Ro4KxSyLKiYPuamy3WixjxVYdqUim+1z2awC
	 z6/QU0lFwVNiiX+sQZEvSTXLs5JVud9SWboTEYW8X8DSR67ozOzAofGGgaWQkHIhwZ9qX
	 AB/wq7NUWpjjkDzTotxiBeq3CSaDe8N1FlIRU0E/96PqArkv5Hu0+z+0WgzpybUPDLiGm
	 cWAv/WEBa3Oo6mKN8ouMRy7jEUm23PmTw1JE0kDXcJ/pv9z/sRFE2RZOsPZQQm+MuCfNd
	 a9bc+NxIQs0CSz7h6gTCSZ7PCKxp5DQoL0KSfa0wAWSvfD4+O4zaV+RTnvKwFp4ovLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633466;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FuxYxFoxGXf9cqFfbP0L04E5xaO0r5INxg5NN3OxeDg=;
	b=i+3iYsYMKKWbQkAEehDiW6sghVwbvJGssfE8xegZ8JKn1yAcqVnZdnqdX2BVpo1fYoQs
	 WdHVIHAQ5JGV6UaXdUmtXb1EtpluQo4fESXGZkjTUMco5VrRCc01nzroojYJjmbYafF62
	 R+flHXrhcsHZ4ylbRoLLBmFa0Jtnmmru60JTHjie4CG9gEdlURiqxgLlAafOcyEFz4TG+
	 h7aEhIw+qJVQ/sw2nGwA8JCvoQBUNMaIZJOixrxaanI5huSrcw7TFHY3ykYz7TyHW7MND
	 eSngeMrMjaFpdTyGAsnKLTrucgR1fsLJV39MGeIQ2EllpNfnMlwi9d7wAqS8VgPPIUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MZYF/09y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D751606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZYF/09y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CF71F000C4;
	Sat, 14 Nov 2026 05:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633465;
	bh=FuxYxFoxGXf9cqFfbP0L04E5xaO0r5INxg5NN3OxeDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MZYF/09yJc0YyXXi8qX50yKYozHxRrhqTWlpvbjxX7DuCyqPeECqIvdzdIbmnFFYQ
	 qf279lrz9NF6rQnJPTV7FN2WY0mmxqQB+n5VU7REM7KdMlD3g6GHprXRl/SX85QJ8U
	 KFdpsmDLj3T8z0qmrB5/8KXxvHqX9dxGyttHbEzHJILysmJLwn16rHDx7W3F9EMiD/
	 W1cdQCqRMn6WNTTODDCnTSiLCyszLHtWL1UYULQOzUz4B8Gj3nZNOlOJAiMzE/kWEX
	 wD/pL0b9nN20eWoMnCHDQhNbN0njTGKQTQ3s68FRlpnmKkQt+zLD9F89Ho0Rr5aYgz
	 Gk/lVfkvjDqyg==
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
Subject: [PATCH 6.18.y] fork: take mmap_lock before copying mm_struct
Date: Sat, 14 Nov 2026 00:17:43 -0500
Message-ID: <20261114051728.3052394-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200309-failed-6.18-ef694e2d2101@kernel.org>
References: <20261109200309-failed-6.18-ef694e2d2101@kernel.org>
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
[ sashal: Retained mm->user_ns as the third argument to mm_init(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/fork.c | 20 ++++++++++++++------
 mm/mmap.c     |  8 +-------
 mm/nommu.c    |  2 +-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index bc6078b910a6a..e38d2de6c6b52 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1487,12 +1487,19 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
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
 
-	uprobe_start_dup_mmap();
 	err = dup_mmap(mm, oldmm);
 	if (err)
 		goto free_pt;
@@ -1511,9 +1518,10 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
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
index b29b31a29ef66..9bf16cc92f185 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1724,8 +1724,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, 0);
 
-	if (mmap_write_lock_killable(oldmm))
-		return -EINTR;
+	mmap_assert_write_locked(oldmm);
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
@@ -1736,11 +1735,6 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
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
index d609ecdcf022b..be977f0dd0c10 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1896,7 +1896,7 @@ subsys_initcall(init_admin_reserve);
 
 int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	mmap_write_lock(oldmm);
+	mmap_assert_write_locked(oldmm);
 	dup_mm_exe_file(mm, oldmm);
 	mmap_write_unlock(oldmm);
 	return 0;
-- 
2.53.0

