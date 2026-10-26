Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793040325;
	b=vxyiKD+NPAhrVpjguUAnW6JbOuQxxIMGZenX1U97gWVAO940B3o8Mjtb4Cnb9AjaulXl
	 G8W0RGOwu2gBCwKRFfHvuUOOyLRyhRHLbRHkOV1lGXGwy6hnqfxl/gEagBWqqfr42GfXZ
	 G+ddNRSweoJfGcdNyYEQwsjkERSFaKBq0j+I3WeHdazJxpGYENdvPe0SsIRfWXYNE9jZ+
	 a3cj+kaHb3bYZtpId2jaSK5OcGfacHJ0A3OK/nBwncsjYQ8ZK0+4WksgpVq6BTbEJrAtP
	 Ti1On4F2NiatPm/xiooLDfai/acod86Gstj83NyUuhIk/0xjMKxlVTmNXFNYoJzso9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TFpakpCDATQoh2Q5Nqa0fBs+TsFHqi4R7N9JGysXjuM=;
	b=pPHWP5ueySwqDEte5N52hDqtltdx+iGTcrP8tEsDa0xQfg+/NyCizRC4Wy/P09Fl64WE
	 yduj1IQZEiWRpJMe3KsjGOCRQW0DqBOZS+rQdHTU8jbHMcFTM0lApSZacmMY2DUl8dCIm
	 G3OlTFUbnCtqk4+lDK3dZ9zwAvK8yaMhUdAH217wg2b00UcTwSvTsAbwVL2jGEbSywdT1
	 fS18RUDPV4216m2hjdraJgp+R2eSg7ZdcvTI6qSdY7b0WLk2W924W7ZWJOPHfffQR8Jq1
	 T00zQN6m944lMghHCQOQS2RcDvCE02DOkSKpkBxqGZ7gM+d+VDQggm0nusKU/AEJIgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DYbMpl8i;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24596606A31D;
	Mon, 26 Oct 2026 18:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24596606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DYbMpl8i
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 408E5202920;
	Mon, 26 Oct 2026 19:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793040318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFpakpCDATQoh2Q5Nqa0fBs+TsFHqi4R7N9JGysXjuM=;
	b=DYbMpl8iCgImFXicoGuLZQjSeLoJ+pX4twtqFkEG+WbEpJR+IPjszsMEundG3+KLnnSfMm
	OSYa6Agko0u4kE1ggiwM/R9ahMbBXWGwRFPYXFzw4rvWuM2d/Vs02JR2hVzQd8up8fDKg5
	ATw32H+gwm14DnZyCMFr1afNrBTQ0jBuvt3vTRGJRmobRDvG/K7c2GrnZ0GCgCdjLbXXB6
	rWd4pFBMNvIgKe6/Qs2cTI1SrqKQJ8qJpIdYhQwkWP/dU7QlCoPdcsVyrDo218HM9SYYnJ
	Le8f0iNt8yZqZ3+Z/DcsrC7RVUWw3u1lb+A/gOoGDmHI0CkgVs6uxqO2mcAfUg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793040318; a=rsa-sha256;
	cv=none;
	b=B54Ds4h5qETfhpTg58MAM+HGP2juHECXpBiI3+c1dZEAa48i+XriLFQyZFak64afv0uWU6
	lbx6zpTb9FP9kvYemrBzERwdgnrljeZ0nHlCrvM0M2rDJjaxz/+HcSc6mZBqEnfYotcVsE
	JVmSp/9V0TZ/aojVDcTbxVPgPHP7o3nGEPFIftTC5bRWUPwgVI1i9Xm6iakOAwXcCX5pXY
	hIgcCmQvt9RVz3WmThPzweQzNClcjSTwQUtxBL/u8gvvaZh+8tuVtezMrypqLw8jnUdEo2
	y613ZdujtFeW8whLRa2qH+IuZ6SmCzBOyUndCf66FMXIB+ofzjUJHxs2iwWkGA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793040318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFpakpCDATQoh2Q5Nqa0fBs+TsFHqi4R7N9JGysXjuM=;
	b=J37cSHj9H1i6jb6fkWLwOhabEK6d1/zZHWGhDteiI2HMiVwaXpJ3j5My2Kd0/VbXz9UCqv
	icIC919gsp30RGRrmpohiW1XtMviHCxpwIYufvXLpTctvsNTqW8+yigwBYw+mdHCZBA9Nc
	nrGKRs0S/OpCdqv73JBxeeHNEmNHD46Q7sTSbWj7JHnXZhSojv2zNlKKyTyG4cFs/20YVU
	q8IaZCsE/36CYqMHKLn6snCkb6PNRP6dbe4BKsdvk6g03uW5kz0+xh6tcJylJnPq415q/r
	LFxS53bOwZ79KZTjMlGnvGp5pisZtVojbsgB+MM154HzpHN67CmaRXGV8oXTkg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLPh8-001JyS-0T;
	Mon, 26 Oct 2026 19:45:18 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D6D825D7288;
	Mon, 26 Oct 2026 18:45:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 26 Oct 2026 19:45:08 +0100
Subject: [PATCH v4 3/4] can: gs_usb: gs_usb_receive_bulk_callback(): check
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
Message-Id: <20261026-gs_usb-fixes-v4-3-59e3b6360053@pengutronix.de>
References: <20261026-gs_usb-fixes-v4-0-59e3b6360053@pengutronix.de>
In-Reply-To: <20261026-gs_usb-fixes-v4-0-59e3b6360053@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=K7vTyiU4LYRmmk13fHSmOHnn9jXEe02D7vtwZf6Yy0E=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6P3/Xy12ZayqKd92teNzAUrHNaIpyi2as/qMlKttt6
 9YdS0u811HKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJ8PQyMjx4LTz/5dF5szal
 br57yPGVTRbDu2N7ugqyfvxIP2z6+Xc1I8Oc6Zdqjj8uCdTW/leX/k7njWVizgbfJWs0Hsh6H+n
 PXMsLAA==
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
index 31c25cda9f43..3afddc46afa9 100644
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

