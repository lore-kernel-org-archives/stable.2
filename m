Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047210;
	b=EN1lyfkjT4YUduX6tWg7nNbVAUuf4t/hfFK+FcSC5PYRa6zU8odiem5y+ptcoGy0n/I/
	 g0I3hsQYNXfJ/yBLiDUE0LhHNOr3IrBhYDGT8U9gm6qLUcAk4R0UzxUqXF10Dtq+Cto+C
	 uzipbwykLX9eTF/HSmGgsaD8Pj78PEVMbFNOMV4ZB7IjvSNGn8oLq7337COPygy/5OaMM
	 qJdr0p9pSXIaMNehGudcUgkNgb6v0pTMEy5WTXlZK5YQ6vlbbUvH94NS4nNZ/HMTLafV5
	 yjiwDv510OzzhxWZ2yulxTBCLEx3IY3FYYpKhxpySDhc+JdsN+PtRkSy52RxuwNR62g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047210;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RjV69YTJRF1AeHOHcoH9IlVaR4zNLbUBaG1hA9DydtE=;
	b=CrwGRMGsXNv1Ma9I2yoBqIJYmu0TkfKWD6IsvL5NHSUtNVRxsc1eBjCRCPTu0Ummvfyu
	 Z38pjE0Z2JtRjw8WWOs/3f9hbh06kMZCykYM25fdApXFcAAAAo3U4CALcf+rKWR1W5RgV
	 lp79uq+D7422i6YQ70sGa2AuXSIQsc0j7KJzM1/VHPMYJIGMnIE6CJKew+U+KOOHHfND3
	 KnBX88P5kSIbVYnkbSQBZG7cWxzKMn/NEKbCHxIUZfl7EaXqBe/Alvjt2lm2ynmr8A4Ca
	 g/vNUcpjZbr2GikEUn+Nl0lLF6nIfHbEUDdhC1kAI0G14/bKtJximssmVJdGoQ5eiBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bc+4h8bU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC5606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bc+4h8bU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448801F0089F;
	Sat,  7 Nov 2026 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047209;
	bh=RjV69YTJRF1AeHOHcoH9IlVaR4zNLbUBaG1hA9DydtE=;
	h=From:To:Cc:Subject:Date;
	b=bc+4h8bU+1Q/zabWw6Q/LBWarH1YmKazXdna0AB/VYEzMvNdhje7tqLCjMHdrzcIU
	 fAnbCQ5Z3r/PJRzQ0XATtcehJze0ydLzIEaM7UzpbSmsXJKlNS8Lw//H9HmhKfhg0+
	 AOoXsV+UjWz6ygYn4t6MUYti/RPZ9MWxyXLkq8+ARulnhpWtrlBvshEE+Ouvq9siGM
	 QIOBNy5GRHsMevTIlt5zefsxsP9/IW7CC4DiGgnmsONVyblPGtIDfKLP9TGm9rQGGO
	 RGXyMQ1kIYczDCEgQ9rz810LFqQKvWi9ERbJ39jJqSTGDXy8rp+0+Uow79OusTi4eq
	 wPsA/r6RxuvQA==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to update superblock crc in sanity_check_area_boundary()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:48 -0500
Message-ID: <20261107052648-failed-6.12-f8f956c7ec8c@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f8f956c7ec8c0285d7a80bed497d2f7adcbded15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052648-failed-6.12-f8f956c7ec8c@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




