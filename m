Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794564540;
	b=wnBD4URHpW81tpSWjObBg8TfuPgfZF6VYn20j7d4bhn3DJOaBFFC/+fvlFNoCHit40lj
	 JgCfCH1/fnRis7a+5c5gOifwKfoVlk03P9EMsHkCp12cxopW/hvb+D11VeG6OHAyHmBlp
	 YuCDPc+DWc+vyjluecxMnX1Z0U7OC5obeWBHh5iLvP3kbEate3ds4FXXco8W4JoaSCq6Q
	 XS7KNBl2ZSWuaz3snr6pMbKYj4YPA/xoVfymEyW2PF6V6jCoHsq2TuA0VPpn08yOkrjgT
	 1sWDqtHCaLXtIW39G/q8mqzk/6oxXJpsRFUPoeswXE9FRod7itIGj5xX76ev0uMNevA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564540;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=5BumYnxgr688Lhee8MEpclMKI8kQD18bv49oVRSM+tI=;
	b=VCHs/BQ9YLFBcMl9Sdjgu2yobGNa2rFq+Dh6m6tFfAURbuVh/oelFJ3s2lo7O37FiiWO
	 o2wXgszdkSPOQlU/S6P+eH04Znqn6NG1mm95JmTkbwhEuEXWmeqkxSed5FylrepVJtYuT
	 2WJMlrIAFD24A3y0oDuZePO7Ap7wGdQmcA9rktF06ETUzgABENW4SXmarm4ykk/+7+q8O
	 K08rQkd7vPCUqMH1DGZH7eFMSTnVZSdJGkdFB6bPGD6WjOKvAlhPJ4URzhAcLJ2wnmsjy
	 NLLpREnuFd/gphJ/3PivAQAu0ObWoUYp2GbWMALCjc2KpvP8UYEyGHubaZb1kiujxSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HGrWosRG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C36606B105;
	Fri, 13 Nov 2026 10:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8C36606B105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HGrWosRG
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A79F320215A;
	Fri, 13 Nov 2026 11:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BumYnxgr688Lhee8MEpclMKI8kQD18bv49oVRSM+tI=;
	b=HGrWosRGZnl336KHIEVZxWVFkVjHBEUfZ1pdmUvvM9kURGk5EcHg97NOJbKaU0kb5uxtEt
	E42fco2ADRZrUPc826badgC14WzG8DJ35tL9nWJEkE9edy/34nlSvGk9Li/gqqI5fjcyNL
	WPYrmBPdGbmQzX1JCE8us1o6TAREYqteLZpEZWYibkLy+/t0aJ3C6LtfkyueWNDSQr7BqP
	0pyhR/Y4BeFNRQ8MUwFpYsX1EdhTHtMIrw8jdLLBxckwvZd6UGi3LEJksxBQjjRdqjfvlu
	rvbw1X5fSmZArYiBRc1WspM8RaetxWrwk8e0+dr6c1X51j6A6ij17xzEmmF0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BumYnxgr688Lhee8MEpclMKI8kQD18bv49oVRSM+tI=;
	b=XkTU5H4eKM7dFCCgQaFnXTjbhGLcNRST7FuNPuONzGFHq4ATID5Hyh2zQb9JxENXCFqQ/0
	Z2GvCeC7j7u6k+royT6g3zhaxXIzOjzl6/DoOnCJBFO+At5FTifiWP6vEzhVH5tLuPkymr
	KxfAXcag009MLTjzEM1kJjEJ0WCgneLuwa455ZBctrOEYvH5dMUucMnS4dDx1XYr7QbdwR
	3+1TznMBxs6O7/5wFlMuHIUD1Y2bW6g4SqSagVc/7HcCge8khNGxuVuwzGKBG7wi8Szy6I
	JhNawqxZThov6QNo6UgvGZYHis0rVa7SmANWS6GUExypgtaEYgsk2EXgB7y9bQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794564534; a=rsa-sha256;
	cv=none;
	b=MgbvqU2BbNgy6V+3OmLFM/802nfgPT8xqhKmsnQg5IqGGvSweBorTvtLSUrPPE8XN0s52Z
	gJIMcfTdIEn9r6jL9VGuA6LikQjuTH6tLObPyIHjQGffZZwgS0gsYvaPq/z2W8tueUjicP
	jEmCazNtUeIFe2hDRZVcnj4i90mZrLdt+t3NXLSGCbroPcHkHtkgsH2hhfVSFH1LkwKqo8
	p1ykILAYdX9eYwWtoz+6URf602qLM6yDA5lSY+UmL9c2lWmAiyDUqFtzImgipU/EPDdaVN
	VVE+RYYAlP2Geuqju6tlZEPJqg59/lsTFSz+WLbGD79iFcw7JzGSa66hCnV6Rw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRoDG-003ySM-1t;
	Fri, 13 Nov 2026 11:08:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 50EA35EA851;
	Fri, 13 Nov 2026 10:08:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 13 Nov 2026 11:08:42 +0100
Subject: [PATCH can-next v6 5/6] can: gs_usb:
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
Message-Id: <20261113-gs_usb-fixes-v6-5-0c039e1bfd74@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
In-Reply-To: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
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
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj69nBzW7xrXxbLkbxlHs/4LwvPdbaydfDr9krPWXvq5
 V61YzvEO0pZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjARTklGhtMG2tHv9O8tMptX
 rfVKcfGfs6uNt6tdnaCuWprbUMtid5fhn2VixOOTN84ySSl83Lm4567f5KoYpbUbs8W3xhb8aT1
 8jQsA
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

