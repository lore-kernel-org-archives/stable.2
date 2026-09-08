Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE3366075
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883305; cv=none; b=Q1AssYHeQY8jyOFpcRW/JS1JPOFQ4L/krsiLR0ocD+rGfQRCkRfemWiLWADdXvyecDy3EKxy4EBlD1s6VWCYkzz06wOgeL+WmDrjraGlDXHT0nz/XbqeeJIPvtqvFk02fZAwVip2NTWjYKuXPc4AMUcfz8JIUy80sG7iR4F4W4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883305; c=relaxed/simple;
	bh=JaRb13rDS3Q1xtQjU1WFDem75y0S4YGjWZnCiRvXmBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef4qDRiiyDIxvPpWu2m/xT1k4KT1irNGfHVi42E3l2W5KBqA36YkdMuZfFqqdlgcAV2IYjw9c06/TX9ADEOOkfcstorfQSo1dDxDQ6YEuP3to2chGTSwf0CCxE8+pC7f+fw/FWAIqPFHp+ygej3Sae4axsLWgG8fn6O71/3Hxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/7akEGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/7akEGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB7B1F00AC4;
	Tue,  8 Sep 2026 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883303;
	bh=yjkITvPudPW608k/wYA8fzapaYRZukvJqBQCP9eG0S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l/7akEGIaLm276o+MyXCbpgzwuKbrYaapGXsU53V+J194iso1FOY/OztpdNvP69cj
	 k7mF/QIXBN0bYizbBdnLwh1yGIs2h8UNkGdMCYksQogt2YFqTJfYXJl2CoauNQSsxD
	 d4SxptqW3yHwzn7fn4tzlNfROCx3SqR6arev1PL8OhzApd6XYOGFudKS9QgXyIZR+J
	 gFgy70zLrczM4WmgO9zCqV0dX2am8fHp+XtqjFKH8EemqkYaICdtJYjuc1kV1bpdVp
	 zwsnaBBJ1+tW0oK+nk2dWPB1fZx6j6wGgpjp1dHAk2/exNSZhP4GqVO7NByefLMwRt
	 tMQnA97+a6wGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] jbd2: use shrink_type type instead of bool type for __jbd2_journal_clean_checkpoint_list()
Date: Tue,  8 Sep 2026 12:01:39 -0400
Message-ID: <20260908160141.2549593-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090324-reemerge-botany-12c4@gregkh>
References: <2026090324-reemerge-botany-12c4@gregkh>
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
index 32ed28cfb3a0b..29036bc9135f8 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -355,8 +355,6 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
 
 /* Checkpoint list management */
 
-enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
-
 /*
  * journal_shrink_one_cp_list
  *
@@ -493,21 +491,25 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
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
@@ -548,7 +550,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
 			spin_unlock(&journal->j_list_lock);
 			break;
 		}
-		__jbd2_journal_clean_checkpoint_list(journal, true);
+		__jbd2_journal_clean_checkpoint_list(journal, SHRINK_DESTROY);
 		spin_unlock(&journal->j_list_lock);
 		cond_resched();
 	}
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 84663ff7dc505..4de8b49afd226 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -501,7 +501,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	 * frees some memory
 	 */
 	spin_lock(&journal->j_list_lock);
-	__jbd2_journal_clean_checkpoint_list(journal, false);
+	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
 	spin_unlock(&journal->j_list_lock);
 
 	jbd2_debug(3, "JBD2: commit phase 1\n");
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 7dad9b761cbce..9f498fef91cd4 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1451,7 +1451,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
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

