Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273184;
	b=44K5qB408n2vdtc32vKG1jZnINRzt1mWtjOAC8AcFhWHWXUZ3Tr4u3O682V2ZEwlv7YU
	 UaxTu77YVcUdgHIIZdQg7yCUcdEh+IBQwL9erQdbD1lcrQm2zokeMmkQu4U57p7TeWnTV
	 6mum/RolSbwH4Yfixfx3hdOl5pBnStkHGSw3UwKK/2d2q0GFAsiXS+UAXQUbpZN/yw8kB
	 g32DUSBus+G2tl28rCqHZ4CAJ4S/9IYo9gLoceE+7PeQ/vv9dy0TwW1CJk3G4jisb96/Y
	 wfTQMlL8l7Wu9rU4fg3Im+8eLtZZb0YTXxn5noW1tSP6O1jZ+ay8Y84D7TlR41+rrXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273184;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e/PPq9g/i/i7ppXwqYgdQoC8BIemdoPd8U0QFhYvF4g=;
	b=K78RZi6ULTnmWEQ8cdU2Q+LeAh4b4YKLa6OtwwIK6kNJldObmXoCjyPKkss1uiW9eC37
	 pKSpYCgm0PdID/E7OJSJxI48lejFyqBaPdvXwp0WO0mxtcQBNlh2bz2mZnGzQUvMA/R+W
	 7DBZKaFqgs+bgiqixWso1iBfnOoCk9qc4SZJXCTMltbs1fGvWx/mFiFVrS23RmL9PycnI
	 H3aXgABvUAc3EG2OR56PW+Bwi3VujOng53ExkjEXyWvJZkiIXYB1hnfkZMLY7qo96HekO
	 fuRk+BHtFCDnRyBJwjKh51WZxStWzng0CWpWT2UFuqq/jrFglnDIh49fZtVEEIpVajw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ti1bPaFk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195DB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ti1bPaFk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538D71F0089F;
	Tue, 10 Nov 2026 01:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273183;
	bh=e/PPq9g/i/i7ppXwqYgdQoC8BIemdoPd8U0QFhYvF4g=;
	h=From:To:Cc:Subject:Date;
	b=Ti1bPaFkmHQnWbVa9gXOGIPhYN6e8rZn4Zw+/bmtgWXnyjeQji6/i68u6nWgiTJTD
	 nAu/ch255uZMCJ2/9hEfDsl9BMmxwuY2m+dQK6cgCcNkMQL5T34T2CgOYl0xhIfZW4
	 47hSmpoZV0AsUrevTVbx+3Z6l02OPDb6vuoTHgISXLzGtwPH3SfV0pSJSqXKVkYUlp
	 0IPO34ztRt+ZDmmHvHUqPfHM0YPAqC222kk1GghvTXP8qPBtBCfZAfMtox03Dl44d4
	 GEjcijLn9n17zDJ5SaEaHn6H/Jb2WyFgcrS8JcShTwostBhlZ4e2N9WwNC0WsL36yc
	 A6hh5h5ehO2lg==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	ebiggers@kernel.org,
	hch@lst.de,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] blk-mq: end the request if getting a keyslot fails" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:02 -0500
Message-ID: <20261109201302-failed-6.6-e67cb6ed40e7@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e67cb6ed40e7f45912b63d7d575f18dfd2ebc98a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201302-failed-6.6-e67cb6ed40e7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e67cb6ed40e7f45912b63d7d575f18dfd2ebc98a Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 29 Oct 2026 20:01:10 +0000
Subject: [PATCH] blk-mq: end the request if getting a keyslot fails

When blk_crypto_rq_get_keyslot() fails, blk_mq_submit_bio() ends the bio
by hand and frees the request. By then blk_mq_bio_to_request() has done
the IO accounting, which blk_mq_free_request() doesn't undo, so the
in_flight counter never drops and iostat shows a device that is 100%
busy. If the bio went through zone write plugging the zone stays plugged
as well, and every later write to it waits forever.

Use blk_mq_end_request() like the dispatch path does for a request the
driver rejected, after marking it for zone write plugging.

Move the call to blk_zone_write_plug_init_request() before
blk_crypto_rq_get_keyslot() so that it doesn't need to be duplicated.
It doesn't depend on the keyslot.

Fixes: 99dc422335d8 ("block: support to account io_ticks precisely")
Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20261029200110.1328103-1-ebiggers@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d9ab295be4d92..e5b9898cede98 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3209,16 +3209,15 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
+	if (bio_zone_write_plugging(bio))
+		blk_zone_write_plug_init_request(rq);
+
 	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
-		bio_endio_status(bio, ret);
-		blk_mq_free_request(rq);
+		blk_mq_end_request(rq, ret);
 		return;
 	}
 
-	if (bio_zone_write_plugging(bio))
-		blk_zone_write_plug_init_request(rq);
-
 	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
 		return;
 
-- 
2.53.0




