Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365F332623
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368256; cv=none; b=HHELnuW0q26iymhPSafLexb2ZdvEfF8tWtHMnsN05W8tBaEunmbvu4HvLWwA7S/QGQ8fu39hX56zGATWBg1D5jAM7glDumcblsJy2AqvZ4SeNei19ThatxAGBazABXx5CiU1Szqzmva4zCqB6rbKbl1kiSzD6ujX6/AIu4s5V8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368256; c=relaxed/simple;
	bh=yfi/JXvu8sMHtLHhVS8UQYxKpKJoSxWZGCtcqeG1Yno=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bHxIwacTh1GLzV/c9UA4NVOeQfiiuX7pV3gtNdFRfaCgp+Ld1Xa8D/wE1mRt7Vj/9GhVsNRCAVKSC1yiHVfNxcLvTQPPE9Q5oMOfve+U04bFoPnElQD/zn0P4iswcpH9Y7WFhNJQQmh0BVw7CTUnQd2n6jhQhlOwVJOdIDPQU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgcDLvKr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgcDLvKr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c8007ce809so665095ad.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 23:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782368254; x=1782973054; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gITK1IMWYuI8gnc/zx/FmlRRwaXSH4ed5iq2ZykEh4=;
        b=MgcDLvKru/a6QB7OJOomvRxY3Ch86TvAfMM8P5BWLlradFW42m8OzojlBhq2ItfNiC
         z6Ld2UFoX2eLR6Td4YOprCpbzDElRZQxusPpyLuCT0iEA8GPr9jdW668IcLQ+PrLFUNY
         8g9YV7Oz1IRpw0oBseTAOJGCKtUqFETTme1UXR0Ono2vTmb0x2q/jTmZpPe/pIQkg6MX
         Hizu6OE1DKzMBv0kV0Us/Phm5csScEawLuM2/9v8bua2gDup9/cH093xYDR4601+kOee
         EyE6jpXkEEH5A6GOsBe12q7n5LtcxE17BodR8VjG5muh3SWp9On4rqTyqQVd3mxyoGE1
         YtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782368254; x=1782973054;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gITK1IMWYuI8gnc/zx/FmlRRwaXSH4ed5iq2ZykEh4=;
        b=goi9neX6ZiEjtkOQLQtLBItnUZJMn1sxUKUNRgK8BnASapqAieiZn1KS1PtGGUpnj8
         uiU50St6tvYRbP9egu87QuhQg83QejZpVuUCJeClyfT8OPzKIKjC1+g0Y1raBmpdCez7
         9JNTAIfTbkS5B1Act2sVjVx9nTADM5QmGIP1IHI4Fd37nomVDC92ZiaYZE6Cg5nW+KcK
         Ed6eIvVS1qT6DGghFTkFTTGV+z97xS0pfpQI0fM55JuL0I4r3Ciipn44aWKViJgmCq10
         m7pc/dY6YewJdrpg/0g+sTL21SCF0cuqqsx4bdlZb4OfT8jWX0JAGS5bdh7gN6/XBjeu
         +xpQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIQwn1Gfq4eTTtYZ4vO8PTmUgQFplQczDrKDQEe1tF/R8H/ncs6v10XCmO1cFPL5Um4xqS4eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkcLE0PFgi6mS8w6TaHcr0z6AaQFTaUHSlUeX9lWqwd9J+w6gF
	SkZ6Qh4CTyUji9odqYoiBdAk//a5H7NDh+HyhUYS8IRanu+fhPGvIBQI
X-Gm-Gg: AfdE7clY2zEC196WeRy41qiUKqqaF/emOlHIGErkh1VIBVUO+HVBS6v7nRShboHk8qi
	BaoehuD5BFa4hsexSP5y9CHlKixv8h73a8WOh9NZRZYnExBcKMAvn8piKVAKt/Xi2aEF5IEM04K
	N0BccxBLTUTxmtL6TywSk6S5RlxsgBvAxYJiJpJd80ca2o8EbyssyLtm0q7kRFB/jJ6wprX8VFz
	QoLRayIp1PxW1BjPO0o8fqkwJlhPuXkQ4BsKFhIrBuwBz7sWIlcIvWQOjYPR222fL+n+J8HSIq9
	/SOSN7oVias52V+1rTx2OTekKT0S+NpIRTmZJNDqk1jF4AVQCEBFaz+vts2TMMCR+t1Ow+ubJnD
	5C/qPj6F5vinuTxt/m8xQlCSsB3vUAOmuXvD+f5QnS1uFSt/mAFvHBgDbbjocgGeyZTVlfgRDfD
	SwK+FY+ZTR+of6FyggmcyrsJoUhYWkoKdtt+pZFA==
X-Received: by 2002:a17:902:f644:b0:2bf:211c:4980 with SMTP id d9443c01a7336-2c7fc8b106fmr13654485ad.35.1782368253877;
        Wed, 24 Jun 2026 23:17:33 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f650aa8esm12195315ad.82.2026.06.24.23.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 23:17:33 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v3] net: wwan: iosm: bound device offsets in the MUX
 downlink decoder
