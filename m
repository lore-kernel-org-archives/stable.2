Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F119AD90
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787707071; cv=none; b=iLyhNfTpM8jfa1ATUgocnkyr7mhUGOdq3igjZf7Vz8RXz7wW2JK2YorhJ3FIz3pRRD+GqYwjwxh2ICmN6sHWt+fbfBveVi7qYx+4K/cFo8+8NcWTTTgYCeI5uNaVYVmFOQSbLsAtFivp6HZJ+HDfTqSWYwm9HKJobRSqXRcX58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787707071; c=relaxed/simple;
	bh=DgQjT15z0j81NB31r/KcKuB5wIt7ze1/ig5HvJ0NXbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHfa5I3dvAuAMr36x4AG3DJlCkBnYJaxoPWG4IWGT7hm0rP9ScdmSqQKnk5kwFmpRGjeVtQnVHKD4cE5Om2H7sEETPqsSLSbjuTuJ4oTJO1uEpHSZiabrR5Br6uWt9mQuA6f42e4w38939rWkWgb7QPWRgedfRj0L3rh1ZoETzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mesGm/L8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mesGm/L8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547B81F000E9;
	Wed, 26 Aug 2026 01:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787707069;
	bh=hOX6J0jXFOAV75f0hLYkafr3El95OAqGqRMKAoDc1Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mesGm/L8zY+7IepJQyArWdKoyX0Wy0Z1/47Bt2soT+ZR/53mCRSmLyOk9DJYRYuZt
	 Ic7NVnS82HVbMCE5AVVuVaPLHxYlKypJt+Eu6vH/g6V+JnMxbmcKi6LAaHelGXhKHB
	 hFSjblFH5OdWcxe6/gCCdAkCHwFXYzf2j0+Ci5+a1/Ae5t0Hb9h2vKuqmm4tNNk+zk
	 BtSpL2MCT5yQp5RPCooJDH3HcnGQt7Mb5lFMEuoCVvzQTulpwQt4GcaV6z+dUfG1q4
	 WFKCQejJKe5OFvuMvJTN3hxPtjaqN4Qbf1dPzbT/B1uQSpShZd2xxiJuc4n8GKreKx
	 HBd3nhU/pUEDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ext4: propagate errors from fast commit range replay
Date: Tue, 25 Aug 2026 21:17:47 -0400
Message-ID: <20260826011747.958597-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082455-limelight-partake-3c43@gregkh>
References: <2026082455-limelight-partake-3c43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanghui Yang <3497809730@qq.com>

[ Upstream commit d8b8dd3530bf41e14b118702cdaf9de64bb96885 ]

ext4_fc_replay() stops replaying fast commit tags only when a tag
handler returns a negative error. However, ext4_fc_replay_add_range()
and ext4_fc_replay_del_range() currently return 0 from their common
exit paths even after internal failures.

This hides errors from ext4_fc_record_modified_inode(),
ext4_map_blocks(), ext4_find_extent(), ext4_ext_insert_extent(),
ext4_ext_replay_update_ex(), and ext4_ext_remove_space(). As a result,
a failed ADD_RANGE or DEL_RANGE replay can be treated as successful and
the replay code may continue with subsequent fast commit tags.

This is particularly problematic for DEL_RANGE because it may already
have marked blocks as free before ext4_ext_remove_space() fails. If the
error is swallowed, replay may continue from a partially applied range
operation.

Return the saved error from the common exit paths and make the
ERR_PTR() cases in ADD_RANGE store PTR_ERR() before jumping to out.

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Cc: stable@vger.kernel.org
Signed-off-by: Guanghui Yang <3497809730@qq.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/tencent_E3622146846A84C75C31C7D32AC4D5AD0605@qq.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ kept the existing `ext4_find_extent(inode, cur, NULL, 0)` call and dropped the `ext4_ext_insert_extent()` error-capture hunk, since this tree's extents API predates the ppath rework and already returns errors via `int` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/fast_commit.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b0c7d8e28337e..84b219cde46c8 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1780,8 +1780,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 		if (ret == 0) {
 			/* Range is not mapped */
 			path = ext4_find_extent(inode, cur, NULL, 0);
-			if (IS_ERR(path))
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
 				goto out;
+			}
 			memset(&newex, 0, sizeof(newex));
 			newex.ee_block = cpu_to_le32(cur);
 			ext4_ext_store_pblock(
@@ -1843,9 +1845,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	}
 	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
 					sb->s_blocksize_bits);
+	ret = 0;
 out:
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 /* Replay DEL_RANGE tag */
@@ -1906,9 +1909,10 @@ ext4_fc_replay_del_range(struct super_block *sb,
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
+	ret = 0;
 out:
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
-- 
2.53.0

