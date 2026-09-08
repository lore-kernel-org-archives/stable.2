Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5A5237B3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883845; cv=none; b=AixqQgMQnt+sdK3z/A7D+VdfPA7dr7Ts4/c/bvSyyFg+YyRAZQQkL7Wuy/uTcu8uFb+hQLyXybWvSGLQ+JgY11Q+wjMghnvLcY0P9SKWfoZH+YjqdsKrlDdZNgMF2SbwkdfyK/4qd5Dha3596TaD5ekrEOMjoStEgAbhSvZrLto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883845; c=relaxed/simple;
	bh=9cAy9EUPpF8LU0O+e1ZFQWotsMsird0t4SnlzZmy0NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyMs4uGy4Pnlyx3XKZ4XOIljXdp7S/qU/yHXQRm47DF4jiesC/2kns6vGqvyihh2msOiMUml+fSW0NRnnPFebzLxmkfibrr+54vvVxsHGrR/EjudwJKBb8uASTsGDvW2xGIPKDJSjKyx8+tYz8lMAdcVa/BhvTz6z8rgOwQTwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh+U3um+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh+U3um+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4A21F00A3A;
	Tue,  8 Sep 2026 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883843;
	bh=S/2STTTrZnoc1UunKg28/ATU8ijdkKiWE18ayyWf7Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lh+U3um+tPWaadhVYZPFFHJu23tPtfEVkjAepBY8wvEVjbwtodY9+cPkRnUhUOt/Y
	 Ot8izC7UkfJ1ZP9Bny1j3dyO3PobJMjOG4Gv2N1ZyHmzRVupSfhnnVUMosQw4GZs7s
	 LZyEiWKoy2/GP8Qr3ACU+RmE7vcHBfofKPTk0e166/pVFfqHyeUYUtp0ifpQ50EHcQ
	 W8wB91mnsagyw8saIW08+5XW84c9VXRGAzQQjD1kl8cgyGrDmqFZlZmbx+dRW1526E
	 dcQBqTDerbRDnK4YjTfgl8Awfc7JoOTkBYIGLUQ3PyLBBSb4i7VZWBSlSLh2+9rtsG
	 UbiyR8oOOsFbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] jbd2: use shrink_type type instead of bool type for __jbd2_journal_clean_checkpoint_list()
Date: Tue,  8 Sep 2026 12:10:38 -0400
Message-ID: <20260908161040.2593291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090324-scorer-unbutton-3de6@gregkh>
References: <2026090324-scorer-unbutton-3de6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 078760d950016f5982751f5512e69f26ad8feb31 ]

"enum shrink_type" can clearly express the meaning of the parameter of
__jbd2_journal_clean_checkpoint_list(), and there is no need to use the
bool type.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://lore.kernel.org/r/20240407065355.1528580-2-yebin10@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 15cb16496446 ("jbd2: bound shrinker scans by examined checkpoint buffers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/checkpoint.c | 16 +++++++++-------
 fs/jbd2/commit.c     |  2 +-
 include/linux/jbd2.h |  4 +++-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 10ce0b6b4ffa2..9fcc68884e262 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -367,8 +367,6 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
 
 /* Checkpoint list management */
 
-enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
-
 /*
  * journal_shrink_one_cp_list
  *
@@ -505,21 +503,25 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
  * journal_clean_checkpoint_list
  *
  * Find all the written-back checkpoint buffers in the journal and release them.
- * If 'destroy' is set, release all buffers unconditionally.
+ * If 'type' is SHRINK_DESTROY, release all buffers unconditionally. If 'type'
+ * is SHRINK_BUSY_STOP, will stop release buffers if encounters a busy buffer.
+ * To avoid wasting CPU cycles scanning the buffer list in some cases, don't
+ * pass SHRINK_BUSY_SKIP 'type' for this function.
  *
  * Called with j_list_lock held.
  */
-void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
+void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
+					  enum shrink_type type)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	enum shrink_type type;
 	bool released;
 
+	WARN_ON_ONCE(type == SHRINK_BUSY_SKIP);
+
 	transaction = journal->j_checkpoint_transactions;
 	if (!transaction)
 		return;
 
-	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;
 	last_transaction = transaction->t_cpprev;
 	next_transaction = transaction;
 	do {
@@ -560,7 +562,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
 			spin_unlock(&journal->j_list_lock);
 			break;
 		}
-		__jbd2_journal_clean_checkpoint_list(journal, true);
+		__jbd2_journal_clean_checkpoint_list(journal, SHRINK_DESTROY);
 		spin_unlock(&journal->j_list_lock);
 		cond_resched();
 	}
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 6d02dcad8ffd7..33113c01f6fc6 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -535,7 +535,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	 * frees some memory
 	 */
 	spin_lock(&journal->j_list_lock);
-	__jbd2_journal_clean_checkpoint_list(journal, false);
+	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
 	spin_unlock(&journal->j_list_lock);
 
 	jbd2_debug(3, "JBD2: commit phase 1\n");
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5bf7ada754d79..e3d371565da85 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1443,7 +1443,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 extern void jbd2_journal_commit_transaction(journal_t *);
 
 /* Checkpoint list management */
-void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
+enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
+
+void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum shrink_type type);
 unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
 int __jbd2_journal_remove_checkpoint(struct journal_head *);
 int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
-- 
2.53.0

