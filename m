Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510693;
	b=K/NqiNkrqtr5eig4YCK/+SfUWR8vVmSml4fpJTwACUa+BiQOtSnBOEoUV+dnxkPegGFe
	 L0z9wndScX562CpIOEzd4HXKe8hiyhtPkLmUkjNZFSG+2PD8hC7G61bdeNwz1PoZYox02
	 3MWb7ZGApyv8chWQlN23WVRliOtuY7kj+00axzoJn+7MZwrE6HrKf3m4dGe/Qv1QKWxS8
	 XSKd8PYIaJk/ueyJhP5i4Hy+nSLrz7qzkZ3ZDvED++omGJAgauKrVjS0LzPL8ykrdAmPV
	 xUxGoRd+DBKz1Z0Q4iu6+xp3nhF3V5muwe31P9+yJo97gP+p0lRXmUARKwqjW7y5v4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510693;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2ZCKJUkcPCKNP1mFV2hmd1YZNhy6cxlOHxjxjiaagQ4=;
	b=bT7ZRmS+X2G0bwhA/jzAYIJS/ASfJ7+VG9dNtV1TNWZ8cT0ufe0UE1N3KEdnFwUvayMx
	 RVHVbnG1S/Ww9tjod0xwsm1j4a/kiFT3MoHkn6GQC6HIPYtPQ2irhu6sRSNi0MfyU5Hrt
	 8IQSvF3tZ5HjWxoBZWWb9kF9ZQG2k2XKQoeD2/UCIhENsmeoKH4m/Mtj+4tQNEc+TUBY8
	 E3Phsg8k21GKhJTu9QvKvCj7gz6c54x6ygeEQ06OjgDzrTnjPs7hZYE8teSjqHZ/WU0M7
	 BY23dEk7SDlkB5ZGqch/7s4dr859uHVyiIHAUUkBgbpsi0zOqeQ4HKef1D3MzwWrnRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="P5/lM8AX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71944606A33C;
	Tue, 24 Nov 2026 08:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71944606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=P5/lM8AX
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BDC01205A2E;
	Tue, 24 Nov 2026 09:58:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZCKJUkcPCKNP1mFV2hmd1YZNhy6cxlOHxjxjiaagQ4=;
	b=P5/lM8AXmErJiHzaMxssXebEUOoE5qtfCqOKshycNjuHokQLJTgQylEmjEJAeHPHTzS06b
	X1BRpNMaL4xmnfnXNHYtUmL1MaBT9l3xs/QRAqqSdrlnmxyoUYbB+qXA46mqU8jhbk/YC7
	/aLA8XySYXmzU7OzTgvJsPgrXRIc0FIS/Dp2CLWt7rAKji4njLGdIa5simyXc0srOIP3A6
	MTNS0dwlwxQctgRLb3MSYfaSj2qPT2L4nSuXapv49jZjK93q/got6DaI+xkSnKJfx3DPax
	sX5UtTgtv2OACo6l315GSMfsCatcK91Ahk47Hg5O8Pfzbk16uoVNxe0zYqiSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZCKJUkcPCKNP1mFV2hmd1YZNhy6cxlOHxjxjiaagQ4=;
	b=DInkK4lB+kKss7GhncpLtdDNQWXvbHyrjbOdZu/SArIrf1rI7QcQMpxrslxwM0RNVOTIg2
	bwe8lCxi5WFJGysUzuNVci7GDRHaV8VzsBC3rBCskFCfbu/cRov/z/XQgoaaZCWA/UeoYZ
	9tCWopwcp7CvnTDZ06mz6brVOzvmm2sWcFTkLdXgHVVEkOb17ptNGeH9fdDGYSMYF4bv9j
	2YrleWEYSylBGs753bzxWEBEHy2N1PSOw4XdMjKcIQ2QMLQRncqa3LeeCpalsQzFSQNU+Y
	Z4D6cqYocTjUKzDYT6/A2iKl1d03VRG6idd7gilmP3D6VTGx+Wa+R68InSfdcw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510687; a=rsa-sha256;
	cv=none;
	b=JM7E3VrCbkNfEl8BQidfuOAtAO69k6iys7EV32Pa34siMRlViPc9X1un1kbPbAFYNDHleo
	OUdHrjTsAbrHMMBArI1UyRzibpC7K/nO9Q/yFr8pH4E92K20XeCva8bBzmnQg/JM24MOoJ
	/oK0fY/C8IV95/qXJc/oYCkvNCrCmHE18rqVHVR/IcXiwGyCGwR/qYJ8HOsmQ5xmpQZGr7
	t8HfmdqGeU+4qikiFX3iuJgeb0qmOV1RbbNL6RA8Xh67RCdmLYm2LvgsyZ5UCY/GYW6k7R
	16zQkL2mindSQqBtGH6S79JLVp7ApcdadQQPxqrX3dnzYNB0AqNi7parn6HeBQ==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH net 11/12] can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
Date: Tue, 24 Nov 2026 09:51:38 +0100
Message-ID: <20261124085757.1093632-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124085757.1093632-1-mkl@pengutronix.de>
References: <20261124085757.1093632-1-mkl@pengutronix.de>
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

