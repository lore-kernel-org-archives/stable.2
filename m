Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011B3F4DD2;
	Tue, 22 Sep 2026 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057399; cv=none; b=PkndifU5+SchzgIQqrZLB/dP+WWpy5ogPyTciiBKgSI717201SJfBKo2Mijz3tOL5j+DFGBDqLOcN/xjBiT2zsQgoYorad/EXI/8pA5j0X+ut1Z50qkAz9FTZMWOm/ojiCwNLEoDpvznfNrCwGJw4MI7VqXShZv7SjmIpGmNDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057399; c=relaxed/simple;
	bh=bSqi5nw26JYLt/66IbXZv9kxKyj7+H/MaFYKrjf9Yxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TF8T1zF037ou698BaYSVhQu2EZr6y6Af9EYgZBUOq7jKocNBL/9EFpRvLwX1X+zwT9hxcTXWbQatRI2cbvbKIBb9QWU66IcSXz8sB0/bcktPxP4hBQmbhMnUvjHVZMcfP0+bMvEh85QIwzeRR8mGB0cRs03/UB5ZxPsXHFg5/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H8RAbPUL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H8RAbPUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7D
	rTlWOkyl00RXsO7e25MPXZkPkCJPXwk1DiHDjAS20=; b=H8RAbPULyatmoWJAzk
	7141S8ZYpA7Pccv+JinKaVvse15hR80ALB3uniTmalEURot6+Ap4WieQZr5L/G5G
	lPD22M6LuGU/MCh3t8OyeQEydU9fo+/Fq3x1tewoTPUdkQBEoIitxpfDtPZ7W8Qy
	4PWi5KWk8EuWhFRgbjtPyKjJI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3fwSaG7JqTH8+AA--.29012S2;
	Tue, 22 Sep 2026 14:09:32 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] md/raid5: use dedicated llist for stripe plug
Date: Tue, 22 Sep 2026 14:09:28 +0800
Message-Id: <20260922060928.3486799-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fwSaG7JqTH8+AA--.29012S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1fZF17JF4Duw1xtw48tFb_yoWrtF4Dpr
	15G3yagrW8Xr4IvrWkWFWDur9Y9a1Igryak3yfCa4S9F1YvrW2qa43Aa98CF98ta95Z3y3
	Xas09r15Gr4rCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5EfOUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+R0142qyG505OQAA3s

From: Li Youhong <liyouhong@kylinos.cn>

release_stripe_plug() and do_release_stripe() share sh->lru.
release_stripe_plug() sets STRIPE_ON_UNPLUG_LIST and
list_add_tail()s sh->lru onto raid5_plug_cb.list without
device_lock. do_release_stripe() holds device_lock and, when the
last reference drops, list_add()s the same lru onto a handle or
inactive list.

Two list_add()s on one node corrupt it. sh->lru can be
reinitialized into a self-loop while raid5_plug_cb.list still
points at that stripe. raid5_unplug() then walks the list under
device_lock with IRQs disabled and never finishes. Other CPUs
waiting for the same lock hard-lockup.

Add a dedicated llist_node, unplug_list, to stripe_head, as
release_list is used for released_stripes.

Fixes: 8811b5968f62 ("raid5: make_request use batch stripe release")
Suggested-by: Yu Kuai <yukuai@fygo.io>
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v2:
- Drop taking device_lock in release_stripe_plug(). Add a dedicated
  unplug_list.
- v1: link: https://lore.kernel.org/linux-raid/20260902095307.358569-1-dayou5941@163.com/

---
 drivers/md/raid5.c | 52 ++++++++++++++++++++++++++--------------------------
 drivers/md/raid5.h |  1 +
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b91545ce090d..9dabbf9743d7 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5710,7 +5710,7 @@ static struct stripe_head *__get_priority_stripe(struct r5conf *conf, int group)
 
 struct raid5_plug_cb {
 	struct blk_plug_cb	cb;
-	struct list_head	list;
+	struct llist_head	unplug_list;
 	struct list_head	temp_inactive_list[NR_STRIPE_HASH_LOCKS];
 };
 
