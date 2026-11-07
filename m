Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047824;
	b=ATBPEcQ19AWZ0Ig4yqtwgc612GbPx89FeHIhXZywAVgZQWUI8EhP1IqYtpnn5snxljtV
	 WAuWIEDQKZrtBWFT4qAp9NrzKsPnEYBpITDBwmL4wdcp620j4DrXdwKqEVKH1amYnUy/0
	 lZKUXRXU4ao5zG8qf8pkfGbtNESk/aTZtmuFG2y4IC5qdNFk/A7h+iET/Zsld2e33jwNE
	 jS0tW3fLk7uHP0rk89Nw7+IaaNk71NP+U0G8AgoK1jm06fLk3bRXRmuTv6JkafYNdh3mA
	 n4RxP08lDmFgpZRK3OUKgxUS2NufkXBxanaxS52puQ1ClLTGQwfGve3OeKmoM+bg19w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047824;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MD8//YwgMDHR/BMsgOGPsSg9RASFl4JRvjjAn5yEl0M=;
	b=fkEXkji47Xyfy68tA8cTzUy90oFuOO4BEO9IChyLz4JzsZ1l2bmgnWFI58oGOAGu9xrG
	 nYCUhL21i2TaD/TnCy73p8I8U6MuH6Q8g2AF8UhDl0wMPfRywslPvSMBKYivjtbugQND/
	 9fzby69tQQlmGNyEhVY/73cZ0BV4EngcZuFS+F6ffB0eJ3rIkFTiDsI2f22IH3Z/iQtqr
	 dsUp1sxdcLQ+huf5U9NvZNoPx14pOejLLWa54CEvQsgpzxIj40H6Id6L/P7iYq59X3wp0
	 SFO/2Izwi4fQWkNLeBXl8CDJRO3P+Jy9UWRq5t0D09y4T2VjP2onBmqezRZw+mwxYzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bC3fkVxI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bC3fkVxI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3B41F0089F;
	Sat,  7 Nov 2026 10:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047824;
	bh=MD8//YwgMDHR/BMsgOGPsSg9RASFl4JRvjjAn5yEl0M=;
	h=From:To:Cc:Subject:Date;
	b=bC3fkVxIgAsjuzPtumqZj5K7zRJYIzxSBz59UvB1+vh3Cl2/7MkI3Ofi74AtCp6Zf
	 D+lEopjOK7gdtJuBaJNCgcWYl2DW0lSsP2Y8YWgdjJohzI6bK2hHXwHZReaqlwX7YD
	 HEgaVsIFpFb0g4Ng3A30PXLtAqaAE8mP8KK0k3MDwhBsgBDWkyOUpZfmE7TTSlLy8L
	 GYbSE1DzRIgUwNaRtfzazK2OUNAAOZ0kWlNQj2gJVdFnlWEhRTWYc3ySBMQ+LK4ORm
	 tquWOjdAzyfWoAdfM5HeaknLbXFAowM5fkiCphcJXvvj3x1NTkfgE0qMOtoseEWvXj
	 TV9WiL3MQAQUA==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	liubaolin@kylinos.cn,
	hyc.lee@gmail.com,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: set the volume dirty bit unconditionally on metadata changes" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:02 -0500
Message-ID: <20261107053702-failed-6.6-55af94ca0ee3@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 55af94ca0ee3512c08d12ffbbb948229da4e1565
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053702-failed-6.6-55af94ca0ee3@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 55af94ca0ee3512c08d12ffbbb948229da4e1565 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Mon, 21 Sep 2026 23:13:19 +0900
Subject: [PATCH] ntfs: set the volume dirty bit unconditionally on metadata
 changes

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
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/file.c  | 20 +++++++++++---------
 fs/ntfs/namei.c | 24 ++++++++----------------
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 2b6588a4ee73c..e8b056c3e4ccd 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -341,8 +341,7 @@ int ntfs_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 		goto out;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	if (ia_valid & ATTR_SIZE) {
 		err = ntfs_setattr_size(vi, attr);
@@ -636,8 +635,13 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -1169,11 +1173,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
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
 
 	inode_lock(vi);
 	if (NInoCompressed(ni) || NInoEncrypted(ni) || NInoWofCompressed(ni)) {
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 2cde39da6beec..028efad7d9c0f 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -756,8 +756,7 @@ static int ntfs_create(const struct mnt_idmap *idmap, struct inode *dir,
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, uname, uname_len, S_IFREG | mode, 0, NULL, 0);
 	kmem_cache_free(ntfs_name_cache, uname);
@@ -1031,8 +1030,7 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	err = ntfs_delete(ni, NTFS_I(dir), uname, uname_len, true);
 	if (err)
@@ -1075,8 +1073,7 @@ static struct dentry *ntfs_mkdir(const struct mnt_idmap *idmap, struct inode *di
 		return ERR_PTR(err);
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, uname, uname_len, mode, 0, NULL, 0);
 	kmem_cache_free(ntfs_name_cache, uname);
@@ -1117,8 +1114,7 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	err = ntfs_delete(ni, NTFS_I(dir), uname, uname_len, true);
 	if (err)
@@ -1304,8 +1300,7 @@ static int ntfs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 		new_dir_first = is_subdir(new_dentry->d_parent,
 					  old_dentry->d_parent);
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	mutex_lock_nested(&old_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
 	if (new_ni)
@@ -1428,8 +1423,7 @@ static int ntfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, usrc, usrc_len, S_IFLNK | 0777, 0,
 			   symname, symlen);
@@ -1473,8 +1467,7 @@ static int ntfs_mknod(const struct mnt_idmap *idmap, struct inode *dir,
 		return err;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	switch (mode & S_IFMT) {
 	case S_IFCHR:
@@ -1520,8 +1513,7 @@ static int ntfs_link(struct dentry *old_dentry, struct inode *dir,
 		return -ENOMEM;
 	}
 
-	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
-		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
+	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ihold(vi);
 	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
-- 
2.53.0




