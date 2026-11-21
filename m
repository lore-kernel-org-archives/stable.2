Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300583;
	b=MiJvDNQacfI3FQK6FwqPhyR9nIf/R4snaOxt0kqpJMnzRaV5te4/QGEZ69gkYHElzPSu
	 TG59vhKf49qx9ZzOvCL6ZoHWtZcc5kqFcTSvFBDsjNjGMQdP9HIRaRaRGmy8brMrRvvxq
	 Dxl6fMo8hwoWfWNg6rrE48kWF1JfROfClSn8Zeq5fbnLJS7VdWlOF9Wz4d1cjvFlG0JIY
	 JBwKdpOBNVv88anWLamXnycnbWQk9VA2t9IfBLAylWdOdXzPQXqE7Gk9LVAHWFt/09k4r
	 0rmqnIaW9rfLbvk0V1V5C4mSCYTbAsQ06EbPAgJbQNB9DCHXjdMHaAdCUJYsFPF66Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300583;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9N2WNj7YVmlCUwAen74jHLg5hKAx6GwlKsGjT+YsiuU=;
	b=U/yfKO9yZZX2chKwXhDYg5+B365IKsFnXkLvA+gX3WKEowW9XvIRpEjVujsXuhS0iPPu
	 riO1Vev/AwKN22uDT81LZoTvMTRLqgCP1O6HA/1OXo1QNd3XqSw9Zn4E3wM2lxDBXTwPs
	 Jkmn8XYMjkXW85l3KSyRYfZ9HV0kPzmesd049Nmmwzr7WOl7Fhins05Tr9zrVQmy81bit
	 nz0zUBLFJXSPrr8hMAnup72WOAnge9lImWhI3sZ8I47EmJsJc7JdEl6mIxXgoARp5eLKS
	 T3Q7e/1C3AI+tjJeTV18ROAlsrZvv5DsZvkDjraqv/RFv98O9LzW15Kl+r32ACSu8UA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=I6zkEpQA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE01606A32A;
	Sat, 21 Nov 2026 22:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE01606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=I6zkEpQA
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CCC45202BB2;
	Sat, 21 Nov 2026 23:36:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N2WNj7YVmlCUwAen74jHLg5hKAx6GwlKsGjT+YsiuU=;
	b=I6zkEpQAi7cd+tYL9HNC8OMso1lYYovGPAnT+fQTcqpwE3JL4yeFfcz8DmyIaQpeDixdgJ
	BxX+lbGIJVvO+vNIufzdpl5b7PCJ60ECG0hC25EG681OXuk76ASpRy78geWVkksO+u4sIz
	/AHvpaKUa1f3i3zAzGQyLmHgNBdtFD/KFzQsTvJWk1+nC0jbOFrrUIqRkZa/QYXVPs9IVt
	T8OknIsZubBUBg9tuNtTlXUW5rm+eR+t5pSW05mYJJADc541+P9HbCEUJidCYn21uoyiT2
	eTgR5abkerGQ0kObn8NSTPDKLNxbw9cW6R7tf53atwC+W/Y6GDnfX2nRMDZCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N2WNj7YVmlCUwAen74jHLg5hKAx6GwlKsGjT+YsiuU=;
	b=Yv5Yu3j0tsSB1JZr2Jbk3KkfL+FXrCgUmjkWxzZHJENMnDY7QJ83eaCzn736pu8m25/FHe
	o3IugXk7gQXhz4Xaufiqynw7QlkP9NY84lUHwvDsSrCyF0Ho5xQdLuagvES8V/djG/qmyg
	QYOK+8143952xf3lmqMDhE+yiiYmKlUxaFD8Xg+YSlppajkrhdky/k0sH5+gTrQearCX8f
	Jqts4PkDbOLEj69pOB828iy2V5cBOTYwauz4owqb0fn4t3hM6vPP+7TAY1d2tfNyxmvotc
	hoa0huLImOkZ7GLeHZSYGFIJEo5wBWg2jfopBkZVXR9yHyzKA3GaGqUi2mvbmg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300579; a=rsa-sha256;
	cv=none;
	b=RZECxHS0dghjNukKyAz8rDbRPU8FMpY4Kq8M5RfMQolg3urPk/nDGdGUaZPubnOj8yT5Dx
	icd9ezRlGu5P6NI9aSqC0M/2y2RPb9PiYfGpgSfPswh8SMIvh38rDLW8nYben7cIyG3wEJ
	XY/YU1x1aaT+jVgv+jkKPEvvGV3u3hhl+N7YUetLTdINOb7rYeqWDqf5M3poB4aWq/R9Sq
	auN1Ny3PjQSlTMJ5dkyIOQgHM6FnnHKYHQEKmtqHy+NvXype1RwLhdl3Ema26QbDAlEGC4
	HGDQG3BpK6i0St/8w+J/GRpCActwuuZ8HVPV0WbcZcxW3S2Fu2RH+fTCpfS8Eg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:35:59 +0100
