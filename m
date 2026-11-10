Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346643;
	b=5RrPLgWVvB3bMKm/dFZ0Uoj46oY5p8r9+31UZPsafgZafIsCZKM475Jpq/kmNvedqv2p
	 5b3nzP12aMOFevmz+7LPVs8nY1ESEcHd5eUOot/7wCJaqGz321ZZ8EqSXntK9eN1sAK6a
	 nsS7ANo7mBT9SKfuXOlTZh5D9BhXbsAlvGjYGVtqnbumvWA6Mgl67RQWpHJYlNcFewWQe
	 vGTofF4fG/OHpLkk/1/8N6Cz3r0dUk42vy4iYeI0BkBRPjlAMxXPBCq0rZ2MJvvtGtmeX
	 wlZ07hnjejubedgycvac/DkQqoTDvel6hrEQ76XoirWYLUMH9v4YppnsBIxHjNyqIuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346643;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JeAlVsVNVXxg5LJ1Nt9/PQy/ettNVIB2Xs3BGyBTOPw=;
	b=TiELrHYY321T69gDtHHZQv+brcOsmP08dhuIoPOxodOYr3+EnmEBjuqUkdfxP6HGtFcJ
	 gBNMslcLKfJkSNM4AxU6i6VgNnX/Tkvhsb2NEAcuQsxMcjnA6xkTXmSv0LdyfIDnsBbbX
	 5sWjWaY7MzH2W35RFi08O7xFZk6dD9ebZVpsNiaXe1EuyedlP2EfnV6ArH+ihj7pVizZK
	 7Lo0hlJiDME4/Qs7ZFHqgAOsaGxj9KvDyFSjVA29cPhGBuL3RHz09x0SM2/mg3I520k0r
	 w0LB+l4agM6LfJ4IsudUuf8+QmZl5aq9xOftfWWhhyYWA8WT/dI+1vflNxbGzjXvURQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyOVwxGl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027C606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyOVwxGl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29F11F008A1;
	Tue, 10 Nov 2026 21:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346642;
	bh=JeAlVsVNVXxg5LJ1Nt9/PQy/ettNVIB2Xs3BGyBTOPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UyOVwxGlZAy7rJCCyVKzB67uqZJSK56IZXH7QmtQyNtpBntG8dwZBimKh5n8ABJjn
	 WzIoAm1T6yMvSVGT0l5SoAHAAKQhwFdDD0R1NJUjXAHIzt5bfJOEi8x6FBkJT46ec0
	 u7X3/QaU32MBu0mlc0WXdfsAZsi1tHI5y8jpuvMeIS/UBNPo4uJRz35A3g18rUEWt5
	 kotdmOlOMXBEnfCOgTM8QURq1CMG5YKkOmc5bV7vDSIaGGRTVShu7d45lwmB/TaDTG
	 J83dPzvLiQNkS5rtK/NCNHWn5UjWKiAWrzKvfDOpKKIH1aNiPePJUX8+CUUsE2t3Qe
	 +EM9Yg3v6FBUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaixuan Li <kaixuanli0131@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: bound the SIT/NAT bitmaps by the checkpoint pack
Date: Tue, 10 Nov 2026 16:37:19 -0500
Message-ID: <20261110213551.3918808-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052312-failed-6.12-080833a32fd5@kernel.org>
References: <20261107052312-failed-6.12-080833a32fd5@kernel.org>
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
[ sashal: Replaced both F2FS_BLKSIZE(sbi) uses with the F2FS_BLKSIZE constant. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 31724ab224d4a..ec3e20cd6c5eb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3773,6 +3773,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
 	unsigned int sit_blk_cnt;
+	unsigned long long ckpt_size, sit_end, nat_end;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -3904,6 +3905,29 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
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

