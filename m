Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAB42B316;
	Wed,  2 Sep 2026 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342815; cv=none; b=ubHuJ9rpf23grKjONsFbU+i/y5EFjueIqDUzp0k4AnxnOtmdz7zezPZPojkDQajl159/zC+nmu38YMbzeaNySMNqzKmOkAGEpFBp3BZTQualbVzKJCS2chnfEwC9DKETyQchAgEwNwX9vAW9q5DGXWlrO8sMOC/MIbM/C4cKj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342815; c=relaxed/simple;
	bh=oNhg4hb4M+E47FxPNXa0AnqWDwKih2/+52GqwcC18QE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HExGU8uYgkesz8Ma16qtzf8B98Cs1P62WJAJBkgx0aNtR2M58jzY43VIGNhx1La1CmWTg4wXZB7VLvh/ia75AtBOXGIsvTGbXedQQJBJfrna/DjGKqviZpcPMBfg8EnAQSw3IUhBeyeN8Gyg6ClYDR/PjHef5cibi8+bkrLM5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=niHfX5Eq; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="niHfX5Eq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=K1
	vRBaEaVS9r2Sq1pSemBzREvTUU39hxrQWzvkncdKc=; b=niHfX5EqjzN+AMSMWr
	WmfnM0POm0DOF99fds1/+2gYOfYAaYyfYp2hbrT6bGoJGR73cOvGBSZe6OLSC+2R
	Xfd5hY6VGZjXjBnwAfIzfdHFZ2sa3cgk+4WJ+RcBZUX//IeaUKcnp+GYOT/E+h6Q
	/tPOA/EKUP55R1VeHxzmxkXHY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDX3zoE8pdql9prAA--.12837S2;
	Wed, 02 Sep 2026 17:53:09 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] md/raid5: serialize plug list add with device_lock
Date: Wed,  2 Sep 2026 17:53:07 +0800
Message-Id: <20260902095307.358569-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX3zoE8pdql9prAA--.12837S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXry8JFy8CryfKF18Zr1rtFb_yoW5tF47pF
	s5Ja1Y93yUWryftrZ7Za1DZr1F9a4rtr98KFWfKw1fZa1YqrW3tryfXa4DKw1UJrs5Jayx
	Xas0vr4UCr1agrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYxRDUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3gU+7GqX8gWR1QAA3H

From: Li Youhong <liyouhong@kylinos.cn>

raid5_unplug() can spin forever under conf->device_lock when
raid5_plug_cb.list still points at a stripe whose sh->lru has
already been reinitialized (self-looped). That disables IRQs on
the holder CPU and causes multi-CPU hard lockups on waiters of
the same lock.

This happens because release_stripe_plug() sets
STRIPE_ON_UNPLUG_LIST and list_add_tail(sh->lru) without
device_lock, while do_release_stripe() may concurrently move the
same lru onto handle/inactive when the last reference drops.

Note: a 2020 proposal tried extra refs / checking
STRIPE_ON_UNPLUG_LIST in do_release_stripe() without serializing
the plug enqueue:
https://lore.kernel.org/linux-raid/20200108163023.9301-1-guoqing.jiang@cloud.ionos.com/
That still leaves a TOCTOU window where the bit is clear during
the check and set afterwards, allowing two list_add on the same
lru. It was not merged.

Serialize the bit update and list_add with device_lock. If
do_release_stripe() still sees STRIPE_ON_UNPLUG_LIST, restore the
reference and let raid5_unplug() own the final release.

Observed on production 9-disk NVMe RAID5 under MySQL AIO
(io_submit -> blk_finish_plug -> raid5_unplug).

Fixes: 8811b5968f62 ("raid5: make_request use batch stripe release")
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/md/raid5.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b91545ce090d..c9197b63b1c4 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -229,6 +229,17 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 	int i;
 	int injournal = 0;	/* number of date pages with R5_InJournal */
 
+	/*
+	 * Stripe is owned by release_stripe_plug()'s cb->list. A concurrent
+	 * last-ref release can reach here after the stripe was queued for
+	 * unplug (lru may already be non-empty). Do not re-add lru elsewhere;
+	 * restore the reference and let raid5_unplug() finish the release.
+	 */
+	if (test_bit(STRIPE_ON_UNPLUG_LIST, &sh->state)) {
+		atomic_inc(&sh->count);
+		return;
+	}
+
 	BUG_ON(!list_empty(&sh->lru));
 	BUG_ON(atomic_read(&conf->active_stripes)==0);
 
@@ -5760,6 +5771,9 @@ static void release_stripe_plug(struct mddev *mddev,
 		raid5_unplug, mddev,
 		sizeof(struct raid5_plug_cb));
 	struct raid5_plug_cb *cb;
+	struct r5conf *conf = mddev->private;
+	unsigned long flags;
+	bool queued = false;
 
 	if (!blk_cb) {
 		raid5_release_stripe(sh);
@@ -5775,9 +5789,22 @@ static void release_stripe_plug(struct mddev *mddev,
 			INIT_LIST_HEAD(cb->temp_inactive_list + i);
 	}
 
-	if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
-		list_add_tail(&sh->lru, &cb->list);
-	else
+	/*
+	 * Serialize with do_release_stripe() on device_lock so sh->lru cannot
+	 * be added to handle/inactive and cb->list at the same time.
+	 */
+	spin_lock_irqsave(&conf->device_lock, flags);
+	if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state)) {
+		if (unlikely(!list_empty(&sh->lru))) {
+			clear_bit(STRIPE_ON_UNPLUG_LIST, &sh->state);
+		} else {
+			list_add_tail(&sh->lru, &cb->list);
+			queued = true;
+		}
+	}
+	spin_unlock_irqrestore(&conf->device_lock, flags);
+
+	if (!queued)
 		raid5_release_stripe(sh);
 }
 
-- 
2.25.1

