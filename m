Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418863;
	b=JHLjzCPeriWpub2Mg59OhOJm2hsK9ZnY3WH+agUNCWrL0R/uXFTFLhkJQe3ZDOc8pm8Q
	 yx85kJMByxgElfm/1Tlds3+jkuyQWrWQ6ohTxdbvHIPtZh38/WGE/CYROt7pgTdV+CQZC
	 fVX9G1m4Wm9wRE0bIEKehD9IaHU/+QI0JcA29EIbaOLqPQ3/kT+sR5k9v4V99c3RxIjii
	 SvZawUZWqz0t4WxZwldc/0pCeIc+Z/W3OUcYYxhOHXKILVqN4ALPaY8Cyi3qcdXiS5pYY
	 EEaKDb6FhDTtl0Nxb/BW4CPckROdAtiCucQ0qhSGRlb0CQovCvk9x/ule+H2o2zKwpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ms5jlLz2fNtkcIaI6SzPwe/AbGGaXqIyO0H4DXc0MEw=;
	b=kxAJ8wGFhut/RDD831D0vHIa6v7wJK5jM0AjN/lx+OiBSQ2lORsLOLMZh3/wHuulHdOK
	 OXXIqx9/XHQteTKRuXt9yAsHp8tXg/oa4MnWbIwW+eXeXtH0XJ+/YG9jyq3vYWiWgsMDO
	 xFFvY827zqVa9+tc+3jBaZfbawPOIyt4Ug+fl6n1j0j/z/bRjCsmcMuk2uRye7gDMtRRh
	 tlYI/oTLxbGAvRgOSep0fmNewGFOERxdiAt85PKC6FatDEu29MkIvPch/Yq/aj8XJ5C5D
	 Tfuc1NR9freck2ra4tkaeVuyVaMm3GeS4ZS+J8k4XWX5fhBlUaQT9c8djMkzHS4ocjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fG9amtrr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E9606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fG9amtrr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9471F00A05;
	Wed, 11 Nov 2026 17:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418863;
	bh=ms5jlLz2fNtkcIaI6SzPwe/AbGGaXqIyO0H4DXc0MEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fG9amtrr7mbjDKdt3wXEkjuC2MBizp4I90RhmWWMNt1P2xFNGXJ4+GtIfjsptHGSS
	 Az4taDM6qlcuiAhRTZBaXoDDUj7A63SGKdKzV8/5XgyRM7GUVZdXHY3580bqBgtX4A
	 swq539hjRIIz4EvkDt2/bScXq4dMitJ7FRAnptdtIShQMrkykAZze0ggpSf08f90tG
	 mw7g0BwaLK5SfmsiCei009w5r2p1l0JNu2Qnhxs2x7LZKd6bLHF8NJhRXiyf3QNxyC
	 Xt4Q9DZk0alKgcqyf2ykCmFpqb6JErNdi4TFHqWDUg+oC0JtgDzhfigggBXz4BixrG
	 CW0MHtR3vcimw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: release a removed xattr node in roll-forward recovery
Date: Wed, 11 Nov 2026 12:41:01 -0500
Message-ID: <20261111173956.3580882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055000-failed-6.1-f5924de8867c@kernel.org>
References: <20261107055000-failed-6.1-f5924de8867c@kernel.org>
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
[ sashal: adapted F2FS helper calls to the existing page-based APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 233448ba3a299..86efa908d94bb 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2763,6 +2763,45 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
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
+			f2fs_err(sbi,
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

