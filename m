Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704910;
	b=KBe10s4OrcLBChb5dOim5zdqwkwD/7+Ca7vn2jrEy8cVkjHoow/aoetsxlF7OL2yuvTY
	 jOKeYR45H+hYysFOX0p9whjOFQOSrVY+HAACpLZmzSORP0qi5rMtYmlvGJeC3duCxm79Z
	 g4JU7rC/dNAFd8+/X0DhY1omo3GOC5VD5zkDq0ohtFtU6MOvZFJ2esci33i6qP0CtDLWc
	 P5wa2OMoW7rDG8ly6oqdpAfqkV3N1tzap9/DQmUV5SC+JlvpA8+UWVjZfoQbPYVCbtPEn
	 dIngTsQtnBEUuv+U3lTSb4HraTE0G9hf+6Z4bXTI+J5ZhhitYeLISgRhAmVzsTg6qLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Hmwsw8Sbdt6KtOM1UkonB0DcR1v4usyhFSv/Uva4uJ4=;
	b=sg94pH661uX9Q2pgrOe7+AZqN/PRB6X68fOthV+XH3sNtuO9sm5KOFsiT5KLChQEtHP8
	 E3JJW5gSYT6MDTb+ktbc6P2VxSbRJJSUnfGTsSqhnGxV9FIbXadOdDSfuOjpT5+cCvdtC
	 ABxoGo+oDkDzRfRqZe2D+5SkzMMDI0pqbT94io9HyRGwBUPseveOtgIGVq/qFlpM04iVn
	 WVULXqc06ESa1ayE4crIEDLVxBdDXWFUQ4ITs8nyxoBKBspYKlIbMXRYPewLcJCVQcSE2
	 UbG5QIkPpg01gRbmfoogd1pnkdD2cDsfvOF8xhXEV1yyxmXALAQE1kkKGUA9Boc6MHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=sCRWZBXV;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DE606BFA3
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 215DE606BFA3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=sCRWZBXV
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d05d51553so26120705e9.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1793704908; x=1794309708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hmwsw8Sbdt6KtOM1UkonB0DcR1v4usyhFSv/Uva4uJ4=;
        b=sCRWZBXVytLCaG7YD+OZLfeHh0dVpUn9poKNHPGOF/STjUZq1QrCIneAjntad7nlJI
         OjdvKFE38972nKRBoPWhcFdekJMQQJ/7E/nGXkz2tKpvGMaB2fpM5leH8A3HbOAqhKD8
         mlNK+FPoUTSIPnX3zr8yJWZFVc3kSJyekG4awjvgEQBdx0jPqUH1EgcW5McsO5DeqsbU
         qveVGcQ+yGhm1bNEcSKXmL4f5svtwNQrQWR4zFarHNqYMQA2IV44kSV6eSHwHuQuiiTd
         8Tyx25yAbEyMYZr8rXbNfRDUyBFsCla3F9jpB14fglv/NJ2OSXchNhyuYrO4gpAHJkO1
         UYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704908; x=1794309708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hmwsw8Sbdt6KtOM1UkonB0DcR1v4usyhFSv/Uva4uJ4=;
        b=vTmKvQtd+rGWWKt34G98GGX6/2pSgkk6fshmsGMlefEqQ7lSwEHl6g0U8TPL8sg4Cy
         1baaQXuaE9rLdsJB5IZ+LYZYrmWJqSo8eSNrv6ud7R2+nTHTRKR6RNo48jXclfoEGFmL
         adSIHygeviuWa1GMhk/nXsVZEgjVXXD6GWMDuM9y7+HKzmweUJS3m0HfptJ6+O67R2Bl
         Gq1aSTncQWqJlxJh4MzkHbgBKRTGZPpkMPVuaBTG1mnVkqAklqYjzXLn86SHHM8xmo5X
         lVeaIjtEuXkhNvRzUgpXeDpsWYjy41pv7bkQVP7qOhKEgWS7hnCWCzmFEIpmymd0afZW
         ZUIg==
