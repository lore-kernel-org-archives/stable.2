Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598283;
	b=4veHtRqmQyla/8vW6jXUIxSZKoxdjEZxO7fwT+LHf6nTFfyVN8HQg9E2nhoGHF7qPmGH
	 2gDTmXNQGaRn7+bx2FHpcUAELA9BDQOcWQlH32cfEGWkZKnQ/2dNpU5o3nYCR7T678Ita
	 gPHDS/aUYP0OCFdfrtvri6G+agzD16qcMhvcYj7ZWdVx2cQFWmqjv4I11mOlDhlLHirKZ
	 Uts1tMqXJIdE6w1DhJHp64+h5W/0bQV8Hl3QGiS0cTrveHu2bNmQNPeRL+fdJZx8JbEUW
	 8W26WUqxWYbV1nFnKDA4n6QK/jFNrhO+GQ4I9dcW1ervGrnOJtqUHL83ej9NzOxdqYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y6fK5qQkXJdM7t48Ec0dy3qgESFMByBl0yDan3TfSzs=;
	b=OTC5oJMPkcLI6hRDGtmta00hYnXEK5nn+yqk798fbX31sNyEbNHYUdxb8wzq/uJGUEl/
	 /McyCcx4b7igDIsu92UOPIOJ8FSDmbwVBgigzc3MP5fCxCPsY1wGYhVL6YtaK+ME02Yn8
	 iC261myAROg008Y5pfJtkv1iHm2lR+fyLBZF+ktFostVXYNHB9RujCHfj7zEkgf3u8cqu
	 xPZqRcHrWRYTjbkQS+UZCWiaLj6KKhp/WqDXcfkmmGcS5m2xmwboEBu2LQjsM1cGt0wEQ
	 4Ex7NFiyNz9JIeKDqaSFkPfMPq7TSoMtWm9zLvnAsHp1uttvb/77wS85RdymLX71jmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYsyZo+B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25970606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYsyZo+B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E751F000C1;
	Wed, 21 Oct 2026 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598282;
	bh=Y6fK5qQkXJdM7t48Ec0dy3qgESFMByBl0yDan3TfSzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EYsyZo+BfANJu4GQRt5yZCfUb0nb6QJD52seSnH6PviNsXzoxXpkp8+2/EYlTA4IV
	 O2Hyc5QSMIzZbNClv+jHmcStnFzwxC+kQLQD8tXSolOdU4hNfzPS/bPVIIufda0gh4
	 g6IILY1z76vQjVXPXMGYCshnYTZqdxkXXfKGrA0OyLRJfyU4+MpJcB2rGAEXWYoLiG
	 4MshLAXsCeSOaXXWOqgmRa6H32j4p6otB/BFOKpGsTRDploAs+lG3bS6qYKM1Xw3bB
	 QCh3pTo9OA11+HX6gqYHWHDflhh4DkN6OVSMBFxj0pT3hkUmnO5yk2rHTUUWfHgVfw
	 rCpQFFtxczcfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ntfs3: free the sbi after a grace period
Date: Wed, 21 Oct 2026 11:58:01 -0400
Message-ID: <20261021155742.369544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102158-quantum-annex-72cd@gregkh>
References: <2026102158-quantum-annex-72cd@gregkh>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit c01b091b06412d3b1b53d8c2925f6de586c8a2fc ]

If the "nocase" mount option ntfs3 uses custom hash and dentry compare
functions. Both access ntfs3 superblock private information in rcu
pathwalk. ntfs_put_super() and ntfs3_kill_sb() drop the info without any
rcu delay. A lookup that's still inside the filesystem when the last
reference to the mount is dropped causes a UAF. With a pathwalk held up
in ntfs_d_hash() while the last reference to the mount goes away:

  BUG: KASAN: slab-use-after-free in ntfs_nls_to_utf16+0x752/0x940
  Read of size 8 at addr ff1100010453c850 by task walker/99
  Call Trace:
   <TASK>
   ntfs_nls_to_utf16+0x752/0x940
   ntfs_d_hash+0x22b/0x500
   link_path_walk+0x11ad/0x1d30
   path_lookupat+0x63/0xb00
   filename_lookup+0x1f1/0x5b0
   vfs_statx+0xd7/0x3b0
  [...]
  Allocated by task 95:
   __kmalloc_cache_noprof+0x249/0x560
   ntfs_init_fs_context+0x2db/0x5a0
   alloc_fs_context+0x52e/0xc70
  [...]
  Freed by task 98:
   kfree+0x1db/0x5b0
   deactivate_locked_super+0x9c/0xf0
   cleanup_mnt+0x9f/0x130
   task_work_run+0x131/0x250

