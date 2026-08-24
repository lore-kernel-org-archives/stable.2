Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781DF3EE1FD
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574428; cv=none; b=r8Z+ZMiMflzQyVx4Z9K1LwXWL7qRVoV0Bdw6KdIYuJxt3F4Lpy2wX3VEaFdSyOpxfOjwo18QCxjpjCf+mYZmp25KeCYBXgd3Fa1+yhsMwluPSDBQlnrnMJ+Y8TXaP3qd6kPBQE5QWrI8+ZNdQ6LyycgzOgdHQw/mF3LQpPhJAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574428; c=relaxed/simple;
	bh=GeN71Uq5lC8bu4AdmOTCTz0tBJ6EFbRIwXQxrQB8iXQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HOZEVyLRH3PCVazFFSgU349uf9oNQnnbHoAxq8MW6ybM7PJw2pWWk0XQI+os+pw0veqk6GKMaEbEia6UIjyINW5cAShw+K2V8DsIOhtICeKWDn0MAd0AcC4duryELk+vxyLBePH8qYup2XXadkq/XtIB6hHMFPlXCx7cDiiiXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AmnrMGXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AmnrMGXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFB61F000E9;
	Mon, 24 Aug 2026 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787574427;
	bh=dXD5KQxb5E9NEzHQ4RjSbCOlqloQG+eqsCEy45aFMi8=;
	h=Subject:To:Cc:From:Date;
	b=AmnrMGXwK/tNDJgqis+IPplNey2ikMOls/mrgMqapw5nks+1LZv8weJy5DOuygiXs
	 UpNFOk5r+3rrMN6KMnPxwsw8/vb8QB4A+pB7+DM0gG3dfWmM0A/IaueFaaohYd9O7v
	 Jt5txoLTu1SXpazncVN0DN0SvjyrXbvFGwTkOSpE=
Subject: FAILED: patch "[PATCH] ext4: propagate errors from fast commit range replay" failed to apply to 5.15-stable tree
To: 3497809730@qq.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 14:26:55 +0200
Message-ID: <2026082455-limelight-partake-3c43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d8b8dd3530bf41e14b118702cdaf9de64bb96885
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082455-limelight-partake-3c43@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d8b8dd3530bf41e14b118702cdaf9de64bb96885 Mon Sep 17 00:00:00 2001
From: Guanghui Yang <3497809730@qq.com>
Date: Wed, 8 Jul 2026 08:12:04 +0000
Subject: [PATCH] ext4: propagate errors from fast commit range replay

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

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index ca72a52f8cc9..062103e42cd8 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2177,8 +2177,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
 		if (ret == 0) {
 			/* Range is not mapped */
 			path = ext4_find_extent(inode, cur, path, 0);
-			if (IS_ERR(path))
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
+				path = NULL;
 				goto out;
+			}
 			memset(&newex, 0, sizeof(newex));
 			newex.ee_block = cpu_to_le32(cur);
 			ext4_ext_store_pblock(
@@ -2190,8 +2193,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
 			path = ext4_ext_insert_extent(NULL, inode,
 						      path, &newex, 0);
 			up_write((&EXT4_I(inode)->i_data_sem));
-			if (IS_ERR(path))
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
+				path = NULL;
 				goto out;
+			}
 			goto next;
 		}
 
@@ -2238,10 +2244,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
 	}
 	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
 					sb->s_blocksize_bits);
+	ret = 0;
 out:
 	ext4_free_ext_path(path);
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 /* Replay DEL_RANGE tag */
@@ -2301,9 +2308,10 @@ ext4_fc_replay_del_range(struct super_block *sb, u8 *val)
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

