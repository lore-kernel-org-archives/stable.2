Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345230;
	b=wigXI4YyzThAAingnZvaEFBCFwB0alJI/gN/2mFqHtbrfqKewO4tQKx8PselYwAHeOGL
	 pbjtoZBkJVEj15p05pG74aQ1LKamZ8y1n3U/vWFlKuJJq5sdjSGwEnjGawfiYtfD0tgO9
	 lH32IicWcYtsi0523tpqJQTeZ13PZpvPLSN1TlHXLYKk3zlouMvTMtACPEaOUzaZh8ycI
	 FlDHhODRxcbuZNbhsF/ieTIFxd/mMAMf1l5crSTmhqI4Y7cOIAAOXEcugDh1jnnmLI7VP
	 IpMLmiXhsXyxZ6EHHpi54PyFHKVwqckzY/dikA/ur06Jh1AnnMuMTngrOC7TAp0deZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=34mxTeZ9eMr8HUFuI5tyYPHaOJJYJMUYfEX+tnuiv1Q=;
	b=huzsJ4r9/PKuqZ6RLQY3TL9g12qOUY+xLT5EuMr1tuB90P2gkLgLH+5Z4quBjvXleI6d
	 hTRCxR/T6jGf4IXJmqzltm2GbMx1HhSateRH23qEQB++IOHnG4qXsuKg3Pr8bXNF/Pu/3
	 wP95qvWE/hj/0jj8q8tlbwWgd7V5lw9fop3QBf98CDa884Joyl7oSrV7vGsIu58i3v4x8
	 djJ/ObuF0zf+HvJaQd8GBU8gljeFQHxOouyr3fWb6h8iispat0aBB09LcwmPgpoE6Ex1A
	 rXQEF2RFPR8aF1JF5qFf/0dKyGOshdrBdA3qwE7Fx6Qu8zd6De1+5mXrHivjeSulxRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWIwdJyT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736AB606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWIwdJyT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E7C1F0089F;
	Tue, 10 Nov 2026 21:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345230;
	bh=34mxTeZ9eMr8HUFuI5tyYPHaOJJYJMUYfEX+tnuiv1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iWIwdJyThkuSG0TvZbG+v9TsBqGKGP+1wJmsiQfzaS4iGi1am9egoMOipD4lb3poi
	 wbb459K6X0WsZaBi6DRg4KpdQ/m22pyCrePpbD9cdGVEBeQrXEmFCYojlH7Fp+QZUu
	 o6Lbje7/PkCOpRsVkP91R8h/tKxQ4BnLSIbF9J7Kqjft6jtbiptUpHlG9a86GZ810X
	 Mu8LlF/FF8VtVCGftB+ZWDfX8AW6RwwBjTO0CVj9evgwtwHx0+L7QNZG1/Tp9PwUMu
	 HOuDoHo6mZBRiith7gmF7Gh2abR8zPnedCKIdEdIRG2i91aDUw5ASscKFl83xln6oS
	 xAYohXMoEWneA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kaixuan Li <kaixuanli0131@gmail.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] f2fs: bound the SIT/NAT bitmaps by the checkpoint pack
Date: Tue, 10 Nov 2026 16:13:48 -0500
Message-ID: <20261110211325.3872544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051158-failed-6.18-080833a32fd5@kernel.org>
References: <20261107051158-failed-6.18-080833a32fd5@kernel.org>
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
[ sashal: replaced the two F2FS_BLKSIZE(sbi) calls with the F2FS_BLKSIZE constant ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 69d36e1a301bf..93e6575706add 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4128,6 +4128,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
 	unsigned int sit_blk_cnt;
+	unsigned long long ckpt_size, sit_end, nat_end;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -4259,6 +4260,29 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
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

