Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4E31E834
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859798; cv=none; b=OQLKLpncc97NPgtEdsaEPLTzEL/XJ6YPSLSglhPThbiw3Fu9Mr8I/G4OdCjv/ggljrI0EyRbf1uNu27/+MvrDh/QlNz8/tydcmRfNQO+QBSXALQA0Ut1FefNNibOKzcZF7+Cx26lviy4BdYiTYYyTDIvp8EYu6f8maA3ND4W/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859798; c=relaxed/simple;
	bh=ZDMKVKiJ99ZZuTo0IWaiei0vmrhN+tQnlsIgRBvy8hg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T/9a+FRqiItoZz80SfKqD07brzWEPjQnB/LJT28XDel2uSiV5VMJaxCKG+3Bpd6aSELTQGqWWzj0eThyLLYOf++WnLT9D2d0bVGf8NXYBiccOicRJQ6W7kFPWP08P5qDky+9caNpHXTYmBcd78AoA2xkizU6W7V7rVXzJdL/Bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfTcTxsn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfTcTxsn"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842848fd613so1737584b3a.3
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781859796; x=1782464596; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6rYFKdT28w7xlw0jk+pEDYESMf9ldPJ9JkhM6PXa+g=;
        b=lfTcTxsnAIGBxffLQBwtxh8cRnLByTGRDojzR58TMA96o+5updz2Cq4Kqr13kSw8j5
         S10biHOxBqAtNjsiLl1kQSLxnpSXB5qOucUJgtsya1Hif4xr7TZ4Ot/zVskPOtuU3z+f
         1Ny95RvVwNt0u+FJcWT+cD/tODttSTk3jV/mVaYzoWyHmSYNkGNyX6zrwkd4LJgEQsws
         ZtzwIcZmRdFWyQGzNSYYVGRmV4vw1uOa2IlotScGoZJ9EBRPqhjiZQHbBa4y6RfUMsNQ
         KoGRZVOCk0HbNsUIPLYvxEoHqtAtAaYn6NBLstCftkFCG8JrHQfQCbDPNvTKpHhcZgDQ
         uqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781859796; x=1782464596;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6rYFKdT28w7xlw0jk+pEDYESMf9ldPJ9JkhM6PXa+g=;
        b=FK83y9HfgZC0Hs22dEMhOG0hStXc+ezN07wBGcno5f9oyuTmXMYVhKF2BOrCF7JpNC
         ewk4UjIHiUEo6OCY9khTcrGi87lTqXk63x0gYDC13bKQ2xlxNKLujq3V4s2uh3GIGl1+
         69hh9GW+aOUcVG+IUM+F2BouiPhJS/G4nFQoHK4kqzMuJvdeWqh3xMYuFF3VPk3x0Kae
         U4YiypixVZ9BH5LTMBfkuS8I2bEUr/Sz7nmtjFoxCGipyvD6613nD+Dz+z9HUUiwoJjz
         zzz3voff/cDoDKYRe4rQzuN8/ExxBw5jvDb2fBHgxAezyIJY6Ct5Z7xnpJxi0wfByGJy
         aiEA==
X-Forwarded-Encrypted: i=1; AFNElJ8jbnlvGMGRS70QCfaIF4O++rlUyJMBPI/iwLyUckscfq4lztqE3Z2+JRAZ/u7gF2t9Ui2rUsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9u0qtYdxJAAacaIp36ee1176IAvDf8SJPqN7e47myOKFLtWBA
	mxyY4PGMdAhBKgvhn6lhqSPLXQiW72DH0G/V9g5kPHlP65odqdbKZkCH
X-Gm-Gg: AfdE7cl42/QNxbV8LnUIcG8qJTztgobWxX/pgNOfB2ksqu8vJT/hMl4Am6g1fAe5dYk
	kKXMD+MEb+935Oho4LXG3M1NcZ49uuySRfhM3TDfa7S4E3gE27H8YWL25s/BRRzlTwPDeYgrhp3
	mqv9m8RciJYBKxVTgq12l8bchaDjL0mWkn71Na5q7K89V1oJNwj8OqC/9T9WOlV5CpaHCnTGYm9
	2pDdcdFsO7BpAYhRhpS3wJfosMYKPeqHfWefzrUw5Hp6nFV3q9biK5LEXeng6aes6AbgJvMjX2m
	Wt91SY6T8W5oky+/jfom9Q1P8Dh8CUXUk8UrpmIJux3ED3pca/QLxq8KHCfLnFIFNFwzOVkt5pb
	rEmGInvUwL6Q5rO9iC7SX54HGmEXc1Vb2YOIfGfqEY9ojAc+UK3i3REYG1IAb0Xod9xEBJo3yIF
	c3cFQ/pctNT34WqH/f5lhJPA0jq24IJmgrilFytw==
X-Received: by 2002:a05:6a00:12d6:b0:835:405a:7e6f with SMTP id d2e1a72fcca58-845507bca47mr3121373b3a.14.1781859795694;
        Fri, 19 Jun 2026 02:03:15 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84553829240sm1984824b3a.44.2026.06.19.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:03:14 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 [PATCH net] net: wwan: iosm: bound device offsets in the MUX downlink decoder
Date: Fri, 19 Jun 2026 17:03:10 +0800
Message-ID: <178185979029.4044562.9993615975949055530@maoyixie.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index bff46f7ca59f..1c021bb0aa7a 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -557,15 +557,21 @@ static int mux_dl_process_dg(struct iosm_mux *ipc_mux, struct mux_adbh *adbh,
 				< sizeof(struct mux_adbh))
 			goto dg_error;
 
-		/* Is the packet inside of the ADB */
+		/* Is the packet inside of the ADB and the received skb ? */
 		if (le32_to_cpu(dg->datagram_index) >=
-					le32_to_cpu(adbh->block_length)) {
+					le32_to_cpu(adbh->block_length) ||
+		    le32_to_cpu(dg->datagram_index) >= skb->len ||
+		    le16_to_cpu(dg->datagram_length) >
+			    skb->len - le32_to_cpu(dg->datagram_index)) {
 			goto dg_error;
 		} else {
 			packet_offset =
 				le32_to_cpu(dg->datagram_index) +
 				dl_head_pad_len;
 			dg_len = le16_to_cpu(dg->datagram_length);
+			/* The header padding must not exceed the datagram. */
+			if (dl_head_pad_len >= dg_len)
+				goto dg_error;
 			/* Pass the packet to the netif layer. */
 			rc = ipc_mux_net_receive(ipc_mux, if_id, ipc_mux->wwan,
 						 packet_offset,
@@ -595,6 +601,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 	block = skb->data;
 	adbh = (struct mux_adbh *)block;
 
+	/* The block header itself must fit in the received skb. */
+	if (skb->len < sizeof(struct mux_adbh))
+		goto adb_decode_err;
+
 	/* Process the aggregated datagram tables. */
 	adth_index = le32_to_cpu(adbh->first_table_index);
 
@@ -606,6 +616,11 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 
 	/* Loop through mixed session tables. */
 	while (adth_index) {
+		/* The table header must lie within the received skb. */
+		if (adth_index < sizeof(struct mux_adbh) ||
+		    adth_index > skb->len - sizeof(struct mux_adth))
+			goto adb_decode_err;
+
 		/* Get the reference to the table header. */
 		adth = (struct mux_adth *)(block + adth_index);
 
@@ -629,6 +644,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
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

