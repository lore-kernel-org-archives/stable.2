Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046924;
	b=epZNqV2RaOR/46zh+9Ys7S5f0cWTtrrsFhjfWQ+MO1cscegW+fVMzkJ37OF4Q3vERWry
	 wHzNwh57506BzSgbheFJTvJkqB0FwI82zf7zdGCz/EFKQmbOHJFmMxhRlh0WghVbYSN52
	 eSYuhugDhxrSTG613+9Ez4OBCGwLvnMAaLS9yN7vdbtiI/57TcMG94kKrjLXb4y/b00IX
	 oYYubCJToez1lXEo7tigwJ0qJd9o9VbgCSRwaIhYNasBMoaNFvVHw5JCKj0qo1SHsjhot
	 Ge7WsXnOCjtwSs4ALbUH3nj6MxOIRo5FnUVE0IPpQ7+sJoSqiH+cV3kivtTnUcTQWPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046924;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IrdA1A1sJ6WW9XIHSjZx8ZWCBBXq+kJPwrw2mRcvJSM=;
	b=Bg4Z27oJfSNpgFWG6NR9a11MKqUOp23Bjg0yXlOSwkK20wq9nponOyrO2k0/SNkk11pl
	 qxzfGwvCN6kW8xz0Ojjm0jBB6zT6GMWlqPSEX9bLlzo9Y4zIQhC+/pv/CSINTzgBmApAf
	 RBkpLKRusKBRhFbqOJSpwtJQOvCEIfFFwD8msYOf7E/w2yqLMlt0AEhKwdN1l/4JsWPrw
	 y45b8AI/yPRcU/4uxzpp0RlUh7yh1Kxbln6i2TGWX4C5q/73Us0/5hMSFLNnFSCU73uA7
	 aRqbTSkk1ULKiuDozrXTiX/MI3agstmaysk/26Q9K2awulH512Z4F6REYhceAlQq5tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EhSTTkC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61767606D825
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhSTTkC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DBF1F0089F;
	Sat,  7 Nov 2026 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046924;
	bh=IrdA1A1sJ6WW9XIHSjZx8ZWCBBXq+kJPwrw2mRcvJSM=;
	h=From:To:Cc:Subject:Date;
	b=EhSTTkC/1yBZxmK8YBzNoEXy6prl/uqWLy770Izbosy+emPleOsEUKS8AOlio4q/V
	 HSTJBG2Y+CXDp4pswbqMEOl9dSoJDsKNQQbwQ7BL1ONDLDbJWfZlDYY0uYUQjN2Tdg
	 tQULHlk74aQLSkbjhvhk6c2JWxBODzQ21kVj7J1imBEVjD2VS0V6TVals6aQpOhv1S
	 XZkgJ8neR1SUZou6VlGrIcii+XCa5OvsDkrgz5Nyd5zfc4fs+atO32sROrbx9NeDiY
	 Jyt1ECt4C8sMUras42E0qYPRoHcHPcTxN50ofWnCf4w55E4WIjMjDcKhUF1jn/zRUt
	 2xJgcTysLjB+g==
From: Sasha Levin <sashal@kernel.org>
To: parri.andrea@gmail.com,
	djwong@kernel.org,
	p.raghav@samsung.com,
	hch@lst.de,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iomap: don't lose a failed direct I/O bio's error when zeroing the tail" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:02 -0500
Message-ID: <20261107052202-failed-6.12-a9fd24bcbe69@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a9fd24bcbe690ed4a5b8ea6a7516fa297fae9360
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052202-failed-6.12-a9fd24bcbe69@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a9fd24bcbe690ed4a5b8ea6a7516fa297fae9360 Mon Sep 17 00:00:00 2001
From: Andrea Parri <parri.andrea@gmail.com>
Date: Mon, 28 Sep 2026 10:48:09 +0200
Subject: [PATCH] iomap: don't lose a failed direct I/O bio's error when
 zeroing the tail

iomap_dio_bio_iter() falls through to the sub-block tail zeroing when
the data bio submission fails, so that the rest of the block is still
zeroed and stale data is not exposed.  The zeroing result was assigned
to ret, which overwrote the submission error with the successful
zeroing result (zero) and the failed write was reported as success.

iomap_dio_zero() can only return an error from a can't-happen
WARN_ON_ONCE() (nr_vecs exceeding BIO_MAX_VECS, which the existing
comment there says "shall never be reached" for any in-tree
filesystem), so it isn't a real runtime failure worth reporting to
userspace, let alone one worth losing the actual submission error for.
Make iomap_dio_zero() return void and drop the error handling at both
call sites instead of threading the result through a separate
variable.

Fixes: 10553a91652d ("iomap: fix iomap_dio_zero() for fs bs > system page size")
Cc: stable@vger.kernel.org # v6.12
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Link: https://patch.msgid.link/0cbce1012f5333690be36a9adafb3e190fe2ca77.1790342457.git.parri.andrea@gmail.com
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/iomap/direct-io.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 0e8d7ddf4e511..b54540391cdec 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -304,7 +304,7 @@ u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
 	return vec_count;
 }
 
-static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
+static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		loff_t pos, unsigned len)
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
@@ -313,14 +313,14 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	int nr_vecs = max(1, i_blocksize(inode) / folio_size(zero_folio));
 
 	if (!len)
-		return 0;
+		return;
 
 	/*
 	 * This limit shall never be reached as most filesystems have a
 	 * maximum blocksize of 64k.
 	 */
 	if (WARN_ON_ONCE(nr_vecs > BIO_MAX_VECS))
-		return -EINVAL;
+		return;
 
 	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs,
 				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
@@ -336,8 +336,6 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		len -= io_len;
 	}
 	iomap_dio_submit_bio(iter, dio, bio, pos);
-
-	return 0;
 }
 
 static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
@@ -541,10 +539,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
 		pad = pos & (fs_block_size - 1);
-
-		ret = iomap_dio_zero(iter, dio, pos - pad, pad);
-		if (ret)
-			goto out;
+		iomap_dio_zero(iter, dio, pos - pad, pad);
 	}
 
 	do {
@@ -582,8 +577,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		/* zero out from the end of the write to the end of the block */
 		pad = pos & (fs_block_size - 1);
 		if (pad)
-			ret = iomap_dio_zero(iter, dio, pos,
-					     fs_block_size - pad);
+			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
 	}
 out:
 	/* Undo iter limitation to current extent */
-- 
2.53.0




