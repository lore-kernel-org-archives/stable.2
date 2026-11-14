Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794669477;
	b=A+a2UiVG57FsfgDmUrspmgRTZ8pxB40vOY4RCCUCLLeuRxgAHTd2a83zrygvTcPh7o6m
	 xTf9eRjuZUkFXWEXDYR63nwZdkAFOFa8X77jnLduTptZG8Hc2K1ESvH+Fjf9RH3WySJ18
	 Bew8k+X/CFdg12YNcakOdy5EL4D3scGxwSgKboHP0Dvivkr7bwuB2JT9p6GQXNOFbgCdA
	 Ss8Bm7aLv5iGgcslW6hYvAa8iE5ivsCN0/NqHtdKHkgUBCe9tempGEt5maySV5JetNMQt
	 sk4DSzspqi+lrng5unj6/yfNwsfHTaAk98JWR7clu7ZsH3sy4EWkAo7oapo+NGjPjxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669477;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=CWIE9gSF8wDh83IQZVLO0HkSfEuOPDPBhAmNgaE3DWY=;
	b=iVDh79g9DeG0YCvY4zR1qHMYv082rmd7kDMgBHhKrcMQDs3h8qVLUix1/huRgdwl0ONE
	 s//WWSU+KI/hduSAo79Yfm+11belSZbVzfaNjMe6vyZvgokIZ0BaLYp3XR7c2SJAIe86A
	 JeUMWUQukC7yESiowJLF2uqN+LD5fKtgC97Ivw7hlfgjaAAD/T5Ednmr6aWJv1N+xN5Bk
	 7say6m62wCtJoz4O5r4sd0GOhfDA79pWh04cDQVAHqMmUt9apZtztFDURAZlL7uTjS41p
	 eWrgBwBtK8y2D253LRzK9JjbNrXl+a+1EpLxb9KWHNTRDK0CJQWcS+3vg3giopurlUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="Y/s6h56M";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E6606A330;
	Sat, 14 Nov 2026 15:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 903E6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Y/s6h56M
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 624632022F0;
	Sat, 14 Nov 2026 16:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWIE9gSF8wDh83IQZVLO0HkSfEuOPDPBhAmNgaE3DWY=;
	b=Y/s6h56Mj4BoWsubAp7L0/piCCn08KEBcQ596ARNTKh0ElvbiB2P1d0Yt87iwRLRJ63iig
	o4QE1CsbZmdwoQdUpnnU9tcwcLppqr0THnrsaa42XXbsRfpzsKpBRM3ckGOvOOoVEa1wsu
	qY8X6U3qJkSUC52b6e+BVgBwT9ewl1eBrFwBUAR3uGCYpZHHkE3mju0FKRLzjDKk1AJPuJ
	68l91lOUu0C54Am8ehi/Ty2tgXcRfRhC0Yu+VYZBrM+E6Bgu+1G55mOgiwq7wnoULd77RG
	F7Z232acuHG+TL3x/+z3e36gJI40EjTN3XIT7L2KAqFLCAikMDu0zwtxmI7u/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWIE9gSF8wDh83IQZVLO0HkSfEuOPDPBhAmNgaE3DWY=;
	b=go83WhzP9p10yUJXeniTXf3ge6+3730S7+7YKZH2GGfcBiGA9qsiC3UtpEMcco76N+TbEN
	wgcBLLkMP9RlZjkegRbMT5JkS1FxRD09Yi14uCx9IjJYy8gre3vTGbOFF9yfr5XZIVjCH6
	9MUV0YPDJUkiLUENVjcd7nqfanO7rgM4L/UmuGSO3HKXIn3p8muvFRM2sx6+G7zzzPT+u+
	ZpSLRdY4AfX6yvdkMBH5vtaKsWp3QEurm3LOgRr2Ot2ZIUNVa6LMPmWsL5lbc5gzRQBQOc
	K1LdoEU1Q17sU3ZWrQRBMRuB/kzAjKXn7vUxnpMXBFYCA3GJCq1O8P4FWcH66g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794669474; a=rsa-sha256;
	cv=none;
	b=QlTV/K2yKxVoNhQ3UTAzQqd3WsY2r/N4FtHW+hOzS0R2EXOIoJfnLyuS+6DnwHpvPOM7Kn
	gMlBSdI9tl/sRHKjoudkpzL6GcDQ25mDcfsTKvEwlk4cSfskqBmlymqY8nFNGMoVNZD50Y
	jyC7wdI/Jdl9U2ycbjHxMtnh164FXvaGHPye+hG9usUqcAHx8YE7TagGEdaSHUMRXdv/mT
	BQ5dqC290M4Ue9eKccLEQaJ/eAIgyaGblAJs1k/4079sgOk3eRCwwqvQN5qjjvaxEn1Npc
	UCWAv7pZwXjjTppHwlaOqmp/alXKZFgJPIPZPPSyigDAYsbUMvz8lwUZXqTO3w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSFVq-0049oE-0v;
	Sat, 14 Nov 2026 16:17:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 045B65EBB31;
	Sat, 14 Nov 2026 15:17:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 16:17:42 +0100
Subject: [PATCH can-next v7 3/6] can: gs_usb:
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
Message-Id: <20261114-gs_usb-fixes-v7-3-58b6341b1c08@pengutronix.de>
References: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=2okD392lvIlE1Ithsb0eSss4rV+Es5YwXjXBxYrFfu0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6UT3ngO0iv8CXU5MLX7pZR0vG/4iVDv1pufzh3z4J3
 a4vrtkqHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZjIPH6GfyYCAudfxAUelZ+X
 sdgvIJ2vwWBbkdelkOx3llMfxcSsu8fIsMG0ctdKTeaY9nDbrAd/khhzq513MF3Q+i2sJjwhVEe
 XBQA=
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
index 6997cc8a6b2d..1db2d660355d 100644
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

