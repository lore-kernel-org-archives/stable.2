Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231937;
	b=b0ZorXmqtZVgHTK86H8z0l5K5TTaKUoVV9mrc6LijLjvcyFWVOx+BZON3YLsGMYa/NrL
	 ehoxrnFnmiohuTEmXc9uA5rw1hEkhap8V5SRJYxgClDtKVHAp4BqfOSQuvhC5b0yS9LAi
	 wivtM7TbuErxWbGwih9EM/71kLAPT9/U33hfJUoqNB3EMmA3TSopigD02xEII5D1Z/WFg
	 shqTIqUe7uX9UzVC/k8En2qrlAl5ZoytGdfXq8zKLUjsk6Yckn9M8OvOM61IICafQrL5R
	 KmeKIEa/CVIrg2FPMo+AfBdACBXjpcpFLAM6udqBSQLttjff00BQK1Fzmv6xv+ff4YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wXHNHwyHqZyMWvC89h3xRMVsL0F7PlcQnNFtH9sdpDM=;
	b=XL2ivqZ6wyO7Jtiwvz7bMFoj1P8EDs/1JcGEW6YOLL/zN23QyoUTDAFvSYIhbyIpm2x/
	 25aDMC18cM2Zvmt1CmdhB9ukf5vu96NNr94OX/vVc7fyfzreEIKNxyvVyg2VdhFYrIl78
	 Mn3HsFd9PAc1j+e/dir5Ch2Exgi53XnrPuw0cNPsmf3sYZe/lISBlA0cZqZjVD11QgiLP
	 V3xqg54WkJ8HJ//qWWrcqemAacQqHVgIjKB23JNRDsr55zYRwfh32jj6LXMgt+65V95/s
	 z3T0wYxttZaHNOQy530DwPS4S0v3F0mT2N8SYM+7kfeHCplVHpmecxrLmICm5Sn0yNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ML8NWqVv;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F7606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 13:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 370F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ML8NWqVv
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e946155442so6698095ad.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231936; x=1794836736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wXHNHwyHqZyMWvC89h3xRMVsL0F7PlcQnNFtH9sdpDM=;
        b=ML8NWqVvehIScf3YeJPDyqwR7Sq+DsRldBMwGKpOSjUFrkHlf0iAJuLc3ijanriryM
         EOFUr3tJvLiezYub615EhDjHVxG/uF0T0Ql42/VBcjraMQ44p0tXJAELx8HYcIw8SSIH
         bbq7bc5+d2/nxF3dC6owyoyZlzm52IdkwKJDrNW5Bnbm9LarPk5i+JjsybWa0nJho6aI
         wrl23jRwnx1I4xlcwMdra83YpSG6Ync5H0kZMykIXkbF+6RBmptts/d3CCBtIi897z1B
         VGgnM6JZ5JXqg9eT4PQliXY08YdM66zeO2SSKvBM4vNUEVmj7DA/GW7PtcYH9397yHyP
         houQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231936; x=1794836736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXHNHwyHqZyMWvC89h3xRMVsL0F7PlcQnNFtH9sdpDM=;
        b=J+frGcw99lDXYSY8E9jhd08sj1G80EzXPIBcC/XRmO2/VYzDWxdDPC2KtRqOd/Lflb
         kwfXO/b+J3MNwYQjUtPioLsEMx2//FriSwncTknrAOEJbMeGi6yY8FV4NcJfz4QFvO5U
         GNoqHMAUoJiMxhqu2v6LMjMOftTp9eGCXvJwKTF7Xf28tqk+2smruYMhaJYPtlplN8rL
         i+q3BrUlx5K15VlYH1kpLV4vNfdi9LnXBsZshjd9mw37HgsiXoVY/47FkO9/xs4t9wjn
         bKlWfLCSsGg/HRm/kytVIqUq6iu8G66FpNI+phIIwiQsiBparTG3VQOWigSOtrtdXVxA
         HnYQ==
