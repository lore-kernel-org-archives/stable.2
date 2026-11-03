Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709026;
	b=uo1rz5yATB0PMz7bAK2OmMIpVCKNWIk74WAzH9xNTXe1axcTVnyq0TuaMkyrdXBlRUT/
	 860ieOZft6kGH1Z8IvCG98h0CwFW1B8/CdEc0dXCsRt21NvyI9eu/4l9bFAxI8fcsxc7X
	 5wIXlh8Sa0pL40fWdbJDPhaYjS1ZDagMm+HGOl4Ydyr5qKqb+mfOMGINet8jcyM4lIAcf
	 Sa9awBECdUhJXXsK8D/vtANxbPv1Y6zJsMXnxIgxLtMktudDdSy7z7DU3LlmJmZmfjGde
	 cwI5dAoPnpKODv6usgrEbnoQecpekfmXvYZdgkTBagxvdhIanncUYDUo0nylYU51n1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709026;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JY6p82Euc2Wh5gjzBsclmn88zO2bmUfG5Wr6Ptzhv4c=;
	b=qywufTjJPpdEyo7gM3jJOGhiuPtnXRGOp3MNmoA/3ikxWN+3Li5j9ZJg4+vP2iKEwXKd
	 o+N+xjdb9WkOA0FZMeCXMAbRXbmN1B9uSA068kwV7VXNYITG/lr4tRsNv3rwLLo8FMGUo
	 jU62kcA5D5iLrrQB7fE/VOEefLG0W1RBJ/zFAFq/GR4qYBpmzJnSyVuHtfPVw8yGy5Bnl
	 x6plmJWiAzomXhatt1LuydyMXR3L3L8/MucvvsuY+KAf/X7946hZQ0OmAqtg9rklQZFLg
	 MSqKyplOrQFp9Fhg1fc0/OcpTl9TqWsLGHFZLAA0yBK3AU2ccIMJ0yOKZlu1uhYwIBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L89br7nU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E64606A32C;
	Tue,  3 Nov 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L89br7nU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709026;
	b=JwO9/eVf1tCOuDoZZG1iZ5xIgvfXyP8vIjM6PhlbDVuGYLI8vt1Fxy2LMvDqLYQ3ghyu
	 emqIECtVx3cm8NTWfYe/fXk5ekIAXVwkyHN172r/7/Q5a3BtA+DY4d3mvL2P4eqBnFKCk
	 kv9BuKx4qoy4qDTYFmGWLSkuk7AUmLOhniOgWER1dIJ20IyneFXjyuWRLw5PL2mgzM7Oq
	 gTMjUoJEjYTszRDRmpxlT8CmwSfuxNKGy2rjOhD0R6xh4wuzEbqsGFeqsjDqUiegUGkQa
	 Jx9VBvcjZWheG8oLtEZh9apxKISiIr1ljer6vg9QX3j9SSnEJFYg4bMnBZJEtrTvZ0g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709026;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JY6p82Euc2Wh5gjzBsclmn88zO2bmUfG5Wr6Ptzhv4c=;
	b=i/dTY1BGxuGvuBMrSHN0bTuX8mZ8dYL5L1JnaCPWiQO2VeppNyRbWzUo5CCrixPvJQjX
	 mfBI3ZA0fyRCkPTdg68zXECL6ek7vFaXDUKVzp5Niwbm+Mylk0mg8FEGnwk7BkaNv0QI4
	 I+kt1ZvziKHxalbKh5qAsTza8jh4yXvhaoVE8VcnVweny7Ww7vGUjggDopGK18aumFBNh
	 nQdpo2zKg4mQwQzREdbVZoQ1Rl2V9Xu5aIVL+96liy+JfILTy+Md9PecUYSgAr9Z27I1q
	 dKc6n4A/c+ZmfHMqZdmIzr/CoSgI7wUHgfsn9kgR8rJLW7SBKFGDEkfHJ5UzTWPweuw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C13B11F000C1;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709026;
	bh=JY6p82Euc2Wh5gjzBsclmn88zO2bmUfG5Wr6Ptzhv4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=L89br7nUWwG7/NADSDjV12+qP1rwfb/2LYH0ZpqIWSr7ksCJ3JJqRaybRPqF6I3dR
	 HtCBwhF9ZJLV/miLELfGSOqjPU32CFic8Y7Bqwrw8G7InwIudScOqYpSftYkcYQmQe
	 DgdqOMr092Gm4Oedo+wXxRPh5diqBwb6dsFbJesAjYXIC49HuYyNi6asOVAH0rTQmA
	 hTsnvwzehDh3PVcC/VcE7KoVB783DKBmMlv3C5/hihLQXAvRXxKe70px3fxTxS014e
	 J+C2oboWgZCMvtKCxT2bHRvSH8yAyb9R44FSo4jq0bUitFj8K7EdI/NgJ3ueAeB6eU
	 /xqpZaGB5VnmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3907A46928;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:18 +0100
Subject: [PATCH v8 02/14] can: peak_usb: harden PCAN-USB message validation
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
Message-Id: <20261103-canfd_check_channel_idx-v8-2-4e8b2c0a8806@peak-system.fr>
References: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
In-Reply-To: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709024; l=2405;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=nJ7r4maIQTeLSa3pRZIZ0YyDiADbSzZnNaU9saNBCGE=;
 b=NEQGkPrK8GoR/I2wu4DDKUhjpMxoK0IKsrE7dAH3LWNUseF/CecSyHtagnuJVV5qbzGcI9dOk
 kMEltaCGM3KDkKuYA2NIijnQgqZHCbxDbVzTSHlUEfZB1k4HCsabENb
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


