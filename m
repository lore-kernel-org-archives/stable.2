Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794634638;
	b=rET1t01lVyTrqw6p36AUVbAAzBYF0PEMk5iZnkj0g4CvrfZvhlTUCAOMNhrMmoTMST+u
	 Mb7sIxnKlqcax195Kd+qILSsYm7/NQzS2aMBEGodYp9S+f70RXTpuNes1ZAozfkU2QsT4
	 0vv10FMVukIsuQX2C8Ah2zAj9hh6BQ9YAYVLwW+tQtJK3jNRxgyotXqpmZ1PFNxXZjLJa
	 mSL/per3SsqQM/iMZBeTFSbOYVQIWbJggu9iLHZW5n+ogVPOY1Jzc9f99CG+chSsYFlfc
	 Fpk+6jzo7uRCskd/dqaPaMc9S6MqyUk7V33kt5qs5SxHkZVEdFxu2/6bVLNdZxgD19Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794634638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=A+B/2k0XZ4jbCMLVul/4B+ZFajOkCVQf7jWERboXVh8=;
	b=jDoz0m4B1swxbedgAXIJ/u3FSSIb/B/mqj3adG8/AevWG9qTVKYBY6dK6PCwJr1k4x4K
	 Sms/IOh4oPg5FoazGw9Hr6Hsy+Zreipc5JXh4ktLYoUxECa3/43Lzi0Bmkt9YpPkRJjlv
	 LYnjaQx+EuTSYCNgCr/exSNPJM96gKFIvOpq0tHUqEYGSmiYWLrrNzPw0gbjY2Woo0eLC
	 J206sVmZo9slAu+BHPb3M/xn7VrqGFRlehVNWGUB7Tj1c63QFlTh3piKRkpxjZ+j7tZbJ
	 Xj5RP4TI7qE4xHUvzGu1iMJmxzrFxq+Ra72nOeCXkQErOd6qp2N5EcerO51PaWe2Wgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDGh605L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD32606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDGh605L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A421F000C4;
	Sat, 14 Nov 2026 05:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794634637;
	bh=A+B/2k0XZ4jbCMLVul/4B+ZFajOkCVQf7jWERboXVh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDGh605LFpohgVMNLwYThHLHHL+kiuaADlcrvjD0IHPryfpfRiKDvHcK7jSQjRg4R
	 2DBRW5mEaEsnrZBiAyYKsqPVOMgqE4Fyh2G+u2CWvHsNFx94xdkt4KOcxtjRWiBVV8
	 ZcMAP9+i2VHLXS/o2gfimnyYlg626sZ7MvQ4PHVaIJASg2NQgN2dNnJL0TIdxKqbPQ
	 Z8hQ2aH5cdMRlI97QGrsN3UIFb4+0fA3P7MFmlYPkn5J0HjpSGSapVXMlV5zCBOpnK
	 q+P2iraAsWmdLUm6wcn7YDvCj2az/atgwD60TBSa6dpqQfl+Lr3atjodzVddzzWYKl
	 cpw6lwEBIvB0g==
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
Subject: [PATCH 6.1.y] fork: take mmap_lock before copying mm_struct
Date: Sat, 14 Nov 2026 00:37:15 -0500
Message-ID: <20261114053658.3135284-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201555-failed-6.1-ef694e2d2101@kernel.org>
References: <20261109201555-failed-6.1-ef694e2d2101@kernel.org>
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
[ sashal: adapted uprobe error handling to account for cleanup already performed by dup_mmap() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/fork.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8a8d55a9ffa03..411c2b427ea85 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -591,11 +591,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
-	uprobe_start_dup_mmap();
-	if (mmap_write_lock_killable(oldmm)) {
-		retval = -EINTR;
-		goto fail_uprobe_end;
-	}
+	mmap_assert_write_locked(oldmm);
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
@@ -606,11 +602,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
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
@@ -720,7 +711,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
 	dup_userfaultfd_complete(&uf);
-fail_uprobe_end:
 	uprobe_end_dup_mmap();
 	return retval;
 
@@ -751,7 +741,7 @@ static inline void mm_free_pgd(struct mm_struct *mm)
 #else
 static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	mmap_write_lock(oldmm);
+	mmap_assert_write_locked(oldmm);
 	dup_mm_exe_file(mm, oldmm);
 	mmap_write_unlock(oldmm);
 	return 0;
@@ -1548,10 +1538,18 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
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
@@ -1570,7 +1568,10 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
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

