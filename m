Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3223741;
	Mon, 17 Aug 2026 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949542; cv=none; b=BoPhm2YwVlZgKby9zyiK5sJywKwpWL6uurS3ZJvmCnXmttIhAwEV4EKSXl9D3ASJsDRWJOB56fbYfo8Caw0d0pXJNPuZ5Kgqr+iRgMcqaLzsEZCsWYMvovEHp/fyhPqf0yst3Of4GW6/MdVrAGIEqDr8brZIXYG50XKZDYCTvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949542; c=relaxed/simple;
	bh=PPuWwveO0ERW19jC3hyJIbV4SEC8N4W0p8Skwdf+y5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=njv3FZUAY0i80S2OUxHEQNVHFyDNhiJcQK2c6j8fnxl+z3KyyeQMqOoX++3rzKtXXPrTGrhQYlzPI8JtweOKlRZpkbJyPx7aK6b7ixrTUZ7P5MEbmY3+Vt6F9poSgz911Osok2lUVG6wRC4V+2SntSk5eNv/Bn4/dnHEMTeiPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xTHBwntn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xTHBwntn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786949540; x=1818485540;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PPuWwveO0ERW19jC3hyJIbV4SEC8N4W0p8Skwdf+y5s=;
  b=xTHBwntnN7Uz0zTV+s00I+SCOVaRoYWHpW0n/7qk/uFK43LABIgqnBP4
   tS2a0p9nGjwnjORCasrbICUiuFHcOSK/25EEh6k3O+UY2C43pdlsKQzTY
   +f6yHXer2PaOsL5lIxj4FJx51UUYPYbXIv/NsHcfdxEPStvziVYhRMxto
   iAqZsgq0dAeS/MUesbKAx9pSdNR6BYf+s4eg/o8v0tNJONpcTcQxrzyHB
   SkjmmSWFg8wVh3G9+Zg/BPCY0PqwwfUPH4G5D54JCLS0+tF6uBDvecoRB
   nGp2smu2rd1S7OerXQm9H6I6jdc0j2yZSXQuhYpzicbjV8z+GQWZPRgQX
   w==;
X-CSE-ConnectionGUID: 7F2Wpgj4TpSTeI/jFDlsVg==
X-CSE-MsgGUID: iySwbNavR8+Ld82foVdt3w==
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="61331925"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2026 23:52:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 16 Aug 2026 23:52:13 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 16 Aug 2026 23:52:08 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:21:59 +0530
Subject: [PATCH v5 02/10] media: microchip-isc: take a reference on the
 parsed endpoints
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260817-balki-isc-prefix-fixes-v1-v5-2-2514df336c5e@microchip.com>
References: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
In-Reply-To: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

for_each_endpoint_of_node() drops the reference on the current node as
it advances. xisc_parse_dt() and isc_parse_dt() store the node in
subdev_entity->epn and release it later with of_node_put(), but never
took their own reference, so the stored pointer refers to an
already-released node. This underflows the refcount and can
use-after-free, reachable through the camera device tree overlay.

Take a reference with of_node_get() when storing the node, and drop it
in microchip_isc_subdev_cleanup() so the entities the bind loop never
reaches on an early exit do not leak it.

Fixes: c9aa973884a1 ("media: atmel: atmel-isc: add microchip-xisc driver")
Fixes: d6701f13bd07 ("media: atmel: Use v4l2_async_notifier_add_fwnode_remote_subdev")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 drivers/media/platform/microchip/microchip-isc-base.c   |  6 ++++++
 .../media/platform/microchip/microchip-sama5d2-isc.c    | 17 ++++++++++++-----
 .../media/platform/microchip/microchip-sama7g5-isc.c    | 17 ++++++++++++-----
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index eebbcb28a7ee..ca4f3b5f58aa 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1853,6 +1853,12 @@ void microchip_isc_subdev_cleanup(struct isc_device *isc)
 	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
 		v4l2_async_nf_unregister(&subdev_entity->notifier);
 		v4l2_async_nf_cleanup(&subdev_entity->notifier);
+		/*
+		 * Release the endpoint reference taken while parsing. It is
+		 * NULL for entities the bind loop already consumed, so this
+		 * only drops the ones left over on an early exit.
+		 */
+		of_node_put(subdev_entity->epn);
 	}
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 25d241b4c66a..18e1ec0b94fa 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -357,28 +357,30 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
 	struct device_node *epn;
 	struct isc_subdev_entity *subdev_entity;
 	unsigned int flags;
+	int ret;
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
 
 	for_each_endpoint_of_node(np, epn) {
 		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
-		int ret;
 
 		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
 						 &v4l2_epn);
 		if (ret) {
-			of_node_put(epn);
 			dev_err(dev, "Could not parse the endpoint\n");
-			return -EINVAL;
+			of_node_put(epn);
+			ret = -EINVAL;
+			goto err_cleanup;
 		}
 
 		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
 					     GFP_KERNEL);
 		if (!subdev_entity) {
 			of_node_put(epn);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_cleanup;
 		}
-		subdev_entity->epn = epn;
+		subdev_entity->epn = of_node_get(epn);
 
 		flags = v4l2_epn.bus.parallel.flags;
 
@@ -399,6 +401,11 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
 	}
 
 	return 0;
+
+err_cleanup:
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
+		of_node_put(subdev_entity->epn);
+	return ret;
 }
 
 static int microchip_isc_probe(struct platform_device *pdev)
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 998146adabd8..d0b91a74bb1a 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -341,6 +341,7 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 	struct isc_subdev_entity *subdev_entity;
 	unsigned int flags;
 	bool mipi_mode;
+	int ret;
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
 
@@ -348,23 +349,24 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 
 	for_each_endpoint_of_node(np, epn) {
 		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
-		int ret;
 
 		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
 						 &v4l2_epn);
 		if (ret) {
-			of_node_put(epn);
 			dev_err(dev, "Could not parse the endpoint\n");
-			return -EINVAL;
+			of_node_put(epn);
+			ret = -EINVAL;
+			goto err_cleanup;
 		}
 
 		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
 					     GFP_KERNEL);
 		if (!subdev_entity) {
 			of_node_put(epn);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_cleanup;
 		}
-		subdev_entity->epn = epn;
+		subdev_entity->epn = of_node_get(epn);
 
 		flags = v4l2_epn.bus.parallel.flags;
 
@@ -388,6 +390,11 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 	}
 
 	return 0;
+
+err_cleanup:
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
+		of_node_put(subdev_entity->epn);
+	return ret;
 }
 
 static int microchip_xisc_probe(struct platform_device *pdev)

-- 
2.34.1

