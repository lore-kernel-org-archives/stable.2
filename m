Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792953402;
	b=CW2JqVmUFquuhhOls88qhSJDC8zevr3bzBteZ/DJFvhZ1AUnLQSVWu4seTmu6tufW9Q8
	 0IloKxf1jywPShCew3rouqJa4kCziuwFHKWJrxMXVBLSWyT83dDcR8JVeL6xyaHOtCJuU
	 2sOOq1+3WJzReKEjmrUrsv9QYkjRSnD9FUitAer9BPTtbKyA5vF85IKKaMSoRgixGDy1n
	 /4wsSSjMNYIA7rC8nsBau+H/nf0y4ylKq01ma4RP38cvW0svMglKqeSpeb3/gIUZQUw+y
	 Q8NdlPMCeuK9JQ7fFq43UREvWThYWajwgqC1nfWu0EWB0ciLY0vEKzz+LJh1r2CgYCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953402;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=y1pxhb41U8jJAtz7nqz5SvFXkTBWeECnitzfDqCxFio=;
	b=NLpw3xPGwL/4RvARtU1AT7VRxNRmirI1+CvWTK2x/k+h7SvQyCkqLIppwiDEupH3UpUM
	 9Pc7WOGQOvpOxGRu7K8YZAyF8xoFAEKrPm5QrRO84VP7VJ5U9YpbgLADmESJyDMCxI720
	 uqUTc+gXu6v+7auOe6f1JycoKM/6Hl0aPfFO1o1/EKBvwdme74ugyswRX1eOTvLZwc+rS
	 uti5Kn6+SD5i8WBDvtuve69vWKqgK4BsifEUMUrv+fShCu6Fqpu10FR88IJXNGSlgypAK
	 Fw7YqRTNrVjNf9+E1U1s5DC9zYmiZOnhYyxBWJK0RUZo6cTO1w54KzxMiocoSOnuEMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=d28CL4Cz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BF606A31A;
	Sun, 25 Oct 2026 18:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F0BF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=d28CL4Cz
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 43DA1202146;
	Sun, 25 Oct 2026 19:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792953398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1pxhb41U8jJAtz7nqz5SvFXkTBWeECnitzfDqCxFio=;
	b=d28CL4CzB00a6GBJv/BQ93gqI8MF73BuMRbPVWTZIn/feaFfq4uAO/zXsyzPnqxsL8PbXE
	wOHPPPzJcUrMlCxIRuNpm0DSC4LhJZn/KhV3qFyW89wBgNUWc6/qbWSoy3duhp2Nq3QVay
	Go3No+7R+uvIoJkRW2gIVnFAbvkbg6WiwFlyucEBE2sZFXaXU08F0iRA/iij/FfOXf5f0p
	0NvA9IflvrjQP+hxTVY16/Q5G9HjDNjYPyZlThMhmLgG8KAjxyALk8GDEFNTWkCJ9WAR+P
	Kj2Bz3NdIR1FN37pTgCFf+s+OipGRE0Z79a13PYk99k4tFCHBqK1lVRVgS3Uyw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792953398; a=rsa-sha256;
	cv=none;
	b=M9ohPdyuBjZsI9mRGkTMd3yBYEbP1eICXl1FX/wK6u9StWekiFzuYVpukptWZf11DvePpN
	AmMf4YytVYDpLgvMmPgt+qWVjjk7O6KhoCdHDpcm+v6gxOPghjJaDS2y8SqvB5NSYOBdhZ
	y4ndvcHLQYjdIea3Yo9GHGD39WgSYMFUXu7gkMRnmVOSPk4dgsM5TQ2oSPGN68p1yfazJx
	D2jI7MI7OLohX8j89LQ53y9TDnKGIVrH1iF4jw1ocCUAO/RbkTkNp4qrkK/LgU1V4qlqfh
	jm16ic5E7X2z//IeDWWfM0Gi4XiQtCYw4xoorIIhiHzNfU5eDaLpth72u/Bh3g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792953398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1pxhb41U8jJAtz7nqz5SvFXkTBWeECnitzfDqCxFio=;
	b=QiSlVzXW6KAY48rB3jiVkrfG7f3HGFLniKUiZeP0OXW4iV6Ni/+9hQsNpxanfzVVe0EsJm
	8XBDepbSvPEILj/jzPJvgOMLkguGcT2ktNTYlmTHqr7vAIV3VxBuubT3hA6YV4/WCEZvnw
	/P+bqFB5qxr/lA547lw3ARuYKq1o+6e2mSaKC/a5aep78yyjJuaNmqYeI8byquFD0zDot7
	MAG9rR5RpTh5RretvcC2Hkv5eNKHLc9vkBrO0oTsngxPCdrBA7ieIjSRC5jBO12uJ9yolf
	YawPrMyxLm7g7EkEH7teBEkZN9q4usCvxzPEBwcN/fcyBsb2Xhhd/6n0jw9EKw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL35C-001AZd-0G;
	Sun, 25 Oct 2026 19:36:38 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8B7505D413C;
	Sun, 25 Oct 2026 18:35:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 25 Oct 2026 19:35:33 +0100
Subject: [PATCH 3/4] can: gs_usb: gs_usb_receive_bulk_callback(): check for
 overflow flag if SKB allocation fails
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
Message-Id: <20261025-gs_usb-fixes-v1-3-f74ebbd4da36@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Fo2WMDWvJEk2KE/V8g3nF38g2pSZrFAcjl6b70OQAmk=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi658PEesjk8ZnUFR91ft7k3S1dszFTsZh/j4oa2+Qlf
 5m8iwzOdJSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAin/YxMvw9d838wKeM8F6B
 1bFLt9cLLrWNfO7YJp56ULxTjD2s0JqRYWv54byW6ILOqz3fv/y7u3nTJuHvZU086yOX+Gdsy1i
 exQ4A
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
 drivers/net/can/usb/gs_usb.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 985d6a9113d9..5687544af99c 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -673,8 +673,12 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
-			if (!skb)
-				goto resubmit_urb;
+			if (!skb) {
+				netdev->stats.rx_dropped++;
+				netdev->stats.rx_errors++;
+
+				goto check_overflow;
+			}
 
 			cfd->can_id = le32_to_cpu(hf->can_id);
 			cfd->len = data_length;
@@ -686,8 +690,12 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			memcpy(cfd->data, hf->canfd->data, data_length);
 		} else {
 			skb = alloc_can_skb(netdev, &cf);
-			if (!skb)
-				goto resubmit_urb;
+			if (!skb) {
+				netdev->stats.rx_dropped++;
+				netdev->stats.rx_errors++;
+
+				goto check_overflow;
+			}
 
 			cf->can_id = le32_to_cpu(hf->can_id);
 			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
@@ -728,6 +736,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		netif_wake_queue(netdev);
 	}
 
+check_overflow:
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
 		stats->rx_over_errors++;
 		stats->rx_errors++;

-- 
2.53.0