The bug is currently masked by the grace period in namespace_unlock()
for umount(2). Keep the necessary information until the filesystem
private info is freed and free it with an rcu delay.

ntfs3_free_sbi() now runs from an rcu callback and drops the upcase
table via ntfs_put_shared(). So switch s_shared_lock over to
spin_lock_bh(). Otherwise the callback can deadlock against a task
holding the lock on the same cpu.

Fixes: a3a956c78efa ("fs/ntfs3: Add option "nocase"")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261009-work-fixes-rcu-v1-7-7446d2d335e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Adjusted ntfs_put_super() context because the early mount-options cleanup block was already absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs_fs.h |  1 +
 fs/ntfs3/super.c   | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 11be9a6f041cf..934dcb136d6da 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -209,6 +209,7 @@ struct ntfs_index {
 /* Ntfs file system in-core superblock data. */
 struct ntfs_sb_info {
 	struct super_block *sb;
+	struct rcu_head rcu;
 
 	u32 discard_granularity;
 	u64 discard_granularity_mask_inv; // ~(discard_granularity_mask_inv-1)
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 4b1941e3f3a67..c7c1896acc2c5 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -187,7 +187,7 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 	void *ret = NULL;
 	int i, j = -1;
 
-	spin_lock(&s_shared_lock);
+	spin_lock_bh(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
 		if (!s_shared[i].cnt) {
 			j = i;
@@ -205,7 +205,7 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 		s_shared[j].cnt = 1;
 		ret = ptr;
 	}
-	spin_unlock(&s_shared_lock);
+	spin_unlock_bh(&s_shared_lock);
 
 	return ret;
 }
@@ -222,7 +222,7 @@ void *ntfs_put_shared(void *ptr)
 	void *ret = ptr;
 	int i;
 
-	spin_lock(&s_shared_lock);
+	spin_lock_bh(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
 		if (s_shared[i].cnt && s_shared[i].ptr == ptr) {
 			if (--s_shared[i].cnt)
@@ -230,7 +230,7 @@ void *ntfs_put_shared(void *ptr)
 			break;
 		}
 	}
-	spin_unlock(&s_shared_lock);
+	spin_unlock_bh(&s_shared_lock);
 
 	return ret;
 }
@@ -630,6 +630,8 @@ static noinline void ntfs3_put_sbi(struct ntfs_sb_info *sbi)
 
 static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
 {
+	if (sbi->options)
+		put_mount_options(sbi->options);
 	kfree(sbi->new_rec);
 	kvfree(ntfs_put_shared(sbi->upcase));
 	kvfree(sbi->def_table);
@@ -641,6 +643,11 @@ static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
 	kfree(sbi);
 }
 
+static void ntfs3_free_sbi_rcu(struct rcu_head *head)
+{
+	ntfs3_free_sbi(container_of(head, struct ntfs_sb_info, rcu));
+}
+
 static void ntfs_put_super(struct super_block *sb)
 {
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
@@ -657,6 +664,12 @@ static void ntfs_put_super(struct super_block *sb)
 
 	/* Mark rw ntfs as clear, if possible. */
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
+
+	/*
+	 * The mount options stay until the sbi is freed: ->d_hash() and
+	 * ->d_compare() of a pathwalk in rcu mode read the nls table through
+	 * them.
+	 */
 	ntfs3_put_sbi(sbi);
 }
 
@@ -1806,9 +1819,11 @@ static void ntfs3_kill_sb(struct super_block *sb)
 
 	kill_block_super(sb);
 
-	if (sbi->options)
-		put_mount_options(sbi->options);
-	ntfs3_free_sbi(sbi);
+	/*
+	 * A pathwalk in rcu mode may still be in ->d_hash() or ->d_compare()
+	 * and read the upcase table and the nls table through the sbi.
+	 */
+	call_rcu(&sbi->rcu, ntfs3_free_sbi_rcu);
 }
 
 // clang-format off
-- 
2.53.0

