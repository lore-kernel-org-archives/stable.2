Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373338;
	b=VFDeQ6nLGG9KV2dE0c75UIJ+FypADnFnbd2u/omTfX7dAH36em8EUVKE/VfVkvhAOXx+
	 smwpkwHyyHk3Rt59nvwJpJicaA+QaG5+Z6z3Wjyqjn2semsPQtyjQCnH9kO4K21DX0O9c
	 EgHGJiN5wKLR6RIhqj3nSxeJro1prLMFIg/eRAEvN8d7ZSBaGrqxJ2f+vIstDHYzGqMmJ
	 anPBcWV5bRVUFKuOIVkcrK0NZtQmSwqp6i9jxGbhVBxAsjiJplTlfSQzCALGMpN7uSNfW
	 81dUViYBXe6FORr7Il+aJJ1BAtpqtwreZe9tlXb5Uedrj70rWq5UF4HK9Vxh9TkZbIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373338;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CFjen9ZF0MW+seTp6lUBHRiMJUwqrgcsUyo1K+US/Gc=;
	b=NspSnC+WZYGdupWX/yMcBZVeqaQoXJZ2b6TvWQDPOTNVAj37Vm5LUDJz8qmoae6GRSzx
	 qskNDXAQ6CWpoylBt9uDSBg7Ppezfu8GM7qpYRcVx4E9XoDvayqj+eckw7v3cSF+YDgE9
	 /HgraDRiAG3k4H1r0lRdMXPb7ffi2YEIjniMzLVv/n67AL3l2e8UM8hA8JmJif5NUO3zC
	 2pV2emp3l451TI2QCxu4sb9lB3yor+9ePgR/pF69ckcu/6EshaSL25IbjyvUFCAJvLitk
	 ujSdXdnwF0eKfEsCkjJBogY1ZwkNb4hTKugWGM5OsN8SKbt5v1gNI09dy7d1a56p6tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="Az/3nFsM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2D606A320;
	Sun, 22 Nov 2026 18:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A2D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Az/3nFsM
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5A1912059C9;
	Sun, 22 Nov 2026 19:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFjen9ZF0MW+seTp6lUBHRiMJUwqrgcsUyo1K+US/Gc=;
	b=Az/3nFsMdF2L3mT2LwJa+tea4bpkBli53VCcVrY8L57N/NnbHxBGuIwNCBBgB17PQzRmIY
	gzpkzdUbWkrFcjyN5V83olqwZZesv6zqS/ekOwobCI5VO70ALCltF+sCTAbQjf758KOeWO
	HbRRqHiB/VpzlDRu30/D0R8IS+k/vBkCWIa3dBjJKVAFdJik9c6uqHlAfnsamEOjbSJDlo
	wr86ef1rR7aK+bDQdVkii7fvb8ZPTqaEXQH0yE106BBALpa6CH3/dWN+CnCm0VBYo8z3o8
	uy/0lpglB87gU8iGP0wE6pTIJgpn2KeKBUJbV2C+/nTpaHLg2vLg5JmzNPxcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFjen9ZF0MW+seTp6lUBHRiMJUwqrgcsUyo1K+US/Gc=;
	b=g8o16Suy79GDbZRvbapdzjLzVm1ljE52IC5B5CKlrsan+an3FDfCNglFiQzTyVWdx4As4f
	u5OhwL6gXWyGniZ6Ua6B3ZXz6fku9kZiyRoGt0cV3DAJEOKh+AD+WLIDywMY+OtZF4NY+M
	dvX84uhQWuVmEuRZly/GI1NJ5KW4JlUgC9T1QYi9rhfumnv9tzWzKUS8/C4nXwAVuXoK6G
	isdSF2EEt6F2MCka0H1ZAlAmeRmZ17qE6Zq/2YNd4ye2v1Sm+fBLVR5YJil4eGkAm4bUGA
	koUIMDMsxLwS4XJ1+XBXmbR/8rj4CfwPf0zt+sSdSHiZ/+oFaLgpiwReAqw0Yw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373329; a=rsa-sha256;
	cv=none;
	b=UqtwtfqqXPaujHIhbXebf+wbcx4YJ1sK4YYK1U/K6Sx5rfkVZKJg5alRO72tw1wSV9ZXlI
	bI3CtBAG8Ciux2L435mApT0YdBFIpdXz+EACvCNgoCzooFitaiRynbj5PoRSzbtzf/EP8K
	I17P8Qx30pPi/DWRor+Ge5Mec1bwuji4y3xACqgbQiUpDC69XS6gESL8DDGQcMIZ8GxJPv
	Fdyop6Rvd5PSAuQy5BOShCIz+nNGrqw5+Q7xTxX8xeUAiql6OAF98neMA9u53ZC/pmp7E3
	Mn81b9xaBpFDugtJnUNLtxm2uqORnELLxbFU9gF5XKCDTNAKKYcmyATTp4jusA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:27 +0100
Subject: [PATCH can-next v10 03/14] can: gs_usb:
 gs_usb_receive_bulk_callback(): add missing call to
 can_rx_offload_irq_finish
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
Message-Id: <20261122-gs_usb-fixes-v10-3-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=0pbRUdXwSKADsXWU1xpzsQ5RFfkjqZ8DJBJwIog0CSA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtmSaz3Htc9t8tl/79kdJJ8yZ4vHqQJQNv98qeaE9q
 9+5R6pJdJSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAiU+YyMmyaeN5bzD5mvee7
 0MkP2vwDt/dPlgj10rw4d0bEgl7XTkWG/5E2ZQ8ja5/KSdQXsrHpTtFv3iEdvvqYXUiTm8DqH8V
 G/AA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If the overflow flag is set for a host frame and the allocation of the
error SKB fails, the URB should not be resubmitted immediately.

Instead, call can_rx_offload_irq_finish(), since an SKB may have been added
to rx-offload.

Closes: https://sashiko.dev/#/bug/linux-441137e2-cd75-411f-9ff5-dc4d473c5ddb
Fixes: 24bc41b45583 ("can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 9e8567544c88..c9306e715552 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -741,7 +741,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 		skb = alloc_can_err_skb(netdev, &cf);
 		if (!skb)
-			goto resubmit_urb;
+			goto can_rx_offload_irq_finish;
 
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->len = CAN_ERR_DLC;
@@ -750,6 +750,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		gs_usb_rx_offload(dev, skb, hf);
 	}
 
+can_rx_offload_irq_finish:
 	can_rx_offload_irq_finish(&dev->offload);
 
 resubmit_urb:

-- 
2.53.0

