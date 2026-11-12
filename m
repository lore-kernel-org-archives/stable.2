Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442124;
	b=Y1ntZbKxZCUAJiyr5cKhyNK5ejGURqA00NDXZirUit1ClDaktUrypQiZMFovadmBZY1U
	 tATUZuIuSHxIuf4FU8aAz8JuS3kKXz+Vd7u9EymXr1joTPNhMHNrIOJj28I31OCsQseny
	 HGDoYd9lsljYZiHrxnNTJ3XOaefmIq82ra8M4vC39JFP6nu4bCufdxv0BYvjGOzu3quth
	 G43mry5vA82No7fAi3FiMXyse7/2uSsTcI1Oe17N7Azn3/0Lxma7BevjEPmXzh72sb0yV
	 DzDLvZLwqH2aB1HuXxpwoe0U2/g1bEJa+Nik4Af87MybELMllNmKHthw/w6cbeDPkrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442124;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+cbxuFgZm4xD9oFWYc6zff48s57RBgg/r/m8hFI+fKU=;
	b=PEENL82DIvR/uDuonN/ZizOCn+G2n/oeFrUbOvXLRosVyxWf0FAlky9ro0IZiE6xe5Cg
	 oA8oDvL7J3y2A/vgpqP+EVSEA/fhAv2wQs95sa7q6qT6ZYsgh0q3JbGOOrhSawJCBGzKn
	 oIE0bPzw1W70YJQuwEIALqibYC5wN2S6Zm2OVoOCMGhHBeFbFdi47s4MYhDKPQQi1a+fs
	 D+fV1hpZ5wITZ4Ygd/e5jdXp5ozLMp5PGzGg9hYfn/mqy9SZPzbxfTPYrnjLiflUWzyEr
	 CixIvidFEf6BJwX8BFahMpqo4D73b3P/WZwouoOCZxZcbtGU8LAnekBMQAmXEvnrslA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iD/isOp2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D43606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iD/isOp2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A11C1F00A05;
	Thu, 12 Nov 2026 00:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442124;
	bh=+cbxuFgZm4xD9oFWYc6zff48s57RBgg/r/m8hFI+fKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iD/isOp2EE8AkqGttw/Xgd6MczmAycfQbIlTGk5vARwVDhaCEiO9rdn6kb7RHnlao
	 g4N0b8Ln97sMebUiFlKeWm/T7HGP/HXVumrNgL/wmZQqTgoEDiOULYHMUWp7uQcaUE
	 6n1FjEsn2lMg8fadBJtvpFro+X5im2Cc+elbg2EuBPUWjxjVcgsWY2KuAAgNAJpcww
	 B9vKfWwsJJOcXFzKezF181VJsNZn3dkEvvfZGr8UMy1XIsiNY7hJU0OChl5CitlV2j
	 5TnYq5AQdjtRHp1fRb6K3/Z+UPxl7nN11CHmNGsFU0hWEkTM4GuFaIEeOeFk/xKI6W
	 XSbC4E3n8YIPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: fix to update superblock crc in sanity_check_area_boundary()
Date: Wed, 11 Nov 2026 19:08:42 -0500
Message-ID: <20261112000825.963891-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062921-failed-5.10-f8f956c7ec8c@kernel.org>
References: <20261107062921-failed-5.10-f8f956c7ec8c@kernel.org>
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
[ sashal: Added sbi as the first argument to f2fs_crc32() to match the older API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ad0f29f579463..758270da70957 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2820,6 +2820,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
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

