Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820244063D
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695553; cv=none; b=roqUcFvDRiBA6pz+wR7GbT8w/nXBf5d9HcrxtloeF3/xJDscKLW/DH56b+e0b6t+KQxkmv/NxbUu7UNMngBJuSZ/GwIsZBTTobSjbOTQA0O1WQ7iqHHp0YpurJ8+zlT5UN4/Fv2RzdgDqXl+/lqWANiCj6SQg3X6JC1LZ+9QJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695553; c=relaxed/simple;
	bh=pr5X5bl0ZnFDjfcr+M4+umg91bMtXSpoEPbtUawQ3as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6YNctAO54DVMgNAAda15F7rv2CcOnD1jmIOwHIzYzPQDLvY2a8hpUl74KJk0bowRU8wLfSojZdtPVkOFk4gnQVobtMrSBklXmv8x7QEWWj82OdsqlVDDPcUHEtfF2MmhWUFh3dl8bK+R2U0d/MVg+XSqkTyCoaQ5y79GdrJMxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUi4K7KF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUi4K7KF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FFE1F00A3E;
	Tue, 25 Aug 2026 22:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695552;
	bh=qtaLR2SwkOsxJy3y5CiMBkLki7G21lF2d+4eALpFmaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kUi4K7KFkcx0iVTn91lx1tjiv1gPORPevCKsrZq+Q0yMYZX5fN5HbeC+QtEQjB0MI
	 r6viBMsHBkiErEI0oogj8RegX4+iGFwfk+aZwovZ24FpBTYmxGcWBN3A61m1m709EN
	 3v9nWzgScpJOFq73dxiaibartm3M7wn7dtHYSetStvgZdOMdhHLdqMhxC8NuQKXc8R
	 hI9SuHcI4k9aAmfwKg1aFt0kMojhWjJ1ptUJVP/tujD/M0+awOGoyqM9rtF2i8BIRV
	 h3hk1Lesxr8r2FDLwMWJ8cfrMVXeFcsUseRjuaqTj7VXCAUab2xNsTyeEJibTAH6Ki
	 PAFMEZi04qF5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] ext4: make some fast commit functions reuse extents path
Date: Tue, 25 Aug 2026 18:05:48 -0400
Message-ID: <20260825220549.2781247-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825220549.2781247-1-sashal@kernel.org>
References: <2026082454-agent-feisty-8c0c@gregkh>
 <20260825220549.2781247-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 2352e3e461926b59f01c1e39fbb0494891cff997 ]

The ext4_find_extent() can update the extent path so that it does not have
to allocate and free the path repeatedly, thus reducing the consumption of
memory allocation and freeing in the following functions:

    ext4_ext_clear_bb
    ext4_ext_replay_set_iblocks
    ext4_fc_replay_add_range
    ext4_fc_set_bitmaps_and_counters

No functional changes. Note that ext4_find_extent() does not support error
pointers, so in this case set path to NULL first.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20240822023545.1994557-25-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: d8b8dd3530bf ("ext4: propagate errors from fast commit range replay")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c     | 51 +++++++++++++++++++------------------------
 fs/ext4/fast_commit.c | 11 ++++++----
 2 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d05f5790a5ac8..98e9c4804f084 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -6092,12 +6092,9 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	ex = path[path->p_depth].p_ext;
-	if (!ex) {
-		ext4_free_ext_path(path);
+	if (!ex)
 		goto out;
-	}
 	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
-	ext4_free_ext_path(path);
 
 	/* Count the number of data blocks */
 	cur = 0;
@@ -6123,32 +6120,28 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 	ret = skip_hole(inode, &cur);
 	if (ret < 0)
 		goto out;
-	path = ext4_find_extent(inode, cur, NULL, 0);
+	path = ext4_find_extent(inode, cur, path, 0);
 	if (IS_ERR(path))
 		goto out;
 	numblks += path->p_depth;
