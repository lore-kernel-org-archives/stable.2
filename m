Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805C55D88B
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883846; cv=none; b=gHR1A2zsTw+Wdzu6PnyGdUClr/hbTaChLzK4RGDVI9LUeG0UtK6mEloIXpzxJAo03ioR+t5Cy3zeugHlM1qUL+9igLV8nntF6XGrkouOaMRsHLBmdlDR/FIgumsZwKcssMflTn70rnk50Eyq2wHhHLzY8eZZN9F5JWaXSy5G4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883846; c=relaxed/simple;
	bh=BH853UXiMZ4gPk6q+yBvXONn9nKBVwv1S+hPtZWGNNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYJXgrfWbOUEKBIMxIitHzUflB/45fnI0dCPEqGKezbW+4cVayrMGUd+xIT/3Kx3plrAjrI4PzfiiKbNtZkVaTjzJhWxCR2stt3l3xew7D5AEBNlSKdYTSH8WYxSHT8w2RYDR+E8cs6jEO63dfZWRV3WNDNxummB3XDJzJefD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTpI+ojB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTpI+ojB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CEB1F00A3D;
	Tue,  8 Sep 2026 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883843;
	bh=uaHOEYWP80xxjhkaT+/Bn7k5I4zTTYBP+g86aB9zMXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTpI+ojB8YpndV02QsEWjE3b+Yc4eOqIaskvcrZiLe+fTm/pBYi1l1qIU5VB3n+fk
	 fwpBT4KRbzBj08Ujx9tjXVmL1bm+V8hHINLPCQHXXlmRfAr/5/LcInv6h6zp3KqEif
	 WGqReKxualwcdokD+x5Q0FSezCvr30bjqEIwR4+y2u0E9bYnyyqVNCf4nTxP6QgwHg
	 qzmR5mJoEplYG2MeWmJZdNHE7e91L7B0g0Su+Xp14WXPoEFDUNkAwvCXb0CqZClRb0
	 Y14N5Q3y7ZCb/a0DBn6LaubGvtRk0w9Iw60YLuN27gGJcN6Bh88oiahrdCWAkdYHOv
	 TaeuRnr2oO07A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] jbd2: add prefix 'jbd2' for 'shrink_type'
Date: Tue,  8 Sep 2026 12:10:39 -0400
Message-ID: <20260908161040.2593291-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908161040.2593291-1-sashal@kernel.org>
References: <2026090324-scorer-unbutton-3de6@gregkh>
 <20260908161040.2593291-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 26770a717cac57041d9414725e3e01dd19b08dd2 ]

As 'shrink_type' is exported. The module prefix 'jbd2' is added to
distinguish from memory reclamation.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://lore.kernel.org/r/20240407065355.1528580-3-yebin10@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 15cb16496446 ("jbd2: bound shrinker scans by examined checkpoint buffers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/checkpoint.c | 22 +++++++++++-----------
 fs/jbd2/commit.c     |  2 +-
 include/linux/jbd2.h |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 9fcc68884e262..36c64cf44e005 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -378,7 +378,7 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
-						enum shrink_type type,
+						enum jbd2_shrink_type type,
 						bool *released)
 {
 	struct journal_head *last_jh;
@@ -395,12 +395,12 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		if (type == SHRINK_DESTROY) {
+		if (type == JBD2_SHRINK_DESTROY) {
 			ret = __jbd2_journal_remove_checkpoint(jh);
 		} else {
 			ret = jbd2_journal_try_remove_checkpoint(jh);
 			if (ret < 0) {
-				if (type == SHRINK_BUSY_SKIP)
+				if (type == JBD2_SHRINK_BUSY_SKIP)
 					continue;
 				break;
 			}
@@ -470,7 +470,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		tid = transaction->t_tid;
 
 		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						   SHRINK_BUSY_SKIP, &released);
+						   JBD2_SHRINK_BUSY_SKIP, &released);
 		nr_freed += freed;
 		(*nr_to_scan) -= min(*nr_to_scan, freed);
 		if (*nr_to_scan == 0)
@@ -503,20 +503,20 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
  * journal_clean_checkpoint_list
  *
  * Find all the written-back checkpoint buffers in the journal and release them.
- * If 'type' is SHRINK_DESTROY, release all buffers unconditionally. If 'type'
- * is SHRINK_BUSY_STOP, will stop release buffers if encounters a busy buffer.
- * To avoid wasting CPU cycles scanning the buffer list in some cases, don't
- * pass SHRINK_BUSY_SKIP 'type' for this function.
+ * If 'type' is JBD2_SHRINK_DESTROY, release all buffers unconditionally. If
+ * 'type' is JBD2_SHRINK_BUSY_STOP, will stop release buffers if encounters a
+ * busy buffer. To avoid wasting CPU cycles scanning the buffer list in some
+ * cases, don't pass JBD2_SHRINK_BUSY_SKIP 'type' for this function.
  *
  * Called with j_list_lock held.
  */
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
-					  enum shrink_type type)
+					  enum jbd2_shrink_type type)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
 	bool released;
 
-	WARN_ON_ONCE(type == SHRINK_BUSY_SKIP);
+	WARN_ON_ONCE(type == JBD2_SHRINK_BUSY_SKIP);
 
 	transaction = journal->j_checkpoint_transactions;
 	if (!transaction)
@@ -562,7 +562,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
 			spin_unlock(&journal->j_list_lock);
 			break;
 		}
-		__jbd2_journal_clean_checkpoint_list(journal, SHRINK_DESTROY);
+		__jbd2_journal_clean_checkpoint_list(journal, JBD2_SHRINK_DESTROY);
 		spin_unlock(&journal->j_list_lock);
 		cond_resched();
 	}
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 33113c01f6fc6..5a45e31530264 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -535,7 +535,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	 * frees some memory
 	 */
 	spin_lock(&journal->j_list_lock);
-	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
+	__jbd2_journal_clean_checkpoint_list(journal, JBD2_SHRINK_BUSY_STOP);
 	spin_unlock(&journal->j_list_lock);
 
 	jbd2_debug(3, "JBD2: commit phase 1\n");
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index e3d371565da85..a5cff8024f767 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1443,9 +1443,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 extern void jbd2_journal_commit_transaction(journal_t *);
 
 /* Checkpoint list management */
-enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
+enum jbd2_shrink_type {JBD2_SHRINK_DESTROY, JBD2_SHRINK_BUSY_STOP, JBD2_SHRINK_BUSY_SKIP};
 
-void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum shrink_type type);
+void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum jbd2_shrink_type type);
 unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
 int __jbd2_journal_remove_checkpoint(struct journal_head *);
 int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
-- 
2.53.0

