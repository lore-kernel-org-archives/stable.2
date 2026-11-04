Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832848;
	b=EM40LAOt9GDGmi1MBU3fxaBq8aQmUqP3vt7Rx+YVT/DsX8oQRmv0T8epJQNEyAxzi/8L
	 i86jSftaHHiVCQvGI/coLqWZN8XRXcWgBTGjQn/zmo023g334O8nQTU3R2eMR8uvUvdM+
	 J6sOISg7+FViJAQjrsF6GDyziIgdpXaiEfdL/aG13J1te0HOyeb69s28YT8lbYfeaxcos
	 OZ1VaA6ylSXnYo4BlavQVDVvvTn8Tiy7FI1J8juxwLj86e8F+JMNWSHLUXeAlsQbrWRGb
	 D53aWsbGRdCc52z3K+BzA/M7qKGpZJndy65Q1UWyzmvo9XiMsFVevQXCoALHsKDoeKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832848;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qgaKUrnarngLCwUfmlp2vJnigIrJi6VP74vlCIus+G0=;
	b=WCnRnTRDnCFkOM8fMCrz2XOdnx5ksUlX/Y/m9+qRqoa4malHw+fSDJ12kZ1Zd5BM+RSc
	 AD/o0QitAT4sUgWtISiVBVnyYEf/i1FC6annjyAMW25Cs9zZxI3kZg0qkJE7g+xyiTqEM
	 OVwTEIw53tsqrC63+C3wkoA6iBdcj3R5/opjF01VaVxaAzpfK6/HdzM8+v0haLrYBMsz2
	 qr62sMTx3mlyIV9bFQ4//mlcOeL53xkJHbGTLfzmZczn+zswhAymiz0GZ0v3cY0IQPmt1
	 qqdC5zb2Vx90hmbupG2vWexSxEUFb2CKYSOkqf0r9NEt37Q5bGImHX4LGVa/YNc5Rxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Mod8O/JQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F59B606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mod8O/JQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422741F000C1;
	Wed,  4 Nov 2026 22:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832847;
	bh=qgaKUrnarngLCwUfmlp2vJnigIrJi6VP74vlCIus+G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mod8O/JQID0c1TLutxj0F9wHQz2/wWR4aXMVPvza1TJGnpbtLyyIW1Uh5pui5ZmQ2
	 nFX2aSGv4nyFuSYiTe3FdjFNbNHBjv7V/5ApvrPkQjsSL4pbpsYlaN7Rgi7Y3ln6QW
	 84DcO/3UGIqduqCXhg82c9QDyp+8lgajxUPVWs4nLHQPa+luLw6iP8rfxe5SeS6uqv
	 VJHPwen6OMobNfgLkB6la4hHERcHO0QHVpv3Suk0AKbxQ6CzS7PROfBzTkBYiy9S/P
	 SJ87EQ/Rcu4p1uPAQttkzj0M60sjKLN1CTIb+oywi0lMSTvoZsXJ7bEp5Fwewg9x5e
	 Za1ZC6tV0w2Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] media: platform: microchip: use for_each_endpoint_of_node()
Date: Wed,  4 Nov 2026 17:54:05 -0500
Message-ID: <20261104225337.851869-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110457-outflank-doorway-6469@gregkh>
References: <2026110457-outflank-doorway-6469@gregkh>
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
 .../microchip/microchip-sama5d2-isc.c         | 21 +++++++------------
 .../microchip/microchip-sama7g5-isc.c         | 21 +++++++------------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 5ac149cf3647f..60b6d922d764e 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -353,33 +353,29 @@ static const u32 isc_sama5d2_gamma_table[][GAMMA_ENTRIES] = {
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
 
@@ -400,9 +396,8 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
 
 		list_add_tail(&subdev_entity->list, &isc->subdev_entities);
 	}
-	of_node_put(epn);
 
-	return ret;
+	return 0;
 }
 
 static int microchip_isc_probe(struct platform_device *pdev)
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 73445f33d26ba..e97abe3e35af0 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -336,36 +336,32 @@ static const u32 isc_sama7g5_gamma_table[][GAMMA_ENTRIES] = {
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
 
@@ -389,9 +385,8 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 
 		list_add_tail(&subdev_entity->list, &isc->subdev_entities);
 	}
-	of_node_put(epn);
 
-	return ret;
+	return 0;
 }
 
 static int microchip_xisc_probe(struct platform_device *pdev)
-- 
2.53.0

