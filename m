Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850262;
	b=fYNu389/kk3CYbIjGI5sRSRFE+7lm41M11yHbql3Qz8vJ+KakjOqZcZ17UQ/86vnIvGe
	 t0P+eb65u3G+GzaFEBABsPp9aAXGI9hwMVuaVQBv+nAwyoDskD2N7bmWJtABBck+q/7pK
	 vmp0UsClp/ZFsIYLM0XAg7XPNvQwhLkyF6a4ABs9WVFbdF6mSIHQzm2QPjAIDFkajwx1g
	 Gzx8JPvqvO241/kT9+r0T9KtO/2Ewd7Ffa0yfP2GzCxZtNP5cbW/nHEkGRwJdex7HgQlu
	 UmTP8cdAsq/+Q/im1NQrzeQaqY7TokUFKNA+kIllsXvQxeN/Hnhr67RskUeY90mqD7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850262;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yJ8dqWz9KUaL17ytdxjlE4oALHuPm1Gl496tqSLmA+o=;
	b=w3V50jBntr0jQFEHNdNUVypRb7Ozx9qFaUIlYex+bOMuxI9kidLwCnekHutQifJ3wzrY
	 c6s+a933ZFlG7LEQ0jsO2HgQr2r1t7P/XJjzAxRBwQmtFc/XwWdlVQ94YTM8WbeTzpEe7
	 uJMmattgfiohPZk9crbx9pyXqsogEv/I4jYagUKuIo0cE1LG2D3nZi1N9fzbadhT4jOKJ
	 wqRl0nsUHtEtVbNR+uOL8COHA1v4MwyplhLpHeQlFI/pO2lsZP8SjiBOWwJ0gaxEdlq2l
	 l4fOBzeEQECrEmJdxbrLELwevnY9GfPqrKvxj6DmMSOfmSkYTfE2gSlX1dOVnczZMPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDgdRZed;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8C606A334
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDgdRZed
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B461F00A02;
	Thu,  5 Nov 2026 03:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793850261;
	bh=yJ8dqWz9KUaL17ytdxjlE4oALHuPm1Gl496tqSLmA+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oDgdRZed3mzg5Jn9KCjIbnFbQdgEdMD8XxlQxyREeuVtLRS5HS4XYbGnyLc3yVOIO
	 rYuz4UirNNYW8Rs6ROrUoW4iYwDbu4JQqFZZEObxojLYsml/jIE284YGh8jKBRFNpb
	 poOPpFHM+vtXDhfXohllDapdSpfech/ApjOI3BlfHbRqQBSAq+VOU6N3UxT6YcC+6W
	 B6eGG0gbMs7UMnRiRy1v4s9WWV37+oF2LwCBmwugQfQLFf93jtazpeGP1+2GKyd+n4
	 7SBPu0U9FLvlnSLWqKp9g9q9891vHp8Y8JuCM8F7P4QTnMG1lYq5VDNrPTR1d1COyX
	 LyGsDkwDSn5zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: rc: Fix race condition during rc_register_device()
Date: Wed,  4 Nov 2026 22:44:19 -0500
Message-ID: <20261105034402.1228887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110406-staple-sheet-b1c6@gregkh>
References: <2026110406-staple-sheet-b1c6@gregkh>
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
[ sashal: adjusted allocation context for kzalloc() with explicit sizes and GFP_KERNEL instead of kzalloc_obj() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-ir-raw.c | 20 +-------------------
 drivers/media/rc/rc-main.c   | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index c65bba4ec4739..d695ca6eaa579 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -73,9 +73,6 @@ static int ir_raw_event_thread(void *data)
  */
 int ir_raw_event_store(struct rc_dev *dev, struct ir_raw_event *ev)
 {
-	if (!dev->raw)
-		return -EINVAL;
-
 	dev_dbg(&dev->dev, "sample: (%05dus %s)\n",
 		ev->duration, TO_STR(ev->pulse));
 
@@ -104,9 +101,6 @@ int ir_raw_event_store_edge(struct rc_dev *dev, bool pulse)
 	ktime_t			now;
 	struct ir_raw_event	ev = {};
 
-	if (!dev->raw)
-		return -EINVAL;
-
 	now = ktime_get();
 	ev.duration = ktime_to_us(ktime_sub(now, dev->raw->last_event));
 	ev.pulse = !pulse;
@@ -131,9 +125,6 @@ int ir_raw_event_store_with_timeout(struct rc_dev *dev, struct ir_raw_event *ev)
 	ktime_t		now;
 	int		rc = 0;
 
-	if (!dev->raw)
-		return -EINVAL;
-
 	now = ktime_get();
 
 	spin_lock(&dev->raw->edge_spinlock);
@@ -168,9 +159,6 @@ EXPORT_SYMBOL_GPL(ir_raw_event_store_with_timeout);
  */
 int ir_raw_event_store_with_filter(struct rc_dev *dev, struct ir_raw_event *ev)
 {
-	if (!dev->raw)
-		return -EINVAL;
-
 	/* Ignore spaces in idle mode */
 	if (dev->idle && !ev->pulse)
 		return 0;
@@ -202,9 +190,6 @@ EXPORT_SYMBOL_GPL(ir_raw_event_store_with_filter);
  */
 void ir_raw_event_set_idle(struct rc_dev *dev, bool idle)
 {
-	if (!dev->raw)
-		return;
-
 	dev_dbg(&dev->dev, "%s idle mode\n", idle ? "enter" : "leave");
 
 	if (idle) {
@@ -228,7 +213,7 @@ EXPORT_SYMBOL_GPL(ir_raw_event_set_idle);
  */
 void ir_raw_event_handle(struct rc_dev *dev)
 {
-	if (!dev->raw || !dev->raw->thread)
+	if (!dev->raw->thread)
 		return;
 
 	wake_up_process(dev->raw->thread);
@@ -613,9 +598,6 @@ EXPORT_SYMBOL(ir_raw_encode_carrier);
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
index 923cc1acda942..e3b538ec547b7 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1699,14 +1699,24 @@ static const struct device_type rc_dev_type = {
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
@@ -1722,6 +1732,7 @@ struct rc_dev *rc_allocate_device(enum rc_driver_type type)
 		spin_lock_init(&dev->rc_map.lock);
 		spin_lock_init(&dev->keylock);
 	}
+
 	mutex_init(&dev->lock);
 
 	dev->dev.type = &rc_dev_type;
@@ -1916,12 +1927,6 @@ int rc_register_device(struct rc_dev *dev)
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
@@ -1978,8 +1983,6 @@ int rc_register_device(struct rc_dev *dev)
 out_rx_free:
 	ir_free_table(&dev->rc_map);
 out_raw:
-	ir_raw_event_free(dev);
-out_minor:
 	ida_free(&rc_ida, minor);
 	return rc;
 }
-- 
2.53.0

