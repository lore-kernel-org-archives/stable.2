Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776982;
	b=MAGCOCEWrZHYGpGnOtKfA9xlysHXywggQIguiJCLqhmdn+7frb/9JALgaRgWtJywic+K
	 EVVRZj21K+w55aVnTBK5oGTqYdKnYkQxlM+Wj/X68j1RZh8PyldhDJr2+Cqh+3vJA8KqZ
	 L/P2HDDfxI8kJ5GhnsvUwummDzN2lllLS1Jyo1geDESGal9AZczZfPa1zKEjn0aStmDDB
	 lwnvuoeldfx04dTabtJoPCLBZe6dTdrd1sqYpp522Xd0oXLM2EjJmhH3SAYc/kwDdW7PF
	 8TsV75LSHpoiuVs/Abgk5j6A1iUzsRUT18UW6VEIe+XCE0SVbQIWg4/ZOzN0qHPD4cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4ZfEG9ExJAKvef7ugb+08iUADX84yq73wvqYFshKuOM=;
	b=5J2t9c9Ced+ktG+y4NDYhD8kuWM3bkYhGe6HzIyUbLQjQ5ntqMujPk67VrqsBKSNReJv
	 3LJcxJxUESpbQB6P3e5mxIqUWx7sxTZVAGfOUAHxD/7T8+BElnC5KWWJXWSzqWiz/nVBw
	 Y+MVf6Orxx5miBCxntWNIvk2qca74/ZZCfl65Mj/REtTt65P0sP9gWPIpWZ7ExHDi5j5H
	 WkSC9igM5jGHyuTk5y5owHvbvqwDf5gwtjlGYxCpAh1RFUoxwYfisTd1H/LJ2sSwIAXj/
	 Ew0udENkPBoOb33uORG7kGSzgENfLTdUeKHGCDW9ocKgVlQQ86yN4WonYgpJ2rCueyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhjnsmlp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F4606A33E;
	Fri, 27 Nov 2026 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhjnsmlp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EBE1F00934;
	Fri, 27 Nov 2026 10:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776981;
	bh=4ZfEG9ExJAKvef7ugb+08iUADX84yq73wvqYFshKuOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mhjnsmlpHIOJk7R8/OoT7W+9o9gmUxvofwSHkOjGq10weJsL94vaQfConw8IOXuL5
	 TDdt8p1ZvtfBYsnqTYDpTvFLhPV0c/viwf8m+tFFfkHdkPbkTAUebDayuH9iBdGLiq
	 lob4Ly127po53gIge/vOi7ewTjbSFFIK9tMH9UOdgzxbILOvtum3W7gmxmPOoSIfer
	 PdjviV/+50oYr9pMuPmhxL8gXI83mUtQoxidNEEHIk68keWpK+jha4AVKreQhrr//A
	 uY3sZ3lfvBm9ZbiPGY3rfDI1Axv9kJAeEnUeFf3h0wuKOsb0FcnrLDaUqpTbb8Vhz4
	 PWw95NiD0h32w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 5/7] f2fs: fix to truncate meta cache entry in F2FS_IOC_SEC_TRIM_FILE
Date: Fri, 27 Nov 2026 10:56:12 +0000
Message-ID: <20261127105608.537148-12-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127105608.537148-8-chao@kernel.org>
References: <20261127105608.537148-8-chao@kernel.org>
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

From: Chao Yu <chao@kernel.org>

F2FS_IOC_SEC_TRIM_FILE discards and/or zeroes out data blocks of the
file in place via f2fs_secure_erase(), but it never truncates the meta
cache entry of the blocks, which may be cached by GC if the inode
requires meta inode GC, e.g. encrypted inode.

GC trusts an uptodate meta cache entry w/o reading the block from disk
again, so it can migrate data which was erased to a new block address,
then the erased data will be resurrected in the file.

- App (file F)				- GC
					- gc_data_segment() phase 3
					 - ra_data_block(F, j)
					 : cache F[j] in META[P]
- ioctl(F2FS_IOC_SEC_TRIM_FILE)
 - f2fs_down_write(i_gc_rwsem[WRITE])
					- gc_data_segment() phase 4
					 - f2fs_down_write_trylock(i_gc_rwsem[WRITE])
					 : fail, skip F[j]
 - f2fs_secure_erase(P)
 : P was erased, META[P] becomes stale
 - f2fs_up_write(i_gc_rwsem[WRITE])
					- gc_data_segment() phase 3
					 - ra_data_block(F, j)
					 : META[P] is uptodate, skip reading
					- gc_data_segment() phase 4
					 - move_data_block(F, j)
					 : META[P] is uptodate, skip reading
					  - memcpy(tentry, sentry)
					  - f2fs_update_data_blkaddr(newaddr)
					 : F[j] was resurrected w/ erased data

In addition, GC may be writing back the block w/ meta cache, we need to
wait for the writeback before erasing the block.

Let's call f2fs_wait_on_block_writeback_range() for each block before
erasing it, which waits for writeback of the cache entry, and truncates
the cache entry.

Cc: stable@vger.kernel.org
Fixes: 9af846486d78 ("f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase to the latest dev-test branch.

 fs/f2fs/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f1fc0177df1a..ddf71ed6e41e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4961,6 +4961,13 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 				goto out;
 			}
 
+			/*
+			 * wait for GC's writeback and truncate the meta cache
+			 * entry of the block, otherwise GC may migrate stale
+			 * data in meta cache after the block was erased.
+			 */
+			f2fs_wait_on_block_writeback_range(inode, blkaddr, 1);
+
 			cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
 			if (f2fs_is_multi_device(sbi)) {
 				int di = f2fs_target_device_index(sbi, blkaddr);
-- 
2.49.0

