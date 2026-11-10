Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347373;
	b=1fIeenGCOZySnfkyUhevsIddSnOvwgquv1U2WbM7S9xXRMISWqisDCzgXil9b8FyxNQt
	 Oa474h+GDH85CJQn7BEgGRYZvUSX72/evcPvmU+w9tcAvkamC5uJtwIIVxgnOelHNkxk0
	 P4R84iy1aaCVmXqV7kO9x+xTP7W2BJJxsMBH2yh0zcemtbX2JF9Qh21pdVQAlmWrSnEPU
	 feW8CSl4K2F+rkHRxbc4DT0IAgMmUdp1emOo/sTc2vNNtP6FPL4zSoRCnehprGS3jH/T9
	 rn1uRMG8OZeHjH5JAPdrAF1Zgd6e6qoyaOPegspIOkbZZO7qehyShErQxsp/FGKwcnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+DSRXW/S5aejnI712+BlOYSiXiuS9TouKAH2deXfxZA=;
	b=MiMxhFt2kFymaVZMZAdolnnUJT+onWQ12BigaQsZhGUTHyUUmHS4QN1Sqz73wq8bwxpv
	 FPIXdubDdRSkLUebsvU5KkADQ6y+nVXT/eGqha4jdc8FIfOn3kQIel2l3xWRMx5FUkkgn
	 l82g0nNvnfbgX//vlo+3exybP01tRlq7kEqXDXReiEo/AUoZu1knEBH3oQctZSOeLVNyQ
	 CYb5oPXMC8PZEoetQCuP3bQD20gH8il1Y5BSkd2gxXZLKDXwLgSdW4Jsm04qGYIRQXqHb
	 6X13DitgF1ps97KoKi+DfnJkTTHc9RmAamAIuQIwja8j8D+2B9IgqByJMe9W/0m1wqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IINyKt8e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IINyKt8e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2F31F0089F;
	Tue, 10 Nov 2026 21:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347372;
	bh=+DSRXW/S5aejnI712+BlOYSiXiuS9TouKAH2deXfxZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IINyKt8eEKABfAWHvKrcos6l+fQHvhKOZFh4j+1QULSlknmRPRRRlRVjwF5ahYfbL
	 160sESIixxEAW7ahRht5GhNSTkWNGpHVdNyJBzM2clJqbw6IuHzhL0xADNxKi4UNxY
	 wro6F9+Gv1qynljf46oxbvr6WF7NHtEZ6AxAwD+UG6WAftuZlX91QdIna8JTWNKpyU
	 yj3TJpq/oQTUXikwQPxjdcp8LTWKV/jBK7TWE7e3ndYfDdvLzhHMvBnp4kEtg2m0/X
	 wZ341AoZ4nRcF942k951Ik80OulaaGtCBup9aRDGO0sGKLh/m7639NyryZO2vCyogF
	 0RwRlWNoyFtHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaixuan Li <kaixuanli0131@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: bound the SIT/NAT bitmaps by the checkpoint pack
Date: Tue, 10 Nov 2026 16:49:30 -0500
Message-ID: <20261110214908.3967504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053549-failed-6.6-080833a32fd5@kernel.org>
References: <20261107053549-failed-6.6-080833a32fd5@kernel.org>
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
[ sashal: Replaced F2FS_BLKSIZE(sbi) with the constant macro F2FS_BLKSIZE in two expressions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 433506ea5738c..a7c35c1cf76cf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3649,6 +3649,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
 	unsigned int sit_blk_cnt;
+	unsigned long long ckpt_size, sit_end, nat_end;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -3780,6 +3781,29 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
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

