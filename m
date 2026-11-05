Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847045;
	b=TBOvX+4BVykSUOerXMbFAN74D2Ancf+QYrIhnGL6M83dP3R5NqcD0IBRiZt6ApdQ4RZS
	 2vcSkbzdADVcgSzM9vpst7MUjCyc0XxcTsa9A5IdmBR1XZYHx7gOYjp0pak3MegRRiuj6
	 2sWf5+Ty0WKIjPhAT/0dQx4k+toeGjVBYvEoeRQMb9HKqGlRAaBWTbnDppc6q8MpPe4Sq
	 8Nys6MGPIV9H7qv+9rdENoOySCwxbS+/+z4hChSNlrvljRlyrsm8HIvA5IPh2sT5iSHWW
	 ONSfjF6dS35Pg1V9PoZb6VfeXHSSsszOv+K0NzR2aGRD9D7FddKmHyNiqujiHhpAH0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847045;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PibmLOtvrMVBNYeDutnN+6K5+icPkI06OsaquK6HS/M=;
	b=g7tvlF/J6HQu0KUFzlvvMLhu8Ge6Q7bpRjuU1VaJHkZnKWsqJCvPreZSy3wEjICdI4mS
	 bY0w/1RS9RYncxrVayj1Lgm2NUl6twf+SCQBUyo0/zQgh7qLkqLc/Hw9Pd+D3qHzoyhC0
	 JIPBZKc3SyNb/UHAHoa4H+cRRqvNiVrUmjfsRNabsaRkOf5ub0z4UO1uA4JzN2B+l3kfF
	 Mpi/rJMaY4KIM9noulrSopOBk36iD0WWJ+5rvx7NaILdE+2u6Kw2slk1tYJKddUSOGlrP
	 QwPbmczFh1kzzTewUUvs8BUSn40v5egF++dCsxB17RIMdI7nTiy+FJLVE0iwW4iisyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh2wUpv1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143D606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh2wUpv1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE031F000C1;
	Thu,  5 Nov 2026 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847044;
	bh=PibmLOtvrMVBNYeDutnN+6K5+icPkI06OsaquK6HS/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wh2wUpv1H7uKkaPH9xzbQVxz6MiiDkM2GMDOQUwq7ZcMbcCzTuXYFBEPr3C25NKuy
	 sbUmaMu/kJVo5L+g85lo+y53RuQAABV15nyXXBSDoM0g6Cfm80mzOWiaSuyR1qQ45+
	 L3x/v9PVBO/R3FWmqphF/Dmd1MpuZo8+3SUnhBFSUGOvnmFbZiwhW41tdHq7lqHnuY
	 F0lfidy2lfMJ3IKl6M9CFgrhBsMDi/b0cno86PRkr2amBSBq69ERYbsHN4BjVediie
	 tpzrpIzTQ68ClLTVDGQAZ5ogxduiBDNJ9Cc3mwuvdoUfojuzKjpnn5pvbUiGqswUxZ
	 UChZRq/jn4KTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: rc: Fix race condition during rc_register_device()
Date: Wed,  4 Nov 2026 21:50:42 -0500
Message-ID: <20261105025023.1213842-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110405-glancing-agreeing-5546@gregkh>
References: <2026110405-glancing-agreeing-5546@gregkh>
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
[ sashal: adjusted context for kzalloc() allocations instead of kzalloc_obj() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-ir-raw.c | 20 +-------------------
 drivers/media/rc/rc-main.c   | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index 16e33d7eaaa2d..bb5c1f157db13 100644
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
@@ -611,9 +596,6 @@ EXPORT_SYMBOL(ir_raw_encode_carrier);
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
index eba0cd30e314d..322c003f5f85d 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1700,14 +1700,24 @@ static const struct device_type rc_dev_type = {
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
@@ -1723,6 +1733,7 @@ struct rc_dev *rc_allocate_device(enum rc_driver_type type)
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
2.53.0

