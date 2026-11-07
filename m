Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049942;
	b=XOlLZ9lgtucC9JSAJy8ZP/7x9WgYypttbiSbMKiaTdC6Je6dO7grKdO7FvTjRSFQGnzO
	 RQwUF3fPOJCesqXDlsp8KUdzvlo05ELXC9oNBoo97rOSATBg1pbTLshidrmaWY45dTHKE
	 CsxLudzlZYCiq3YPKIwTHlrWv+XmeyMZ53hMy9Sbtv7Bf1liVAMGKFKYxCudcHAD4idNR
	 ZFRF+O7SYY0GPR3ufxAUdCnp5gaUx5UuWQp54/FjJnL/vP/Hvmb7TTbl18inLpJPH3Rqn
	 nt4K1JcuozEdvPRR93nWoWtCpUJX4XKCFPfe3FCdBgQIrXlzi+qRcMpbCdGOytPlO2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049942;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EPkNq3WHpunvU6lHoLuXhmUNU1ze4t//1Be+gKW4Nso=;
	b=SF8uanTGjKSgRTkyBESfxEJchn8GMWvLDepH0UKHzCleIFFkyXbOhhnIMLcFCjvD4jun
	 +GF4F5M7iCtxfWi2GlqT7QfD+kg00eohthHQ8RjoobKgdaPdpQSQND1SrkDzEQYUqtsFQ
	 RC+zURL93SpZBDfu515DPC83EJ0fOG0R6qupGyoO+NoXxPDiNyhmxDTqQHOTtKGRq5Y9Y
	 eMRffnQ3ks9Anh/585hh/l8ag/PA2VxVnTL1EvNH7e7WkI96qjsFE7v3JKCXPv6LQ3Xt4
	 kZEzQxT03P3+WxxjXqSVDl/2pGdQoyXGrblTQUuxyGpbazosu8yCP2AVHxloc9PQ2mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpqVoPBZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpqVoPBZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC531F0089F;
	Sat,  7 Nov 2026 11:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049941;
	bh=EPkNq3WHpunvU6lHoLuXhmUNU1ze4t//1Be+gKW4Nso=;
	h=From:To:Cc:Subject:Date;
	b=YpqVoPBZMrHOjFtpJXBAiP9Ro7Ybljq/ZoddcuIir42G4bhZIPolLgAG2pzUstR0R
	 E4NkYd0Nc67r8GrgGyNHtcmKgWrVl98UT3HJpp/cr7gRRqpMPuks0yr3ksiDAhWAfI
	 Ved7pD7+fdtQPepkHqYI8mwwLRf1uZl41xkjr6mEWIBqWek2djxxbooziaZq7dl8Wx
	 cCbDe0cb0w0jjakTjgZenjEozNsjbMkf+D49ocuVGDtExrDUBnat0ujpYe9RUZEN4E
	 rVgbajQUIpCOlUtVM/VCrpE3KxciXxY4Hq7O+s2GLeBDx8A2Auuhr4tLLJ6qGJwFa9
	 t/N0ufa3EayUA==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to update superblock crc in sanity_check_area_boundary()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:12:20 -0500
Message-ID: <20261107061219-failed-5.15-f8f956c7ec8c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f8f956c7ec8c0285d7a80bed497d2f7adcbded15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061219-failed-5.15-f8f956c7ec8c@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f8f956c7ec8c0285d7a80bed497d2f7adcbded15 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 08:23:50 +0800
Subject: [PATCH] f2fs: fix to update superblock crc in
 sanity_check_area_boundary()

This patch fixes the bug reported by Sashiko:

We should update superblock crc along w/ raw_super->segment_count in
sanity_check_area_boundary() if sb_checksum feature is enabled.

Cc: stable@kernel.org
Fixes: d440c52d3151 ("f2fs: support superblock checksum")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 857cc2b299464..1071059f2cc22 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4084,6 +4084,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		/* fix in-memory information all the time */
 		raw_super->segment_count = cpu_to_le32((main_end_blkaddr -
 				segment0_blkaddr) >> log_blocks_per_seg);
+		if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
+			__u32 crc = f2fs_crc32(raw_super,
+					offsetof(struct f2fs_super_block, crc));
+
+			raw_super->crc = cpu_to_le32(crc);
+		}
 
 		if (f2fs_readonly(sb) || f2fs_hw_is_readonly(sbi)) {
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
-- 
2.53.0




