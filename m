Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F0335BA;
	Tue, 30 Jun 2026 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782788991; cv=none; b=HNoBzQdlUuhBDu6C3mKbmWpjkB6cVNy7S0EI0J9CeYzswyiWMrqRb6S+w2tXO7MOfRf6b1iMmW3UnNZSqAYUmQmNxLf5UNnrTKAAEkeg2f2A45zl7ygPkS/q3OmwhZM2PyrYHI3q6j313feScFs7qanAgIaanMaotx+8oGk9Lb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782788991; c=relaxed/simple;
	bh=5L/cSEGvPtP3iaRS4GeQQ+VEM5ck7RMhTM8l/ZG6gLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAFZPGNbnc2QR2PSiWzF9nTcg4neb3j/m0u0nkQDcfSye0aeScswZ469Dmfv1tEk4XXc4qv5snQJWXtFn3+mDLNnmSoOjc0QaKpEly+r/7pOhIaF1tCnx7yw53QAIfpmVKqx7hbYAP0+1yj2U7eH2pyAp/ohslDYf8qmJxh0B1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=u1JdgPQ/; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="u1JdgPQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1782788946;
	bh=7WcfZP1UOOLYSOg9HtPf0M8B5bAz4/WMG8M4g/hDJzs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=u1JdgPQ/RYHWYts3Fe0i8Q679OlBVBzdssf1jUfZh4OoAg+mJffCKXrwicHu0wVc1
	 IBk5cN5+sMqh7sby8EPIlYjaeLGBkSJPBtg2qtwXefn8ImgN43UJtqZEeO08iWy/P8
	 Fq8Rn2OzW78oBE85Mv8Svbz5GebUIuxJm2K600gc=
X-QQ-mid: esmtpgz16t1782788940tac31b7c8
X-QQ-Originating-IP: zc0nl9nEZCIVZIPtSuTq/mPDO2oMnifVArq6bC4hDfM=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.72])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jun 2026 11:08:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1330492449178660943
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: syzkaller@googlegroups.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ntfs: fix mrec_lock ABBA deadlock in rename
Date: Tue, 30 Jun 2026 11:08:56 +0800
Message-ID: <E1CB185090CF6721+20260630030856.2210012-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N3qHXqQQ4xJJy/mWsJsrubmZL6h44yGPV0t0TeUPgM2S7Us1DSQb7VDp
	LKL+JEtoxB4/6rkGtJtbHP4Cz0YGeyU7EdRgoy8KJg9LxIJx6/oLELhPYSM5thRosGzJcY4
	ovDkKkqEvhADjeOHPTzEAiiG9lDQ5nnAaxKTp/upc778PKgSmtIfSz2APUiyojMP1bPaTpC
	CSpAntpAOf+gdSHM17gOo4YQfjOvnMbMwScRYw8F649gBR5vMHnk2vPer8toVKmHDOoQ38v
	dSSaipZj8U1TvdcMparPVndYxdI9q4NwXmr2x0EWtlsURGBxuxCIQj+W2RJBPCjFDxxbh62
	NWvK0QnEJ4GZNiH7D0Jn1P75DR4qlNS+IURgljtXeg0Dybq4YJ1R+Ob1o+GBr8Hj/nZZZK8
	wp8R+k7gNZdqzCaV9y/ksZ74Eg2wBgyI3WtW0Q2beUQEMG4hDBpncQ7BmQes6wF8mu1BHsm
	rWkjDg7KHguU3g6cGskjIfUFAX6YHIRIzeYf/AlJG8AyLPmGOqPOPMu8wiUk/zK+7bAWCfx
	bul+fuwKf6b5naJubjbcABXwVRGYLIg7ArrQo2jhZw832aHDQcYyavltkgngDhOkXh+3MwU
	bfZEcpM1N1uamPJGaAQiHpzU2E1lcjmKFfHFq22qpk0IK/Fc9dfOWoyjwD90ExiDd/puCRJ
	kzoZlqvUR9GblTA2rB+zqLmU1jo6wonY/sJBPFqavwLd5a6X2n8RBfGNgNBUiN2iM//Fy4i
	JPMgMqWWSj7boToOOh271Zne5WocJ7eeq3GfVTr7N9h/oDpbOyvHv6ubRU5nxLTUHCexSg/
	5fH3DkOVDS4CE31YlTwXcXy22kJqSUTwITm0sCrmbBb0eRgzujtqYvgRTzaPXkU7OEwY5Kg
	HP1FHtqzlihsfudZ6ziRZnFhZr/E2pbtuwf6fATdg3ziPP2VoIsoBfWapOSsxpl8pGhvEPW
	vplkxoe4Yanqgrx+Gb3Jn8HjEUoUqEvgEl0uEzshw2y6TbyFh3zr83Z0zD/tmz0ATvHZk/G
	1XY6tV5X0UjXQAgAqz8Rc1vhAWUIEfMI3EixqfxsHmg68XnN5Q9NMyZFWkcZG/0CatWDr/0
	u6mam+hKyW19ImvG69Je5KvzqzzvnLe0A==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

ntfs_file_fsync(), ntfs_dir_fsync() and __ntfs_write_inode() lock an
inode's mrec_lock before taking the mrec_lock of its parent directory.

