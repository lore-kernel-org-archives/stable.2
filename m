Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B33BCD28
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537221; cv=none; b=YshSeGqvZVNhGR+zy8JmDQfmBazXa4eBXw0jfmh8X/BX9D94NomFr+c0eFisMBmiZeB17DqLst2pp+WxryLLPZ4IHzY+dYo4Y7U6SvDSH3HM2xviiFeI/5DwAtZedaCsZutHNCLPgJ9EKfTlamGmwmASuPkOn+sMlHC+KtGmt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537221; c=relaxed/simple;
	bh=wWgG7sjV9nscaDv1Mq3ZKEfp6g3wkkmBwslvdUb/uqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=or3yCTx61pbvsgXF2rj6xrZ8gKLLzVkiH5u18BLkvtMgyMlF+67IkCabNnlMV6YzTzhrRi3qM+3E4HFWNN1Ku2KdADQtEjuOGw31xlMeJA1qJEB6Vbm5YriGP3jvitg3mXblZTe52+hEHyVtPM2XCZ6z1kgHacA4/N2ijDsHD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYNT07Ek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYNT07Ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFD61F00A3E;
	Fri,  4 Sep 2026 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537219;
	bh=SE7A+hEEmdWKihLpAHPJaTZ6iGhW63pnM5KrloEBSiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NYNT07Ek+rG44NSANO0ckdUl9EpIdebh9t2ZcynK9nvji1+QM8P1RH9wqiWS9mCWq
	 cV9ZOgwycCAqXsuBw1NxAmhaFHZwo3NWF3jyQlciOPgvfxoRNY1yaMkoj4uNi4x+Ku
	 /AyT2FpdDFj7cZlw0D+hVm0ZKlO8r1nU/8d0RJI2o+SNqsTG+S4VwCyWKVq6sMkVPk
	 onOWwcjp5IYMzhrQQ6dn7n+xbby9yOB9/pJeEVlKgi0XJvy41q1vFRz3IZ/MuC+4Q7
	 LMPLNsN0LO18k7fwf1N16p5zXKwO7GNh70vfAOcFL8gYtNf1k+qM1WRPvUZFxoMwTb
	 yYony1P4AI4OQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] block: use flags instead of bit fields for blkdev_dio
Date: Fri,  4 Sep 2026 11:53:32 -0400
Message-ID: <20260904155336.1042108-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155336.1042108-1-sashal@kernel.org>
References: <2026090333-willfully-art-ea0b@gregkh>
 <20260904155336.1042108-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 09ce8744253a038eb658c14f9dc3b77fa021fc9f ]

This generates a lot better code for me, and bumps performance from
7650K IOPS to 7750K IOPS. Looking at profiles for the run and running
perf diff, it confirms that we're now sending a lot less time there:

     6.38%     -2.80%  [kernel.vmlinux]  [k] blkdev_direct_IO

Taking it from the 2nd most cycle consumer to only the 9th most at
3.35% of the CPU time.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: e78dcb1f7ec2 ("usb: gadget: f_fs: Fix Use-After-Free in AIO error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/fops.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index c23529d08929d..9359368ca7cf4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -126,6 +126,12 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	return ret;
 }
 
+enum {
+	DIO_MULTI_BIO		= 1,
+	DIO_SHOULD_DIRTY	= 2,
+	DIO_IS_SYNC		= 4,
+};
+
 struct blkdev_dio {
 	union {
 		struct kiocb		*iocb;
@@ -133,9 +139,7 @@ struct blkdev_dio {
 	};
 	size_t			size;
 	atomic_t		ref;
-	bool			multi_bio : 1;
-	bool			should_dirty : 1;
-	bool			is_sync : 1;
+	unsigned int		flags;
 	struct bio		bio;
 };
 
@@ -152,13 +156,13 @@ static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
-	bool should_dirty = dio->should_dirty;
+	bool should_dirty = dio->flags & DIO_SHOULD_DIRTY;
 
 	if (bio->bi_status && !dio->bio.bi_status)
 		dio->bio.bi_status = bio->bi_status;
 
-	if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {
-		if (!dio->is_sync) {
+	if (!(dio->flags & DIO_MULTI_BIO) || atomic_dec_and_test(&dio->ref)) {
+		if (!(dio->flags & DIO_IS_SYNC)) {
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;
 
@@ -170,7 +174,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 			}
 
 			dio->iocb->ki_complete(iocb, ret, 0);
-			if (dio->multi_bio)
+			if (dio->flags & DIO_MULTI_BIO)
 				bio_put(&dio->bio);
 		} else {
 			struct task_struct *waiter = dio->waiter;
@@ -210,17 +214,19 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
 
 	dio = container_of(bio, struct blkdev_dio, bio);
-	dio->is_sync = is_sync = is_sync_kiocb(iocb);
-	if (dio->is_sync) {
+	is_sync = is_sync_kiocb(iocb);
+	if (is_sync) {
+		dio->flags = DIO_IS_SYNC;
 		dio->waiter = current;
 		bio_get(bio);
 	} else {
+		dio->flags = 0;
 		dio->iocb = iocb;
 	}
 
 	dio->size = 0;
-	dio->multi_bio = false;
-	dio->should_dirty = is_read && iter_is_iovec(iter);
+	if (is_read && iter_is_iovec(iter))
+		dio->flags |= DIO_SHOULD_DIRTY;
 
 	/*
 	 * Don't plug for HIPRI/polled IO, as those should go straight
@@ -263,7 +269,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 		if (is_read) {
 			bio->bi_opf = REQ_OP_READ;
-			if (dio->should_dirty)
+			if (dio->flags & DIO_SHOULD_DIRTY)
 				bio_set_pages_dirty(bio);
 		} else {
 			bio->bi_opf = dio_bio_write_op(iocb);
@@ -285,7 +291,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				WRITE_ONCE(iocb->ki_cookie, qc);
 			break;
 		}
-		if (!dio->multi_bio) {
+		if (!(dio->flags & DIO_MULTI_BIO)) {
 			/*
 			 * AIO needs an extra reference to ensure the dio
 			 * structure which is embedded into the first bio
@@ -293,7 +299,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			 */
 			if (!is_sync)
 				bio_get(bio);
-			dio->multi_bio = true;
+			dio->flags |= DIO_MULTI_BIO;
 			atomic_set(&dio->ref, 2);
 			do_poll = false;
 		} else {
-- 
2.53.0

