Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708563E2AD6
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695552; cv=none; b=lon4yuMWDFBNpCO80m7FslFl3z14jOWsZZ+82IOCiAdSbe4jIaZtQJ1xrjgNWvuoFby2JXn3XNFJSFVxF71h848olVqUGVJI/9rsBfOcyHEvH6XQJGqR3pHtqIlqarjayadHpQTLOWzxP3iYB+gR8EYOu13lX9aI4NMV53KXmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695552; c=relaxed/simple;
	bh=1gwedEuQAnj8pjDRP3zLMcG/8f2DWyHYe8ySy5HH+Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA6UyXWj3aTDffpKhWCQMtpvLj9c1aUnMV3xKUoqTApHIcpezc3nseEuoYxwlvQvuOxI/Yr80cIfjTUvsrRNDY9C6Fmd+lb6H3JttPNB2xgTFedUbqb2n9kpuvz/qa9zsR1ueh7gdPjwMmQ+jXFjvSCdqe4tCe4NUFnJCImg8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocV3P0ki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocV3P0ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B2A1F000E9;
	Tue, 25 Aug 2026 22:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695551;
	bh=sahSxs11TB+VY2RepctS0+3CbTmouCibPtwlGNYcbkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ocV3P0ki/3nkshTILshuBjCH5pXzSLb289UtHVtoHMgjxUaGtmeNOs8zuvaM31wpK
	 zGDFjEnOHEgvcjkETjhXTCxs+3g14qE/QSXikjun0mG5Wq7gNZyY7eS52xkYBSOzFY
	 wYQ3AOBg0xD23q/pzfWo3ItjoM+xxMmcFfPw5PC12twKznbui9QcyX/D1UY7jGCAQc
	 3/3MXuG8p+D/vsXBn8tDYwf5HBxZPd7q1Cirxw5OM4dDYvEP92ql+TGpeFqn8rkGUn
	 T7jjvsedEpsqdslMpp/UIvkVoMN4c7vH3GBYJMPuJVEhnpcUo+yT6bOfELbkqIcW2S
	 TuGz4Qcm4w/Hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] ext4: make state in ext4_mb_mark_bb to be bool
Date: Tue, 25 Aug 2026 18:05:47 -0400
Message-ID: <20260825220549.2781247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082454-agent-feisty-8c0c@gregkh>
References: <2026082454-agent-feisty-8c0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit d2f7cf40ea89b486fb7a25f5ab9a5d3ce26fb4bb ]

As state could only be either 0 or 1, just make it bool.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/20230928160407.142069-2-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: d8b8dd3530bf ("ext4: propagate errors from fast commit range replay")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h        | 2 +-
 fs/ext4/extents.c     | 4 ++--
 fs/ext4/fast_commit.c | 8 ++++----
 fs/ext4/mballoc.c     | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 317c2c0c015b2..387509da86a2a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2940,7 +2940,7 @@ extern int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
 extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
 extern void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
-		       int len, int state);
+			    int len, bool state);
 static inline bool ext4_mb_cr_expensive(enum criteria cr)
 {
 	return cr >= CR_GOAL_LEN_SLOW;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9c2d23958146b..d05f5790a5ac8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -6207,13 +6207,13 @@ int ext4_ext_clear_bb(struct inode *inode)
 				for (j = 0; j < path->p_depth; j++) {
 
 					ext4_mb_mark_bb(inode->i_sb,
-							path[j].p_block, 1, 0);
+							path[j].p_block, 1, false);
 					ext4_fc_record_regions(inode->i_sb, inode->i_ino,
 							0, path[j].p_block, 1, 1);
 				}
 				ext4_free_ext_path(path);
 			}
-			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
+			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
 			ext4_fc_record_regions(inode->i_sb, inode->i_ino,
 					map.m_lblk, map.m_pblk, map.m_len, 1);
 		}
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index ca5f1b0d2687b..d96d303e390da 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1838,7 +1838,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			 * at the end of the FC replay using our array of
 			 * modified inodes.
 			 */
-			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
+			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
 			goto next;
 		}
 
@@ -1907,7 +1907,7 @@ ext4_fc_replay_del_range(struct super_block *sb,
 		if (ret > 0) {
 			remaining -= ret;
 			cur += ret;
-			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
+			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
 		} else {
 			remaining -= map.m_len;
 			cur += map.m_len;
@@ -1966,12 +1966,12 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 				if (!IS_ERR(path)) {
 					for (j = 0; j < path->p_depth; j++)
 						ext4_mb_mark_bb(inode->i_sb,
-							path[j].p_block, 1, 1);
+							path[j].p_block, 1, true);
 					ext4_free_ext_path(path);
 				}
 				cur += ret;
 				ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
-							map.m_len, 1);
+							map.m_len, true);
 			} else {
 				cur = cur + (map.m_len ? map.m_len : 1);
 			}
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 73b27ddafe915..4ec4388932eaf 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4121,7 +4121,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac, handle_t *handle
  * blocks in bitmaps and update counters.
  */
 void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
-			int len, int state)
+		     int len, bool state)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct ext4_group_desc *gdp;
@@ -6158,7 +6158,7 @@ ext4_mb_new_blocks_simple(struct ext4_allocation_request *ar, int *errp)
 	}
 
 	block = ext4_group_first_block_no(sb, group) + EXT4_C2B(sbi, i);
-	ext4_mb_mark_bb(sb, block, 1, 1);
+	ext4_mb_mark_bb(sb, block, 1, true);
 	ar->len = 1;
 
 	*errp = 0;
-- 
2.53.0

