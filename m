Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776976;
	b=p69GqU4NgrHfgKqfvm1HVNnFZkinLfUpljKVSNY4UJcerm4mgzGzIVTU/UDNxTtaH07C
	 agvuLjPMpKEohVGgX9ioQH68k7fpVEDskvaGb+zYfY+pKi5l85mgYBBhDnCUQ8Es3zm3F
	 t2vlSe5FfwxO8T5iYlW45hY177sQm8v27LhebRe0L7O0oV5m5v0EuoSmkvrmESNQQBNRk
	 FNKJnQffCS7BMtH0DpHNJKASzjpoK/f59FGlLc/vTX7SsAVO2OkhDqDqv2xSpO6R8u1zC
	 0WsEttq6sDUo2HGmi5urHRm2EDOEKXfrIcYS8yDyE2YNRDrvSPbozf4F3SO9qH2+hOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776976;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PcIDSrMX4GfRswyhZ8Mr5fmEaIdp0nKGVydna+0B8qU=;
	b=xapiv91fUZVuDZWM+OHjOM27/fy0zwvDQw/qG0bVo/5F1zf2VDYbM3DW0/+Uvx500QG7
	 2LIR4MPCy9328MSZUzdJ8C7Jdms3BBaBbaZzBtEn89l7ghB9FNYE7cbPlrchwfrk8SuWE
	 wA10gjIUsZdJKxwH6lidzk35TsTJ/s7A5b6c8o1lH4q3ViD9mLyZjymsDvaLqMAvHqZM7
	 MxM7V1LQKWsAjGVGN+3qLeR431rbtXsRMMFXNj4Ywf0kPw0NVj87ZzT3ecyriJkS2L/DA
	 J0k9VtA/J5SH/iIRAKl1EIDI1cMkIQNx/VM+AQaeT8YRcPrcNBz0e+9IZssNXVKYWdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6Wa8Ysr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402C606A32E;
	Fri, 27 Nov 2026 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6Wa8Ysr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64DC1F0089B;
	Fri, 27 Nov 2026 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776976;
	bh=PcIDSrMX4GfRswyhZ8Mr5fmEaIdp0nKGVydna+0B8qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i6Wa8YsrXOYlquO8VqjYTWal3vnNjX8cX+bD198l0isO1KAAP5XYTKyKsLYPA/Sqs
	 ZEPkm9FoI1xUv40386Dg9hcjD+tADctA6ZbBDDm6Og2QH21VFoiBCPJ21AcNg5MxXK
	 7MSzBMtPK1ypOQdbQtvI31PnKnza3cyY6sz973Ujr/cJ3EQHLb4U2vweT7hQVe8SXp
	 GTMtaRWcF7EaAYYmw0ZD9a6Xds7ztu4gK8NYn8uIvQFR/4Sr0XhByEtVcjMI/UpBqz
	 OfIJaRU4h1FD1o5YpDUsT4EItzMJoyO7FrjFNSA6pQk2zA3ph6rBsynkCv5hnwbH4i
	 FEFdTCNc8lzXw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/7] f2fs: fix to return -EIO from f2fs_sync_fs() if cp_error is set
Date: Fri, 27 Nov 2026 10:56:09 +0000
Message-ID: <20261127105608.537148-9-chao@kernel.org>
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

f2fs_sync_fs() returns 0 w/o doing checkpoint once cp_error is set, so
its callers can not tell whether checkpoint was done or not.

For a file which needs a checkpoint to persist its fsynced data, e.g. a
compressed file (CP_COMPRESSED), f2fs_do_sync_file() calls
f2fs_sync_fs(). So if shutdown (e.g. F2FS_GOING_DOWN_NOSYNC) races w/
fsync, after f2fs_sync_file() passed its cp_error check, fsync() returns
0 while neither checkpoint nor fsync node blocks were written: after
recovery, the fsynced data of the compressed file is rolled back to an
old version or lost.

In addition, syncfs(2) and F2FS_IOC_WRITE_CHECKPOINT report false
success on a stopped filesystem as well, whereas other filesystems
return -EIO from ->sync_fs after shutdown.

Note that f2fs_write_checkpoint() already returns -EIO if cp_error is
set, so callers of f2fs_sync_fs() have to handle -EIO anyway.

