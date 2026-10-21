Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596638;
	b=I9BPtfmfmtvP+0AVBcnFFZsm9iVJ9L1Fws0Z0SHDgl6E2tIK0d5Z765LxS0JMqp+dMVA
	 zB9gy1wJ1gpYqaHqgqeT8nzjdaUq1lQuDNSphJGRIaAnJ9qvv5J3xXj9/wuPtH4Wj0c33
	 UfsrcyAbYXh+8FOi/XGH9gAtkgIiYSrkEK4ANEux4sUVN62mNpHpJ1+9dSF+NSs6xH78b
	 Pr9XrrHTPpAvjvrOOgIWOzckXFdkNsBzVd/ihFSaMX02sHPZu8CGW5aD9GpLWNydPifqE
	 iHEzp1mPHssIV2QxQ6m1/Afv95WjcIcpOoo/lnrAxjU5s9ilshRfOJjYE8MgwSpfWZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BLz38lA+12If20U7WojPMh+5D0jN5Rn14XUZ2GhAZek=;
	b=l8yBnmL6E/lOz9+K4/Gz4mylxgqsXl87L8GED5SgRuuidujJPnFZ7pbRg/kyIkbk0Mnz
	 qkhZGpCS8X/9PouZLiS/aKKtt74++jmB5+2wDIJmAxlyOP1mBF2LvcPfBidXhL371PYUM
	 J+au8ACh/XCre7kJdcB/nfXRz3/5Rw4bfcN0f0pJP6gEgB7ZK8rN9V9CSu/qmSK6ylyQ7
	 qaneHIAYKkYbJO1K0mAKxHO8FfQkwuY2FQdcJkFcFKjFVZZQcCcYiMBdqN/RJEAF/Rmxj
	 Oh7gxhTtqGavNxOGZUa4M6Qq1ecY6IVyueXbPnqauhaDFIRMoODp2Fs9/wwVKumim1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHiv+ZXV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670B606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHiv+ZXV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEFB1F000C6;
	Wed, 21 Oct 2026 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596638;
	bh=BLz38lA+12If20U7WojPMh+5D0jN5Rn14XUZ2GhAZek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KHiv+ZXVFd9cFBN4gWER7r2CGeZEKGoeqNNn+1HbhvNwHHzFNSO3kbQNhHrVXhEFi
	 dgW582rHJgMxfJeo6G8LcNSP/ZFoltwIUyyDSJCkQPBrsfzlEfBTqcPYSv/OQaVQfT
	 6DevL8rfhLCvSWXEMCQClvHe0/3bPz95ghUIpuWlm3zVCaZy9asaXyW1NgzHAqLpDl
	 kl4ZKpzdxndnK+v4nl3eAd8rI/xBVv1TefF6cSqKAkN6foTiqG5x6II66/K0w5UYRK
	 fgr9JcJ0LvXZa5nCG1CElJR4DCyQS1mrA7E58BjEOok6wPVeNIq+D/d0PQuTP3+xnS
	 aTgRUmX/7iQiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] ntfs3: free the sbi after a grace period
Date: Wed, 21 Oct 2026 11:30:33 -0400
Message-ID: <20261021152930.293677-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021152930.293677-1-sashal@kernel.org>
References: <2026102157-deuce-giblet-3fc8@gregkh>
 <20261021152930.293677-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs_fs.h |  1 +
 fs/ntfs3/super.c   | 33 +++++++++++++++++++++------------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 99a78204b9865..9cacca3397055 100644
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
index 558f96db9019c..dc799ebc6c883 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -194,7 +194,7 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 	void *ret = NULL;
 	int i, j = -1;
 
-	spin_lock(&s_shared_lock);
+	spin_lock_bh(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
 		if (!s_shared[i].cnt) {
 			j = i;
@@ -212,7 +212,7 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 		s_shared[j].cnt = 1;
 		ret = ptr;
 	}
-	spin_unlock(&s_shared_lock);
+	spin_unlock_bh(&s_shared_lock);
 
 	return ret;
 }
@@ -229,7 +229,7 @@ void *ntfs_put_shared(void *ptr)
 	void *ret = ptr;
 	int i;
 
-	spin_lock(&s_shared_lock);
+	spin_lock_bh(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
 		if (s_shared[i].cnt && s_shared[i].ptr == ptr) {
 			if (--s_shared[i].cnt)
@@ -237,7 +237,7 @@ void *ntfs_put_shared(void *ptr)
 			break;
 		}
 	}
-	spin_unlock(&s_shared_lock);
+	spin_unlock_bh(&s_shared_lock);
 
 	return ret;
 }
@@ -684,6 +684,8 @@ static noinline void ntfs3_put_sbi(struct ntfs_sb_info *sbi)
 
 static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
 {
+	if (sbi->options)
+		put_mount_options(sbi->options);
 	kfree(sbi->new_rec);
 	kvfree(ntfs_put_shared(sbi->upcase));
 	kvfree(sbi->def_table);
@@ -695,6 +697,11 @@ static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
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
@@ -704,11 +711,11 @@ static void ntfs_put_super(struct super_block *sb)
 	/* Mark rw ntfs as clear, if possible. */
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
 
-	if (sbi->options) {
-		put_mount_options(sbi->options);
-		sbi->options = NULL;
-	}
-
+	/*
+	 * The mount options stay until the sbi is freed: ->d_hash() and
+	 * ->d_compare() of a pathwalk in rcu mode read the nls table through
+	 * them.
+	 */
 	ntfs3_put_sbi(sbi);
 }
 
@@ -1865,9 +1872,11 @@ static void ntfs3_kill_sb(struct super_block *sb)
 
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

