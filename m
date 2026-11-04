Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832849;
	b=aS+r+FJGcNQpwH8xRJfSWZ8MLwsVcfS1trg5IiA/X7EpbcWj8l/gyAdqR4UAKyvYki+i
	 vaKUgbg4a9lyxHjy49c84w12/N7lu1q9+v/MrqQueB18c5eLi6h60qQgfndbFDZJu8TU2
	 T3kZBmowauSiJWHOzVVEUVHkIDYxCdNGCp/AejXSW058lBzuchWTu8fy1OqvXfoHxunq/
	 NTmGRV0Z8/arJ9EqB3ggBjZ5Gh8rPHcWDAbrgDpvkUGy45je1uhs8UVGEJLV6Zlk1Y45+
	 V+GdusCGLLvXGgvmwDWavqeA90Jb82CNA3vsVbBksqooLRtbML2nOsb0gz180RL0n1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832849;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uTaT3wRcFq0+4WYOVXfukVbFadHbxV3B4vLdLjzA3i0=;
	b=p9JAW94fSPB1reHo8TyEGEetR6GT0rsY63exJybsZeOdUD5AIK3pXircyLtbVi6XFzbb
	 Dqm23AoBtUOIVErajQE+K1fPiOywIOGcn1QYICGZwKiqa9j9a8Pc/84ntkbmbSNtlqSJ+
	 w5vLk29DBNWu0azrgJrfA90ZO2WAdyoqVUnxZkFHzV1ktR2orWzTQqY1CTOqGE59o4w9r
	 wrqtUFJW9nUxlnxRnzHzUdIyZnffnFXbhlAkpVKfGhNPp/419enkbeEKqEu3JjJIKXbLO
	 gbXfj3iPcdxpfNFo6cJix/X/JAkTAOJAkhehsw6xKM+kO8e5jq3IJsF8bI80PZtJeuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGjQ5EzP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E7606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGjQ5EzP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1428B1F00919;
	Wed,  4 Nov 2026 22:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832848;
	bh=uTaT3wRcFq0+4WYOVXfukVbFadHbxV3B4vLdLjzA3i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OGjQ5EzPfmwiznrASoG5IcoyvQlryH2zWmEnrP4ld+eqqbkyCPpkKf0TY5m/YdwhQ
	 lcChPHSj86LRHAx0vhMh/w8lDlNSbGsms4Lt704kWbTkBPOEk+T7iWFQS4yrjQ1Rg4
	 LeITRMkkQcbVERh5SGrrFJB2lglw2X2gvH94d1gbXm6zq5BzgSSDOFfeVPbDKnGXWe
	 +1ew+YOUtV4FgBhiklPSNUgh+r36aekNSO8muVatnB/PiSMxsblZkKfq7ErZ/nY8cH
	 o+XGH8vkXBYo29HD2qu16ej99HYxPug4iakFf0QCLYKxIaNXWKRIhSUBYgv68jlHtQ
	 FhOt/Yx1wClZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] media: microchip-isc: take a reference on the parsed endpoints
Date: Wed,  4 Nov 2026 17:54:06 -0500
Message-ID: <20261104225337.851869-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104225337.851869-1-sashal@kernel.org>
References: <2026110457-outflank-doorway-6469@gregkh>
 <20261104225337.851869-1-sashal@kernel.org>
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

From: Balakrishnan Sambath <balakrishnan.s@microchip.com>

[ Upstream commit f2eb2fd388bf3f1959556a326e797cacca341c86 ]

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
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/microchip/microchip-isc-base.c     |  6 ++++++
 .../platform/microchip/microchip-sama5d2-isc.c  | 17 ++++++++++++-----
 .../platform/microchip/microchip-sama7g5-isc.c  | 17 ++++++++++++-----
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 8dbf7bc1e863b..78a26babf3894 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1902,6 +1902,12 @@ void microchip_isc_subdev_cleanup(struct isc_device *isc)
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
index 60b6d922d764e..4033bfc96bb77 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -356,28 +356,30 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
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
 
@@ -398,6 +400,11 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
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
index e97abe3e35af0..58cfbf6fcd668 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -340,6 +340,7 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 	struct isc_subdev_entity *subdev_entity;
 	unsigned int flags;
 	bool mipi_mode;
+	int ret;
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
 
@@ -347,23 +348,24 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 
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
 
@@ -387,6 +389,11 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
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
2.53.0

