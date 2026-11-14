Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794689418;
	b=04PupaHuADyaZ+XbYSED9fskWCZGnjelfkLYXMcf+R5xKinKWR7xtuStbk3/VaReurVt
	 DQA63yQ1aWBc29c97Vs5ajhHD4e9Wz1YZq/YHpngQDLTaar62C7ZUtisEXu9MPF/4Pyw4
	 GpEETH1nr5DUiYLfjMXpr545QxIQuoKl3Ojk3/6/FOInYQnIMma7tE2Aksxx5TCamARVH
	 IkcfPDpGyd/+U3UB9tAJC152NkoB5tdUqyr/vGKJWkimB+9L53kHOROOk32B0rDtUw3UR
	 Tp1GlQJNIRfLt7nNWFFOFE2PUyNI2W7FP2zl/HZMbWJ+l3uHHeaL+v3DQvVbBIUFsGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689418;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=CWIE9gSF8wDh83IQZVLO0HkSfEuOPDPBhAmNgaE3DWY=;
	b=kuA/OIF3YiHLMb5VjqF3alLMdKszLmJN0+6AV+ELRr1zPJT2VNIHQTkZEeK/uERw49EM
	 YTv8u3pjJY3NpeGjfYrz0ljmja8MWxKybN/vxUytEf6fV1DuVdAz+Mz1J/XklpPmv6t9R
	 QYcloXG+FjdEyXRGq5GUUOVE1DwX4B/R4hDIfXVGiMt+egUmYCBC1G86y6jZT89A/9g42
	 g2AYN8E4Mv2nMLwEG/lFTHllEboR9Use5j72gb0+NTcuTfmQBEN32jh9VVx++wiZ/di/k
	 gROECcuones5LEy0qU3ow9fiFxxUmVbAHT2hjKiqXhQwYE3Ne4+53hvfsVhJ2BPx3IQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="Q/cXv7S9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCC606A32D;
	Sat, 14 Nov 2026 20:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71DCC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Q/cXv7S9
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 751E9202336;
	Sat, 14 Nov 2026 21:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWIE9gSF8wDh83IQZVLO0HkSfEuOPDPBhAmNgaE3DWY=;
	b=Q/cXv7S9B6VK05XYLFmW0BJMDsx4zUbRw1BQoMrKtDageZV8lqw2bLSNOirBf6oMWmpon8
	XGh++zGSwsb/DBvaypRA3ljbsdRzcBju6BZ6rf+Kao96SxXTfzvOUChfcb8Ao92MOgmQ+l
	Mw6XdywwHVi23pek4O/GP6Ums7m2Wn+jVgXNNr8GJTSLBSCUMRvaxGSSm+wcfyTGnRDoPl
	QaPZhGGssPLSvkWqTBbXSS5qqVlN5gHsysGhZeUFlmYU5QWdK9sdVxh55KuJRIXxtIJIX1
	b5JWbia6goSSq7KYiCOkMaNf+MRlYVWJrw4FpSHlmfXHMAd3Hn2sx3Rn66eqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWIE9gSF8wDh83IQZVLO0HkSfEuOPDPBhAmNgaE3DWY=;
	b=efR/1nXj+YNGkwEAuGsOMoBaCqURQ4LsVJ3ltVN5WTWBRcy2FpFi08tMy3eSfQcn1cG/0Y
	BjZFS3idbRpP5SXHQFp2y58flECJwSm+SCRlNKDIgeTFKXp0aivVYa8tW2FB5SbtT9zIsi
	nO//AnRj9M4JHkWZsdRnsnVFfEl4istkwRvzLcQTcakCYobipmlBC/cwBfoYAj4jYJs1bE
	iMa/SrCYCeGEFLJa/tcAs6nnJmhn4/4JqPEJ58Ixce2ZqEbfCZ7klcyNQEN1wkOcibFaWi
	XMwm5Wqcvu2DdziWRHHWCAjCNVvrBihJb01SWrEf/zfU5GY+fTluV+TuqON+SQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794689415; a=rsa-sha256;
	cv=none;
	b=d5FHgVNTMb/cyTSROM1SFzQupdR5embJNdhDibNvrOWhJfudmwZyEVqOjtfiiz2EtFJBaj
	+c6o5yU/b0G/oUqRxCoKYRifdaqebxnv/ONuIjOdPMFL3JH26kiA2EEgToiLarHH5mLo0J
	tLNMLgkaNfDUmtE3w7P0pBOgTwtj50V2gjQcYAzHkdM3SCGCdn21wfUWcRtKebQUMr029X
	wa6qkwMVa2Elpf0KQ0Tgx83WhWtw7Ook/Vf+w2xvi7HTj32r9VY11XUFnAivFEHdzy8J+R
	ABF6jeJ4LvRw8s7rItC1r9O6D+U9AS81g9ni0eLlrEHPL4oOg0nCv8bAVW51aQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSKhT-004BfL-1B;
	Sat, 14 Nov 2026 21:50:15 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 12B145EBD71;
	Sat, 14 Nov 2026 20:50:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 21:49:57 +0100
Subject: [PATCH can-next v8 3/7] can: gs_usb:
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
Message-Id: <20261114-gs_usb-fixes-v8-3-f615502b005b@pengutronix.de>
References: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=2okD392lvIlE1Ithsb0eSss4rV+Es5YwXjXBxYrFfu0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cbLBMF93n9VPndX9e+6fbNI/r6djv0eNqe/U30N3r
 q9JPClwu6OUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQAT+fKHkaHzfG764zRh9e15
 k25f5U1Vfrt9ic5fR4OfPzKUdfdvXLSbkWF5Umam66mM/GUd7tfVRUVbbxnyW3zMP6ne5/hu9cU
 5YlwA
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

