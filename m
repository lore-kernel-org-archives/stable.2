Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793033131;
	b=KANcPCRgfl6AmAmY09fQfcOtQhJ2uGy6X2Ck9tNXKJFHZwbUZRiZtfhK9lcNWZZ815gf
	 Qzk9lwLZDefS1GVw4r+KiYFpWqmcbsrWaTw+HEwPeiZ/mRCIf5Hmql3qBfBBeW1Sn/VDV
	 IKrN7u9Ef5CO+KhNLeOX/7Id43ZF9lupz2jf3y3kZehf02O1BDa9/7H2iWIzz+ueEbpmC
	 PTKIvbjqCusFzGO+zvXapKxvNE64FlV11c1+bULl3MbPFoR9hd3FRAws1tKDHPerykrBr
	 nnhLNPPujfs+uqc8sGsCCc1VZ/6An36iiDE/YmMzjMb4icBMG0gX7XwEbB4caj/g2OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033131;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=f7d2iVw+tfSSZ2gqsWMbb5CxjuOi50fofZEerRNlY20=;
	b=G6XR5kx72vIyJJFqr2d6O+OxKdWK9cI1vEwN1HR24CcV7uR6c8JeFIygY1mCt89aM1q7
	 AHBz7ZCntAY3yM5+y6uaE0+OBDXbPT3JwIFdZj5i4yHTxcAJJJBio9+n1jtv2SqDZEO3j
	 bXX0eCdyRqhZSehbCmxBIU5ZXcL0x3w6Ep0Xpkw2GR1ycd+XyyblTzxxbChGOIEoq5m7s
	 ZzHAK02DvTnZzVM+KKJGg4ko14rNN0lxnuuhQPbohNLsV3BRrMGUM+nHsxi4FcV69i1b8
	 NfSV82sG4zNpKHhg6PgQuz5HlenVk/mB90P7jS3MSxqR/YH2Bk+nNm+RBiKdIx8Q+uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CE8CyMO4;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A1606A31F;
	Mon, 26 Oct 2026 16:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D60A1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CE8CyMO4
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2BA96202921;
	Mon, 26 Oct 2026 17:45:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7d2iVw+tfSSZ2gqsWMbb5CxjuOi50fofZEerRNlY20=;
	b=CE8CyMO4iVA0Vehpewn7n531kV9JOurJvFDvVUDcE9MvKL3WB5ZsgsBj+r2HCFdhx6IjUx
	ymumxAebEuAsq39kBDWa6wmNUph6kcjDh0OO2FK+cS/BpiwpcFRS5PuC+Ktz5Bazt2G3N6
	TNjpr1dFPXjKqPyjZRamI8n+k+w71tO8CQHRWClrkD4/AOkzcI/cQUd5nYMzHvj+0mqRf6
	p2L7Rl4baED45ukgfmmudJ9wQBxHo13OVhmeF1T0uWkoBJvhuPgn75hasHRJn3nyu16Atx
	ZL4KHdPU0qvpV/2fTXWVK3RL/74UVK2D/QiZwCo3P1OCr9FTjKaoeSBSov80qA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793033124; a=rsa-sha256;
	cv=none;
	b=K3/oaYgynVax5dxxO6VhfDcIgBpx0AJI5GVoOVyvaU4pNS+6WNSna0+JrwUF51h2jtdxOI
	7Nc8xsqzIKuYqwWofjbCu4XJjVbLj3HXXPjuz2M7ReQNjD3E8WxqmIT+ZSbGzTxoQyYOdi
	vz5VADoXJcVLuE0+bwk5P2utYMjAWzgej1SbN6n4qauX9EBeGrgoDb0fcuZjfAuNkmblOj
	nMNcJcjVd1uRMwWdhm3m3E8Ic9oMEl/F5/YH8I7Mwci9NUciLpbl1lJFoCQ9QwqMwTBQyS
	D+Kd+polxBuUf7pWLG1uGonCXjHyjauRNb4jVjN2XmIN1loEu4B5tcyTZTyWZg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7d2iVw+tfSSZ2gqsWMbb5CxjuOi50fofZEerRNlY20=;
	b=b9hzSTqxRwEpQiX6o6AAK7kNDyolyuJlmPYVlmtkHhgexHlVUW73cENoh2Do+iZAs+gweT
	ZmiAPcXxjpKO/Q/nOvKY9E2E2T8rs62Ogc2t88bVBubrDHqVS0DAtVabtunSorzXqHjsVo
	xXe6l/fgL6CUtdaKw1jpgcy2LL//MYnwNuc4nmwYd2s7+xttuGi16Jr23fI19AzQ6PcfyW
	58z7kuXqHGwxqkov5lOw127R+v3MnL8Fg/dTXTP0vSqYz5RwXei7qEb6r1LZ0ncdDVj1WN
	CNEDQzPM9lGL4Z44s8aF+AMxz4R/KgfX/zWtY863SUN7WXx21As/eascTS2Yqg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLNp6-001JFh-0D;
	Mon, 26 Oct 2026 17:45:24 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9A4695D716A;
	Mon, 26 Oct 2026 16:45:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 26 Oct 2026 17:45:07 +0100
Subject: [PATCH v3 3/4] can: gs_usb: gs_usb_receive_bulk_callback(): check
 for overflow flag if SKB allocation fails
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
Message-Id: <20261026-gs_usb-fixes-v3-3-3a68f1f62813@pengutronix.de>
References: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
In-Reply-To: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=M6sVVScYLrsqbjKV913rZQVqQmzWtIX+jycbFoY6v20=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi637zgSk9p8OOLDz2VvVv5lVYwCmZO5X/yW07/BP9h9
 fZfi/gYOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRig2MDMc4OtU8F+R8n7Zf
 d5bIn28mwjWybTc//0+qmaiR8fjS71WMDHeOpgoxtUw4GLTi4iuHYNNs5Yb9gkk38rSzrtzLMF7
 LwgoA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If the allocation of an SKB fails in gs_usb_receive_bulk_callback(), the
function neither updates the statistics nor checks whether an overflow flag
is set in the host frame.

Instead of directly resubmitting the URB, first update the dropped RX
statistics then check if an overflow flag is set.

Closes: https://sashiko.dev/#/bug/linux-7b3fe6a0-4628-4d0e-aec0-69f4bf8ad5d4
Fixes: 68c5724ecd15 ("can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index cbe3750bb68a..5b0c58fde53c 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -673,8 +673,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
-			if (!skb)
-				goto resubmit_urb;
+			if (!skb) {
+				netdev->stats.rx_dropped++;
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
+				netdev->stats.rx_dropped++;
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

