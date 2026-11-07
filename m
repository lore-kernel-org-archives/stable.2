Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048118;
	b=XBqNDRiuJcIBZDLHG9Nw3XSd4KVtCUlJyPj4hALINMRibyyI1XK/39f6wU/sId5PFOV4
	 sFTOwKnn4WeB/dK8FPKcsDXUZ0bKWa05OQTDBnvLuDXn8ZStnSWyB9ycxkbTXq3HbYoq0
	 KwaAaQDQKYeWSzu5+75uiOG4tXD1BlZtZ6u1opSbyY4oPsFNaN2JfBHhxlddc5xlou/ee
	 uf1o99M5V0SfzUn/U1tjLlZCoPUXjNtqQ4CQF+xDIjV2QR9BXO+WaEch9Jwft0oRHbioE
	 HWDrbj2ryCGHgpLsoaB8vp0vQYldsTZsIQiTMSJnYi6+MeVgiGMYInkWA+tQJNddmiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mfMxyBq8Zvs7t19VHTZaeIgTbYgivxojzjJlIxfiuIY=;
	b=oKHq7yKcWhhK6yxWdTmtPuwCMckP3rXYcKKLDnzW6gTyATx8uKd2ghxoFdScPeS6KPEZ
	 qXjuyopEdh88Kf+GIp/HbMP78uvZty348npyZ1FUyIZu8m6Vl3+ZBp8q/v4tU3vZ2EZJY
	 gka3tyjjgLu4SdNXkTlIQgTMO0hMmHiUo1w6nykUl95U7LFYJbIbC2kU5kcJawUpCyMXx
	 LvWgWbbCcHiBEOh2cD+BKq9h7hnyYp36pYHfWPWJ8JgJgQk8ZfHrR/18OJTYxPpxRYgJL
	 /GmqB8RzrK41Q/KG18lHT60nMAQ8yBegi17rwhNqY3HGyNqIgc4S+JOJFEiQgoi3Zgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYm0T5PT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYm0T5PT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086B31F0089F;
	Sat,  7 Nov 2026 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048118;
	bh=mfMxyBq8Zvs7t19VHTZaeIgTbYgivxojzjJlIxfiuIY=;
	h=From:To:Cc:Subject:Date;
	b=jYm0T5PT93kW4zzRWLBTuV0jO4t0Sj59EiiTaieKUfRpOAdkr+AIw3YmXs5DAnXIR
	 gySjxtUCERZe69tA4REUbXLTErNM5ImEb6mhlUwEmfLYb6hdcWgDSZk9/RIuFucgse
	 ltADxYh2mqZgVdlzmRGo5axX862RW9Q3vOoEImLW8/LibVMfdkb30UQldFu7rcBk68
	 tjF3LtkGHpJs4y3X3ofqZJY48VfSSXasId9bvbnlmd3ofqOEeSd/EyOiYNBa2TdapD
	 X2SKAPAQIspuV+YoCfsDFz9IfK/Dy0er9ntn33H3tiOfzcBOAtUF28KSxLXBUcy+lV
	 d+6BoBBjR9Flg==
From: Sasha Levin <sashal@kernel.org>
To: jiucheng.xu@amlogic.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: force out-place update for all writes on compressed file" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:56 -0500
Message-ID: <20261107054156-failed-6.1-a64a3fec11e7@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a64a3fec11e77a3a0dc0009bdc58b925e45a1bb4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054156-failed-6.1-a64a3fec11e7@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




