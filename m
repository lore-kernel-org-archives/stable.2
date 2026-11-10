Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349086;
	b=rGkVAzuraZBETMn/q2jNVNFmXEqJb3d65QD1BbnZ95lxFKXOzdTEp6X16omv5OaGTqPu
	 zM6yijAZ47af43d0bWTikm2X8jzJUi9DsDlCHikLQTRwXZjFhZheP17DyWKhwce/SrGFp
	 WftwCmEiF0i9CA54evqI6oSC3JwMHPH4HcgdmqBYYoYqNJuii+F9hQ1sVYfjSiIEmCZis
	 /7ImSNbw3XW733P/DRHDd7CcPXgx/Ge/A6MUc2Lq0duKuBq0686b2W5zPOyZUDaFWKTHU
	 Wfa8Lo0vu54WyzJ7C4n2csh3AEb5AeMWZj48F3urm3aA4ekdG/ayknAZOAZv3Bli4Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NHhP4xJkQwMEfsD9tU/7b9nUzi1hvFrNDI+uwR1r2jM=;
	b=Ci3JR+P4F2l2VQ9fhWpg5TQBU8h1Nge5c3cANwIpFo2a76uoh8NNYfxeDq4uHO/SBpwv
	 h/MBiswweVGqtYvnt+8RnXJlNFEIwK+kPr6T4VVO53YMa5aAMj0wxE4qFLasKKB7mjiGv
	 IaiYDw1B+tVbCGK5FrR3qB/+SNMDZrPbgDmTQK81N3ljhopw0KHeoeaIFhdTbhfCXhzdS
	 0wItQyjLeYV94/PCz02tHVt7WQOXjWHdUtx7Ud1THJqakn6vRhIuhOh0BbgoY2jTLZUpH
	 nZ8XghQRkvrPeaMRJfyN5o2bC4tOaZR1iQQsAacLN12FezZwLhBOj2TZnyDHgJ3TYIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9UpMRvo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D19606A326;
	Tue, 10 Nov 2026 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9UpMRvo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CDF1F008A2;
	Tue, 10 Nov 2026 22:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349085;
	bh=NHhP4xJkQwMEfsD9tU/7b9nUzi1hvFrNDI+uwR1r2jM=;
	h=From:To:Cc:Subject:Date;
	b=N9UpMRvohbZSGM+1tcCCLQAtrRX7dSp9HD3jqU5otfCD2HYv6xyCgrr6o9++uza5r
	 5og+6V0dISaFXtV+1G5kgeEP//NqKKCB39J4RdXEfdqGLBeTGJ21Xyy583zoBAidFN
	 AoEFGf72LOT788v46+wjfOt64W4C86AvuGPiGajpJfhj/uM5t+Zxm+xKtq823v8p+V
	 eS7xRH8BinS69XVjoCGajJxyJ1T5mVK7khzhCBuWvnjKKTweq3FSdHU2CKrennIn4S
	 XdBDsRO5S0eKPjWv0msMiZj9dobnhtxCbkehlCPw4KazSgK2GjUlunyT/vd2qk1ZJs
	 38jb3mnoQxaoA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1] blk-mq: end the request if getting a keyslot fails
Date: Tue, 10 Nov 2026 14:17:48 -0800
Message-ID: <20261110221748.54448-1-ebiggers@kernel.org>
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
[ Backport to 6.1.y: dropped the part related to
  bio_zone_write_plugging(), which doesn't exist on this branch. ]
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 block/blk-mq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bc619519dd665..9722b0afdcee3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3030,9 +3030,7 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
-		bio->bi_status = ret;
-		bio_endio(bio);
-		blk_mq_free_request(rq);
+		blk_mq_end_request(rq, ret);
 		return;
 	}
 

base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
-- 
2.56.0

