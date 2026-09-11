Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC341B8E4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155154; cv=none; b=exL/rdU4VyOyuZ8yyw2vBuEMnFVuy6e9IiWmJYYXf+rNgTcfUZbqkav3DrQ/DZR03crNhsya0SjorGySyb+DcbRXL5l4iJwQF7P1XO5eD3JANPq8t0RL148g608RS7CB14Ddai7rgogoqbKaAWtfMsRhzgQPVBq+MNksfas1rco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155154; c=relaxed/simple;
	bh=C4Gljiq+bSjj2SEqpdoUAkGnbul7ggM4wLs0HI8uXNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNxJNQWKZZ1xR8/LXbtGuphyjB8xnHxqmgaPiBCe3/88SfRwbDbBKt2ZJCHWSeVSLwPpw1WEvZRNtKXbmWsIT0F/ZgzkDSONPc4U4j3s1YtinJ3lvgqwjG2Uv/Rgbxos4Ra3BWLh6/3zERV7bwS/fakUCCGCJdY2u6eOtY3t+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbSHaZuF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbSHaZuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674C81F000FF;
	Fri, 11 Sep 2026 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155151;
	bh=Y0eW1sV4QxK7fSvnu7ufRK67S3rH/QQxoc/n+Wd9Yuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NbSHaZuFAB+aEUsfbo4RFyq9GpG/WLnmMBlCAE4Or21GwGXO3TC6nvE8zWlnC3O9V
	 +c6NtknVPSCNGylUqvGSZsk7lkhvtsRXENe3zhZnxBIKeo4N8yWqX004+ARz74FvIv
	 SI/2m316pJdUsNO33w8TRopJaQ3B6V3re6/LlZ7PSki4rqkPptmmc0KYhNMspxb1PY
	 PBzwOxOrfc3ukXr3kLjFs+sodrVWHgp6gg+bz/r6Xe6zKwwKhX627/UvrH2siczmsW
	 YWBpWqN5FUlcmm8h6FeTUvj4SPfR49S1gchmuYcUSxbPoQboowvdIAKJSGrCTltLPZ
	 6ko5DpH1DX6SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: wangzijie <wangzijie1@honor.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] f2fs: convert F2FS_I_SB to sbi in f2fs_setattr()
Date: Fri, 11 Sep 2026 15:32:27 -0400
Message-ID: <20260911193229.1414042-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090949-defendant-bonsai-eda1@gregkh>
References: <2026090949-defendant-bonsai-eda1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: wangzijie <wangzijie1@honor.com>

[ Upstream commit 90c5ce37adf074ed85b26d1cd43074f29c0743ba ]

Introduce sbi in f2fs_setattr() and convert F2FS_I_SB to it. No logic
change, just cleanup and prepare to get CAP_BLKS_PER_SEC(sbi).

Signed-off-by: wangzijie <wangzijie1@honor.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: d0a481fad5c7 ("f2fs: fix to avoid potential section-unaligned pinfile")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5f69bdca95c27..038b3f14b0a27 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1015,9 +1015,10 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;
 
-	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
+	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
 	err = setattr_prepare(idmap, dentry, attr);
@@ -1056,12 +1057,11 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
@@ -1071,7 +1071,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		i_uid_update(idmap, attr, inode);
 		i_gid_update(idmap, attr, inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
-		f2fs_unlock_op(F2FS_I_SB(inode));
+		f2fs_unlock_op(sbi);
 	}
 
 	if (attr->ia_valid & ATTR_SIZE) {
@@ -1134,7 +1134,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	f2fs_mark_inode_dirty_sync(inode, true);
 
 	/* inode change will produce dirty node pages flushed by checkpoint */
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	return err;
 }
-- 
2.53.0

