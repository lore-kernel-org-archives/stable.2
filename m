Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348979;
	b=tZ4Y5pg/bkjSWgUrkk8TVfpmOZbj2tc0Pv++ON0kS9Y5caMPxldCqyiu9nRFuDPqdP7D
	 fmhIYhOKwWmB3cqoBXFz6Kvx1/ghWrmPfOSsqAoTTeu8DSoRtLsQxiD6mifCA2RIlZkqR
	 SQzly2tTGUdeh+JB7jTkfaNzVXaMn7LaOauhwBkrTVTSWX2XxmhSAzpqRr0ivJPVpzzes
	 Uv/LQcHflGrWmXxrR6mYtBvbfLrua0/vY7BXqhMH8PGVFGvJuBxRljmKAFHjsuI+K8BjL
	 B73zieuOqVFkH2hNRV76KoahM5LCF6aT/RER7KF61II4r6okQOj6EpO1UFKWEvnkFQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348979;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oflyRcO2v6ZEH9eKPkss7UaWg/xiokjk1e9kn72nSy4=;
	b=aAHcM0Bn56fIZVsre3oOiLP/8nWzgLm8WC9FVDpqPq8eg0l8XYYl+2+GbKjFZH9VoAfB
	 JmrBBOhwtmqiMwoPKiEtE45+qsu+bGEC0Nf7nnsKpmI5QyDWeRd1hKAr96QozMINkIxsa
	 JiOFZaODsGM1aWSKQFKmpf+k/un09ROoGgjLz7Vry+sBctksRdRFVzQeqEGurPNic0KmO
	 wibogtQPvypeAZZ47GmFJEdHBV3hFdrH0dPzyhm8imi1QVrxhPe6y/HitfD52E/PbwlF4
	 ddM2dfo4XTX+XM8bujzKzmhqpYQlhX2ggbI75uCSVxWcW+QaxXwbBQV3HEnjudc+JTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cov3rlo1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301E606A31C;
	Tue, 10 Nov 2026 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cov3rlo1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F061F008A2;
	Tue, 10 Nov 2026 22:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348979;
	bh=oflyRcO2v6ZEH9eKPkss7UaWg/xiokjk1e9kn72nSy4=;
	h=From:To:Cc:Subject:Date;
	b=cov3rlo1xVWSlL1pFNWaMuA6OyQGlbzjqWlS7i1PYhHaap3I2X3XesJZtUGjZ5GP5
	 VzcE3QWWwZ/3ZU06r9W63Eu5Zbwarq7AG7bYQvRKPyW1Qht2q3tSHq3LAgs/pKCpEt
	 GMa87Gk48NbYhXDlcZ+VKZa/gcfaIys9ijEpa3frszTgvfP9+3MjLBnrSmcTg7vVPS
	 E5mSGhl47hfg2fz+co/X7q2aaNzdvBC2XG06tD7MQdipnQdF2SLKZwTEA/tZYRUddq
	 XD9PC24BRqiTs6D6f19TyWSx6HiSymmwkDqh0993C3wsoQVhvu5QFJhKeWWtMPe+m7
	 tstT0lix0nYzA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6] blk-mq: end the request if getting a keyslot fails
Date: Tue, 10 Nov 2026 14:15:46 -0800
Message-ID: <20261110221546.46165-1-ebiggers@kernel.org>
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
[ Backport to 6.6.y: dropped the part related to
  bio_zone_write_plugging(), which doesn't exist on this branch. ]
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 block/blk-mq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3fb9222c5ee0..130f4fea9f9c2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3069,9 +3069,7 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
-		bio->bi_status = ret;
-		bio_endio(bio);
-		blk_mq_free_request(rq);
+		blk_mq_end_request(rq, ret);
 		return;
 	}
 

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.56.0

