Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805572;
	b=s5Jwfd0td8wCzM6Vt/ykEySGeW1zPtFoJjPMsqDWpwjDh6EAbvLjJNsvfh9Q8M0ZCbeH
	 BwWq7yN+oZr6SlTTy+GTvLmbciprj9qvTp2CtiMi2Es/X4cDDhEd4yn0Qgw+22hqfqsKj
	 0EhaTDKu9RnDO0KA8f5fYypydveedTizTwYYBLp0xYoyhEPNCMPpQ7SJGgo/PDCQriFy4
	 uocoLmpxRJCkaCbBq6K6WqVu0Ooy3Wk8gefAYWyU6nKk2t31m3V9kmPqhKL5M/zkOkbXa
	 89T/AOrB1TFC+OtzrxX98RrCxMlMCg4S6dcqGv99g5T/YPELU0x2X5Dz5H2dT15yMBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805572;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nxrZJxHUg2O9j8zi4wkVtSZmuc/DWB6+tE9tT3nYX8c=;
	b=kmwsOu4mEYxXkws2w2qKVxP/SzIGdcPEF+00R/U6r8WRZALk3SIqJcbmIZuTTPxUGu4c
	 2MIpjNmP0shKxSKYVhtfcAYMJpnaTjqQFT6nKun6FpEtdu8H+mn52ODHKZWb2HBYV88Xv
	 d+kR1ZBwV1Vs6vg9H2aCkkAXW0mXppB+tfVAmo5rXsWV5S81+yBTyFA6WastK+Ihyzkh6
	 l3ttbhvUkB6wXkyjP4TvHbN//tc/BjSXoo/JVA6qQ2x2etBYTekk3IRt7ofLMcUVEAhyN
	 N6uVATNn2j7xfrCDIHcJyIsBtQB7mY4VoSA+jf/LrVxoaGrd/p/bI/MIWXVZ8OZ5Ysg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFE606EEBF
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBEFE606EEBF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so7036565e9.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805570; x=1794410370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxrZJxHUg2O9j8zi4wkVtSZmuc/DWB6+tE9tT3nYX8c=;
        b=SwEFWJ8xBbTcOEQ5wmpeasteWP2e6K3XHPxx99QZ6cC3YWLePLheZOuB8HGIvgt6ka
         C1OlgOYW9yj+8hTUo+KtTbLE6n2nU2+6J+PKnjWG2nnv38ARvzmq2n7KHRIGhrtThTrk
         myWJzNQ1VoKj4a+foV7M95X18W1R/s6WCbafpKjY4rMlc09vsXLKjyuVA+Sw4Pp2f2o4
         Ytl8X3zLN2we+Ti2ewT1n7SYrMHVV/y8lroEUc664Oo0sr50IurVXDDPYxgjf1Dw37sR
         ybvIeYIoR6gbKLRKdWK62b3Cde2RLkykxt1cRLfVCmSNkqtnEFkZ3QLLH0DRRqpkI7vK
         EcZA==
X-Forwarded-Encrypted: i=1; AKwUvBzJdKRmd4aIxTA/GJD1oxA4rg3QkbYLSUHRngp6LFImyDHSHJx7Tuuhc7ut7wXtHLU4e/mdMAc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+1G2SspBhb7gJpggM1dDkX/2JQ7zR8oHMx15cE5/1C39WjVom
	kBAn5Ugr0J1Bax6brzkXkSv/GHIyHB7gARZkhFWXhJYjIHs7WfGiL5jL7Nmd1wyh3Yk=
X-Gm-Gg: AYBFou2LgspRXGHVHAJeKXLCq2OW8cYjOK8yqugmwfy2UST3/mhzNA8gPPelOfnRWyT
	S8oxrl5iUBBFKOkBRsAlBTSJXRShXBxVdaImY0PDqnBaRbEig9aVANY2B5W8zFNioT8RiUftE/g
	9eiu1ILBKvNwtsj/VJ8tYD5wHD8PZvz/B35Mtw+qELvUp/Oy0BHQhO5dNFdbf/ESav2w5aOJPxo
	IYm4dqP/gO+ZT+zYO0szjFsPJJ0Tj8s7FUVMiWZZ+yIJjWDPZzcq6yHCH/HtsV8PHg1HAN/sY0y
	5h8f2/FpKqIWczopMtOkDjLrMFJPV97mRlEZnoP4HQrCcdCuT3IAeaRg7qSQqWM+6p5D+tylE5A
	MNKqwktzYoyeqbXyAoypP3OKGNh6VzWe32n3dfiMOp5yByaXRRfjqMX022X60qhHVhlgn/dXCuc
	MiMRt6SUih2tDmNkpXR/9cX+0rDTuxPZ8qGm2ZWGR6iqg5QQpfhD9O1nWRgnoEjR1tS77i28dSX
	Q23PEK2whotA3bhKcCj8aEtmpRiCYIJkRdmNdsfGy9y3H0Lz1pNZ1JJXBxubic7TVSijHWtqKSb
	hZj6fO8mOMzYu+qhy4GQG18X/g==