-	ext4_free_ext_path(path);
 	while (cur < end) {
-		path = ext4_find_extent(inode, cur, NULL, 0);
+		path = ext4_find_extent(inode, cur, path, 0);
 		if (IS_ERR(path))
 			break;
 		ex = path[path->p_depth].p_ext;
-		if (!ex) {
-			ext4_free_ext_path(path);
-			return 0;
-		}
+		if (!ex)
+			goto cleanup;
+
 		cur = max(cur + 1, le32_to_cpu(ex->ee_block) +
 					ext4_ext_get_actual_len(ex));
 		ret = skip_hole(inode, &cur);
-		if (ret < 0) {
-			ext4_free_ext_path(path);
+		if (ret < 0)
 			break;
-		}
-		path2 = ext4_find_extent(inode, cur, NULL, 0);
-		if (IS_ERR(path2)) {
-			ext4_free_ext_path(path);
+
+		path2 = ext4_find_extent(inode, cur, path2, 0);
+		if (IS_ERR(path2))
 			break;
-		}
+
 		for (i = 0; i <= max(path->p_depth, path2->p_depth); i++) {
 			cmp1 = cmp2 = 0;
 			if (i <= path->p_depth)
@@ -6160,13 +6153,14 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 			if (cmp1 != cmp2 && cmp2 != 0)
 				numblks++;
 		}
-		ext4_free_ext_path(path);
-		ext4_free_ext_path(path2);
 	}
 
 out:
 	inode->i_blocks = numblks << (inode->i_sb->s_blocksize_bits - 9);
 	ext4_mark_inode_dirty(NULL, inode);
+cleanup:
+	ext4_free_ext_path(path);
+	ext4_free_ext_path(path2);
 	return 0;
 }
 
@@ -6187,12 +6181,9 @@ int ext4_ext_clear_bb(struct inode *inode)
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	ex = path[path->p_depth].p_ext;
-	if (!ex) {
-		ext4_free_ext_path(path);
-		return 0;
-	}
+	if (!ex)
+		goto out;
 	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
-	ext4_free_ext_path(path);
 
 	cur = 0;
 	while (cur < end) {
@@ -6202,16 +6193,16 @@ int ext4_ext_clear_bb(struct inode *inode)
 		if (ret < 0)
 			break;
 		if (ret > 0) {
-			path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
-			if (!IS_ERR_OR_NULL(path)) {
+			path = ext4_find_extent(inode, map.m_lblk, path, 0);
+			if (!IS_ERR(path)) {
 				for (j = 0; j < path->p_depth; j++) {
-
 					ext4_mb_mark_bb(inode->i_sb,
 							path[j].p_block, 1, false);
 					ext4_fc_record_regions(inode->i_sb, inode->i_ino,
 							0, path[j].p_block, 1, 1);
 				}
-				ext4_free_ext_path(path);
+			} else {
+				path = NULL;
 			}
 			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
 			ext4_fc_record_regions(inode->i_sb, inode->i_ino,
@@ -6220,5 +6211,7 @@ int ext4_ext_clear_bb(struct inode *inode)
 		cur = cur + map.m_len;
 	}
 
+out:
+	ext4_free_ext_path(path);
 	return 0;
 }
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index d96d303e390da..3ee282c8d2481 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1798,7 +1798,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 
 		if (ret == 0) {
 			/* Range is not mapped */
-			path = ext4_find_extent(inode, cur, NULL, 0);
+			path = ext4_find_extent(inode, cur, path, 0);
 			if (IS_ERR(path))
 				goto out;
 			memset(&newex, 0, sizeof(newex));
@@ -1814,7 +1814,6 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			up_write((&EXT4_I(inode)->i_data_sem));
 			if (IS_ERR(path))
 				goto out;
-			ext4_free_ext_path(path);
 			goto next;
 		}
 
@@ -1862,6 +1861,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
 					sb->s_blocksize_bits);
 out:
+	ext4_free_ext_path(path);
 	iput(inode);
 	return 0;
 }
@@ -1962,12 +1962,13 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 				break;
 
 			if (ret > 0) {
-				path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
+				path = ext4_find_extent(inode, map.m_lblk, path, 0);
 				if (!IS_ERR(path)) {
 					for (j = 0; j < path->p_depth; j++)
 						ext4_mb_mark_bb(inode->i_sb,
 							path[j].p_block, 1, true);
-					ext4_free_ext_path(path);
+				} else {
+					path = NULL;
 				}
 				cur += ret;
 				ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
@@ -1978,6 +1979,8 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 		}
 		iput(inode);
 	}
+
+	ext4_free_ext_path(path);
 }
 
 /*
-- 
2.53.0

