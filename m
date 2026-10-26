Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793040325;
	b=2KCAzVk1VC7hG6Gr3DQWxarVCOOgIdmKFQJl0LSzHdo1cGaAv6Ut7Q1kKy9hCABUu8VU
	 vlh53VXcF1VFWcRpjmfKCSffpR1vqCyCqE9JmU7T8zFjdMxRc5l/cpgYSBoOM2rg/yTmJ
	 6uHYIy25dLpyBzfxvPArjHnvM5P5gVCYvbs7xxeGepY/RxQSHO17DDoWTMcYupytzNbkR
	 Yv48gZAeTqxweKnTefFpq0LdBVzjq6PED7/dmb+kwPsQywEmT2MOcK13Y3tMUyq2uasbE
	 qGNikZQV9A6zBoDag/11IXHf+iKdLdGy6eOc3NcfCUxzcON31tSA98G6T7AsIttxRXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=cUU/JeqLxpTuiQNUfoIO9Obem53+WMrheH+GwE9rCcg=;
	b=H7d1XPzyDDgkoLyD6VYpyeBle6qy9AZ0vIZkpcP5/wglrxod5ktS12Itx6llO6dzvpOf
	 Fh8EY80PYCeg42ETVx+FsML5ev7eZblvw+SowPi+D+WpZ+dgphYJCG4pqH3HzI6A/mW1V
	 yrs7UD++K6DeUKak6E7pq/jrvC9QoVcekF3GIuWGfFHvG65PdLBSGHSwOND7TKrvgQXvG
	 q+dG/AoB/swSSXOPneUK1CGntRdHp6U/PH3/Jgm5W6tbypcAUL5uUvxBVaqVeP12ytRUV
	 2PGsGv0rDrs6YgQbCKygo2/kFjfZHUFzfqUH1LhNxGRbStTFbD9pBYKFjdIlr8fMHow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="fCwQGb/A";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BEE606A320;
	Mon, 26 Oct 2026 18:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BEE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fCwQGb/A
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 762C4202921;
	Mon, 26 Oct 2026 19:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793040318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUU/JeqLxpTuiQNUfoIO9Obem53+WMrheH+GwE9rCcg=;
	b=fCwQGb/AT3vxMDnJoo96P7pSNh2UAMKsjvsswRoPst+HCy8GxZcFq4m5IP7rOnvW1RiOn3
	KgIyGa4n2ypeMR9oTts5zY2/Nd8KzQBR8hRHRGsLLI+xk5nW1j6SDDsZF2gCi9URsw4ECr
	pwSTLQFt6aqIGLeCq1P4jqVA0Vobl6wTUcUStWd4psmZ+7LrMdZfG7Q6uu6erXpSWE7qkI
	eel/eeRSknhw7DUy/fvbCsMW1DYYDTJV+od/nOfDUzM8SahpJp6BClzxRMqKu9g4dDlGyd
	4wMJoddtpPJk5FZ7YpANNeg467vsKtaIMum+hRd4r36BSY3tm5/HKkUjnusTXw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793040318; a=rsa-sha256;
	cv=none;
	b=NAHvlD3zJdJYi9744fcfFeK5NSC0eOB9b9ccWu7TEOlbKMGj1zEfIwV/0UZsdriwsI8593
	+4dvgq7AneqA7v6ZXcCQRJaYN8ftMd23gwOcrMpHRUIGQixCD+xA/xnR8boQym4r8SD8P7
	20RTNAekcMKgf5jsVZL+Y48j4C3frLn1cG1LNx42uCgF2FWrHNYZopDV/YyJ+tEQwzbtjd
	tsr3s+mDPMGudOjbUV8oESaTArIPtIWbJGhd22zIQ8rvE8TWUVxgcuxZSurmFgUSMM0Sk0
	KcU3YE7OzAn1E007Wfz9nnZGSCS4jfJHrbvL9qYAXEEQAfbL/x7kTM3A4IYsLg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793040318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUU/JeqLxpTuiQNUfoIO9Obem53+WMrheH+GwE9rCcg=;
	b=TTY4GJbqtwN9Ap0flkoIkBqJuG4thxqsUvR2Ybb6V9dCuuuGTts5AwoFXQpiNadvs69l/w
	LsoV+joCswx/GEzULR39sTti/ZK573/3RXxe9CAAOLQMgq4v3hWpcxXJ10MlR/kQJEd0tM
	lqLwHj3q8SqeX9GIGjXhtPI0Qai63HIYQDgdkwvbmvr3LbzBbWeDbxEn81jmW/7UBwxdMp
	220b2ohqr/YaDVYUNJD+C2+5cS5aRaB/OLBffHmK9c+249Q0cgn3Euwg1ivIyN3z2/5lju
	wUjXtx1qq9CWQLSWtIhaqZTn+DKXKSpftp7Ke9LjuQWnOeWZSpo+ouaX9kskkw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLPh8-001JyY-1B;
	Mon, 26 Oct 2026 19:45:18 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E3DE45D7289;
	Mon, 26 Oct 2026 18:45:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 26 Oct 2026 19:45:09 +0100
Subject: [PATCH v4 4/4] can: gs_usb: gs_usb_receive_bulk_callback(): add
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
Message-Id: <20261026-gs_usb-fixes-v4-4-59e3b6360053@pengutronix.de>
References: <20261026-gs_usb-fixes-v4-0-59e3b6360053@pengutronix.de>
In-Reply-To: <20261026-gs_usb-fixes-v4-0-59e3b6360053@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=wk2RaE8sUauh5r/ie2OTcsPPolpU93QwrgcPP4pRVW8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6P3937H0Wnv9/Hab2Jv4N3soqq7zFKfHW/ZfLb57wE
 TUQfFZi1FHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJlLQwMhwq2PaGL/2QF4+j
 3WGv1mffdjj0xu4vvbch69D7oqeulvwM/1RXrmDqvDKtxjw09s+W5pk7GndO0r3y0smWLeB03/K
 KLiYA
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
index 3afddc46afa9..7095ec818ca9 100644
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

