Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82F360EF7
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238000; cv=none; b=owYecSS2tIKzrzlsAwXOPPudxToGvuyoDciDJVdXhSL/lJj14K9cqM6Tjdtr2IkVhhihgUpPl4ybsgHZk22ve5CITjw2xmReb2o3EfQ0Bjrdwnb2CgzTnbi8HY38gunv03UoHIC9gvPxBEpQOejCcgNWD4OVb7QwoI36vp1aGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238000; c=relaxed/simple;
	bh=V251f68AK2V7fciivPQ3/BNfSprJGGjRz02NZzkvc9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ln3z5YxdRVamLCcqYlXyT8vkyoXqpMRTB4hrB2s8UCdrKz7Ke2PmOKeab2uFn8nprI82cKnLNUuy29wW/eHpWzgTPB+SeJnudX/355oOkf3ZMxQezUvp27Tnsx7aedxdGepRFHgcOxG8JnDFyHNy86TGLzuEfiiJq6zaOCJd0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sO7zk+53; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sO7zk+53"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e44so806991a12.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791237999; x=1791842799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JTKWejYowm2p4DJaJvyyuvQbEpNVbY+JknPKvn9wkJo=;
        b=sO7zk+53ykV2XWNu41c6R1tEIaGqsYLAraUqTSqbYEFfDNYoDDVt9/o73U7eNCLmw7
         PzgAlGVjCoXzEbDmlulF78XmMblyYXu1m7knHqfyyhLGGGKtwur0pUafAfnfkJ4py4yl
         EAIm15MkddaZj/iQnGk6MOAPIT+eR+PK8f/y/DFF5lUFw1prJKM+bK+prAGTbyCFyLcH
         XSMsqFMAqQSxQ/Pm0hS3GAcz9wwcc6hTg0c6naXp6QA64XLshWnHMo0QdzSm4dNNSLQD
         KzxYO9/wJ/2F04LM1ssgo78ZvHAfFfFtOMOhjOXOM59icycGAu5cVPpOPpoRLPJQzxh/
         RVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791237999; x=1791842799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JTKWejYowm2p4DJaJvyyuvQbEpNVbY+JknPKvn9wkJo=;
        b=w/odG/nMwVkQP/ImjCkD6lFYQTCglhM+AAg02BU6oQ8ST3r6spQG66StGXZ4gkE2og
         rq4ElPQrV1wnszZcwMhq15pTyq0zY8K/yFoAWbCNCeCEZRbG/6Tddr2XzA+rq/3wna2N
         Hit2X96sIijqulCtB00zdHbh5aBxmRg8rqfsR7E8uMMndvsJ7eAxvAGEn5xGLMZpi24m
         69Rq+A9qYgITpHfdOX3IY8uFs0XcnM8NBqg0RRntaVSGYk3tBRSSj1qufje6Vj3D3Qgy
         K3vZvkDNY9jI2wKsSe/1eb8mEKAT+ctHZtinNX09lP3SbNDc1GLDTRayYdgEHsR199LZ
         tOyw==
X-Forwarded-Encrypted: i=1; AKwUvBw5lj7YaVToMl5aumzUxIBC+ElLDOfnt5G9aMacL9Ea8jcRTcPRoVSUubj/CgQkk0XhJLm3Pww=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMARf3FY0KQDhXKviuATtNpLoh6OGIFYwEL89kWOyGN/ni/ImH
	OcpEZYoPhWqjneuvPwInEYB8IJ3NlV8OKtalDsZ5nh3bC6kKyJDYQ5Vt
X-Gm-Gg: AYBFou0dE46DGQAGJzg++4CCxkqjP+zPcorzjDNN9peQSKCG3Nvy/Ikg+fvMGHOTRTM
	C3ETcrBI2jqZeorX1dM3frO5X78UxbqfQN/uClHFakdDkGZSpmEOzUt9ChtoK/bbJWHjTetc36T
	dpP+fP4C13xU2HztWI+NwSW+HmwRHw1m0TBetXfWUiuPyG+mUW8M4FEKVwSonPGmqWZRWj6SYhY
	FRA5rfJJT4ke1n0YEUrIqi0NVZRoghw4LGZbFaz3z0vB3wOyyul6T9B5CoMMl0sPV1YZXGdEwqv
	KzlA2lmgAuhGuWS96pGgFLPzyHHgza9TZnPNDHAPJ/vsPrJ9FYZFTPiApxG2NDoo+huKlDMgfeW
	LNNCUi/Sdw8OVtfsYQ9unlabYvOZXxlL+XODFp5j5G6YKRlnumlXXF0A6uIUgnQQSg3XIbS/JcO
	BqHuLGy/DoQPIH/xrMXHqfsI29yX8F1pybXlPMdrRybn/HzcvGoy6igHxzvj7+J3wk/FqZGaEyk
	D0f18v5wzVlzfM7gBgDI0a0noqk0+eY06foTWMYLt+eGfmnjFDg9BgEk5nZj+zP
X-Received: by 2002:a17:903:191:b0:2dd:c053:d741 with SMTP id d9443c01a7336-2e49b684cffmr118013695ad.40.1791237998457;
        Mon, 05 Oct 2026 15:06:38 -0700 (PDT)
Received: from LAPTOP-BEQ9FFIS.localdomain (60-250-51-133.hinet-ip.hinet.net. [60.250.51.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ecbdd3sm13723035ad.48.2026.10.05.15.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 15:06:31 -0700 (PDT)
From: Pin-Hao Chen <billy920225@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Mark Brown <broonie@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pin-Hao Chen <billy920225@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: stm32: fix double free of SRAM buffer on MDMA fallback
Date: Tue,  6 Oct 2026 06:05:28 +0800
Message-ID: <20261005220528.7199-1-billy920225@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the "rxm2m" MDMA channel cannot be obtained, the driver frees the
SRAM buffer and falls back to DMA-only mode. However, sram_rx_buf is
left pointing to the freed buffer.

As a result, stm32_spi_unprepare_msg() may clear the released SRAM
area, while stm32_spi_remove() or a later probe error path may free the
buffer again, triggering BUG_ON() in gen_pool_free_owner().

The probe error path also checks sram_pool instead of sram_rx_buf. If
the SRAM allocation failed and a later probe step fails,
gen_pool_free() may therefore be called with an unallocated buffer.

Clear sram_rx_buf after freeing it on the MDMA fallback path and use
the buffer pointer to determine whether cleanup is needed.

Fixes: d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use")
Cc: stable@vger.kernel.org
Signed-off-by: Pin-Hao Chen <billy920225@gmail.com>
---
Found by code inspection. Compile-tested only (ARM multi_v7_defconfig,
W=1 and sparse); no hardware was available for runtime testing.

 drivers/spi/spi-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index be88e62075af..605b847d8773 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2511,6 +2511,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 					gen_pool_free(spi->sram_pool,
 						      (unsigned long)spi->sram_rx_buf,
 						      spi->sram_rx_buf_size);
+					spi->sram_rx_buf = NULL;
 					dev_warn(&pdev->dev,
 						 "failed to request rx mdma channel, DMA only\n");
 				}
@@ -2548,7 +2549,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (spi->mdma_rx)
 		dma_release_channel(spi->mdma_rx);
 err_pool_free:
-	if (spi->sram_pool)
+	if (spi->sram_rx_buf)
 		gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf,
 			      spi->sram_rx_buf_size);
 	if (spi->dma_rx)

base-commit: fd99864b0ac936e870c7ae28354c5cd3dad5efd0
-- 
2.53.0

