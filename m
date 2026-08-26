Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F242874F8
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741857; cv=none; b=qS4wGjYUPhdt+sysJqrvXWC9iagadST6TP0NTiplcJAVOc8WFf5qMXhrc0tq/HH1Mfn/NpGhYK+mzlmIWT3FsJZcO/M2yK4/sT7pTb5Psder53bGIPN+poD+tMmLWC24BhK5uGPVxg8dFgD3pslmZFQ6Fi5xaOzNzyj5UmCiJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741857; c=relaxed/simple;
	bh=0hcVHPWnuReN5kYauniBLcmyCXrmGI88kfFT86q5KBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENUtVGhJl5fykA8lkA5dgyIRP3JNE5ezEIWSNiLB3YIBaKqdVbZcpoqiG3TK8bsxFserfCZrJjU/FobKf6jgNDx/27zIrm2XDLw5Bcr4OzHF1+89hwO6xrsHU4ehG24fg033fVipm6Dqav9hsTYpsKa1udGokjjbbEgaQIO8VmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhFM3aya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhFM3aya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8FF1F00A3A;
	Wed, 26 Aug 2026 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787741840;
	bh=OsdowQMA1Kmk6BvGI9wRjrPskJx9W9+nYDdehLMJ6kE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HhFM3ayagm5P4x0cActjjO+Xgc/LWj5SMOabdznPPvqQuZ3DGKW2FWp49HNB5/713
	 2Z+U+lw73qGDiVxmqFRU2PFYCqj+couiG7+JU4eIIoEK6ukVcfBScIisPLI80kf9Lc
	 7DPXvkOuRZdrzyMUvdiBYaHGIvAVF3NAr6i0WH2Vpi1rrIBhhRn1QMXdzYamjQqHrV
	 2SR7KgrDNitSKg/loseG1YS7TfD0ZJ895QPR6okkT0XxuF2LW1e05qiQmLpa9PJmLa
	 RnxoCrZbwzPQP/vo9NEFvNOiOVr7Tsh/1raFjhNGNelISWpxO3hrp6wyOPcO28eJEy
	 MP+M+4qpAYXsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ext4: propagate errors from fast commit range replay
Date: Wed, 26 Aug 2026 06:57:17 -0400
Message-ID: <20260826105717.2608181-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082456-backache-routing-3aa7@gregkh>
References: <2026082456-backache-routing-3aa7@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/fast_commit.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 26b7782b03f40..4f73f0ad6c85c 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1678,8 +1678,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
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
@@ -1741,9 +1743,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
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
@@ -1804,9 +1807,10 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
+	ret = 0;
 out:
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 static inline const char *tag2str(u16 tag)
-- 
2.53.0

