Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC255930F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874400; cv=none; b=W/w5PEs6FUMq18Rv1CZmn2jDOJf/4O1+emdzkAOovBOh2GteFDwoE/fZC5p/2ZRSD9Ntea6y667jvgcTPBI7JKa1iK3fNOiMkPN3NJ2qFeeQ6LSiafC3e/f3NLMPL4x15v5gEYgwTd6vMIdneCxGJeduwxcWsGzm7uS8r3wuMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874400; c=relaxed/simple;
	bh=P2wA/MJLazhX0Rkrmy0VkFONyBY+XVc6UrHTkTswFRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqoYtaF/iko95Br4XVzHqBlQ38EUlT2ITiVE5W3adFLLSaePHADWtmrT1iksARtRtI4jTdhSjn5tMcpOsCooMY4nKMpRnDxlzj4daYA453aIu8FyZRJhb3A7Zhu55EFEFvC3YtQGZ90Z2GDe1bp1e6MWMfnjMXHW+Jdx9Zv2ezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0CE1F0155A;
	Tue,  8 Sep 2026 13:33:05 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?=E8=83=A1=E8=BF=9E=E5=8B=A4?= <hulianqin@vivo.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] block: set QUEUE_FLAG_DYING unconditionally in blk_mark_disk_dead()
Date: Tue,  8 Sep 2026 09:32:59 -0400
Message-ID: <20260908133259.2325197-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908133259.2325197-1-sashal@kernel.org>
References: <2026090327-engross-lapped-120b@gregkh>
 <20260908133259.2325197-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 胡连勤 <hulianqin@vivo.com>

[ Upstream commit 7e9a46004b471eaf69b082c473d865316a4158e0 ]

Disks created via blk_mq_alloc_disk_for_queue() (e.g. SCSI SD disks)
do not have GD_OWNS_QUEUE set.  Currently __blk_mark_disk_dead() only
sets QUEUE_FLAG_DYING when GD_OWNS_QUEUE is set, so for such disks
blk_queue_enter() and __bio_queue_enter() cannot detect the dying
state via blk_queue_dying() and remain blocked waiting for I/O that
will never complete after surprise removal.

blk_mark_disk_dead() is the explicit "surprise removal" API -- the
caller has already decided the disk is dead.  Setting QUEUE_FLAG_DYING
unconditionally here is appropriate: any in-flight I/O from other
threads should get -ENODEV immediately from blk_queue_enter()
regardless of GD_OWNS_QUEUE ownership.

For disks that already have GD_OWNS_QUEUE set, __blk_mark_disk_dead()
will set the flag again which is harmless.

Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/PUZPR06MB62247E82E66A3ED46CC3E6C7D2DC2@PUZPR06MB6224.apcprd06.prod.outlook.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ adapted the newer helper-based implementation to the existing 6.1 function body. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/genhd.c b/block/genhd.c
index c058a01c1b3a1..753dfa846e3ea 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -585,6 +585,7 @@ EXPORT_SYMBOL(device_add_disk);
  */
 void blk_mark_disk_dead(struct gendisk *disk)
 {
+	blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
 	set_bit(GD_DEAD, &disk->state);
 	blk_queue_start_drain(disk->queue);
 }
-- 
2.53.0

