Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794171225;
	b=gd9+Ol/zvdH1QabiKdjYD4Ls6q9uihar4BUl8qyhMtkbeikolSDynsxJhwdYBE3NvC7N
	 MmNB6W/8LbXkMTexlkZa+C0Ctw/DHRhViqxJsFsMOxEZsnEyXTXdF6FxVAENJDeIpA9bd
	 dn8yDcb1uSvE42sve1Vas04XKILVV8nlodk8FlEb7zGAbJmhHN8WIUbO3w1u4els+rKT+
	 RNrFZBmH/Ho/0zd7bWWbAHVgoErrdyOml9hJLmx5OLld0yqY1diH4dla4FdNXGKyaOXcJ
	 6gUapk4M8Z7KiYPO6NOnvTgqvjkR2I/wrmGFH9ETmsJ8kQL++Px8lFltOCHFEQXSCeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171225;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=OT+afa1wLgeFLqzZhZGdmgAbeeLMo8nJiRCU6WEaetI=;
	b=mtMWkv7u3cCAR3/G+WEIEmEXS5HrU8mjcu9qHsCKqghu+0owfFBh5MwChYUTnYYJNK5y
	 u6odO5PvQFdv4FtOgM3SfHM25237kn6gO0lO8hIGgJgREgcjVhDyoq0vkhFXqluPXaLGL
	 VD4UpixiO/sEaWDs5CIU/AmAPluYlkvCUKBUitzL1Th5cV1/vMJNTllYsuKbjlFxHpWjs
	 U05rfMKeZNprBDj66MF69a8jgm8L4+e6qT7OqU5xcsbHd2SftBHuJYWCAcn5FEEjvED4H
	 UZVXqBXjs89wXoEd9ohvl+vIvGx3l/Ca+yoasPICRLwqNIjbo5OWbnW+qJXJvv/lwgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="ApzbjCi/";
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F7606A321;
	Sun,  8 Nov 2026 20:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC1F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ApzbjCi/
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E268820189D;
	Sun, 08 Nov 2026 21:53:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT+afa1wLgeFLqzZhZGdmgAbeeLMo8nJiRCU6WEaetI=;
	b=ApzbjCi/jsJt3HLPjolfx61xPEK16FEyawJMa7ih4K6twB5gR7C94DD4jyDlR3UWbmT6U9
	53MStE6Znudq7T9a4EDkvg41zj3lTYJx/+ikT1n/f/WjjdiEG4lUz+e7Ktq2dz1Rgyy9Q8
	bbvKc2a3l5ipTYE6hi9ySEBF0R6WkiI/fFns9LN1+DlPNGx7Mx8Q3JU18IXypD+ylLqAT7
	ee8jgG8/kaJ/nppzO5q5JE1E+zm9ErTVYR8ilfgL+3skGzFMAae8+UEbk8fujWobPVqmUf
	/izb8Rdl78Dcz42jAK8R6acHdGWhJIp/HmEzVl1tYx/zhGxWGg8oMtnl0tHMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT+afa1wLgeFLqzZhZGdmgAbeeLMo8nJiRCU6WEaetI=;
	b=cLhVEqBqBih5f2qygkldl7rn3klQ6TNhnL+egWZWziSvtGKTijTTOCSfNUS8Lo71s/MBkO
	4slvBFwq4MFaUb1sWtZjXYqn8RcU8GTVytuAqlf7nv5h8cR97S++gBQik38c4AaCLJzDm0
	LT/upfd+DAGdEIF/4+FWzAkB9hmjPgo31yI5z5omoAYn7jG8pSyuEpuMxO1lTafibaxoPd
	2rsR8bAUQgebIsgLNy3BuAV+eO0cZ4WojDl1qdACezqkGle12TkErtsr1m7E/Dl43TwIyX
	/fTzKAscwXfFemE4+U8ABclHrkiWtRBVD1PrMcb+fXn7gn4womZbmd1Q/spmZQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794171219; a=rsa-sha256;
	cv=none;
	b=ecTxLF97uOmZbjuxQGvuBhJ4A0j4ZWVnVoHEFxOZrcR00E4tTyWAdpLxhc2CL9b7c287QN
	y3KWue2R1p0ftm/q82zt8FF4T3G5gQUFZU18QRtRWpi5GcguGRabkfE1ShYP2ellRRpgMn
	kHlyASfDppGX3cwXe5bIaozLwtPqPK2mk+yc4aSYBscf9h5Z1qbF0rGB26VuE097FDZTEA
	KPCnprZ9dErEUB/aNw7dnM8iehTqGYVxCVC4Bc/ZNKnjyXZNlSeoB7hv7kYpKBlrhcJZYC
	+9WC7JQo3XkKB2iSs3k1+oqwS4QiMaklgNo4KFGYSh83wWM8jfsyzYKA8BId1Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQ9tT-003EmK-2Z;
	Sun, 08 Nov 2026 21:53:39 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6F5265E3E74;
	Sun, 08 Nov 2026 20:47:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 08 Nov 2026 21:47:24 +0100
Subject: [PATCH can-next v5 3/6] can: gs_usb: gs_usb_probe(): init netdev
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
Message-Id: <20261108-gs_usb-fixes-v5-3-d52dd4940d46@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
In-Reply-To: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=4199; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=w+qmsSA5+xABUS37EGtRsdYalHXZjHdWdMb/eoFl6yo=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cP/JGb31pnHO9wymLuDtLJmaulmGacrucNuJJ77P4
 9KYk6fB3lHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJvN3LyHA9KMjilgR7W46j
 3bVSrmdXly1r3TTXhGmzdsu040K/HYsZGVbusJuX2rbu4pGVuxz4VB+3XHCs0e23nHdkQ3ugX8E
 NATYA
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
index aa90cc58f28b..1527163e8c35 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1493,18 +1493,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
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
@@ -1512,7 +1502,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 static void gs_destroy_candev(struct gs_can *dev)
 {
-	unregister_candev(dev->netdev);
 	can_rx_offload_del(&dev->offload);
 	free_candev(dev->netdev);
 }
@@ -1590,21 +1579,16 @@ static int gs_usb_probe(struct usb_interface *intf,
 
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
@@ -1624,7 +1608,37 @@ static int gs_usb_probe(struct usb_interface *intf,
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
@@ -1640,8 +1654,10 @@ static void gs_usb_disconnect(struct usb_interface *intf)
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

