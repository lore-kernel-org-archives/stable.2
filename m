Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4831326B;
	Fri, 17 Jul 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298596; cv=none; b=k5uFISRvHyvYRD7mgfkq37esbWwbYN8vBQ4DdNRKBSEo/IgR0QOGUlHOE+1O6B1pgXmfySZYnSWUf8953D8vh1eqsU7Ma5JyOGDJZOs0O+g2aAiYLd/L41f5DwgQXzM4lsfNn5BN/gp13ZGFlMH0Tqs1347ncC2H2Mn8fCyfEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298596; c=relaxed/simple;
	bh=I5ldIjRGD3cNvUQF+m5WOM6prop/74NfY9VNphtqOQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gRRcW+i4pIV9cd+h850NZlNlYoJjK5wuGoKnfuzBkBYCGWQ/IX5MONpTo3csRxTzfjvVSo96/wyLC89CBUBlR242Z/tjTXiaEP7vbLrDzFdDOdVlTFLxk1LLfU+KaYmcOx1MbWWkVoFnePs1xUMdOjGH8atBLsW435+28awdoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hceIPzM9; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hceIPzM9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784298573; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2QkTdjWC0lSY6M9Vz7HbKNPdgT55JYfFATk17MFjoN4=;
	b=hceIPzM9OCRLw4T+NbL5RspTvcY+prC/qfx3zCrIoWhkHEkidPvWBCnVhYmPF3uDlM2O1qpPQHGzQa+RHJIfllMTvDrZiYOeTxQQgIvO2x0Rk6FF4Vz8UrOtKqiNuqjsjnBKS/Z4FCuL285m0tgxJHDGX5lrguE7dcPnsJ5dgWM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X7HYLFb_1784298572;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X7HYLFb_1784298572 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jul 2026 22:29:33 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	fuse-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	horst@birthelmer.de,
	stable@vger.kernel.org
Subject: [PATCH v2] fuse: don't bump attr_version for async direct read completion
Date: Fri, 17 Jul 2026 22:29:32 +0800
Message-Id: <20260717142932.71778-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The attr_version counter should only be incremented when cached
attributes are actually modified (as documented in commit 1fb69e781729
("fuse: fix race between getattr and write")).  Async direct reads do not
modify any cached inode attributes (size, mtime, ctime), so bumping
attr_version in fuse_aio_complete() for reads is incorrect.

This unconditional bump causes a livelock when auto_inval_data is
enabled together with writeback_cache: fuse_cache_read_iter() issues a
FUSE_GETATTR before every read, but by the time the response arrives,
an async DIO read completion has already incremented fi->attr_version
past the snapshot taken before the request.  The GETATTR result is then
discarded (attr_version race), fi->i_time is never refreshed, and every
subsequent read triggers yet another GETATTR -- creating an infinite
loop of useless round-trips.

Fix this by only bumping attr_version for write completions, consistent
with the synchronous DIO write path (fuse_write_update_attr) and the
cached write path.

Fixes: 01e9d11a3e79 ("fuse: add support of async IO")
Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ceada75310b8..c41287e8bc15 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -688,7 +688,7 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 		struct address_space *mapping = io->iocb->ki_filp->f_mapping;
 		ssize_t res = fuse_get_res_by_io(io);
 
-		if (res >= 0) {
+		if (res >= 0 && io->write) {
 			struct fuse_conn *fc = get_fuse_conn(inode);
 			struct fuse_inode *fi = get_fuse_inode(inode);
 
-- 
2.19.1.6.gb485710b

