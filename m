Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346503;
	b=1BL8M/cCNOsaiYyoDxMaUazUiTGmU+5FiZB/Yb1p9jittbAqSFHKLpc9A8dFPPOoz4lW
	 qongZ5rBREmWBwYke33kSVKGChFIfEmO25AZwzmADJZZJeIL4IFTfYx+TdKqtZVLac443
	 +dVz0vBXBgXVDa/w6wpIObhqzLEK5sVr8UgMRV+0kT0WztGWIk1bw2pUSd+bj0zMXOuQT
	 7VcAWYSZ8mXVhCQPXCxzttKzs38VaZET9WP5gHBhVA4jQQbzLV+J6vLQnX33wfa7r4Q74
	 He6O+CdVGd7GjBTETR4g09JmyzYNnAz4ERuewlAaRGbPS4pbxytL4Hu8z7mvVdr51Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346503;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dZD43tyunaItScbhLZfSDsnS0JSVPJy1+C5YEfh5C50=;
	b=IdKAx/z8tyi/r7ugHApwpNbaJB7NMdDcjpUZUB4rgBUVD3lKXB24o6qoUzBWsMp/d2Ty
	 7TDnGcszRqZFs30+fo3xtZf7MRAyrZ/jFUeqEEIa+4IUDqn8/4cCE5IqGCnDqnn7FN/CS
	 R1jngS9PgsR0Li4H1D7JPobcKohsdK9ldkCfQAOSqkL4efYwW582BfVniKHCPy7ccxwpA
	 6WyeHaHGXofAzuBw/rqDJ29LrmFrsRboekPBu/hRJfaVIBHzN+JAPMF1iGYEFRdEPW8CX
	 JRmDEy1joxAdvj7sKEQN8XwoWEDv7ZE6Q5l5HpxX17QlQVRFWgzHvdnLX4pJCVRLhmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PkDMOb1K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CEA60A2604
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PkDMOb1K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB621F008BF;
	Tue, 10 Nov 2026 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346503;
	bh=dZD43tyunaItScbhLZfSDsnS0JSVPJy1+C5YEfh5C50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PkDMOb1KOQXhryGSEcdfItDoXFGnA8IoxTp/l7JsZm8ph2JHXos62fkMyz/DBRw27
	 pTBsscyWK3Lu9zoNMMIE0zgL8Y1q8oefIJhtKfuAzAYvdH+GM5gZEKwNXkDTcirUlO
	 ltDOowoXljAIpIncA9FhERFhw49gDuTUGIW2ohzm0dk39xHKeXDIjLbLVnL6kXx8Tr
	 jc5RC/56b8A+oP1AD7OPf1V6/gESQUPHlnTtkXZmMaMNnOBydqd4QGTqIidKI/Nxzq
	 ylUzJd5vYT67OOdwjM8hPRplOIpfh3jgtzDnLSSrlirKpivFbMmHsn9bsQbejKhZ9N
	 WlYjqPjxGL3ZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tal Zussman <tz2294@columbia.edu>,
	Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] block: introduce bio_in_atomic()
Date: Tue, 10 Nov 2026 16:34:59 -0500
Message-ID: <20261110213230.3939455-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053451-failed-6.6-a605d5d71a6d@kernel.org>
References: <20261107053451-failed-6.6-a605d5d71a6d@kernel.org>
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

From: Tal Zussman <tz2294@columbia.edu>

[ Upstream commit 8ed0831b5263e1aa48d99063795a1f20e4e69b50 ]

Move the atomic context detection logic from erofs's z_erofs_in_atomic()
into the block layer as bio_in_atomic(). This helper returns true when
the current context is unsafe for sleeping bio completion handlers (e.g.,
hard/soft IRQ, preempt-disabled).

The logic was originally added to erofs in commit c99fab6e80b7 ("erofs:
fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC"). A
subsequent patch will use it in the block layer's bio completion
infrastructure, so move it to include/linux/bio.h where both subsystems
can share it.

Convert erofs to call the new bio_in_atomic() directly.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260730-blk-dontcache-v7-1-3e8e6850068d@columbia.edu
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: a605d5d71a6d ("f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c    | 11 +----------
 include/linux/bio.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ede86dd93b5dd..1a8c4a068db8e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1404,15 +1404,6 @@ static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
 }
 #endif
 
-/* Use (kthread_)work in atomic contexts to minimize scheduling overhead */
-static inline bool z_erofs_in_atomic(void)
-{
-	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
-		return true;
-	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		return true;
-	return !preemptible();
-}
 
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       int bios)
@@ -1429,7 +1420,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	if (z_erofs_in_atomic()) {
+	if (bio_in_atomic()) {
 		/* See `sync_decompress` in sysfs-fs-erofs for more details */
 		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
 			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f193aef4fac08..089008d1d21ef 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -438,6 +438,21 @@ static inline struct bio *bio_alloc(struct block_device *bdev,
 
 void submit_bio(struct bio *bio);
 
+/**
+ * bio_in_atomic - check if the current context is unsafe for bio completion
+ *
+ * Return: %true in atomic contexts (e.g. hard/soft IRQ, preempt-disabled);
+ * %false when a bio can be safely completed in the current context.
+ */
+static inline bool bio_in_atomic(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
+		return true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return true;
+	return !preemptible();
+}
+
 extern void bio_endio(struct bio *);
 
 static inline void bio_io_error(struct bio *bio)
-- 
2.53.0