Date: Thu, 25 Jun 2026 14:17:28 +0800
Message-ID: <178236824878.3259367.5389624724479864947@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

mux_dl_adb_decode() walks a chain of aggregated datagram tables using
offsets and lengths taken from the modem. first_table_index,
next_table_index, table_length, datagram_index and datagram_length are
all device supplied le values. Only first_table_index was checked, and
only for being non zero. The decoder then formed adth = block +
adth_index and read the table header and the datagram entries with no
bound against the received skb. A modem that reports an index or a
length past the downlink buffer makes the decoder read out of bounds.

The buffer is IPC_MEM_MAX_DL_MUX_LITE_BUF_SIZE and skb->len is at most
that, so skb->len is the real limit, but none of these in band offsets
were checked against it.

The table chain is also followed with no forward progress check. The loop
takes the next table from adth->next_table_index and stops only when that
reaches zero. A modem can stage two tables that point at each other, so
the loop never ends. It runs in softirq and clones the skb on every pass.

Validate every device offset and length against skb->len before use.
The block header must fit. Each table header, on entry and after every
next_table_index, must lie inside the skb. The datagram table must fit.
Each datagram index and length must stay inside the skb. The header
padding must not exceed the datagram length so the receive length does
not wrap. Require each next_table_index to move forward so the chain
cannot cycle.

This was reproduced under KASAN as a slab out of bounds read on a normal
downlink receive once the iosm net device is up.

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
Changes in v3:
- Also require next_table_index to move strictly forward, so a modem
  cannot point two tables at each other and spin the decode loop in
  softirq. Raised in review of v2.

Link to v1: https://lore.kernel.org/all/178185979029.4044562.9993615975949055530@maoyixie.com/
Link to v2: https://lore.kernel.org/all/178196118045.462404.11069139160448641355@maoyixie.com/

 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c |   40 +++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index bff46f7ca59f..0bbd41263cc2 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -553,19 +553,21 @@ static int mux_dl_process_dg(struct iosm_mux *ipc_mux, struct mux_adbh *adbh,
 	u32 packet_offset, i, rc, dg_len;
 
 	for (i = 0; i < nr_of_dg; i++, dg++) {
-		if (le32_to_cpu(dg->datagram_index)
-				< sizeof(struct mux_adbh))
+		u32 dg_index = le32_to_cpu(dg->datagram_index);
+
+		dg_len = le16_to_cpu(dg->datagram_length);
+
+		if (dg_index < sizeof(struct mux_adbh))
 			goto dg_error;
 
-		/* Is the packet inside of the ADB */
-		if (le32_to_cpu(dg->datagram_index) >=
-					le32_to_cpu(adbh->block_length)) {
+		/* Is the packet inside of the ADB and the received skb ? */
+		if (dg_index >= le32_to_cpu(adbh->block_length) ||
+		    dg_index >= skb->len ||
+		    dg_len > skb->len - dg_index ||
+		    dl_head_pad_len >= dg_len) {
 			goto dg_error;
 		} else {
-			packet_offset =
-				le32_to_cpu(dg->datagram_index) +
-				dl_head_pad_len;
-			dg_len = le16_to_cpu(dg->datagram_length);
+			packet_offset = dg_index + dl_head_pad_len;
 			/* Pass the packet to the netif layer. */
 			rc = ipc_mux_net_receive(ipc_mux, if_id, ipc_mux->wwan,
 						 packet_offset,
@@ -589,12 +591,16 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 	struct mux_adbh *adbh;
 	struct mux_adth *adth;
 	int nr_of_dg, if_id;
-	u32 adth_index;
+	u32 adth_index, prev_index = 0;
 	u8 *block;
 
 	block = skb->data;
 	adbh = (struct mux_adbh *)block;
 
+	/* The block header itself must fit in the received skb. */
+	if (skb->len < sizeof(struct mux_adbh))
+		goto adb_decode_err;
+
 	/* Process the aggregated datagram tables. */
 	adth_index = le32_to_cpu(adbh->first_table_index);
 
@@ -606,6 +612,16 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 
 	/* Loop through mixed session tables. */
 	while (adth_index) {
+		/* The table header must lie within the received skb, and the
+		 * chain must move forward so a modem cannot make the loop
+		 * cycle between two tables.
+		 */
+		if (adth_index <= prev_index ||
+		    adth_index < sizeof(struct mux_adbh) ||
+		    adth_index > skb->len - sizeof(struct mux_adth))
+			goto adb_decode_err;
+		prev_index = adth_index;
+
 		/* Get the reference to the table header. */
 		adth = (struct mux_adth *)(block + adth_index);
 
@@ -629,6 +645,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 		if (le16_to_cpu(adth->table_length) < sizeof(struct mux_adth))
 			goto adb_decode_err;
 
+		/* The whole datagram table must fit in the received skb. */
+		if (le16_to_cpu(adth->table_length) > skb->len - adth_index)
+			goto adb_decode_err;
+
 		/* Calculate the number of datagrams. */
 		nr_of_dg = (le16_to_cpu(adth->table_length) -
 					sizeof(struct mux_adth)) /
-- 
2.34.1
