Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046320;
	b=eBdxGWGzIpBQgvXdG1xioulO13XBMkkBFqrJ35KJPytUahJGmqvgkLUzOwMC2eN3ghOH
	 tdBiDya1NZMUWOpQDknaZ60xJYzPx9Vkdgge7Ur/QDhjcjjTcBDYXx1Kw8dZc7YD889pf
	 o5cWJZA8YDXlnwZcpDRdJ2tAmOyF8muu91FU8uxbWe+HjqU/5C8CYnVO7WhuCpiPN/8AH
	 6L6+zo4CRWsM/TN+m1EN9dNqFw7DgjpyPhZXdeIK4iHkd9PvrcW9es1TCg3jXNsSgiJ2m
	 9MuTzoBtKQf1hlnSV83iZEc6EGs+peGhIHlnHu01VmduOhtC7keMFhH3RUvkVrqtHaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R6emEKRREYsmsoWRL1YzEYBgGaC0EmU4XL550n3naY8=;
	b=IxaTBB6sUNX/sm0BOmFloK8Vl1k88swLerm72DccdC4wbEfDLnRL7S97SXOj5JVIXxPG
	 bN98vYlNCIwuAZO8vz1i+luKz2HlJhRKdtEFOfghSJeUEHiVS/JAbtbOHLDkE9Ui18H5/
	 NoM7ht7lJDqJ2rKuPE0AnA5mzFT6jRXOJlUPAWAmx/UGb4tF8/PpFU8k66NDzf5qvnAlN
	 16tmJyJDxydIfExli89CB3XwYCrCbk2awgvxL5eZA0wXAqg5EuHf1Nh3OprIM/SsyFp+v
	 9I+Hq5YJCwN2UuUY5qQuDTlTOlbKb/ykrd5NaLOEGTzhgrIRd8PaosUGbvQmjqYXdkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYt1+bWC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E30606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYt1+bWC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B951F008A1;
	Sat,  7 Nov 2026 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046320;
	bh=R6emEKRREYsmsoWRL1YzEYBgGaC0EmU4XL550n3naY8=;
	h=From:To:Cc:Subject:Date;
	b=UYt1+bWCYUKOr2s0VWnoXMjHE895AdJtifrqD4jy7aLDLyRVmOMFnAdHjfKoNILqC
	 4RfylZ8oSPMR8pJxQots0K0xCOOBsN7OqJ6i9cL2OAR/BSOcOFqRAqilmOKdRwMTPH
	 n2UOT2xg/3RYDCQtBUdr/ZB3oBWP7iShJm86kRGm+wQ9L1JjO+PXFTOFtKJUx7f5cJ
	 0qySyh0NLAnG5nuFx/aDiF7bXzwWu1R6907ddDuopdVeNohULIYJUkQ2HG/fRkNhfG
	 oldVSbZKH6j7jMRU2eZGj5EWspzEQTyIk7QzAgQYheJdVQfcfLVcKg1PgSQPFjyGR5
	 WUHPezDBSPUGA==
From: Sasha Levin <sashal@kernel.org>
To: kaixuanli0131@gmail.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: bound the SIT/NAT bitmaps by the checkpoint pack" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:58 -0500
Message-ID: <20261107051158-failed-6.18-080833a32fd5@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 080833a32fd5dc10b3acf2fa9af9b3213e6cb617
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051158-failed-6.18-080833a32fd5@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 080833a32fd5dc10b3acf2fa9af9b3213e6cb617 Mon Sep 17 00:00:00 2001
From: Kaixuan Li <kaixuanli0131@gmail.com>
Date: Sat, 19 Sep 2026 21:09:24 +0800
Subject: [PATCH] f2fs: bound the SIT/NAT bitmaps by the checkpoint pack

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
---
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 54431da34edf9..3a191fda7030f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4278,6 +4278,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
 	unsigned int sit_blk_cnt;
+	unsigned long long ckpt_size, sit_end, nat_end;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -4409,6 +4410,29 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
+	/*
+	 * Nothing above ties the bitmap lengths to sbi->ckpt, which is
+	 * (1 + cp_payload) blocks. Bound both ends the way __bitmap_ptr()
+	 * lays them out.
+	 */
+	ckpt_size = (unsigned long long)(cp_payload + 1) * F2FS_BLKSIZE(sbi);
+	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG)) {
+		nat_end = CP_MIN_CHKSUM_OFFSET + sizeof(__le32) + nat_bitmap_size;
+		sit_end = nat_end + sit_bitmap_size;
+	} else if (cp_payload > 0) {
+		nat_end = CP_MIN_CHKSUM_OFFSET + nat_bitmap_size;
+		sit_end = F2FS_BLKSIZE(sbi) + sit_bitmap_size;
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




