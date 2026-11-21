Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300582;
	b=otb0HVBIPgPwIp7y4ZroT/ZtxN07FkMJbq5u7UZ4+wdo475aI80grB0A/j7PIbuwGpP+
	 OzB8UW6j5OZ4oFgrIfMeRnev6NTmmLecTre/caEhS98fq4ElPcfzzpWIWuk4+9ZUrYyOB
	 6LrMKG5I3T1uY27qZVCO0NkxHkJni+FKwRzYb0ZhtH7e0FP0efaI1iUZh7BRMAjsfGkCT
	 FDOrGjVKuO4z9enh/KWOGITaJ/jz95ncEh2fHw4CMP3vG1kiHRqLILVU3ZwzvOVsYwaz3
	 Ri1JRvqkHABrbClIPxbvC7AoHwMdNsH2/Fw7Dox3ICS1kM/gqX7VTmsebm9FAnfpODw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300582;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CFjen9ZF0MW+seTp6lUBHRiMJUwqrgcsUyo1K+US/Gc=;
	b=gpy6WqVoED3/dumu54O1CcW2SM4817TtgJgmls4QzyBXLocNwAufinJ/PhsKcYioL2sG
	 POoBn8w2/T6sRR78ng3nvCghjILf6A+4oIZEXJXNw9z7xJ8YZsxk3Nl8fsPTQkAVEJYd+
	 Yb4YQ9eNNmbqUMLYm+vadkIIMRofHoXRDI6areBJUMaoB1bMoX8YN6uwPHn+qAnqNpRtA
	 EpiES5kNQEYOwu6bNNlHYt220Q3fmDIoutDRrokCnNsy6q3tJMY+WwjvzNiAsC3+9uuVe
	 ersVGglrvjsMsGOJN8rrhBsopWOsPWtMbigLuh4Our6KskvuTr1oKO6e6YpV4kYxCwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OJshJec4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2176606A330;
	Sat, 21 Nov 2026 22:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2176606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OJshJec4
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 39B19202BC4;
	Sat, 21 Nov 2026 23:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFjen9ZF0MW+seTp6lUBHRiMJUwqrgcsUyo1K+US/Gc=;
	b=OJshJec4mdF6j34K9wjA5uhla8bPCWTC2i9hiLpYIMILLK2PrARbRNxeF96yBGRt/cebKx
	8qwojhxxwGZigzrZoPoAoBC0exZeR5oHmowXTt8IJrOi3wB5tA85MFMNJk9Tph5C2sEqEq
	rSyUAGo6OH+aTgyMMHFi+9DJUDDFY881YXxp1NFhVj/dvTlEomxStqBPMw9UMiVHs+gvHz
	YU3oWivagSKT469Ax4pFnzMm4rQ5WDsZ1WHMkLdOCByEcE9p/3wplgSMnUugaPgG5/OSvh
	hOBVm6855pd2Uhmtth7nAIw8+IFyFLTYBbKlK8z8Un9agst9zxEwH++f7Hw1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFjen9ZF0MW+seTp6lUBHRiMJUwqrgcsUyo1K+US/Gc=;
	b=dj3499KPvSzcg/HmpspahIFsMKDp8jwj5VEiIsFEvkpa5Qk4eedxUHu6xsx10NdJUpihnn
	SPfOuhMiBvLl5yCEoSR7K4oteQny2nLUkru9JnpWH688OjAqoZXtr9GKZNNGFUIypKU3ut
	Q3kAMQUO7nQdzmMssaiECUEYHKqHwqsPNLziA714+gyyH1qBKFHO51dch8c1Y2+zxAxg5/
	l101l+uL8bkOR1kUNTTP1BJZTLVwMgScQyuRPqejJs+WWaN2UuucYZrPzl6fx+9OAiz4Ck
	UN7rrEXhkO+SI/aiX7OrnD1XAP/WyUYKnKqFNo2uVvQuiUNCdDAbyquakj6o7Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300580; a=rsa-sha256;
	cv=none;
	b=f+ITRt6k5MODC0f+5pfU1dpkRyTs38v+w4BdLwiZCJCPGyWTFuecgfwUSF583UMQikK4Md
	xOaE85/YCeYxq4WvVtS1lenkGO0is2Raq1BnO2tnOKyWz7XjpZguicMUnVYizWFaskJCTT
	cqyMw4IGviQrcso+yYtXSM5EMr/QgTjoAXmb5SrJH0hfZyzbR88cc7vdfWRdTRWHAFhyMA
	5aoO3qXS5+6r9BD3pIKU8JKYOPvr3Va/gFwu0aNHtJ/hI+tT6fPqH/iU3oga5m4bmSRfGX
	iW62W9jpNHjFAKnlertiW0Vjg7iBslT9Kfef3D0d/vmE6l9fl0J1sFFrH5e6Cg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:01 +0100
Subject: [PATCH can-next v9 03/13] can: gs_usb:
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
Message-Id: <20261121-gs_usb-fixes-v9-3-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=0pbRUdXwSKADsXWU1xpzsQ5RFfkjqZ8DJBJwIog0CSA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrk6wYShZHNIT6huUBmDXGGO5uwd2h6GLhUc6axZR
 twp/wU7SlkYxLgYZMUUWZb+OKEoEOhQ2vsyYRLMHFYmkCEMXJwCMJHATob/yXtb93SzTrpRF/c0
 VP7ni8rIWxaTlxVdaN0c953Te1GFO8Mvpkztp1xC9SV9K7VOJZt51013u9mamOueKH7mUdwUsQY
 GAA==
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

