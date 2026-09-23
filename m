Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2EA52CCEA
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195877; cv=none; b=CD6Uj0XrVM2RWXvXgyW+BaE37PpsQYQKVS+yEkONd6Yf13Bj7VsgMpAFSxzORPAsB5YltPO3epldehSxImLzc8OrFyGAo0FXhv+GveJ0BwW0Q/p9GC0C9XMFpPGFgyXmmmSHJo/PprPE5Vynz68o659QTgw4RIkEAjxmu/N1mNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195877; c=relaxed/simple;
	bh=ktR9e2h8nCd9S0EFkl5DruJEUJcripKPI1tSmR1JOBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+nQEFN68KdLVTQela1CMOv41zzWYkSH7Mil01tN6GHtTrRaS4+FbHG9d0KXESkJocVkrL+/ZLfQh9Y+RJ4/s/1M8Rlzxil4fPseLAiFPt64CeyQ4/qh71P0t9AdsoHWZo6CyNp5xn6FyZlrsiKg2CeC2N8rBgWASlqWfluqi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsPFLco0; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsPFLco0"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e62211987so1542760eec.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790195875; x=1790800675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ZvYoYp7T3tg2JMG9Cckdchh+Egbf2tNmPcdBTT/ZU4=;
        b=WsPFLco0BTKLwvvYD/SgZxR7EEMa9176KlisVwB54AJYvwXv9rOttuYZqbe0GWlG0R
         O7Nw2L40x7ZTi0y3HFViQBW7I5H8TwP9jDHjZnxezZ6FiVrMUL7y143XHfirYtGq8TdU
         2q8omMlKbC0+07N2TvZ/wMi6kxlGlMHWdk/8CD4IksXriQqXBuHTGDEycFGunSj09DKz
         zXsXRxiWmd/MhJuuc1SRm+TyDX+3R43WfVngqkSGYgcRfi/HLTyW6MZY2TlMng4/G1l4
         CAcvrlDEkB8E/Q3UsM2rUHqyF1MYSaQqko9AFY4yDhr2EszY5YMdXbFEBL+fXiQQEQZv
         YdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195875; x=1790800675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZvYoYp7T3tg2JMG9Cckdchh+Egbf2tNmPcdBTT/ZU4=;
        b=KtQZ/oN9jtQ5V4ggyTk8L4BGmGSaBzcffPYChW3/ehUVRJ93BZOQSjA94FBES3iltY
         0GcdoKoUk41H7N90ODr3b+qOOeEhi/8KrHHl7Hb0pCaPYdwXP+dXr+q3pciK69nZNrQU
         anPiQsb6DqPfHZN80R7oIjZwTnzVBqBDAtNuhZ2nky9AJ/BB8f8m8lLL3mt8p1x5N6q9
         ZQhM9sMpXo4FOg0wgL75/fYnnqm8O8bM2SNKhHi7eKLNSy3Ij/SVI/zct0nGUVFmyew/
         3oAwqDwRqJE/SHlb1ykoQxCAwMsvnIHoVzUFIi8wCcMB0lBMsQIIcpI6BEDemnk9h3/h
         2cqA==
X-Forwarded-Encrypted: i=1; AKwUvBw9wuIxiB5SS0Y1x4v1EMz/wrbJT84CQC8se3AJvoYVwTii6iihYBl2x5PdoHodTPnavRtzha8=@vger.kernel.org
X-Gm-Message-State: AFuF++mTSi3ZNWLo7Ef6cJlFDTizjl5s+lfelyBZrY49TNM01pzOEhPc
	g7YTHDMmTiSwG7E8AxnnwDvCWiJi/71RyxXRitO42p7ijdX/FUU2r9EK
X-Gm-Gg: AYBFou36n4uJX6Ev7Cs54NbJ3pswC+m+iteiwJ5fIREg3K7LjHump22JiZHYQ7ZgD9q
	yaYTNcQ3mzCgxAsrhIRu/4Q5lQ3i1K8UPIzSFfZBw6DbiaOtsylCvSMEZmaUpGHaVXRw6Kqfe3P
	cYYcQ/gcBpmCTnct9JRwEvNmDOVhHVa9OcvpgfJKnCKx/0UhqwuZHzXZsjoGIrKP8EQrT1XttMw
	pUKDJ3mG38ihWPLk3Kk8B4/dGbQ36fsdrQbB7Lqa26HDLO7U0o/jj8KqtltFygHpJdRYhFPpzPf
	xYAcoprxPYMThNFmtJWlC5jqMY1FFjDSGIwfQ5TQsyXCL2/gDy9ZTEPf2P+heogNOtL4Wdpvnxx
	1Y6W3qw0oTH8Sqcn5RtFrNuoxHplpab2GlMDxOreRWMBU+zDjgzdX4sHjWtKdiYKqbSCeUje+Xh
	M8Rr3+yQNFiuM8Bqbdqvg1CnN7cSWmHJNDpZael6Dlif1k6/e0edNOc6qV/viqV5c=
X-Received: by 2002:a05:693c:8206:b0:339:8131:424e with SMTP id 5a478bee46e88-34006978035mr212595eec.34.1790195875080;
        Wed, 23 Sep 2026 13:37:55 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm8375052eec.5.2026.09.23.13.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:37:54 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: wei.fang@nxp.com
Cc: andrew@lunn.ch,
	frank.li@nxp.com,
	shenwei.wang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v2] net: fec: reject oversized fragments before bounce-buffer memcpy
Date: Wed, 23 Sep 2026 17:37:38 -0300
Message-ID: <20260923203738.1583735-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fec_enet_txq_submit_frag_skb() and fec_enet_txq_submit_skb() copy
transmit data into a per-ring bounce buffer when the source address is
misaligned or the FEC_QUIRK_SWAP_FRAME quirk is active. The bounce
buffers are allocated as kmalloc(FEC_ENET_TX_FRSIZE) where
FEC_ENET_TX_FRSIZE is 2048 bytes.

However, skb_frag_size() can return up to PAGE_SIZE (4096 on most
architectures) for scatter-gather fragments, and skb_headlen() can
exceed 2048 for certain GSO packets. When this happens the memcpy
overflows the bounce buffer by up to 2048 bytes, corrupting adjacent
heap objects.

Add a length check before each bounce-buffer copy. If the data exceeds
the bounce buffer capacity, fall through to the error path rather than
performing the out-of-bounds write.

Fixes: 6605b730c061 ("FEC: Add alignment handling for FEC driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 794ec42..8614984 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -558,6 +558,8 @@ fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
 		if (((unsigned long) bufaddr) & fep->tx_align ||
 			fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+			if (frag_len > FEC_ENET_TX_FRSIZE)
+				goto dma_mapping_error;
 			memcpy(txq->tx_bounce[index], bufaddr, frag_len);
 			bufaddr = txq->tx_bounce[index];
 
@@ -634,6 +636,8 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	index = fec_enet_get_bd_index(bdp, &txq->bd);
 	if (((unsigned long) bufaddr) & fep->tx_align ||
 		fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+		if (buflen > FEC_ENET_TX_FRSIZE)
+			goto release;
 		memcpy(txq->tx_bounce[index], skb->data, buflen);
 		bufaddr = txq->tx_bounce[index];
 
-- 
2.43.0
