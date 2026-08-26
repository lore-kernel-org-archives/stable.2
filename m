Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEB21CA13
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787705393; cv=none; b=a2QkPh0i4x4zbwz8+v6YQg4SL+segLuZy3Kf+I1TgsjQv95Qg0mYTBiM4RaBJK7zMYlcaoIC1lhvl8IvOhBPAXln+zIDSCeClNJH/KsMWfQRvsWKLeLamTTsvasrNYvXMVWDEkMMDakBlxBZxCgdICY9YKzqCZQuvF1B85miHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787705393; c=relaxed/simple;
	bh=GCHGoQO19pacWs3M0nuFvT8ubRAKaMV4E3b5gKReDN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6ynkFszajCx6tV4tDPldG5ffnm5ydHqVT46o5xF5LyhxSkWkSW6+YXk+5jveEkKBeINsu194Ry9eVkQ/5M+zQUoUrSiM3VtstM/B18wXx83yUlRoEb4a8pXkZMqxVnVpd9lu+AdzjLEulQeafmersPeEX8Uc8OtqQ6zf7Kf7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqDor0X0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqDor0X0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7309D1F000E9;
	Wed, 26 Aug 2026 00:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787705392;
	bh=NMC9TYx1Afb+dwqc4f9MFhzMWpa4Du83eohY6TizvL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WqDor0X0oiJsyujLZOVXMAK6M0y9RYSL/hv1XM9CROwsGmwL6XZ9Ke6nHBlmRbH1e
	 P92hcVlkKaF014g4d3E1iKR7tYxHoKc0BsxQhR55QMXnkl/FNwf0Mu+SO8PR6vwpWT
	 X//uxKyrizlSSqpcicnpqR4Fp1QknDzJsPi5IJLruKcaOaaS48jxewx7ewvcBBYO06
	 IM38F6dsVadbpMLlgsMZ3ViQIherHNya3NDU9T6+PDpvw6NcqgDIa0AfjdRzagajUC
	 hgvgY7yliGP7boewzpevKTDYWlImiquhap5XRYY037L9Rg8zi5MjDqfUVOp3TIwitX
	 sG+c6TbcLJUUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ext4: propagate errors from fast commit range replay
Date: Tue, 25 Aug 2026 20:49:49 -0400
Message-ID: <20260826004949.829268-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082455-unread-dinginess-7c90@gregkh>
References: <2026082455-unread-dinginess-7c90@gregkh>
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
index 49076dedd591c..3b05c46958d37 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1821,8 +1821,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
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
@@ -1883,9 +1885,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
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
@@ -1946,9 +1949,10 @@ ext4_fc_replay_del_range(struct super_block *sb,
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