X-Forwarded-Encrypted: i=1; AKwUvBy71/zW/UZC9+xPykNqlMUEExSUBO9yG5gUwk64JXr2PU91V87xHwEb2+oAeuU8yWcA0JvmyZ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iEM18fB7TORFjuBv/VtwYKJecGoea3N2PPfA5dr0v+eZJMfUW
	mh9nLk1jVS7NjCMnlLSRnBZ5L/XbHtWSr8NwNxriSY1TajRFn9zxbdW6/gVToti1l/8gJaHXKfL
	K7FJYW8Y=
X-Gm-Gg: AYBFou2TSm0LoNGgE77plUxLakXWDOszo5gsTM3TJcDFC/ZU9eVEr7IC0VQVA0A4HtF
	txQWQJoyYhOhAO19QvohMCq3EkmL1S0BO9YHJfzXcFUIdQGk4FbNLzr1reP87ISzhSyyqITn83g
	8V+5HuXDKHordI2ZgxxVrgQ4F7Q5oIt+vev9KZpB+rktAzdz52LVSKt2TGFpETWM2sxY287fPAQ
	IPh4IUcZvA7m5STZf6vF8POIjF8XBq+vOjpHg7zMu4vWtkE77j1eGrEdXpxpmdYdF8mGpOcUEmz
	oSfqbBMcf+kGDePBg0WLJYCqJKDTF9b76Y7qm/fQwXfmyjhah2shVWyTjpf1DiOGU9bgYPcZkw0
	HxiXrTv7mYGHa/5fdDSIGjUAD6dyixq4VSeuJPApW/4ee6I8yaBNE+LCNHcvIOAEi3vh9MJ3r33
	OkwvuOsSDf42HDCM3sCX3PDxavY+H81hsk+8KpsoNj76yLe7aUGoP4gJNdVcGkk7SMzHhAJJNBm
	a5OJzx4MglRJtVV6doLBFhQ1JSJgpkoGT56CZxsJ5OHtYtYOWM8IwDsr2g2VT+F1YQ9QluHWVMg
	+YRoJT/4zV+ns90CTwDxxiMTIZ2HUYi5/9LOzmg8XBI/FkQLjjZlrYYiy8eS5KoqD9mcUe8Hlht
	N0U86rh/whBp1mE6erXf9GyK9IAsd+Sj/
X-Received: by 2002:a05:600c:1987:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4ac16fa2edbmr295498615e9.9.1793704908519;
        Tue, 03 Nov 2026 03:21:48 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab3ea6a9sm76135345e9.15.2026.11.03.03.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:21:48 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Nov 2026 15:21:23 +0400
Subject: [PATCH 2/5] usb: typec: tcpci: Receive SOP' only while sourcing
 VCONN
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
Message-Id: <20261103-husb311-cable-comm-v1-2-6217dabc1a85@flipper.net>
References: <20261103-husb311-cable-comm-v1-0-6217dabc1a85@flipper.net>
In-Reply-To: <20261103-husb311-cable-comm-v1-0-6217dabc1a85@flipper.net>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 RD Babiera <rdbabiera@google.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4477; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Y+Y0smxCISp62BQ19uBzIyipjINlpTXkK4pYI1Ccdzk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWS9PHwkcKPI2XnL1CJOi1f1tuqabp8zZ4ZkaBxjZ3Rn3
 ftFx3bu7ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCq/X4xMpxYFVX/Iu1ndOZ0Q73DnIuj2ddodgS9iBV/ff5lvEX1lgyG/6GNn79
 nPZttfHHdjCSVlCt/Cw6UF8Q8sI3defr2MtsAOwYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

A TCPC acks every message type enabled in RECEIVE_DETECT and passes it
on to TCPM. With SOP' enabled while the partner sources VCONN, the port
acks the partner's requests to the cable plug and the plug's replies to
the partner, colliding with the GoodCRC that the plug or the partner
sends. TCPM also tries to answer these messages as if they were destined
to it, which for the case of a partner's SOP' Discover Identity on a
HUSB311 made the partner soft reset the contract every time.

