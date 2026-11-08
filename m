Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794171229;
	b=Rh4x1d1aTkFsewoHIh/N1akEvnM94ncbPHp6TzO4Vwal2ELxhrd8FoiqzSjLnH03OKnx
	 ffbgq3+20+wwAAW93Jdo9CNXaD8tXbGAzBwMRubU+dlsq4mc/edkKyK9ZoZjWXyBLidMa
	 Zu3Bk8qge15IK1Vv5kZH0I8m/vrR9gNg57z3YrF1X15dT1vBI0iesOo6aydWBhHrNKo9S
	 Ym56/lzR/tcVr8gxkD9Qt+rC0rjHmnmAWehuFkyBa+6EMAKUSlE7ANu+7eIChO+f2b8j7
	 PDsbzCH9K1TULDcS4bqE5ReSYQ8+KN8c7kReKfrDWPijc+TN7+Ul9ZNYPgc+xQXBjPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171229;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=5BumYnxgr688Lhee8MEpclMKI8kQD18bv49oVRSM+tI=;
	b=TU2VKeoIG5rC/Jr796hZ1Uzm6zRdSPOg2PUzm8YgEJfL7meQMlsXx0Q9ylBnhAEwsHib
	 3nmo2SpiivxG3llS4yMm6S7k3sHvb5B8m+R9O6gY8OKOLX2P8UBfcNdm83xKdwyvwqaaQ
	 suV5vMR8K4OA4pr9FqfJjX7A4k7w1L/WNjtG0HP68TsPzUVY5DrLH9RQ4bvJ1obHM/5B+
	 VJ/Y1J01cEWRrUP+hVey+ZSTW8x6Rr7TTi4t7KqLpGKBvVvKNk1lq8g2hOVcYFzmi6m5b
	 0RoiJ6Kz/Y+hNTwt57hu0i7qm03XKnI8Iin/1BCpCqLYvsjvebWe9hSAVEPR4owca4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AjMi296N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8E606A331;
	Sun,  8 Nov 2026 20:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A8E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AjMi296N
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0D3DA2019C9;
	Sun, 08 Nov 2026 21:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BumYnxgr688Lhee8MEpclMKI8kQD18bv49oVRSM+tI=;
	b=AjMi296NVOCaGlijdubDCPm4bMFB6ze0oiMOQb1+Ql0stGfmbmLVa/By+L5eDovLgE37yT
	QrhZc+fmj6+LaRnp0IlpaQMvTcRCc2KasVA0VYfIa6yqbsAYzdrUkMH0iFl2/eY2DE78gQ
	nCEEibIvSdqk+M+AyPNgYmxDafeSbiOAt2jtZ2BAzrCVXjSmdWUAQZpVUb44x5pm+9hs8D
	ZOOFJyxJJiTwRDzqLhQfWL96qF5l7aUBydGXuzyr8pZ7EJCYT7zisbTgpxrSgoU+iun9nF
	rKZ/w3R+Dt1FwxSy+zFfvmSE2quJ1fiQ1fj1vGW8qTiYeYY7ubOZSPsFu8oDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BumYnxgr688Lhee8MEpclMKI8kQD18bv49oVRSM+tI=;
	b=Aw5AnWROrEPiw55995Tqa9yoL76eV/s04+fkrzqxn0bwVLSEjpoZIcIc+aqXnrs8b0Hl46
	4Ghg0vdd0te58c0lPgeRLO/qO/erVrQjS9STiYrvFHKY5/6wBcyoHYnOmNXyBiSzUyLVI6
	0S7LXozR8J23hONeodLcW/2pLJo+CuWEAO9PQKYKuv1F9Sw4axTuIiz6CkR9B9WQylHejC
	ALXj8f9pa7cebcVC3y8WpsPfZdFKGpib8PJZZwR6b88d3lG8j1fQ8fxgpkyj55lwKs0lij
	m2x9eTo4zcUJks6lEiuzjQQUxPTVmt1KnHwJ8mwEZV47GSzZF/upNPlmNr6NdA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794171220; a=rsa-sha256;
	cv=none;
	b=FGq8N9QrRU5RAEl3sVTl682Dw5ScisQaO2B0fBbhoGiiveibcU/QmhSYxsWOmbf//8If8Z
	1o5YI4E/AfOJi9JLY8mRMZUUAJLrS+im5zMoVc0Y2s9Q21uB+KKLdowVKUAwV/x+hIOyyo
	EKVpDsITCJp/qyLf0Kz1VSxLgmfY370l/q1IwQ3YiTmDrsrAskjR0FFYqstBhVU8b5GNZz
	oVj57CtG98jnWNK50DoRoecEnwLyxOUWqVt6VrD1lV8dEd5+kyx2QJSM6cgAyEGEA8FGzj
	kATko9e2hf7D+e61tWsse0Ua0HdnCOnlBUPtseUH3tvnK4fDIqgpIeQYZTMpYQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQ9tT-003EmQ-31;
	Sun, 08 Nov 2026 21:53:39 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 89E7D5E3E79;
	Sun, 08 Nov 2026 20:47:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 08 Nov 2026 21:47:26 +0100
Subject: [PATCH can-next v5 5/6] can: gs_usb:
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
Message-Id: <20261108-gs_usb-fixes-v5-5-d52dd4940d46@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
In-Reply-To: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/WbcXCwHTBEd+J1sWhsgb+mXbMyqTflQZVZAIDtwrsI=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cP9ZU+neCB/Lw8nmX3+LbWCsrTr6/Kp29s0Z4vIp1
 /7OUBff2lHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJdPxnZDjutWSvpcQGJ99F
 7gKFP7ym8/8r/zavMv57Fe/OBfXKRvMZ/ko5PLT4wvAr8b7NsjczXJIb3ujJbhZLq980K5fbN1T
 uLT8A
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
index a42dba9d158e..6327069f63c9 100644
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

