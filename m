Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD7538D85
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870005; cv=none; b=M+zouoPOVyUH2GTGR9hL9ounQ7EHkgdDu9JHZTJpxefOfAWQSLGvbtqkMTQPETi2sWCGFIGT0KcdzuQF748p4ABK6OMZe7AGhhjG57oD9XzoTwWLHESqqfxkaV/zi2GLHmRr9ub/1pT5c/coc14lPuRVDjxnledLqLbvoTcgGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870005; c=relaxed/simple;
	bh=sJSqHmkmNfDEcGPdPjYC5DW7599XwYafeOr+oeBIN5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkFHcbY/VJnazQ35D6yrj/3XKUVV4WkiBSb0P2N02uu+CI6hfegTTlzjr9m9OIjDNjyGn3A0R9b7WO6qBOgQ4Y+YPBDtr7XGpBKKf/XpilZPijxsEwjUAkHcdr22LW6E6ty4yhKqIAAHYGC20darSp3hfsQy7b3Y1OInTIFPuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU4ezUZ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU4ezUZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3EB1F00A3D;
	Tue,  8 Sep 2026 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870000;
	bh=4xQicaI2DqrPU5sgo3uByXwnXhz7qVBaAoMXc9cpK0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dU4ezUZ8pcqSrUq2+tHAhfUSWrjfpO4Dr5mqABuhv+sdUZoD/b82gA00RIig5zTxx
	 O8UeApNFem4Xfx4d1h2Tsv3RymHChklwBbeFuwIFHphEjUfwGFm883Y///rqCj6fLr
	 4kZQycfLwp3b7ZTzfBsc4yjiaAPhf42dC942mzVZC/5vSM9YIrcCNjib3gmYR57eUp
	 ji544SzGIatCmhdLCdD5rI9Kc4awLOJi0HEwiJt20oMUWDlZoWRGZBB+wqS6UogsJ8
	 1KJE56sXM3fwkCDzU2RXQ12JUf4B9p8mfh5mPNadmMYc3/sGaV8/RL4KRnuXjtmtaW
	 s9m1IrMYCJgVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/6] iomap: simplify iomap_dio_bio_iter
Date: Tue,  8 Sep 2026 08:19:52 -0400
Message-ID: <20260908121955.2049107-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908121955.2049107-1-sashal@kernel.org>
References: <2026090313-revolver-python-ce1a@gregkh>
 <20260908121955.2049107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 6e7a6c80198ead08b11aa6cdc92e60a42fc5895f ]

Use iov_iter_count to check if we need to continue as that just reads
a field in the iov_iter, and only use bio_iov_vecs_to_alloc to calculate
the actual number of vectors to allocate for the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 14b007e17881 ("block: validate user space vectors during extraction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/direct-io.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e73c71f39bd45..6ea14d07dc618 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -344,7 +344,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 	bool need_zeroout = false;
-	int nr_pages, ret = 0;
+	int ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
 
@@ -426,7 +426,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 	}
 
-	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
 
@@ -439,7 +438,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 		}
 
-		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
+		bio = iomap_dio_alloc_bio(iter, dio,
+				bio_iov_vecs_to_alloc(dio->submit.iter,
+						BIO_MAX_VECS), bio_opf);
 		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
@@ -481,16 +482,14 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		dio->size += n;
 		copied += n;
 
-		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
-						 BIO_MAX_VECS);
 		/*
 		 * We can only poll for single bio I/Os.
 		 */
-		if (nr_pages)
+		if (iov_iter_count(dio->submit.iter))
 			dio->iocb->ki_flags &= ~IOCB_HIPRI;
 		iomap_dio_submit_bio(iter, dio, bio, pos);
 		pos += n;
-	} while (nr_pages);
+	} while (iov_iter_count(dio->submit.iter));
 
 	/*
 	 * We need to zeroout the tail of a sub-block write if the extent type
-- 
2.53.0

