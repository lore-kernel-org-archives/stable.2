Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794669478;
	b=U1opvCIPVps5Mp3Cz9sSvqkVvuzQ1Mzqs+BYL7s78vGZOjM6iP2wkBAh/NPlWoA2YUW3
	 sg8zfb3zXJ8hch4uTnuEWKTypQ7EgplePzbKmUIShUAQPbs7dLt+KVeeEjJlGy7id/KE7
	 8LdskT+urkiagt40nQ6BuB+SgaVUyYvpVM5IhgemjB8/GT62yeVmThpFukfDjOxqt8jiK
	 uG7CPynshj0jcP+Z6ZOE+LoJDyBnF51HgY4AGf7UYCBXjGn3TsldQDqeeK/MzHg+2hb3H
	 G5FYBGR4o01DvU9driG5IkiTcaYbiA5yHfOsNv48IOmhjpVqjYrs263B9X9u4PN1rcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669478;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WOEtCnvIbC2FkS+7wC8CJhNJPIRc2fn4Oa7C3sur1iY=;
	b=M7uakCXpElNAe4JGoKd6a0gea0XOBM/3pihD9rSU+dwJcsxsbf/P67wrvam3CyV8Wle6
	 5GfJYjh4kz8mLfEvlKH3BzbHWiPkbn1ZtBGbZyCTXg1MWKMhm+PnxeLCffgR00h095a35
	 qJmkiIRJp9tPUmHaIvAsGCKagJQwIGxl9jZM2BsSpjiq4i/VP9uA7FZUzeUu2jJkchLVa
	 eLtfeqFFDjOkAksdWlMdwLYJ96aIYpy6qUG8SXkbtGfJ23e2VwGg3eYqDWPUwrF2aUNy+
	 RaoLKCXlHTMiCWbDoxQC8gMTwPaMhDWXP1j/w+/0R8bG0iiqZ4xcEOIgExURlHDhL/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dS801pto;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B4606A32D;
	Sat, 14 Nov 2026 15:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 902B4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dS801pto
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6E17B202336;
	Sat, 14 Nov 2026 16:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOEtCnvIbC2FkS+7wC8CJhNJPIRc2fn4Oa7C3sur1iY=;
	b=dS801ptoyEPJkHZBrEOHbL4NqqP3QVfZZHLr/mohpx/0/najSvytQ6YnI2mCLIZtdOJnNV
	yoN4i/dhIf/jfEeuRX1fq+/oUvXgoUP8d4GMZAkp7GguOzF27csEm1ow4OtB/aiRpqyZYr
	XeDjTTvct0IlkZqF2gylrR/R3ePuHC4EBAqqSkRUtgHF6UXUETjjCkSQhAvMnnhRypCXNQ
	MZ2EQh5I1fOXMHNLW3JOP55Hh4/CKBe8JzbzhxwkD5OEWv9xusKubpoerdMkmAH+ly0upY
	F6hgm8QpKTwc8Qbigv0aGfDCNW/PSZCg0Vbkqst5g/B2D6L6SeRL1ql8EoFVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOEtCnvIbC2FkS+7wC8CJhNJPIRc2fn4Oa7C3sur1iY=;
	b=Ke8FJTOZAVjVPuI4vi4RwYKPbItrt+gT4iAqn1dv9Ep6SDwPbjkeCwyr1G9M1ozX+3z6Cr
	PJex7hT78tKszXBPTNXVoIytM7klcXlO2+cbi4FP8cHXaWyaDFdPUGE4pDw3RpJ/3qK6My
	mahoKi3yd8/oa3B0heQizFUL1E9t5embwmVc8+DYjFDYt0cx9G18DPcWlJg7MB4qG7CeOt
	IXtEIn/arQyc1y1GHKkCbTiM1Zj009wSA3GLNSlsGSo42tbgE7qb1gF+nATePbRmI2svHQ
	ZGKz3QgirGF9JL6Khb4qqAV3wP1WmgtzmYMKJKpKaqMfOOTRHCJbQu5qTdgj+w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794669474; a=rsa-sha256;
	cv=none;
	b=ED3VCBTdX7Lks+m5EsrnYlQYbFSyJBPQKjeRSuHkWVOjgTTsTHW68njJLRwC3kWvWdsjMM
	Z+62bdGo+Rz9Gu6vv3hUflmOn3zk4d7gyGt6+8BfU4PUkGAJDJcVxW7LWsnqCUx5f0Nbov
	Mzn/7gFkcrX6X2oHk73IWf9yNm1Dwjr1Zt46u2ZfwXFxr7EYF1b/DWUr98qJuDTol+50VB
	AJvRLpjneOSWNp/pXKzB2pCvcm/V/OaDZ6H8bN5JsbHlXsRGy1cyX9KqrjwlukgbDVRDj/
	EYwG8B/D7+b8cmTTkF8XWSxMk/CdgyIMCTw+RMMQMTIKJEUksBH5IdB/r+lSIw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSFVq-0049oF-17;
	Sat, 14 Nov 2026 16:17:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 11ED25EBB32;
	Sat, 14 Nov 2026 15:17:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 16:17:43 +0100
Subject: [PATCH can-next v7 4/6] can: gs_usb:
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
Message-Id: <20261114-gs_usb-fixes-v7-4-58b6341b1c08@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=xTveZx87Sa3xmAWTY+7027NU30EfLt7H02pS8loX088=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6UT2XNVTU+8Pv8EXrNZ58XViglrUtyP7bA7851nOyB
 V7tW/mqs6OUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQATEXFl+F93rb5spmq2u/cM
 Zo1rE7WURH1CJiSp3G2fdOGF6sVr14Aqqo7zrW+s4D/4tFRa/n3WXxFOLq1pC329L8rzCp1l1ln
 OAAA=
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
index 1db2d660355d..980c4a748c94 100644
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

