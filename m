Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796649;
	b=BQ1CnUSrqw/qLvr9bi80jbc5NbcZikTmPjthPRk2RUzNsyAsKfMGhxe31zj5GgutyxQb
	 JyyfpvJDDvsHKmGUupd63h5UPjVVzgHgkrOxuoUMesDx7dwNFVMNyZ9g/ubwm693/2+Ki
	 QVbny3USLnWfDMFeA9g2Bg2kJfXhn1b/f6OD7bhGyoW0bNIIdHukjkJuX2aD83h9oLrSK
	 TMfXjhSrGuAYZGua9UPmbxuE1qjp4rwvI3D7QsjJrM4i8DAf5bIf9K2giedxvQCsqAC9G
	 LExNHAITktn/NkL3a06IuTqCJxMSFSD24BrDP81b4vTWMyUORICbbMeKHJcBNsD/Y1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wXHNHwyHqZyMWvC89h3xRMVsL0F7PlcQnNFtH9sdpDM=;
	b=1UTmT0jS/FaPWA4jxbK99/Imt/kJGtDRFcIJczd4Y3J6i2g0Jd8UyDw7ggx4qMwLbYBr
	 m+lLdGSpGvND03Al9Q15XrO2eKTYLFBOyxgRCtWq+nPqVEvy/GBa8CtLCfD1vSAKcwoez
	 U22RpKxxBgFOF+AdoZJJCLECCFM6lLVujzrygbguw20J1x+CsGajx9dICT62ZmG8aAUDs
	 d04J79MKcHIw2gm9Z8a3wPXHvlNXYJAdUVp4XvUqMsZrmXjTZ3wRIaV8QkQxEJfHFHGg6
	 L/J6w1VNY/NcEc9AExcH/R5NTzhZpGETN8TSkJ5IR9MHHFzXDZ4drYSLwLgJ37vSwBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NhZN0Ywz;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE13606D804
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CE13606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NhZN0Ywz
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so491474a91.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 04:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793796648; x=1794401448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wXHNHwyHqZyMWvC89h3xRMVsL0F7PlcQnNFtH9sdpDM=;
        b=NhZN0YwzBH7ZrkgsGG/YF8QhTT3boEzosxnAlYxL0Mfs4xCz9Ik/mIck/vCG1BwJEE
         J49qe7Ic5x1qY+/bU3EYoLqAfgZT4zLbQPc0nHThPrd3fInvj1X9JT663kl2QF/g/BZb
         zTrlkgd5yhiOTJ+/jCQRx+wZ27KiW2+Fp+EPfJS6eX930Bv74BQrIYl1xOp41AS40nk5
         eKV8jPf0x1e/0kPx18pGo0WtlTNUpx3O0/AizkYdFL4QViI8ubbgCEZHnGmeGYaWgxGx
         BNVEv6B5oNBdLSjqKlmYiCUeDXUTVu4lBWiv/kkT3owRAmhjGDcZAMJYKzvU4elLNUgu
         X+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793796648; x=1794401448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXHNHwyHqZyMWvC89h3xRMVsL0F7PlcQnNFtH9sdpDM=;
        b=JlSPhao1IzrWRQkA0bLXn5yzGiwjhxeTfRNGmVahiDqlB/V+DnW9wF791jVQhaPXcO
         jwALMx4UAjPJrdZSy678UkpP3AYENJjbtKng/wc6njIgQS3feR8k8Z5x0ZVcwdPQ3xL4
         rRIkj5sE0MKVRKSbFW1TUNKzSx7rTerMqjF3NYuRG2t0VJWTlhgJUdTEPE4JSrtsA0QH
         GI0A8Kil0xLG6FW4NanCZIzAWrWeTomMDaKT/GqCXKmbILZymPhjkxslD+u6KNhSEwJA
         xEl9UKl+8rxqpg26P5ykefqV4KsSxVfEsBslkdyrA9Fdrh/hMovXRdIGGY6cdRfBNzr5
         QORA==
X-Forwarded-Encrypted: i=1; AKwUvBwbcTSiQB6CEONb0yrDaCknlHFmsF/e41o/+Ysbm5Bbpa5mVp926hKshjVFz4COnhk80bIwxgA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9d92cPOZ7Rp8qeNg6BlcN9V1UVkAQpYuVY4B5i4b6GphBrls9c
	3Ak9ps8tUzz4sdl74rhFGSVrLxxUu0aC32yzQxENR66IbCJIlKBinsh2
X-Gm-Gg: AYBFou3Fb9eH6FwCF7ixW8pE5g6QWsn3JSmoJwJlf6nDNCVVzHK9NRLY7M5N+L8IUwg
	zT2dCDzTbHbA/pZ6LDvol8rZAToU5+9nDxtmD37XHDA8PdEDUzw5R4fJ3TV8PEx/XB3J8VXSVIr
	ib+qvue5CWwWC1nfC4nsfbHXgUrCQF9f/hXrDq9I0bftiNgdVkhjBPBRn7iKGvnDimr7fYyjtcx
	I0T7P7bEDBUQK+dbaQQ/kgsUvqqO32ZvLPkfTbNn5vBKbTjkC2l9HgGLHGp48X+XYJ789nPT83T
	UBma6H5s5d0Krl6eJP+QafZVJuwstpq6bPL6aAjcwVXML6QcEErIdR2kaWfx3pERn9rnoOy3I8h
	RF2XlrdPVc/kHyEqBb1HoGJLpsttq1L9JvmeqvZHI+yf0jeGc9sOXjENors4wcxK/D9Os6pBmQG
	fM4W2CyHqrD+/GzzIucxvul6oWmq7v2Fc9T0s0giPNeLovmqDPbX+orQ62x3gxw9MDBNAoSk6VC
	vsHTtR9LM94xXNyeNrw8+TpX4D9Gt6BhmXBWvGHxu8Alo3s4ws4vfSvWgMAVrYwb/jPhr1oTq/u
	lAczogsWU3O5ggSGlNRFXKg3yS3y
X-Received: by 2002:a17:90b:4c52:b0:3ab:1481:69e5 with SMTP id 98e67ed59e1d1-3ae897ccbfdmr13704831a91.11.1793796647941;
        Wed, 04 Nov 2026 04:50:47 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09449bff2sm3920799a91.9.2026.11.04.04.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:50:47 -0800 (PST)
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
	o.rempel@pengutronix.de,
	wojciech.drewek@intel.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v9 2/3] net: stmmac: guard against a zero channel in the aux snapshot handler
Date: Wed,  4 Nov 2026 20:50:29 +0800
Message-Id: <20261104125030.1183146-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104125030.1183146-1-zxyan0222@gmail.com>
References: <20261104125030.1183146-1-zxyan0222@gmail.com>
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

