Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049641;
	b=fCXUes5GbP/Fef3SLilQt4a/ZVQdBVqCwlW9Amnr+eKk/4xomq4UnowIoqe33pIiObBS
	 4lqut7bd/dFCjjX7O9s55HJSKrCKRrCnTTpYLfxSWIvnmUssSa2UCNJGU0/d5zfXHlJz7
	 e5W7mCuKyt02NLuAvziA4qrNu7WI4fw54U2+tu1rRV60dVRSIkKCkEkvZ1O/Rs0Wz24ja
	 bZiq6topUXzqFmnSxYlU99M4qCIlN7QINCXHA0mtgo4Uu88v6RFtqY8Nz3NrVtMq0BlO8
	 eq5r8GyyCXtOduC/hZ7q3u6mdBmBlQRopwB52d3LNENMb3LAl9b1ArR52e0B5olo/CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R/FPPtEuSHeBQMJd36c/1cHz1x5TS9vJYxGz+eM8PZY=;
	b=hBUUZ+mFJR3+p+967DtXgSDQkWP4GDf8qwY99CbD9FLg7YMnDy559FsH1vbIKHt01zVB
	 CFbUH7NukzY426OvjEDqKEZT7iq1ElnNw1KqRYJQAUmIiYtbXg3jYJ3yg6JvCBh1iJ4ep
	 o5XQRxQAwvoucSFoj+gDRd760ZZHzXBqbTYW3H5Ro/f2T8MxvLLL+Jk8w9/fG3fyjnXxz
	 9f4JbKqkl8isuiuyFj4+LpK8nO+It8o9rgfHljdntt42AIUUwNl8fNgCviK62BZYkOb/M
	 ZuPsa3m3cMnzOL39Xghb5CvR/WdjNSPLU2fwfbo+qXdwrx4lNS4pJUYvgmfElRHr9FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJspqJK3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DE606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJspqJK3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59721F0089F;
	Sat,  7 Nov 2026 11:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049641;
	bh=R/FPPtEuSHeBQMJd36c/1cHz1x5TS9vJYxGz+eM8PZY=;
	h=From:To:Cc:Subject:Date;
	b=hJspqJK33DIIQ3nvvVtqz9TpmxxENghI2JFk0s4T+PKuCrvhieLZbC7bbF3eXvtSa
	 XrWVtH/qRkHZz1wVbDcqsPRxTtmURV4NY5v3jp1hh00zg1CEPVjeUeJOy2uNmajxQK
	 xw6ajw1ffAyQMCckq+H+OsF3JGAE8+UsKMeRdQhr+LOTq9v28SoAz+5c3zS8Hr+bHM
	 mzBwW5+Czvt53AELgkxrGT/KQKTppVdpFivanab75z59jgAWdw3O68gEybP1y7zYFl
	 VWUh1GB9QkaZPTXhE4okJ66ukPH76LTOqBFkFjHcW/MtkxjLZOONtOy+2rMVkZJqoZ
	 tiamNnlAlfqiA==
From: Sasha Levin <sashal@kernel.org>
To: kaixuanli0131@gmail.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: bound the SIT/NAT bitmaps by the checkpoint pack" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:19 -0500
Message-ID: <20261107060719-failed-5.15-080833a32fd5@kernel.org>
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
git cherry-pick -x 080833a32fd5dc10b3acf2fa9af9b3213e6cb617
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060719-failed-5.15-080833a32fd5@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




