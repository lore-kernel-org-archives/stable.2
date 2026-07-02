Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB341492187
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997758; cv=none; b=oabNipGTELek9lIvUYupcd3pKGWWsuWbpFQ+rDrzX7nn90BBvjXrSP4lio9dbf3S7KWvb5iE+7KzXDVibSuHj8zKLSHe9r1qpgIeMS2qqUlhhZKBPuIgFB740GRiJ2OhgY2h+ZB1/m8myBxfhKdMFJsTUTMISM6tA+ifrlfLjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997758; c=relaxed/simple;
	bh=oZYskJZfP+qkd5Qkgy57r7Q0gUVFS73MNkaSaLxEZX0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FiH+XQh6JRKZtVqBb8masRXSyC5DwrbR7M0EEj7ty0Taw7+2fgC4+2IW7OEo/MMKjv/ZPGWzqWsWp+/n4zQcQnD6pX2my8c37/1CVOcIGybVLgAPiq2V+c++j28Z0g8pAVjm3AIEvOIMKIl0vrJCfV5ybWvSIwpE1lEC2239xnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kOcKBiiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kOcKBiiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC911F000E9;
	Thu,  2 Jul 2026 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997755;
	bh=Xi/M225ovwV8Qi2w7gsXfRDK4vVACZFanQDNXZ4HoX8=;
	h=Subject:To:Cc:From:Date;
	b=kOcKBiiDPjz42q2YoGG9X7lynAiCnepKlPYIZ0zaAbNX6VLYWThWQjj2y/BEhQksI
	 VyIsBntBkm8CzA5/NJpF6CdbAnDHZSuzuOIsiHr5fp2/s5kKFxOnQa5lrFEExR9vCV
	 /swu9D0F5r0IlvCW2WbBKtbOzFZnu4E8/YO1zP6U=
Subject: FAILED: patch "[PATCH] f2fs: validate compress cache inode only when enabled" failed to apply to 5.15-stable tree
To: qwjhust@gmail.com,chao@kernel.org,jaegeuk@kernel.org,qiwenjie@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:09:18 +0200
Message-ID: <2026070218-taekwondo-skeletal-13d5@gregkh>
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
git cherry-pick -x 5073c66a96a9c23c0c2533ed4ed06e42f9021208
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070218-taekwondo-skeletal-13d5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5073c66a96a9c23c0c2533ed4ed06e42f9021208 Mon Sep 17 00:00:00 2001
From: Wenjie Qi <qwjhust@gmail.com>
Date: Thu, 21 May 2026 11:16:18 +0800
Subject: [PATCH] f2fs: validate compress cache inode only when enabled

F2FS_COMPRESS_INO() uses NM_I(sbi)->max_nid as the synthetic inode
number for the compressed page cache inode. That inode only exists when
the compress_cache mount option is enabled.

When compress_cache is disabled, max_nid is outside the valid inode
range. A corrupted directory entry that points to ino == max_nid should
therefore be rejected by f2fs_check_nid_range(). However, is_meta_ino()
currently treats F2FS_COMPRESS_INO() as a meta inode unconditionally,
so f2fs_iget() bypasses do_read_inode() and its nid range check, and
instantiates a fake internal inode instead.

Gate the compressed cache inode case on COMPRESS_CACHE, matching
f2fs_init_compress_inode(). With compress_cache disabled, ino ==
max_nid now follows the normal inode path and is rejected as an
out-of-range nid.

Cc: stable@kernel.org
Fixes: 6ce19aff0b8c ("f2fs: compress: add compress_inode to cache compressed blocks")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 939d75663a40..25f30b8eadc5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -564,8 +564,13 @@ static int do_read_inode(struct inode *inode)
 
 static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
 {
-	return ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi) ||
-		ino == F2FS_COMPRESS_INO(sbi);
+	if (ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi))
+		return true;
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (test_opt(sbi, COMPRESS_CACHE) && ino == F2FS_COMPRESS_INO(sbi))
+		return true;
+#endif
+	return false;
 }
 
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)

