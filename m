Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440897;
	b=11uJO3yKrD3EmXCZvIum8dIxLkCeX8c8YC/DLmJq1QZdErg/PecwlsKor0FjTg16/xyX
	 X+chwLPtF8rF6EW6UIbj2lMewdrqRum/9k5BvC7VGVIkeVCUvBU3hEc483P5yr24BsfCx
	 WKvXjX+86t9NX3joiSZzFwtJwBT+hsKr11OYzZ2+LXixWLaCx8z2eSl6K1RvVZ6VRNC4Q
	 V6tFsAjZz2Ix4sNbMUo8MdrNyK78ydDA+xmNawBLpQbuqDoCfdw4djfvaPtRGqZ2G67DQ
	 K9da6Uw/y92LjoEXLnQoIk1xzbAGe06IsZUJ3iYBUNbO0rC91NINx5XqmBUkkVZE5yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440897;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gnYbXk/ckj29oTITYzaLGsprlkz4S1KPyKVEaO01Jec=;
	b=0k7VPCAdFQU7vQBBDTRLESpQNs5b8GXLI2TtCextHRiLAiZKAWVMa3CUSQU8UjMPp3i5
	 FJaYnDPlRKqPgJ0L+yi/V9s3fquX/0UOxLk5D3Rc+EJE5MmdwoSzhi47jVvecVOJ4cHnh
	 6M+Xu8afbJpoobg48WEyU1tnjw2kYMgRcZxNASlCBKzVNXLxhsuLUSDyvpic3jdwkVJb+
	 k1GBv5jnc+c+WkDyABNucxe3gA8amsM9n8OkaFHUivfSKismXudsXFKjWi/G67aNgspuI
	 fNq4CojtOZyt4zDllol0vAY6jHPPHw+B9JiuYtodsAv2ata0gIiplH2zUQOgVA5wMaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kT2wKkh5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3936606A331
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kT2wKkh5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C181F00A05;
	Wed, 11 Nov 2026 23:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440897;
	bh=gnYbXk/ckj29oTITYzaLGsprlkz4S1KPyKVEaO01Jec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kT2wKkh5q43BG8l/PoaclPWzPh1BctFBkmTi1hRXEQ/u1MFT/ye4DYz3AboP98LXS
	 MVhMUJzdaM0hogTWRRejtJbmASFYHgg9CxYt7x3Q8TMKwDZci859XHQN8anUEZx6Ch
	 zIF3eL2A1u/8yQHnMJNJdcMnhNvLFybPoAMSaBtNxwz4+dSrho/UwQuoCFr5Ut/x2f
	 Vi8llrKFrN5h9lqc1yPCyzKwcZQps+LYLzFdVElNw0wRRLzu9dVl3KGWsRchGsAzb/
	 BEEkbrmCUcQXXleg9KMbiIUCgv74EOvrhPHVADdtQwP3qJ0/sWQ1n7fqe+Wxl4p4z/
	 Id7PRmJvAr7jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: fix to update superblock crc in sanity_check_area_boundary()
Date: Wed, 11 Nov 2026 18:48:15 -0500
Message-ID: <20261111234756.706194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052648-failed-6.12-f8f956c7ec8c@kernel.org>
References: <20261107052648-failed-6.12-f8f956c7ec8c@kernel.org>
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
[ sashal: Added sbi as the first argument to f2fs_crc32() to match the older checksum API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 31724ab224d4a..73c88a4257565 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3571,6 +3571,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
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

