Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A2859C982
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161343; cv=none; b=A9iyzU9ZRfDKH+ow/QBvJN8sHgLFo9+eb34T+H6afZ2PVkiVzDMmUX7ODj2Z02aCGuamz2o7NXUkv4qeoJKSqtH2w9BG+ANXiUe/xUS4WGxwA0oB9YZE6O+hcXJbwDIRIKLgD+AZqWnRdasV6r2X138cQCqSGJBc/x5sUmOodNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161343; c=relaxed/simple;
	bh=UBiPNO2OiO6u3JqgGzzPLl6Js7tUB+9RqKapDcATHkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEhIi8lagq7FU32kah+yeiaSUGtNeY4eP0ChRho8/gthVZ00TBrbgnR491QXb17YlcLG/DkYjEUqsHPUcDRQWIMUXPeAEjaNKNRQSrDiHX51y7kqv0rHocoTEuYFELJ5uL3h/i95psWYntpwnRZji8WkGi7/kkNOg8lTgAkwDGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHC8OT9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHC8OT9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A551F000FF;
	Fri, 11 Sep 2026 21:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161341;
	bh=4pzMfhSGaP94tWXNIX8y1qtq6OwRm3XtS06kvBQasWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lHC8OT9sk2i31JEZILHe55EFhghFmQUBL3kLKdXAJSj8D692ZR6wM8Szh2cnEtOsc
	 WwKgRIn+MOQ3vDrhbsEVyCkOR0gf6WwFF7R7zxsbVwtfO+eaUErAFxq3CUv3BoTT/X
	 1FORYMsrwNiX1huueInOWqk1DKZCAlQw8ou640lnniWZDNpK0OEvh61uezd2p5s1nP
	 M7JqRoNWif4tf7RYsyeWYQXnIXgsx2WSg+0lUHq2w9c3ziD1EXk3zmjIy5FoDPyzLS
	 DDDp+KLFmJdGu4mm06akrOA0Jf+oJcHyBptO+/gYYzSktjXxUy7DP4D0GkH0rVv3hP
	 Wh1e5a37E+zgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] f2fs: clean up F2FS_I()
Date: Fri, 11 Sep 2026 17:15:38 -0400
Message-ID: <20260911211539.1531828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090950-divorcee-jump-d9a1@gregkh>
References: <2026090950-divorcee-jump-d9a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 7309871c03be22bee843f6961dcce183f04d48a9 ]

Use temporary variable instead of F2FS_I() for cleanup.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

[Stable dependency adaptation for d0a481fad5c7]
Limit the cleanup to f2fs_setattr(), the only function touched by the
target. Drop the unrelated compression, inode creation, inode update,
and recovery cleanups. Preserve the stable timestamp assignment,
inflight direct-I/O wait, and post-EOF zeroing.

Include the existing-function alignment check from d738f7085647
("f2fs: don't allow unaligned truncation to smaller/equal size on pinned
file"), authored by wangzijie <wangzijie1@honor.com>. This stable tree
already has section-aligned pinned allocation and overwrite-only pinned
writes, but lacks that check. Cache sbi alongside fi to support its
section-capacity expression and use it consistently in f2fs_setattr().

This supplies the exact context needed by d0a481fad5c7, which will also
reject size increases on pinned files. No functions are added.

[ sashal: Reduced backport -- upstream 7309871c03be2 touches 5 file(s), this
  backport carries 1. Not backported here:
  fs/f2fs/f2fs.h
  fs/f2fs/inode.c
  fs/f2fs/namei.c
  fs/f2fs/recovery.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: d0a481fad5c7 ("f2fs: fix to avoid potential section-unaligned pinfile")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d321a42f97c89..9f82d34eb2f43 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1003,9 +1003,11 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;
 
-	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
+	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
 	err = setattr_prepare(idmap, dentry, attr);
@@ -1033,7 +1035,18 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			return -EOPNOTSUPP;
 		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
 			!IS_ALIGNED(attr->ia_size,
-			F2FS_BLK_TO_BYTES(F2FS_I(inode)->i_cluster_size)))
+			F2FS_BLK_TO_BYTES(fi->i_cluster_size)))
+			return -EINVAL;
+		/*
+		 * To prevent scattered pin block generation, we don't allow
+		 * smaller/equal size unaligned truncation for pinned file.
+		 * We only support overwrite IO to pinned file, so don't
+		 * care about larger size truncation.
+		 */
+		if (f2fs_is_pinned_file(inode) &&
+			attr->ia_size <= i_size_read(inode) &&
+			!IS_ALIGNED(attr->ia_size,
+			F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
 			return -EINVAL;
 	}
 
@@ -1044,12 +1057,11 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 	if (i_uid_needs_update(idmap, attr, inode) ||
 	    i_gid_needs_update(idmap, attr, inode)) {
-		f2fs_lock_op(F2FS_I_SB(inode));
+		f2fs_lock_op(sbi);
 		err = dquot_transfer(idmap, inode, attr);
 		if (err) {
-			set_sbi_flag(F2FS_I_SB(inode),
-					SBI_QUOTA_NEED_REPAIR);
-			f2fs_unlock_op(F2FS_I_SB(inode));
+			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+			f2fs_unlock_op(sbi);
 			return err;
 		}
 		/*
@@ -1059,7 +1071,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		i_uid_update(idmap, attr, inode);
 		i_gid_update(idmap, attr, inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
-		f2fs_unlock_op(F2FS_I_SB(inode));
+		f2fs_unlock_op(sbi);
 	}
 
 	if (attr->ia_valid & ATTR_SIZE) {
@@ -1082,7 +1094,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (attr->ia_size < old_size)
 			inode_dio_wait(inode);
 
-		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
 		if (attr->ia_size > old_size)
@@ -1096,14 +1108,14 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * larger than i_size.
 		 */
 		filemap_invalidate_unlock(inode->i_mapping);
-		f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 		if (err)
 			return err;
 
-		spin_lock(&F2FS_I(inode)->i_size_lock);
+		spin_lock(&fi->i_size_lock);
 		inode->i_mtime = inode_set_ctime_current(inode);
-		F2FS_I(inode)->last_disk_size = i_size_read(inode);
-		spin_unlock(&F2FS_I(inode)->i_size_lock);
+		fi->last_disk_size = i_size_read(inode);
+		spin_unlock(&fi->i_size_lock);
 	}
 
 	__setattr_copy(idmap, inode, attr);
@@ -1113,7 +1125,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 		if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 			if (!err)
-				inode->i_mode = F2FS_I(inode)->i_acl_mode;
+				inode->i_mode = fi->i_acl_mode;
 			clear_inode_flag(inode, FI_ACL_MODE);
 		}
 	}
@@ -1122,7 +1134,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	f2fs_mark_inode_dirty_sync(inode, true);
 
 	/* inode change will produce dirty node pages flushed by checkpoint */
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	return err;
 }
-- 
2.53.0

