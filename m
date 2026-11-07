Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050144;
	b=wKJguoow6iNLdt852olSuImhxUG6C9/T6IAS3RDDIxx07BLNeu1oDqb8BaZx8by+0jni
	 iccRpI0c3yaQoqpghC3WhEDre80Hd5g03x+LgyCyYTcy6HxtuMs7ukgeFUYSjudZGhakT
	 IxtMJE+UQX0Dicbanj3kc7NXnyZNkSUG3DTovr8Ql5/e70GT3Xb65at+vM4PiUufZVNcP
	 aT4EYDh5qS12FyUDg3scDxs2P9JjwBAhaevJIIpq4akP/UWIvbtXNAvZDTYcaNw6+p4z4
	 IhiWDtgn0uF64tClPV/61uoBNAvEV2ZlviSjZcAcuBpkVgvcsdJYQuKtyY7qnkpCXVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050144;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QaltLFSIjuFUO4hWXLrZBPnqgwlwGYavcBp+jEfprzc=;
	b=piS/qzWptnEIrUkuxMhLWSWgZ9Hf4EXPnvgAqj/tTG8R9LMa8OrdzuplNM2pAm81Gukw
	 akQzByft6/MhyY10Z1uj5HhSHz5cN6ANZNvEhePDDtzbP8Ob7F3WS3ZBbV9QxykpR8CBc
	 fJE5A0UhBvYk7uCR7kAEAOQrKKqfS+iY+I7pb4VA/4qa9haGu/OIAgzH2IOwG+vBxjkTg
	 YyOlzMJATDWJNKMpzh0/qfjGlcvwd9QnIS2jlY/+v6iQ9FQZgajZ7Guofmvs+MP8oQXQO
	 SjQUk6wsfhImFey01vpUeDayWtQutf7oelTOCKb+VWUAN6DXvMKyEGdDvOaUUwlUqbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAUDQXMS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAUDQXMS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C211F0089F;
	Sat,  7 Nov 2026 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050143;
	bh=QaltLFSIjuFUO4hWXLrZBPnqgwlwGYavcBp+jEfprzc=;
	h=From:To:Cc:Subject:Date;
	b=HAUDQXMSB0hqFeWhVCcPu7DX026tsM7itP0R4uRUSbRMcHx25lahcQaio2LrADf5s
	 PBWAL2uf88zXQT22uLJLJQHI9KanuUCkj0CKO3YomvU4wvVuQf9fNZupCkXb+aVtPh
	 XN4cCHGxEaIZRX344hhAcb1Nnyuvx70qofcRfu5xO3WQoTnfd0NY2PyqkzDp8z28oz
	 eG9or6kW1TfyIA5m0+1rFLBN6S3A59jHQ90Cea3Y9UhLmJPX3jNOBdfgVSvLVOiB3g
	 rJKT8hzw0ySR5WI7EjFCEqsT398jZnWNPwHXsvZy8vS+23hMzFcOqwMGouJJ9Szh8S
	 reDXfvSDm/pYw==
From: Sasha Levin <sashal@kernel.org>
To: jiucheng.xu@amlogic.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: force out-place update for all writes on compressed file" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:41 -0500
Message-ID: <20261107061541-failed-5.10-a64a3fec11e7@kernel.org>
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
git cherry-pick -x a64a3fec11e77a3a0dc0009bdc58b925e45a1bb4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061541-failed-5.10-a64a3fec11e7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a64a3fec11e77a3a0dc0009bdc58b925e45a1bb4 Mon Sep 17 00:00:00 2001
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
Date: Mon, 7 Sep 2026 19:35:42 +0800
Subject: [PATCH] f2fs: force out-place update for all writes on compressed
 file

For compressed file, compressed write may fail and fall back to raw
write.

-Thread A                                         - Thread B
  - f2fs_write_multi_pages                          - f2fs_down_write(&sbi->cp_rwsem);
   - f2fs_write_compressed_pages                    - ...
    - f2fs_trylock_op                               - ...
     - f2fs_down_read_trylock(&sbi->cp_rwsem);      - ...
   - f2fs_write_raw_pages                           - ...

Thread B acquires the lock first, which causes Thread A to fail lock
acquisition and fall back to raw-data write.
IPU_FORCE is enabled on small-capacity storage devices (< 16GB),
so f2fs_write_raw_pages() overwrites the original compressed data
in-place.

The in-memory node has been updated with raw-data addresses, while the
node metadata stored on eMMC still remains in compressed state.
If a power-cut occurs before the node is flushed to disk, on-disk
inconsistency arises: disk data is raw, yet metadata treats it as a
compressed cluster, leading to decompression failure.

To eliminate this risk completely, force out-place update for all
write operations on compressed file.

Cc: stable@kernel.org
Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bc53ac21efeee..22de00754678c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2914,10 +2914,12 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (f2fs_used_in_atomic_write(inode))
 		return true;
-	/* rewrite low ratio compress data w/ OPU mode to avoid fragmentation */
-	if (f2fs_compressed_file(inode) &&
-		F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER &&
-		is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
+	/*
+	 * rewrite low ratio compress data w/ OPU mode to avoid fragmentation.
+	 * If IO comes from compressed write path and fallback to raw write,
+	 * force out‑place to prevent metadata‑data inconsistency.
+	 */
+	if (f2fs_compressed_file(inode))
 		return true;
 
 	/* swap file is migrating in aligned write mode */
-- 
2.53.0




