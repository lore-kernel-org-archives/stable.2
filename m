Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792953403;
	b=pDATXA0nlhDFL78eePHpxcH6FaSDp/UMJirpkdLF3CI0IeL+3MKq9kC1JylfRWTKigGj
	 jY2eicKApBXp/dytoj7tct5KgHlTju6wmSX/R7y+Oy1QgMOVJv1nk0KGthOliTuPUfWLf
	 OaDnnZPnhEE755xk1kpQhmEtBdHtXHbhhKzlH/ryiCuaLrJlj7w9LcRFO9yjKNyWDVz2/
	 llztFRQjzm1f6RM/oXBHvB8QwUxJP6UucTlOJLFsdk0G5jiHc+79VF8x/PvtOwooDAxdY
	 Dk6QMpqvuB1BfTFZrk53awAapFrNTKls8sL3VjPXypItI2Ciy1xYzHrWDP/s+cWTOHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953403;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=RLQRrll391iC4YjsasOe+MzeYtAfjP3KdR82WCUfiF6G1kgEA5e3JpyxsDIOkYWMZYVQ
	 WNWkjm0999jnsD/0x3cTv5GZrt82nGBhPnEj7br/8+yNktSzwSorD0hPaSqJ66cmjzgqQ
	 j9/GrWSaPq4ReBU3tUmOY14LlskqYBmthcyYIAD4CbdPB2y98TWtMalvl//cFTm0u7j1l
	 P8iKZHXhU9QjcCNB2DfLp3Pj99K6/RRum/FaTkhD9N2kaQCC22dkX0lO2ctmdt43Fp6hd
	 AcKwBoBM6yu84pi7cWdi0FRTVbsG9ckaZ4WdZ0s6Chuj/KUO1H++zwZXoD5yEyeX8Yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QjU6oJfE;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23A606A31F;
	Sun, 25 Oct 2026 18:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F23A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QjU6oJfE
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 299D3200582;
	Sun, 25 Oct 2026 19:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792953398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=QjU6oJfENzSWzm3JPTDVKdQdy6amNuACAmb1kAjPRtpTq/uaeqgGORvDbSUBmC/DP+mFYF
	tpByQmQzR3StDMl0lkol5VTE8yX8oyoEt1nZT9ZLBBMx3kHT7ef7qXFzeKnPVelaFhi8Wg
	cdV5voE1tl8Ec3ZvLh0iGlOWOSdbiQIcHJg8mJ2Ye8Qjx9+dW4Dzn7+quPXym/UyytsCW9
	lBsWShwsTTPxeONu/LguB7HNe2S5OvQAPokvNp2lWQT32y8rKhU7qO86GA1GMaKMKScXvj
	GPcYgha4RVrAEbSS3fP4v6yn2W2wSvvseQEDga4gVe8HAZv3e0nz0sgGGhm14w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792953398; a=rsa-sha256;
	cv=none;
	b=BZ8bubfMgv0dXDC1mC5qw0nJc9HFlppcT26sNbNVeF0mW0ehQwhMg0hZ/CW6hpF4C0YHDJ
	5279UKbp+g6yWgYDHq5fmwRK3WAtrwftudkbdhsAq2lReRPJ3SM/PAJ1lEaePlmDCrjM6t
	YkUKX47C/C4JNTxzCBNt4Zc6yJEMzG4z6kkag6N7XhUgd/jm4BVHqs/dcqJ46JImGgpD7k
	1j60ECDCLAjclvmEAvkP085VRehN9+98pys6lZl1DUUjh7ngPsEG10KpDYzFGTjp3AcHKS
	+JGnD2Y66UfA9JssHKcLF4VmMWfeeJncb7DuTjPSJBZ1ovP72akOlz2OTNy9vw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792953398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=RMTq3/N1YYM0Dj6w2zdFz7M8/ViqT7Bl64t40St3A/s6QCHwfR+CE+pKpOP57iSLu9tmG4
	Cdq1TczbpJyjQk3hxqAREb5vVbBzCfOh8O7yi7qmDRB8acwO4kdFihq8If8JrpuaoGAT7f
	UMljjpr7tWGkEsmZRexQa3G3kuBHik0sP0fNEvcukKdVv+pLadHTnf9iRO9wB9vooirBq5
	XZY3+OwnK1x1C1+O0He2LX2M1EyeNLYJ0pcK8pvzORUIdQt+FM0p55MUmsssJ3UU/Du4ZS
	vFN79Q3JmwdNdX9YGhYcUUtqawVgTVAM1CWipIR034gkKQMdV+xZTrYR2NB/fQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL35C-001AZb-09;
	Sun, 25 Oct 2026 19:36:38 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 707275D4138;
	Sun, 25 Oct 2026 18:35:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 25 Oct 2026 19:35:31 +0100
Subject: [PATCH 1/4] can: gs_usb: gs_can_start_xmit(): don't leak
 uninitialized memory over USB
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
Message-Id: <20261025-gs_usb-fixes-v1-1-f74ebbd4da36@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=xMzMzZuOb1bhvyVgFQl8vx69LoqShxppSYb1Nul7mjw=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi65/3//QH+NLXtSe4tM3NvTDzfpTnvVQvT7vkve+Xj/
 0bHBL7j7ChlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEXH4xMrTP2cF3o+5TETvT
 wqR9aft8d8bc47X4IFiSd/xw8pzbZ5cxMjxLc10j+3nejYPdh69/Cv8WqTpZ4IGvzE22ZJ+Tbwy
 W93MBAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The driver allocates the transmission buffer using kmalloc(), which means
the memory remains uninitialized. Then various headers are filled and, but
only the actual CAN frame data payload (of length cfd->len or cf->len) is
copied into the buffer, leaving the remaining buffer uninitialized.

Fix this information leak, allocate the buffer with kzalloc().

Closes: https://sashiko.dev/#/bug/linux-0a8c0e8a-c623-426a-8db3-f55111f6cd84
Fixes: 26949ac935e3 ("can: gs_usb: add CAN-FD support")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..15f28833f2de 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -861,7 +861,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	if (!urb)
 		goto nomem_urb;
 
-	hf = kmalloc(dev->hf_size_tx, GFP_ATOMIC);
+	hf = kzalloc(dev->hf_size_tx, GFP_ATOMIC);
 	if (!hf)
 		goto nomem_hf;
 

-- 
2.53.0

