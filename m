Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033131;
	b=1SmxIkrEw+8nJbipvTZNH902bsX2mwCvJExAEgdCV2+GUgoF1y3lVRBx5aOBzK8ovtFq
	 01AevryetH/EP3IQd57WXkjZeTHMs2rOdczXTaXk+8PMnnx1pBD5iISSlwe28+qBSAmkg
	 0473nKgb/cizdwvq8yzpcp6f7TpjMwQyFOXx3kOP283ChknQ7sYVs+/vWxLY0SdczGyM4
	 6edbeQ+CnMZIokXANGs7j2ZU3OgMqU0R9K7eWj7sbvze4pVeuMCBuKwQkSnoc4b7MeXm9
	 T41FYrCDXnJLc1uPUAe2t+Z2pS+Xm87nU5fxzOey/2XjnF50uWz63Qhz4t8G0Etw2UQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033131;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=9lNcbi/00HapmznVu9Lst2xGU1PENo4wfUKNt0U+SR4=;
	b=LDwAatFu9yibGqui8HnTmO/ycA1JWUpS3FVPd/VSWOHevwWjpn/uNxKau1Mi4ZRGHbRX
	 diAnlVb6EdUyK8GCbLk7sbEYb1UFmSzfrN/UyC+cteRB8zbhtGFFICFuKNcuMv2Dy9KRG
	 wtlG2hifKkG3Eh6T792N46/bd0YKPSu6QOR6o7j81lHjsyTj+8TzX2ltCvQ+QIUiFIXkP
	 zIYbUQVSxozztfB+QYloekqy2dues8PGVvai1AlG/C6haPSAlalbAGOtivGigv6smnraE
	 DavO8kYKnACMsftr+ztusdKsm94IxCqp34pJOPn627OA/8O5qm9kw7yjtNCSaP71IZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HshfGUN8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03C606A320;
	Mon, 26 Oct 2026 16:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F03C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HshfGUN8
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6B73D202922;
	Mon, 26 Oct 2026 17:45:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lNcbi/00HapmznVu9Lst2xGU1PENo4wfUKNt0U+SR4=;
	b=HshfGUN8TjJTZueS2O++NoRfh3IpLJjG8TaZ3KN7YglxYUx22RMFlBjpseTG4p+WaSuhBd
	XJOQDi7goSzx8KRU8/l0iyZaI3Gwke5EIjwW2Xvn8oXifx2LFPmIocJ9sA9Ylgc4P9bLn1
	kvk79V/f+UQsyDdHDp9//VOHtu8QeF05AaW1eTVwPLroBw0p6Iw8dvTM1JIni83RRBfOuu
	3Vso6VXz0/bRyQ44kkHAw0RgX+ueHeGTDbV1S7RGCEAY+c8qH8Tvx5UWwaifKEgeB6jCdF
	6YNbyHk7l8/el2vTO0IDr76CpiJTprWFfHDABIulUlbBYVIi7l9nOX3ukH8rPg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793033124; a=rsa-sha256;
	cv=none;
	b=JiINnM6adpBM0YhqcndI3eB8y0wVsFdhzhd7L05y17vTHLL3nuQsGx4X3WILLQNEFyNqmy
	fFq37P4TCUGyP/H1XndoLutljO2dR0PTt5enAAEvL0wCNsfgQXOKZ/8+vp/oA+EClEpvJW
	mOskhHD0GbDZQ7qDzjbIAXdsMalutRCDzJyLD4SO2hVhNupwFDNUnUCN3vp6yj1M5FpDgk
	Dg0raHYK6kMT4iE031sK6/rmHrywiuncIIXY9bxBQ67GOiSShDfuUGgWT8gyNcEmFzzJuQ
	0Cupk3FsPFI7T9AcRyLa3kXfYBh72HvLPNCL076d81okeZ1DTXZPRveLfWzrrQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lNcbi/00HapmznVu9Lst2xGU1PENo4wfUKNt0U+SR4=;
	b=bd7rarn4Qpa7haDpVzWOPACZqYxgJL7gXKlgxGpV9lAVCk+ouy1X2AXGFoKd/mFW6F7rrO
	on0fdH7dAfF2JWRd7eL8V2R+M464pd4fXlnMG5MhQ6S5oBB4yPjliLWptMv2L07BGd2UYZ
	Tq++b6pXJAURUfhXyIzQnpALjY1gbkxQoE/DmiziwAVhHHLJt6Lo5F9N4KueoqBHBkIVi2
	KwPX1lf1gGqCMm6ysnsYgqLtn+NDZZxW1yECKeLuQP3vFPchsTkIhbyaL+FT5APPjisVWq
	wIjjWVcolOGMUv7HNg0B2QEZ84fRozGOR4nzGrCYPioqEXv8lrc7RsMK8bgcQg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLNp6-001JFk-13;
	Mon, 26 Oct 2026 17:45:24 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D8BF55D716B;
	Mon, 26 Oct 2026 16:45:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 26 Oct 2026 17:45:08 +0100
Subject: [PATCH v3 4/4] can: gs_usb: gs_usb_receive_bulk_callback(): add
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
Message-Id: <20261026-gs_usb-fixes-v3-4-3a68f1f62813@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=V70xppMYnTmZVIDljTzPiitow+b3ymMgyc5OPZswWIs=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi637yw9crOMzMe1zvtuK/TrBX/6FONrftN4+W22fXPe
 Pce/muZ1VHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJHFzB8D9Kvbzj+iWtxo2N
 Sf3vljx9v3HzvPLXV8qWnuy6mlOosMaKkeFfobfZv1Z+h1WbGh2+/jOvjVd/L3G+lb3nxJrwz8s
 Vc9gB
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
index 5b0c58fde53c..0e945f04d81b 100644
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

