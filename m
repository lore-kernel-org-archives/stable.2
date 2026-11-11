Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441469;
	b=GMBd5URHdyVZeVPMpa6qxUmYaRFJSnowZQgGDQF9Wyx6QU6Z37lFbPOtswot/g5Fh0Xf
	 q73f4Kfl7l+UnQ00PFQsmn/FOoBYwGX/r7F+ZLyVwF4ZIHwDJOmBa5O0xvLvlV6Jb3V5I
	 WNefcondJXizAL00lStX7sR2WIylAlB8YB9PYcrfAqIpDNaRsJiA1cioe853ShwVv55Km
	 7qWVdfJzRt8FhqJva8vAOe/HqmjscAJ6N2QSX10pthDOQC8SqoYo4tLjhgmaezhwwzAed
	 La7fPz2rEsyvdINeeoyhuMumXXtNyiuImtRoI9UJK3B+5AbRDMJua4V/9EEEZhCw9oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441469;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mi/t+24rNYbfiUYmScBZ+SxZsToBffZ68oe2niA5rbg=;
	b=0hPrkk6kHVNvSLCxtuvWDIeJtQ1sYgl1rwxsNM7sNkOIgoWEBucQFb1GYKFbm3kzarNX
	 pqKZJ6hKa8pusFts/ep+ud51gnG/IoUU+fJy+RZm1yxwFfC/ZJPBcemsjF3QORmsEP6hE
	 1eUsMXyHjYo/eL30Z1H+jIBnjdhtQ94duQNZhGhBVoME9+lQcxgO4PBFmU9AatWPP+GRT
	 R2f9B/xnaYpM/IrXBmrEGHpIOp2xDg9bG5ofcSL0XBH99iuj1Jro2DkfHmsSfVUBLSOfc
	 QdnqOqyQEa7yC78gH42529P/yvFsnF12M/c3FV8h29GeZZGWBEmU+VGjX9wgh6EOQ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNbCpkXO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F063606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNbCpkXO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941F81F00A05;
	Wed, 11 Nov 2026 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441469;
	bh=mi/t+24rNYbfiUYmScBZ+SxZsToBffZ68oe2niA5rbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oNbCpkXON8vlwmjITduBVFrOYyteWlVW4jPDJBnMH/gnKmfN0RIzUIJQ0sAd9l4Bm
	 4wvNDnb5gqM7ULfKsCK7VwcarVcIZ3/3cD68x+IyEBeUsS3WKf0fTHI0mmZJApCVxX
	 cNgvHBQG/h82Hvertmorm0ERadoC+2jli+zIB+ITIyL+ElheHpQHdN8tJVEjCRfrlp
	 ZCk6DLlKHcg5vHyi+XRREnrg6GKQu5PZ0ri6LYb6cENFY8+0qFmwDG0QNeMF9zWaFO
	 FAOsrFjSQ0JVWKFd6179bptklMKQbAFL1ak4xF/JY5JtXB9MaMLA0Zz6XMzdj0sOIj
	 RQQGcYpTuuk5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix to update superblock crc in sanity_check_area_boundary()
Date: Wed, 11 Nov 2026 18:57:47 -0500
Message-ID: <20261111235728.878463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061219-failed-5.15-f8f956c7ec8c@kernel.org>
References: <20261107061219-failed-5.15-f8f956c7ec8c@kernel.org>
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
[ sashal: Added sbi as the first argument to f2fs_crc32() to match the three-argument API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 405e17984adef..7ee17b5521742 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3268,6 +3268,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		/* fix in-memory information all the time */
 		raw_super->segment_count = cpu_to_le32((main_end_blkaddr -
 				segment0_blkaddr) >> log_blocks_per_seg);
+		if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
+			__u32 crc = f2fs_crc32(sbi, raw_super,
+					offsetof(struct f2fs_super_block, crc));
+
+			raw_super->crc = cpu_to_le32(crc);
+		}
 
 		if (f2fs_readonly(sb) || bdev_read_only(sb->s_bdev)) {
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
-- 
2.53.0

