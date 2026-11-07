Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046264;
	b=b3INupxfdtE8tDdkzmJjmCkvRELyDO//4kKmNNAwh54E3lmMcyVOYohEvbGkg5EzV7u+
	 ma6khOuvAt21q9EHHiTcTT588i1qQrKJoW9JQQzAXr3ccEMG4Qg+6tUE0YgbxtqtwYZOn
	 CYIMjJAV4vAm4rlsxDIg6guKNWHRdXPAWDW+VXHOx5pjUniHa5cZVGi8OJ2mKTYXX2hzr
	 dKVqcgQPG+lAvrWcbnl+qDg4iQzIKGH7gUZDuI/l9ZNff6GQbCqhyMPy1JKzbFv2t6mja
	 zGnz3UqutCf+QaDYX5yAv7FtkAStizKgSp+affbE+yp/G0D+ARbLFeI5kPuy/V8kvLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046264;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+fNZO+6wR17shDQUVz5pqyd05jnDYkwmzEm4EnS1854=;
	b=J2fn+0aUP1/fhE0pvTbZJfR9POOFZziM6Q+IAerJQr0q2VhaOMEIovIhUtom8pi5Qy3h
	 jV046ZhQkG2Y2obXkAxbcyqA9LB+hdO4u6w/IvyJ+Xu0gpuesvicsqKH+0NVa45dhgiMg
	 0AzaNzSxgr28bIEPgRnj9Cm4pH5Vn+ZASdmWvRqScu/KCIQJbOdoBdkYszSbSIF9lPyod
	 gLDAn8+J9qB1y58c3k6dtgXLwIQVLMTqS04HR2B4yGfF0DUTEeqMNHqzt4h7mv5o2MqSI
	 zCgg5NgxybKOKq+86TFUTnpzLXsVgm7+U5zT7y4lAtYm/KYwlXjhWAaVSMOfQoexhxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0caB4m4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0caB4m4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA57F1F008A1;
	Sat,  7 Nov 2026 10:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046264;
	bh=+fNZO+6wR17shDQUVz5pqyd05jnDYkwmzEm4EnS1854=;
	h=From:To:Cc:Subject:Date;
	b=Q0caB4m4plymBiT9LcNlkY/XP/VxaH9G2H1m6ndpF8Xm4I41QnYkXB4HlONpCqJa0
	 5poGuy+DUbN60agsBZhPlEQIh0n13ZBxmrwsbzLVxUBLomNhTY6fcf8Vei7foPQ+zq
	 YR2N92k77SXr/ODw1vF69agEzCGPT9iRT2dlAbUK3hx7L5PgS0lfC/ESJYC74CAHJ1
	 8o3kUVP+YDOBBhw1MuIaqRjoSFzuPAE/oquJXqB+q0KnmL410NWS6cPTYPAQjm8lTG
	 IIpNG7i217+/lkhJi15C15Ul8yfzWG7Zmm2Romgal/otLCuNRiQYI5r65c2ftFgrkN
	 DNV7gjZXENdqg==
From: Sasha Levin <sashal@kernel.org>
To: parri.andrea@gmail.com,
	djwong@kernel.org,
	p.raghav@samsung.com,
	hch@lst.de,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iomap: don't lose a failed direct I/O bio's error when zeroing the tail" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:02 -0500
Message-ID: <20261107051102-failed-6.18-a9fd24bcbe69@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a9fd24bcbe690ed4a5b8ea6a7516fa297fae9360
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051102-failed-6.18-a9fd24bcbe69@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