X-Received: by 2002:a05:600c:1f93:b0:4a1:de8a:603a with SMTP id 5b1f17b1804b1-4ac17ffb002mr392967005e9.6.1793805570362;
        Wed, 04 Nov 2026 07:19:30 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm4639812f8f.19.2026.11.04.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:19:29 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Christian Schmidbauer <opensource@grische.xyz>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@nokia.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/3] net: stmmac: dwmac1000: don't discard frames with only a checksum error
Date: Wed,  4 Nov 2026 16:19:12 +0100
Message-ID: <20261104151914.2651241-3-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104151914.2651241-1-opensource@grische.xyz>
References: <20261104151914.2651241-1-opensource@grische.xyz>
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

On dwmac1000 with enhanced descriptors, the hardware sets the Error
Summary (ES) bit of the Rx descriptor not only for L2 errors but also
for an L3/L4 checksum error. enh_desc_get_rx_status() returns
discard_frame whenever ES is set, and since commit 1b746ce8b397 ("net:
stmmac: don't overwrite discard_frame status") the checksum status is
only evaluated for good frames.

Return discard_frame only when ES comes with one of the L2 error bits.
A frame with only a checksum error is then reported as csum_none and
reaches the stack as CHECKSUM_NONE, so the stack verifies the checksum
itself. This matches dwmac4, whose Error Summary bit does not cover
checksum errors.

RDES0 bit 7 is not in the mask, because depending on the core and on
Rx checksum offload it reports a timestamp, an IP header checksum error
or a giant frame, and enh_desc_get_rx_status() cannot tell which. In
threshold Rx mode, a giant frame that fits one buffer therefore reaches
the stack with a verified FCS.

Also remove the pr_err that enh_desc_get_rx_status() prints when bit 7
is set. Once the MAC stops dropping checksum-error frames, any host on
the link can flood the kernel log by sending frames with a bad IPv4
header checksum.

This prepares for setting DMA_CONTROL_DT, which makes the MAC deliver
checksum-error frames instead of dropping them in its Rx FIFO.

Fixes: 1b746ce8b397 ("net: stmmac: don't overwrite discard_frame status")
Cc: <stable@vger.kernel.org> # 6.6.x: ee0aace5f844: net: stmmac: Correctly handle Rx checksum offload errors
Cc: <stable@vger.kernel.org> # 6.6.x
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
v2:
- Drop RDES0_LENGTH_ERROR from the mask of Error Summary bits. The
  length check further down already discards such a frame.
- Explain in the commit message why RDES0 bit 7 is not treated as an
  L2 error.
v1: https://lore.kernel.org/netdev/20261020190319.884375-1-opensource@grische.xyz/
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 7ece8d4157a8..d0622f2605aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -216,9 +216,6 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 		if (unlikely(rdes0 & RDES0_OVERFLOW_ERROR))
 			x->rx_gmac_overflow++;
 
-		if (unlikely(rdes0 & RDES0_IPC_CSUM_ERROR))
-			pr_err("\tIPC Csum Error/Giant frame\n");
-
 		if (unlikely(rdes0 & RDES0_COLLISION))
 			x->rx_collision++;
 		if (unlikely(rdes0 & RDES0_RECEIVE_WATCHDOG))
@@ -230,7 +227,10 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 		if (unlikely(rdes0 & RDES0_CRC_ERROR)) {
 			x->rx_crc_errors++;
 		}
-		ret = discard_frame;
+		if (rdes0 & (RDES0_DESCRIPTOR_ERROR | RDES0_OVERFLOW_ERROR |
+			     RDES0_COLLISION | RDES0_RECEIVE_WATCHDOG |
+			     RDES0_MII_ERROR | RDES0_CRC_ERROR))
+			ret = discard_frame;
 	}
 
 	/* After a payload csum error, the ES bit is set.
-- 
2.54.0

