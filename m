Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683689;
	b=yOt4VXJD9hqRqg05l9t29/dv0PkBi0E91RNHQfVqCIRZBFBFKwoXYCM75cpkxpxE426I
	 e+j07h3mTd1yy9DVwZoSozmVRQMkbwewcZOeA7yb162ZFWLAeFwaxGdTOPscgG4tnv6tK
	 ZSQz0BJ1Vx2Cmm6+yQS4mrGyum5e23ehhh7eROmVXhY67tErVYvnsKfdOixfqqdih2rF2
	 nUj33jXf7mSssazrx9R4sqzHU0vzwu/ampaUpyJHqKWt5BiO5MhGiM5h6aY8ZEkb9Okxk
	 fIM3uSlBFdirxcOcxHFCo/4S8fejG27X4Lgjd+I0UjUxhe1Pou0fsWeFAsdK7nKfyVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683689;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JY6p82Euc2Wh5gjzBsclmn88zO2bmUfG5Wr6Ptzhv4c=;
	b=QJokb0ljXLi+iAczNn6yS9uCEFb8tDq0LJJH23eqroN4Jyr8lMivMUB2prx03IRBgakb
	 Y0FtDNJjYkR4HXuWDO8K41CU6ohOBrbmzki6FPepcST+fJ4l6fxUmdILiehqCTWiMFbwn
	 Cl4HiWGpIcShrmEpNKn8NrNI+9YY4zvgpryVQmI6PfJWI6+9xvDUEsZN5DZhN0qLNML6V
	 GG4UIPZKFKM3DNHlVplFikgDu0HT2H/nFuixeiYXbYgL8pDy5UmMDX+XCTHmQuGY1tLOA
	 Lm5fQ4S3c4v+tKt6XFsyZ/Tc1CKkIlwyXrGW7C/p4wteSPzu7q7XPBKtTOceWoNEL8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eA4ONhlT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3221F606A31E;
	Thu, 26 Nov 2026 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eA4ONhlT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683688;
	b=zmzMet2QA17YE+yWVKzrgLYQ+cDpDlxAzVr1BMiN8MVyPufZuBfOjl1D5+9XC25ZAiYM
	 c8KbbvIz2ugXWdK6tLw8Xypl54XIMojsN5fg8YM/yqOup1t2+BiLG5BWwukEr47CH6ZyP
	 QPc6oOPp9UnS1EdAdtr1heHa5SDa8YvjQVGU9NYSkD0bPZV+7Lj445/p6AqWiinqZBvzG
	 XqaBWrWlnTMCbIsiylPgvMtJh72rs7xWEmVFro4K8zXiaHR+2qB/pSQ2ES3YBm/MiORIF
	 2r0UbzQS4SrMS25g7CKkJuKMB2sZMX6CcuwMFcVKqUAxE52IAwV9jW2icPD/E2DzW3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683688;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JY6p82Euc2Wh5gjzBsclmn88zO2bmUfG5Wr6Ptzhv4c=;
	b=fRVOEuhuL+HIGm0nJk1H9Mi/G9CkhT1S8KtPyI7pPHYwGirw7SGurbuS8UtfXy6W8Lic
	 CaM8Ley8nFvQOuP6MHY+QDMznpysoK3wvzkqIzSQQxv6Askb4tdoIV8Ah6uaILOTA+p4T
	 kLepVz0w9Z3/t3PYw2Cg9h8q5Bn3zh3nKg7A7pAHEa6MT+oqFb28L+EsIu8+OfW73qZwF
	 jzlMwYxXC6VS3V4HqnezZ+hR9emLRqU+gmk46vz+PpGSbwfblQKtjkuPqO4+dqpDcavH9
	 w3bXEKoHZqoR9JWRfv7mfovXBI3Zdz57x49ECn+QdK2RwobpREYvrOaI8pHovKT6hoA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 708271F000C6;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683688;
	bh=JY6p82Euc2Wh5gjzBsclmn88zO2bmUfG5Wr6Ptzhv4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eA4ONhlTf4L/io0fxoksjs1TUOgt/2CC9d8Xd+L3MO9kQzDkq0UCpaR+eCIw7YFXg
	 NoEao2UkVcRwUDMXU4U4NykbLha5XKQAhdBpXJyZ4+b9tM5AwSMSlnL8s78q4xlh+6
	 lrV1bhZzbhM1iKEL7lJ9F6I+6eCXE9wk4fvrn9BRboorbo9j9FSHv88KndFgQ9BZGL
	 JfIJOpcgFb/Escy1HTSie4oZoBmNKZ4LDyEL/ATHidaqUbUltmUD1FnqbMcsqnRx8e
	 mex6iZqm7fz3Hu5hvnU6WN+sukxu0LRMq5xXn7zKwCG61PXarfogdauw16egI2bfhu
	 h+Fh51a7Od2Gw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 015914D316;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:03 +0100
