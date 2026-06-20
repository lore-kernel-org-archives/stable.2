Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591234107F
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781961187; cv=none; b=rmwx5qPGQ5EbtsQ1bthGuvazfhTW8IP/GNrQ/b6NaypzWyAAFYH9AfhYk2krjuY82Qh4JjtVmvEC6ueDr5UyNZfb9TE8rpSZvn1XhhgvRF5vsOigQ20vs2JbCGL8mpJz1kTGw4CSyZmBeshybQZCoSMkLu6at1IEt6Jo6B4qYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781961187; c=relaxed/simple;
	bh=mt/3ILTG+XNwiIzhNrlbnzFKkgephpF+6bXQ/A6h+gg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iSuAyTFywW1eiE6HQ4lFQgjub2Cbx2UskMH6Ay1sXvDWe9QiXThbuEXZyEJMXELkm39Y+PVzMp31uJS4dCIu1jIfojvCMqZBBhf1XpQ6vhl6fwufYId2PPDuZwXDr78vYvCKIHkZt6X2eMZ6iMTxGJPjRdwpSNAbRa7gWsJ9O1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMf8iBLW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMf8iBLW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c379e8ffso24401415ad.3
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781961185; x=1782565985; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s369gC1gwT7dsz7DMcgFie9Oig2M6XFOV+HnD3kXY14=;
        b=JMf8iBLWUo0pHXTpVGcg7eBWd6CQssM/iqVqLcrADrlinj+4r9/3fn+toxNuSQL3vy
         xHOP9ZbB5eBBloDN+AWXrP5N8eCjyUzn2i4opAEridKv40/C7Lj2CCaXWXAJ/7j7JmU+
         /JW3HDsdRTg4yTS9repa5nLlBP3AoU230eIV3bu5Uv1YcFya7dluEbkY2pRIJ4uxKm18
         p70fiIZK1Jxj0iTTeZvSRrUKhMZ3BXNRFCvm1tlvHKw9KcqCXgY0pyBAVArF4pSbU4uF
         MAaZWx+zffcnDlnd0H2VmuXtJSHrHSWGyLQKVpJYVsuijymKOTr1tBZkgFBkdb1NNOPb
         l79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781961185; x=1782565985;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s369gC1gwT7dsz7DMcgFie9Oig2M6XFOV+HnD3kXY14=;
        b=GtmVKvhpJXuR06+73XWKEt3fmcfElYkuWt54TnJ5v14imr3LI+hSzw90CZpuKf8bqp
         iglNBFscHftuYBE+3WUhrVaXDOK2k4yQo3ov9w+9e+LF2aMgjrhxiPlJi1lb1NtuFm7H
         C9ofwpQOY1XzjrwHtQhR7Gjdjwj1pAD9PtLhXDZxvPeI0o1aRjTJ9iNnHTYdYmy2tx9z
         Ph3UErTsl4n0bAhD2Hv7NgTy8MlOzvf1rPObT0O9DY9ayhjWbLTWBXjnqOHBD8HqeUe5
         QMhZT9KPHf/cMMgYcqUpM2NXYzBO/h17jYr4v5iShX47FJb54LOlkg3n5Aua8xX9QZOm
         UccQ==
X-Forwarded-Encrypted: i=1; AFNElJ/w76hce+/wZyEGrYKmPxtKHzsQmDGbVXGgCHVs1GZS1FsswnhBmN/OFKZyYSue7MJcj9PQLHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwG64D3dkFN9RzjcC5Av4j/l6Qe2d6isZUZcavDoTrIra8Epj
	4ntjKznXd0tHYquGpfcTjEZl3SZqlDlX84w1ZJBC3jsMaTQZQnqnNYa2
X-Gm-Gg: AfdE7clT+hTtkZOnpX9Gzel0tNrmIfb0DRx61ORQtD7DiMMj3QbhUnKaxly8M5DLNBy
	D8BGiSG1vGfvw7FgKC9yet3YrkrAWOIWfKak2v7EZYSr6sbBenV1zTHtHsLtfdRgRlbDf9MgpbR
	qN/8jPpF8yW5cx1zLQVbtasczZJgOZ2ObccaNOI3gAwRmtI/DVY75A3yiRpTmZ3+EBqvneb8zDX
	QLzPNrvAao5t/qfM527jr4BQSvJokDegwXD0a7BC73d9GgMvPqFllWqsbHIYYgo4UL7fOVXwht8
	r0mcfQI533mFnFR2pKGlHQkcR1P4tfJ0SonP8cA5hZPNWPtx1lfbMfkUc6OHfQvBY2IM4Yf53tt
	BQ8eIuv8Ypfg+PqL0KKbmbVXWfFfvcOs5WFBPsmBI5NDfx9cZO5yZ3UpkNtfTuCMbrojbj40xjD
	m/pLUviptEfTWjtsRFBQ6mlotdGuC3mRTrT9NlSQ==
X-Received: by 2002:a17:903:41c2:b0:2c0:b081:849a with SMTP id d9443c01a7336-2c71901c644mr79485055ad.30.1781961185503;
        Sat, 20 Jun 2026 06:13:05 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af57asm27653775ad.13.2026.06.20.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:13:04 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v2] net: wwan: iosm: bound device offsets in the MUX
 downlink decoder
Date: Sat, 20 Jun 2026 21:13:00 +0800
Message-ID: <178196118045.462404.11069139160448641355@maoyixie.com>
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

Validate every device offset and length against skb->len before use.
The block header must fit. Each table header, on entry and after every
next_table_index, must lie inside the skb. The datagram table must fit.
Each datagram index and length must stay inside the skb. The header
padding must not exceed the datagram length so the receive length does
not wrap.

This was reproduced under KASAN as a slab out of bounds read on a normal
downlink receive once the iosm net device is up.

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
Changes in v2:
- mux_dl_process_dg now uses intermediate native endian locals dg_index
  and dg_len so the bound checks read cleaner and avoid the repeated
  le32_to_cpu conversions, per Loic Poulain's review. No functional
  change.

Link to v1: https://lore.kernel.org/all/178185979029.4044562.9993615975949055530@maoyixie.com/

 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 33 ++++++++++++++++------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index bff46f7ca59f..ff9a4bc52f29 100644
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
@@ -595,6 +597,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 	block = skb->data;
 	adbh = (struct mux_adbh *)block;
 
+	/* The block header itself must fit in the received skb. */
+	if (skb->len < sizeof(struct mux_adbh))
+		goto adb_decode_err;
+
 	/* Process the aggregated datagram tables. */
 	adth_index = le32_to_cpu(adbh->first_table_index);
 
@@ -606,6 +612,11 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 
 	/* Loop through mixed session tables. */
 	while (adth_index) {
+		/* The table header must lie within the received skb. */
+		if (adth_index < sizeof(struct mux_adbh) ||
+		    adth_index > skb->len - sizeof(struct mux_adth))
+			goto adb_decode_err;
+
 		/* Get the reference to the table header. */
 		adth = (struct mux_adth *)(block + adth_index);
 
@@ -629,6 +640,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
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

