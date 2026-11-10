Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332553;
	b=Ktu9aQqeCQSs4hAmOZIG3SL5G4EZJVnRKeatjfQRzGC11mYw74B2pbkHUHPivmU5HXz2
	 boGymcR62eZltGiZo1ySJ/fN/vEenG/TPCtL4fX1v+Yn7dxCU7OCEllrPAyDK/7/s8miW
	 aIBxnwPzbaQhKTxe+etw47LnpGl5BtQTSRNZzW35w6SsdipVkDYIlBq3S9zlYxjWaOWbq
	 d2YH75HeU7tVqOl9J7dkvSMEWR1fmJZ3JeEgG0mD6EJEa/ZVm6sf2w4ttS6VfP/OUzeSA
	 xaKd5mvr9KecjJAiscMkB3lOt6wan3i2xRf7BplhKwJXHOm5QRSWDaxgHwWbs90yqXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332553;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=05okc4t7UdB3vf8+GYrRMZgDfRHvDlKE4i9NmfulAeI=;
	b=nSHL15lpYyMmGWXAFdhSWGzFMh2Xwjqn+dZAb+qVeQCexTSJSUW6LPFQonZ9/w4ZHtyt
	 eJ9cbxOovE/uSInuLXCjRPE9ftjuYgx5m9hQW3GShdlyNN/bRVizi0zmgPjJ8anDx/Idn
	 23K8w7IenyEvDqj5RMVpomcebPhpz+jWl5koSdfUp7J0+Mun3SthWsn5lIJ0KwLFyS2LV
	 aUVsQKBGBu0xUp5Y8LNEngC5KzD5dItnBVkqtxku4ShUvj2M6pBvo7D7foCUEsT9dwKXe
	 b+xKSKnxkq4WXNicdVofbDpuLrx7mZ4vTR36nl5G/cRcuwettTF+ClfT+TeVjnJgRKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ibS7/k+S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B4D606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibS7/k+S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459311F0089F;
	Tue, 10 Nov 2026 17:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332552;
	bh=05okc4t7UdB3vf8+GYrRMZgDfRHvDlKE4i9NmfulAeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ibS7/k+SozNsavWijOgO/myGDykQa+GcKeH4Othu2e0omq2XVYz1VXnVZXMeJhvGr
	 g34zRja3LM51sx0Qlt7kFdqTzwYOqdqYx3vwq2Ff1UtZ/eczTP3tXUeisL4H/D6NlW
	 8+ftUJ7PxjyJbG4heae88FRtK38easf/wbp2noO6RWbHLqfx5Hi2Pnu0pgDc95txcC
	 XaaMLV9Z7H712mB37vmnxN8GDWkzyMVL3VWXD9Fhwp1ta+m7w2ZXE652ga06OTIQP/
	 KjCoYyZm/TL4ZONcPe9g7vgccqre4UWwSVbcWLky40a1RI6RifgPVny4TRmXfhMna3
	 yIW9pi4sHfSJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] f2fs: atomic: fix to forbid dio in atomic_file
Date: Tue, 10 Nov 2026 12:42:29 -0500
Message-ID: <20261110173914.2972639-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053447-failed-6.6-06dfe4a7eb69@kernel.org>
References: <20261107053447-failed-6.6-06dfe4a7eb69@kernel.org>
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

[ Upstream commit b2c160f4f3cfe9334b3e6bb52cb89a3a20ef0385 ]

atomic write can only be used via buffered IO, let's fail direct IO on
atomic_file and return -EOPNOTSUPP.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 06dfe4a7eb69 ("f2fs: disallow mmap write and data-modifying fallocate on atomic files")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7ec8d054bf1ee..42eb530cca9f5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2281,6 +2281,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		goto out;
 
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
+	f2fs_down_write(&fi->i_gc_rwsem[READ]);
 
 	/*
 	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
@@ -2290,10 +2291,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		f2fs_warn(sbi, "Unexpected flush for atomic writes: ino=%lu, npages=%u",
 			  inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
-	if (ret) {
-		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-		goto out;
-	}
+	if (ret)
+		goto out_unlock;
 
 	/* Check if the inode already has a COW inode */
 	if (fi->cow_inode == NULL) {
@@ -2302,10 +2301,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		struct inode *dir = d_inode(dentry->d_parent);
 
 		ret = f2fs_get_tmpfile(idmap, dir, &fi->cow_inode);
-		if (ret) {
-			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-			goto out;
-		}
+		if (ret)
+			goto out_unlock;
 
 		set_inode_flag(fi->cow_inode, FI_COW_FILE);
 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
@@ -2319,10 +2316,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
 
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
-		if (ret) {
-			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-			goto out;
-		}
+		if (ret)
+			goto out_unlock;
 	}
 
 	f2fs_write_inode(inode, NULL);
@@ -2341,7 +2336,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	}
 	f2fs_i_size_write(fi->cow_inode, isize);
 
+out_unlock:
+	f2fs_up_write(&fi->i_gc_rwsem[READ]);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+	if (ret)
+		goto out;
 
 	f2fs_update_time(sbi, REQ_TIME);
 	fi->atomic_write_task = current;
@@ -4735,6 +4734,13 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		f2fs_down_read(&fi->i_gc_rwsem[READ]);
 	}
 
+	/* dio is not compatible w/ atomic file */
+	if (f2fs_is_atomic_file(inode)) {
+		f2fs_up_read(&fi->i_gc_rwsem[READ]);
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/*
 	 * We have to use __iomap_dio_rw() and iomap_dio_complete() instead of
 	 * the higher-level function iomap_dio_rw() in order to ensure that the
@@ -5140,6 +5146,12 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* Determine whether we will do a direct write or a buffered write. */
 	dio = f2fs_should_use_dio(inode, iocb, from);
 
+	/* dio is not compatible w/ atomic write */
+	if (dio && f2fs_is_atomic_file(inode)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	/* Possibly preallocate the blocks for the write. */
 	target_size = iocb->ki_pos + iov_iter_count(from);
 	preallocated = f2fs_preallocate_blocks(iocb, from, dio);
-- 
2.53.0

