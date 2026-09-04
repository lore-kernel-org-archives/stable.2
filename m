Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C64D2ED0
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546916; cv=none; b=SEvXTuAn17NJjd7vQULbmzONy/U8LCUN6vUAWh2OKcFsEgR3aewXpTMX0ke45/U1IpRMU8dhbUwEMcQKGSP04jCo6zoITNLOIZfboiX/LXRGq7jS49yyUQNgw+S5ra5lcRRbwG/RROaZqOY5dQni4Xpz+MDZuayXZASORUid2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546916; c=relaxed/simple;
	bh=O4LpJKbadcHsAvIxdDz2yur5iM2kWhRs9pKSR867pF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBLguIFJuTPI87SQLnOKs7YMfLzjDuAm5hubOQfkZijFuHUl05LgUYdJ8w/klYYDafB4jQlEyBaaIqIt4hFU3GraNvE6fpEz4RrLHC897hqfzuiMIO57DZPRk8cDWQndF6LzlTkpEvAaae10Mzi6+zNDg/yPKQBZ5ql8SpW3pqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtQl/Scp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtQl/Scp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F0D1F00A3E;
	Fri,  4 Sep 2026 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546911;
	bh=oyOqOeZY4mvL8OXtlANaqaIM7bNOBSEJEyVHg/DJI+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EtQl/Scpp7NYTJ5t01tDxvoxVCziEOLFe35ZFrTEuORZsTUshk097GoPVn7mmWbcR
	 hTGHFFOPdoJqQ7vUrGL0OCUYff83qpTVSWftxl3DUugkIRRPvE6Za9ADKO1F1eve0s
	 4RhN4xl8ejNkOjALd8QEThNOsAZZktGOyEwP24WL3n+XCgPs5BhJWqrrmqacn+UDVJ
	 AxeT1M/5vhvSK0WCIjxM758XN/Ft2ij+MxjEZdef7SRxa8yAYnu6Eo0GO0MnMCHi/8
	 vyIJB+B3pET6Fz9Bh7VrOW79O3rhzEf51+Ij1+AobrFBuCXqpaV2paUVXJVQ0qmNzW
	 BXfI4PpIrclHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] block: split out operations on block special files
Date: Fri,  4 Sep 2026 14:35:06 -0400
Message-ID: <20260904183509.1323404-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090334-tiring-good-fffe@gregkh>
References: <2026090334-tiring-good-fffe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit cd82cca7ebfe9c6c74a8e5b28382ba88177ba5f1 ]

Add a new block/fops.c for all the file and address_space operations
that provide the block special file support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20210907141303.1371844-2-hch@lst.de
[axboe: correct trailing whitespace while at it]
Signed-off-by: Jens Axboe <axboe@kernel.dk>

[ sashal: Reduced backport -- upstream cd82cca7ebfe9 touches 4 file(s), this
  backport carries 1. Not backported here:
  block/blk.h
  block/fops.c
  block/Makefile
  fs/block_dev.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e78dcb1f7ec2 ("usb: gadget: f_fs: Fix Use-After-Free in AIO error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index fa3444e6b67d4..75a27d3e261aa 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -831,9 +831,15 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	unsigned long flags;
 
 	if (io_data->read && ret > 0) {
-		kthread_use_mm(io_data->mm);
-		ret = ffs_copy_to_iter(io_data->buf, ret, &io_data->data);
-		kthread_unuse_mm(io_data->mm);
+		if (mmget_not_zero(io_data->mm)) {
+			kthread_use_mm(io_data->mm);
+			ret = ffs_copy_to_iter(io_data->buf, ret, &io_data->data);
+			kthread_unuse_mm(io_data->mm);
+			mmput(io_data->mm);
+		} else {
+			ret = -EFAULT;
+		}
+		mmdrop(io_data->mm);
 	}
 
 	io_data->kiocb->ki_complete(io_data->kiocb, ret, ret);
@@ -1210,16 +1216,20 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
 	kiocb->private = p;
 
-	if (p->aio)
+	if (p->aio) {
+		mmgrab(p->mm);
 		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
+	}
 
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
-	if (p->aio)
+	if (p->aio) {
+		mmdrop(p->mm);
 		kfree(p);
-	else
+	} else {
 		*from = p->data;
+	}
 	return res;
 }
 
@@ -1256,14 +1266,17 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
 	kiocb->private = p;
 
-	if (p->aio)
+	if (p->aio) {
+		mmgrab(p->mm);
 		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
+	}
 
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
 
 	if (p->aio) {
+		mmdrop(p->mm);
 		kfree(p->to_free);
 		kfree(p);
 	} else {
-- 
2.53.0