ntfs_rename() takes old_ni->mrec_lock and old_dir_ni->mrec_lock
before taking new_ni->mrec_lock for an existing target, or
new_dir_ni->mrec_lock for a cross-directory rename.
This can deadlock when ntfs_file_fsync() or __ntfs_write_inode() holds
the target inode, or when ntfs_dir_fsync() holds a child target
directory, while rename() holds the parent directory and waits for the
target.

Fix this by locking the existing target inode before taking any parent
directory mrec_lock. For cross-directory renames where the target parent
is a descendant of the source parent, lock the target parent before the
source parent so the directory order matches the child-to-parent order used
by ntfs_file_fsync(), ntfs_dir_fsync(), and __ntfs_write_inode().

Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Closes: https://lore.kernel.org/all/C4D296F0E9F3D66C+9397ffbc-eb55-44bb-9b3f-5da4809e7955@smail.nju.edu.cn/
Fixes: af0db57d4293 ("ntfs: update inode operations")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.5
---
Changes in v2:
 - fix the NTFS module build by using exported is_subdir() instead of
   unexported d_ancestor() (suggested by kernel test robot)
 - move the ancestor relationship check before taking any mrec_lock

 fs/ntfs/namei.c | 62 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index a19626a135bd..5ff25e9aaa32 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -1266,6 +1266,7 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct ntfs_volume *vol = NTFS_SB(sb);
 	struct ntfs_inode *old_ni, *new_ni = NULL;
 	struct ntfs_inode *old_dir_ni = NTFS_I(old_dir), *new_dir_ni = NTFS_I(new_dir);
+	bool new_dir_first = false;
 
 	if (NVolShutdown(old_dir_ni->vol))
 		return -EIO;
@@ -1301,36 +1302,39 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
 	old_ni = NTFS_I(old_inode);
+	if (new_inode)
+		new_ni = NTFS_I(new_inode);
+	if (old_dir != new_dir)
+		new_dir_first = is_subdir(new_dentry->d_parent,
+					  old_dentry->d_parent);
 
 	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
 		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	mutex_lock_nested(&old_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
-	mutex_lock_nested(&old_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+	if (new_ni)
+		mutex_lock_nested(&new_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_2);
+
+	if (old_dir == new_dir) {
+		mutex_lock_nested(&old_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+	} else if (new_dir_first) {
+		mutex_lock_nested(&new_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+		mutex_lock_nested(&old_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
+	} else {
+		mutex_lock_nested(&old_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+		mutex_lock_nested(&new_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
+	}
 
-	if (NInoBeingDeleted(old_ni) || NInoBeingDeleted(old_dir_ni)) {
+	if (NInoBeingDeleted(old_ni) || NInoBeingDeleted(old_dir_ni) ||
+	    (new_ni && NInoBeingDeleted(new_ni)) ||
+	    (old_dir != new_dir && NInoBeingDeleted(new_dir_ni))) {
 		err = -ENOENT;
-		goto unlock_old;
+		goto err_out;
 	}
 
 	is_dir = S_ISDIR(old_inode->i_mode);
 
 	if (new_inode) {
-		new_ni = NTFS_I(new_inode);
-		mutex_lock_nested(&new_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_2);
-		if (old_dir != new_dir) {
-			mutex_lock_nested(&new_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
-			if (NInoBeingDeleted(new_dir_ni)) {
-				err = -ENOENT;
-				goto err_out;
-			}
-		}
-
-		if (NInoBeingDeleted(new_ni)) {
-			err = -ENOENT;
-			goto err_out;
-		}
-
 		if (is_dir) {
 			struct mft_record *ni_mrec;
 
@@ -1348,14 +1352,6 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		err = ntfs_delete(new_ni, new_dir_ni, uname_new, new_name_len, false);
 		if (err)
 			goto err_out;
-	} else {
-		if (old_dir != new_dir) {
-			mutex_lock_nested(&new_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
-			if (NInoBeingDeleted(new_dir_ni)) {
-				err = -ENOENT;
-				goto err_out;
-			}
-		}
 	}
 
 	err = __ntfs_link(old_ni, new_dir_ni, uname_new, new_name_len);
@@ -1386,13 +1382,17 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	inode_inc_iversion(new_dir);
 
 err_out:
-	if (old_dir != new_dir)
+	if (old_dir == new_dir) {
+		mutex_unlock(&old_dir_ni->mrec_lock);
+	} else if (new_dir_first) {
+		mutex_unlock(&old_dir_ni->mrec_lock);
 		mutex_unlock(&new_dir_ni->mrec_lock);
-	if (new_inode)
+	} else {
+		mutex_unlock(&new_dir_ni->mrec_lock);
+		mutex_unlock(&old_dir_ni->mrec_lock);
+	}
+	if (new_ni)
 		mutex_unlock(&new_ni->mrec_lock);
-
-unlock_old:
-	mutex_unlock(&old_dir_ni->mrec_lock);
 	mutex_unlock(&old_ni->mrec_lock);
 	if (uname_new)
 		kmem_cache_free(ntfs_name_cache, uname_new);

base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
-- 
2.43.0
