Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593242;
	b=uYQU3GTRydbYgzFNcN2/z7qREjnhqO+A9AGvKpYujag9Yzjq7gsP8IgJ3m0Kmk/5dxm6
	 QL3H3oVB34WFU3ey746Qzb0AtB8skujS5U8smwEbCd9E0hayxaGlSQ1F1li9V16JNqkQx
	 lqgPL60yPLJzCTayNS4CJ5KHKHWjSbq7QqrsctPX4mNjTu1YY/XWwtWpt/PQqgWLhqh6J
	 0jeTO1w3W/hbljBV8JYkZkN1Yvx9x7rGzq556IwJmpkw8112JIJ6rORrOhMfAFnQM69th
	 15m0bvJkk9eC2sJCQP2dcB1v6N1GkDhDTSfIPJaPB0kTtJHCAm4kF8M0AC5yTWxhxXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593242;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=slmqaWxrQQkrp1Tvb3tyQrJGfE91dG0et4e+bNJto10=;
	b=1ufI8E+zruRjAiPuxoMeGVHGiyMvHnaEmjzUuT+c5js2dUrPPZy+MFpnSccNN/sAvYbS
	 9EZe3Ga2FT+TuNr5GLGoWixbjCVBQNEs4352HYt7iDbX4tA3NzMGSOtk+28fJdMNj1Too
	 SUcvjRaIvvnv3jlOJnhdWv6eBeLNKsVgUgQIvIhYZEAL5c7HjlZ8VYGBrPHKIZ+0VZ7+3
	 tIjFQujSwuaxBdlzIVybQ69QfN5IGYTeANt2R7KuCUDktus4I20A0gStG+IsUDU3rBPfT
	 Hbdx6jltk4d9rDe+UBc5eoBlQC7KpW4vmmA4YzCKPYeiA1Sqm6ySUpvR/jK0ZIYctvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MDwfeGCK;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1960606A31B;
	Wed, 21 Oct 2026 14:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1960606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MDwfeGCK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sl
	mqaWxrQQkrp1Tvb3tyQrJGfE91dG0et4e+bNJto10=; b=MDwfeGCKfin2swP6iR
	Ctu63uFOlEQDTdWyjVxChrxd/1CoVc6wiGoq0Yv2R4+5GJoF09GTdLDQqCdw+OAA
	fO82vN+CRwjMExIzIujXIxxhNBYr10RFpzcwdmx8FFEjvEzkWUA4PbhjigQnbZwc
	twVCARLlVmR0J9A1FHPLEdNus=
Received: from pc.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHt6Uzzdhqp3_gBA--.20120S4;
	Wed, 21 Oct 2026 22:33:28 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/2] Drivers: hv: vmbus: copy dynamic IDs before dropping the lock
Date: Wed, 21 Oct 2026 22:33:23 +0800
Message-Id: <20261021143323.338146-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021143323.338146-1-yaojiale02@163.com>
References: <20261021143323.338146-1-yaojiale02@163.com>
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
X-CM-TRANSID:PygvCgDHt6Uzzdhqp3_gBA--.20120S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFWxKFWxtFWrtryxWryUKFg_yoW7GF43pa
	1DWFWayrW7GF1Sg3s3Zry8AFyF9wnFq3WY9rnYkasxKF9IyryUXayxtFWYv34FyrWUGF12
	yF1UtryrCFWUAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcmiiUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BhSjGrYzTiZzAAA3k

Dynamic IDs are freed by remove_id_store() while holding dynids.lock, so a
pointer into a dynamic ID entry is valid only while that lock is held.
hv_vmbus_dynid_match() currently returns such a pointer after unlocking. A
concurrent remove_id write can therefore free the entry before a driver
probe dereferences it.

Copy a matching dynamic ID under the lock and pass the caller-owned copy to
the probe callback. This follows the lifetime handling added for PCI by
commit 3ffc4c9690c3 ("PCI: Fix UAF when probe runs concurrent to dyn ID
removal") and for USB by commit ef8154d8b52d ("usb: fix UAF when probe runs
concurrent to dyn ID removal"). Document that the ID is valid only for the
duration of probe.

Because matching and probing perform separate lookups, removal can also
happen between them. Reject the probe if the second lookup no longer finds
an ID instead of passing NULL to drivers which dereference it. Keep the
hvsock exception because it does not use an ID table or inspect the ID.

This issue was found by static analysis of the dynamic ID lifetime.

Fixes: fc76936d3ea5 ("vmbus: add support for dynamic device id's")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hv/vmbus_drv.c | 38 ++++++++++++++++++++++----------------
 include/linux/hyperv.h |  1 +
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1037117e2d81..cc439d9295fa 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -661,21 +661,21 @@ hv_vmbus_dev_match(const struct hv_vmbus_device_id *id, const guid_t *guid)
 }
 
 static const struct hv_vmbus_device_id *
