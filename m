Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416813;
	b=DYfMPnH5kAhf+TrXIJtogb7R/pKJH2n39ObTPmeP8pUarWLCqOU8nU801pBVi8xYJVeg
	 59h8uAJvxOBhN206GBcHOkjZV95JuUrv/QKnsip+K6YqvWgp5ol10gSDJp1U4/zTHA3Mj
	 YXsJx3BmVDwm7hUR9eo7AoDiW2TFWC2hinQWRFtldpbdZrYQ9gpy8yS/48rrssc8NpdEd
	 bbk19M2loRKwhrpLy6AEVzpKnotl5O67MKqqlBgorWRRkI0/e+XWFpybgSiYEyGW/oo/G
	 PI2N7YP6U9LW3QCR5ct77Akyus75Pi1fuAJawcL0VvDy8ugSEZh4Qh9LsCcnfi7su/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xF6KUOYa5j/uJ3jpM45br7D0iPl99/Qm8tZ2TKVwEp8=;
	b=d7NhX9y2NeqZjSe8uNRBEmkpfmXMEwls7BWBe9nGAciJUHw3hPbR58TO3s+pWfZItfjs
	 FXlSOqr/s+qFck7OKJrjZoBR2BR0gUnqFRbdXRZDra6rmnVU5dia1zULH1+Qbm1zsH+Jf
	 Kk4L0GS2yvP5NXXZx97kh2JKrhlrcnGwlzqVWJh9c3VS22FXt2wtE8ratAtK6+FGW+QOY
	 v9aNjPwCB6JU5V4dGTUlHG/GyvA+pdHudnhAB3kGioZCaXDlYxp0PwjbToCsa//+9LriR
	 vNILeuvwGA8Kr90TPCCrq2+MFXfvkLjR7M/nTOmj65bZ0/soWJn7NUCyk/h4AHA6obA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6P713pf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C96606A887
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6P713pf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF3C1F00A06;
	Wed, 11 Nov 2026 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416813;
	bh=xF6KUOYa5j/uJ3jpM45br7D0iPl99/Qm8tZ2TKVwEp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A6P713pfyrMLDQ9G8JIrBJYPvEfprinfOuysed+l6Iyb7zosrRLRPTG0QIbJ4GoNa
	 I3dxcnEJGVcpPxbZF+NY0ZVKNKb2d06dSxi/gGbaybE4M/rFpudRE3+Ho4N6Nl4317
	 fGf12tcgIXpvP00iB4du+O1wkn8p5nvkZUgcd011rpuuVhJcQelyifcJp/Te85OIlb
	 GCVG+T6BgmT0sq/iwmmOCC+cpWg/NHT3vqCtnC5gOkAD9OO0m9fV4Q1QCswNdvwcWY
	 IR2/xlTDN7phcHrxXpEf1einF/eZjZQEKLQf7MMHcOcKWB2EAyfuU526xfKFk6LE5j
	 6UGYhMq7GweMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] f2fs: release a removed xattr node in roll-forward recovery
Date: Wed, 11 Nov 2026 12:06:51 -0500
Message-ID: <20261111170435.3358982-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050503-failed-7.3-f5924de8867c@kernel.org>
References: <20261107050503-failed-7.3-f5924de8867c@kernel.org>
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
[ sashal: Replaced newer node-cache helpers with f2fs_folio_put() and truncate_inode_pages_range(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b23fe1383009a..a0bd7bbb5cc0c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2871,6 +2871,45 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct folio *folio)
 	f2fs_folio_wait_writeback(ifolio, NODE, true, true);
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
+			f2fs_folio_put(ifolio, true);
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
+			f2fs_folio_put(ifolio, true);
+			return -EFSCORRUPTED;
+		}
+
+		f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
+		dec_valid_node_count(sbi, inode, false);
+		set_node_addr(sbi, &ni, NULL_ADDR, false);
+		/* drop the cached xattr node, which may be dirty */
+		truncate_inode_pages_range(NODE_MAPPING(sbi),
+				F2FS_BLK_TO_BYTES((loff_t)ni.nid),
+				F2FS_BLK_END_BYTES((loff_t)ni.nid));
+		f2fs_i_xnid_write(inode, 0);
+	}
+
 	f2fs_update_inode(inode, ifolio);
 	f2fs_folio_put(ifolio, true);
 	return 0;
-- 
2.53.0

