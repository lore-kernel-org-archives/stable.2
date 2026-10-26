Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793040325;
	b=e4KPXuvhX52N05j+gwvaUM/oxxHki3CQnvsE0NGxhErQrc4KcZsV0kEBc9yokRePPmbL
	 JYTA6gwUeTdrwEhuJ83CGg9r2PFIP/VhHtcihDnRRf5xhhH6gfKdbQXCUdHZdIZdsRp9W
	 xtfVy2E+UzgfcNg0GqZd86alVoxA3ybi+Fl+8+tWZlbIGYr6bw3jzhuX5Pn1Aac7ahBB5
	 z/fyUJPJO0O1IOke3/3K0DYJOnjaJ/wq9egDA6+PyRA/ej9Ge3kVi9ISqkSRuh7DTSBDn
	 uemXxCbWNPHvxUu8q1FlHT31ydSIl/z0Aoz8VhGNVkmkOhgvZTcmeT9TkFBHH/op/1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=i0lpfa1BF3aFM2GFKg5cF6dXjpLadytgJ5BR9cboSa1WoKxbbDQtCD9xuQ+wsPUq/KiX
	 gqI6vOJimiiWGFWFEjBno67o2DOKc5rPydwvwVzHU7PPLcbsWpOzKhQaVi1KdPoMgc67l
	 F2MktGJchrMDBfzbEjE5K58IAoI1zU3t6A4uG9v3zRqCaB4aIYQfo5y8dDHA5aqISbvBm
	 R2XfKvM4OjGt1xVUlLV5RYfX6jDqzbIHhzL8M/b9BKxLrcwwFlvCZFkNjLEw5hWcXsQIk
	 9zWlikGI6a5q2zkc2EmcEc2+dFaDF9DI+OXJiro8Rbc3jFAosYJCeyiI0DD1/TOY4Zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WTPjD1TN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9DF606A31F;
	Mon, 26 Oct 2026 18:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF9DF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WTPjD1TN
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 23605202859;
	Mon, 26 Oct 2026 19:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793040318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=WTPjD1TNqH+FExMqXGydvYzzr/8x8R3A1xBxCCNCvcPLUpTr+Ez0YxmA2ocViwXUm9Ddfl
	wxcNUX5yaFIkY5c3iwFV0to1/bWPCLxQO7vUuC9iJbGQGozItZXjRJu6ubsziUY7FudDgZ
	0WBL2AX1GUAoVa0FAZKWmN0XssBitsPDmDdJfJYt8YO/IKnbobH00kA0XqkpG3IK3ZUcKC
	zB4ajjQCZz2YuuIAKvJKDJ7oUcRFF0VWWx2KQU4STdGn5feQXEICenbDVLdGlRd2mLTdpa
	q68p9YweEEAou2Lq4fR6cEcPghXDiabG7SI4h6mO/Yt3JZDHVUsKc5pdBJtiyg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793040318; a=rsa-sha256;
	cv=none;
	b=dOg1CyUg90WsXv2OcpLmZS+RKLsf9NZS+cmTlR8CJXChLQ9tatdPAoTgq9aNPleD+mntRO
	Uk8i5uimeysSO5iUU8LTzQ/90fjt13NmXRmOIz1T/31ZXK3EZRMgDZtDejRFCFxoESsgq4
	8EqInMto5j4lXypLJX4YKFDCTzgKqrgX2f3i/2Ga2WOXiu6o626v/Pp53kMJQyAFFmEk4o
	IK0m1hUo7VNREeNhGZqcblG8jTgdDwZC0KmdtfSwq85UdbUL7Rf5XWMLSZyVfqyJhNFs0y
	zlWcsEyVoE5avm2g5riwiIM0I0T5VFjVzaj8dSYQdNxAnHSKMFyQSEa0qEBtOw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793040318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzqvCXUxAiBvbMROfVnJpVOaWr7Kd+9TvqdSl276L7w=;
	b=KOkkxFwt9iR1tP9bHLvy+9nYEALafuSTkJaO1sXJEycbgBnETSAbEXHSwlAlcSf8hr1oJo
	Rh70nW3lO5lwwOutdzdbBOCo3r12Y4Av2k8jiNM0YuCEDFnGlcoBzK1CBQ+ZxOqR3cuRKS
	J+tF0YjEOGIab1O4bVBU1iIgC3UV5aYX27UUuTVCgm5IR2Msw7ctYvo0iBEo4Fh0Y8Z3Io
	L55JD04GOmZne+xZLUTHzxrgcSM5FPUAuDrnQS7ver0cajT5kUQvDJgR7gUFXyLz2oHnOC
	148I2sOY6xCUbkNnc/AKWu4yhSo6ZXxxr3oeoVY7mUw+FI9l7+5STlfpsp2MHA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLPh8-001JyQ-05;
	Mon, 26 Oct 2026 19:45:18 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 892C85D7286;
	Mon, 26 Oct 2026 18:45:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 26 Oct 2026 19:45:06 +0100
Subject: [PATCH v4 1/4] can: gs_usb: gs_can_start_xmit(): don't leak
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
Message-Id: <20261026-gs_usb-fixes-v4-1-59e3b6360053@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=xMzMzZuOb1bhvyVgFQl8vx69LoqShxppSYb1Nul7mjw=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6P387YyprzMIs6U3qipuZZxQuvd53SYdn+WwGU/feu
 h2C93797ihlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBE+sQY/sfoqV9geH701Iq1
 +mfSdx41ctnTpxukMTnH068+24vteSMjw6sIrv8dp3RO9bRsdViXFnH145E9N3dKRL5Mdjh82TJ
 wOisA
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

