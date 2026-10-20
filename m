Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487402;
	b=NPkDSMjyDQKYpvrFWNonBKjNB5au8RhmtOSFfrU1IjnrQM29/xcHaFZp96M4kXIz+p3z
	 qcDN9ENl8qe1DpCQrbBrzg3KrgttspG+5Myv5IqnSZ8iuIT1RAll6EZ8AgtVC9pcDR3v0
	 xiupfOwMMxcTFJtTgZAzycdUaV9V/WT/SSUgPTSbide3P6TL6NRB3QIMMAlyht3vFCOBt
	 BpH1Ja1U2oqNtueC1O8RfEDBeWi78tD4J461NsGCLVpoIN/aAeckMHbqIe6f2S1SfQm9/
	 NT1sZA/FylKuLku2kgm8Hrh9LPm1eslcOM7FGk0g0a6b7jALF4pebjMJrFSf9ENEeaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487402;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=xxbuQ7YnwKJRiO0qCRVlDpGTsW4CQx/KBY872s2d53w=;
	b=kYT3xXezSzyvoY6twnfyvElqgEEuu0mcuL3RILNpZp8eyv0NIi7/jUH5it/r9dilFn5J
	 FsnDBDdRCXwEUSr7Eu0S5c7xOqXiABtrJJHAMhc6S4zq98NkFATkPAVHFEmv37Hhsmxsq
	 GiNWrU68UXuj3unSQx4sSF7OLsTBoUg8mA1yrpQalmAMWA6+lOjOZJrdwHAXKf4W0TnAx
	 hrf63tcou5MlPor+Kl+OpgheLhj2caGXBr28FYh2vi40Wvk8jWLRHp1UzC1m8ovpuAWGw
	 XdURJguAtHS+ho6phxes5aRuwOfA8N6mngrcl3rkKi31gBdeEo3WQeN2vdBjGwZ7pnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=HGfh20tO;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62338606A319;
	Tue, 20 Oct 2026 09:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62338606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=HGfh20tO
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 323A7780511;
	Tue, 20 Oct 2026 11:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792487401;
	bh=tE3vJC0W8o3NwDoEDj1/qPH9HQAmDSOArZ3MVdoGzgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HGfh20tOHYz7ju10QJTatuWztHxov6dpPh0o8yCwtFuy3t160DBDRWNOQuvbv6ggI
	 DH3HNw7gPveuS0E77AEJLljFlxHyqmgJz4EtScV9NwJej51Vi3tYfUfBF8k4L564Cr
	 TEkuB6VIKI1pSFKr42y0+PzLjqOYoDPOeVCdr1WzGxyihX7rop8bcnFEDBTTcqAG6V
	 PyLVa9vKWjLBzzlTVuDvEbsCc/pPzbo0w4hQDZZq2Hc4W5rE+opKVn9z5TvkVsnywW
	 VI2kniQomfm4/bLCew6u6bS08ZkqLnNLCdpI/prS2vptz30pYMEBqIRh/f9yXkjk/T
	 KTagDgifCuvkA==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 11:08:12 +0200
Subject: [PATCH v3 07/10] can: peak_usb: fix RX cursor desync for
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-canfd_check_channel_idx-v3-7-74d17c5a599e@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

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

