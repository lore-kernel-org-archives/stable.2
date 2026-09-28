Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61C502D5A;
	Mon, 28 Sep 2026 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624013; cv=pass; b=PrItr3UYNP6tvzRx9j18noanzMercHusX8UHgQS20hUqtONy8Hj+saZkscI8f+TGViTUBK73hXYiLld4c2kWd44Kxiz3cKR7NmgezU/NeA5wjMQhY6QM6vRSXvBsLiQHOFdk/qs42ysAWxxrTOsLJ3VvLlC75Iu36wjyzoVYCy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624013; c=relaxed/simple;
	bh=nv62Kjvjw2Se9Y1SZMQ/l/ptXvFA+AlrtiuFWTfdGlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gc/9Tw/2javQCO6V7TjW+SwuOyirlK+14crgJu1dVvNn8NA4Y8QrpELkcS5yr1iVank81GknetZ+BRLdWmgnbcIKnJoiSVSWiB75h04TZxprjjSxMHyZ7rlJkrEY/RvzIuHwrCsfp171UYX9Vh+HJ8+cQsN18CbRM/w8xtoyKs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=GTObDXZO; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="GTObDXZO"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E9A4F2022E0;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfLX0FVn5KXNuLwBvoZh4vQ7hK3XXJBqTaCubH8TshI=;
	b=GTObDXZOm2EinUuYigMQ7Dx2ovR0h5W5SEmW32CMeI6GhI0Zp4M9wJXcLbqJxm492VxFbD
	A1XmytrxggUJF9tzOhfvqEgISNCDqtYQ2HOvSpTJ3vf9cPHPp+HQ+toB9XNi1u9BeD7bsX
	/NEDizONpLY7TkCzxKy7dRvJuVixRhCd4vyNBS0s+wmoEyFFNtAcy3PO5+ilRuijRNX+PM
	/4xdD7qn6iKvTvoUl4X4rxJMvhHmTSqX5vuTvc6KZzb0HAd7tA2Z98rbOxDRZS/DFiOSbD
	oOticB6+xg/TLDwwuZeCpQmAmt8EpaYJx+RMnoveXSPm+wZkkMdgUTwp1DVbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfLX0FVn5KXNuLwBvoZh4vQ7hK3XXJBqTaCubH8TshI=;
	b=Jx2bDwbCFzeqGuUWjK/fK+bBNQ4J0RjxRzc7GQBMIVSxT0s5wkfPQDxlAXmtIQLHFFBgvv
	7tMSVL4+fnxodTkfPVm7IDzZHRxY3C+Jkj2b4RSroeKGOOSnpCJmcsnaYYaqKn2+YosYaj
	XU+qaeSYqQ4z3RW3661+tzsGQo9eP/8ThHBWSo9UtupYORlHdNcpNRONjNP4Mqu8wPLwv4
	sFcdOGcg8mlSG18Z3rKwBASQzK/P6DLcEtEralem2jIq77sGwp6vIlCrJA53PSUwRVXC3Z
	ronOuI3K0gGHid1AyzOjnM3UBEmlUV+aebajNCLXEIiONSBE27YiiiNtRGREKw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=OvO+45Kz6ihwZxr0HHpDhs+MaSSJLI4Yex8Tz2afHMH85YVp7+Easemza98pgYZmqoktmI
	SGybS8CswgWS7sv1V6cfYw9UHwnWjX1Yfq3Dtm1ccEQSkuWEGqmNUU0xlNfqBzmJmnL+K5
	r4x67096koSbdiHo2BSbiZv92/GWnKj8TvIlINuYF/f9hcKxyg/BKocNfyYGwHSE6B9VRF
	458tViGb/PNGgpBjlXuAR7WgsuMHr6eOzw4x4vSV8thvBkgjK1X7LA64XeuV3CVGPt9dGK
	gBOeWCRnTA4xvkb1gCa3On83Yz3PBhpGtbH4ouOeDeYa05DIXKx6mka/XJPueQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6o-2X;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 865575B155D;
	Mon, 28 Sep 2026 19:33:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20G=C3=BCnther?= <stefangun@pm.me>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 22/22] can: peak_usb: fix missing CAN_ERR_FLAG when reporting error counters
Date: Mon, 28 Sep 2026 20:45:29 +0200
Message-ID: <20260928193312.553632-23-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefan Günther <stefangun@pm.me>

When the device reports error counters, the driver incorrectly uses an
assignment (=) instead of a bitwise OR (|=) for CAN_ERR_CNT. This wipes
out the CAN_ERR_FLAG and CAN_ERR_CRTL flags, causing the error frame to
be sent to userspace as a regular CAN frame with ID 0x200.

Fix this by using a bitwise OR to preserve the flags.

Signed-off-by: Stefan Günther <stefangun@pm.me>
Link: https://patch.msgid.link/20260915134551.54038-1-stefangun@pm.me
Cc: stable@vger.kernel.org
Fixes: 3e5c291c7942 ("can: add CAN_ERR_CNT flag to notify availability of error counter")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..785224e00c4e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -526,7 +526,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			/* Supply TX/RX error counters in case of
 			 * controller error.
 			 */
-			cf->can_id = CAN_ERR_CNT;
+			cf->can_id |= CAN_ERR_CNT;
 			cf->data[6] = mc->pdev->bec.txerr;
 			cf->data[7] = mc->pdev->bec.rxerr;
 		}
-- 
2.53.0

