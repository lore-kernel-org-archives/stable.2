Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792953402;
	b=D1fjbdTYa0c7ewBABV601WUgKAF2VmbIu8zwyfbZzm+9XBTXg0UyNkUbR++Gg1SscLo4
	 T9JYrdkzRG7/7hnEUJSq6RISpgCEBDEsb1ucGxoLnr9dDK5MnvVe/kgxsfwNsdJZUP+YN
	 8esesEExp7/lAwba1WtJECEP3ITxIrwR1PTdJYN0PPwW1DFYrrsPGclOFfknzUw6kB+SQ
	 GRSfP4bX0bdNJegjtt/eHLivx2xdeXJvLDVKR/N6I5LbsxckP2W6H5VKRpk27H4IjIXwp
	 F5GVDn/rFsL7mqgRlX7lxlDjaT7Z6eKdVR151leAvhrZ9hX3hy9PCDHCElq8O6GDPjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953402;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=z4fxsR/d09NNkomvP0goWYighbPYF5tZE91mwiOtivw=;
	b=mNlzXvkhbUnUyxgS+y4is4OEQw7kJlJIn2RIjx2TKfVbPqDepeGlRXbAKciu5oY9x9FP
	 71P7PUbsLhpc3LQOomu+mml0U5iuyyjjb2PI7DJhGI2b87ESMOkLlT5WXPgCqL7gCi965
	 R+1ZJ7tqsbB+Vi+vmtz2ZRFjNdfLQup2B6B95FQnWAHxK/uJFN0SY0sEUux4ONEhH9iLp
	 klk+Ac1Jx7TO9riX1iJCBpEUwJk0ES6oK73TbaBI/nZ/zxO+YUDhesYYiKBxyG8QL251E
	 leedsTqZcQ7fCN1SQaMbhvez4c0PnJ8Xp2wUIFcIJqFrP7JA+mgyBuChyB9eLiVlEXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Y3Z4bzuB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F140606A31B;
	Sun, 25 Oct 2026 18:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F140606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Y3Z4bzuB
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3FECE201F35;
	Sun, 25 Oct 2026 19:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792953398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4fxsR/d09NNkomvP0goWYighbPYF5tZE91mwiOtivw=;
	b=Y3Z4bzuB9qIDERpSDCKjKPcHHMfjzV+hEP0RJ8VtoyaKG/Z4VSm1lnyTEWJ7cZUKW/Jshh
	kC0x07s4T6P8ERlzyyKchMDZdR2uBZ6e5oFxjbetIO16LPvguq8Ql2D/CQNEJrEeDKI1Wf
	a3SYhLsl6iyxI2pjbU0VNGTgDXhazi3FmqjDe2h5WuqacUCVVwC1/WzCRDbeE15lPtfduj
	9Uor7v2JmMaD8mWYUvXqrvrUa+w68g1SIAZk+AOv5CPTtJ108JhoqDbci5a6j+A8cXUPGG
	mJEqyhNyZ8CXj0ibjLIEgCrsY/9MzfCkaiPiSGkeZ9WUfvc4mcfHtq1MyWfsEw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792953398; a=rsa-sha256;
	cv=none;
	b=DjGYmX+nfcxei8pz/9z1j9K29ONXaqFuHOuTYjt2hYu3kQnS1txDpwA1F99WWVEIZa3t1q
	K5JBCtxAu4oQHkZqCoWmKVgNQWrzMS+iG4MMQ5unOSgSt81gRlJW6Yp/2+QgR0VywXeS6d
	XPYQ1NRyaAUo9tKn8glIFJjrnVrMz03jf6n1lySXwAWcoXjJy8hgzV9MwT/0LrlBxHRKOC
	//ekOBU58I7RJV5U6ZA0iTOkJ4F8PQETz0Dw9r60ukXT+BOWA7SZInPgQ8J15YGiS17IMA
	jH3IHGOwc9DgxorIM20ZswiSU8kdbEUA7Gvqw8iLxMbXKwTuF57Zs2VzOLlPng==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792953398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4fxsR/d09NNkomvP0goWYighbPYF5tZE91mwiOtivw=;
	b=T1QXw8YU6RR3eCB4zSq0Qy0N8jRsS0ts9qHhw8GrfINgnXLVgfAKDhpfOYfYWiVqcmMune
	A02L9f7aB2qB6lC4spLxOcL0BNP18Of9/iVoBl/W4NSZ0cDWC2+mEk8WnoEZ8VB84Z8b0Z
	yVwuttdrSfPQsD+86Xyukvnp5tnXJSZlPk4FraB7shnRU/dBAwqVQ2j/640sPB6prGJme1
	n1vn7QUKuJTifkNNJC3tzi+aVMWVZmpeCrDDO0zGjJV2v/WJLsRjl7Xcx9L5RZ6vIwQKsK
	qHgVhayta3c9sFCT4YTvQd/9vcWLcb3O6L1laq5FfQoBp+YyzzkrESqIwMIh1A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL35C-001AZe-0G;
	Sun, 25 Oct 2026 19:36:38 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A72455D413E;
	Sun, 25 Oct 2026 18:35:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 25 Oct 2026 19:35:34 +0100
Subject: [PATCH 4/4] can: gs_usb: gs_usb_receive_bulk_callback(): add
 missing call to can_rx_offload_irq_finish
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
Message-Id: <20261025-gs_usb-fixes-v1-4-f74ebbd4da36@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Rz32E7AYy11XezyRoyDg9anBfLLbDnaCG4YTLHjjcAU=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi658O8OfJUCWe9zT/72HuxYp51X/QtCyQFb+T8lF+4d
 3JHlNGsjlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEzkYhnD/7QncjPP5C26M/fq
 EYMf+7TOOZetSXuetSgt9Oc1dqEt500Y/jt+Z+szLtMs+H1L+nmU8r2ojF/n7t5dElM2d0F/l0u
 mGBcA
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
index 5687544af99c..4635bb60e14b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -743,7 +743,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 		skb = alloc_can_err_skb(netdev, &cf);
 		if (!skb)
-			goto resubmit_urb;
+			goto can_rx_offload_irq_finish;
 
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->len = CAN_ERR_DLC;
@@ -752,6 +752,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		gs_usb_rx_offload(dev, skb, hf);
 	}
 
+can_rx_offload_irq_finish:
 	can_rx_offload_irq_finish(&dev->offload);
 
 resubmit_urb:

-- 
2.53.0

