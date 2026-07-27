Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3EF41930F;
	Mon, 27 Jul 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158368; cv=none; b=feBnCA69T9w2g2zPJGp9UzzlACAJ4qEEFwH2veAbQB4upy6Xk/htGwJp+u6WuVtVUIz41gu2GyTvsFUG36UCotrm3yOc+/TjVjliCJEwC9SnXJf2pFnEE3I09K9bfIUUUYj0m5kVqhR2e15X1NN4517USw5hrhXF17Ug5fZii8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158368; c=relaxed/simple;
	bh=K7ko5W5HJKiBlWM2ELJFYSR9RMf2LXHGTp6lVHUSOzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nd5vBAQcBiwzi00iW0pDHDFBsjcXf2kSbHU25H704wpE/XAa7AjbaqUJP/GLa0iK4SCGYWSMsBST3vv0SakvId08pVvEGFW+EgxbmXZCroD8GnmcwX4F07jQT1noH7eRBRs3LPxDd+CTGyZ0ZYXOPFuFyXx48hAem1Lchp6AyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=qQz9nHs3; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=r87taKx/; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="qQz9nHs3";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="r87taKx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158361; bh=K7ko5W5HJKiBlWM2ELJFYSR9RMf2LXHGTp6lVHUSOzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQz9nHs3Za4FUywdN9RrPVVL4yajqrOSk7LRuqiJrVL9WT8uk+AsJcc9ytY84rroi
	 QqUauC1OhtyPGZW7o1NqMnyxWMOnsz4J8JrlsSlDHOwtb4kpCnUTsBK3SqL+UHRLQS
	 C+s4K19h0ORj4UdI8FO+l1/Y94KNqm5oQ3iAcEhAyjeSCjU8M7BFXN0yAbEeO4LN64
	 oumSlMyKOE2hXjqC7ndrE4wA2XUHssEpJJKMjUWANCnCzXVg9EcMGWDM7PRZJkUQ49
	 4oJwZnRO09mf3Lxz6PaIAqg9rwVgZZBROaV2yFMa2pLM6twO0rwHp/Ix6hFhsDfxYL
	 TDCwuOPfAwdAQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 8CD884255A; Mon, 27 Jul 2026 14:19:21 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158360; bh=K7ko5W5HJKiBlWM2ELJFYSR9RMf2LXHGTp6lVHUSOzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r87taKx/on7dJte2skT03NMW2YgTBbzr0x/9xUe0J5OW7H6rjPYfzEeQho+ijXD1z
	 PW9LmrQp1sclPudHDLZ3X6DJS823q4d50jxu+JbujL39cn/agOejgK7cg4sNm7T25V
	 dwLrGRt+9mhabPuTeV1r3pEptn7Sb2XKS/HljupPg6aUUxHRs5/EcnWITxz+PkC3xp
	 avb8Z+cI1AF5icOqrPVgK1uXctR8TR3Y1PQWiaBLIzIACWb+Yos+Uj5yhOwy3xVAxU
	 bFkOMJ+cTAWCRC5F+lh0Ib2ShD0Fmxk+8dSaLRCKvc+xFy+//uD5YzftPUveSUEfMl
	 XD6gc+IOb6sxQ==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id A740642570;
	Mon, 27 Jul 2026 14:19:20 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/15] media: rc: Fix race condition during rc_register_device()
Date: Mon, 27 Jul 2026 14:18:58 +0100
Message-ID: <5479a9288629888ea5a9f25b5ac03a7384d1dce3.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct sequence for rc core is so:

     rc_allocation_device()

     /*
      * setup hardware and now calls to ir_raw_event_store etc are
      * permitted, as well as rc_keydown. There is no rc device in sysfs
      * or lirc chardev.
      */
     rc_register_device()

     /*
      * After rc_register_device(), the rc device can be used now from lirc
      * chardev, sysfs and IR is now decoded and reported.
      */

     rc_unregister_device()
     /*
      * User space can no longer access /dev/lirc or the rc sysfs
      * attributes. They will get -ENODEV if they still have a file
      * descriptor open.
      * Calls to ir_raw_event_handle() etc or rc_keydown() are permitted
      * but they must stop before the call to rc_free_device(), so
      * this is the time to stop the hardware.
      */
     rc_free_device()

This means that during rc_register_device(), we can get calls to
ir_raw_event_{store,handle,overflow,store_with_filter}. Ensure this
is done race-free.

Fixes: a3572c34da8d ("V4L/DVB: ir-core: Add logic to decode IR protocols at the IR core")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-ir-raw.c | 20 +-------------------
 drivers/media/rc/rc-main.c   | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index b32f3cff9401..bebb45ffa971 100644
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

