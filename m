Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA649DB9B
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883602; cv=none; b=VO2sAWxTo/E1aM6VX9/NET/TpaHMiO6GeQOismoIbxswE+otpZ2ap3171J1x6/bIk50pEL675wo2iQHkt6kyhWtRMshL+nUM8tLZyUUVMJ/wsbN1PvS7ejSzAuaXzSEkXiF5lv7LHAG/bTItT+lklIOt0WoFf80Ki2iioO4Y/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883602; c=relaxed/simple;
	bh=25sTc89D7ajOWg1O6evZeAkZ91jbCS7pRJhJQVclku4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGOTL8DMHh72VLbWJMKVXiq5jisJIa/7RlM8rJVAGkU81BgONwtj/DthMMlhIwXOEsovZgx1kk6+zWzrOXaxpNJ5CRzuA2zz06OJUPTsM/+Lk4WypUj7eHMQXw3CWDkrbh2TpszPtrEHrFoxD6GuvNJaEsxYP02FaLp7Dx7yjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDvCSMF2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDvCSMF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06351F00A3F;
	Tue,  8 Sep 2026 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883600;
	bh=IgzmZNtsr+GH3uuNWzaZmgVNBlYFKxNuhRuUiFji7u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eDvCSMF2GpF0VQc2WkHEh45YrynO2G+yCiMRLorkHYYLQq02U9Nre5+ARjpzDIk5S
	 6al6fgB53etGKUsTPXYjArl4YXmMj4SqySb0wEioHWh3064K9scNIalU+2xL1gPsah
	 i5isfXnivPtT5Nqy+r7SCiom86S/7l6U8KZmgmjG0kO/egXqTpyBONFdv5FB50Nl49
	 UaDJN2sTtAr1jMW4Wn6FRNnaUE6JW1YmEtIRRCXJyZEgc4VY1wgiKHqeSFkee8gFle
	 W+18CivD+sAu//7XohWNDPXKm74N0A4vVWMSwzWLSqIW2KQVMC75o75vB/gGCfZ2yc
	 ELkC2TXZroD2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] jbd2: add prefix 'jbd2' for 'shrink_type'
Date: Tue,  8 Sep 2026 12:06:36 -0400
Message-ID: <20260908160637.2569758-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160637.2569758-1-sashal@kernel.org>
References: <2026090337-absolve-bonnet-5b19@gregkh>
 <20260908160637.2569758-1-sashal@kernel.org>
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
Stable-dep-of: f213e12ff5c9 ("jbd2: check need_resched() when skipping busy checkpoint buffers")
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
index 182d2c39ff0a4..53908eb74c58f 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -536,7 +536,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	 * frees some memory
 	 */
 	spin_lock(&journal->j_list_lock);
-	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
+	__jbd2_journal_clean_checkpoint_list(journal, JBD2_SHRINK_BUSY_STOP);
 	spin_unlock(&journal->j_list_lock);
 
 	jbd2_debug(3, "JBD2: commit phase 1\n");
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5583d735d4bf3..221e7dc87a296 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1435,9 +1435,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
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

