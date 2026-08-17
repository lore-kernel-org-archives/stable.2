Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C943C7DF
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975059; cv=none; b=iHP+ikbeevj2HZ7qX09SlDrNwwq6IlABzdsDCe1PXokbBtiWM6GZ1hRzQ0YbXM2M90jDR4FJGwLij23fDdJTpJ2z5YQKa4zuLCzwrKTyTTDWfMNNbo7CPLSlvfra7UdUoc7HFSeiqPSz8d4YyDyvluPW/NmK9gJGIlTSyb/Q+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975059; c=relaxed/simple;
	bh=PZI7MMxmJVNzbmV5bnrz48F2Q3n5UxIGaRjcpiHxuHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQN+byNfwPrWNwiqHmTFybP6AMzSeA8I7Xs9i69xxgupZAGs1VT7aYZlMrcRpCxSNJ05I7xyX0beYrjsmczNzrj3jJBz2NmjgmfS5fz/BB25T2fXMLqtdUYqm3uVkbTJnBDOyICJUxds3ga+Ua7UUVoBy5hBzq+twa0VLTO4iZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=soundtrack.io; spf=pass smtp.mailfrom=soundtrack.io; dkim=pass (2048-bit key) header.d=soundtrack.io header.i=@soundtrack.io header.b=tEpTIBqH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=soundtrack.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soundtrack.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soundtrack.io header.i=@soundtrack.io header.b="tEpTIBqH"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69fdfd98eb8so471374a12.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soundtrack.io; s=google; t=1786975054; x=1787579854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLmqosVfHRUnCpTXG/vmgJdRPIFeEEdEr21ji49UgUg=;
        b=tEpTIBqHOBDANpCGB3UUeUWv7fsWbUyEVdhtcDtwO4ow2BV1/qXXoNsn4KpTBZceNS
         +epRX8gxHhp3p7jD8atP/eTILwMrLYloFOlBsRqnmQK7pK8S/VQaeg1hwZtNyAKdqKbW
         XhxA33Er+1OhNraUijNWjhKECGmKgR5Hjaqsz8TDqZOlZ/WmWKjpS8eZ/SpVAHXR2DvK
         qtSS0NCcAyYCwKi4zaQT5w9kZc7bvntfyunBiIIckGK5/3/Zp1t3s+aL18avXya01HuK
         nXvhhAvdM5DohQnoyNoi3atR92f7m0KTP0MOgmIMF/GfDw/Mzo2K3xoYdI4PjEkG0hqN
         V/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786975054; x=1787579854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLmqosVfHRUnCpTXG/vmgJdRPIFeEEdEr21ji49UgUg=;
        b=NRiP7EaY21nrkAY+o67xxlD+2a3wl8+bgNTT/2oQLCtFcSLVHFbwbu6YzoQxq6PxZ1
         gwU9NkQgair3eq/1zpsUH490/KSIf87QrtD/nng3mX8IwEl5ldTVCXsh1vDCREbuiP6D
         2gFRH+dvTXORUOxRO6yqSfVPTE8wK4ZC1RtP9PomVwv4v3dgyiWYPetC2gZskVyBu1WS
         o8R3HJXvA6TonJqSdRiogXBysD/23GZikO5Q2PA3GNLo5b51sutQdkWsrgydjLc7MA/m
         ToSOQTQseZNlLEZTQYdu8XIi57I11+H+7onP6B30A61lwsrF/JL0kYyZQNOlZNYOstYp
         qVjw==
X-Forwarded-Encrypted: i=1; AHgh+Rptzfvpqvzzx3V6AZfW0D/OL3CRpviRMJWKtJ4B/ryXWq+eYS1xM3bkkHhlJFJjyuHQcAM0niQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA73tEOkysBdTCSvtXwdOE3Sv8fvFDh2a1o+waQhSz4jHC1/hJ
	FEy0dvHrbr3TI/YLQNV+c2SraMqa7IrYby9ItjE0Et2uIvys2WYnayKEyz0itBGKoxE=
