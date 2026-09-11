Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C959B68E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161344; cv=none; b=cLs2GzsXbxdKjyiAxec5IU+FuWxVYCT5QeQgWp/7VnWBo4lwKEFWpLL5HAKcQDg2J2zcrRlGj1xmXoUuy4cGPzKiqUi0cFNhjmz0r6UGAh2xb6z/wzMVl5lH5P1xkgWTtxFBQxEIHBRKYZu3RcUdZeyQcUPx5OI4OzwXHRChKfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161344; c=relaxed/simple;
	bh=4JUNCRc+p2s0ytKfOxEh9HeQKNWICGjkcF8yf0jicpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwM9nrHJo+yJo2bkUbnxkKN2837d1oWcTMM524jMaPtHr3VzBMRyvca9Cnx1uaApt06eIpsjmlyNNZNxw0vhT1lpQUE7TwB3l6xNJq1JxVAll2R0MiVvyeEoVyDvkqtF+6VrSyZY29V45CHe2yV5IP+5oBdYek9K1QQzEp9NCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e802k8A/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e802k8A/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69691F00898;
	Fri, 11 Sep 2026 21:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161342;
	bh=xL7l5iA8O7sqh8QQmdlMzCUMV4Ih4+w+Wtx05HT6KYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e802k8A/AkL0swLPgb4XAevYPa+yorESwco6SBFttTyoIr0RhqWi+lvE0Idsxd0jj
	 drw3vVdM+ADbc7Mf1Vv4JPYCdibQHTJjUDCrW7fwOurwQ33M5wCanvpWLeoD10jcnY
	 y4biJ7Q34lsJQlMJyqgXwniU8XvlSOXMNhgsjrek1oq27Fu/MVXucVWh2tY5CTtLDP
	 CKjWW2ewxWdyo4pMGZv0HrR5fyOo8UfZCnJqKaaj+B1fDjoIOO6fQJsgPfz62QAtL0
	 BbY51s8GN3jf7Dp9rOCO9TsGI7BtVEaijYtIqXVKz/EU51cyr7zdstJ2xMYuymrz9Z
	 2+KzBBWKvhPdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] f2fs: fix to avoid potential section-unaligned pinfile
Date: Fri, 11 Sep 2026 17:15:39 -0400
Message-ID: <20260911211539.1531828-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911211539.1531828-1-sashal@kernel.org>
References: <2026090950-divorcee-jump-d9a1@gregkh>
 <20260911211539.1531828-1-sashal@kernel.org>
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
index 9f82d34eb2f43..3e0b9e166be3c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1037,17 +1037,23 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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

