Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344338;
	b=fxbqwIwbgJfFSUGUJZgbTorRZel+7q2VKpdOm0Anc1iET2rAiKhwDZ7gJ02Uz+IY0Dv6
	 k2XxKOiFnSkNn99jBgDBbCmkBoRW2J3OWXrwPTYG39TkhjB1CE0LtwQp1WcnyQzVjneFa
	 h4HB9RnnpOwGrY5/OvmbkTRqW+vmXn1LmvPqXGYUppSkyB+NcoDq1wFQtA9BMTDVc0G57
	 ywMVwLlWK+JmfoWn4vU4iLeHP9PU1z3c9uJenccnofCTtdGUIg+qvrw9JA2sMGiMGL/QT
	 hnLD1AEAE+9Xj0UrYReInsVivzA2t4wjp0xFAGXXVZW3lpz6BGOR/IwoJwKas5u57xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344338;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mSjhINdT5wLfB4e4Gr0YlYnKtF8cuYA5arlT+Ep6W+U=;
	b=sYavWf7V0iJgS8gvSLM58S1wtZ1ytBjmleCqiwhTqZ7Smupqj38pGJXL+2nA3EGx2n3g
	 L2XBzV4eWsC4LrLn4VaJu3ko02yAyxSlSHhpxKUtBDoGCbbR68eamcGqtOyfU1cUZkTCz
	 E0JBknC4I3NFPUGjKW2gpAuukvA5ItvDWjp3OaIgDUTC4temh31cDb9gzJ10sPCXEHRVs
	 hxGz3WWBU54ymPQphN+qt/DKSi/plSGfuGyFyS7zDJUI+OEyWkGQUpI385CHQ4HVoMAbn
	 7TdS4NWsiUlcC1J5S4mvQjdM1rARGvLESWT//8YFJRm0xNgKCiWij52+dcaPcDQ4wXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIcZ1G3b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B0606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIcZ1G3b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD141F0089F;
	Tue, 10 Nov 2026 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344337;
	bh=mSjhINdT5wLfB4e4Gr0YlYnKtF8cuYA5arlT+Ep6W+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UIcZ1G3bWCUOg0udVj5A1A4+jzidyp2Xy8aWyCXxUp4Mr+Xs7XKEGJMP3oHVc5XD5
	 WAdLfGicq4nVk4VfUH8mXYg7S9isFDa4XnNZ1rDDCaW5QJ30D1R+wGNHbvhcbmaaJn
	 Bzelwidyuo0OvVnW1yW3VzwsiBMfFMrmcUxhqNEmRtBRtONRirNSD2T/Id82J8FXme
	 dse+UBM0VNv+3d4FN2PZfZC01kjGcqYtOpSsHqjh7XDA0RIoNkP87BFDsb+fwwa3BC
	 ex5MFBPVdsL9wY4O71rPqkeoPSkDWF3M6OabpgEef92LM0z4ikKaPDmgSn3RuOAJZo
	 wnnnD1Nl4Ps9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tal Zussman <tz2294@columbia.edu>,
	Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] block: introduce bio_in_atomic()
Date: Tue, 10 Nov 2026 15:58:54 -0500
Message-ID: <20261110205812.3791945-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051116-failed-6.18-a605d5d71a6d@kernel.org>
References: <20261107051116-failed-6.18-a605d5d71a6d@kernel.org>
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
index 0af259e22026f..ab4b222aae899 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1414,15 +1414,6 @@ static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
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
@@ -1439,7 +1430,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	if (z_erofs_in_atomic()) {
+	if (bio_in_atomic()) {
 		/* See `sync_decompress` in sysfs-fs-erofs for more details */
 		if (sbi->sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
 			sbi->sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index fb747b053b98c..a5763f11fb137 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -376,6 +376,21 @@ static inline struct bio *bio_alloc(struct block_device *bdev,
 
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
 
 /**
-- 
2.53.0

