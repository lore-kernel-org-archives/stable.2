Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304120;
	b=iGV3npxy7LfdPAXq5XHb1m3sqDbep9/zjoy6J7amSbTPofbi2dFDua9dETT42kO3It0b
	 +/5qmM7sG6cqY3vcRKiqUJaeGBKMHVscm6Z3hCzMrmvgNVs6BZ0sU8bAgPc0CFZqiLB0v
	 sjtC4ycfilDl8sA1aTPnIjsbuPPay8bv13TMOoNpdJA2WEPx6eKYK70coux1LpxQ31M0O
	 alhSV0eCAdoS4mcVPqKrWeVUdbrkziJLxESyZBlRpzTSGaq+grRXxjm6QfrcxHp9Y64x/
	 Hgzbc3kfbus2qcoNCkYwEBghv3OY26hye2iBKYaQtbVjQ5kaoYN30033WyjAv3NUTWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304120;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KWw4RyYICR/RfZi8mqYAl1NLHPBDm5L4/g2llgJ6ExA=;
	b=pFCx/ey0cKKk1epJqGVOJlZluIW/NyyphxlNqwuyxgZ3j4wGI0t4G9X7vYPd1QL9KYhK
	 lSkK5CAjerMP/Mgl8NA7KM/D0D1jvd8K7zlJfMEJ6Sr9t2lyBrjw5lAJNRrZBOOp3laMQ
	 Fz3LEgWFZszkZzmc5M8CBsVEHhvqa7hZjd+2hxhSI0z1yIH6UOcH/cU0gOuWRduWosQw1
	 E4Okp1xLu2JVH97yV6ORr5yO3tKoo0B7hAPnzIUveJXe+cHD+r0bYZQTykXqkaMg82DUb
	 rsvgZ2T/6hoqKHbkQzw90tAk9zlVeFq93hqDHcXrX42VQHc3Ba8qJfnCpmHMmeuoySg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xvr4zru6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C34606A31A;
	Thu, 29 Oct 2026 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xvr4zru6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7301F01816;
	Thu, 29 Oct 2026 20:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304120;
	bh=KWw4RyYICR/RfZi8mqYAl1NLHPBDm5L4/g2llgJ6ExA=;
	h=From:To:Cc:Subject:Date;
	b=Xvr4zru6MwItKPIQtOYOiN/oPHO90VhfEwROykZ3Ykrr0ti7haVdFHjUhJwTYs5m+
	 1d0sNHoScqZ0dhC1Ic6VCs/YLwtPd3UQfHsjLb4DryaqNUhuK91GhPIsiwvsubZp7C
	 MVRAw0XzD9iPnUCPkjI1Zv5tkqscRWwNVr5ulDrfj4U1gRNC0vOKL/QdkTDH4WG59C
	 upndLTmQxWV0J5pXF1U4aOZpJ8W4s01AgRIlV4Qqz/xEoB00SbCM3oGTUIjVSIIoio
	 h9c9STVd9vpo/36F3neSfwK2z67VFQX6iVIDGGFjHZNiTIG/b5HbXEo3Xp1i6JF91M
	 XCrcTHkB1qQaw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2] blk-mq: end the request if getting a keyslot fails
Date: Thu, 29 Oct 2026 20:01:10 +0000
Message-ID: <20261029200110.1328103-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
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
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

v2:
  - Moved the call to blk_zone_write_plug_init_request()
  - Updated Fixes to list the commits that actually introduced the bugs
  - Added Cc stable
  - Sent as standalone patch

 block/blk-mq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8d687b338d6d7..379c679b04138 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3199,16 +3199,15 @@ void blk_mq_submit_bio(struct bio *bio)
 
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
 

base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
-- 
2.56.0.317.g454f8302e1-goog

