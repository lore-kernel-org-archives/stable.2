Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300583;
	b=f/Bmv5UoF6DJVRAPTB0bMqc1fCgzv9Oso/Xc5/AYUmoIZVsxGYEbqMw0IqVifpPGNaha
	 6iD6GkXVlSxl1PjjuNRG4aQSmtf0ulxSyn7pt9+NhweBHgrjydJks+UAHzNZR+5RnAcAr
	 pmER6Lly56YM0cJbBcBOd61wmErtRWnNzR+3vdy9mRNVdU05TMaD2e7pE7C7fjHjoUUGb
	 aKqqSvXfPsfrMkJ474N9+PRg/32LX0e48snQXvLXuivyA62Wo3iTkVcL6RHCdrnQuGx1Y
	 FPwYQ3E5w8HyCKUmtnfLCPjhvITEBfu7xXeDAlN4owfwjuzvcZoHJiccIw1803w0jkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300583;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pdPkEVvYDSTX7Fau+CMhb/SQ9DVWBphOf9Hy0+D/jQI=;
	b=QoFpTjv7ZWQdmGn/qTVf1e+WYUPvNOkbZn8liE+R0ydurkAeSHt49i1GEdb/CSrD2cd+
	 2HHFjq4zO1dbASWPoL3UihNxhmwLHpncySO2HthhAYcvY/cbpDqq3ZWwjy/oQNKfLmoAQ
	 jQ9R3O8X2ypNmnTq72xNIhxksl2dPixzq+0YlOJgU2lNAFTcHpSEhpWo6KX+WKYogjzm5
	 34qT+XPbDkRnOCWooGl+U+zwMcA19qEGepdSHFcDhToWeTpDcA30KFEsBOpuXaqlO7o8u
	 62+yykk6pfgz8+0EnjY0lgv5QOrcqEYXJ3suhtP875nVrDDqYrfIWFJW/K9LGixipqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DKTTD7B1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD61606A320;
	Sat, 21 Nov 2026 22:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDD61606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DKTTD7B1
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0A1F6202BBD;
	Sat, 21 Nov 2026 23:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdPkEVvYDSTX7Fau+CMhb/SQ9DVWBphOf9Hy0+D/jQI=;
	b=DKTTD7B1EwNzkMtdNiVPAP0iwrVhvM3taZvG9HMfRVNBEtxugg+/rZ2h5MV7TPA0oscUBV
	aG02T3ZmKAYdd46BgwyKUiM6LgOZtr9/HlEsweD94EeuYub/o3/FPVtFHYqWuRS7I5jnaK
	80ghciuUsdXVIbrmaHJAlbVx8aCRSeCc04sbMwrUVLJXFn6A+ZjHayS6TS1nicD4bD6Bbn
	X2Y/MBuc+OA2mZBqV68X/XortyyvHuW70KavwpF+fk136g6B6CHBC2coxcn/envU8EQTyc
	RFN4eehJ6RBa9bo8iocIt5tVFuGokSnph7yMBbOHabUK1XFqoDv+x+irRrq/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdPkEVvYDSTX7Fau+CMhb/SQ9DVWBphOf9Hy0+D/jQI=;
	b=ZRaTenkeAUJaIGTKrzQhRFZJLtIvOv64YnfhkFmKjByOf/dHIu8UrlysQSR62Ecx9NC9gc
	F1cICpMOndBTk7Zqv2U3B+PA0MTgqBnEs+wUM9m6qZUxS7tcgzLzSdgihuGyu06lK/1nbt
	CABCmJWZceuxejYZIB7iXwOC/JQBOS001xhcq/jTl127v7IYEx/KqBR4RMK30suGrBm03M
	5XUqOcr7c8mkrY+i8AGDbNrI5ZopR8IozQ924Rm3y1dPRkdAj+L/jX7INQPBq7jmuPw3ep
	7qc7FBeKsHGSTpaQktGvd9HsiHWVhXyguQr+xl2w/H8HqdagyPmi0Pn/1Ln8wg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300580; a=rsa-sha256;
	cv=none;
	b=aZxhzgx9Xr7cnLf0dUqk3wKbwjSemDAZCitsVYETCt7P96qD3LRpq3V/mcAVGentYsywdR
	KpGQZyubc0WFThr8WyPQNqIHJ4dSQyONY0pj0grmUOWW0XmBRlLVtP1w/i5ixvSqmDrogJ
	fdDU9CQ4gybWv15GrmadW6bxiYDsTc9NYcAQwDHJcFagV0IOpJHD9PNcBvs2dpHX1hBjNn
	eroRsZyPCA3Moi8VAtICFUZIQbUdcsyFdUHMA0ey3jAJ14xy2aeCHkLp3W922Xc6+UdHvG
	JdV015SGbfXK66S2CNEPij0oxrpHL1nM4HUw7LUMUE2lhitFibjb8jtuUlrPwA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:00 +0100
Subject: [PATCH can-next v9 02/13] can: gs_usb:
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
Message-Id: <20261121-gs_usb-fixes-v9-2-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=uJgvJknP0D3FX5oQa0UQ7tYpfzMgYwkS71p9uRw9AWk=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrlinPtuSc1E/YkzQgwys36v/nMk68jsxOzd0e6/Z
 oabnFn4uqOUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQAT0e5m+J82s+mjwwXHXOP7
 nCxbbmwX3vXIoD5jXcnta+auUUoe2/oZGXoswpbZnBO4pbTr+FkxAY4Lfjnz2B9UMJgpa0o+ftX
 bwwAA
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