Subject: [PATCH v9 02/14] can: peak_usb: harden PCAN-USB message validation
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
Message-Id: <20261126-canfd_check_channel_idx-v9-2-abe0099b4585@peak-system.fr>
References: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
In-Reply-To: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=2405;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=nJ7r4maIQTeLSa3pRZIZ0YyDiADbSzZnNaU9saNBCGE=;
 b=+29/II4CIFTsdQrDreWOrgG//Icer5V63pBkccWOuUvlQAhroe3zQbSY9Qnl8mSkvcmwyB4E8
 K2t5sLkwdoaDIR30PY9ZprQe0nr39BSlAGCaYPNdAJ8Hi8a5r4RJ3Kk
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Add boundary checks when parsing PCAN-USB messages and reject
malformed buffers whose contents would otherwise lead to accesses
outside the received USB data area.

This prevents potential out-of-bounds memory accesses caused by
corrupted or malicious device messages.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 785224e00c4e..f79b651ab4a7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -558,6 +558,8 @@ static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir)
 	switch (ir) {
 	case PCAN_USB_ERR_CNT_DEC:
 	case PCAN_USB_ERR_CNT_INC:
+		if ((mc->ptr + 3) > mc->end)
+			return -EINVAL;
 
 		/* save rx/tx error counters from in the device context */
 		pdev->bec.rxerr = mc->ptr[1];
@@ -696,8 +698,11 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 		mc->ptr += rec_len;
 
 		/* Ignore next byte (client private id) if SRR bit is set */
-		if (can_id_flags & PCAN_USB_TX_SRR)
+		if (can_id_flags & PCAN_USB_TX_SRR) {
+			if ((mc->ptr + 1) > mc->end)
+				goto decode_failed;
 			mc->ptr++;
+		}
 
 		/* update statistics */
 		mc->netdev->stats.rx_bytes += cf->len;
@@ -733,14 +738,19 @@ static int pcan_usb_decode_msg(struct peak_usb_device *dev, u8 *ibuf, u32 lbuf)
 	int err;
 
 	for (err = 0; mc.rec_idx < mc.rec_cnt && !err; mc.rec_idx++) {
-		u8 sl = *mc.ptr++;
-
-		/* handle status and error frames here */
-		if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
-			err = pcan_usb_decode_status(&mc, sl);
-		/* handle normal can frames here */
+		/* check if status_len byte can be read next */
+		if (mc.ptr >= mc.end) {
+			err = -EINVAL;
 		} else {
-			err = pcan_usb_decode_data(&mc, sl);
+			u8 sl = *mc.ptr++;
+
+			/* handle status and error frames here */
+			if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
+				err = pcan_usb_decode_status(&mc, sl);
+			/* handle normal can frames here */
+			} else {
+				err = pcan_usb_decode_data(&mc, sl);
+			}
 		}
 	}
 

-- 
2.53.0


