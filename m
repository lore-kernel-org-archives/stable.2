Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F902F7EE7;
	Thu,  1 Oct 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874886; cv=none; b=b+pWkvukwdqI8yL5JJqU/aZq8mqwOt5J6pe3tdwvSgsKdV11p4NorqKINqIcKCAZw9rL+zrzYImACf5DtQUsyUAEtGjxz/J5hD91ys83KdrQfe0MYSlOA78o+e48VtUV4XY9ViHw9IC8vnAskF9Tx1Udw56KIWHNtzgvAzYCKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874886; c=relaxed/simple;
	bh=r4mOQ6DUqPtT5fWKZVM4/eQ+BtWY5YiaZ3wUblAaxvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KARKvxbw6IdYwgh/WdLmQ1OzBytccjI6oeDJ2i2rpOfgKW5/nV7X+qedX+SdWWNbsd3igMbZnoICwnNgV91w0s0QixCE6mGwBRq/lTUwfp4i7B8nvAe4YW/6TF0AUDttipC9qcHAQ5YzTCtHfpjJYvi9uK9y2rjSBlbOLROyMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDaQJY/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDaQJY/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F6D1F000FF;
	Thu,  1 Oct 2026 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790874881;
	bh=d3OI93CslrMJd5LCHTrV6UGCfCMJDqvFLQa/stHpzZM=;
	h=From:To:Cc:Subject:Date;
	b=VDaQJY/QXgFRFoINCAf07gDWXmNH3pYYpeaafner0ak9/Dp71ybvnvqlG1gnqaKWI
	 jMJsh9z4GH4VB8mbEbdMKbYaOKy130YKvTs0TWCcWB502yIyY9KaCLLlLWIE3pfdcy
	 dFEUAxzi0Ujn2g3wHl3oCADVCXVWEaj2V7gmJzSloXxCMLqJWpsthkcoKhNJ8GsPE8
	 f+lv0oCnL96ffOutG3Hg/BztxBICJgmp7hXhmNlVUwljhl5GuMhw6RJqVfBP2eQ8r7
	 LXMrP9DLMESHvSXLRf+P+H+FPbk20iurxf4dZ+9WXZmhl5YQMrreqhcnrx+3MVeDe0
	 Qn/s0OIFP6npg==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] fsverity: RCU-delay the freeing of struct fsverity_info
Date: Thu,  1 Oct 2026 10:13:49 -0700
Message-ID: <20261001171349.81454-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__fsverity_get_info() calls rhashtable_lookup_fast(), which just uses
rcu_read_lock() and doesn't directly synchronize with
fsverity_remove_info().

For the same inode this isn't a problem: its fsverity_info is removed
only at inode eviction time or upon failure to enable verity, when the
inode no longer needs its fsverity_info and it will no longer be
accessed via that inode.

However, this is broken and can cause a use-after-free for concurrent
__fsverity_get_info() for *different* inodes.  Those rely on following
fsverity_info::rhash_head in the rhashtable under rcu_read_lock() only.
They also use fsverity_info::inode to do the key comparison.

Fix this by RCU-delaying the freeing of 'struct fsverity_info' after
it's been removed from the rhashtable.

Fixes: f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/fsverity_private.h | 15 ++++++++++++++-
 fs/verity/open.c             | 13 ++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 881d46f25e08..6f85f63861aa 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) "fs-verity: " fmt
 
 #include <linux/fsverity.h>
+#include <linux/rcupdate.h>
 #include <linux/rhashtable.h>
 
 /*
@@ -76,7 +77,19 @@ struct merkle_tree_params {
 struct fsverity_info {
 	struct rhash_head rhash_head;
 	struct merkle_tree_params tree_params;
-	u8 root_hash[FS_VERITY_MAX_DIGEST_SIZE];
+	union {
+		u8 root_hash[FS_VERITY_MAX_DIGEST_SIZE];
+
+		/*
+		 * Used for final freeing of the struct, in which case root_hash
+		 * is no longer needed.  Specifically, the only fields needed
+		 * besides the rcu_head are those needed by fsverity_free_info()
+		 * itself, and those that can be accessed by fsverity_get_info()
+		 * (rhash_head and inode) during the RCU-protected rhashtable
+		 * chain search trying to find another inode's fsverity_info.
+		 */
+		struct rcu_head rcu_head;
+	};
 	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
 	struct inode *inode;
 	unsigned long *hash_block_verified;
diff --git a/fs/verity/open.c b/fs/verity/open.c
index d0c56a7faa3b..52c8cd014921 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -399,11 +399,22 @@ void fsverity_free_info(struct fsverity_info *vi)
 	kmem_cache_free(fsverity_info_cachep, vi);
 }
 
+static void fsverity_free_info_rcu(struct rcu_head *head)
+{
+	fsverity_free_info(container_of(head, struct fsverity_info, rcu_head));
+}
+
 void fsverity_remove_info(struct fsverity_info *vi)
 {
 	rhashtable_remove_fast(&fsverity_info_hash, &vi->rhash_head,
 			       fsverity_info_hash_params);
-	fsverity_free_info(vi);
+	/*
+	 * The freeing must be RCU-delayed because __fsverity_get_info() for a
+	 * *different* inode's fsverity_info in the same rhashtable hash chain
+	 * can still be accessing *this* fsverity_info's rhash_head and inode
+	 * fields as part of the RCU-protected hash chain search.
+	 */
+	call_rcu(&vi->rcu_head, fsverity_free_info_rcu);
 }
 
 void fsverity_cleanup_inode(struct inode *inode)

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.56.0

