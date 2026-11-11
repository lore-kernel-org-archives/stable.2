Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441330;
	b=KqNfj4Or4bZoS+QOQGvBo1DAHhNzqCDk1qNA7yFDVVEEWDuhD8CMsd4nzna3yJl/VpRQ
	 xGXAWyFhP8zFhKlrtMRL0q01TOxgemOmrPhOdxZRB+8ER10vqqZxJHADAVjFszzPKPcDO
	 y9a5/d1EUbT6JTlWrqniDF5t0fdI93+aN54HvPSJEjqjrDb9hbwRkiVOu7pWjKz5fhydY
	 VMrxebagda5PG2DEKnjDt+PBUN23rdDlEjDCY9rKg6YBa2k7M8JQzib3qy8h8UMdPEg6Y
	 D0VYVmbM90i1JibOL0OLLglqL8qPuPV5Wi6vdZ2HoiFYgihBAI14N7VHZ+drm5JMkbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441330;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SdoDPna6FTq83mtuEKLTu47a92u5aDebx/DnrCWjpYg=;
	b=0v6T2MBKtiYTG7xAiA5QvUUeU42HS+NBx91TVefQm3xh6WaChNr99k+UQAcBfK6QdLih
	 faINaHMcXLZrXXpedekJFLbTTZVC+SHF1MX1kI29aslhwFBKV69eaJE6R3fxcEMwY7pQY
	 Hsj+LvLafks7wzVahC/ke9ElKXsfSVSSvKSWza6huX1ayd9Ud2w+H3TwoAMoRcNskA+0F
	 vCFyK5R7f83X47y8riRM1kQUG2blGK72Qfv/djRQAwmWs3TQv5NOIJ3aOMm5/3HArSDYd
	 igKDBT3pfrgNVjrUlsQtoU0VR/BQeTIY2Py1DsJdaL3R1aorJOQM5fYAsNKwK7wWoRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UADZw6za;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F1606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UADZw6za
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F7A1F00A05;
	Wed, 11 Nov 2026 23:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441330;
	bh=SdoDPna6FTq83mtuEKLTu47a92u5aDebx/DnrCWjpYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UADZw6zaw9mcJVHt3GjSpCfj/Z0wv1Dn+SyqjrkwpZrogrN+06qV05KaMoxKkDBaD
	 GhnAi+8TYlzP5V/D49eBit/s1+x29xO/9SVvfj8Jl6fLcPQlMg6Na3hnzsm0IR4Ah8
	 vG5Z4jXNHQcX+xb5ybZo8fkH1TBZRvr7SqTt09usPhmByA8qQnpbdo3yRFDmIMa83i
	 V8s0+pk88DVTGWyaonPnClQaSwh7tAWC7N+S8JAWLmk6rGgU3n/A9dcpvLF35oPZx8
	 eGAEqua/+ivfenkwmKtik0srVlFnxLxgKPNPe0rWKzekCNb3WNN6HArSHxw/j3bWse
	 4b6pau2hC/nug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix to update superblock crc in sanity_check_area_boundary()
Date: Wed, 11 Nov 2026 18:55:28 -0500
Message-ID: <20261111235508.812531-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055522-failed-6.1-f8f956c7ec8c@kernel.org>
References: <20261107055522-failed-6.1-f8f956c7ec8c@kernel.org>
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
[ sashal: Added the required sbi argument to f2fs_crc32(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1b6d28116a04c..e27c3c76e86bf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3350,6 +3350,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
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

