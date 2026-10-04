Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30443CEF8
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115582; cv=none; b=Ik/WJLYeQiwnuDL2uPXQnVLNT8M390GViUoXasV8Bh0DfVOQCSVlrFaYAdSVzGT5x9RdsVUu/nkCQ8Ph/s555JUjiTGUAucaxwxKW0LMU7asPc/r4smzGpn2CECgM/A+6JpYnOlntHkJgK3yiAhO5369DUooV/TNSfercur+zUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115582; c=relaxed/simple;
	bh=EXkfKCc9E5fuCQAQZZmlXL2AKxr+f04NqtE9A2Hapkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFC1jJkQFVLK/hF/T2lHX5qmFra7cijgk8xxfEWpleDyXnlVUgr+diip/DHDXUlpurUDNn0lYlXQ4WkU+qeW0OduFHxV2LfB9iRAoXc4j6RZP7SYMdTE+HoLAJdbflJaio29R/dIm+haWD86cGvQKisl7lWQOd1iZxhav9grSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDQZgkj+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDQZgkj+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a0a911e8d6so359549a91.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 05:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791115577; x=1791720377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+CAZYh8v0QDN7ZotKXM0PQZtaFfuu3vpY61Ne2zKy0=;
        b=GDQZgkj+6AQIC6aZYBN8Fkl7y/Se0CnxciQLujOMZd4c5WC6YWA1iMu5gExDfJGn9Q
         NCCuC8zmZVfqzWUdIx80B2PjVlp6HSt7TJG72Hczrj+qcS28iig3+k2r27KSckCHdX9V
         4KKtNdMw3IhRsB42ZG8XGG1FkidMTqWLPLlJ95ULsP9jyiPcmDNKS85Am+mT2XCECR5/
         r0gL42Ud4rttBZ+9GKBlZ7MnxzvDPUTqBui1uoXw3EkR36ONQQmupE+euIMG/j1lrxS0
         q9r2P5e4H5ernNZasHytIJsgkX82QMDb3VXBS1reYJUa1ildUgikG6/qgimf1L/MOiQq
         1Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791115577; x=1791720377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+CAZYh8v0QDN7ZotKXM0PQZtaFfuu3vpY61Ne2zKy0=;
        b=XlcjuL7PETx9PBScHIGZxJViy/ulaijXPbq8WelCtkH+hIYnaE+qssJIjOmu/GIBjo
         VMNjua0JBqKK9xXUUAMS81kwgiRp24X57eLx/D2pwCSriETk+4xvqN1bai2TN1NLiLim
         CN2hRooBemHqXMP4Lwa+iKPMfCPa/sO2vdiz9dZjI2gIdlEHrt1rg8Ilmgu14JO7ugoA
         ZdO6WCMFZYNP9sIqYd2fEABOu/JmzTWGhja6+nJuuZHV29tFMi6DCNOeFZDVUp4rPEtW
         tUyCnfyQPpKjKq9AiQ6CHeSrPIjnJwa7djGsFpilnupVOm1L5uXBrLGHitM5h7sSpoVr
         HXwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvckyhzt2qxJLobcpZnH+KQz7msKq8lVP+DhjCBb3ijoV/yu9pCCPlaGQIf2UzPR7mRWfvg8A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwITAiAImWmDVsSDs7/hnevKsaO2Ye+yMN8cDmu1fP/tWqMs+M
	DVe4PTAK8o188K4KKI2fwRwD3Q1R/8lfgdm/5wzxQYntyZ0GINyEoVyE
X-Gm-Gg: AYBFou1oWV5+ULJ9yjZ1HXX3IOxUEA+0FKbw5wBbAWG6KugW2WwXONacg/re/IhN3WN
	l2XB+4v/sO5nOJkiYZEPAZ6l35Ev/G9X7df42rE9YzvyTxS79Ya17sr2UexavwmljnmhqKEVUvw
	9x1Wy7Gg2rEtPtpu/nkd0kk22t8n5a/48rhN3kRWP2kWF2p94vDz9UCCYhQBRqNBJccCCHZB9ug
	t8o9RA+7RzjsuVJVCuDXdMvFNlHr5j2VqwTNQkWIK7saOjLtcBYcviwkgBBOpu9HQ9Dv8pnCxnh
	+4Atf9JByWmGOD82kV3eiZZBGUYY6kLgIx9MiXEb2mUWxHDv7fmhZc7CqJiww1NuTNZ9GCQmkjF
	RQ9SYKQLqLCvZW4r45Kr+7bsZdkS4Hv4oABnTPE5jTghhoLDkol3jG8aF5QCl4ahFd4QVyfV4bs
	rfVZGgUsiWz527zzbfhQGnuTXEhk9nN9H7t8QBbZ2+y+vwsEzYxM2x1mWNUVkZGt4CP+8P1w==
X-Received: by 2002:a17:90a:d60e:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3a7875265bemr3132986a91.52.1791115576910;
        Sun, 04 Oct 2026 05:06:16 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a79e7c243csm2603661a91.0.2026.10.04.05.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 05:06:16 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	maxime.chevallier@bootlin.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v7 2/3] net: stmmac: guard against a zero channel in the aux snapshot handler
Date: Sun,  4 Oct 2026 20:05:25 +0800
Message-Id: <20261004120526.2728564-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261004120526.2728564-1-zxyan0222@gmail.com>
References: <20261004120526.2728564-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
index b9a985fa772c..2a076e228e9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -242,7 +242,10 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
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

