Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411677;
	b=yyobQTdoN4wBSCSAt3M1//w4F8mj4UgmGMPzexS1uzVTZ+pxG3cmMxPIa0OidhGD+ZCe
	 SanCGmUXLfL6vHvmUbT6EJRjvPxUudpHmkRvR78WwjN4eNMlxcjYjY0+Xr/0SXoC7Pl2v
	 LxiY3wRliWC75gqwhVNiIPfwPa3y8E8kCQ/6Up5fKdjZ7InGtmuNn0f+JYJ/7jPZ+NH/U
	 /+4ndTvM+PGxpFeRs1TJtMS+tGz8k6cmjTqL5J55WmqA5uC7+qGbzOfC/03GNQ0zRdvxW
	 8VyARgd0B4r1UXLwdy+ExNcq7tt+DRWNbnke98RCrHUWf8NiR2bAzu7qzFnAD6BfIQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411677;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=k7vY/es2cdaQx6kNqyTY+a1zou8OPKAapNdREd4ObsU=;
	b=liZ1O7sVt0QIuuJxUfKmMuhOcxhsdl3chUOG5x+xCdWJP1qb0OiSlSGchAiBdJnZDPIp
	 9Z5emSjO3Ys8gxaucOIuJSrIX1HfeQeW1cPK7MEKBp6ETE0vwDFvhpU1qOXNYn6kOSjD0
	 6e4TPXKT7CFwRT6eSaxNaxkCNwWTVlf0vIZy/zbG/nqGSszjMqepVOr270mpIJuBB713F
	 79+UTI6J79Edl8l7xOk9M77IWCvIrCJ39yYX36R2Xlhsy8KA+C0vAX6VKRSvKImQ0WPKo
	 zrx8yD8mp3YrDtNXG+GNPq5MkyeNOcPQUcrrTlCqUhiOF0JPG9w+T6tfpB2xjie9ONw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxJNtKDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20246606A88D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxJNtKDP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEBA1F00A07;
	Wed, 11 Nov 2026 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411677;
	bh=k7vY/es2cdaQx6kNqyTY+a1zou8OPKAapNdREd4ObsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SxJNtKDP28CVigAmYhZ+IbRwsb3oGkvwdMDTPa9HoVFGlDpcHphhHrhGAHwqqVrAm
	 Jd+VegxVUBOi2AezDlucsYkVJXc495kzoczjTCYgwRF+VJ0V5oySTzVQWpLnVgL5M4
	 95v1MAy+qTV4RVyvi+33LumD3Hj+xVGxczuRaVJXgcRqL9vqCJIlt0grTi+RztC1yJ
	 Hm56oO5wYpWX1shYg0v1lzq0H8c+XMLTPvIy2DrdZsOb3T9QzbQKPJfbS6xJzD/Qva
	 IO0ic8vlNAc0D6Vdk6vIl+nKA6p8NqvTvq2r1b4vzz2yEjvQ6zeE5qpWgoVffDI6hG
	 u3FttbTaGtMTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] f2fs: remove allow_outplace_dio()
Date: Wed, 11 Nov 2026 10:41:12 -0500
Message-ID: <20261111154005.2482659-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111154005.2482659-1-sashal@kernel.org>
References: <20261107062516-failed-5.10-6d1f622b9c06@kernel.org>
 <20261111154005.2482659-1-sashal@kernel.org>
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

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 6de8687ccdefed40d617492f4e1b3962eb577b6b ]

We can just check f2fs_lfs_mode() directly.  The block_unaligned_IO()
check is redundant because in LFS mode, f2fs doesn't do direct I/O
writes that aren't block-aligned (due to f2fs_force_buffered_io()
returning true in this case, triggering the fallback to buffered I/O).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 6d1f622b9c06 ("f2fs: fix submit accounting for IPU writeback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c |  2 +-
 fs/f2fs/f2fs.h | 10 ----------
 fs/f2fs/file.c |  2 +-
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e033c8dfb0348..3f7056f9971f5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3725,7 +3725,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (f2fs_force_buffered_io(inode, iocb, iter))
 		return 0;
 
-	do_opu = allow_outplace_dio(inode, iocb, iter);
+	do_opu = rw == WRITE && f2fs_lfs_mode(sbi);
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cead30cab94bc..43f14bbfef49b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4135,16 +4135,6 @@ static inline int block_unaligned_IO(struct inode *inode,
 	return align & blocksize_mask;
 }
 
-static inline int allow_outplace_dio(struct inode *inode,
-				struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int rw = iov_iter_rw(iter);
-
-	return (f2fs_lfs_mode(sbi) && (rw == WRITE) &&
-				!block_unaligned_IO(inode, iocb, iter));
-}
-
 static inline bool f2fs_force_buffered_io(struct inode *inode,
 				struct kiocb *iocb, struct iov_iter *iter)
 {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9c12691ace0b6..f43cc0ba83837 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4250,7 +4250,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			 * back to buffered IO.
 			 */
 			if (!f2fs_force_buffered_io(inode, iocb, from) &&
-					allow_outplace_dio(inode, iocb, from))
+					f2fs_lfs_mode(F2FS_I_SB(inode)))
 				goto write;
 		}
 		preallocated = true;
-- 
2.53.0

