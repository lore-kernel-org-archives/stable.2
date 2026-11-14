Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633951;
	b=MpQpAtF8l87zMmwW/QfAcVX3Cal9JsdS0v+tFavt01uvV7sFYFb+BsNNxNUxvqlDYeQI
	 9Z+wdTc81rRyGFMDs8S5huHu96CVSR16qpkD6hG6ZwJCkr9329M0fivUem8sH95bwn8Pc
	 N4mGqJCwj2AW3nKBTXAWIrkfFs+RbXMBO8duinUNRpmGcQTJo9ID2t6RmYb7joIn5BnR0
	 FGitbszQsDB0hI+2cUTiKqt3KxMs9UdPKtWARucDudd1Fk6eA1e1saxtsV59YJdhdR8LC
	 Rm++7PzYOJvBOT5Ft87M1T1GqxCeb7+lzUhGrva2cluPN1krK9Qi/wGmreiEiDWANWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Pt00E6EePNE8b8GKdGufzELxtl6phO/EBWMq4zxuXP4=;
	b=2u4s0NfG5Qp2jfAWIV4krhaOg/+2mHJZ3CB7vviChTW2uNA9Jd3c1gkFDMiLxYQ+QwpD
	 lh8KWyyuu5Rq+Pmi6wcilS4jP1j9KNPqfecoRsfPwqCgq7OszbPoU7FGD2mqWO5QPj5X6
	 gTw5dtKTETcDvITICQ3qeiRbauJNcj+A++bGlFGcUn8fjj2nJrrs2nIMrii/IpQWdccB5
	 n6iElt5lE6+jLqxBVQ4MlJk3p1IY97v9MYqQnXvCp8MKeksbzpbkydBnSlDYIexHGsDTb
	 LVxP1jPOBNCF/hnw/a7pUs6FCU7QI7jh5epxj/vYDSS7A3VXlws93Vx2RVLR+c/mg7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxLOZiAG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0045606A332
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxLOZiAG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457701F000C4;
	Sat, 14 Nov 2026 05:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633950;
	bh=Pt00E6EePNE8b8GKdGufzELxtl6phO/EBWMq4zxuXP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LxLOZiAG/eiMuSDo9y8qhQARdH38Q6HZbPeo3guOpGo3ymPhJhn1itN4lWKAja1AG
	 k8aNLGKOnrdIa2xluxmzk5dQls5fJWH6r7qXSPfM1DoIYkJYSegmEhkY7BHH53nw45
	 yKUAbNp5Tw1TZywvGNjirtAY1++H5TKiqSkRP71MZYde7UE4o3JRUFZqbXSQKr/SqE
	 Y5jUe5geuVZsyydAK3v3PLGnLkINtlSGCK+rZD+xgFraTFEb8IfIFdDgg8zDQv7/Xv
	 +Lmmed2Gg+Sbf/RifYRdziHUUh5fus9mKva2d5IiOJWisfOpDzkiUWBPePGWKUZ8fb
	 Nkqjw+geUHKcw==
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
Subject: [PATCH 6.12.y] fork: take mmap_lock before copying mm_struct
Date: Sat, 14 Nov 2026 00:25:47 -0500
Message-ID: <20261114052533.3081626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200703-failed-6.12-ef694e2d2101@kernel.org>
References: <20261109200703-failed-6.12-ef694e2d2101@kernel.org>
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
 kernel/fork.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 140a615daf42e..af3c8be386efa 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -641,8 +641,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, 0);
 
-	if (mmap_write_lock_killable(oldmm))
-		return -EINTR;
+	mmap_assert_write_locked(oldmm);
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
@@ -653,11 +652,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
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
@@ -824,7 +818,7 @@ static inline void mm_free_pgd(struct mm_struct *mm)
 #else
 static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	mmap_write_lock(oldmm);
+	mmap_assert_write_locked(oldmm);
 	dup_mm_exe_file(mm, oldmm);
 	mmap_write_unlock(oldmm);
 	return 0;
@@ -1705,12 +1699,19 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
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
@@ -1729,9 +1730,10 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
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
-- 
2.53.0

