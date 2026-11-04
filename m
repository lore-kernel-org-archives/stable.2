Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833966;
	b=ZwJwjWgra0P9eGHGou5GQXkEmNRcvAVl/L/mcA4oxEAlHKxv0SZaN2Ja23GZK3keDtoA
	 9sdxAVhFb3JstK6Frr2v6wLWGapclnuftFNelrGq1uFdSZUjnejXrnh/G5IE5dRm80OMZ
	 SZ8QKTmss5zWtuW24WTr/Pd5nviw9zQ6R0LK2gplipF6gThZj+iMLvYs/VNeUu0jpbY5O
	 77LmpM8Cr7FsHnuy+B7mL8sZN4ApNLN44kXxd4np5aKP8iC/Fo3rahL8SuL59PYHXQO0U
	 6O1lk/TMfV26uoY8G89qHO/v21K42R9TuVcu8hxLaoRh9kCCUnwqu0btz7k8p8IVnkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lqYr/7xUxOu/yCVdOM2U+1y3Y7LtNuhsSsv9FAAhzdY=;
	b=fBwazjxtanFX4R80tfDhjuTsu6e53/t6DYcaIGzKWN+rm+04e6+3ciE37WKYS1WS4Azk
	 V5WfRJc/50OfUSLaH0iJFVUR8WQM5COUGpf6oZz565DDISBFAeTP+eo/OqLpqwrrb8SET
	 ZVQO9jyJ0udSV8OUG7m58ulYqMZ0U1aDOUpSdDlUz5oPXp3pur6fiFR8N9+JzrsqlKprD
	 +P4bjkeGRCQA49UK0a/15H/DsF17KqbGpWOCr6NfKUlPKF7c1F3Wc6mtRL3EXz8s09CMJ
	 NWCGtEXGDfRwnNg07bRuT9FuPmlmJiJLcHfet8r7d6vUxzlDi+hWiMdvn+AIUW3brGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FP2GKTCM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583FD606D80D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FP2GKTCM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14211F00A1A;
	Wed,  4 Nov 2026 23:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833966;
	bh=lqYr/7xUxOu/yCVdOM2U+1y3Y7LtNuhsSsv9FAAhzdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FP2GKTCMffSIx5cPUnBLtecnUXZVAdvSRTaEwPbA3VVG2f5V8DA/uzHpPVcNiqLC5
	 jJYTWzgZq/jvWKMF4fLI/YC2sWwVP66RN7Y34ACRHW0z+YIlMKgVtI7pD1naNz9eLH
	 uL8WPW0DUicKSQFbEQvVdTZrqH7W5zny9+1P2qyqTVtr/a/eK89+S+7AJULswDFALs
	 /ZlUe2A9TmsKtsoqIYc7oS9WmjVJDbrjbCT5UWg+yMr2sHnzRO45pRdU+SdHvZI6+G
	 dk4qLNBH9Cxz+nuaTYRO3Rl8q79fB8oZW0UZoZfuTwfLrm18aj8Jyf0XyP3BecCE3j
	 RdK8OGobGzATQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] media: microchip-isc: take a reference on the parsed endpoints
Date: Wed,  4 Nov 2026 18:12:43 -0500
Message-ID: <20261104231212.888692-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104231212.888692-1-sashal@kernel.org>
References: <2026110457-banking-figurine-e1c2@gregkh>
 <20261104231212.888692-1-sashal@kernel.org>
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
 drivers/media/platform/atmel/atmel-isc-base.c   |  6 ++++++
 .../media/platform/atmel/atmel-sama5d2-isc.c    | 17 ++++++++++++-----
 .../media/platform/atmel/atmel-sama7g5-isc.c    | 17 ++++++++++++-----
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 9e5317a7d5164..b7fc4177f10bd 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1948,6 +1948,12 @@ void isc_subdev_cleanup(struct isc_device *isc)
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
diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index 7689bc2bff481..ea3e8b86a7f31 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -336,28 +336,30 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
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
 
@@ -378,6 +380,11 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
 	}
 
 	return 0;
+
+err_cleanup:
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
+		of_node_put(subdev_entity->epn);
+	return ret;
 }
 
 static int atmel_isc_probe(struct platform_device *pdev)
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index ef0c3c357426f..4bc2f5c7f2f7d 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -320,6 +320,7 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 	struct isc_subdev_entity *subdev_entity;
 	unsigned int flags;
 	bool mipi_mode;
+	int ret;
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
 
@@ -327,23 +328,24 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
 
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
 
@@ -367,6 +369,11 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
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

