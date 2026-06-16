Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670B543C074;
	Tue, 16 Jun 2026 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610677; cv=none; b=uwfCfoRIAgq9ulCAxZhB+HVY0NIQ5NwMYhEps7Rz4xur4WaSIn0xueWy8baZw1Bd0m8B6Q3WhZmJandfdUYUCXuQb/l9/mtlk0DkiXAma9h0FEkHHq1aujnZy+PIzSnM+YvdGdu0yoEmFmfjFhy9fLAVANE9pILaAi/IeqcRF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610677; c=relaxed/simple;
	bh=agcXhHZQfY9GSymiB+S4S7qoSlSq70hKgrCm9xXkH+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ELzKyC4xsvgJD/9L6cqLkLbnJMvFHMH3JGYVdoQ7+YkrXNMDx/5NvSIbHzlxAfAWeCXqzfDnI7/13TPy7Y2RThslwhFvA4UkVshI5fnRfRR8A8YpKNezTW8Y8RHHryzxM67RbehGCR9/16e3zeyfbj8DCAsryiH3tt8z9I70cVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N2wmaDKs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N2wmaDKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781610675; x=1813146675;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=agcXhHZQfY9GSymiB+S4S7qoSlSq70hKgrCm9xXkH+c=;
  b=N2wmaDKsC9m7PPa3xxt77StMsyykRIUlq4eDAY5Q5998LSonriQLyTAO
   ggjQmwDvU21QdpMyRHljFr8O6JfDTn1C4HjYH4XNrflyxSJwC7Op1p0go
   ODRyArEmMFXyFTBWkrVmzDF6gIELEPBoNMVHXiN2l2wLNaODessxakwdu
   vJAuzTq6Xg7Fvc2QR5tVkYQzbm/5hm6nSzUTAGfvPD2YFwMZNVVm/bF58
   JYkP0zB4hx0B30Nc7zU88xcqoVlu/dhGVy596sL7Q5L0gOQnueqKerb5n
   5Jc6WeVgDgralYC1NADw07SJXdqnUMSh95grYZ4mlQySD5p8FHSbINZNt
   Q==;
X-CSE-ConnectionGUID: WOfSbNrBTfGWclgH6FlLRg==
X-CSE-MsgGUID: sIe+8KqCTSKkP0VOtisOyA==
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="68270788"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2026 04:51:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Jun 2026 04:51:08 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Jun 2026 04:51:05 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Tue, 16 Jun 2026 17:20:57 +0530
Subject: [PATCH 02/10] media: microchip-isc: take a reference on the parsed
 endpoints
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-balki-isc-prefix-fixes-v1-v1-2-b23677fc5ab6@microchip.com>
References: <20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com>
In-Reply-To: <20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com>
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

