Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049130;
	b=s/kSrdyJPYjBqD/tBfgqAFptX/ToGr5sx+PXtMkE2DpIloHuCQthyI4bYlKV7vvu4stS
	 H+EDpc846kUluGpK8CysOg4e7vXoEoR7Ff3nb6tOPUxrjJ4UvTkXwOzQtBDzvobWTGO4Y
	 3G5Nebniji21nJys8nL5C4tb3U/yP7JhwLAt6yS0zRLTp5/cZ+KK6bhzzBKEAxX3Z7MnN
	 /0SwdyIKSGitKsfRzmrB7rOFcq7IxPriFJebKoTPd2+cx7sOJ84RW8KkYLzsfb7a3zV6F
	 pJMKu6JtwXXsTmuM/6FpMMqUkRDwNhnZ8J8xMS2TcMqPuUTLQMVyEE8M1l6jO7dF1aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049130;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cDLEq0LkR6GUN4b0BDsHyZNX810By/KpEGmhQeCWKO4=;
	b=p/5MyMaG9L9g/9qZrHOFppSFoW0ZQ20a8jV/7Hw3CIKAUJR5bpTaTH7wwN5ExeJFk1FF
	 fP1SsJ6b8RqX7TJk0MWf/bZDGQdzRR+Lo5W9piHVX/WMuVUrggyWbfUiHcSLwJbQqmzXb
	 8eYXq/JoeKZmUa1LofVqOrKIBcemS07Dd0R6hjWYnOfcw+qO8ll9ZRIKm/WiCUlVY8dGs
	 uMkETrPIPllVgzXC5mvy7b/tlUidq9VLxbKlZMQkSS+5MkuqrM732NdUt6cnXLjI1oMfr
	 zVo1VBvVil72SJZLwt0veuYOaU4psV5Nrf8ALjzyY43HIrhKugtBPKsfSmjRxEKgwbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PY16FJu0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PY16FJu0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CCE1F0089F;
	Sat,  7 Nov 2026 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049129;
	bh=cDLEq0LkR6GUN4b0BDsHyZNX810By/KpEGmhQeCWKO4=;
	h=From:To:Cc:Subject:Date;
	b=PY16FJu01PlwSQ7h1iu7rDB+Dj87dYo0nRixu9W8u6XRKox9uQEMxe6ULYsUx2Y5m
	 OMpfZoijMQ8D8d7bjn+VaBaRoj51gaFk9HNShQTO+V4R09EBp8jSuUikZf+2rpxEp2
	 9da+Xr67WraPyafK8matRVuw54Gzz0hsZbQwyhOfj6B3d3n9S45ewLmiAVlJH6ReKe
	 D7CMLiyXco8ALUZZwvpPPfLdXMszSUm3A7Hpkbs+X+TTK7eLMO6NIDlKwlZv4Ls2Cn
	 TUH4g6rkIVQ+o1KCL4hTQ2zVuET+drR5N2Om50thsyN9Xdi17wIPJ25XluAlJoO55A
	 AGpif7Cv03lzA==
From: Sasha Levin <sashal@kernel.org>
To: jiucheng.xu@amlogic.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: force out-place update for all writes on compressed file" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:47 -0500
Message-ID: <20261107055847-failed-5.15-a64a3fec11e7@kernel.org>
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
git cherry-pick -x a64a3fec11e77a3a0dc0009bdc58b925e45a1bb4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055847-failed-5.15-a64a3fec11e7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




