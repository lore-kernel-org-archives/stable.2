Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA5634752E
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211821; cv=none; b=CyK+0Q8Y/x+KcM6k9J0yefP5zDz8tItebEQn7LfoezB96nhNPTFU7tgRaUlqLYGuntREolWbbGkLz3v1P9DhFcCuwYBw1q9IeocZwn9UFiEnNL207mbsQCirmaPwUxSvYRGtUpQ8xBHckC5znG8ek0lCe/dXHyWHWlID/uWYrCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211821; c=relaxed/simple;
	bh=dki2EOafrGyN/yZWFofOEtL8dVKKp8dBCNi4/poNCKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCYtYgEg7Jj6vBZ+N07DNW4AseIszFYhEnR1uIG8L5X76N5zjWWljQeLjn+DoY8OFxKpn3tSvez3uJkCCXXl89EKx6hW612pVojXuWv/cAzI6xs5nIRWo/TQisV33XNk7xwU/PvqD5wO2oGAhxR7FQVOkGjl4lveaRY9iwMqtfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp3JBtHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp3JBtHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E59B1F00893;
	Sat, 12 Sep 2026 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211820;
	bh=9ZPajzoOJqDZufWWAfm4gmrsQxzFA4yZnBf7ZWqO/MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pp3JBtHeK27/Ducuew7c7DiahcbIKksFZuN38ie2EAxx6+D1t5Kg5NbZTN5bmoFRX
	 1viqolelN42rx5EsLNx8mAl5E4bFk4um4rfu8fa52h4wmyNwdB9txi9pyTNKhZ6hPd
	 N9ihZcgE6DJYzbX43hNmE0MNVk+bRzgxxFfgkrBm28WityLRoxdKBhKptXfeMaoCll
	 AyitTiRgXFGIyUv3hvyw7gB9t3FFziZxzGZdzCOgYMVZKyg5C0zWw9SD5QGqer08yD
	 CUn49lVPYmX5w3UxpUqNh9og92+AbQIorlBECOk12KkQe8jAfSE4t4CQ9/nMFq9DD+
	 +c9USgOyCmBhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Chang <joannechien@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: dirty directory inodes on mtime/ctime update
Date: Sat, 12 Sep 2026 07:16:57 -0400
Message-ID: <20260912111657.2278495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090950-applied-detective-47db@gregkh>
References: <2026090950-applied-detective-47db@gregkh>
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
index 29ac1e77b5d7a..3103d8234d468 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -513,7 +513,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	set_page_dirty(page);
 
 	dir->i_mtime = dir->i_ctime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 	f2fs_put_page(page, 1);
 }
 
@@ -667,7 +667,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	dir->i_mtime = dir->i_ctime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
 		f2fs_i_depth_write(dir, current_depth);
@@ -983,7 +983,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_put_page(page, 1);
 
 	dir->i_ctime = dir->i_mtime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8e09832a0e692..2b90d6094c221 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -704,7 +704,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_put_page(page, 1);
 
 	dir->i_ctime = dir->i_mtime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index ddcd9805449a9..a4987fed877ad 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1020,7 +1020,7 @@ static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	f2fs_up_write(&F2FS_I(old_inode)->i_sem);
 
 	old_inode->i_ctime = current_time(old_inode);
-	f2fs_mark_inode_dirty_sync(old_inode, false);
+	f2fs_mark_inode_dirty_sync(old_inode, true);
 
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
 	old_page = NULL;
@@ -1192,7 +1192,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(old_dir, old_nlink > 0);
 		f2fs_up_write(&F2FS_I(old_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(old_dir, false);
+	f2fs_mark_inode_dirty_sync(old_dir, true);
 
 	/* update directory entry info of new dir inode */
 	f2fs_set_link(new_dir, new_entry, new_page, old_inode);
@@ -1211,7 +1211,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(new_dir, new_nlink > 0);
 		f2fs_up_write(&F2FS_I(new_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(new_dir, false);
+	f2fs_mark_inode_dirty_sync(new_dir, true);
 
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		f2fs_add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
-- 
2.53.0

