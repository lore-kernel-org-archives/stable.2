Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348136;
	b=1GLE/m15vh9cOB+xuWW0aDXsE0j7LW5hVGztNkDpb7+WQb8N4BopjoiM2twVINvwt2cw
	 mGIplnN+uuzs/xtpHFHGgZla29i5Ni3talj+ssW4BFU5H0xE/J7HG79xoJBg/2tuXBF31
	 +noSgbHFesPGUC4RFzHYyfoKTafldCBAmo8oePQPDZ+7Dg44Ukqffuuqt5aSoOHmPm8qW
	 muU38FN/ZyaseZ+h5ISDt1bFurwyRPmL4iDhMCCqDGLZgsBPIuIPnjvvtOy88ocmc9MEB
	 r7vb0Z5FugpkpbpEc8uY/8FLOu8SMAl0+fwV81y0JM+G9h2BPTf9+EiYaCHVPCjo0bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348136;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=emq8jmanvB3G0F7LubffLV2bdhN8Gqxf4XaL1jtvBuc=;
	b=PQJ2h9oOiBn9LD4jC4Y+cQuLFpgDY2rTnzrhSyqElXJ3e8vY3lfSP9KBzIQEtiEn8RIX
	 WYo3pyxKzXTAiKFZ0Oej33SLJkM2viSyQdvOCabVxUnx0rU73+aIXXiLbSpv69t1x61m2
	 Bobszh4VzuRn+BTNkYffyQOg0FwxVD5k+fLIEK+6jfDVdOzbessjo9qj72p+W6t1PygEd
	 yKews+DqNsrDuvmZAsMgTcfKsaCaKyPBsUMTibEfOslj0M8gkIxDZrzR/wyUONfsf07Rb
	 O3b8ijWj3nftKl+KvMMIvWpazCb9Ls5mX/8iqUuVPKMS9va4RlmLNVc0kPKbIgL9kEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcUsiqWW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcUsiqWW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF721F0089F;
	Tue, 10 Nov 2026 22:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348135;
	bh=emq8jmanvB3G0F7LubffLV2bdhN8Gqxf4XaL1jtvBuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fcUsiqWWTheVufgV1WLGI5BUHWbeD4f7Y71Up+/rR/Suj1cvjdLijkMKQHQdRs1pE
	 zIKKplH0Xunmdn6eJ9UFcy/IPn7B4rpcDoL+Yg2YTU1CNFRAJx9BOp9mxrk2B0hEOi
	 Re2IsI+fchvWpJygX0ZYzewiLvrkckp3a1yQNrmeloOFkvij5UyKocc05uHdBSwEWy
	 4Rx95xqzhKOMDYBm8hfTLDBhxb8Ol3bvPv5H+vie+4g2QJyRNu0EputQuZpKtn488m
	 D8H9+8N4DrpBPhioDUTXSakaTBvYLeP1sAXQSLmmLO3J4/dIB36AJZ/oyNF2SX2nAQ
	 vhjntE6PozkRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaixuan Li <kaixuanli0131@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: bound the SIT/NAT bitmaps by the checkpoint pack
Date: Tue, 10 Nov 2026 17:02:13 -0500
Message-ID: <20261110215940.3991417-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055006-failed-6.1-080833a32fd5@kernel.org>
References: <20261107055006-failed-6.1-080833a32fd5@kernel.org>
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

From: Kaixuan Li <kaixuanli0131@gmail.com>

[ Upstream commit 080833a32fd5dc10b3acf2fa9af9b3213e6cb617 ]

sit_ver_bitmap_bytesize and nat_ver_bitmap_bytesize are used as memcpy
lengths into and out of sbi->ckpt, which is sized from cp_payload alone,
and nothing compares either length against that allocation.

sanity_check_ckpt() has checked these two fields since c77ec61ca0a4, which
added them after a crafted image overran build_sit_info(). That check ties
each length to a segment count; it never compares either against the
allocation, which is the half this adds.

Mounting over-reads in build_sit_info() and build_node_manager(), and the
first checkpoint writes the same lengths back through the same pointers,
so the over-read's contents reach the on-disk checkpoint. An unmount is
enough; the filesystem does not have to be used.

Bound both ends the way __bitmap_ptr() lays them out. The three branches
differ, so a single sum of the two lengths would still admit a small
overflow when cp_payload is non-zero.

Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
Cc: stable@kernel.org
Signed-off-by: Kaixuan Li <kaixuanli0131@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Replaced F2FS_BLKSIZE(sbi) with the constant F2FS_BLKSIZE in two expressions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1b6d28116a04c..89d1de05cb31c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3553,6 +3553,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
 	unsigned int sit_blk_cnt;
+	unsigned long long ckpt_size, sit_end, nat_end;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -3684,6 +3685,29 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
+	/*
+	 * Nothing above ties the bitmap lengths to sbi->ckpt, which is
+	 * (1 + cp_payload) blocks. Bound both ends the way __bitmap_ptr()
+	 * lays them out.
+	 */
+	ckpt_size = (unsigned long long)(cp_payload + 1) * F2FS_BLKSIZE;
+	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG)) {
+		nat_end = CP_MIN_CHKSUM_OFFSET + sizeof(__le32) + nat_bitmap_size;
+		sit_end = nat_end + sit_bitmap_size;
+	} else if (cp_payload > 0) {
+		nat_end = CP_MIN_CHKSUM_OFFSET + nat_bitmap_size;
+		sit_end = F2FS_BLKSIZE + sit_bitmap_size;
+	} else {
+		sit_end = CP_MIN_CHKSUM_OFFSET + sit_bitmap_size;
+		nat_end = sit_end + nat_bitmap_size;
+	}
+
+	if (sit_end > ckpt_size || nat_end > ckpt_size) {
+		f2fs_err(sbi, "Bitmaps do not fit the checkpoint pack: sit ends at %llu, nat at %llu, pack is %llu bytes",
+			 sit_end, nat_end, ckpt_size);
+		return 1;
+	}
+
 	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG) &&
 		le32_to_cpu(ckpt->checksum_offset) != CP_MIN_CHKSUM_OFFSET) {
 		f2fs_warn(sbi, "using deprecated layout of large_nat_bitmap, "
-- 
2.53.0