X-Forwarded-Encrypted: i=1; AL+hErEMtHeVBHv9EbAwAsZqlTokOlL021QkdrNnNwrOt69PgB/C5DCB+ZRCzpHeu6hdfnI5T0v3D08=@vger.kernel.org
X-Gm-Message-State: APuU4Z+J5izKx8AoycXVxmvYg9HJrkAVkBUVzuseaSpMDjSWU63iLMrY
	7RGk/rN6nSCufACFP/G5RDkgVkFjmPE3uDhz0hEjc3KA5VJQyNtVjcJZ
X-Gm-Gg: AYBFou3pBoVpRCS+Ylmiq1g+dqlfu8fMk8aBKTavhMe6RPoCaoaJyFN6HjWwmkQe7bh
	UcGrQs7fNjLdH8zoBWpBzVr2rGGofWzCocqODOSdSx2MNq9HfJmWsVanY5chndMrjke8aRhg5Gi
	xDLjLORW8b7+h3dvOxrjTkcocdCsRhLwlmFcVRhDMAeQhzt/ql9ihYY9J2/DQxZcoLrQBrR6NQH
	pmKSgTuMygUvjmttzXUCZquAyhJBO6WsypeFGJiVRX6pm6UwxHq2RjH+MwtQ6pULTV6IyzVJo4y
	wGKkYmmt8YKH3LQTSQFWbVEi6f4WfrBXoPoFm+d7hmXy4o52tmFw09mbfqB4bCdNYWE4wfMAjY6
	6wUWaNKJqnHwixVnxwhRdRR/a3tO45QrmS4vYIqZwJhmQySxGPbiCNqtJpfHoOdU+axn0EpQ6pE
	2TdfvyBRSHqPLf73JQLo8OyJA10v3fOtzxHYcNAFVXk6cQqu+Sm0+4pnGVHduirmCPPcHtzxVa0
	OMW/GtkPU4Wdf/qym+dt90aJPsS/Rolu6Zx5YeuwhCMgVj6s1uk9iuBokEJd/uVXf2dhAm8kvnM
	yMrZ6fXtmzxaQGitTFZOEV4qemY/
X-Received: by 2002:a17:902:e949:b0:2dd:c100:a5df with SMTP id d9443c01a7336-2ed837a98a2mr40597565ad.51.1794231935615;
        Mon, 09 Nov 2026 05:45:35 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81727f9bsm11014285ad.57.2026.11.09.05.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:45:35 -0800 (PST)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	rmk+kernel@armlinux.org.uk,
	o.rempel@pengutronix.de,
	wojciech.drewek@intel.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v10 2/3] net: stmmac: guard against a zero channel in the aux snapshot handler
Date: Mon,  9 Nov 2026 21:45:05 +0800
Message-Id: <20261109134506.2794160-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109134506.2794160-1-zxyan0222@gmail.com>
References: <20261109134506.2794160-1-zxyan0222@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic timestamp_interrupt() handler derives the EXTTS channel
index with ilog2() applied directly to the PTP_ACR channel mask, with
no check for a zero mask.  ilog2(0) yields -1, which ends up in
event.index as 0xffffffff, and ptp_clock_event() uses that index in
test_bit() against a PTP_MAX_CHANNELS bitmap without range validation,
reading far past the allocation from hard IRQ context.

The zero-mask window is reachable: stmmac_enable() sets
STMMAC_FLAG_EXT_SNAPSHOT_EN before it programs PTP_ACR, so an EXTTS
interrupt arriving in between passes the flag check while the mask is
still clear (snapshots can also linger in the FIFO from a previous
enable, as only PTP_ACR_ATSFC clears them).

Check the mask before applying the ilog2().

Fixes: 8851346912a1 ("net: stmmac: Assign configured channel value to EXTTS event")
Cc: stable@vger.kernel.org
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 870c740b4a50..fd1142344950 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -245,7 +245,10 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 		       GMAC_TIMESTAMP_ATSNS_SHIFT;
 
 	acr_value = readl(priv->ptpaddr + PTP_ACR);
-	channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
+	channel = FIELD_GET(PTP_ACR_MASK, acr_value);
+	if (!channel)
+		return;
+	channel = ilog2(channel);
 
 	for (i = 0; i < num_snapshot; i++) {
 		read_lock_irqsave(&priv->ptp_lock, flags);
-- 
2.34.1

