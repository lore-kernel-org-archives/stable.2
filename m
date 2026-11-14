Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663407;
	b=YoL6WbXByh76LYxQWoSHbHUi3wyeO1xlmsvf7wj2PHQZfqLRJU/uCRB2emrqnI4V4pcN
	 BncKtxXgatnUeKV6OfbPgqVRep5y7tr+W2ixdziQS5rLBKTNW6R88mnmZWyrmBhenPbbC
	 4vPVYWtbkezan3v9a/glatfk5GwMIEidJpk9Z0Duv9fjwKaxNRdBRzcIJ0yJa2DfGoBGe
	 6Iz4QmPrO3ypbDEjOHUvVnyxuPBXYZtN8dEcNcYg6pWbHEE5dbAOrX7chgmuXBEY7GE/l
	 LzRwd5HBJWENHFfy0dFEMizcMR72d/Fi+CleqFxZrY/ZGn6svk+J0g1DVlJQHCUH39Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nxrZJxHUg2O9j8zi4wkVtSZmuc/DWB6+tE9tT3nYX8c=;
	b=XDflhiSXZEPcGIqxLHdpfXd4Ihf/W7gqbvySRX/LiYlI+1YN8pQQPld7vCBgnctgQ+jy
	 pOQ9xWauBh49SaSmv0V9Lj22ye1FQ5d80+8ou30sY41JgsD/5p8jN/kQHjgFxEyBEHldz
	 RhfPPUalIZSxGPhw0aYJLtRzahNTD5VBbLB04o6/LwZoraqoTh3jd4tcqDoQVSR8QL0K2
	 MY7CrbQtBQFmdBbddRMcg45U+xCdcLpGpdLe18utK06E3Q1+VzvXcUl8sFWTdHWrFk/3y
	 S6iPx0fvsMcEL8jRnWEW9R+lxVQ8ANUlDZFhhRpMa4XDcB7I0fIVwtcb6wr0dmkST3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	dkim=pass header.d=grische.xyz header.i=@grische.xyz header.a=rsa-sha256 header.s=google header.b=MNy13gTL;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47579606A88C
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 13:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47579606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grische.xyz header.i=@grische.xyz header.a=rsa-sha256 header.s=google header.b=MNy13gTL
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso739417f8f.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grische.xyz; s=google; t=1794663406; x=1795268206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxrZJxHUg2O9j8zi4wkVtSZmuc/DWB6+tE9tT3nYX8c=;
        b=MNy13gTLmC76O2NwWxzMLq2bD2NcAS2Lmb+Fa3QAE5m3tgPQDQl/dmDgGSBdSkVSXM
         jo7SSTHv6JwLuKfNswjxK4G+NRrtPwxEFluwI1dZ1LCBs2oAjApsc2mI1Apv+ilRrROY
         K46icOMtrBYmvhpyDkK38wTxSxfIeRGUbx6Fr8v8CmvbnTTlM8I4Ou+0sEivLrrzS/8N
         R9OKZ31N8fOJ5RtReTqWfpVyjMlpwrkDQiCLrzuE1wjnedpYqztGKEPtAV62PUFHoTIB
         PPDQur2xPCsj+0uWGKSMxDXEpQRrgpdiiQMlO2m0nzR6hC9dpNppZyzFw9myK7+h01q5
         soAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794663406; x=1795268206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxrZJxHUg2O9j8zi4wkVtSZmuc/DWB6+tE9tT3nYX8c=;
        b=CvBz7sXvoQawI3ZHTFN0WHkI5ffGv8iseRNYbU04zlg4fnY8J4+FpwlweYUHQoRwQg
         M0rBhR3TV8Pjl5/GtwtgxLuGucYAZfqamO432yTPLWeSs/IOI1dAv7FRk7MLOlEWv/Y6
         Vid/Dke0OQVRSaErlJpL/+17ZgJZfDQa7vXEaCk4U7gKqP+sV5vOCwhCNFb6ze2M54Jq
         oxuw/iowNTRtl6r7WoYyMWdag8kFxO5x6pw+JfFbnM8XnwHVjv9wq6eKvRxOqED0Sti3
         pndlVP3n4wbtfp/PzwQPqmaPOmgDo9jd6CKgKrIXK/6r8aXKDt50mH3MA/JzOA+CBPoM
         WHjQ==
X-Forwarded-Encrypted: i=1; AL+hErEHFwrVjS0lNkFQdHWW/ZhNQeytAdSE/4Btqywgf6m1pna6DQP7jOglzCNnQq8ksWq4etJoUV0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zHH3Nxa8tiOFY3iK+8ChfMGjXhhkq/waeF2nRUcKNj3KwZNOy
	TnUlNkE/8LMdjZ2ezxmh25PiWw+q/rZtFM58RUmozI34Lovq7/h1IkE8UZa8Uae5Epw=
X-Gm-Gg: AYBFou3V0FrZAL8CDLrPTviESOb2WEx+BsCH7+YiRG5oFZR1cSqotWqdjmYyjBXVM6M
	LyRUCWeeQZ0QgERxdno1QWeQDJvob7bnbzwnJ/DKbJVLABPvUbwnUYt/q46d7XfRpnHVyuA5bkn
	vfY6WsWgw6dWgA8E5WrN/rsO3FrS3q4HkgIvvHQAGSSxAQtGYoqNi5cqZjnNMXTHEgmmkZpjRD9
	bK2Y1cxHa/1sfiRId6LjEp+eeMgLe9PAFwyf1YREyT0PmQx5NuRyy6cxk/OFVnBlu/V+x/mEDcd
	VQUw0ueVGpPtiss0B8a+WWk009WkaxJfkVX7I2D34OGkQO8oSHWB6KOpoiNwMu1JxhiQnXcmHhE
	Vj1CjfW9brQWXVUUrd30QA7RjFiYsRqlFB0mvkGdU5+eE4ir3SR6wnlb44iPEhpVVJDSTdl0ksI
	jVCdJUbrkZQq2cWdg2VfGLcN9FkZU4ZEoQcR4tvG7T/P+Tl1e7pnkq+Fv+mxL1/1DwAxvo6ACay
	Op0kxt3w9e+u0qRnL1x+0qaQXg4oDC63MFekuoRCQdMjHrl+hu30UPOJHr0V0x0KluGipYIMWQb
	u+1jHdvEIaPxeZ1VvYYS1zQ5lw==
X-Received: by 2002:a5d:5e85:0:b0:48d:f391:5c45 with SMTP id ffacd0b85a97d-49c740bcf7amr10850377f8f.42.1794663405564;
        Sat, 14 Nov 2026 05:36:45 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:1a41:5e41:61a6:f0b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d69c21a17sm6657866f8f.50.2026.11.14.05.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:36:45 -0800 (PST)
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
Subject: [PATCH net v3 2/3] net: stmmac: dwmac1000: don't discard frames with only a checksum error
Date: Sat, 14 Nov 2026 14:36:38 +0100
Message-ID: <20261114133640.3285413-3-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261114133640.3285413-1-opensource@grische.xyz>
References: <20261114133640.3285413-1-opensource@grische.xyz>
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

