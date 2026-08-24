Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB43EE1FD
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574431; cv=none; b=GOKsU+GIpOMtS2tn+QKRFwiyZ3XEdBZFb4k9xBYrdeFDFGbwRkwZstC4vL95dU0uWbEqyFAI3LjuNtDWW0iTO7G6NTJbpqQ7hMoveLSTP9GelOlFsqwbMqldUNN9XrsCz5CFiZ7MGGyavz5BFSRd0iBS3K3CHp375XZgMlTidU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574431; c=relaxed/simple;
	bh=81CREufPNgS2msADd2LrVryyPgVR0giuOGRo//712Xw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DcyWvDdBqcqqgZ6Vm8GTTzPTPQ+/oIWuwDvsm8FYj63Gjg2Cau0ZhkPncPx+Cssfluor9rjUhQ2aZDTEOBC9+8LS2Zv1Ww7Ql3G6axrXx4nBsBUrJDIUMnbJmZgRA/aEmebC1/9prqGdxVbd48qUQoykoZ9BspmgMEsRGriu674=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=smsCxmt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="smsCxmt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421271F000E9;
	Mon, 24 Aug 2026 12:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787574429;
	bh=iTRzZ75NLuxHocPeMLpbe3s/GOgKA6Xk8a12m7/GXj0=;
	h=Subject:To:Cc:From:Date;
	b=smsCxmt4/K1CoTYtx3Ei7QL4jXWeWrPujj12tshYLjWS3ru7S+lgKK80OKUP/DCbE
	 z98GIOKgA/zQfR7emmjiyqyoF1HKk+V+0LOE8Bdd3/BDlzwymccd7T6PLCCizgTV3w
	 1OCzXMZIDYZu1umtkSMvf4aPZT4N3+4uwhF0BdtY=
Subject: FAILED: patch "[PATCH] ext4: propagate errors from fast commit range replay" failed to apply to 6.1-stable tree
To: 3497809730@qq.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 14:26:55 +0200
Message-ID: <2026082455-unread-dinginess-7c90@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d8b8dd3530bf41e14b118702cdaf9de64bb96885
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082455-unread-dinginess-7c90@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

