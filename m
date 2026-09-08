Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DAC52FE51
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870008; cv=none; b=dit+n+OMhkaqjYlfxWcvqotlyVkGoThsCVtkaPei9bkLJhBiyoQ/c/Gi0jWf1DYohcvTqNIXimL/LMHYhxv08XsHJNpZEIN5Q0zT0kuqwWmdQqULYL5kjY+issQMmQUU5mJ42/3kYxsLM4nwhju9BKtOMMqfNXdOjSdqWEvoozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870008; c=relaxed/simple;
	bh=62T1cBCCwZpNdQeG3Ung+JtwelODpF1NmCaAQmoFtCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7BcQePduOkq6nfRsqRq73CJwUSgxx89vBq5wBiK0quX5tGc0SO0ow9c2RMPlq56N8zu7mS0sOyVNxvqqajBAeMSLTUe2iXorf4naq0+QjN3cZMVvqIXoEmGS+W06XaIJQG1JjRz8fTJNopcSu9ygl918akDmT8tLUICTl5bgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhUq/2bk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhUq/2bk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F94E1F00ACF;
	Tue,  8 Sep 2026 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870002;
	bh=yu/cHoBe6oMwlI5XOMUbOWIzIS4pm3GNQ+Tznz91xQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QhUq/2bkNVeLt9B658rNHnWhOx1rT+cc+GhU2t3uu1v+yT1z50uYXHKvt/HtmrZPL
	 hbmv8x+SdCAb9fUuuMR6xn4r4tF4CLpwN5h3KXWawMtnC9oEaq1sXYy1N0kipU231D
	 Dfqg1YrCvwnrF3RlN1Ca+39rbu336gziufZiP/K7tLuCDUJe6X05BeV/6SuRa3pnKA
	 /Tv2z+SgARyLNo64IqcCdXCmI7UQYljPBS+PnKaaF4eCP+Z2yd7RoH1dZYC82uqPI6
	 DKf69P22FO0MRR6oTmMk6J6jhhFgjQd2F+m03RZpior8N6fMGQFrxkze60wuYpKO2S
	 MmAAQ+o0nCktA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/6] iomap: rename IOMAP_DIO_DIRTY to IOMAP_DIO_USER_BACKED
Date: Tue,  8 Sep 2026 08:19:54 -0400
Message-ID: <20260908121955.2049107-5-sashal@kernel.org>
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

[ Upstream commit c96b8b220271024c04289d6d9779dc2ccbd12be2 ]

Match the more descriptive iov_iter terminology instead of encoding
what we do with them for reads only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 14b007e17881 ("block: validate user space vectors during extraction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/direct-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 2dc3c26cf870e..6c7293c3ba592 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -22,7 +22,7 @@
 #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
 #define IOMAP_DIO_NEED_SYNC	(1U << 29)
 #define IOMAP_DIO_WRITE		(1U << 30)
-#define IOMAP_DIO_DIRTY		(1U << 31)
+#define IOMAP_DIO_USER_BACKED	(1U << 31)
 
 /*
  * Used for sub block zeroing in iomap_dio_zero()
@@ -234,7 +234,7 @@ void iomap_dio_bio_end_io(struct bio *bio)
 {
 	struct iomap_dio *dio = bio->bi_private;
 	bool should_bounce = (dio->flags & IOMAP_DIO_BOUNCE);
-	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
+	bool should_dirty = (dio->flags & IOMAP_DIO_USER_BACKED);
 
 	if (bio->bi_status)
 		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
@@ -258,7 +258,7 @@ u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
 {
 	struct iomap_dio *dio = ioend->io_bio.bi_private;
 	bool should_bounce = (dio->flags & IOMAP_DIO_BOUNCE);
-	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
+	bool should_dirty = (dio->flags & IOMAP_DIO_USER_BACKED);
 	u32 vec_count = ioend->io_bio.bi_vcnt;
 
 	if (ioend->io_error)
@@ -385,7 +385,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 
 	if (dio->flags & IOMAP_DIO_WRITE)
 		task_io_account_write(ret);
-	else if ((dio->flags & IOMAP_DIO_DIRTY) &&
+	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
 		 !(dio->flags & IOMAP_DIO_BOUNCE))
 		bio_set_pages_dirty(bio);
 
@@ -688,7 +688,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_free_dio;
 
 		if (user_backed_iter(iter))
-			dio->flags |= IOMAP_DIO_DIRTY;
+			dio->flags |= IOMAP_DIO_USER_BACKED;
 
 		ret = kiocb_write_and_wait(iocb, iomi.len);
 		if (ret)
-- 
2.53.0

