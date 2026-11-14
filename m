Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794689418;
	b=AEzcLtOj/K1WFSR9Md3dipQ9Pq29ezrT/KR3N6mZMKALSuyBXMqHQvuoURmwuTnIscZT
	 vBBqiGF30zLKznR4p4wk/d9jxRLLYSyl8K6nVPqpcJ/A/8UDwJwn3/OXIS8MnO6Uom/Fd
	 k6VVtV5SsZ85ZAA9Q/gTu6ZKmxeFY+jI5OS8ELgRHXGuDebidgzqhm3xDqX2J4MIGswAi
	 kLt48hIvR0nbclgeHU/cg7iYXub7yOP/MotaiX5y6mifGS51A1JdxBmrwi2uYjpttzolU
	 ErDaOYn1AB0MsNsHm9K5pDlHMUUuIULrz3k1UG5mINKT+GbYkkO/CQa1obwQGml1M9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689418;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WOEtCnvIbC2FkS+7wC8CJhNJPIRc2fn4Oa7C3sur1iY=;
	b=VZvxh+vobqspJzKb4tdt1FtnRN9rY9KvPxKexiJ8KUpPjpROe5E9wGkns3hhk2yqgNA0
	 ork9kG0KfqEZc3MbspS0aoIl+lbuYHccP0zP7cH678fx7sy2t6QQZFsyHewhTGAhGfM94
	 h5EewwHJqwvgVqh6AeqvSn3uCfd0qDjxa+U00QmN5x+3lLgi3VrqMDldfp12weVQmYFH0
	 6tKsJt9Z6cZihKpl5GRS/wBJn+z+xdWd/rmntwgH/cqSMzuHmCBz6S6wYIFdxElPDrMCw
	 67JYIiTI79FACXUpFmbxDFzoM8QZNOgQkaPWQi4EVoA0O9lQF7zeyuaAEguV7+iovIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="MnaAYC/A";
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9F606A327;
	Sat, 14 Nov 2026 20:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C9F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MnaAYC/A
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 83680202383;
	Sat, 14 Nov 2026 21:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOEtCnvIbC2FkS+7wC8CJhNJPIRc2fn4Oa7C3sur1iY=;
	b=MnaAYC/A1tLmvTofpXNsOLPVFzfMpHB4RcmIBwOR2FcXfeFozg3w4WOkPtRP6tBgHMZrK1
	RrD1kPMASNQZR31vj0brd6s4B7Anj939D5T5ieTyWAESxgZiLgaTrB4ftxs7JCARrWN+L1
	rs6awLASHhHyHm5CsEDQDpUSDj9Q9TWcf8QfuTLcO4xgGJ2POt+lVULo1Fntz8z5mk/SbT
	MX0Y118CtTVkdwXAwv/WCiQUV/NyIKfdxUwJChxh4qa4VtnUZY8IUC/TXUAJBAq3Xx5BR3
	/yjlM78OxN5voW/I4/5m2fWomfYdTDLQeDYBi3yeDARaluDog6KF+JsrrmBvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794689415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOEtCnvIbC2FkS+7wC8CJhNJPIRc2fn4Oa7C3sur1iY=;
	b=CCOfsHDDnjDTNhzGJca4fiFuFdLR1lKPssPEDtTYlMMGYZvyEJZLwoAdxNraxU/v7FAHPH
	Oip49IRgX5CnBs8ZeFhBTUeZF8AywaT5S2vtrdMExsn0d48JJaRNJ7KMfsc8ToleYvZ1sS
	buv3ScTk/U9PpD9iUfC7/fRyr3jHgw1I2ZUyTnQj1yARbtoQG3ldgjfUOjwr1PXyDM50Qc
	KDavf+LZ14QV5c8a2UlpluVexVudmVFvOmsCBUy2GAyzY6RSQ5872vLQ2FqJSPbu9WSwnu
	V1TuY5zACIvDnrKtWsz+P30gUfzpx/+XFLfbsPumK1ONgR/6Hm9tqrC4+331MQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794689415; a=rsa-sha256;
	cv=none;
	b=PpV/U+LFAJk1cWrP3zkA9kWb7TXsyyLvzytx/ZG0urYTu2Wte+kl8qc0l+x+PctE/4FYh4
	j7Ca3rOOfu6c5u57t0AMX/nmumwoSad8Bx4Kuc8PI4Fahw/o5zo8/Sy58ZvRu/e5Kz4HN7
	TcUPfar/BXw7CdADeSEnx2P2KSSViRlYWwxSrdFifX9gNpMlnztyljH2ME/HaEEtAW7w6i
	tQ4tjT0Uor3UzTJDnRGCuiXWFtThDWlwcgMDuIGdaA9qQCFumC0DubYj+dtZqQlGlFz4N/
	O/uvvRYPb9YrSP+dWipcRzMJffWcEYBw5Z6dJNDND110jPz/SQ+d8YBWENvX6A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSKhT-004BfM-1L;
	Sat, 14 Nov 2026 21:50:15 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 270535EBD72;
	Sat, 14 Nov 2026 20:50:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 21:49:58 +0100
Subject: [PATCH can-next v8 4/7] can: gs_usb:
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
Message-Id: <20261114-gs_usb-fixes-v8-4-f615502b005b@pengutronix.de>
References: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=xTveZx87Sa3xmAWTY+7027NU30EfLt7H02pS8loX088=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cbJx5pSJrzwizvN7HwmsWLPxmt1kjld178scJiSYf
 f3vLcUxt6OUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQATOavJyPB5MbusT10fS/28
 lCV7zQrOhl7Z93mjyPlvXdy689pO+J1iZLgQJVnF5HeEMac/0s4npXWnt+YtNQ/pmgKbat/v99R
 msgMA
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