-hv_vmbus_dynid_match(struct hv_driver *drv, const guid_t *guid)
+hv_vmbus_dynid_match(struct hv_driver *drv, const guid_t *guid,
+		     struct hv_vmbus_device_id *id_copy)
 {
-	const struct hv_vmbus_device_id *id = NULL;
-	struct vmbus_dynid *dynid;
+	scoped_guard(spinlock, &drv->dynids.lock) {
+		struct vmbus_dynid *dynid;
 
-	spin_lock(&drv->dynids.lock);
-	list_for_each_entry(dynid, &drv->dynids.list, node) {
-		if (guid_equal(&dynid->id.guid, guid)) {
-			id = &dynid->id;
-			break;
+		list_for_each_entry(dynid, &drv->dynids.list, node) {
+			if (guid_equal(&dynid->id.guid, guid)) {
+				memcpy(id_copy, &dynid->id, sizeof(*id_copy));
+				return id_copy;
+			}
 		}
 	}
-	spin_unlock(&drv->dynids.lock);
 
-	return id;
+	return NULL;
 }
 
 static const struct hv_vmbus_device_id vmbus_device_null;
@@ -685,7 +685,8 @@ static const struct hv_vmbus_device_id vmbus_device_null;
  * If there is no match, return NULL.
  */
 static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *drv,
-							struct hv_device *dev)
+							struct hv_device *dev,
+							struct hv_vmbus_device_id *id_copy)
 {
 	const guid_t *guid = &dev->dev_type;
 	const struct hv_vmbus_device_id *id;
@@ -697,7 +698,7 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *
 		return NULL;
 
 	/* Look at the dynamic ids first, before the static ones */
-	id = hv_vmbus_dynid_match((struct hv_driver *)drv, guid);
+	id = hv_vmbus_dynid_match((struct hv_driver *)drv, guid, id_copy);
 	if (!id)
 		id = hv_vmbus_dev_match(drv->id_table, guid);
 
@@ -843,13 +844,14 @@ ATTRIBUTE_GROUPS(vmbus_drv);
 static int vmbus_match(struct device *device, const struct device_driver *driver)
 {
 	const struct hv_driver *drv = drv_to_hv_drv(driver);
+	struct hv_vmbus_device_id id_copy;
 	struct hv_device *hv_dev = device_to_hv_device(device);
 
 	/* The hv_sock driver handles all hv_sock offers. */
 	if (is_hvsock_channel(hv_dev->channel))
 		return drv->hvsock;
 
-	if (hv_vmbus_get_id(drv, hv_dev))
+	if (hv_vmbus_get_id(drv, hv_dev, &id_copy))
 		return 1;
 
 	return 0;
@@ -860,13 +862,17 @@ static int vmbus_match(struct device *device, const struct device_driver *driver
  */
 static int vmbus_probe(struct device *child_device)
 {
-	int ret = 0;
+	const struct hv_vmbus_device_id *dev_id;
+	struct hv_vmbus_device_id dev_id_copy;
 	struct hv_driver *drv =
 			drv_to_hv_drv(child_device->driver);
 	struct hv_device *dev = device_to_hv_device(child_device);
-	const struct hv_vmbus_device_id *dev_id;
+	int ret = 0;
+
+	dev_id = hv_vmbus_get_id(drv, dev, &dev_id_copy);
+	if (!dev_id && !is_hvsock_channel(dev->channel))
+		return -ENODEV;
 
-	dev_id = hv_vmbus_get_id(drv, dev);
 	if (drv->probe) {
 		ret = drv->probe(dev, dev_id);
 		if (ret != 0)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 9e109d91aa14..0f0423e8a184 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1264,6 +1264,7 @@ struct hv_driver {
 		struct list_head list;
 	} dynids;
 
+	/* The device ID pointer is only valid during the probe callback. */
 	int (*probe)(struct hv_device *, const struct hv_vmbus_device_id *);
 	void (*remove)(struct hv_device *dev);
 	void (*shutdown)(struct hv_device *);
-- 
2.34.1

