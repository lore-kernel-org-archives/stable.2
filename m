Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792953402;
	b=LOYVC91diWBFtgkLks1kIxp967aRxFbbfqsAG9TVxdt+IJt5CRLAUp6p+TG0aeKkd5QL
	 7Nph/ZmeZORjru73h156LdctxaT5gC6rN4zSsBdHSDnSRanT15labcQ/fe2WlCGwhvUVb
	 +9CjKyvjIr09IruZncw5sSzICnZ4scJlN/7cUTxBOyKWKhOu0J0S2VGOe0e3V8ujDiNVK
	 w4uNAwP4Q/J8nu8YdJmB9slL8CpRy40vMJ23rKw2CjHGURQ/bhh9XDckzOMt1aPBTybOw
	 KFIVZRaT6CV3m+MqZuYbZXscZ1JRcLglSakeM+d+WtQTX0sB39LGpoNG4tpjTBEac8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953402;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=IDdnfDencCIoYYBiDjFSJYnd7u45twvqsecquPdNc9E=;
	b=3yCNVESsjnwgUDFPUUuY79mk46b9RTyoPKQ3Jyl3GwbkGSl55zExShtIgDuB2E3J4NiY
	 LD2pNkCzWZdo68Rpkn+M2EW79ihqDL3aF4+wgzCIscLnsFWvN0PN+XrqFWyjVV8LFU5pi
	 zlGCJ5DQL7oerLMQkwffUV1zdNUNUIFS41JdcII6rO26UDlZqU9hMDeg99KYzw3jxSTnP
	 pRvgNeNs3l9mqwQKyY1mbkN7w6xvGdMDeWToWhDfNHUtnweE7xQjZKPINhWhF/d+rj+mj
	 +MRtdkwNGpDrBBzoGQ4ttVXDHLoq6crWB4v0U98XWgGI6jNH6GkKxbV2qLq2O0j88aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="Oxc1X/BX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F199606A31E;
	Sun, 25 Oct 2026 18:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F199606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Oxc1X/BX
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3B8D6201E0D;
	Sun, 25 Oct 2026 19:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792953398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDdnfDencCIoYYBiDjFSJYnd7u45twvqsecquPdNc9E=;
	b=Oxc1X/BXNwGwh7Al64QemOytAPW4tH/0T8sdyU/BkcwBGuBc1K4UCk+S63nP5+YrDkk8xr
	5+xkdPRDPivSXPLsAKNUU+bh+2XSabUv4/LbSmDllpoWqDxjIabAsug//L1UqF0jsQUxXc
	r6rk5Zj4s34kiYl3JLUrQ3jY0IkdTdYwQijc3EsSektVstcP/QHV1HynKXBVRTfPE7tpPD
	djKHDWXUyfsz+hkYYfVwbirAD2Tz7thR95TBibzYZA7lsTsnyUo2rE+EWHy2uGI5AR6aD0
	G80WRgd4kjXy9KdFS++M1969fELGFiBAqFGb2GZ/JMR4yLOlzQwKCU+JDvukaA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792953398; a=rsa-sha256;
	cv=none;
	b=OQLd0KlIfWIB5tq3dkyunR4V2qgX+Z2ETL8kV40zHr3jp1Cb6kVxtm5djHhzi7kRy55G1Q
	mnvqk0Q9ZBpvfevixnBOLVKb+IKD51vZJiJFDDkjuJsW5I3LxnFS6Pkie9gIXcfvT1upUP
	9lwFYCzh2wQsn2rRK+Dm/8rJCerZHCvqtfNoto9y+Mv5wfFXns6eNeWXEMszcjnhdiq/TW
	7wmUX0Byfhm3W2kBkOjNtOZv5EMyVEMVmbmsYFFh6flXaSZAd8QRLM/hC1M7AtjEwRzGS0
	/757DrNjieJ4W65mLDwysKmmjs8df8xvq40Pz5jsV0x3+Sg3eTVnqK6Zep2EVg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792953398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDdnfDencCIoYYBiDjFSJYnd7u45twvqsecquPdNc9E=;
	b=ArYwWAmUneIy/j4S4vE0qbDYKHZsTv1QkgBiHzUt4WteJm4yrUqoIMG1z90ha37+97NSMq
	wSbbI5swHeZi8Tp7YPyLafPnmTLm315qhiRCyU0WpQkUKpKJnCdGjOswOYJQUz+BuIzk4T
	IiAbXDcB2o0lJxsQVJH1YIMxLPyOW21c2ZJQ9y5o45+16H4oXNTcMt4fwuWKuRQEl8CoC/
	juUGOwyf3eSQ1+ifzYzw2u+wEyGKmThFASVEyjrHZ3H6lgvj/sqxxlKgubVDLfqTSbgsOW
	ve9v/Qxpiqq9Zgx5hWp3jJPiFZSYCfTcmlOMhnLMpNLKkjqnb37cKFtMAk8qtg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL35C-001AZc-0D;
	Sun, 25 Oct 2026 19:36:38 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7C7275D4139;
	Sun, 25 Oct 2026 18:35:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 25 Oct 2026 19:35:32 +0100
