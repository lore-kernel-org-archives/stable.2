Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6B47124F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212326; cv=none; b=Cajc3Aswd9DXuCP5DqPfJq/OGSGM3CP52EjjyNMpe8inaHop7YsWTmaygB9EuCBnHJelfFTaJ6TmW2uOeQTCmY93yBNhmIx4UT0M+F9EovKWR5wuohWoxcLLuvKef54f4yMOGDLftQl1HTL6Bi0LAfxmju/2NJm8o+O4J9pkKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212326; c=relaxed/simple;
	bh=c8ZB1YFdzthxAHA7Fy8n4tR+r6TCkv/jJuvtZOA/nwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNMxMFJqNHNQwHONpvZKQEinnj/relMHhdi1s+LaYHFB7RMoQvDmrQk6u6tcT4cO+wwfSZwHaCNapszISV+c0mkQwv8NO8WMNGu9vD8nyghjVho70y1ZYgKA5ZucxFbyNPIDqVALOuoyeZWRBLfAnVYlSpme3nkgRTJHmK8mCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNvMwfES; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNvMwfES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD621F000FF;
	Sat, 12 Sep 2026 11:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212324;
	bh=FXExQjpA+cYDAGmd7x4GYaqI+dFTkJ4GCt4OAoxIi8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UNvMwfESVGxADoUnLwo1Cg7yrQYKp/Cpui9ileVe8JXql1uISFDGlBJMgqi8xzGqg
	 XFppa9qVIr0Xg2lFEdc5OAV2qC2TcQLETjJrlrQrlCCmDYrORg0H6LmCyxvWFIzZMK
	 rmpW/8KCPHYh0t4Q1xGugBda3VS4XoeoeA6DGQjQr7eBYvYlnt4upSIBx/hC1lZUpa
	 H2fnulv+CrXxHwRxtNe7MkU13sXVOAe/769rURaSn0gDtAnbh+wiaVyYNLgW2qDEQj
	 OrEIXenDfB87LV7WwgF+aa4wZ0AILA/ZTLWwekArs1ng4vXAVx+8RZP3mAc5WRnMmd
	 s/5vAGblock9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Chang <joannechien@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: dirty directory inodes on mtime/ctime update
Date: Sat, 12 Sep 2026 07:25:22 -0400
Message-ID: <20260912112522.2333995-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090951-only-erratic-27cc@gregkh>
References: <2026090951-only-erratic-27cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ adjusted context to retain Linux 6.1’s direct timestamp assignments and page APIs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c    | 6 +++---
 fs/f2fs/inline.c | 2 +-
 fs/f2fs/namei.c  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c6348e346851f..ada31e2fabcf5 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -445,7 +445,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	set_page_dirty(page);
 
 	dir->i_mtime = dir->i_ctime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 	f2fs_put_page(page, 1);
 }
 
@@ -581,7 +581,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	dir->i_mtime = dir->i_ctime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
 		f2fs_i_depth_write(dir, current_depth);
@@ -886,7 +886,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_put_page(page, 1);
 
 	dir->i_ctime = dir->i_mtime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8cd6383be3325..2d921bc9da187 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -691,7 +691,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_put_page(page, 1);
 
 	dir->i_ctime = dir->i_mtime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3f716028ca74d..b034418d7ef68 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1056,7 +1056,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	up_write(&F2FS_I(old_inode)->i_sem);
 
 	old_inode->i_ctime = current_time(old_inode);
-	f2fs_mark_inode_dirty_sync(old_inode, false);
+	f2fs_mark_inode_dirty_sync(old_inode, true);
 
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
 	old_page = NULL;
@@ -1229,7 +1229,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(old_dir, old_nlink > 0);
 		up_write(&F2FS_I(old_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(old_dir, false);
+	f2fs_mark_inode_dirty_sync(old_dir, true);
 
 	/* update directory entry info of new dir inode */
 	f2fs_set_link(new_dir, new_entry, new_page, old_inode);
@@ -1248,7 +1248,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(new_dir, new_nlink > 0);
 		up_write(&F2FS_I(new_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(new_dir, false);
+	f2fs_mark_inode_dirty_sync(new_dir, true);
 
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		f2fs_add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
-- 
2.53.0

