Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62B43C7DB
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537220; cv=none; b=myK0BJE5Z9xqxKSM6ncE8L3pL3Vb7U2gR418WMbxhgETsdAkda/mIK6h6FTev3dP/8ACuMABFvRf0ZI86MtE2LlhikSiBJghKpRWQMCrLnDDSQ27xf24aRYELin7NEWBPy/I1y4ya8S5tB2zFiHmlBuEdpWOu0gX8m5Yz3Epg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537220; c=relaxed/simple;
	bh=AI2Oi+cQbETW0tV17IkLKKa/QlPZOTN+GGJ3f9IHsug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTJ6F5XiNkPrjWpHX4TnNQBmxJAqklYeL0bJMZjybtmt7WeJTSMbUr6XgfwG1drxYlZGAdo0o/fR1847Jn6Ixszpe3Cp2lRCQpir1aqoo/muqCMtsWkXKGZDfDuG10h0Z5Rsi4DlEzVCxYhCMzGrDqyY2+9d4mLX5WNrZ456bCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfOGNzdf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfOGNzdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BEA1F00A3D;
	Fri,  4 Sep 2026 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537218;
	bh=HfbKmfSsUenBGt/+/gE57XrgSoqpx5ha/2YYt/wk7IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfOGNzdfk+HkE565Gjwn7Dzoot98DYKCQxKRU5b+jM2PlXQvf/Ai2pPMs6Csl2WbB
	 4/NgcqCPuwKGDTMAsOUvyi34e/YaoVhufFwhyzVxFRLsf+5ULls+9/O5UZBF52idUk
	 9pXsY4lQi0x3vs0hd/sxWnWAwp7IWTbvbh/NuIB9GkI3VhOKz3+4nSoB5AoYaMXrUK
	 i/r7+ij3ibO0lcKe5mKnLlc7v1TLf48FOaSBCofBFmwxdLgV9lUWZKy0mZapwRYjxY
	 MeFe6KImRM6tK0A7TM6VPzNW7CBg8KLNcytgYTs9MH27Mss1kNwRF6T9/o+0gOsl80
	 d2bZsEuSMVABQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] block: don't try to poll multi-bio I/Os in __blkdev_direct_IO
Date: Fri,  4 Sep 2026 11:53:31 -0400
Message-ID: <20260904155336.1042108-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090333-willfully-art-ea0b@gregkh>
References: <2026090333-willfully-art-ea0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 71fc3f5e2c00c966e6a2ffebadfbcc6914249d32 ]

If an iocb is split into multiple bios we can't poll for both.  So don't
even bother to try to poll in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20211012111226.760968-3-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: e78dcb1f7ec2 ("usb: gadget: f_fs: Fix Use-After-Free in AIO error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/fops.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 72da501542f14..c23529d08929d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -197,7 +197,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
+	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
@@ -226,7 +226,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	 * Don't plug for HIPRI/polled IO, as those should go straight
 	 * to issue
 	 */
-	if (!is_poll)
+	if (!(iocb->ki_flags & IOCB_HIPRI))
 		blk_start_plug(&plug);
 
 	for (;;) {
@@ -278,20 +278,13 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
 		if (!nr_pages) {
-			bool polled = false;
-
-			if (iocb->ki_flags & IOCB_HIPRI) {
+			if (do_poll)
 				bio_set_polled(bio, iocb);
-				polled = true;
-			}
-
 			qc = submit_bio(bio);
-
-			if (polled)
+			if (do_poll)
 				WRITE_ONCE(iocb->ki_cookie, qc);
 			break;
 		}
-
 		if (!dio->multi_bio) {
 			/*
 			 * AIO needs an extra reference to ensure the dio
@@ -302,6 +295,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				bio_get(bio);
 			dio->multi_bio = true;
 			atomic_set(&dio->ref, 2);
+			do_poll = false;
 		} else {
 			atomic_inc(&dio->ref);
 		}
@@ -310,7 +304,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
-	if (!is_poll)
+	if (!(iocb->ki_flags & IOCB_HIPRI))
 		blk_finish_plug(&plug);
 
 	if (!is_sync)
@@ -321,8 +315,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, true))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.53.0

