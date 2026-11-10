Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349099;
	b=TgcNslSjNdfc6ZbaYPUETpVbTMB6+x24n4Qvf7vYyIthHc77slBBiatrExgbvLPlBVg/
	 K998wjM07OQdXLPta8LPo1a/K+BDvrTCNvEkepSZ2fGfUXoz7HEeLiAQF0xJDMbz4neAi
	 QBz97Rpr6p22OpDoDSgGOuBYpgUOzTKPFPmlpAewW+QZA7pqn+xW3jZrvNIZ2Vl6ELy+7
	 UFqziR3nhlJ/G2tNKkjhnK8JESaVaHhJ4G0JXXmMaSZYGlWFhz5TdLAfRH+AVw71blM6b
	 hlAfOeaIFIDUEhLIWIKGY5LnjmVx/oaGBPvv9k5E6hxcW3FZH4QOnk1Ft3FUdGu9HPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UflswuDIV9kvRG/UiWVh/vNwbFEZaMOExzWZZAzd+vE=;
	b=zcHUumniQ1ybQL+5zTBpF24t8Q8oHRA6TiZt2vVaH3cuqMdjy8F/iqotQcM4lu0t28m1
	 /t1RlNOeZ6tJr+BHQeJ2G6iqv/djLme69d9N0AFnHznEuHWZql2Kzn/IAEmXU3lQ95xcL
	 3cVRMf4XD5aTB7NdG4HxkDnt1JAunNVZWyszT106ZO7akadhdHBN+9hLRvPhmlcH4Kjle
	 FsQvN6ES7PR07ckJVZHtwrWKRLZlB4+MJiuQegeUi6GCSFsAb1N+lsNzrVHjG+elm9oWw
	 F+GYHwcugQY70S+7WXmPCpWckdDnyANXATcIknVMsCUsMDeVHhPjhBEf23QFnrytA/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZsDXwYz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9A8606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZsDXwYz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0CF1F008A2;
	Tue, 10 Nov 2026 22:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349098;
	bh=UflswuDIV9kvRG/UiWVh/vNwbFEZaMOExzWZZAzd+vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AZsDXwYzyoNsjWYnh4GwtHWxjAQNLjHZmUdTFYAvyiWllZCf3FoeJr5g9zt0z6W24
	 ZFdJyxmR0Oi1Zx/qIhlNs9yX7rYPoCnUUfPMs9QcavL/J+a8TnxPYZyED63vynMqsr
	 EMPft5VDsbjDCVMepiOpkZi/5ZEB9Jo5Y/IKa49VqjLUb1/LNJTUANAmcJQOh5agk4
	 Xyd1XHZ+7C60C2cgwJw1QWKeuMtRlcbXwvFh8WF+D4BEqg+pO774sxqejMO5y+iXxn
	 zNU+Nkne/9g2Fqa9j5QO/hWzWnDTaUaOI7kkv+AMTZ3tRyu7plDvcO4PFxrS2FuV3P
	 U3EQsJ5jGRAnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaixuan Li <kaixuanli0131@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: bound the SIT/NAT bitmaps by the checkpoint pack
Date: Tue, 10 Nov 2026 17:18:16 -0500
Message-ID: <20261110221655.4015786-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060719-failed-5.15-080833a32fd5@kernel.org>
References: <20261107060719-failed-5.15-080833a32fd5@kernel.org>
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
[ sashal: Replaced both F2FS_BLKSIZE(sbi) calls with the F2FS_BLKSIZE constant. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 405e17984adef..a2dcee4e675f9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3471,6 +3471,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
 	unsigned int sit_blk_cnt;
+	unsigned long long ckpt_size, sit_end, nat_end;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -3602,6 +3603,29 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
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

