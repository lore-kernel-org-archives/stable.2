Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343869;
	b=uEdgbVgQ0hc2sAqlQE0NB73S6iqCMnXQqj4hKkPCbTFe+EvA+XjKdH6qEkPGLs+RGWdw
	 AXJdia3bV0iyZYto2A+ERUV6C2mxBRWtJjsaAUi2gaRNdhlenAsHDaIy40unA+nppD0Fd
	 gG9n1kAIBv9IL8fA2jh4cyDKKFo7JshQFJMvdAQk4bXGRxpZzKKJJ36aauXoM5c0orULO
	 2u3UY/9G1mF8nkmIov2bIwPAZawed7s3pZH+lKhsqi+GqVbxyDi42XUO11S7q6So4FiW6
	 rT+0XIaR3ji3ujefHJYYwu9aQy+u38AY9ePlVHdlukmRxbKaNe3zfsGXuIhRv3vXIRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343869;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oU4LziLIzmnEyv8GrkVc/rvNe4v3mMFUkIg3zu2U570=;
	b=s8kF88JPrUYIGomERap01D1cb3wf+FTJ2H7RW+bDTh3fC64jDUAtEkWqnbrV83tWtQff
	 kb/aKgaVO5p2sxcnplzYOJziDnOTHBSf02iGtyDX0CRG28gKfh7dMpFGPSscPXn7aYZOg
	 R6gTKxVTVonn2D+8K+JWmso1WSynH44/+IPYsihVrfAywIygvvWVwKyoMrgnOL1G+tZnf
	 rO2+KpXdm6mNNfaAK+fEx5KzVDW167tWh2RH1+/44PYK5TuugG05H5cD4jM7wKNtzfkGy
	 tQByX3pUoqcHKgH6+hCJ7GgpCLzlA7WSX3WmzonjRR7eLJLcb+5XLAYbOufj5JkLgLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+Rt5fHd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DBA606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+Rt5fHd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9CE1F0093D;
	Tue, 10 Nov 2026 20:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343868;
	bh=oU4LziLIzmnEyv8GrkVc/rvNe4v3mMFUkIg3zu2U570=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g+Rt5fHdLrdv7A1wCtqW5XbVC/uYjO8osSrtpkDWozqBF0FlEvXpIowBwEKB39NcR
	 Q4NnY4YOYgaWFS2lMeGCpbgArs0h9Fg4Kp9kBrhMr47ppuWlcvJl26Vb9NeZR0AQuF
	 zGmQoTJeU99U2VasiEhc6pMjTV68Cbo+qCMrQ32t3vshav34LI97Lu+Qck022/EO2a
	 I8xQNsQvSkrHq/u9/hM8RV4ru0dwY13H5RaSuzpLFoDBu9JD9U7ZvOeQnBzHjjhiVz
	 B5M3ai5yql7vTQKYKj7VNuGhZUCJXn9fUxrTpZMQA2CSDZGCNxGePS1E3dZ9YQ8ih4
	 12mqmhY72VbnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaixuan Li <kaixuanli0131@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] f2fs: bound the SIT/NAT bitmaps by the checkpoint pack
Date: Tue, 10 Nov 2026 15:51:06 -0500
Message-ID: <20261110205048.3774693-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050500-failed-7.3-080833a32fd5@kernel.org>
References: <20261107050500-failed-7.3-080833a32fd5@kernel.org>
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
[ sashal: Replaced F2FS_BLKSIZE(sbi) calls with the F2FS_BLKSIZE constant. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b9adad85e18c3..b18ea09bcbe2c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4255,6 +4255,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
 	unsigned int sit_blk_cnt;
+	unsigned long long ckpt_size, sit_end, nat_end;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -4386,6 +4387,29 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
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

