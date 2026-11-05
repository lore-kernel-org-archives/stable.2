Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845458;
	b=25vznrmXWKmQ/g/DQa7B/haXZwZFbUIBvIAFMNwJNSN5C1zojeV/msTjQ7q0nyy9qYK9
	 j8mEbYoyo7fiiq59OwiE8FXKMJPwQ823kQXfOQ4QgAmwbY9R1vsqMEm2IhshN7SC7e1eO
	 J7dWddkf68oA/95Zlfs1d3DU8gQC8/Win5RdiVjoiYRa6207ymv6zq9hXOZKgwrMND2pW
	 t5DOmCVOwUFefPwCYv/PdeLbqoIEaNy7fOrNnXZ6ruYzV5SuOmMCRyec4HUHF+B104x7L
	 XRNuYlNiFhDnrz83X7xTrZZ0VuWASoJnmDMxyJWO91VQkcPoOkxV6qh8uCj0ZfSfLqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845458;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Oz1bGnACal3C3J6gDkB1pKEsgvCxlnRsJc6z7fq2+sM=;
	b=Hu4Q4/TU7GE4uuLGo3CNr2eGaMCfoWBLznWG9Is67lGrypkw9UjcTabRExwvA3+3Mbz2
	 OraCQqn7ojtDLypx7EpM5z3YQSwu36hpMAZslzb1JIIBetfbCqhBshIpVfEfxadHYhQve
	 WBgcldHcUexlF2PPqEtEqOrm52MTFFh/tsdX8rLYgZaG5YohaB32CsFHuliz5FoA4ro+I
	 9Dk6WN5/rodx+IFqk/grnwP4CgQzNpjz/DWVwFO233YNF3/qHpDvKxqy3eF2VABGASJvY
	 qFRGJKqMGmfaC8Km64575KK4+7c2hztF/NQsbViKRMvRcRUrBgq9l1zfoEtQIGsIhWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwmDuGUb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C8606A32E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwmDuGUb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454551F00919;
	Thu,  5 Nov 2026 02:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793845457;
	bh=Oz1bGnACal3C3J6gDkB1pKEsgvCxlnRsJc6z7fq2+sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwmDuGUbBlgXNGoO6dh+aTz3nGfkBEP0FEjR1madIZlREfVFqD6hEXYFitmum3Fah
	 tUNysMUJplSRt5a9ORSz+Xqm+HVs2Nz5ljTgLs/KMP05Qn19S+1/LeTyg1VPhbHdd5
	 4ZKEAGgGpJj3NVttlJL/wYbTeAqJrQtamVw8OjwrWmRg+tWlhtKiOYAVmvd8cztaqJ
	 9VOYGqbiaTutYFpiuXaDZ5KJCkv6DxeGEZze0AuEcM3vL0vdC6RHDJbMe1ztkAOVUP
	 pdjw4jsSEluJ+ZATojb3fbg7HtpU5eEtJWl1IbicGd1jCvK+eZKDsK38yiG0XAofck
	 AKDqfvgplYdvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: rc: Fix race condition during rc_register_device()
Date: Wed,  4 Nov 2026 21:24:16 -0500
Message-ID: <20261105022404.1172334-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110405-opulently-slobbery-fb2f@gregkh>
References: <2026110405-opulently-slobbery-fb2f@gregkh>
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

From: Sean Young <sean@mess.org>

[ Upstream commit ec7cb49871e5c4f85d57290320c50ee0bae4db84 ]

Device drivers can call ir_raw_event_store() or ir_raw_event_handle()
right after rc_allocate_device(). This means that while
rc_register_device() is being called, those functions can be called
from e.g. interrupt handlers.

Currently dev->raw is being allocated and populated by
ir_raw_event_prepare() which is called from rc_register_device(). This
is not done in a safe way, e.g. dev->raw is being set before the
raw members are populated.

Call ir_raw_event_prepare() from rc_allocate_device() instead.