Subject: [PATCH can-next v9 01/13] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-gs_usb-fixes-v9-1-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=4265; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/jUR29lrku0FN0ClogEy+hCBXwhs8H/ok5eQXLbPN70=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrm8dNaFLeZa3wVenf0ruPC+Paf/zKlx097s3rNmS
 oK8ovjUXR2lLAxiXAyyYoosS3+cUBQIdCjtfZkwCWYOKxPIEAYuTgGYiM0Chr/CXLGbSltOZsk/
 bdnbz/Vqzwf+zMfXZjDHCZwUaBWZdTeC4a+M5KnVXZdu9G39nOAbtFPfN07y5sVbf6V/3rnaMWO
 XzB9WAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

In gs_usb_probe(), gs_make_candev() is called to allocate and set up the
CAN channel, as well as to call register_candev(). However, gs_usb_probe()
defers the assignment of dev->parent and parent->hf_size_rx until after
gs_make_candev() returns. This opens a race window for the user space to
bring up the CAN interface, while it's not completely setup.

To close the race window, initialize all CAN interfaces in a first loop and
then register them in a second loop: Don't call register_candev() from
gs_make_candev() but explicitly from gs_usb_probe(). Adjust
gs_destroy_candev() likewise, move unregister_candev() to
gs_usb_disconnect() and the error paths in gs_usb_probe(), to keep it
inverse to symmetric to gs_make_candev().

Closes: https://sashiko.dev/#/bug/linux-be54de7d-0b75-408c-b3ee-dd90c9756857
Closes: https://sashiko.dev/#/bug/linux-71076d59-0843-4749-a5ab-fdd98a08582f
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 64 +++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..d1124c49460e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1490,18 +1490,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
-	rc = register_candev(dev->netdev);
-	if (rc) {
-		dev_err(&intf->dev,
-			"Couldn't register candev for channel %d (%pe)\n",
-			channel, ERR_PTR(rc));
-		goto out_can_rx_offload_del;
-	}
-
 	return dev;
 
-out_can_rx_offload_del:
-	can_rx_offload_del(&dev->offload);
 out_free_candev:
 	free_candev(dev->netdev);
 	return ERR_PTR(rc);
@@ -1509,7 +1499,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 static void gs_destroy_candev(struct gs_can *dev)
 {
-	unregister_candev(dev->netdev);
 	can_rx_offload_del(&dev->offload);
 	free_candev(dev->netdev);
 }
@@ -1587,21 +1576,16 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 	for (i = 0; i < icount; i++) {
 		unsigned int hf_size_rx = 0;
+		struct gs_can *dev;
 
-		parent->canch[i] = gs_make_candev(i, intf, &dconf);
-		if (IS_ERR_OR_NULL(parent->canch[i])) {
+		dev = gs_make_candev(i, intf, &dconf);
+		if (IS_ERR_OR_NULL(dev)) {
 			/* save error code to return later */
-			rc = PTR_ERR(parent->canch[i]);
+			rc = PTR_ERR(dev);
 
-			/* on failure destroy previously created candevs */
-			icount = i;
-			for (i = 0; i < icount; i++)
-				gs_destroy_candev(parent->canch[i]);
-
-			usb_kill_anchored_urbs(&parent->rx_submitted);
-			kfree(parent);
-			return rc;
+			goto out_gs_destroy_candev;
 		}
+		parent->canch[i] = dev;
 		parent->canch[i]->parent = parent;
 
 		/* set RX packet size based on FD and if hardware
@@ -1621,7 +1605,37 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
 	}
 
+	for (i = 0; i < icount; i++) {
+		struct gs_can *dev = parent->canch[i];
+
+		rc = register_candev(dev->netdev);
+		if (rc) {
+			const unsigned int cur = i;
+
+			dev_err(&intf->dev,
+				"Couldn't register candev for channel %d (%pe)\n",
+				i, ERR_PTR(rc));
+
+			for (i = 0; i < cur; i++)
+				unregister_candev(parent->canch[i]->netdev);
+
+			goto out_gs_destroy_candev;
+		}
+	}
+
 	return 0;
+
+out_gs_destroy_candev:
+	for (i = 0; i < parent->channel_cnt; i++) {
+		if (!parent->canch[i])
+			continue;
+
+		gs_destroy_candev(parent->canch[i]);
+	}
+
+	kfree(parent);
+
+	return rc;
 }
 
 static void gs_usb_disconnect(struct usb_interface *intf)
@@ -1637,8 +1651,10 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 	}
 
 	for (i = 0; i < parent->channel_cnt; i++)
-		if (parent->canch[i])
-			gs_destroy_candev(parent->canch[i]);
+		unregister_candev(parent->canch[i]->netdev);
+
+	for (i = 0; i < parent->channel_cnt; i++)
+		gs_destroy_candev(parent->canch[i]);
 
 	kfree(parent);
 }

-- 
2.53.0

