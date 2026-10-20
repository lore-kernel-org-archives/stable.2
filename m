Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503055;
	b=bBvdx6eDmCEzsG7CoPKGE2qheohnT4bPAwdH7nkoUir4XTgnrg7kCyewv4Dvj0HooNeI
	 cSBpHu9HqHU+lpSwB3FSX5IoV27otWMCbRl5qjgOmbnIGj3QZ7/Dq1zopq9Ff2LDqM80L
	 CCLJrZJ0ygFVPvFZ2kfJca2+DTJAyVS6R6yE7g7F5S7cdXuayCIu/bqvcfIkHsZeFv6Gr
	 HOL+eMUMeMTf7RfJrwCGthiqeGlKmwRuEa4ydI2Nho47cG5NOYanvysk7wPHmeXBKz5LL
	 fMuXmItPteXdQ4ZgYlMWnv5zTP6KihZ/KvlZA1Y1ChXJ6wrpskYDpepBR1mS+ncx1Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503055;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xxbuQ7YnwKJRiO0qCRVlDpGTsW4CQx/KBY872s2d53w=;
	b=3OBUp37u51FK675Ldk5PJIbHbs1PMzKlGmwKuWmqZKmC7Lpr/EIugtMbKqhjWK+QR7fT
	 9DaIlNJlmSUyu5B46+IXeztP28O91GaI2TUTIT9mivMl3JrEUGcRgT7cK6gmrkqxGJe1c
	 ndBXKH8ZTALVI3dFBF9horvBXXK66OpxeGOaY8YfxVjkoZRuG1lflM3sUAwdL9Fkd4OOa
	 75UdII/wD40uf77ReOr1wOv61u2ft2X8SZ8t1TcIIu9tzdOtT3l7sE6b/qucCKgmffUW0
	 r5UvA7vkuwE2LwYn+WxGp8wOxdOiMz87TbODxN7COGJzzbwe5N1kDXhel6NZcEn2jDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjDEqrCM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9260A2601;
	Tue, 20 Oct 2026 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjDEqrCM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503054;
	b=ydsAShz6tbdbDPzIpll4c8ZVPBtEJiiRDNR2wID/Ku7vr/qifpjNLdEemQN35LInvDfL
	 6tgEkfKWZ+d6gA0FiBX+qgOHiJpPZLZ3+xZAIIre3WH8c/BRGSfyXdX3IOvpp/xT9wTqE
	 9uQkAZy6gU27J3iJnTW/B9K3MB79/YR+eFJ+uRxFa5lEoWYFIDPcANf89ahfyPQ6qoQIo
	 Nji/tUcrHfZmn4r6F21dFFBmTXbX7HEKCBZg16jEIXx3UGCmGKF+mntU4Iyf7vTSdj478
	 CdNcnoOJAxno83rSfjBM1fhxgFd/DX0gnvBkfvnt8qZWCm/tfyKUyMyBMNiZyxZV8Gg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503054;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xxbuQ7YnwKJRiO0qCRVlDpGTsW4CQx/KBY872s2d53w=;
	b=EYfICaDEhBARE4L35N0kk8dQAJUlr5Z4486m42SMzCd2CKlTn2oVe34/Fygesyj9Y7rF
	 GUS/SPRSYvboB2D4nWSYb/PCwKqiqwjhXDXvNHF0rFYyx8Zmz2ZD3jSnUx0y3N+MU8pzW
	 FBapC1IJipP0+DQO2peoOm2KbjgvjKmgF3hDwk0XdwYDQushcrYh6IB1IIZJa3Pty2rvs
	 aiOsTSKvSy/MdJ1XwqmCGAg/S4VpqXNNSkRIfiiqdcwpiZjG7xPr690NgbAx0lVKSovpo
	 +HGGYRL3/jMLYawaTljSIZbk7L6hFfKnMcp3Pg7kUCRdHMOg3vuyW0giXlR4BKM1QKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B09011F000CA;
	Tue, 20 Oct 2026 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503054;
	bh=xxbuQ7YnwKJRiO0qCRVlDpGTsW4CQx/KBY872s2d53w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jjDEqrCMxN1QvlvI60KTq/kuhnyQp6mQCeR9XKkgoYuVqCaV1igZUKEvGosPjcRP+
	 5k8XmDfRsWImnm8XTGOjlGF4CjWSYW56GvpOxex6GLU/HTRzLiYF1l+CZLe/7Yfxtr
	 HnA2exhG1JN/cyj5ubjU8Z3yo6FOOTa0+tioozerYF89Ke3Ac1Clcald728MJkktrJ
	 MRaTntomlgYmu7cEM0quHrK6GS75WOvmYbINuMbTVEia0KGYI1egUJk2xzasB9F3Y9
	 OnGYvXrcBYPkVPTxocY1Pq5lxuphNmTpXv/GPfLNvRUwMSuF8Qb0UHaZRRsAN2dtPV
	 F/+Zm+mXuynAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B0CAA43194;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 20 Oct 2026 15:30:46 +0200
Subject: [PATCH v5 07/10] can: peak_usb: fix RX cursor desync for
 self-received RTR frames with SRR
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
Message-Id: <20261020-canfd_check_channel_idx-v5-7-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=2124;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=0jWkvtrawf4H585XSLeRYSXK05iFHqh2BhPJhVjt6PM=;
 b=xBlbyTajQAIdvC40AHLoGzqyoPN60Bpc+g36SmXAS+GGLJKT547i6ujI7AGxH6OP/+syiOibO
 8PqzJzv9pv9BhkU/Bipf7xsRZp+oWYi0rtYKbDYcBAxPZs3iXYjSMJt
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

pcan_usb_encode_msg() appends a one-byte "writer id" whenever
PCAN_USB_TX_SRR is set in can_id_flags, for both RTR and non-RTR
frames: the data block and the SRR writer id byte are two independent,
unconditional steps.

pcan_usb_decode_data() only consumed that extra byte in the non-RTR
branch, inside the same conditional block that reads the CAN data
payload. A self-received RTR frame with the SRR bit set (e.g. a
loopback echo with CAN_CTRLMODE_LOOPBACK) therefore left the RX cursor
one byte short, causing the private id byte to be misparsed as the
next record's status/len byte and the rest of the URB to be misparsed
or rejected.

Move the private id byte skip out of the RTR/non-RTR branch so it is
applied whenever SRR is set, matching the encoder's layout.

Fixes: 3a7939495ce8 ("can: peak_usb: PCAN-USB: add support of loopback and one-shot mode")
Cc: stable@vger.kernel.org
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 93da0fd4f10e..4c8cfed31634 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -697,16 +697,19 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 		memcpy(cf->data, mc->ptr, cf->len);
 		mc->ptr += rec_len;
 
-		/* Ignore next byte (client private id) if SRR bit is set */
-		if (can_id_flags & PCAN_USB_TX_SRR) {
-			if ((mc->ptr + 1) > mc->end)
-				goto decode_failed;
-			mc->ptr++;
-		}
-
 		/* update statistics */
 		mc->netdev->stats.rx_bytes += cf->len;
 	}
+
+	/* Ignore next byte (client private id) if SRR bit is set.
+	 * Note: this test must be done even when the frame is an RTR frame.
+	 */
+	if (can_id_flags & PCAN_USB_TX_SRR) {
+		if ((mc->ptr + 1) > mc->end)
+			goto decode_failed;
+		mc->ptr++;
+	}
+
 	mc->netdev->stats.rx_packets++;
 
 	/* convert timestamp into kernel time */

-- 
2.53.0


