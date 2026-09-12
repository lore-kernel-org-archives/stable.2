Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18C2DAFDE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176740; cv=none; b=H2F5CDGHcWdWwLs32PD4f0/HjKSQV+s8OK6exrp1huhxwOBynvw7KgL5NH2qWNKO7pm65bfgx6G49o5UkKZZmZ7n/qFpZ3NIo9OJ47A5FfH0upmZqM6RB/0nj2472a0XyyydkyrY5avbmsGcKUcd/D531+vhmD5mppD6OhRJ+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176740; c=relaxed/simple;
	bh=zBRV2nyS57myGTVpohTiEgodzkvZqMdZ76PttKaM6YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SX1IRkQqQVH3RhCwlIJLVW8yIAfwv7bH0Jn0z7KQaMBqIKem+cXOku1E1wCNB7r0UHkfXh6x+rxjleLF5yFY1zvPovLlxvp8J4W2Z/coBLN0gwiPluctAR/1dt4Lu3AMqn5a/Hf+EpFac9+5ue+qb2agF2eVnVb9SKJmiDekM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeD2MQur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeD2MQur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAE31F000FF;
	Sat, 12 Sep 2026 01:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176739;
	bh=cus2qXM6hKVrwXvIK3C4QGP//eUWwNiZFx3654a5ECQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SeD2MQurOt8U6pYezCtNGEt32hAnI6uFX4LD2q8g/8cpXbOi1QS4+5qYQh0qXXEfO
	 PIMkfVqh6DlGPUgW15etDSWqyLp8Viu22zAhFEq5CmIDo8gVTx08b+RxmafXYoSA+S
	 fjslINdpk+I9eCGFV1A1PT1+dRZdQ+5T8USS1bFZK1oXZCWrzcFYjUT7r2fvTUZyW4
	 VKOJZteoOO0grs5DkjIjhnJkbGM0F6GAagpRTFWY4lqpEqleHEYg09JwCJMZU5JkiZ
	 +eWda+dGkxoB2PAi5kZztF2kWftFKvvHccSpxXk/nDb18zEv1CpEraAQJxEpy4J9wj
	 xjSExVFptdAJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Chang <joannechien@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] f2fs: dirty directory inodes on mtime/ctime update
Date: Fri, 11 Sep 2026 21:32:14 -0400
Message-ID: <20260912013214.1760785-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013214.1760785-1-sashal@kernel.org>
References: <2026090949-surpass-emphases-308c@gregkh>
 <20260912013214.1760785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Chang <joannechien@google.com>

[ Upstream commit 9ec09d5f4b317a417c8655c14056f70cbe71eb6c ]

Xfstests generic/547 sometimes fail with mismatched directory metadata
before and after a power failure. This happens because when a directory
entry is added, renamed, or deleted, its mtime and ctime are updated and
the inode is marked dirty via
f2fs_mark_inode_dirty_sync(dir, sync=false). The sync=false flag means
the dirty inode is not added to the global DIRTY_META list. Therefore,
subsequent checkpoints skip flushing these updated directory blocks,
causing directory timestamps to revert to stale values after a sudden
power failure.

Address this by changing the dirtying parameter to sync=true during
directory entry mutations and renames. This forces F2FS to immediately
queue the updated directory blocks on the global DIRTY_META list,
ensuring timestamps are committed to checkpoints.

Fixes: 7c45729a4d6d ("f2fs: keep dirty inodes selectively for checkpoint")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Chang <joannechien@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c    | 6 +++---
 fs/f2fs/inline.c | 2 +-
 fs/f2fs/namei.c  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 29005eeb283ca..11d2d27c9a703 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -487,7 +487,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	folio_mark_dirty(folio);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 	f2fs_folio_put(folio, true);
 }
 
@@ -641,7 +641,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
 		f2fs_i_depth_write(dir, current_depth);
@@ -953,7 +953,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
 	f2fs_folio_put(folio, true);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 68e5a77bb515d..1a03fac43f997 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -722,7 +722,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct folio *folio
 	f2fs_folio_put(folio, true);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 96ed0ab996b0d..018ef38e2e535 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1037,7 +1037,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	f2fs_up_write(&F2FS_I(old_inode)->i_sem);
 
 	inode_set_ctime_current(old_inode);
-	f2fs_mark_inode_dirty_sync(old_inode, false);
+	f2fs_mark_inode_dirty_sync(old_inode, true);
 
 	f2fs_delete_entry(old_entry, old_folio, old_dir, NULL);
 	old_folio = NULL;
@@ -1211,7 +1211,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(old_dir, old_nlink > 0);
 		f2fs_up_write(&F2FS_I(old_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(old_dir, false);
+	f2fs_mark_inode_dirty_sync(old_dir, true);
 
 	/* update directory entry info of new dir inode */
 	f2fs_set_link(new_dir, new_entry, new_folio, old_inode);
@@ -1230,7 +1230,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(new_dir, new_nlink > 0);
 		f2fs_up_write(&F2FS_I(new_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(new_dir, false);
+	f2fs_mark_inode_dirty_sync(new_dir, true);
 
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		f2fs_add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
-- 
2.53.0

