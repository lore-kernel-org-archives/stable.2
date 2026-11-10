Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272913;
	b=RI4u4lVfpuA/XT9IdUAvcjqbgkAjyR+6qd3OGgzOEzPWzsF+pp2kfE7yZqO6OcAJbPkD
	 GbirxlkEXBDlpu8Acs+JeALQQrtRtX0Y8ouQBLSAuqQR3BnZ/wXMTo2tV/r7FSR41ygUd
	 VA4Xm6s7M472VH+0gWypCzcz4ACEqu9+1DM6ayziMEb34ofaxhMkCfM0i3mhXEtGli1Ru
	 oa9/OoTmtCCFybrH8ed6HEdex7ls8NX29cg6Le8Jok3rSoOyUoB/TNs9PApc9wiJoABZg
	 ZMJDQd1CGfcf32xPt8xj62/htmNpnr8AwPorffI5MJzQrbrr8NlLudqMAd7RnnGrlSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272913;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MWRKr4nzDldi8z7hxmNzG3wGoOFDcoV5YnkJTyNuGew=;
	b=Ace2JX9GdZsODtysTLgMDthfcGjmkHo4Z72URdr4dgxsXrNzv4ehI7svM7dwFbjICcMj
	 dmQHjLXe0FSYesatEbxvWYub2sswiESeyNyhQCYwBSw1iRcGs1XZO0k9xlUD7iE1OlhGf
	 CQ3LguGvhMc+UI4bFezJIrDQF45QTTPXCTxMSFHoIwjdKkJ6gSXZAGB5ZoF730nVpdncU
	 V00cpJARy0burEzI6HnATTzO7HWn4uk14rbEo9bC0D9g28nielbHJIYqdF6TwB8QqeGfk
	 WdH7ERMDShOOtVAiWjtUQv9N60r8jxwZeod/6ZLLbpgSj1ZWQHPlkzYkz8fFY2/pJ/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lU8FiFHV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE6606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lU8FiFHV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D061F0089F;
	Tue, 10 Nov 2026 01:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272912;
	bh=MWRKr4nzDldi8z7hxmNzG3wGoOFDcoV5YnkJTyNuGew=;
	h=From:To:Cc:Subject:Date;
	b=lU8FiFHVDm5iIwR6Hv5/PMaQgpfyvQUzmVReXmwa8vWlwEM9DmYxcMNMJR6Cqt4Wd
	 WFFeD6p9vLFlgih/pdIMotXTRG+f5yr92GAuhC4V1quTzUXwkD1ekEPnDnJ7MtZYub
	 h/Opz+MJsutXBO/XOyaOov8olaJsQTnNbK4E7LDvY4r/8bJ1zgA3gVX+SiwJqoSBbx
	 +dw36UYiJXTgUGQoMgZ9P2ihFMAoqPWAPFGKnX2j0j+faI2REV6LihsXwVFTWBxQBP
	 hxqez9ABQWm6TTVwrst8tB0dPvt9L62Fi2Tn3rBu4fX2Rnq06A4LIS48VCdzgXUDmQ
	 7yPmNmjPAPdOQ==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	ebiggers@kernel.org,
	hch@lst.de,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] blk-mq: end the request if getting a keyslot fails" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:08:31 -0500
Message-ID: <20261109200831-failed-6.12-e67cb6ed40e7@kernel.org>
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
git cherry-pick -x e67cb6ed40e7f45912b63d7d575f18dfd2ebc98a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200831-failed-6.12-e67cb6ed40e7@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