So let's return -EIO from f2fs_sync_fs() if cp_error is set, and in
f2fs_do_sync_file(), bail out w/o clearing FI_APPEND_WRITE and
FI_UPDATE_WRITE if f2fs_sync_fs() fails, as the non-checkpoint path
already does after f2fs_fsync_node_caches().

For shutdown, F2FS_GOING_DOWN_METASYNC and F2FS_GOING_DOWN_NEED_FSCK
have already converted -EIO from f2fs_sync_fs() to 0, however,
F2FS_GOING_DOWN_FULLSYNC fails w/ -EIO once cp_error is set, e.g. when
the filesystem is shutdown again, because:

- f2fs_do_shutdown
 - bdev_freeze
  - fs_bdev_freeze
   - freeze_super
    - sync_filesystem
     - f2fs_sync_fs_super
      - f2fs_sync_fs
      : return -EIO due to cp_error
    - f2fs_freeze
    : return -EIO due to cp_error as well

whereas other filesystems return 0 in this case. So let's do the
conversion for all shutdown modes at the end of f2fs_do_shutdown(), and
only if cp_error is set, so that the error is still returned to the
caller if the filesystem was not stopped, e.g. bdev_freeze() fails due
to other reasons.

Cc: stable@vger.kernel.org
Fixes: 1f227a3e215d ("f2fs: stop all the operations by cp_error flag")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- f2fs_do_shutdown(): if filesystem has stopped already, i.e.
  bdev_freeze() of F2FS_GOING_DOWN_FULLSYNC or f2fs_sync_fs() of
  F2FS_GOING_DOWN_METASYNC fails w/ -EIO and cp_error is set, still call
  f2fs_stop_checkpoint() and do the rest of shutdown, i.e. stop gc and
  discard threads and drop discard commands, rather than jumping to out.
- rebase to the latest dev-test branch.

 fs/f2fs/file.c  | 25 +++++++++++++++++--------
 fs/f2fs/super.c |  2 +-
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3caa6ceea554..f1fc0177df1a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -468,6 +468,8 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	if (cp_reason) {
 		/* all the dirty node pages should be flushed for POR */
 		ret = f2fs_sync_fs(inode->i_sb, 1);
+		if (ret)
+			goto out;
 
 		/*
 		 * We've secured consistency through sync_fs. Following pino
@@ -2764,19 +2766,21 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 	switch (flag) {
 	case F2FS_GOING_DOWN_FULLSYNC:
 		ret = bdev_freeze(sb->s_bdev);
-		if (ret)
-			goto out;
+		if (ret) {
+			if (ret != -EIO || !f2fs_cp_error(sbi))
+				goto out;
+			/* fs has stopped already, shutdown it anyway */
+			f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
+			break;
+		}
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		bdev_thaw(sb->s_bdev);
 		break;
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
 		ret = f2fs_sync_fs(sb, 1);
-		if (ret) {
-			if (ret == -EIO)
-				ret = 0;
+		if (ret && (ret != -EIO || !f2fs_cp_error(sbi)))
 			goto out;
-		}
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_NOSYNC:
@@ -2792,8 +2796,6 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 		/* do checkpoint only */
 		ret = f2fs_sync_fs(sb, 1);
-		if (ret == -EIO)
-			ret = 0;
 		goto out;
 	default:
 		ret = -EINVAL;
@@ -2821,6 +2823,13 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 
 	f2fs_update_time(sbi, REQ_TIME);
 out:
+	/*
+	 * If filesystem has already stopped, e.g. it was shutdown before,
+	 * bdev_freeze() or f2fs_sync_fs() will fail w/ -EIO, let's return
+	 * 0 for such case, as other filesystems did.
+	 */
+	if (ret == -EIO && f2fs_cp_error(sbi))
+		ret = 0;
 
 	trace_f2fs_shutdown(sbi, flag, ret);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b73fc6e75c7a..43ef7a4ac219 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2138,7 +2138,7 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 	int err = 0;
 
 	if (unlikely(f2fs_cp_error(sbi)))
-		return 0;
+		return -EIO;
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return 0;
 
-- 
2.49.0

