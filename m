Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917737F309;
	Mon, 14 Sep 2026 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364982; cv=none; b=OoVAmzjrPhv8EcXi4SDJjrMZwaoMYwuwpg7x+VbDx3dy1YbJG058/VmAPV091JqwlXV0Q7fv22XZec9/GWq1jULLS6Ey4/hRPB5e3rZV0dfKzXSfNL6kq9dat38vWGAK34hTiIoni1Mu7xvRqmtA6wza1ebfvkMu6LXIQRDNoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364982; c=relaxed/simple;
	bh=A09OHkw0psSLkx6FKOss/BUH+O/19kPKvUcWwko7h00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2T8ASVO/fI5aWpjnshBVPxWL3UGMi6bGtO2tuvgKHhVu7K5cdFAuXbH8aTX5LhTx6dwaNifInCmQGs1BdAy2ajbvBkPu6JOUBHdBXrvDuEdfWO2lV2LlR5tpyD+p5YfehJ0PiOVn/f2I2nPw7tb9hyhnzK9iWBBA1McGyp7HaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0f104ac0b00011f19a56ed5b684f684d-20260914
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7d5fdb5a-0fee-4fba-bdee-2ece3cbab930,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:34ea739899712a946a605e90b900336f,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0f104ac0b00011f19a56ed5b684f684d-20260914
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 15398452; Mon, 14 Sep 2026 13:49:32 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Baolin Liu <liubaolin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v11 2/6] ntfs: set the volume dirty bit unconditionally on metadata changes
Date: Mon, 14 Sep 2026 13:49:22 +0800
Message-Id: <20260914054926.78808-3-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260914054926.78808-1-zenghongling@kylinos.cn>
References: <20260914054926.78808-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callers in file.c and namei.c skip ntfs_set_volume_flags() when
the in-memory vol_flags already show VOLUME_IS_DIRTY, but that check
runs without any lock: if it observes the bit set and ntfs_sync_fs()
clears it under the mrec_lock before the caller's metadata update
completes, the set is skipped and the volume can end up clean on disk
despite the modification, so chkdsk will not run on the next mount.

Drop the caller-side checks and call ntfs_set_volume_flags()
unconditionally: ntfs_write_volume_flags() already skips the write
under the mrec_lock when the combined value is unchanged.  That
unconditional call costs one mrec_lock acquisition per metadata
operation even in the already-dirty steady state; it cannot be
avoided, because deciding to skip the call without the lock is itself
what allows a concurrent ntfs_sync_fs() clear to lose the set.

The IOCB_NOWAIT path in ntfs_file_write_iter() goes through the same
sleeping call: a RWF_NOWAIT write can block in the marking, as it
already could before this change whenever the volume appeared clean.
Giving that path a non-blocking variant is left as follow-up work.
The callers keep the pre-existing behavior of proceeding when the
marking fails, so the dirty bit remains best-effort.

This closes the variant where the set is skipped outright.  A clear
for a concurrent, error-free sync can still land between the set and
the end of the metadata operation; that mark-at-start lifecycle is
pre-existing and is not changed by this patch.

Reported-by: Baolin Liu <liubaolin@kylinos.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/file.c  | 20 +++++++++++---------
 fs/ntfs/namei.c | 24 ++++++++----------------
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 007d1614b9ac..cfc7b36b7dff 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -325,8 +325,7 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		goto out;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	if (ia_valid & ATTR_SIZE) {
 		err = ntfs_setattr_size(vi, attr);
@@ -620,8 +619,13 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out_lock;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	/*
+	 * The volume must be marked dirty before the modification is made,
+	 * without an unlocked check of the in-memory flag: ntfs_sync_fs()
+	 * can clear the bit concurrently and the modification would then
+	 * land on a volume that is clean on disk.
+	 */
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	pos = iocb->ki_pos;
 	count = ret;
@@ -1153,11 +1157,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 			return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY)) {
-		err = ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
-		if (err)
-			return err;
-	}
+	err = ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	if (err)
+		return err;
 
 	old_size = i_size_read(vi);
 
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index fdf52fac4329..3e0adb9a0ea4 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -757,8 +757,7 @@ static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, uname, uname_len, S_IFREG | mode, 0, NULL, 0);
 	kmem_cache_free(ntfs_name_cache, uname);
@@ -1032,8 +1031,7 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	err = ntfs_delete(ni, NTFS_I(dir), uname, uname_len, true);
 	if (err)
@@ -1076,8 +1074,7 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		return ERR_PTR(err);
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, uname, uname_len, mode, 0, NULL, 0);
 	kmem_cache_free(ntfs_name_cache, uname);
@@ -1118,8 +1115,7 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	err = ntfs_delete(ni, NTFS_I(dir), uname, uname_len, true);
 	if (err)
@@ -1305,8 +1301,7 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		new_dir_first = is_subdir(new_dentry->d_parent,
 					  old_dentry->d_parent);
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	mutex_lock_nested(&old_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
 	if (new_ni)
@@ -1429,8 +1424,7 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, usrc, usrc_len, S_IFLNK | 0777, 0,
 			   symname, symlen);
@@ -1474,8 +1468,7 @@ static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	switch (mode & S_IFMT) {
 	case S_IFCHR:
@@ -1521,8 +1514,7 @@ static int ntfs_link(struct dentry *old_dentry, struct inode *dir,
 		return -ENOMEM;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ihold(vi);
 	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
-- 
2.25.1

