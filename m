Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AB5650E4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883600; cv=none; b=sZeABcgauZi9adgIrf1HrbakkNn0+Oux1jzz7GCrx5svfEWl+UPr6L3N860c+8CTVlRvyj8f8uT/nH2dpYPaIb4Ax7/r2QkAGnB2QBmToJl9uyEdZeqrv5GIn6cfhe5TvX5Jmjor3b0hUc65IAgqRTgfwSc4Iera8Iq3KaHQD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883600; c=relaxed/simple;
	bh=fdRgsLojLicdsgJE81db3AVAp3wiIh5tDVvI5A174ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1uuSLOvJxWpOHXssQFfvwMqAze/Z0nzf0ZBBHqJw36PwpZcEe5rZNaO44SWt/Gb/X94LX7S7X/6i7b8Sp9fJeX8qU7nsXa55B62iSx2F9wvTi5m1tNFL22+x4ztvZguw9sWa63mjGFjsLEQIYoXRT2oMV0SkAUCh6CuC0W+YVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy0ulFDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy0ulFDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AAB1F00A3D;
	Tue,  8 Sep 2026 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883599;
	bh=QGikPdbNuW+lu3OQqcky+s+Sp3Z6Y2ZZN3/Ms7OXIo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fy0ulFDOfaA+sT2QhJMhfa4hgmSGpvvi524lpicbXOjyqyxE7fodtAYW68yl2509c
	 P8C/D+TXCu7TtkGymHB4D8mbg/qo3yPTGz40jc6hTsUWDnWeivCKqXgXEQuWBhhJXY
	 x1sWos4+N9sYqb4PnA35Lb4KQxngnJEzDPBp0gGySvJkvHMloFnZLWHe15q1lLOmYw
	 npYyBJTuqovso0CJ+U6+Y1f3hR6C/FA1wdmZPz3+nSoQwVplPeSzTgXMLpK8qgZFsS
	 efY1xLIlE89BL2oWacahHcTLYjpkBLapA0wQxMtzHR+/8zI8uHFEsbYpigF2fch/0j
	 dQkGeLONSstcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] jbd2: use shrink_type type instead of bool type for __jbd2_journal_clean_checkpoint_list()
Date: Tue,  8 Sep 2026 12:06:35 -0400
Message-ID: <20260908160637.2569758-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090337-absolve-bonnet-5b19@gregkh>
References: <2026090337-absolve-bonnet-5b19@gregkh>
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
index 9b2225ab5fe5a..182d2c39ff0a4 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -536,7 +536,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	 * frees some memory
 	 */
 	spin_lock(&journal->j_list_lock);
-	__jbd2_journal_clean_checkpoint_list(journal, false);
+	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
 	spin_unlock(&journal->j_list_lock);
 
 	jbd2_debug(3, "JBD2: commit phase 1\n");
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5377df8c85453..5583d735d4bf3 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1435,7 +1435,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
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