Fixes: a3572c34da8d ("V4L/DVB: ir-core: Add logic to decode IR protocols at the IR core")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: Adjusted context for existing kzalloc() allocations and the out_free_table cleanup label. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-ir-raw.c | 20 +-------------------
 drivers/media/rc/rc-main.c   | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index b84fc9dc2a017..6d7b2577e463f 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -72,9 +72,6 @@ static int ir_raw_event_thread(void *data)
  */
 int ir_raw_event_store(struct rc_dev *dev, struct ir_raw_event *ev)
 {
-	if (!dev->raw)
-		return -EINVAL;
-
 	dev_dbg(&dev->dev, "sample: (%05dus %s)\n",
 		ev->duration, TO_STR(ev->pulse));
 
@@ -103,9 +100,6 @@ int ir_raw_event_store_edge(struct rc_dev *dev, bool pulse)
 	ktime_t			now;
 	struct ir_raw_event	ev = {};
 
-	if (!dev->raw)
-		return -EINVAL;
-
 	now = ktime_get();
 	ev.duration = ktime_to_us(ktime_sub(now, dev->raw->last_event));
 	ev.pulse = !pulse;
@@ -130,9 +124,6 @@ int ir_raw_event_store_with_timeout(struct rc_dev *dev, struct ir_raw_event *ev)
 	ktime_t		now;
 	int		rc = 0;
 
-	if (!dev->raw)
-		return -EINVAL;
-
 	now = ktime_get();
 
 	spin_lock(&dev->raw->edge_spinlock);
@@ -167,9 +158,6 @@ EXPORT_SYMBOL_GPL(ir_raw_event_store_with_timeout);
  */
 int ir_raw_event_store_with_filter(struct rc_dev *dev, struct ir_raw_event *ev)
 {
-	if (!dev->raw)
-		return -EINVAL;
-
 	/* Ignore spaces in idle mode */
 	if (dev->idle && !ev->pulse)
 		return 0;
@@ -201,9 +189,6 @@ EXPORT_SYMBOL_GPL(ir_raw_event_store_with_filter);
  */
 void ir_raw_event_set_idle(struct rc_dev *dev, bool idle)
 {
-	if (!dev->raw)
-		return;
-
 	dev_dbg(&dev->dev, "%s idle mode\n", idle ? "enter" : "leave");
 
 	if (idle) {
@@ -227,7 +212,7 @@ EXPORT_SYMBOL_GPL(ir_raw_event_set_idle);
  */
 void ir_raw_event_handle(struct rc_dev *dev)
 {
-	if (!dev->raw || !dev->raw->thread)
+	if (!dev->raw->thread)
 		return;
 
 	wake_up_process(dev->raw->thread);
@@ -605,9 +590,6 @@ EXPORT_SYMBOL(ir_raw_encode_carrier);
  */
 int ir_raw_event_prepare(struct rc_dev *dev)
 {
-	if (!dev)
-		return -EINVAL;
-
 	dev->raw = kzalloc(sizeof(*dev->raw), GFP_KERNEL);
 	if (!dev->raw)
 		return -ENOMEM;
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index fb52ed2d4ef6b..5bd6aade49056 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1701,14 +1701,24 @@ static const struct device_type rc_dev_type = {
 struct rc_dev *rc_allocate_device(enum rc_driver_type type)
 {
 	struct rc_dev *dev;
+	int ret;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
 
+	if (type == RC_DRIVER_IR_RAW) {
+		ret = ir_raw_event_prepare(dev);
+		if (ret < 0) {
+			kfree(dev);
+			return NULL;
+		}
+	}
+
 	if (type != RC_DRIVER_IR_RAW_TX) {
 		dev->input_dev = input_allocate_device();
 		if (!dev->input_dev) {
+			ir_raw_event_free(dev);
 			kfree(dev);
 			return NULL;
 		}
@@ -1724,6 +1734,7 @@ struct rc_dev *rc_allocate_device(enum rc_driver_type type)
 		spin_lock_init(&dev->rc_map.lock);
 		spin_lock_init(&dev->keylock);
 	}
+
 	mutex_init(&dev->lock);
 
 	dev->dev.type = &rc_dev_type;
@@ -1922,12 +1933,6 @@ int rc_register_device(struct rc_dev *dev)
 		dev->sysfs_groups[attr++] = &rc_dev_wakeup_filter_attr_grp;
 	dev->sysfs_groups[attr++] = NULL;
 
-	if (dev->driver_type == RC_DRIVER_IR_RAW) {
-		rc = ir_raw_event_prepare(dev);
-		if (rc < 0)
-			goto out_minor;
-	}
-
 	if (dev->driver_type != RC_DRIVER_IR_RAW_TX) {
 		rc = rc_prepare_rx_device(dev);
 		if (rc)
@@ -1991,8 +1996,6 @@ int rc_register_device(struct rc_dev *dev)
 out_free_table:
 	ir_free_table(&dev->rc_map);
 out_raw:
-	ir_raw_event_free(dev);
-out_minor:
 	ida_free(&rc_ida, minor);
 	return rc;
 }
-- 
2.53.0

