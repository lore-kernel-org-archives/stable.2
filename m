Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050964;
	b=hBvUJucMDUDDgxYRaIKjSxAzQ2R5SxW0KeJIlsuLAbtgHyqS3LQroe7aChoDqpGfMwg0
	 FrxAvumfgAM8+XUjS7prmQ2yj+JD7IKFqtavWpUftE9aFz8kD7buf3oCD3iXeoQeA4Qfo
	 O52q7GH6CZguNbI9OdtCmK8x4AMdr66vJvdbiiaNmE6vCLyCNv+91JmdMNm/GEau/vfl+
	 TLAA5ygt8dbOnnjPWzPg1nCOf4nhK29hqoFzrh4MBgXYEF1qEWDz536h0aXjWtO+rcmyw
	 ALbdkAJHZeokbCGxdco25X/TxStOl5SarGL91lpjeOypYBjBo3vOyoWF92hfp+Jqtuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050964;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cGXaVJD+e6H/wAFZPUKg25NQuzRHdL27iAIBXtfOsqQ=;
	b=vuMHAH4wz3LyLIzYwFQAf4rVvsi3eTczDiEQRXoQk32hbVmfeGH050WArTNslYJTT23f
	 Kz+amx5AaUMLf+ioATvKgtyme2GvOIgo5ZZmqzEqEjZVb2EoZtma/TdIAFB3s8L+dPxj8
	 fi1mWJotPbXW/p1WnAjEeffekUDiGtzy6Uz+pt7Yw8ZQY/7F3MeuFxF7ItPrQNFIIX6mw
	 TW/xx2sYUVtOqMtzIVFjJe9Z+/Y5vDpEHu1IMPntFlPSGP7ugqchexviKkir0BDk7wP+f
	 7bPO+LG0qhwyE8zbRLBZgONLUGSD+662wlatsQ8isPrS3zQWHOuiyvUhZ2S1vqs7RlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=furdT70A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEEB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=furdT70A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E10F1F0089F;
	Sat,  7 Nov 2026 11:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050963;
	bh=cGXaVJD+e6H/wAFZPUKg25NQuzRHdL27iAIBXtfOsqQ=;
	h=From:To:Cc:Subject:Date;
	b=furdT70Agt9et4yDRd5B6xytoresmqxX72QP/Y7iVsMw7Q73/47/dUZe310OE4Vtv
	 NGKP1JL/AkKVFc/C2Lz/eaqxKz+FyAB7VfV08r2kGUky1YbzRh2fIj4OSQKUfwRMZW
	 cI2zVSSqmpHlsk8AujIYvAsGDhqWnT+7EYb/gawQSEPD7syKG56FcKK2QEpPWbKTG+
	 n+wIPp9f5Q3LnhzL4e96ONeT8jSLVlkRdnNWoEj0qx3GdMLRfa7p95sbecyg8iT6Qh
	 iM3ASFztb1YJMmj8SSJgY7WnqIz/UevZ4MKQkubDyh9GUpfFZhCQrfmEUM5pUEja2v
	 wMlYo53SMXvwA==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to update superblock crc in sanity_check_area_boundary()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:22 -0500
Message-ID: <20261107062921-failed-5.10-f8f956c7ec8c@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f8f956c7ec8c0285d7a80bed497d2f7adcbded15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062921-failed-5.10-f8f956c7ec8c@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




