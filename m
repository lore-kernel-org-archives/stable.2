Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084239;
	b=Ppm5jkqpVaboXdcdW610XFVEXFjTy+YdBacbTEf4oMcNC/DUU3kPNQ2wZ+24/oYalT7C
	 V58DEWr7CNnkhdKExq+eRkn97xNRawhYTdX/P7MQSDym6aSknV4vNaDeh1YPrmsrwCyj5
	 MWS3KhYJWf//I0icnMQPSScai1tG6KvIJ8Uqfs+jBsIl6TPnmkLJxUmbhRYkMPCKO7y46
	 klYLsBfEWDKRgy2+fj76vHBnBdCMg0W+Qu15Ju5p+eB3lOkRYBd+5ipBCnyTOA3XMQE8q
	 lb/eX27pYNkSJeJMT2pZvxO4izJuUvotq2Mo5YS12dPnLq2KUx5l81SRWE8dyqW+f7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084239;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=pRNMKUxHBHa2Apv5r1Y7542NpZLiiBP519/s4FlUMAw=;
	b=dlaXmtAa02RqMlXPPiY7QeXT4kJ64fhRiU8m7CvdX1x9wUBbHai4f9jLRzXOiqqpc48b
	 BC7dKlcVRVGagygEXcYxOYMpl9YEWzizkKCrUB/zMEyjfDRitjmM+BVRn+nHuG5ll4kHN
	 QVlVU5372med+ZdTi50s5M93hNGDQ85a6U3aheSWfrJ2j1SxtGIVyrYTw6KjAIgd4hi7Z
	 /2cPSSe9LTmth3NOoXbcpGn1hK8ZcPU+oJDNqa6szxgsqD/Hruubab1NNpA8HGJlJiEDb
	 VrIW/dT6d9FH7MoyzAtUmZ0RlFlrZKd5BG0l+s1SxfSGrk+XSDGAU0aW3wsiHsE9ElQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bwAsvIEp;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D6606A323;
	Tue, 27 Oct 2026 06:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA9D6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bwAsvIEp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pR
	NMKUxHBHa2Apv5r1Y7542NpZLiiBP519/s4FlUMAw=; b=bwAsvIEpMwavS2NKX5
	3UsiiKbg8MFRRa2K0YYrg07O0irRjyG8BHRNuquZ0etUJuGRq5t9DrNpINm3CToC
	lu/lIW84LVXfvG6uae5Vhjs225SBmnUeyTem19UBZr8GzAR6ztabP+lR/s+7cKfB
	JbCWO0OLtpXNPXOS6mgnK9pX4=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3f3srS+BqJPR6DA--.54486S4;
	Tue, 27 Oct 2026 14:56:46 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Kameron Carr <kameroncarr@linux.microsoft.com>
Subject: [PATCH v3 2/2] Drivers: hv: vmbus: copy dynamic IDs before dropping the lock
Date: Tue, 27 Oct 2026 14:56:42 +0800
Message-Id: <20261027065642.2280297-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027065642.2280297-1-yaojiale02@163.com>
References: <20261027065642.2280297-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3f3srS+BqJPR6DA--.54486S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFWxKFWxtFWrKFWxZr4Utwb_yoW7Gryfpa
	1DWFWYyrW7GF1fW3s3Zr18AFyY9wnFq3WY9rnYk3ZxKF9IyryUXayxtFWjvasYyrWUGF12
	yF1UtryrAFWDZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7DG5UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8A6w6mrgSy4PSAAA3M

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
Tested-by: Kameron Carr <kameroncarr@linux.microsoft.com>
Reviewed-by: Kameron Carr <kameroncarr@linux.microsoft.com>
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hv/vmbus_drv.c | 34 ++++++++++++++++++++--------------
 include/linux/hyperv.h |  1 +
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1037117e2d81..1cacbc71266f 100644
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
@@ -864,9 +866,13 @@ static int vmbus_probe(struct device *child_device)
 	struct hv_driver *drv =
 			drv_to_hv_drv(child_device->driver);
 	struct hv_device *dev = device_to_hv_device(child_device);
+	struct hv_vmbus_device_id dev_id_copy;
 	const struct hv_vmbus_device_id *dev_id;
 
-	dev_id = hv_vmbus_get_id(drv, dev);
+	dev_id = hv_vmbus_get_id(drv, dev, &dev_id_copy);
+	if (!dev_id && !is_hvsock_channel(dev->channel))
+		return -ENODEV;
+
 	if (drv->probe) {
 		ret = drv->probe(dev, dev_id);
 		if (ret != 0)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index e61f9a4cb7c3..1d5862725f24 100644
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

