Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44B3264DA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883278; cv=none; b=KYzBXZqCp0kzSLX8Q4W20yCsXiIT4qctoOgqR2gDgqfxHZaFzL8ydl2fNzxagUARlObT/QKefl7qb31tD6wJtNRHGOBD8v9z53RYqd/r+9PafuQxiYFj3NBUQQDkrzOYwvsO8FHZUnvCFydFCu4nLAWszhKKK3EP7fuMdnIXMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883278; c=relaxed/simple;
	bh=eonQwjnfTylx5nf+Z0eLclQat7oseADBCMWg0WIsjEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmmTvZptE0nHng2HSBuMDrWZ/8DQy+3AkEsH5g4Ip1tiWoUkHqYIVWUg+99pEDPSXdyLYSlqr94fqddiLFaQdg8wWzsujkAbh7AsCXsRAU5O97e0X0hi8UohPLRKh/7FS/6NmBlvqXdvQNLlzRSGjMZnfW49ZNQlaLhX+QkWvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieisQqqV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieisQqqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F651F00A3A;
	Tue,  8 Sep 2026 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883276;
	bh=b/zczYjUm1o9A90ER1GkMq1ItUs03Oz9WOj/KNR/B5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ieisQqqVXVt5AgDF/2B62hTvvnIU2RAYsg8b0ByBQTM7sg9ZDMDQtetrAmEJz5rPK
	 +Dr4TxjqBglhyyo1ortm7SBat9MwU0/LlWFKSdfrzxLMtxOnBXDl3Js8BQLC5ifHCy
	 UPML5wSxQPWlH5u47WxH8+0xbsOQgsg9UZ9bv1w9QgMxJAefB2BSVxih5G2lzkYrFh
	 CZnaUCmx8xYoukbzDdxKjZbmHFDwSNbQ7svk5jjdq0tyG94OYWcu9Ntx7PGagibk9c
	 pUelNfECaJzPB0bs9RUIo29GaaxvGlpNxuQOW36TfPu+S+UAuEiEjuPhuqK/ymBHR6
	 BdVfRa2R420ZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] jbd2: use shrink_type type instead of bool type for __jbd2_journal_clean_checkpoint_list()
Date: Tue,  8 Sep 2026 12:01:12 -0400
Message-ID: <20260908160114.2547081-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090337-idiocy-unfocused-cf1f@gregkh>
References: <2026090337-idiocy-unfocused-cf1f@gregkh>
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
Stable-dep-of: f213e12ff5c9 ("jbd2: check need_resched() when skipping busy checkpoint buffers")
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