TCPM talks to the cable plug only while it is the VCONN Source, as USB
PD 3.0 section 6.3.11 requires, so listen for SOP' only then.

Switch SOP' reception off before VCONN goes off and on only once it is
on. If that fails, warn instead of failing the VCONN switch: SOP'
reception left off only costs cable discovery, and left on is no worse
than before this change.

Cc: stable@vger.kernel.org
Fixes: 3bbb9ba4f660 ("usb: typec: tcpci: add tcpm_transmit_type to tcpm_pd_receive")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/typec/tcpm/tcpci.c | 72 ++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 6717ac914c6a..af8db6b4497a 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -41,6 +41,7 @@ struct tcpci {
 	unsigned int rx_type_mask;
 
 	bool controls_vbus;
+	bool vconn_enabled;
 
 	struct tcpc_dev tcpc;
 	struct tcpci_data *data;
@@ -344,11 +345,45 @@ static void tcpci_set_partner_usb_comm_capable(struct tcpc_dev *tcpc, bool capab
 		tcpci->data->set_partner_usb_comm_capable(tcpci, tcpci->data, capable);
 }
 
+static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+	unsigned int reg = 0;
+	int ret;
+
+	if (enable) {
+		reg = TCPC_RX_DETECT_SOP | TCPC_RX_DETECT_HARD_RESET;
+		/* Only the VCONN Source talks to the cable plug */
+		if (tcpci->data->cable_comm_capable && tcpci->vconn_enabled)
+			reg |= TCPC_RX_DETECT_SOP1;
+	}
+
+	tcpci->rx_type_mask = reg;
+	ret = regmap_write(tcpci->regmap, TCPC_RX_DETECT, reg);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
 	int ret;
 
+	/*
+	 * Without VCONN from us, SOP' traffic is between the partner and the
+	 * cable plug, and our GoodCRC would collide with theirs. So stop
+	 * receiving SOP' before VCONN goes off, and start only once it is on.
+	 * Neither is worth failing the VCONN switch over.
+	 */
+	if (!enable) {
+		tcpci->vconn_enabled = false;
+		if ((tcpci->rx_type_mask & TCPC_RX_DETECT_SOP1) &&
+		    tcpci_set_pd_rx(tcpc, true) < 0)
+			dev_warn(tcpci->dev, "Failed to disable SOP' reception\n");
+	}
+
 	/* Handle vendor set vconn */
 	if (tcpci->data->set_vconn) {
 		ret = tcpci->data->set_vconn(tcpci, tcpci->data, enable);
@@ -356,9 +391,20 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 			return ret;
 	}
 
-	return regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL,
-				TCPC_POWER_CTRL_VCONN_ENABLE,
-				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
+	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL,
+				 TCPC_POWER_CTRL_VCONN_ENABLE,
+				 enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
+	if (ret < 0)
+		return ret;
+
+	if (enable) {
+		tcpci->vconn_enabled = true;
+		if (tcpci->data->cable_comm_capable && tcpci->rx_type_mask &&
+		    tcpci_set_pd_rx(tcpc, true) < 0)
+			dev_warn(tcpci->dev, "Failed to enable SOP' reception\n");
+	}
+
+	return 0;
 }
 
 static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
@@ -478,26 +524,6 @@ static int tcpci_set_roles(struct tcpc_dev *tcpc, bool attached,
 	return 0;
 }
 
-static int tcpci_set_pd_rx(struct tcpc_dev *tcpc, bool enable)
-{
-	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
-	unsigned int reg = 0;
-	int ret;
-
-	if (enable) {
-		reg = TCPC_RX_DETECT_SOP | TCPC_RX_DETECT_HARD_RESET;
-		if (tcpci->data->cable_comm_capable)
-			reg |= TCPC_RX_DETECT_SOP1;
-	}
-
-	tcpci->rx_type_mask = reg;
-	ret = regmap_write(tcpci->regmap, TCPC_RX_DETECT, reg);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static int tcpci_get_vbus(struct tcpc_dev *tcpc)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);

-- 
2.56.0

