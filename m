Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792957916;
	b=Vyouov85T6ulHa8dJ6L1g33tk2WDAhSPlfXlKwm9Lo/SRvraAGUnBurYZR6fhUI6F7Ey
	 Gi+tZ5UWqQ8l6UcJJx0lZ2r27YCB05ooMI0JTyRdK97LfyIP4LSNltzF6NPFqyd+ThdEJ
	 /I8o7ckWTzZsXaeMhro/IDUFzHEXV+8XBciOY8rGE7B22TVlN+P7xlbK8/Lnbt4ZkT22u
	 L/fbBC8bvsDwPrl2dMF1GeSfq4rf/mNYYn+XnILZWAPRGWvOdILbibImESYaNRrzWuPof
	 P7YuJgni/NcTkkdDw66nAbqYXE8bGgfjBCw24by+WDLAHaKKle0wmSGZO3XaBJDGz5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=y24R00fhigjY6ItQZ02Ue6mYs9oPMktDVhpDu0pCBRs=;
	b=xeDsKcFvTGRrnoSbu0OaktZZZHqsgsVovG+1dJM2wQc5fZTKKWbugH3g+XcujgZzmgXN
	 yyMSBiTX3brTMu6WZmehp0Qw47Fw4zi+808p3/HQHbMgvnES/ks/w6cqhOWyB3btJDiuI
	 uMvDlNGa87bAvaiqxZjSeINqCkXAtUcBF6bHjeiimeojhPDnQi3mIIAeO3sZmHyq1fQ8M
	 vI3OhaPkBkF94O6NdeSMISihhyccey/n9BLQmS44GDVRrHUWRnWyqXoZVa8/xgYjXskzU
	 YevX4FpQDDhEL0fgQgvmLL6Iwy6bP//mFpJQ/r17trK/F4ONdS9uML6wNMDSA4dYUlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gxE7SYRE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5F606A31F;
	Sun, 25 Oct 2026 19:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEC5F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gxE7SYRE
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0C890202146;
	Sun, 25 Oct 2026 20:51:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y24R00fhigjY6ItQZ02Ue6mYs9oPMktDVhpDu0pCBRs=;
	b=gxE7SYRE+kEEIQdbIaoLnGWubbGoAJnlD9oY/LHIVXfk6lEB39U7oA8P7iEMP3nlVVGD6u
	Y6os20MQNAQEh8fOWmbyyfqz1oVKVt0y0iYhhbwxvh7uLe1I9tSR4mPJLqfkMffSmq2eeQ
	yWH88wy4RzjkJtxifT2QL7fV+vvlkxiyQ5FbuXgsD+sJxxvxaPOCjy6MBYe92OXEcE8TZW
	OEmr9hL4/ps6BlE4Hr02uK9Wiw/BXzrtWyrfYxqwz5hxxtgjo585wQjhZE8VrMnGzeESy/
	peOATGukQpvi3MCsy1dfz+RU8Td887mtULQ1Z0KH1lkpfc1TpSxgWlZylocuIw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792957913; a=rsa-sha256;
	cv=none;
	b=a59nzJ01rD54F50ULI/tUPiU+cP1DFRc4rDripT6iqQ31qsYkcf907ypthiZDojn+XdrnV
	gi6jB76kWJW9Mt5cWppTtSAkVvXlbLl0YrtTSUadnb7juqq3TpYdBF+s+xWX7rUoUA2jOL
	nzGbKpCremPMBxjZedngP9Lcmkj3IwJn86ub4DZnd3kLx1wIFZTPeC9H8ER3p08pCayo8z
	tctbDDNmnLAAI+p4dxyTYU9NmUxs2ZhYhiuUnjG7MsU/Bfd1TU0q1F96aq/GmMrtzydCXM
	Ceg7cDsy/xNNWG5iyWI0L0DfiTWKvCZHsKW1q8hOCtQ9hF3J6kGgmojLgKPydw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y24R00fhigjY6ItQZ02Ue6mYs9oPMktDVhpDu0pCBRs=;
	b=GlSwf/mV9iiDLT7jpDAtaeoUy10zULN90/N2X0y9L6QKTGhod3T3YdS/qar9NAYXXeowo3
	2zVxi/VBRDKgpiVg5UhSCe9poDyfHY/cW+0ov3uYp92NKjHOvoFLxEhp2Mi8TsC9RVZ7xD
	vJg9RrrhOcY6zaBmQkqBo0sFyeSkSNqE1DhKJxS3agdbOZWZlxlTXCXSErJF/CEWFQcd3Z
	TuqfmiIfAqaQ2t7j6wDAjLVpkMmV6id3xM54gKwcIymQ9/Tc2jGz014nNyrOyXpds1v6zh
	ORO9teHiMJeDo3uTS/cGvCDGpe4h5k40bPdFYOhQSPGt5JoAT9FV4IWcf4OrIw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL4G0-001AwT-36;
	Sun, 25 Oct 2026 20:51:52 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A55DE5D41F7;
	Sun, 25 Oct 2026 19:51:52 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 25 Oct 2026 20:51:44 +0100
Subject: [PATCH v2 4/4] can: gs_usb: gs_usb_receive_bulk_callback(): add
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
Message-Id: <20261025-gs_usb-fixes-v2-4-535d45097f72@pengutronix.de>
References: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
In-Reply-To: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=rxlwzSHRDYVLoNLcH7hAOJuKUAUafepuvVCAeeSPeB8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6F3vNYMJR60tHUo3Ve0vF3v75XLSV/ZOnRr6Wrnjt4
 tK6bxcqOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRI+YM/12MZ1xU26e84NC9
 rTeV6xoYGlruyG5NK1GZq7Qu5trSkrWMDP8MfCRa/l2ZytO+9NqV/MMHFu0QEXHv8uF3/tJoFyI
 4mQUA
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
index e3bf1c7cdd83..83bf9a1ac0ac 100644
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

