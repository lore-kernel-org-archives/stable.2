Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373338;
	b=V6Yr9IdNIU4yIGoyT8+r8O8zXf3EBCRXmLUjVQEZV1pL3HCrnuE6wq6A0JHn85RifFm+
	 Clxz7mpVafvGbTnjMCVmzpQ82uNyOUCB92PsJcU2xCHE1ls8U5UnRfdEjIxYKoOCF8/6b
	 wqQ70xj/BtxyRYhUwR0DrvEaB2ARffgYTS0FM8PzGKr0XKJE5MtnsTAKcVWs+9clcptQg
	 +3PxqZOz5CDuIob0/ACh1wqrq40d1n5j9yWHFVEdfVtG69RtOtUPAO3I8bD5Ji7Oq+ydG
	 KuwKUYy5O6lexpBhOkxyI2sOR3THEQMh+cBnfrzz/INDL54XGXpg9CwRCgfiBUxP9Fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373338;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pdPkEVvYDSTX7Fau+CMhb/SQ9DVWBphOf9Hy0+D/jQI=;
	b=1PvEr5BgZ9u1bQj+CPTKVk4mZeIVBEDwpZ27T4WvmLZ4yWtqVozM8TLree5GrzvIrJS/
	 O4m9oIMpA9v/pZObrZQA60G/1uTTsHBMQ7nbnn+/AntMVabus73GZEQ9v64MQ953VcH+w
	 Ckg1kR9VVBZcULttuYLYzybIl/asmQgXoz/7BBD4TwEG9tHygrYziY5pzOBtZCxUH5wfo
	 rhzmynvlCyVbeG+orCeAQoE7sNvaczg14s2I1zPAZ+5jTTOE5i5RrrKPgeyw9UxSgOgVS
	 FQ2EWBgBTMDJ+0JiDnXhVLZzisZ0yoH49TXF7JsXLKEHkNA3CsIzHnTCrqA2LsueFhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LqMKdm9H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4A606A330;
	Sun, 22 Nov 2026 18:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B4A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LqMKdm9H
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 29204202BB2;
	Sun, 22 Nov 2026 19:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdPkEVvYDSTX7Fau+CMhb/SQ9DVWBphOf9Hy0+D/jQI=;
	b=LqMKdm9HwKLCoenrbrtLc2RQo0gM/2lsXXcJdJDHVD3D0cjLxLikmNDEMwNZYzKZMm8OGZ
	M5xmCIscQLYRjyi90zYNlbI5v1IG/tAnsKOiA9ST5d72c77zofYLZQpC4D8E+4drzf+TGt
	op73Y8X6+6zLHDLOEDwaRFueJFrnEW/pBl4zcSSJCVBubNKwSvyjCL2wgCudoo1fbymOat
	RwZKiw4KwRnDmFOIc4R3ZcWsTyUb57vEzABFrFfWid0ES/FILXUpiE6+MvDL4vV3qtIBUK
	LnmHiiceW3AnSl9vlaKy01gX5Hr9TnT/QOvQgjVElfJVwtqAXYnKPVg9rPQE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdPkEVvYDSTX7Fau+CMhb/SQ9DVWBphOf9Hy0+D/jQI=;
	b=an3/8iR61NeOg4BD2fHIVFY7UXW1Ge3CJf5TCwyjr7iZHo1hqPwZC/zBLa1gBgiKe9/2d0
	NtGw5MYyS5EjZk27koTvs4qK2FzWPGqCYs1QVcScEs3kFODsK4kg76kfVZwItjyapo4G2T
	fFwK9/aVpoeULwURNdudIgr5+xDsOjV+5SgQVCZmlx5AVjWuSdIoAu3XGe8GhqlynLNNBv
	c+ChicvMNdOsJ3+RmE6yI5jlYjT1CJIGKNl9CU1BXP0JaAwVln1MeG4jRGtAJYuwQL69UG
	Fxf6Vwh3RTjaBh1Sv3O3W0SKOzN2UMs1390OMFfXaXBOjBHbKx/fPqMJTSQiiQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373329; a=rsa-sha256;
	cv=none;
	b=EANqMcpqfiCUsCBj58V2P9W/Te5MHmyeoZyMS7mpk1OvVr8dh+L5Bl+FhZW6n7Odmtg2gg
	3FPmuWcsQKBtvn4xRGenYf2sFu4hJ7aQnZXHRNkz5qgqL89bcYB/8sIeBxnEwLYF/xFfPM
	EjAUqUpJZdjmcxbyNgMrYu+DxdTnYPeBUoFzotjn2Wx6683n7STgxwThz3MbJmCl6iFR+b
	4PdSe+ufABPoZs0VF7F4tT1AgZvEi7LPixQgk+dUHL8+rVPUKti9p+aJY+43Kf5ezXKTRg
	oQAzSzygoOlDLkw/tA1FHt8fYzT0LfMVwjYCOWHr1hhocZbbdmhFHtvqBvlEyA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:26 +0100
Subject: [PATCH can-next v10 02/14] can: gs_usb:
 gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation
 fails
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
Message-Id: <20261122-gs_usb-fixes-v10-2-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=uJgvJknP0D3FX5oQa0UQ7tYpfzMgYwkS71p9uRw9AWk=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtmRs7ndcVz6T27PjdjT/nr7gtufXRLwL1vJ2Pm88r
 R0vcG1tRykLgxgXg6yYIsvSHycUBQIdSntfJkyCmcPKBDKEgYtTACbCb8HI8GttjJTZ4t8OT+tF
 o8psWrZ/4onfb5/3darxGfUFRya/L2D4Z/S9OtA1L6eiYeZF5V0VzDH6wW6fwz6v0X8uuG3PmfZ
 ULgA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If the allocation of an SKB fails in gs_usb_receive_bulk_callback(), the
function neither updates the statistics nor checks whether an overflow flag
is set in the host frame.

Instead of directly resubmitting the URB, first update the dropped RX
statistics then check if an overflow flag is set.

Closes: https://sashiko.dev/#/bug/linux-7b3fe6a0-4628-4d0e-aec0-69f4bf8ad5d4
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Fixes: 26949ac935e3 ("can: gs_usb: add CAN-FD support")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d1124c49460e..9e8567544c88 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -673,8 +673,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
-			if (!skb)
-				goto resubmit_urb;
+			if (!skb) {
+				stats->rx_dropped++;
+
+				goto check_overflow;
+			}
 
 			cfd->can_id = le32_to_cpu(hf->can_id);
 			cfd->len = data_length;
@@ -686,8 +689,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			memcpy(cfd->data, hf->canfd->data, data_length);
 		} else {
 			skb = alloc_can_skb(netdev, &cf);
-			if (!skb)
-				goto resubmit_urb;
+			if (!skb) {
+				stats->rx_dropped++;
+
+				goto check_overflow;
+			}
 
 			cf->can_id = le32_to_cpu(hf->can_id);
 			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
@@ -728,6 +734,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		netif_wake_queue(netdev);
 	}
 
+check_overflow:
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
 		stats->rx_over_errors++;
 		stats->rx_errors++;

-- 
2.53.0

