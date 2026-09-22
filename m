Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACFF45C704
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101012; cv=none; b=eSGO29IwBUESV+bsysa3y2xZCiXGpXYdw/H3USE12ri2x5JieUdiKlOKSj/uQKAzTg6YC+819THyeRTffxojAGmwAYzhpGT4PQNJbnMp6/1u/fc+avJhl7YVIArbWoKz3gWj3/i1HX4gwjddeR3o9POgRFeXwUKvyDVVi2NueTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101012; c=relaxed/simple;
	bh=aqlutWBYPMoTucxTIUjtQK/ht69Ut0Xfx1VyXyW8nHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lque2QFYYtn9neICtfsGu5OLO9Gf9c9eUr5ImxSoZRbTHnHtJGEvwDgyypAIi94JCPXa2pSXJr3PjFQ/9ctZmlKDUNGG7geo4HlCeJYBEmFgaDwSEKysRnink2pSs+FmHGVnjUwvMI17dad9aCoTPBjrlLo2H/V/7i2Q4R0Erko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+PGBNSi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+PGBNSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447A81F0089C;
	Tue, 22 Sep 2026 18:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101010;
	bh=igBVo1rOjycTKwNSjrpj4uV84Z8+lEeecLoRvEJP6mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+PGBNSiJQ0AzLwfzB5wGN+m6BUICqxt/LN1j179PqtTTV8J3//JLJIEendz3yGYr
	 aFl0W33diwBo99TSXnuIP0zxidWP2l2qU//IsFK2WJvgbGOhqWNZs+v9VE6Z4/Kz13
	 QNmmcoPEtrVxcfgnR+lEUJ3u33ohBisdBKlko2wULnHmcInpAfGV+vYwpKX0QwXt99
	 4vQ8c9fIWZ3/Pubey4SoZHI2v0ZO4pe+MVEiJU3H+wSVt70xB118T+bwighStV31Kx
	 60Nw+nSJoWf+cDdKguniGzuVKRRuk2M6wWyT/f4Y4TLLSFufhwoAJt1NhT8XC8u+7x
	 IentlBtwG4Nig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Wu <michael@allwinnertech.com>,
	Wenchao Chen <wenchao.chen@unisoc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] mmc: mmc-hsq: Use fifo to dispatch mmc_request
Date: Tue, 22 Sep 2026 14:16:46 -0400
Message-ID: <20260922181647.3522363-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922181647.3522363-1-sashal@kernel.org>
References: <2026092257-ranger-harmonize-17aa@gregkh>
 <20260922181647.3522363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Wu <michael@allwinnertech.com>

[ Upstream commit e026a3f9172f5c9aacff270b929a166c3ea1b6f7 ]

Current next_tag selection will cause a large delay in some requests and
destroy the scheduling results of the block scheduling layer. Because the
issued mrq tags cannot ensure that each time is sequential, especially when
the IO load is heavy. In the fio performance test, we found that 4k random
read data was sent to mmc_hsq to start calling request_atomic It takes
nearly 200ms to process the request, while mmc_hsq has processed thousands
of other requests. So we use fifo here to ensure the first in, first out
feature of the request and avoid adding additional delay to the request.

Reviewed-by: Wenchao Chen <wenchao.chen@unisoc.com>
Signed-off-by: Michael Wu <michael@allwinnertech.com>
Link: https://lore.kernel.org/r/20221128093847.22768-1-michael@allwinnertech.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 5d132990475f ("mmc: hsq: Fix use-after-free in retry work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmc_hsq.c | 40 ++++++++++++++------------------------
 drivers/mmc/host/mmc_hsq.h |  5 +++++
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 9d35453e7371b..424dc7b07858f 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -13,9 +13,6 @@
 
 #include "mmc_hsq.h"
 
-#define HSQ_NUM_SLOTS	64
-#define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
-
 static void mmc_hsq_retry_handler(struct work_struct *work)
 {
 	struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
@@ -73,7 +70,6 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 
 static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
 {
-	struct hsq_slot *slot;
 	int tag;
 
 	/*
@@ -82,29 +78,12 @@ static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
 	 */
 	if (!remains) {
 		hsq->next_tag = HSQ_INVALID_TAG;
+		hsq->tail_tag = HSQ_INVALID_TAG;
 		return;
 	}
 
-	/*
-	 * Increasing the next tag and check if the corresponding request is
-	 * available, if yes, then we found a candidate request.
-	 */
-	if (++hsq->next_tag != HSQ_INVALID_TAG) {
-		slot = &hsq->slot[hsq->next_tag];
-		if (slot->mrq)
-			return;
-	}
-
-	/* Othersie we should iterate all slots to find a available tag. */
-	for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
-		slot = &hsq->slot[tag];
-		if (slot->mrq)
-			break;
-	}
-
-	if (tag == HSQ_NUM_SLOTS)
-		tag = HSQ_INVALID_TAG;
-
+	tag = hsq->tag_slot[hsq->next_tag];
+	hsq->tag_slot[hsq->next_tag] = HSQ_INVALID_TAG;
 	hsq->next_tag = tag;
 }
 
@@ -233,8 +212,14 @@ static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	 * Set the next tag as current request tag if no available
 	 * next tag.
 	 */
-	if (hsq->next_tag == HSQ_INVALID_TAG)
+	if (hsq->next_tag == HSQ_INVALID_TAG) {
 		hsq->next_tag = tag;
+		hsq->tail_tag = tag;
+		hsq->tag_slot[hsq->tail_tag] = HSQ_INVALID_TAG;
+	} else {
+		hsq->tag_slot[hsq->tail_tag] = tag;
+		hsq->tail_tag = tag;
+	}
 
 	hsq->qcnt++;
 
@@ -339,8 +324,10 @@ static const struct mmc_cqe_ops mmc_hsq_ops = {
 
 int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 {
+	int i;
 	hsq->num_slots = HSQ_NUM_SLOTS;
 	hsq->next_tag = HSQ_INVALID_TAG;
+	hsq->tail_tag = HSQ_INVALID_TAG;
 
 	hsq->slot = devm_kcalloc(mmc_dev(mmc), hsq->num_slots,
 				 sizeof(struct hsq_slot), GFP_KERNEL);
@@ -351,6 +338,9 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 	hsq->mmc->cqe_private = hsq;
 	mmc->cqe_ops = &mmc_hsq_ops;
 
+	for (i = 0; i < HSQ_NUM_SLOTS; i++)
+		hsq->tag_slot[i] = HSQ_INVALID_TAG;
+
 	INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
 	spin_lock_init(&hsq->lock);
 	init_waitqueue_head(&hsq->wait_queue);
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index ffdd9cd172c34..1808024fc6c5d 100644
--- a/drivers/mmc/host/mmc_hsq.h
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -2,6 +2,9 @@
 #ifndef LINUX_MMC_HSQ_H
 #define LINUX_MMC_HSQ_H
 
+#define HSQ_NUM_SLOTS	64
+#define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
+
 struct hsq_slot {
 	struct mmc_request *mrq;
 };
@@ -17,6 +20,8 @@ struct mmc_hsq {
 	int next_tag;
 	int num_slots;
 	int qcnt;
+	int tail_tag;
+	int tag_slot[HSQ_NUM_SLOTS];
 
 	bool enabled;
 	bool waiting_for_idle;
-- 
2.53.0

