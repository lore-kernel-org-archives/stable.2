Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383F2F7F09
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667447; cv=none; b=fwvxa0ACDXeIbDjLFLLjsV/aCcI6HwiDiwtQxmw/kaOVBKNvGcQHnWV0Q+w5NtdbebFzk2dm+ucgjQYQzs4Mak4hlVNFuxP345ISbb2TjP7FNl85Yf7uUghLgovkfUXwPSmRKQWJgqv8jcuHmzpBOX73k4UT7Fb60J/HbgWud3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667447; c=relaxed/simple;
	bh=EXkfKCc9E5fuCQAQZZmlXL2AKxr+f04NqtE9A2Hapkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgaLz7sDbE/m97mSiEB83CxFaMXforOQmPIFK8blan399q1QHElGxJTBfAbfaVSTaCPT7qb+mn5Dr0lqBsl45gL1tyvZl13oGNVQCY7ErR1hyV6oyC6A5FpAOSDVZvi6Hn4778Du1ESUrfT//Q0k7BWptUlZouN37mggXW2W3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV94Sqpf; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV94Sqpf"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso2505298a91.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 00:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790667440; x=1791272240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+CAZYh8v0QDN7ZotKXM0PQZtaFfuu3vpY61Ne2zKy0=;
        b=BV94SqpfoBNPrGYpDRBiT6Zd2i3k/gllq2A/lk2cTRJsYrTQzB/ddH7SlUMsFbmWLI
         jcQ1KyCAdB4dHts7Kai/M4weJa8kCd3UKKKFzVQOJlkbWymB98ZnsFnCCQ6XQh79kHb4
         ufZ3+jb9jhb13PVVihZB5zmGAvXA11biMx00cEk+Lc0l1/IjWh8b/lbx3X+II+7Iypjm
         oTc8VGJjySUGwYadCdt2PHUclJCbZlBBV9l920NsZv98/VajzIm1IKKmuqPLQffmobnw
         fjeIHviM1SZhOLDGvKKByS+0wbdT+sQztxOMFF1CwhtmIELwojzzIZSv6bA/w/mlQZ2F
         f3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667440; x=1791272240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+CAZYh8v0QDN7ZotKXM0PQZtaFfuu3vpY61Ne2zKy0=;
        b=yDv0hSHsAVgEKu1ItknYYISfGJ0OxHJ+fMqSA4nvechisADoqbahKltjBzoWkoKloO
         cTjK1RxR4azxwKvxGqLgkOiQOFuZ3RjKTPZLwhqHBfszZu/aT4qZX0Nz5/+WLjQceKJ6
         rVY9gC5FxCitew5amncLrQwb3L1VfDhtT3RQd296bmAuXl8xarDRPnnF+M48iaD1Zp86
         dAZ8otTNHze0AP7QLbSm+12BXJKmFAcztpsnLygRBuiDeJEWseiNKlN8BA8Ae68t33as
         rs55dMsHuzudHz9dD0FUAjV81thfzRqhQhjbtz0WZj1svwmvthtr0nx/LNW0bDip1tYX
         tklg==
X-Forwarded-Encrypted: i=1; AKwUvByHPO23fSAH7JaMxq030hzglI4SVI5Nv6Ht28DDAI/LWUuutCezYz2NwuOhwVxtiRo7VomyFkY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAR+M+mmVrNGuzkOKDz1e/1H0L6g2yKdr5Zx3+kn0TnquQx3I/
	kQZQdMtymyx3fKwMmqyyM/ezlLCJPLFSKAvi720hp1uQ+e4X6r8bp6F8
X-Gm-Gg: AYBFou3BHhj1TE3u2IVvABSMnAVgiPoUwKt/hd7tUQ95qU12X7ubdQSJ9NdSTt059gN
	W/9ZH8aWSeTB7iaoYyN4gpn2cjgmaGkgsJpdLtlQdRstVyVkawwawpsYxCO5kDH0+cONAkwN8x1
	HXfpN94cZCN8vpfZ0p7gSnulQzujN4fc52S3bHsIBh0Xw4rtWtUsolU5gjdWpZiKdQk4Wk3o8VK
	Lpd/hiK+LUMcYbi4R77nD0LARn8Z5C4PeItOq3TPYIyEuBTaarxW3ZgFtE6QnYLkYWnagIibSpG
	ANqy0tagG9z5iJCcTx9R3o4nNVktFkyGQ2/eVT9C4fuKkaGhEMl+sJdbSkKpUHzp9qJcb7vxm0Q
	eQTrKrybV16MzDTvWurahA7hCpcRw9ozP28BbJhHMwmW0dfs5NI1UDw5b55NOeA9fG20eNEtVjP
	A/DVw2LUHpaqp/mmjRRmN78dZ0t/ZGUMlSqBNz3Hwd/uvBy+wpNb4fSOoiMcx0xMLUr6d9ew==
X-Received: by 2002:a17:90b:164c:b0:39e:6d82:dca with SMTP id 98e67ed59e1d1-3a098df465emr13963048a91.30.1790667440494;
        Tue, 29 Sep 2026 00:37:20 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498ecc986sm1328708a91.3.2026.09.29.00.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:37:18 -0700 (PDT)
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
Subject: [PATCH net-next v6 2/3] net: stmmac: guard against a zero channel in the aux snapshot handler
Date: Tue, 29 Sep 2026 15:35:52 +0800
Message-Id: <20260929073553.4136336-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929073553.4136336-1-zxyan0222@gmail.com>
References: <20260929073553.4136336-1-zxyan0222@gmail.com>
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

