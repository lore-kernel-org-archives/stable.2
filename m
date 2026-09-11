Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05C599A33
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161351; cv=none; b=XBWr94TimbgOOHzyN1ofV7ukFAdIVhEnR9LoTbD1VdxShrG+EB07tFd1YGfIsZTBCKubhrBykHPACy/uxEQnsfDmC6U85Tv2OYYa1N1oNbdCYnIIK0YAIhDWUzUzKRjfWMkm1um3z00DpyJreo41CGeuLwoKJPmB0fgjosaG6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161351; c=relaxed/simple;
	bh=tfKb2t3G/FMMCTM86XdpiESx+8D0KiAZpyI/kOE2Npo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEeYCnuk5ObMrGhf6AFBi/vszXBdD8jO0/3S17xFTAsz9Zvr4dZa6nh6qhOC0qCnTj0IYkDEe47KafegGnVsRggti+RxX9D20Jp4Du+o9We3GJld8Eudu1PFnvgIrdFXc9Jb7DAXBhw5+BI5HoQ2i4xxG4H8xs0LOlzotqiljJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4dxIw3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4dxIw3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5001F000FF;
	Fri, 11 Sep 2026 21:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161347;
	bh=YQfkpC+moFV/h7ZfLlSeLkeqOPyzwffPK9WMDvAfbFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V4dxIw3TB/kEION3WoEqXJhUd+4ysmlclNnCI6tX6oKlEU5czXZmuAxfGMsYkVwgt
	 dUGXI110iE4KoFRdV3ZyzqhW4jDGFwhz4yrqwNrO/SvU4HWxuc+AI7K/VsrCSLO4D6
	 xa3ChW25iOiPhhyHG+/WwKnQVZ7oSHnKswRja/PKIMK6g5PJlwOBU5Z/N7ybjzy6h6
	 nBWbl46ZPhluuIAUzvxTVnNSwpcQKQH/3FSebQTUtiq22l7VqOGNecR3ITWnIxEvTE
	 l43LhCDzYgcoyGltRwZE8b24TWACqjSSpAaSWLQ4Sq9hLrQwLcUBub1g38MRUaaduQ
	 yyvt8vE/N9g4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Chang <joannechien@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: dirty directory inodes on mtime/ctime update
Date: Fri, 11 Sep 2026 17:15:45 -0400
Message-ID: <20260911211545.1532801-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090949-starring-glider-1adf@gregkh>
References: <2026090949-starring-glider-1adf@gregkh>
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
[ Adjusted f2fs_set_link() context to retain f2fs_put_page(page, 1) instead of f2fs_folio_put(folio, true). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c    | 6 +++---
 fs/f2fs/inline.c | 2 +-
 fs/f2fs/namei.c  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 54dd52de7269d..79d8dbbcdb3a8 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -437,7 +437,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	set_page_dirty(page);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 	f2fs_put_page(page, 1);
 }
 
@@ -591,7 +591,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
 		f2fs_i_depth_write(dir, current_depth);
@@ -903,7 +903,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_put_page(page, 1);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 758ec6d3ae841..5e85a03153704 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -720,7 +720,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_put_page(page, 1);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index da213cd39fc70..74482016832d2 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1037,7 +1037,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	f2fs_up_write(&F2FS_I(old_inode)->i_sem);
 
 	inode_set_ctime_current(old_inode);
-	f2fs_mark_inode_dirty_sync(old_inode, false);
+	f2fs_mark_inode_dirty_sync(old_inode, true);
 
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
 	old_page = NULL;
@@ -1206,7 +1206,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(old_dir, old_nlink > 0);
 		f2fs_up_write(&F2FS_I(old_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(old_dir, false);
+	f2fs_mark_inode_dirty_sync(old_dir, true);
 
 	/* update directory entry info of new dir inode */
 	f2fs_set_link(new_dir, new_entry, new_page, old_inode);
@@ -1225,7 +1225,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(new_dir, new_nlink > 0);
 		f2fs_up_write(&F2FS_I(new_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(new_dir, false);
+	f2fs_mark_inode_dirty_sync(new_dir, true);
 
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		f2fs_add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
-- 
2.53.0

