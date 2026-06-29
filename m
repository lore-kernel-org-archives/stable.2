Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB63B71D6;
	Mon, 29 Jun 2026 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731386; cv=none; b=b1f35ufbHYK24yWPpJ165XgDDQagHSnub8IUGXGMg/8n73uoM/96GF6Jqy/xiAXwvdlWK3LXKKqxHMr/MvTtpDkQhjvFeX+HyQSRQMMKyWHv04IdDRm2Ksf2PMg+sTQvN/+6uBH6v2+JzX+ujKdVeqZ/A7CphjSYpAZqvEkj66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731386; c=relaxed/simple;
	bh=agcXhHZQfY9GSymiB+S4S7qoSlSq70hKgrCm9xXkH+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TLKMX+XpML7hPVwrnaHQYHhJTsRv6JIT1dN+LeDe6UXRK5RVi3sI6GUeWXg17pp4R2EopgIXT+9b65FJlPhHrtHTD5XS9Ts4uU/WEDPZj08+i0v2z3kuVCKM0tOGRgBitInwgnp7AyYDRV2zSotGmCyulhSmQ74ST7REpjCace0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iQRHHKoC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iQRHHKoC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782731385; x=1814267385;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=agcXhHZQfY9GSymiB+S4S7qoSlSq70hKgrCm9xXkH+c=;
  b=iQRHHKoCbQll1xvEJpOrc+BnK+LCYsdEQhC3FNEKnoAsCenTDsB6qv41
   uNcHIt0umcHN/x7Vlekbusu3khKQ8S2omQ45h3UI4GdQNEKj3hlHpi9ju
   OP89MtgSPJHoHg3CiyT+M1hflh+kTxa9gEpENuKMX8tmDwWWqVIJWcLcA
   1Q9CjUr/UzCukQYL7WD4/2QyRzyJf7NLimjWaSquK0CjNgq2r+h+ujWrM
   GecnMB6tBiucIFAx7+iTLJ7jlFv4LagGGk2xCqBJ7UEQ6PnmZBFoOvoah
   yKP+zuE1PYlKsjFY4ajrS0WF6dgPyR6+wxcdUqHaIwK7fHSq7vB6YksaR
   g==;
X-CSE-ConnectionGUID: BX/kHuIhSKSPz1hJiZnQ2g==
X-CSE-MsgGUID: SRYV5SV1SbWdH71qT6NCcg==
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="58973937"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2026 04:09:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 29 Jun 2026 04:09:38 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 29 Jun 2026 04:09:35 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 29 Jun 2026 16:39:27 +0530
Subject: [PATCH v2 02/10] media: microchip-isc: take a reference on the
 parsed endpoints
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-balki-isc-prefix-fixes-v1-v2-2-3b120cc3742f@microchip.com>
References: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
In-Reply-To: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
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
 drivers/media/platform/microchip/microchip-isc-base.c  |  6 ++++++
 .../media/platform/microchip/microchip-sama5d2-isc.c   | 18 ++++++++++++------
 .../media/platform/microchip/microchip-sama7g5-isc.c   | 18 ++++++++++++------
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 45a7af779323..4079c79cb668 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1859,6 +1859,12 @@ void microchip_isc_subdev_cleanup(struct isc_device *isc)
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
index 66d3d7891991..97752eca6d6b 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -356,28 +356,28 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
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
+			ret = -EINVAL;
+			goto err_put;
 		}
 
 		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
 					     GFP_KERNEL);
 		if (!subdev_entity) {
-			of_node_put(epn);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_put;
 		}
-		subdev_entity->epn = epn;
+		subdev_entity->epn = of_node_get(epn);
 
 		flags = v4l2_epn.bus.parallel.flags;
 
@@ -398,6 +398,12 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
 	}
 
 	return 0;
+
+err_put:
+	of_node_put(epn);
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
+		of_node_put(subdev_entity->epn);
+	return ret;
 }
 
 static int microchip_isc_probe(struct platform_device *pdev)
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index b0302dfc3278..1f5debb74f18 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -340,6 +340,7 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 	struct isc_subdev_entity *subdev_entity;
 	unsigned int flags;
 	bool mipi_mode;
+	int ret;
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
 
@@ -347,23 +348,22 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 
 	for_each_endpoint_of_node(np, epn) {
 		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
-		int ret;
 
 		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
 						 &v4l2_epn);
 		if (ret) {
-			of_node_put(epn);
 			dev_err(dev, "Could not parse the endpoint\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put;
 		}
 
 		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
 					     GFP_KERNEL);
 		if (!subdev_entity) {
-			of_node_put(epn);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_put;
 		}
-		subdev_entity->epn = epn;
+		subdev_entity->epn = of_node_get(epn);
 
 		flags = v4l2_epn.bus.parallel.flags;
 
@@ -387,6 +387,12 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 	}
 
 	return 0;
+
+err_put:
+	of_node_put(epn);
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
+		of_node_put(subdev_entity->epn);
+	return ret;
 }
 
 static int microchip_xisc_probe(struct platform_device *pdev)

-- 
2.34.1

