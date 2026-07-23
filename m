Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B377368D6B
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827343; cv=none; b=msUdG6PUT0WLYyenuqMGaI6OvtZz5nR1KsCH7BN3880oZBkltIdhquw0TE0K9S/lVV8MGXlNlEzrgtX8MN4BHY8GXfKe5m0OsUHx1Gudaof4ygyxukIkeg4i93RPs2IzLb/T7OeYSGB5sqaaggsqJKhGeHT2apK6O1ZPLbrKQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827343; c=relaxed/simple;
	bh=j5WCdHhHSkZeR8Eg8tGyVuiR5d4ymb+wt2M4W0jBHxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLi0XMYqIdUOS/ho7xU3ZkOYVlKd92/pdpPhUsEohdpRceAfcgb2JndzLlTuMW9gcYiBs4sBtyPGW2NgUHWVNlhCegTbKC0BVwSKNE8mUVSx31ZjxC9FnHiMNvevCujuwh4PnMpDKzaf+1oZU+qLje/R03nMTPlnRa/R59Tiy7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10BD1F000E9;
	Thu, 23 Jul 2026 17:22:20 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] jbd2: add a helper to find out number of fast commit blocks
Date: Thu, 23 Jul 2026 13:22:00 -0400
Message-ID: <20260723172201.3413360-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072041-pork-untapped-b293@gregkh>
References: <2026072041-pork-untapped-b293@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

[ Upstream commit 9bd23c31f392bda88618008f27fd52ee9e0fac38 ]

Add a helper to read number of fast commit blocks from jbd2 superblock
and also rename the JBD2_MIN_FC_BLKS to
JBD2_DEFAULT_FAST_COMMIT_BLOCKS since this constant is just the
default number of fast commit blocks to use in case number of fast
commit blocks isn't set in jbd2 superblock.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Link: https://lore.kernel.org/r/20201120202232.2240293-2-harshadshirwadkar@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 289a2ca0c9b7 ("jbd2: fix integer underflow in jbd2_journal_initialize_fast_commit()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/journal.c    | 8 ++------
 include/linux/jbd2.h | 9 ++++++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 14b176d63482df..cbf56b18521666 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1884,9 +1884,7 @@ static int load_superblock(journal_t *journal)
 
 	if (jbd2_has_feature_fast_commit(journal)) {
 		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
-		num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
-		if (!num_fc_blocks)
-			num_fc_blocks = JBD2_MIN_FC_BLOCKS;
+		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
 		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
 			journal->j_last = journal->j_fc_last - num_fc_blocks;
 		journal->j_fc_first = journal->j_last + 1;
@@ -2117,9 +2115,7 @@ jbd2_journal_initialize_fast_commit(journal_t *journal)
 	journal_superblock_t *sb = journal->j_superblock;
 	unsigned long long num_fc_blks;
 
-	num_fc_blks = be32_to_cpu(sb->s_num_fc_blks);
-	if (num_fc_blks == 0)
-		num_fc_blks = JBD2_MIN_FC_BLOCKS;
+	num_fc_blks = jbd2_journal_get_num_fc_blks(sb);
 	if (journal->j_last - num_fc_blks < JBD2_MIN_JOURNAL_BLOCKS)
 		return -ENOSPC;
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 80f573d1b3b83b..f5826f99fe9aa1 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -68,7 +68,7 @@ extern void *jbd2_alloc(size_t size, gfp_t flags);
 extern void jbd2_free(void *ptr, size_t size);
 
 #define JBD2_MIN_JOURNAL_BLOCKS 1024
-#define JBD2_MIN_FC_BLOCKS	256
+#define JBD2_DEFAULT_FAST_COMMIT_BLOCKS 256
 
 #ifdef __KERNEL__
 
@@ -1686,6 +1686,13 @@ static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
 	return journal->j_chksum_driver != NULL;
 }
 
+static inline int jbd2_journal_get_num_fc_blks(journal_superblock_t *jsb)
+{
+	int num_fc_blocks = be32_to_cpu(jsb->s_num_fc_blks);
+
+	return num_fc_blocks ? num_fc_blocks : JBD2_DEFAULT_FAST_COMMIT_BLOCKS;
+}
+
 /*
  * Return number of free blocks in the log. Must be called under j_state_lock.
  */
-- 
2.53.0

