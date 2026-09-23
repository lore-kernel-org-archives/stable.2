Received: from mail-dy2-f26.google.com (mail-dy2-f26.google.com [74.125.229.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D8527586
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172731; cv=none; b=VBWHjFnwJBckQv3Dy/tBdNLcjaIRhOPb0s4LPxQdUDfIDiTk+nBW/rbRbFtuoJxws14jtuQ6hEAgjfUYVorH2//xsK7Ez+gtE4CVWMi6hnu0SZYwZrl4/tD3onlDszKatnrEQpUxspLGtV0shqHquXH2WpXcXkQHGisWrbtmfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172731; c=relaxed/simple;
	bh=ktR9e2h8nCd9S0EFkl5DruJEUJcripKPI1tSmR1JOBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bxha/3CEMoCIKaXemsk5DXASu6FDhodnmbVtpCxpHTf5bLTrhyw5wFAgtYWbQ1enDA0P7Ncf75WAjaG7luN7l6S4li0mfXLaWZjQszyAB/ywwflanOXOy3ErdIvbkERBQSmcKDTvwQtdmCYNsz0mHptp62U0jLj8EaaWcrG+0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRp7RS61; arc=none smtp.client-ip=74.125.229.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRp7RS61"
Received: by mail-dy2-f26.google.com with SMTP id 5a478bee46e88-33175556ebbso579250eec.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790172729; x=1790777529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ZvYoYp7T3tg2JMG9Cckdchh+Egbf2tNmPcdBTT/ZU4=;
        b=pRp7RS61spOd3YquanMz3ILiDZe8eHlW4x1rnIWd94D+4fOganFvcOPUe8A2kdakHK
         4TBq6wSV11Otke9AyXZmkBBYvTEY6URiQVjYkEXZQpI2TBQyg7+VSXLkntRQ5pp0b6Te
         fXpxsue7zMjEdWg678URa+ONc3SIeFx2s0PsP7mlWZKI4iQyVisjAAftV7SxpHjkkaeI
         31iclWvQ04FX32JZ3a8a1LxcKxJC7H/uz5CEZxATZfKYw6k5s08bm4sZ+z9JRSFl+QzA
         ImD0yuJmFtW6SRfX7gUhCwc3xq/HZkYTv2lM1xIqYKc3XFcgEueLb+7b9uNNL9DDfyH5
         K0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172729; x=1790777529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZvYoYp7T3tg2JMG9Cckdchh+Egbf2tNmPcdBTT/ZU4=;
        b=gmza7vYp322F4pTKxAsDx0wPqmL3LYYOjHF5g/dAmBhZZEYgM+oUCcF5g9oI+c1Y2y
         gutDFdDLbJh/0yf2uXyKPFVrxDV4VvZcCNLI+Gnn/DvHIPWCvnw6ghSLMPAyBBl3fT//
         It9NWOteCKc+BU7fBKANmaetodfxiGmaNE0Rb2EMUiAFnW+rN5fnH5So9iy87eOl3aIP
         BZFySkC8EKXpWraXrfn/mWAKBqf5A5GwUXpGLKKZsWZn6mKGTuZ0wRvaqLi+hu7zFLSJ
         dj9ZcNidTL68JEweuRhTqlUDcpTfjgqbA9mvw7oaYESIRoQJmCyheJAWG0kf7oxsCCXP
         uf/w==
X-Forwarded-Encrypted: i=1; AKwUvBxDOliSjTTQnudIBzN03A+UV6B3DcZ4NbXp3FB95wNfDXpKzYA95k1DX4IMhKiC4YN6GE01yWA=@vger.kernel.org
X-Gm-Message-State: AFuF++nOCEHyx35E+9M2yGBfWHORvwCLD9Ewvt9bmtrx4trzV9yKNY4v
	RsVlST3x6t8Mz/rNntBKH/8WJzopJMbfNlABYf33sx5tHSwLY+1cnv+oxwalymbx
X-Gm-Gg: AYBFou3Pyi8Q71VNAOR2YDloiGgK6D0ogtq8MMcmrF8NEyXgsYPn82P4a1UgoHJwJht
	wD8itQI+aL0EPo5V1M4bGPNV6JZmiPENtKJeCTOxnMZrjZ1zWD/IqVP/XxGKzg/HLSQ2abNp1F1
	vcmIY6WXKypfGDkYmAbRoK3kLvGx5vykh70l2o1CJQuLdiHF72B+j7xRdWKFmaq93cZ5prTKq6e
	EBdeKq08ugVWtwHKRQWklxWoTSF+UMZWRuqarNOmvzfoLpfo+Z5EheXRQa3SRmkmbMNnRPvBK7O
	9wQFqf7BUCsdVsR1vgdnf7hFXtq+xAUPgddqBJ/p2kqwRMVC/FosoqcESFwSON7e2YAy6rDHvMD
	rjPQZFMf1POJ0B/iQ0bKAHkHSZjXbeczDw7EmkZrvAWNjuHlrNH5AeDiLKg+4i8YRmEmxTdtj2B
	jbuic1TpTFmoERDvQZCJNzUGSoPG22F+ntM90DUp7aN1Ys8hHTZ55wpJXNM2MLQ6Sr2IpXpE+HS
	w==
X-Received: by 2002:a05:7301:6196:10b0:33b:fc9d:947f with SMTP id 5a478bee46e88-33e8ea87051mr2781245eec.40.1790172728561;
        Wed, 23 Sep 2026 07:12:08 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm7193489eec.5.2026.09.23.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:12:08 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: wei.fang@nxp.com
Cc: frank.li@nxp.com,
	shenwei.wang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] net: fec: reject oversized fragments before bounce-buffer memcpy
Date: Wed, 23 Sep 2026 11:11:54 -0300
Message-ID: <20260923141154.2415545-1-qwe.aldo@gmail.com>
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
