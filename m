Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358650;
	b=kV5m6af4vITkWidnDpJH8I4LJfTlj/fngrYS8wUoF76dQb2H8EvYkhsVLL3Ja6+AQbUO
	 sxRq9ueAC7Z7eU0K0xBtFWAj4yRX9uwt4FN28y9Q+pGMv0Ue0I4IlCAueYUyzEkrQlhds
	 zjDyHBQIiQN/XKoBZ3N99iMcZPcseokrYbRCz2RVEKytJGuE76ByVi7puhjNYuFImg/6r
	 ZzZ0GTPIrEZALEBQ1f7H6l9LXk8f3CHO5XW5t0ZNJMgd/3Ovba0AA8fKPQy810conKl11
	 /TKaaARpmIqeJW/84VeXNmOjLSVygUAdeexZLuNTlkdWUCyRfbBhAamdaM9lqhYWmzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358650;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rUDKJwAD7JH06OFijmE6B2BOoMdncirS7RZkH+koZnw=;
	b=Xob/lY4HEYmSgHYa78WsMMZhL2KmCA1ZHggIUF+UqwdSOrfPLQq/IXbBisnEseaGHACS
	 07fP6ZnerrrdW5txEnriW0BaR6zedDxOlWHRW/OOjxErB6Pkd/iKQut8wp6YA+9euHHx5
	 iL8ZCDjYDQGquZV6+Yn+GxcPjcc1/gA9I7/pTD2/QEutt5BNaIDOOx1jqU4EERUth7A+R
	 tkmTGGLBr9X5IhTjw96P+GU9DT5vKZOkRb6KCmoIYQ+UGv/HcZRiLYB3yIzysEGjTR1Vm
	 ddPSZICZ4eGs9QweXHkW08xQ2dF0TNN3pI6vJEYB9rbNqOqvVyx2VVnboORtYAo3cDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHPVxsxl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272E606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHPVxsxl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E7D1F0089F;
	Wed, 11 Nov 2026 00:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358649;
	bh=rUDKJwAD7JH06OFijmE6B2BOoMdncirS7RZkH+koZnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eHPVxsxlXrtUzzdJ/aPowAWQDRKe8dKLUqUickis4zD3LYEDulv7863NxqpQbv1ri
	 Yr+FNVkR8aSR07dn+7Ja9Zfrj/cjoJOOOjQZEqz+OgeqTe4iTyYAAmnpEvxkkguu6V
	 KeBomaWt3StjTr8kE3vSr+WZmWWVQgEbFJy1/MFOymwMyRz68C2IoGgi/XaggFhqHc
	 6a3QAGVKT2PKfZtknjPzbkjxjix+RChLXuuSxGyi/l2pvpmrWhAfaWCt7OimSWpr2z
	 s7YljPi1X7lEPJ41W74lesPATPdtZbtBJmZO2stGEzIXT19Na9+mj5gBjdtCLKgRow
	 7Er6or6xfuNPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Chao Leng <lengchao@huawei.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] block: set the disk capacity to 0 in blk_mark_disk_dead
Date: Tue, 10 Nov 2026 19:57:26 -0500
Message-ID: <20261111005717.339235-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054611-failed-6.1-61b6d1df1d62@kernel.org>
References: <20261107054611-failed-6.1-61b6d1df1d62@kernel.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 71b26083d59cd4ab22489829ffe7d4ead93f5546 ]

nvme and xen-blkfront are already doing this to stop buffered writes from
creating dirty pages that can't be written out later.  Move it to the
common code.

This also removes the comment about the ordering from nvme, as bd_mutex
not only is gone entirely, but also hasn't been used for locking updates
to the disk size long before that, and thus the ordering requirement
documented there doesn't apply any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://lore.kernel.org/r/20221101150050.3510-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 61b6d1df1d62 ("xen-blkfront: Fix IO race during unplug")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c                | 5 +++++
 drivers/block/xen-blkfront.c | 1 -
 drivers/nvme/host/core.c     | 7 +------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ee6dc7feccc6f..f06195e53571c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -595,6 +595,11 @@ void blk_mark_disk_dead(struct gendisk *disk)
 	blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
 	set_bit(GD_DEAD, &disk->state);
 	blk_queue_start_drain(disk->queue);
+
+	/*
+	 * Stop buffered writers from dirtying pages that can't be written out.
+	 */
+	set_capacity_and_notify(disk, 0);
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index df0eaf15a4ddd..7ad03bcd9f274 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2134,7 +2134,6 @@ static void blkfront_closing(struct blkfront_info *info)
 	if (info->rq && info->gd) {
 		blk_mq_stop_hw_queues(info->rq);
 		blk_mark_disk_dead(info->gd);
-		set_capacity(info->gd, 0);
 	}
 
 	for_each_rinfo(info, rinfo, i) {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 26233e6a50da9..ecaba784e593d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5339,10 +5339,7 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 /*
  * Prepare a queue for teardown.
  *
- * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
- * the capacity to 0 after that to avoid blocking dispatchers that may be
- * holding bd_butex.  This will end buffered writers dirtying pages that can't
- * be synced.
+ * This must forcibly unquiesce queues to avoid blocking dispatch.
  */
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
@@ -5351,8 +5348,6 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 
 	blk_mark_disk_dead(ns->disk);
 	nvme_start_ns_queue(ns);
-
-	set_capacity_and_notify(ns->disk, 0);
 }
 
 /**
-- 
2.53.0

