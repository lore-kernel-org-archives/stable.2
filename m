Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417818;
	b=wcqR5r0KPJp2FKnoMU03wzY0pdUkhojInLYQ6DtGFqqs95KptzgKVANDEXzioRZ4bxZ+
	 +17IgGy/A4+ZjhS9/JEeCC+2IH4zoANaieN3CMTVlNRz5V+cmf76IOUNcKR0SPELQxBli
	 XD7WAbn1nx3PeOQ6B8ZZ4WfUZ7snufSoHPgz96GICw43mQYBT4gtlkI2j8CxUH8OKZXEY
	 GiPm5uyIDneYpJAaqYahEr5VT5dcOhYc9JJD0SwRf65d29iRDnZVc2MmKnzANZh7bkjCV
	 7BEYy2zbLtjawmc2BHzZAYeK6KvQqoFvBiekeDeXLAo5YW41jT5RLa6zsgYlDgDtV7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417818;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r4fmQiimTXKZYacLB1rZn6Yo65xhYszU9o8NVnTjMpU=;
	b=YYnQtCUxfvA0Zn9yBK4jdOZPMPsvtzRTd4pD9WA0a9Iv9wOEBUBn9fygyeIKlsTQS90E
	 w3G5wQsVwzhjejGMWCM4mrDFy4v3qIdnTrvroCTSPEfrPkU7I57TfPR406PKWV8QOs++K
	 KUJeJZ175am6wIWSgzXIEDfW0bnSLM9h0Mxg5nqNeUFs3mE03aL1aF/qvu179ggHrJcA9
	 PjMUKHLOiMCZB0V6QAmTxClgrGEHi7iCGIxcEQK0VBkXWC+SI7Nzzij3xl2SpIcFWBQqt
	 1zJDjaumHrjHG+PDWuRFvXq968uvAlGK6/7tDMgd93EVCP/fDyK2siITh1QTYFOOa8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPARPPuW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B12606A8BD
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPARPPuW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4331F00A05;
	Wed, 11 Nov 2026 17:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417817;
	bh=r4fmQiimTXKZYacLB1rZn6Yo65xhYszU9o8NVnTjMpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aPARPPuWvO2Mg7LG6LyHxfzO2QKkV8fsU45xC5Tp9cj5qnyWK9f9ZLpVuCjDVi6lf
	 LWkITRMVtbn/Nd+i8ByiZO7jZvjSLqbVjsjzDQ/Tt8fymR4d5MWFkmbCEOck3IwBs5
	 RU/F1b+8c0+xdvkmxz/xcHgd2ALWr1MYO/jZ5iqmDN7ANSCppQvkXq5SAxUUv7T1jz
	 ql20/AlKJu/HDVc96+ZF3YKFPD8dbrpF0T6JT9t54BnS1+Y627fNkUI2Lw+Svys9iD
	 BmCURw8Gz7k18vgcyjyDVSx1MWk9A07rsNfZsQcGFD1tA5DkIlxosGOZqHdNYV2iGy
	 /BHgQfzTBACYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: release a removed xattr node in roll-forward recovery
Date: Wed, 11 Nov 2026 12:23:35 -0500
Message-ID: <20261111172233.3560716-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053547-failed-6.6-f5924de8867c@kernel.org>
References: <20261107053547-failed-6.6-f5924de8867c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit f5924de8867c09206ba631b9faed63862ec00a10 ]

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
[ sashal: adapted cached-node helpers to page-based equivalents and the older f2fs_invalidate_blocks() signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8aa52629f788c..1d4e723d0b7eb 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2755,6 +2755,45 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
 	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
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
+			f2fs_put_page(ipage, 1);
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
+			f2fs_put_page(ipage, 1);
+			return -EFSCORRUPTED;
+		}
+
+		f2fs_invalidate_blocks(sbi, ni.blk_addr);
+		dec_valid_node_count(sbi, inode, false);
+		set_node_addr(sbi, &ni, NULL_ADDR, false);
+		/* drop the cached xattr node, which may be dirty */
+		truncate_inode_pages_range(NODE_MAPPING(sbi),
+				F2FS_BLK_TO_BYTES((loff_t)ni.nid),
+				F2FS_BLK_END_BYTES((loff_t)ni.nid));
+		f2fs_i_xnid_write(inode, 0);
+	}
+
 	f2fs_update_inode(inode, ipage);
 	f2fs_put_page(ipage, 1);
 	return 0;
-- 
2.53.0