Subject: [PATCH 2/4] can: gs_usb: gs_usb_probe(): init netdev completely
 before register_candev()
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
Message-Id: <20261025-gs_usb-fixes-v1-2-f74ebbd4da36@pengutronix.de>
References: <20261025-gs_usb-fixes-v1-0-f74ebbd4da36@pengutronix.de>
In-Reply-To: <20261025-gs_usb-fixes-v1-0-f74ebbd4da36@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=3107; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=5W9odyizZ4Z85g92rIc4My8WgLffmzts+7Adl0a2Za8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi658MQcZW394vZjNeB/1k5fJY7f9l934ZPb9GSLzMr/
 zEGHp7H2FHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJ/LjFyHD80wOr904LGdQe
 +fxPjpWZIiv3XHyq2atDm98zi8cfNWVhZLhV4ly1NEk2+GpGU1TJ0zsTfI2PH2d+abMk54MQ96/
 X7xgB
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

In gs_usb_probe(), gs_make_candev() is called to allocate and set up the
CAN channel, as well as to call register_candev(). However, gs_usb_probe()
defers the assignment of dev->parent and parent->hf_size_rx until after
gs_make_candev() returns. This opens a race window for the user space to
bring up the CAN interface, while it's not completely setup.

To close the race window, initialize all CAN interfaces in a first loop and
then register them in a second loop.

Closes: https://sashiko.dev/#/bug/linux-be54de7d-0b75-408c-b3ee-dd90c9756857
Closes: https://sashiko.dev/#/bug/linux-71076d59-0843-4749-a5ab-fdd98a08582f
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 45 ++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 15f28833f2de..985d6a9113d9 100644
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
@@ -1593,14 +1583,14 @@ static int gs_usb_probe(struct usb_interface *intf,
 			/* save error code to return later */
 			rc = PTR_ERR(parent->canch[i]);
 
-			/* on failure destroy previously created candevs */
+			/* on failure clean up previously created candevs */
 			icount = i;
-			for (i = 0; i < icount; i++)
-				gs_destroy_candev(parent->canch[i]);
+			for (i = 0; i < icount; i++) {
+				can_rx_offload_del(&parent->canch[i]->offload);
+				free_candev(parent->canch[i]->netdev);
+			}
 
-			usb_kill_anchored_urbs(&parent->rx_submitted);
-			kfree(parent);
-			return rc;
+			goto out_usb_kill_anchored_urbs;
 		}
 		parent->canch[i]->parent = parent;
 
@@ -1621,7 +1611,30 @@ static int gs_usb_probe(struct usb_interface *intf,
 		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
 	}
 
+	for (i = 0; i < icount; i++) {
+		struct gs_can *dev = parent->canch[i];
+
+		rc = register_candev(dev->netdev);
+		if (rc) {
+			dev_err(&intf->dev,
+				"Couldn't register candev for channel %d (%pe)\n",
+				i, ERR_PTR(rc));
+
+			icount = i;
+			for (i = 0; i < icount; i++)
+				gs_destroy_candev(parent->canch[i]);
+
+			goto out_usb_kill_anchored_urbs;
+		}
+	}
+
 	return 0;
+
+out_usb_kill_anchored_urbs:
+	usb_kill_anchored_urbs(&parent->rx_submitted);
+	kfree(parent);
+
+	return rc;
 }
 
 static void gs_usb_disconnect(struct usb_interface *intf)

-- 
2.53.0