X-Gm-Gg: AR+sD13mubUVejH/A6G42QJJkL143GHfZOz3GiNt4XEWAwReYQimWp44fGr0KAVIxq8
	n0zBnyjKh1WUCyrkWL5usOvy8G/HWrFAVAI9BRDj65/VhKwxJOCUsnKpr2f61Sixm2zI/rawJ1k
	2cVQ7OOXQrStCUgH7VwoZAKcat+AzvkkKpyERGosq3Ranmhuk+vbkkjjF2FoJaU+8Atx1z+amjL
	Kc6etWjCOUqPCR2IT237NZIxNIckdw3hii0N5x09OkA+z34tUb/nEDrTo13E5R4uAnI+IZtRUEw
	n1Gg+lO3vWl6v0Ni0sgVFi4sAPvvFYVLvi+3vmM+3asEjHPcgPMCahdUlT1pxuQhTxB1E+bNpXF
	6kVQ3Jy0kuDdp+7El5TwSiUDocij/vBRLsRSvtmUUw6vGXi/Y1sbmwyTloPPFnypUDvAnnD56+7
	2GfZKphgCD7QlWIGvvmDu1TGuh+LBWM0a3QEIdhomf7MwLDZ7njy06/MFNGzYc7t60bSolxlg0n
	0LVwWdq/eUTmsbZxaWplMFA01AGkb/NvDfnwjgLqd+4uLqHFN1NBd90nno=
X-Received: by 2002:a05:6402:234b:b0:6a3:68c2:9a9e with SMTP id 4fb4d7f45d1cf-6a38a845a42mr7135042a12.0.1786975054047;
        Mon, 17 Aug 2026 06:57:34 -0700 (PDT)
Received: from Mac.localdomain (31-209-40-223.cust.bredband2.com. [31.209.40.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d85319b1sm810238a12.13.2026.08.17.06.57.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 06:57:33 -0700 (PDT)
From: Christian Lugnberg <christian.lugnberg@soundtrack.io>
To: vkoul@kernel.org
Cc: Frank.Li@kernel.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christian Lugnberg <christian.lugnberg@soundtrack.io>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] dmaengine: sun6i: fix non-atomic read of DMA position registers
Date: Mon, 17 Aug 2026 15:51:22 +0200
Message-ID: <20260817135723.12807-2-christian.lugnberg@soundtrack.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817135723.12807-1-christian.lugnberg@soundtrack.io>
References: <20260817135723.12807-1-christian.lugnberg@soundtrack.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun6i_get_chan_size() reads DMA_CHAN_LLI_ADDR and DMA_CHAN_CUR_CNT in two
separate readl() calls with no synchronisation between them:

    pos   = readl(pchan->base + DMA_CHAN_LLI_ADDR);
    bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);

DMA_CHAN_LLI_ADDR holds the physical address of the *next* descriptor the
engine will load once the current one completes. DMA_CHAN_CUR_CNT holds the
remaining byte count for the *current* descriptor. If the DMA engine
advances to the next LLI entry between the two reads, pos becomes stale: it
still points to what was the next descriptor at the time of the first read,
but that descriptor is now the current one and CUR_CNT reflects its initial
(full) byte count. The subsequent virtual-chain walk starts one entry too
early and accumulates an extra full period's worth of bytes into the
residue estimate.

Fix this by re-reading DMA_CHAN_LLI_ADDR after DMA_CHAN_CUR_CNT and
retrying if the value changed. This double-read pattern guarantees that
both registers were sampled during the same descriptor interval. The cost
is at most one extra readl() pair per call in the racy case, which occurs
only at descriptor boundaries (~every 2 ms) and is negligible.

Fixes: a90e173f3faf ("dmaengine: sun6i: Add cyclic capability")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Christian Lugnberg <christian.lugnberg@soundtrack.io>
---
 drivers/dma/sun6i-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index f47a326dd7ff..04fe1f5042e9 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -354,8 +354,10 @@ static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 	size_t bytes;
 	dma_addr_t pos;
 
-	pos = readl(pchan->base + DMA_CHAN_LLI_ADDR);
-	bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
+	do {
+		pos = readl(pchan->base + DMA_CHAN_LLI_ADDR);
+		bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
+	} while (pos != readl(pchan->base + DMA_CHAN_LLI_ADDR));
 
 	if (pos == LLI_LAST_ITEM)
 		return bytes;
-- 
2.54.0 (Apple Git-156)

