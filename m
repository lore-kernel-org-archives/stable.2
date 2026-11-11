Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418113;
	b=0oIBLhmvDP4ZVq528UJU8oPU9Z+l3H8fXs3UWbQYrpzioQnx5pqhBIcgd87gnJOfhn6g
	 9hh/BOoep/aKtabeN03mo/8G+mhjTdNhNcwHiPmir97vup6QGJwQ3K8GmJbtL0zo+UVEP
	 G3ET1+yld8NAiy1Ano4oiPekHath5ctG2pA/ociSVRs9fF62J26p6Im6jpgbXlGqt5hZ4
	 5CLe4pZyugPYUcDwEhpOqOecBPp40r1Oq/1J2pDchciIeUMVqnltyhsVRmKeZ5cW31OuG
	 rrX7eLieE3D1vS9hzfUJzFiwVTwAp4gl8WK69TUg2jKCWLm/UW5FREzkLiBFf4mPsvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418113;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f0T98J3k5Zmfkfg7rLQiI/nniAmIgHY1HZPyFWkEJ6w=;
	b=Nd1QllIDeTSqGxvaH01EcqPlxaaf0PK9xrFWjy7eJpPcXtmkj5p+wMyY/vhuo8CwTJ8i
	 Wi09V2RlURl+QdMOa6HJRvv8MQOMyYw+/43DIO9xIl1X3LTNdXv7sD0qJ15qKfcoeIb3/
	 3qLbyWwrWPgwwiLUF9nfx24coWfRX2+pEeN/OtfP34JIx+0A84wVC6/WVP77dA8ddnEan
	 O1grYhBBFthL8AZaufc3WlgjC7Pv7P9hvzWGqXkZvXwKq9OLGsFMsk8GmimVAq0QUqzPU
	 626h1ZrYJIGWgq9i5O7jKOTDe3bgnASHUDhpk19y80WLpandPDaHdXG9QG+D/ZIxC6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fjP24Zs/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853BD606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fjP24Zs/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AF11F00A05;
	Wed, 11 Nov 2026 17:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418113;
	bh=f0T98J3k5Zmfkfg7rLQiI/nniAmIgHY1HZPyFWkEJ6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fjP24Zs/8gmXlMi72FvXu5Xqnzt8/xW6zcA6vyJdCLE7HtILfigMccNeEzdnIddrh
	 aiu1xQRlavXSWt/LhAEvpeDsVS1+BpN4HdB+YWF0q5MnKz2zTHt3LWSeJTgtsgv4DE
	 bduxBRpQKf1zfgFF5n7XjGVXrrpnCgmijAuDOlNNQcSSleEq0JRyqu4A0BHRoqyEAf
	 bGEJS1FAmhkqw2mlZK36bTryO+eSxKlc4XPmbrq+9PtyxqN0Ey5X0xFq27SXrj/obm
	 L/vv2wRD7R6d+zG/5D6l8uWMvv27wtEIFQpU7MpaiQ3KHhV7mtUUzkRG1SDK7TEgqY
	 +ZaYq8yOswUjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] f2fs: release a removed xattr node in roll-forward recovery
Date: Wed, 11 Nov 2026 12:28:31 -0500
Message-ID: <20261111171916.3469500-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051156-failed-6.18-f5924de8867c@kernel.org>
References: <20261107051156-failed-6.18-f5924de8867c@kernel.org>
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
[ sashal: adapted cached-block operations to the existing folio and page-cache APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1b67184df3dd6..bd3e475c1eaf6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2839,6 +2839,45 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct folio *folio)
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

