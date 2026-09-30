Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6C4E50A7;
	Wed, 30 Sep 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778767; cv=none; b=TkXvBCmHyH2K60eQumEhAsUsVB6c3uJ2vC7PhfW8CxJQPKsp1ktVMspzk5JJ0yjvzoj81rxIgzqK843T4IxUHg5FTWeXu343hHs+QBsYAjykGTaOoN9XP3VIh2voc/nfGfokJla3gMzSDxvf8s2+YdW6ZnA+v95/lqfkD+DsX2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778767; c=relaxed/simple;
	bh=vzRnkfd6Bh23V2t9FkYG3oKkN1fe1gV1DgjJYGDDMpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m7gWmeQRnGz6B/4FSBH70+Ig1rO+QkK8oBxvK73vfu38Eblk4JsxxGHnG9QXq50X7BeYREJ9whWGb5HPugn3GfCxxmXClaygyuJvlQ7xh5V4vZP1MIcN2mRnZ10GjqKL3+YLLrbPrCJiWt6kaIwGJDmLIJLqX7nuzn/PAbpiTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=aYsXghDR; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aYsXghDR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=WNgWQ++5bvjPUMOSIdc7aHt8/9NgBV0Oam8GVheP5hI=; b=aYsXghDRM01lguKV1hs
	cihQGvJ/39qTCSyllg98yazpbSSnA5m9NSZPqs1DE2ZXKNqt172bLA/j2of5we85UKpQ1dFSg1m3P
	8G0zPruVXXcaGpa4rvsjTdQLDiU/XkFrxN9pq5fjJ9AszG5Cw5YnVOnaSWgZYzdmoK0+zcv4JzU4i
	x/c+z18onAaaN2KQCQ7Lr+rIcrfKkZjZZDEC47ozKOISsooVY7hSC4OdQZj5HTO8MAv2YslsM7Fxk
	TnuYfZwtfOhvhlXoqJhv4MOYt89LLrjF0+F9V7BdLKjvAKsRTufnpZyAijc6pgYngW/3iG6401LMr
	DAdGEzraEFIsVug==;
Received: from [130.117.225.5] (helo=dev010.ch-qa.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <vasileios.almpanis@virtuozzo.com>)
	id 1xBvJ5-006Oij-22;
	Wed, 30 Sep 2026 16:32:26 +0200
From: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Date: Wed, 30 Sep 2026 14:32:26 +0000
Subject: [PATCH] block: drop the cached plug time when blk_add_rq_to_plug()
 flushes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-blk-plug-ts-flush-v1-1-bf8ca7bc5cd6@virtuozzo.com>
X-B4-Tracking: v=1; b=H4sIAHkdvWoC/yXMQQqDMBBA0avIrDsQDYbqVaQLTUYdDSoZUwri3
 Y12+Rb/HyAUmATq7IBAXxZel4T8lYEd22UgZJcMhSqMqrTCzs+4+TjgLtj7KCNqU1pHldHKvSF
 1W6Cef8+z+fwtsZvI7vcIzvMCYOKO2XUAAAA=
X-Change-ID: 20260930-blk-plug-ts-flush-365cde9630d8
To: Jens Axboe <axboe@kernel.dk>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790778747; l=1605;
 i=vasileios.almpanis@virtuozzo.com; s=20260812; h=from:subject:message-id;
 bh=vzRnkfd6Bh23V2t9FkYG3oKkN1fe1gV1DgjJYGDDMpg=;
 b=GF1ifJykS3ZNBY7AJWDGuIVLusgEY0GGJDIT3zFsmPbyHJnrTCBqcRd2z66Zmr0nlnPrMyHBv
 JJGYiXg5ljDB2nrW64YEyqHhsku/cce9ldPTeCbvabbPzm3UXBrzvb8
X-Developer-Key: i=vasileios.almpanis@virtuozzo.com; a=ed25519;
 pk=HhuHDXAcPva9A8zccWEMRsb36reu+y4IVbBjXKxNUjw=

blk_time_get_ns() caches the current time in the task's plug. The idea
is that the cache lives for one plug and is dropped when the plug is
flushed. __blk_flush_plug() and finish_task_switch() do that.

blk_add_rq_to_plug() also flushes, when the plug has too many requests
or the last request is at least BLK_PLUG_FLUSH_SIZE. But it calls
blk_mq_flush_plug_list() directly and never drops the cached time. So
a task that keeps submitting without sleeping stamps every request
after that with the time first cached in the plug. start_time_ns and
io_start_time_ns are stale and the disk stats charge each request for
the whole time since the plug began.

Drop the cached time after the flush, same as __blk_flush_plug() does.

Fixes: da4c8c3d0975 ("block: cache current nsec time in struct blk_plug")
Cc: stable@vger.kernel.org
Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..7a37d9f1647d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1384,6 +1384,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 		   (!blk_queue_nomerges(rq->q) &&
 		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
 		blk_mq_flush_plug_list(plug, false);
+		blk_plug_invalidate_ts();
 		last = NULL;
 		trace_block_plug(rq->q);
 	}

---
base-commit: 551c722f40809618230001baccf219193e22fc5a
change-id: 20260930-blk-plug-ts-flush-365cde9630d8

-- 
Best regards, Vasileios Almpanis
Software Developer, Virtuozzo.

