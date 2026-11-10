Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348460;
	b=oxcuxJrun8LGW4euMJFZuSvnU4IcDOWwjES5EdbbR/1qI9spNl3w6jsYLSGpBFX3fFVP
	 0+w5+7LyEi1nDlD54D+udy8+0EWuY0PelJh/S+3ksVdJh58J3DT6k/XJn4KvaNYjDAVBO
	 9ytj8xLv4TWRlvfX+kVcx4A/h9DF7UapGy4B5act26To04r0V0792ApDfDrcu1f3bWcYB
	 MUoH359lOwsV3XitsjJwJ39GstnGfdH4d+PYcJbZvaS5Abv7FhsxDbYeRPBQWWmIi8AH5
	 LDnQcqNxjwAxCLm2i0zeyUXjVX7unQP0iMUoms++UU5N/CaGMmzecxWX/gYXsOHngsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348460;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=O024VvLDBmvri6Dz/qYYw8XQLV0yXweu0O6a6WH8e98=;
	b=MNT6bO4WyrB51vUtcxT1egSpwEkSPnxEu9wRWeefDKBozNqCO8VnO7DvEEUqChYkcq0D
	 96JelZ2vyg9nuvEyXj/lXZpITftiJTYEmvT5bO2qrWrpjTcjuusZk7AOrorYHiRj2Fxw2
	 X7cKbNy0Nbn00oPHgyqslQe4C2H+0y32cPXF7yejZ4i0cVhCmdHPhBgYzDu481lXCaDiq
	 3Vlar+0wlRoNRMJjY+J0XJqhZbgSd4m3NQnN7rFr9upsIU5NhvqsPKKy0C1XnRwoVD0Xd
	 8Rj1qTaA7tEagOkxesq0OUQTpuxcJXELYwmrTYYG47YRRdAMrSrrC+wAkNkbJ5MvOzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1xZJyTO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16860606A330;
	Tue, 10 Nov 2026 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1xZJyTO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5134B1F0089F;
	Tue, 10 Nov 2026 22:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348459;
	bh=O024VvLDBmvri6Dz/qYYw8XQLV0yXweu0O6a6WH8e98=;
	h=From:To:Cc:Subject:Date;
	b=I1xZJyTOLxaRnscHm+AOQvZu9gx0xtPZxtL6+0Q89rXWmKPjEQ73DSA5ta909WRLn
	 I5tqPS61DtN8ogA2IGyEnIF1mo/+N+JnmL+fLRp7jnK24XXRSiSfPHNOx7gIsZxIxd
	 cDlZy27q2oNSERrDiJGxpGn9gpEqAqCMizy7uSC+KQ+mTJd7A0GwSjkNJkCsSP6zC0
	 I9dTiBcIVNJOuWlKFsMWzS8nQt9Zo062LIXXm1e2IkZDvr+mref731B0dhsdFXE48s
	 +wf6GkMAanbSQYb0LuEw0l5kgWOhJY0F65qJkEpC2Uk7U7yu6AqQPaW2O8KPXflY1+
	 Zh3je+HOVWqqw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12] blk-mq: end the request if getting a keyslot fails
Date: Tue, 10 Nov 2026 14:07:26 -0800
Message-ID: <20261110220726.41659-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
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

From: Josef Bacik <josef@toxicpanda.com>

commit e67cb6ed40e7f45912b63d7d575f18dfd2ebc98a upstream.

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
 block/blk-mq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e01437e64c740..c5be2e8578a7b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3122,17 +3122,15 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
+	if (bio_zone_write_plugging(bio))
+		blk_zone_write_plug_init_request(rq);
+
 	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
-		bio->bi_status = ret;
-		bio_endio(bio);
-		blk_mq_free_request(rq);
+		blk_mq_end_request(rq, ret);
 		return;
 	}
 
-	if (bio_zone_write_plugging(bio))
-		blk_zone_write_plug_init_request(rq);
-
 	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
 		return;
 

base-commit: d3417611a3b40b7f04a29e558cebac2bf69889d7
-- 
2.56.0

