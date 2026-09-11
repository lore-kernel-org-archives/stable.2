Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85D538D68
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155156; cv=none; b=nc8COv4kcSyi9R/UAolo/TCsHbNJKtA4rh04xe6LHJzrTb2oZpFR2EQNQkAmtDfNMCfDr8EtacRdLASwqNvpwIHcpDnoWaTHDv8mwQARQKlrCPwBWDW6IWq6kSsg3+GR9Itdq74mfOo3aR7vzSLJURH1B2cdpKV1mRr7alCb6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155156; c=relaxed/simple;
	bh=zYBnMT9aBX1VZ5zti8VuLKvCLyB8hnMFFURMoA4WYmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3wmHvNxlNHO1s89n6i01kIU/XaCb3W+i4XUXYfSm38h3JhhIjjCzetaGipY+1rxm7qreiDEMzWOzfx4w9re1lpqg8hMMchkix164i7MG0D43u0Gk/dtiuEq8y23WHxXttQjbAwdx2SIYgdB/aL7WNdVLpqWeR5KSOzdGvMa/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClASKaD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClASKaD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179CB1F00899;
	Fri, 11 Sep 2026 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155152;
	bh=f6rmcVk8ONLhGJqMA4bP89aWtxuTMk4H7gxMZBGlLVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ClASKaD/f8eIWvKi1K1QdNV6e1aAoUI9HoJ1iY0/cs4wvWxwMf6XYeS6ykcCTN2dv
	 AZlacAnhJdmhFxiPa29lR+Suk7/agULpxHZclkLVXkhQwe6qW/35VXmYHoTAOsFCbO
	 xMLJ6G1jpa3WHXnySHYt+2nShZXQXZ34xSd7VNJmmSf0MBJbVRhO4UDYiaqJlHcXyp
	 0t+a8KFe4Pl6KTweX3vB6cIF7iubwmNY+xLAWF+juKCgy4GrjMgb16iFANOSOmf99x
	 Un/f8zHyrpgeJV/Ki4ZhweTzTRoSpXSqJ2J7fXR6Osuue9I+GpJr9S+ypVlVqbpJhz
	 S/SlyRgvuzBwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] f2fs: fix to avoid potential section-unaligned pinfile
Date: Fri, 11 Sep 2026 15:32:29 -0400
Message-ID: <20260911193229.1414042-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911193229.1414042-1-sashal@kernel.org>
References: <2026090949-defendant-bonsai-eda1@gregkh>
 <20260911193229.1414042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit d0a481fad5c7a3a56ecf54a099651216869f4d0a ]

Blocks of pinfile may not aligned to section size due to wrong use
on pinfile, result in heavy overhead of GC, let avoid this by
adding additional check condition in f2fs_setattr().

- truncate -s 8mb pinfile
: random checkpoint may persist filesize w/ inode
- fallocate -o 0 -l 8mb pinfile
 - f2fs_fallocate
  - f2fs_expand_inode_data
   - f2fs_allocate_pinning_section
   - f2fs_map_blocks
    - f2fs_map_lock
    - __allocate_data_block
    - file_need_truncate
    : w/ FADVISE_TRUNC_BIT, we can expect unaligned mapping can be
      truncated while open() if f2fs is not umount abnormally
    - f2fs_map_unlock
    : following f2fs checkpoint and sudden power-cut

- mount
- open pinfile
 - f2fs_file_open
  - finish_preallocate_blocks
   - truncate_setsize
   : filesize is 8mb
   - f2fs_truncate
   : can only truncate block outside filesize, rather than truncating
     unaligned blocks inside filesize

Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
Cc: stable@kernel.org
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9cef43052f8b5..0bb12ccf9bb68 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1048,17 +1048,23 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			!IS_ALIGNED(attr->ia_size,
 			F2FS_BLK_TO_BYTES(fi->i_cluster_size)))
 			return -EINVAL;
-		/*
-		 * To prevent scattered pin block generation, we don't allow
-		 * smaller/equal size unaligned truncation for pinned file.
-		 * We only support overwrite IO to pinned file, so don't
-		 * care about larger size truncation.
-		 */
-		if (f2fs_is_pinned_file(inode) &&
-			attr->ia_size <= i_size_read(inode) &&
-			!IS_ALIGNED(attr->ia_size,
-			F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
-			return -EINVAL;
+
+		if (f2fs_is_pinned_file(inode)) {
+			/*
+			 * It may break section-aligned fallocate recovery
+			 * mechanism, so do not allow larger size truncation.
+			 */
+			if (attr->ia_size > i_size_read(inode))
+				return -EINVAL;
+			/*
+			 * To prevent scattered pin block generation, we don't
+			 * allow smaller/equal size unaligned truncation for
+			 * pinned file.
+			 */
+			else if (!IS_ALIGNED(attr->ia_size,
+				F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
+				return -EINVAL;
+		}
 	}
 
 	if (is_quota_modification(idmap, inode, attr)) {
-- 
2.53.0

