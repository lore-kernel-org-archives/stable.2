Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A03AFB01;
	Thu,  4 Jun 2026 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780545502; cv=none; b=okK4/0BXi0AEGuBmwkIFNpKIFCVh4ftimJPjEWlXzWwMDMdrZs1RluD3gD6GpRPLiy5xDjiR7Bs+zXxQdV29FnNwf6fuJtXhWOspURDlk/Nc6yc0DJe+dmuKLng2NQhl3LViB57OjckVRCg2ltIAfHLbWMI+/C589cyTLBVOCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780545502; c=relaxed/simple;
	bh=m2r3NnCy/KZ84xotuXv71W3230SYAAJzBbEbXOOXLXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPnzivW9BnNkyyG2AxmVwcJjvCgosfgrLBz79TE2ubz8jz5Sh7eL5qj+UyCSiDhZlfYTXqyNcfHPpSVB6Gd+yE3G9plqT+qqU57qKjzxFSkElgfjktnbvDxHbGAJ/lFX4wH/nyZiOaAaul+wm/ZrFmzzVAE7B06ElbxgCM7FX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=LSLVJ0ra; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="LSLVJ0ra"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4103cca56;
	Thu, 4 Jun 2026 11:52:53 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: dakr@kernel.org,
	driver-core@lists.linux.dev,
	linux@armlinux.org.uk,
	andersson@kernel.org,
	mathieu.poirier@linaro.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com,
	linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] vmbus: use generic driver_override infrastructure
Date: Thu,  4 Jun 2026 11:52:38 +0800
Message-Id: <20260604035239.1711889-4-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604035239.1711889-1-runyu.xiao@seu.edu.cn>
References: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>
 <20260604035239.1711889-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e90c337db03a1kunm0f81216d28d16
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0xJVk5NH05JSk0YH08ZH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=LSLVJ0raer3sjupnvQRNaKHY/z4PoUoLkIehpjSWd0fRNN+6OkVsCv3khotgx6wZa7J6GZKBfvF17jJhZess5RurpNSUWU2llTJFBo1D6kTW7Bl7XBRg6y2cvxNGw4FUPkq5jzCwNJXGHpIVkOIs0/CzHHIWetOpMUQODPuZ5rE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=1saAZ4M5FGw32ryywngoGqoPoT+AUfoWbT4m71a/aNs=;
	h=date:mime-version:subject:message-id:from;

VMBUS devices still keep driver_override in bus-private storage.

The sysfs write side updates that string through driver_set_override(),
which replaces the pointer and frees the old value. However,
driver_match_device() can call into hv_vmbus_get_id() from
__driver_attach() without holding the device lock, and hv_vmbus_get_id()
still dereferences that private pointer directly.

That means a bind/reprobe path can race with a concurrent
driver_override update and make the match logic inspect freed memory.

Switch vmbus to the driver-core driver_override infrastructure. This
removes the private driver_override storage and uses
device_match_driver_override() for the locked read in the match path.

Keep the existing vmbus semantics intact: if driver_override matches but
no dynamic or static device ID matches, continue to return the dummy
vmbus_device_null ID so override-only binding still works as before.

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/
Fixes: d765edbb301c ("vmbus: add driver_override support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
drivers/hv/vmbus_drv.c | 36 +++++-------------------------------
include/linux/hyperv.h |  6 ------
 2 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d28ff45d4cfd..a81e2b097636 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -538,34 +538,6 @@ static ssize_t device_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(device);
 
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct hv_device *hv_dev = device_to_hv_device(dev);
-	int ret;
-
-	ret = driver_set_override(dev, &hv_dev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct hv_device *hv_dev = device_to_hv_device(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", hv_dev->driver_override);
-	device_unlock(dev);
-
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 /* Set up per device attributes in /sys/bus/vmbus/devices/<bus device> */
 static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_id.attr,
@@ -596,7 +568,6 @@ static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_channel_vp_mapping.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
-	&dev_attr_driver_override.attr,
 	NULL,
 };
 
@@ -708,9 +679,11 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *
 {
 	const guid_t *guid = &dev->dev_type;
 	const struct hv_vmbus_device_id *id;
+	int ret;
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
+	ret = device_match_driver_override(&dev->device, &drv->driver);
+	if (ret == 0)
 		return NULL;
 
 	/* Look at the dynamic ids first, before the static ones */
@@ -719,7 +692,7 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *
 		id = hv_vmbus_dev_match(drv->id_table, guid);
 
 	/* driver_override will always match, send a dummy id */
-	if (!id && dev->driver_override)
+	if (!id && ret > 0)
 		id = &vmbus_device_null;
 
 	return id;
@@ -1021,6 +994,7 @@ static const struct dev_pm_ops vmbus_pm = {
 /* The one and only one */
 static const struct bus_type  hv_bus = {
 	.name =		"vmbus",
+	.driver_override = true,
 	.match =		vmbus_match,
 	.shutdown =		vmbus_shutdown,
 	.remove =		vmbus_remove,
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 964f1be8150c..f9ede569602d 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1272,12 +1272,6 @@ struct hv_device {
 	u16 device_id;
 
 	struct device device;
-	/*
-	 * Driver name to force a match.  Do not set directly, because core
-	 * frees it.  Use driver_set_override() to set or clear it.
-	 */
-	const char *driver_override;
-
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
 	struct device_dma_parameters dma_parms;
-- 
2.34.1
