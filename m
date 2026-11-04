Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833966;
	b=LbQv4Sjn92zLO0NclLzN9XSTmhDF4V+IT+BvOTvja63BUrAZNETy+wk+T+099oJQWbAa
	 jgErPo9NTXsAMR8/ITEJMwHxdEoAkusUHLzmkqzOsV2h5y1paT4rKt3ra1lx2fRIMYfOi
	 QauPoJKU71PzeSgnRud0caPFDp9ppIdWp7jwTFAVHVVIBbBsbOQ4tQ/Fq2rNPqBjZ4CwT
	 P7J96YodZ8vZ2qRvpY0XRGCxUr5RbyArth+6+z38oCKDePhvyxDGlBExbBIJGFDfqjwkx
	 SCU4wOEUUEGt4uycTj01LnOd/WgJV/M0tk/sz1/WmqtUsZ+Ix+pReUetAZ5yKfPr40g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lnlMcZ+c/S9hI2LOCgF5ymwjH6uyhub08hNg29RLq9o=;
	b=ic3Pf6XZo6fGuUURFJu5ubuEnfaNysxAPB8qDYz8HehmH/4rMK6izDYNcI9AmFLIuWGA
	 BCG4a+l/GltU8cCvacEm4ll/TspEj5mdsuTYKzbLMhgCgBlICzPxuRJp+gmeW1LWjOtEn
	 OE6N8gX2gpzI6NWqPJimPt8F3WiczxI50QTG5ryysYw0f+wupZWFjI3QJ3j+zPYiZan8L
	 FZxEqmGkq84XN8HyzZkpqFuZbPNwSs6FSaWczUT+LmNS6Bw6jKuN/JUkoAvhz2p/2nNq/
	 QQCwNwKGm3R9WcTd1EY40yQY8wmdaniuBVS0SOw1AX1vEBpXuLgIdto/uoJgslk+D8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ksjeo4v6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E7606D807
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ksjeo4v6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9921F00A25;
	Wed,  4 Nov 2026 23:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833965;
	bh=lnlMcZ+c/S9hI2LOCgF5ymwjH6uyhub08hNg29RLq9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ksjeo4v6rpqKrB3BeeiMxowDHOX3dUQPSvyI23kQAoUBaw4RpydZqo9g+A68EcOdC
	 1TCREb9Q7IjJNVEWGOC/VDqanWjjCX8sMk3aGN3j1UNpIjR9gE2Ck4k5P2HgQ2+XR4
	 ye3xPx/eBt7JCiEWAqv+wFmdXEAabetkLEeJ1KAAfSYS0r9H0EQVPd/cH2lVmaSP1e
	 wd832MCd6nO+uMMTbwRySK2ImpgdaqqI4KjKhcWU+EzU8NmPS38Auxvj+pHGaloMqD
	 Iz5uARsZMVYgSUjAOu1PYDCVYEB3QWI9s2sr5vnJzItB3jBJnA0oYvdjKkZrM/uFA8
	 fucOx4D2O6uxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] media: platform: microchip: use for_each_endpoint_of_node()
Date: Wed,  4 Nov 2026 18:12:42 -0500
Message-ID: <20261104231212.888692-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110457-banking-figurine-e1c2@gregkh>
References: <2026110457-banking-figurine-e1c2@gregkh>
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

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 68a1560c3b7f8bb23423b272334fc19279e82d9a ]

We already have for_each_endpoint_of_node(), don't use
of_graph_get_next_endpoint() directly. Replace it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: f2eb2fd388bf ("media: microchip-isc: take a reference on the parsed endpoints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/atmel/atmel-sama5d2-isc.c  | 21 +++++++------------
 .../media/platform/atmel/atmel-sama7g5-isc.c  | 21 +++++++------------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index 9881d89a645b0..7689bc2bff481 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -333,33 +333,29 @@ static const u32 isc_sama5d2_gamma_table[][GAMMA_ENTRIES] = {
 static int isc_parse_dt(struct device *dev, struct isc_device *isc)
 {
 	struct device_node *np = dev->of_node;
-	struct device_node *epn = NULL;
+	struct device_node *epn;
 	struct isc_subdev_entity *subdev_entity;
 	unsigned int flags;
-	int ret;
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
 
-	while (1) {
+	for_each_endpoint_of_node(np, epn) {
 		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
-
-		epn = of_graph_get_next_endpoint(np, epn);
-		if (!epn)
-			return 0;
+		int ret;
 
 		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
 						 &v4l2_epn);
 		if (ret) {
-			ret = -EINVAL;
+			of_node_put(epn);
 			dev_err(dev, "Could not parse the endpoint\n");
-			break;
+			return -EINVAL;
 		}
 
 		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
 					     GFP_KERNEL);
 		if (!subdev_entity) {
-			ret = -ENOMEM;
-			break;
+			of_node_put(epn);
+			return -ENOMEM;
 		}
 		subdev_entity->epn = epn;
 
@@ -380,9 +376,8 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
 
 		list_add_tail(&subdev_entity->list, &isc->subdev_entities);
 	}
-	of_node_put(epn);
 
-	return ret;
+	return 0;
 }
 
 static int atmel_isc_probe(struct platform_device *pdev)
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index 8b11aa8340d7e..ef0c3c357426f 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -316,36 +316,32 @@ static const u32 isc_sama7g5_gamma_table[][GAMMA_ENTRIES] = {
 static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 {
 	struct device_node *np = dev->of_node;
-	struct device_node *epn = NULL;
+	struct device_node *epn;
 	struct isc_subdev_entity *subdev_entity;
 	unsigned int flags;
-	int ret;
 	bool mipi_mode;
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
 
 	mipi_mode = of_property_read_bool(np, "microchip,mipi-mode");
 
-	while (1) {
+	for_each_endpoint_of_node(np, epn) {
 		struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
-
-		epn = of_graph_get_next_endpoint(np, epn);
-		if (!epn)
-			return 0;
+		int ret;
 
 		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
 						 &v4l2_epn);
 		if (ret) {
-			ret = -EINVAL;
+			of_node_put(epn);
 			dev_err(dev, "Could not parse the endpoint\n");
-			break;
+			return -EINVAL;
 		}
 
 		subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
 					     GFP_KERNEL);
 		if (!subdev_entity) {
-			ret = -ENOMEM;
-			break;
+			of_node_put(epn);
+			return -ENOMEM;
 		}
 		subdev_entity->epn = epn;
 
@@ -369,9 +365,8 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 
 		list_add_tail(&subdev_entity->list, &isc->subdev_entities);
 	}
-	of_node_put(epn);
 
-	return ret;
+	return 0;
 }
 
 static int microchip_xisc_probe(struct platform_device *pdev)
-- 
2.53.0