@@ -5718,34 +5718,33 @@ static void raid5_unplug(struct blk_plug_cb *blk_cb, bool from_schedule)
 {
 	struct raid5_plug_cb *cb = container_of(
 		blk_cb, struct raid5_plug_cb, cb);
-	struct stripe_head *sh;
+	struct stripe_head *sh, *tmp;
 	struct mddev *mddev = cb->cb.data;
 	struct r5conf *conf = mddev->private;
+	struct llist_node *head;
 	int cnt = 0;
 	int hash;
 
-	if (cb->list.next && !list_empty(&cb->list)) {
-		spin_lock_irq(&conf->device_lock);
-		while (!list_empty(&cb->list)) {
-			sh = list_first_entry(&cb->list, struct stripe_head, lru);
-			list_del_init(&sh->lru);
-			/*
-			 * avoid race release_stripe_plug() sees
-			 * STRIPE_ON_UNPLUG_LIST clear but the stripe
-			 * is still in our list
-			 */
-			smp_mb__before_atomic();
-			clear_bit(STRIPE_ON_UNPLUG_LIST, &sh->state);
-			/*
-			 * STRIPE_ON_RELEASE_LIST could be set here. In that
-			 * case, the count is always > 1 here
-			 */
-			hash = sh->hash_lock_index;
-			__release_stripe(conf, sh, &cb->temp_inactive_list[hash]);
-			cnt++;
-		}
-		spin_unlock_irq(&conf->device_lock);
+	head = llist_del_all(&cb->unplug_list);
+	head = llist_reverse_order(head);
+	spin_lock_irq(&conf->device_lock);
+	llist_for_each_entry_safe(sh, tmp, head, unplug_list) {
+		/*
+		 * avoid race release_stripe_plug() sees
+		 * STRIPE_ON_UNPLUG_LIST clear but the stripe
+		 * is still in our list
+		 */
+		smp_mb__before_atomic();
+		clear_bit(STRIPE_ON_UNPLUG_LIST, &sh->state);
+		/*
+		 * STRIPE_ON_RELEASE_LIST could be set here. In that
+		 * case, the count is always > 1 here
+		 */
+		hash = sh->hash_lock_index;
+		__release_stripe(conf, sh, &cb->temp_inactive_list[hash]);
+		cnt++;
 	}
+	spin_unlock_irq(&conf->device_lock);
 	release_inactive_stripe_list(conf, cb->temp_inactive_list,
 				     NR_STRIPE_HASH_LOCKS);
 	if (!mddev_is_dm(mddev))
@@ -5768,15 +5767,16 @@ static void release_stripe_plug(struct mddev *mddev,
 
 	cb = container_of(blk_cb, struct raid5_plug_cb, cb);
 
-	if (cb->list.next == NULL) {
+	if (!cb->temp_inactive_list[0].next) {
 		int i;
-		INIT_LIST_HEAD(&cb->list);
+
+		init_llist_head(&cb->unplug_list);
 		for (i = 0; i < NR_STRIPE_HASH_LOCKS; i++)
 			INIT_LIST_HEAD(cb->temp_inactive_list + i);
 	}
 
 	if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
-		list_add_tail(&sh->lru, &cb->list);
+		llist_add(&sh->unplug_list, &cb->unplug_list);
 	else
 		raid5_release_stripe(sh);
 }
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index cb5feae04db2..e314f17eb949 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -201,6 +201,7 @@ struct stripe_head {
 	struct hlist_node	hash;
 	struct list_head	lru;	      /* inactive_list or handle_list */
 	struct llist_node	release_list;
+	struct llist_node	unplug_list;
 	struct r5conf		*raid_conf;
 	short			generation;	/* increments with every
 						 * reshape */
-- 
2.25.1

