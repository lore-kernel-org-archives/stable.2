Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F74DC527;
	Wed, 29 Jul 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338602; cv=none; b=K0qVz7OY1W+W8i4ng+M2zSzW7aiRtO+daln9LDsDkezoKDaruCzqK1VKHHzFxfjp31WKE/rqBWu9g8+lNEkP4+YYHrqUoZU/2g5iVIEPnNNflFaLMydLfjpPQPiaAz/2LXjDlYI/6yusprEkGV8AYfgkxJiAZ4T42cqIydBqh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338602; c=relaxed/simple;
	bh=AgaIg980bOGUGfz98fPdfhROCvYemFKEJ1jVeBZyrFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp29AsY6T9sL+49+qFxKa+RT2bRMuTTgC0XxJQrBXZJ3rPa1YvTuI8mwCppPanTbxvaTtmzDTmqatwOQSWlwh06TLU3wdjI3EdlYzljJ/HA3lT5e/INDLODg4h9j4CwfcLF/x8b8+IC+VCAu4zPgj5jRr9gBGgPLcPNXVTQFX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=d2HrOVwj; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=BY7JatGb; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="d2HrOVwj";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="BY7JatGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338598; bh=AgaIg980bOGUGfz98fPdfhROCvYemFKEJ1jVeBZyrFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2HrOVwj7eUb6L+bmX6vMlQahaiyQ6JMLz+pDII5cho+QRSPsoAEY8xFrOFhTfgD5
	 HHZrQUWynLZY5Q/0yppKJMolww3eccGxzpFJD++FCiiBjPPLotHT7qwBmvwHr3aI4M
	 efrw2vNDgl/gi5+/E/WnhqrCA1OAZ00BiluhEFUmS+8UvngT+YWoNJp5iRQD/QQF1b
	 MUPba7+1R+4Z6NkSqonlC4c7Skv6oUSYyIsJt9BgWcmJyjEfW1snwl01idv/W7z/b1
	 oMxMpENFo+AlbxZMsS1yApZsnXglBtlCQcHjTo7uKOGWuJ1VCeC4yekLsvPe7N1nUT
	 ehZWaaLZCRC+Q==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id BDF8541567; Wed, 29 Jul 2026 16:23:18 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338596; bh=AgaIg980bOGUGfz98fPdfhROCvYemFKEJ1jVeBZyrFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BY7JatGbox0LGUf4E/g2YQ7Lu2nfbgImtk1k/1/tI3j4+Dqfl5kflYSk67L4ASKnH
	 iQ9PXxvNVkHUc+c+nSFG7wob37o1jJJju1B2QWxYtti0CStc1EWS+pEtkjt8doLs7E
	 v5mws5mbl96kjuNaSg5FdXMBftnbpYajc0XO9mgFohJnN4+WwQ/7g+Xp6L2LEtVB52
	 I90BeBOygbhbPkwWmPh4y9QKapbSOVNhVrJANvJF4yxi9whIE7cZBfRkCsnUQwlFZi
	 YV6wi4csL/hV7o+c5Jl3N4Z9neSH7qwLmBD5e+BsjcAqWTlVn9zDg8EjfRCMYyTMjO
	 uJyLgDv3Lbi+A==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id C9DDD42542;
	Wed, 29 Jul 2026 16:23:16 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/15] media: rc: Fix race condition during rc_register_device()
Date: Wed, 29 Jul 2026 16:22:51 +0100
Message-ID: <1178dae8744431b7adf8cc92dfb42270cd56b700.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/media/rc/rc-ir-raw.c | 20 +-------------------
 drivers/media/rc/rc-main.c   | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index ba24c2f22d39..46c50f423798 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -71,9 +71,6 @@ static int ir_raw_event_thread(void *data)
  */
 int ir_raw_event_store(struct rc_dev *dev, struct ir_raw_event *ev)
 {
-	if (!dev->raw)
-		return -EINVAL;
-
 	dev_dbg(&dev->dev, "sample: (%05dus %s)\n",
 		ev->duration, TO_STR(ev->pulse));
 
@@ -102,9 +99,6 @@ int ir_raw_event_store_edge(struct rc_dev *dev, bool pulse)
 	ktime_t			now;
 	struct ir_raw_event	ev = {};
 
-	if (!dev->raw)
-		return -EINVAL;
-
 	now = ktime_get();
 	ev.duration = ktime_to_us(ktime_sub(now, dev->raw->last_event));
 	ev.pulse = !pulse;
@@ -129,9 +123,6 @@ int ir_raw_event_store_with_timeout(struct rc_dev *dev, struct ir_raw_event *ev)
 	ktime_t		now;
 	int		rc = 0;
 
-	if (!dev->raw)
-		return -EINVAL;
-
 	now = ktime_get();
 
 	spin_lock(&dev->raw->edge_spinlock);
@@ -166,9 +157,6 @@ EXPORT_SYMBOL_GPL(ir_raw_event_store_with_timeout);
  */
 int ir_raw_event_store_with_filter(struct rc_dev *dev, struct ir_raw_event *ev)
 {
-	if (!dev->raw)
-		return -EINVAL;
-
 	/* Ignore spaces in idle mode */
 	if (dev->idle && !ev->pulse)
 		return 0;
@@ -200,9 +188,6 @@ EXPORT_SYMBOL_GPL(ir_raw_event_store_with_filter);
  */
 void ir_raw_event_set_idle(struct rc_dev *dev, bool idle)
 {
-	if (!dev->raw)
-		return;
-
 	dev_dbg(&dev->dev, "%s idle mode\n", idle ? "enter" : "leave");
 
 	if (idle) {
@@ -226,7 +211,7 @@ EXPORT_SYMBOL_GPL(ir_raw_event_set_idle);
  */
 void ir_raw_event_handle(struct rc_dev *dev)
 {
-	if (!dev->raw || !dev->raw->thread)
+	if (!dev->raw->thread)
 		return;
 
 	wake_up_process(dev->raw->thread);
@@ -612,9 +597,6 @@ EXPORT_SYMBOL(ir_raw_encode_carrier);
  */
 int ir_raw_event_prepare(struct rc_dev *dev)
 {
-	if (!dev)
-		return -EINVAL;
-
 	dev->raw = kzalloc_obj(*dev->raw);
 	if (!dev->raw)
 		return -ENOMEM;
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index dda3479ea3ad..d93e98189c1a 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1701,14 +1701,24 @@ static const struct device_type rc_dev_type = {
 struct rc_dev *rc_allocate_device(enum rc_driver_type type)
 {
 	struct rc_dev *dev;
+	int ret;
 
 	dev = kzalloc_obj(*dev);
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
@@ -1917,12 +1928,6 @@ int rc_register_device(struct rc_dev *dev)
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
@@ -1979,8 +1984,6 @@ int rc_register_device(struct rc_dev *dev)
 out_rx_free:
 	ir_free_table(&dev->rc_map);
 out_raw:
-	ir_raw_event_free(dev);
-out_minor:
 	ida_free(&rc_ida, minor);
 	return rc;
 }
-- 
2.55.0

