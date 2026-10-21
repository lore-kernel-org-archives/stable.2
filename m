Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618627;
	b=kJdFZh7MMnOMKOa/PYNyL7uDMFFS+4WYlSxEEvQgUTW2HRan3Ru5dnje2jqGbEUIpkUR
	 8Sv0VKcfGvh3I7qphLcZVgt0r67mLVLgfN7bQvOMVyfVSD1pYOKZGjpf9kVUfoTCQN5s2
	 Ay/fowHvtpN1YC+eL6y5Nf2fw6m06oI1kWaZE3MEMbUUq3L8sMV3RX9IZf7KZfm2D7GvX
	 9TJ7+BPa3TRs8lYWikOZ59tFcxU01j8Nm5tMzH3verovF9Ksa2pEC+8wsQ5eyPsNc1lVe
	 2ZVxXWkLZIR+nAegEbWqWk72PBQVxwsiEgMFWokWj2O3VbsYdXjVy1IG2LrGZyYqV5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618627;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eXVHJTd+0f8g5yK17oFdrqJJ/k86XfURGYzspUztakM=;
	b=uPU0QmTT5gz0r3XkBahM0+/Hvg4Jen574fULBNqsadf8LmwnXbnPAl79vcTV3fgYqQ3p
	 P6wNu8N53iLzMi8iIP72w60nogYWAfctegHNKRuxCs7nVF4hq5O/zogW+TAb7BUi6LqNs
	 E1+UMjDgXkac/oytl9dOHlqm1denCXNpP1/gcODt7PuKnCF5czDVJ3+Yu8Z4fWjUfEufn
	 15ScBJPRycL3aiUG8t74zb3S7wM/rVivFXLkssBShi67/FV+6QRLWNI7sraGp/kWYJBuG
	 p3cadMFso9gUl1mdA6MvmCeVTs7qWvB41iNV7SAsznFDmGEt+h7rR4lOPbSOlPd8cxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMfdCvXw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25A606A323
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMfdCvXw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288FC1F000C6;
	Wed, 21 Oct 2026 21:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618626;
	bh=eXVHJTd+0f8g5yK17oFdrqJJ/k86XfURGYzspUztakM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MMfdCvXwYNabTvfoIadKxEz2JjOmAchWWQ9Bh6U8E1zf/dXpYEE/nHDDR5Qlm9ROE
	 yXJHh7f5brxN7jmBX5gihvSPCGFjRSNp72RodInCj+mUqDUXB0IWySqtYL3/vhya/O
	 FM4bOu7OK6LnAEARABHZshe1eDf1TP08kL+JNWSefu4LiYVgQN97NRuGPQZxVZVkNL
	 /DeTS2RrObjdRge9xG+mxivRMCeJWJ9LFemekUvDsyavHAWaPNhNijhFDU9sbj40PC
	 xmhTlqQBXR3Komczwte47NrY2ix/mfTmwUWmVUFAGCmFg6Tp1N58aJBU27kFMaDdE8
	 cExsZCeSEQKeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ntfs3: free the sbi after a grace period
Date: Wed, 21 Oct 2026 17:37:05 -0400
Message-ID: <20261021213615.470893-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102158-strife-renewable-5171@gregkh>
References: <2026102158-strife-renewable-5171@gregkh>
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
[ sashal: Omitted removal of mount-option cleanup already absent from ntfs_put_super(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs_fs.h |  1 +
 fs/ntfs3/super.c   | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 5e7536ad0b94c..8850ee2b75b11 100644
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
index 15b1f2027b4ed..3b7731b188302 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -183,7 +183,7 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 	void *ret = NULL;
 	int i, j = -1;
 
-	spin_lock(&s_shared_lock);
+	spin_lock_bh(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
 		if (!s_shared[i].cnt) {
 			j = i;
@@ -201,7 +201,7 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 		s_shared[j].cnt = 1;
 		ret = ptr;
 	}
-	spin_unlock(&s_shared_lock);
+	spin_unlock_bh(&s_shared_lock);
 
 	return ret;
 }
@@ -218,7 +218,7 @@ void *ntfs_put_shared(void *ptr)
 	void *ret = ptr;
 	int i;
 
-	spin_lock(&s_shared_lock);
+	spin_lock_bh(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
 		if (s_shared[i].cnt && s_shared[i].ptr == ptr) {
 			if (--s_shared[i].cnt)
@@ -226,7 +226,7 @@ void *ntfs_put_shared(void *ptr)
 			break;
 		}
 	}
-	spin_unlock(&s_shared_lock);
+	spin_unlock_bh(&s_shared_lock);
 
 	return ret;
 }
@@ -624,6 +624,8 @@ static noinline void ntfs3_put_sbi(struct ntfs_sb_info *sbi)
 
 static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
 {
+	if (sbi->options)
+		put_mount_options(sbi->options);
 	kfree(sbi->new_rec);
 	kvfree(ntfs_put_shared(sbi->upcase));
 	kvfree(sbi->def_table);
@@ -635,6 +637,11 @@ static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
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
@@ -651,6 +658,12 @@ static void ntfs_put_super(struct super_block *sb)
 
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
 
@@ -1807,9 +1820,11 @@ static void ntfs3_kill_sb(struct super_block *sb)
 
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

