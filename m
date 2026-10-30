Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357107;
	b=0gvJ0w8ATPbQlZ7ewFVUWkO+emQOczl8CZRClyRdvELjYMK6vzU02Lokl3FDbsQZFtVx
	 ODXVbqjoyeKMzJSblqFVveeFWXqHHmNIjlkXibwQHC6gjGFsUw1+/Y24TNk8V/pjfd2Lk
	 TgkQcbChgFHEXqGlxAfuz96PXklXf6/JaB+sErBGqCT2A3+tJ7vOGDGcHLaMPN2sIgtSL
	 KVb7rK++L0WpEXPAgbpcwDCtvJrMrjR/FfIw6wguaHBR3OEJ9uCo8rjztU5NzP7xN0y3Q
	 SZ+GoymNaJG+2iLFpLTlZsM11cI9wLZLsfzjHJm8CYle2jRh1dldkGIDAbXWH15QuZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357107;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=G357Gtw0ebtUq9WfJoJPOz2L/IzVfBlLxJhIP3E7aAo=;
	b=cwWvUGJZ9bQ0vf/A0zEWp1jADdv0W4X3SvL7zGu+abxOgwuSjiXw5aH076h4Bze9GAvt
	 qaACdcvYiL0SVRJbIj6WQ9rlufC5tb26Z5LOMP4+bBUsrpOgeqAL+k+NjF4F3gTjfyTsH
	 qf73cMW2nFVTx/eMsmOwl/5gwSKej8OcRj4adMwL72LwxaHoaJ+Ax7rFSC+tD38nU/YRZ
	 5ISfi4ckGNQV2s2NJjr0ZAd7lW0TRCX4iHC4rifzIqqeK6CoX3cuAZKPkiHmPHMqupSws
	 DrCmFS3PIsG2baXDbO9nouM0FfYhQdViyYe3OrHJWv48pp6EXCZOq5S3GPdKQkaaDsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6VbjGA1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C10606A320;
	Fri, 30 Oct 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6VbjGA1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357106;
	b=FuOJPihZ3BdkYBiDuPoxsgCUid4APrfQT2JlTPzE4AIhPWIy0s33bRbxidbEZoZm8N1r
	 U2V522UA8nKJ6XHey9+LtrSRCGkPzt2MtmGySyQBZsG9DYrAbc0IGJvZsHD1nBCzWOx0l
	 t4jaLF/PAQU1+dTNCFZSGz1GR9dMEyeagShVlH7uXbPrteUXI8myBPy3LK9LMLBeuUPGx
	 vqyDZphDZWfjQeAe3nPMobsRwlIeotR4b9mzS6s8VVz8RpRz2pyLNT+5+I11SWtzCQlYe
	 pM48cxZ9Ogj+OuArpD1sz7L74ElLSzOdYeQxGEr5JN9+LwQUaMQgTHK+YktvxnHfpdQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357106;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=G357Gtw0ebtUq9WfJoJPOz2L/IzVfBlLxJhIP3E7aAo=;
	b=hIDCC7cp2qSkhO7e9rek7TFPKOClt7kjVTpUfCGm/7OHLG+z+vQuKk6iDSLFyASdQjt6
	 VlThEVBCNwyVW5pjQrLUj2yfyRUZjYSItpAsxTJ+K+l/IPKaiycohkBfWEIAbyE6ul3u4
	 vB5dtpzuH9TJ/y12UOaqy/NUOV1JjZWKH08OEPlJE9M0zvjfwErzEhDKn4Co/r3eIOCXY
	 Um+YmCGY5dGzQOSFw48emIbMGO+hGar2icEJZhPU0EURW7ccJjKMTLZFyA/rjvkd/cMyH
	 eY2CwWCox2hSBl5q9pq3JOUp7weOVxbcsjFxOE7rE3quRoTB+xPS6RsvofWbkC/uc2g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ED9731F00A16;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357106;
	bh=G357Gtw0ebtUq9WfJoJPOz2L/IzVfBlLxJhIP3E7aAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=F6VbjGA1wv7tIed0hZhXnCWzxwEI+eoIc/9em6VbLBOTiHwPG15eEiuNiO2XtBl3x
	 4FpnIWtHpt0IRKrIF41ff9PXZv2ee+rEH27hh0TLOPIWOEIBsa1mhII8Jy71YFv9ZJ
	 xe74k3JFqZVtiAWHl7nK0wupUiZO9AYsm75emf+L8Dz1TFCc2J9Qdb3XfnxXu5Qokg
	 v0Ca1RB+TNnvQvy2fS+EyEIaQLO2pxKpOC8t222n1k2ihIQjwdjDjdmRpp5XdZ0oha
	 MobBoULlX/aufqBmCinp3dXk7+igGe8rB18TYkY4uGWrZVNEmggRwSZTl8ppaw+8j4
	 KcJPFtEtcNe+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7AA8943742;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:44:53 +0100
Subject: [PATCH v7 04/13] can: peak_usb: harden PCAN-USB message validation
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
Message-Id: <20261030-canfd_check_channel_idx-v7-4-fc4a3faf3acf@peak-system.fr>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
In-Reply-To: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=2405;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=C+l/UDiMGawjbpRVl7WiHHPEOB6Es54TdESClPO3hd0=;
 b=rOE8xowTC01XkyYRc4gAkCiixDafQbUQBf/hlAqJorshSobJ8zFoQFD9GF2doDWG5wQuUVer8
 nMR7exagzahAs4nrhwojJEmqsxpC5z+KEuLx8tmkwFHDPTz8VO4d93/
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
index afe5e68d5ea3..b515acd36466 100644
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


