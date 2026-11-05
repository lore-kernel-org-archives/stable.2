Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844080;
	b=0ivj0Bxx9Uvwk8uWCzRLEwzrLhjiCG0u4Z902SWzu89bINAlrAEiV+IQzcpWs3GPPPah
	 owRv3gHzj8aOermPwH7s0Hq17bLYa3zmXj4+4YtvAfySN/YJsMhDCuqqV0+BPo406sbS/
	 R4Q7aMvVT0B6I6Ivnio2CJy7cGNuWOCVHID9QGalcupcaXO3wbdU5upckJZ6vWm+nCPMx
	 DFy+n7upAIMZ8zEhsgVZa4HJVnJTIDlBEUMjNpIaq/VjadEmpAQVmesgcNMzsn0INHVv3
	 HXTZXGf/YjfEDT13cOeIfUngqwbLAzspwlc+1OWp7HXx0gOl0eA2xOsUUSc1x4LP+pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844080;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QB9Xyx3ta39qW431833onDEPcMa3DDKpwmfZIbD84NU=;
	b=TOpMJF8cHlOWgifwkm3ac+UKp5Jayp71QFxihkvNUVo9crn8IGUkHSYo/l5GOt7mANsP
	 vZimjDFsqnD5iYetRQIsmqEnGYt6alyJk0bJgJ/drr1DgFWrXHPNyf1BMXzhNcBNffWpN
	 DjTgdD/Xv4KvPrIH++eixAkIISOdPkJZbMT/ExHRk8xhDiPNP/on+ADLc0IGpjJ2TnnVH
	 etzoLgPgxNdiwAGxefiAWvSL7arGuOhC4JW3TqnW11V/uE7q6uU/DymGjSqWAgpbJhgh7
	 cjoQpuQiXHyXtLpy30YE4t7hpC+7NMLTvm5SvzlKNRAnPElGpo0DmHlchtoandrowGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij+liANE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89D6082BD7
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij+liANE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B50A1F000C1;
	Thu,  5 Nov 2026 02:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844079;
	bh=QB9Xyx3ta39qW431833onDEPcMa3DDKpwmfZIbD84NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ij+liANEPT6vYuqNeVf/xcY4+2J4fjNzvnN9B9Vp/lNw5nWnup/6KwtY6CjZecCEE
	 k2RU1mMbJ7xyf1mY6+t25nfTSOWcu9/5Qw05hYqv+B519XBYfJku7D5wHszjbieeX9
	 kBm4fZntT6GEaM5UmoPYtFUIb2KfAjxzeSYFzBMMNGgVfBjRE42yUZ7sO4v78rDKHV
	 u3WybPpLT3jW+BNn1tJKuhqRPe45h1KuP/CUWrLWGsNbqVeXtPWQ6Fs/UmpGao1h8o
	 589Pkoqvpo5qE5vaISZkOvTjozebkjAbR2h4cRY+Pv2/nJ86Mx0EYsiUhhmlz2g1KC
	 k6WjDsyBMSdng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] media: rc: Fix race condition during rc_register_device()
Date: Wed,  4 Nov 2026 21:01:17 -0500
Message-ID: <20261105020042.1081272-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110404-speckled-pedicure-c48e@gregkh>
References: <2026110404-speckled-pedicure-c48e@gregkh>
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
[ sashal: Retained the existing kzalloc() call instead of kzalloc_obj() in ir_raw_event_prepare(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-ir-raw.c | 20 +-------------------
 drivers/media/rc/rc-main.c   | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index 6da12803fd9e0..1782bbce35559 100644
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
@@ -606,9 +591,6 @@ EXPORT_SYMBOL(ir_raw_encode_carrier);
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
index 2f1684a81eb14..ea262801e1155 100644
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

