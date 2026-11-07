Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046318;
	b=zj3UbfuYUJVTybaOCVQlIHxEvgJFfEUUXVAqpeIpYGReqN5DNd/yP5UF299NTzwczGaE
	 2BzOZEktMKjfK5Wvr3sZJW97smjjMioSI7CnK28NvEbNMK9+65HgvdgEdRjhdxJ09GPd+
	 66KWLMl/6CJ5igD8qA1/G60pufIv8NXkt16jalrpdd9tU+MoOprur24QHuvgtLrkvza/A
	 lHoctYxuPnctIoOLLlMjXwYzJ/XazjZlgnyQTiiE8X5TIpWAQazIR1PqqQ/p9e+0x9aug
	 hlC87i/1rTdN0WQozK7fTMLtF5R+iRk7J4EftAmrcg/DOj02JS83iMZDWnRdMZfGNvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046318;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Hx89+idkjzoGDZFo6pGHZ1h2KUrp5kOj6HWYXoRIGq0=;
	b=037OTXxpA4YyX8kwCfuEZolFTya5bxbdmA86Ft9TJj2BH6Ubfv1YsTW/7JveqYiJDWi0
	 r/lvYF3g4XyMj19EHO6zT3paY/ZidoBIA9/j9gKUi3HwAmmGsy6PImMe19fAYGtddV/0Q
	 tTlcKbtp+vbVxwRBp1gJSD8PwJ/ETqHlbcEijZIeet/YoaYCG/2we+1ptYmIaWRIeJek/
	 +0E2Yv1ZIoCL/elrNQB0Ipjj7O0mCaOOZ1rTf7rBOcehZWJw0g0MABzEiDqUdalB9RdGF
	 ADa1FqHLhDfv15792pqNYChNmkJiWNO5ujn5QbP6H2qLKdvluW8OLs8BE9NYYyKmhvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIvPwbbF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIvPwbbF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1ED1F008A1;
	Sat,  7 Nov 2026 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046317;
	bh=Hx89+idkjzoGDZFo6pGHZ1h2KUrp5kOj6HWYXoRIGq0=;
	h=From:To:Cc:Subject:Date;
	b=AIvPwbbF+Bfp4VrUJ1/xYx5gizlUwsqrwIhqjLVLgMu6/cmtNqpgp8gHCdzGhq6nu
	 j2wIzCtSkHiEGbBOFTN1zhlezE0tfJb+3nPU2UYVyhiGAgB8OKFGiRzLzySFf6tkCV
	 Co4BQ0MMfsZQUUs+OrNE0UbtJyIscftoWwYIqezsnudnC9nFF6B2T35dRyrLeTff12
	 ssZX1w2TvAc6+QZInRslBM4kO5PFeYrUosfj94P1qGI4kFnk7X+YiyNSTiJcb8500r
	 PJT+qN9vdWKE2EQP6Zh4+V62PB2lGckzF1ojho57cpRLiCIpedsJAlQj9H7mjnh0fa
	 cxali3HIGWf+Q==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: release a removed xattr node in roll-forward recovery" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:56 -0500
Message-ID: <20261107051156-failed-6.18-f5924de8867c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f5924de8867c09206ba631b9faed63862ec00a10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051156-failed-6.18-f5924de8867c@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f5924de8867c09206ba631b9faed63862ec00a10 Mon Sep 17 00:00:00 2001
From: Daeho Jeong <daehojeong@google.com>
Date: Thu, 15 Oct 2026 02:57:31 +0000
Subject: [PATCH] f2fs: release a removed xattr node in roll-forward recovery

When xattrs shrink enough to fit in the inline xattr area,
write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
the file is then fsynced without a checkpoint, only the inode block is
written, with i_xattr_nid of 0.

Roll-forward recovery starts from the checkpointed inode, whose
i_xattr_nid still points to the old xattr node.
f2fs_recover_inline_xattr() copies only the inline xattr area, and
f2fs_update_inode() writes the old i_xattr_nid back. So the inode keeps
the stale xattr node:

 - The node block is never released, and fsck reports "nonzero bytes in
   xattr space after end of list".
 - If the inline xattr list ends exactly at the end of the inline area,
   its terminator is read from the stale node, and the removed xattrs
   come back after recovery.

When the fsynced inode has no xattr node but the checkpointed one has,
release the old xattr node as truncate_node() does: check its block
address, invalidate the block and drop its node cache, which may still
be dirty.

Fixes: 28cdce0459cc ("f2fs: recover inline xattr data in roll-forward process")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2dc136dbee34f..424e95ca58789 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2846,6 +2846,43 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *ent
 	f2fs_cache_wait_writeback(ientry);
 	memcpy(dst_addr, src_addr, inline_size);
 update_inode:
+	/*
+	 * The xattr node of the checkpoint was removed before fsync, e.g. the
+	 * xattrs became small enough to fit inline. Release it as well, or
+	 * the inode keeps pointing to the stale xattrs.
+	 */
+	if (!ri->i_xattr_nid && F2FS_I(inode)->i_xattr_nid) {
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+		struct node_info ni;
+		int err;
+
+		err = f2fs_get_node_info(sbi, F2FS_I(inode)->i_xattr_nid,
+								&ni, false);
+		if (err) {
+			f2fs_put_cache(ientry, true);
+			return err;
+		}
+
+		if (ni.blk_addr != NEW_ADDR &&
+		    !f2fs_is_valid_blkaddr(sbi, ni.blk_addr,
+					   DATA_GENERIC_ENHANCE)) {
+			f2fs_err_ratelimited(sbi,
+				"nat entry is corrupted, run fsck to fix it, ino:%u, nid:%u, blkaddr:%u",
+				ni.ino, ni.nid, ni.blk_addr);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
+			f2fs_put_cache(ientry, true);
+			return -EFSCORRUPTED;
+		}
+
+		f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
+		dec_valid_node_count(sbi, inode, false);
+		set_node_addr(sbi, &ni, NULL_ADDR, false);
+		/* drop the cached xattr node, which may be dirty */
+		f2fs_truncate_node_caches(sbi, ni.nid, 1);
+		f2fs_i_xnid_write(inode, 0);
+	}
+
 	f2fs_update_inode(inode, ientry);
 	f2fs_put_cache(ientry, true);
 	return 0;
-- 
2.53.0




