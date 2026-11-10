Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349956;
	b=u2FyDEeSdwUnVPeP3iJ+ZUX7LCD4iXIhh434N+DSVgSMThtVziWD4p89vQpW9UmFF9G8
	 cUlNu9D8jutfyQVNXsL1IRPyTl67YFyr/w/JwWKQfjcYmN/7mmKs9YAsi/e6iJmw9lfbT
	 JhFrG/piTu5Wv8etxJCPAl/IiwKrmh29KomrAlOBVX8szcDCdq39hgRRWCY7eqrjTOuEl
	 83J2NvPYmIPi7G3WG6b9bJOl7X+xSzg40+4R8yXuYskOAVZ36oAULef5snWfLX3SeeQUS
	 sBRf5prF0dMVMX9hKGU/kk9C/DWU7pRCkgp0xUzGxWJLzRVMZoh8yGhphEfxRSmraFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349956;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DN9YyLAHFEeZtkSI1xaRdnRxY+jclMNX6wFckRPNz1E=;
	b=VIkIBh/wLOUpM7A1YzKUe0VYQ31ck7TNl1dVLDMh77iN9Z4wnWhq3SQoxoKmJfCcZqaV
	 Yai0a07Tp37oV4LZMkWaDV2HMsn/GmSbtfNqpyLNa0E39SC4CIft9MJGqSPL94Oxe+Qpw
	 xfYB4LNS5CQ9v0mTCs/96al5crnEX3uL/eD/DgB/fP/iEpq+MVXDqAeT2CSqIOgp73C2o
	 sOCXmRUloqpi3+9umHkI5xoCAmFvhFSb8UWBr8sWSCnEVuYm672AIxMKRWo1qR7msuK6S
	 ZEXiTQ/jxD5lgR1TJsR6WzWXyZu3QyENPlw6dN51dJnUm79UIuIhv6ypUIyf6ukdreA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRmM+5e7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DBE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRmM+5e7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675021F008A2;
	Tue, 10 Nov 2026 22:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349956;
	bh=DN9YyLAHFEeZtkSI1xaRdnRxY+jclMNX6wFckRPNz1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HRmM+5e7iu0qc0R32W1RqS40fQX8WR29Az8iaKXYZts4s8zK5mvzBkytZ+iXK4Aol
	 thq3miogvlVQGitUHi3VUFs2XdV7RD+PlSHnUeiLsKr9Yt0SQeZnIssQd4Os42eIDy
	 Q+k3zF2YbIOPET/BoB4ib18csrgvfE5i38Wv7WzmqAuk5j1/IBQPVnjmG8OML1yHL+
	 6EFV/dUslcOSy/2czOFxMkCQuas3M0nOGT9KWLnsQT6S2c96PrCuOOD/UrDs8SpxrX
	 fNX1AgugkHerc1OcmKCq1iFMkvgvaAKZfBf74Wnta5tDXxkMZkGIWRfPqaxanYhXHG
	 nlPyFRZ0q5LBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaixuan Li <kaixuanli0131@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: bound the SIT/NAT bitmaps by the checkpoint pack
Date: Tue, 10 Nov 2026 17:32:34 -0500
Message-ID: <20261110223036.4040558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062405-failed-5.10-080833a32fd5@kernel.org>
References: <20261107062405-failed-5.10-080833a32fd5@kernel.org>
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
[ sashal: replaced both F2FS_BLKSIZE(sbi) uses with the existing F2FS_BLKSIZE constant ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ad0f29f579463..56ee5a097c864 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3030,6 +3030,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
 	unsigned int sit_blk_cnt;
+	unsigned long long ckpt_size, sit_end, nat_end;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -3148,6 +3149,29 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
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

