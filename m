Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546844;
	b=rAXfYP4rCfBb4FPCDjDut5UxlIxtavEpCSILh7mUr9fLlw8oJBdtbydhbboLH9fmFAvY
	 zcwIXcoaTHwIntdBhTQzXd0MCzrmCHYoDuKu6AE+/KIP3uC+zwsnBoQ9ihZU4g6aMboKJ
	 FUu+mAqLe0KPEcu4BBanYRPSILiSPvwuieMuwTVs4jyzYKniUxyFy/JyI/1ixh7QLU6UY
	 TxCeU4cmXkn4p1oCfushv6ulWTSVIN0TBLNAvF+u+MYRWAEwi4xoYI7YfDQBWVMehltCa
	 knlwnYfYHyIi5+0IzvQKGoQwE0Af3T9Va5sz9AFLNeuJ/MFsEYrjrPZMoNlDAvk1iAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546844;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=HeDOc1a25yKZFHVErDRfWSX7GxV09UeyrppnQuDKie4=;
	b=nXnJXuejgmC6vx/SB9jWqEaQdbZ8//wA43VA4wGlMhcGdVmNBX8AGqxTkmTFJ2OgY3N0
	 AcjteZwnb9CpyW41iDQtJJuWkCqU9z+JzvbpyI6K/O51rmduR6xLtuRV3u1pLSqXJWTDr
	 m4XiSDWVq/E2dCRCudnOq+1YZg9w3QchnGdtOhpRDm43wEX9YFOjENC57Au6GM5W8Z39v
	 tH7lq4muup/PxccVw0EjNFqpjIlv6/LFT3bkOzhVEb88bTaA8Haud3MzlsPYVaIDgq0J0
	 QjceDjPrLrL1loaOF3cfxliuLcxw63KeVcIRBM6UjbhyOrTPz+1gmKgFHP0/OAWBeug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=al5lKTVZ;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FFE606A319;
	Wed, 21 Oct 2026 01:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74FFE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=al5lKTVZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=He
	DOc1a25yKZFHVErDRfWSX7GxV09UeyrppnQuDKie4=; b=al5lKTVZ0RGRiYmUsx
	yc36VgQnurINXS1sNdNbgR8iZEuI/6NlEiV89e2uaG5gMRSQG/CNyKSvL2JcWKrm
	NXDQj/egfcCXCeRnPmZEI5lK96KNLmpzrRrqPmcC3uDuJzfTEyIFlnrrR2j8EOO2
	cnaf38+4eXc3VVzwmCNW44mK0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB345b7F9hqHjJlBA--.9484S2;
	Wed, 21 Oct 2026 09:40:12 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] md/raid5: use dedicated llist for stripe plug
Date: Wed, 21 Oct 2026 09:40:09 +0800
Message-Id: <20261021014009.1206807-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:QCgvCgB345b7F9hqHjJlBA--.9484S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1fZF1fAr15ZF18uw1kAFb_yoWrXrWxpw
	n8G3yY9rW8ur40vrWvqFWDuF9a9a1agryakrWFka4S9F1YvrW7ta43WFZ8CFn8AFZ5u3y3
	Xwn09r17Gr45CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYMKZUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3R3VhGrYF-2vvgAA3Y

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
v3:
- Skip device_lock when llist_del_all() returns NULL. The plug
  callback can still run with an empty list, and the check avoids
  an unnecessary spin_lock.
- v2: link: https://lore.kernel.org/linux-raid/20260922060928.3486799-1-dayou5941@163.com/

v2:
- Drop taking device_lock in release_stripe_plug(). Add a dedicated
  unplug_list.
- v1: link: https://lore.kernel.org/linux-raid/20260902095307.358569-1-dayou5941@163.com/

---
 drivers/md/raid5.c | 20 +++++++++++---------
 drivers/md/raid5.h |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b91545ce090d..dbc6e6876509 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5710,7 +5710,7 @@ static struct stripe_head *__get_priority_stripe(struct r5conf *conf, int group)
 
 struct raid5_plug_cb {
 	struct blk_plug_cb	cb;
-	struct list_head	list;
+	struct llist_head	unplug_list;
 	struct list_head	temp_inactive_list[NR_STRIPE_HASH_LOCKS];
 };
 
@@ -5718,17 +5718,18 @@ static void raid5_unplug(struct blk_plug_cb *blk_cb, bool from_schedule)
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
+	head = llist_del_all(&cb->unplug_list);
+	if (head) {
+		head = llist_reverse_order(head);
 		spin_lock_irq(&conf->device_lock);
-		while (!list_empty(&cb->list)) {
-			sh = list_first_entry(&cb->list, struct stripe_head, lru);
-			list_del_init(&sh->lru);
+		llist_for_each_entry_safe(sh, tmp, head, unplug_list) {
 			/*
 			 * avoid race release_stripe_plug() sees
 			 * STRIPE_ON_UNPLUG_LIST clear but the stripe
@@ -5768,15 +5769,16 @@ static void release_stripe_plug(struct mddev *mddev,
 
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

