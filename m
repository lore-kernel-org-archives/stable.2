Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953406;
	b=nTZRBLzpyuJ1EoWODsMPFGUIjP97xeHHjL/uJYAn7/o9nZfP1eXez9aYKzE7b9vl+Vbl
	 9XdKazGGdpQNStQWUrDszUJ3dPy0zMf+BlUS8V9qhE6hmTZ+QPahQczKVpQAayXSHEdPy
	 1ZjAbDEdjl/vt1TQ0cwtVRgcE+E+/MUZbwWTEGaL34m2+cAUCSy2wdSUBFJ1cZ03B0e5n
	 IrRh4znRc+6BtACDSIPzF5E6Vz1KR85NiI7mgoyaFWowO4gbb5FapPTGeSsFWPVL6JvE1
	 GUjaPwH8MrDywRha6QXInk/NTp1Vd3EuI5wn46yoRC7CFJ2sBtR/LN0bRC7FgBKzrAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953406;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2ZCKJUkcPCKNP1mFV2hmd1YZNhy6cxlOHxjxjiaagQ4=;
	b=un9Q4yDcalwq5h9EThzlRtJIdPSlycNKbMwsV3eQpoJ0EUsGUNC8GE/kDkY6TTaCPHZD
	 vw529evUN52W5elHjyUTEdSwPVNqZkLX+xXeZNCvq7Ek5vjuStaHM+9Dd5VWc8ZJ58A/g
	 N3WMVm/aFvKCZLdt3Dzn1UBlLszyhIEM1K7PFOkM0gBwdXvoCl8qNKQAJ4A6sNQGUIY3j
	 +iS7tOE932YfJoRuQ6ofkOMn1iKLQs78HX8rB2/vuYX6/erWOJba8wpHI4csxaYULTM3y
	 W1/1ybEZGukptl7NrRgmrnW4pL69UQeXNNA9uIOvbimE3qUIEGUfSEL8z9JB7fKyGrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MVzaGrVs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD4606A32F;
	Tue, 17 Nov 2026 22:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3CD4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MVzaGrVs
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3DF28205A64;
	Tue, 17 Nov 2026 23:10:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZCKJUkcPCKNP1mFV2hmd1YZNhy6cxlOHxjxjiaagQ4=;
	b=MVzaGrVsfAKkqf41NEIARmpQO1yfjuKYo01v+6Vc/frBBnac1X2oIC8fbYtfxQdoT1qayJ
	Ca+glC7jenkTMBV+niCzRCjm2RVd9pJbGNe83HQkUCnsCZX4U9zGNlhRByfq4wDPPRWE8p
	l1g26zJ8c5YVPclAc3aeURb2BUDC854JnBIpbYQwSmMXV04dtMkkL64OcUP/P0BxpNkgFV
	X5rND+weuMqJJXwYhSKLBzjTPIUW67L2geCP5pW2Kr9FiWQisS9+tArdB009NtpDgJRJo8
	auB6UUCbjFD8D6ytqats9HMzgzalDNOVfSocwMySIKDPKlMEVYoiRpDaG15KUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZCKJUkcPCKNP1mFV2hmd1YZNhy6cxlOHxjxjiaagQ4=;
	b=Yq5sqT8Bx92Am7nL5BjxOYpzYMlSifGA3dBN81Hs4zp+ViRRoOk61ShKRWvpT42lOVE51p
	rYkqnGDv2+PAWtolK5i5zuXKvFjm/MWRI7IPFc6gWSRNi7VnYcF64B4EuSHxgiNhDjo4aB
	AsW/+6VrGZxppglZGOz0+9DC8hb59yjrB69GEkNjQpGe9toSZmpirG87/SO3N/dmpaY2qC
	0HLMtq7i3DAcwlI+5bkVATdDruSBagzrSIw7belvESjfgblhnDAn5oS8yfMSO1CpGAkatj
	bgq9q+//TMiJJMjwGXnGsHYLsBTUKpKGV61555GCi05z4dUnAdpLmfnw3e23Wg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794953400; a=rsa-sha256;
	cv=none;
	b=Sj1bb7ly7jArEAZfE4TvNaomf4j2QJxOQvWA6tbZ9hPpOJh6ssl9AJXUjSW1zLR1JeUNBs
	Y+HIBY725OIFR8EYQK/xubxaTqkUEtXGcexrhy6Rj2rnrgDDfTTd+QKoFbE/wQm+IPlU4O
	cGbXROka6OJTDQgQA8ufXMtmRmj/Hgq1Px6+0hniakXZDA1UBXdN2M7geevRm7G0DBr4EU
	JmKS1VSNhxhVYhSAbsAN5aBPnPFgIvp12HKSTwS9jys68VAlPJjR+aN94Z7w9IWXp9P7fI
	4qkyGLR59x/Vg0lptCp+4vv53uoKonooeX3q3drb4tgZQbuKH8x7q331NpB3MQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTRNH-000Fn2-20;
	Tue, 17 Nov 2026 23:10:00 +0100
Received: from blackshift.org (unknown [192.145.8.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CC0BC5EDA2E;
	Tue, 17 Nov 2026 22:09:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH net 11/11] can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
Date: Tue, 17 Nov 2026 23:03:16 +0100
Message-ID: <20261117220818.1142581-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117220818.1142581-1-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver allocates the transmission buffer using kmalloc(), which means
the memory remains uninitialized. Then various headers are filled and, but
only the actual CAN frame data payload (of length cfd->len or cf->len) is
copied into the buffer, leaving the remaining buffer uninitialized.

Fix this information leak, allocate the buffer with kzalloc().

Closes: https://sashiko.dev/#/bug/linux-0a8c0e8a-c623-426a-8db3-f55111f6cd84
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
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

