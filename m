Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440585;
	b=m8fbC3uFgbLaGfrWvOGym2LslhyK3rExzceWV/ld86NV9WoyEPEBVNU2HQTpuUawk7Ys
	 gbpeXZJnKcp8VFCwEeK5L4NW1qjGhkT5YC6zm1XaC4c1r+ovXC0W70Zeatb4BHoz6pN7d
	 c7/0IjruWqCBzXOoCtg8Bk1atGSkmH040EioVyCSo6cMPv5899O/DHQ3MQLfJJrkcQtUn
	 si2a+1k/ukxpzo+vS2WnkWiAD7oWW9L2Rs7qAIFDnZdksY1IbCqeTx5b34LYIAYgoS6Sa
	 0sK/qi3cclIgE7L6zqvC1FJsD9KlU/pBzlHlzZzNcPjy+Qyv2EqPR4ZRV+e2ZAeHDtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440585;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/gK0LHaY+LJ7TYnufCDWO+pLa21WTcfAsVRDy/cmeUk=;
	b=U1t8NOctfnwX+ELIkupjFqvJ4dpJVo99cnO5NnAmODT3ND3Z5oIJ9d1rtZDe8mrwaOhm
	 6BOkUeZp5k9T2L9QHjkuhMcklK6zuZP/6YSCHYEhyKIFiW/T012hPo1NJmsdwt97eG8df
	 V8Wi2WFoeyjdR3rTjIqIlAQYRJRFZsAx/OLk5ErPMLO2pjTOBLgzVBDS3GpxcNNyyDpSV
	 DLuId2DPxwJBK8X4H2nOjcXXx9Soz3Wtn50sTwO4IYEqBhXMtTXyG/S3pPw3j050Ts3qc
	 Tp2VqiCTcSbTlKXJbMJRjBBr4fj0UfLTslt4Yhui5fxG8Xccz8jfazidW4u5IJk2qYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jebIP+Sh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A951606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jebIP+Sh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD541F00A05;
	Wed, 11 Nov 2026 23:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440585;
	bh=/gK0LHaY+LJ7TYnufCDWO+pLa21WTcfAsVRDy/cmeUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jebIP+Sh89sCZAZP4h0y/BaBoah7mAkqkvdTJ8VsbErPqWXUAfA43mqIRIWRCPZTp
	 0d/FsATjTcSlOClLuuKw8+KUdVurtNt8ztd3soQHazfL30Yxmh83qh/weX39kvQRFU
	 6pT7DnlA1q7wqbCVLetgtMk35Tf/Mj8NuwMVQkb3cEvwpQ0VC0VNcbOYXBAV/5c8dt
	 yZBVGOqULeR5m3Ruel0ahIbrwlfnl31xpqKvUncuO1WEyXP5Cc6VWWzKfONFvmHIZc
	 YUPKxm/jaBTCVrG4Z80cztxoGPmAbad/hTVAqC0Vg0aH9tVSq1g/GH7V53PkGE105i
	 Nef9CY9D2G3ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: fix to update superblock crc in sanity_check_area_boundary()
Date: Wed, 11 Nov 2026 18:43:03 -0500
Message-ID: <20261111234232.707558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053935-failed-6.6-f8f956c7ec8c@kernel.org>
References: <20261107053935-failed-6.6-f8f956c7ec8c@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit f8f956c7ec8c0285d7a80bed497d2f7adcbded15 ]

This patch fixes the bug reported by Sashiko:

We should update superblock crc along w/ raw_super->segment_count in
sanity_check_area_boundary() if sb_checksum feature is enabled.

Cc: stable@kernel.org
Fixes: d440c52d3151 ("f2fs: support superblock checksum")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Added the sbi argument to f2fs_crc32() to match the older checksum API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 433506ea5738c..84ed0da813838 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3446,6 +3446,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		/* fix in-memory information all the time */
 		raw_super->segment_count = cpu_to_le32((main_end_blkaddr -
 				segment0_blkaddr) >> log_blocks_per_seg);
+		if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
+			__u32 crc = f2fs_crc32(sbi, raw_super,
+					offsetof(struct f2fs_super_block, crc));
+
+			raw_super->crc = cpu_to_le32(crc);
+		}
 
 		if (f2fs_readonly(sb) || f2fs_hw_is_readonly(sbi)) {
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
-- 
2.53.0

