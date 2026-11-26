Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670024;
	b=OnIOuLQZtpzBWFJoh1gmjVcdfIh3J/X6czc7zVQFEEOd9A2IsaxUQd77G1MkCXig0XEq
	 rbz9BhNZ0csLtFv4fwWMG166PS85+MrdBJsxhk64t6ACTEdaTHeiTHsHoHxkNiTzxXoem
	 p12o4gj9iqf545IVdQ6DE6dCxg2GWm4z99cIHaJgZU8Si288ebukx7XQisNVIrwMAFzjn
	 QR+H/F+hGeyeRyLKIrhuZpiSKaJ1iG28Ee9X/fECOq5SeBEkTiXUvvzfg4zNMe20wILGD
	 bXXJyKgc9FzMAHYjNuoVv4yNm8rIyZTqbFWBh+KsPQPoVHYTOov0QgxW0CddEIVEnHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670024;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MxS3ASGMYvWkGwcByfyvx/CZhuVzKc8h9mlkYYlcfSw=;
	b=lJ4Ht5shbcWD1u4NP9AYna4u9pqy+DzD6LhtSDTBYj3g/V/q0RGb1Sznx/AaIjt0ALvn
	 fuaAsyHRCvEvc5o2StwxY+A5MCbaDQTTQBwQBcB9s78sSH3o7CHXTRysfwPWQpMTM51JW
	 nTiqB2i0i22sM0qBOc+M2sC2EejG7eNq92xSNRyVD5uOaeUIgUt5ZlmZ1RZRq77Wdge+g
	 JyP18GeJkwydamj5SX80uvfSEPWyJgGBwFcyFRG3sZOpN5Grdq3bl1EKXjytjQ/C3Hhg3
	 cQJ/718rmjAzg6y8b7/RkL9G30IQvJFmIWCj7GKPsjTDPn5yJ8FVkT+/YhZ7uUhetnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWDeoXbZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C7606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWDeoXbZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2A91F000C6;
	Thu, 26 Nov 2026 05:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795670024;
	bh=MxS3ASGMYvWkGwcByfyvx/CZhuVzKc8h9mlkYYlcfSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aWDeoXbZqh1o/d77bvUf/bgho+arAcgr//Nmn5IyiNQ1NJamhFD8YZFnNmuftdK+C
	 ai7ginUwcq0eXFauPBqApwQ0u5KQFmx4lWPYQ6Ta/aIY2UCLCYvkz2L5VbvsyeCPEl
	 9PutnibA5HafzZBruNNZlCxqhiA5aWsKfQ3SFEi0+y7l27JD1z9tl66V4EB/RPEqdQ
	 2bfPRvYo7Y6+RnfHSxg6Dotzgp40E8+i7QvId5aczldiUi+DpSZ7BK1aA2yvTIIT3L
	 KSpC6tBItw2NQv+zlfPZE6zvLv58iADTZQe09+HfYICpBaygavtm0yAOvj4LVTbA8I
	 3ldmrdh3IWUtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Tejun Heo <tj@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm: fail a REQ_PREFLUSH bio with data when its preflush fails
Date: Thu, 26 Nov 2026 00:13:42 -0500
Message-ID: <20261126051332.2129618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-confetti-saloon-c0b5@gregkh>
References: <2026112517-confetti-saloon-c0b5@gregkh>
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

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit e92cd41e8e5ee5616c6c7cd4378661d942f0a7c0 ]

For a bio with REQ_PREFLUSH and data, dm core may send an empty flush
first. If the flush fails, __dm_io_complete() still reissues the bio
without REQ_PREFLUSH and drops the error. When that write succeeds,
the XFS log keeps running and fsync() can return 0.

End the bio with the flush error instead of writing the data, as
blk-mq does.

Fixes: 6a8736d10cb4 ("dm: relax ordering of bio-based flush implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ sashal: Changed the reissue condition to use bio_is_flush_with_data(bio) && !io_error inside dm_io_dec_pending(), since the upstream __dm_io_complete() and requeue_flush_with_data don't exist here. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 820af6e250f49..47c7ed0048d93 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -853,7 +853,7 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 		if (io_error == BLK_STS_DM_REQUEUE)
 			return;
 
-		if (bio_is_flush_with_data(bio)) {
+		if (bio_is_flush_with_data(bio) && !io_error) {
 			/*
 			 * Preflush done for flush with data, reissue
 			 * without REQ_PREFLUSH.
@@ -861,7 +861,7 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 			bio->bi_opf &= ~REQ_PREFLUSH;
 			queue_io(md, bio);
 		} else {
-			/* done with normal IO or empty flush */
+			/* done with normal IO, empty flush or failed preflush */
 			if (io_error)
 				bio->bi_status = io_error;
 			bio_endio(bio);
-- 
2.53.0

