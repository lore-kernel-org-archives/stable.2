Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4033932FF
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168648; cv=none; b=Yvb4a6Mfsfau6jo4uGUxrV8zZs0V7uPV5doku/Pbexzv6UOlGrdV58Sip9gLffAIr5mKnUknq/+P7J9p830McsN+U0SxZ9dVtnTt3RFk8ZJ4cNeZLlQ+3sui9Hr9LF3JPvpWtFCTML/HrdEmOlfIf+ffsPNZrbHIZBw1WAvV934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168648; c=relaxed/simple;
	bh=ay0QhUIxWGqQW7tkXs2XfwnADTvpm/OD3c2MGP4/vpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZq+mcWMTzDUcgu3xDaObVjM2lqASr+OYX+DxwXwXWD1NOvyGhqNZWe9WJSkqiGadBZna69F5OOSGNfGNvzWawTVZnHubqhmjJU7pGcbw5z68mmEvCOG2Nj5k6x9vmZKzrealPg0wK5cTHihq1nHjXNyfC2QhkQsMRYDkL4mjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwrPIoeG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwrPIoeG"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd1006978ecso22697a12.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168636; x=1792773436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fE/8k1v1er6yt8K5zlufTxmneZEuI8I3OJXU6lY3dxA=;
        b=MwrPIoeGFOy7FkZdsQzeZ/DRbDwSpkRA1Fo375X/TH7U/C69ozfBKrSWeWLBWRM5kv
         XmL47UpYlAT0bHRJ3IZjYI5XeEU6o1nIaG5mYYxHhTdaOm5LHhvsLiYy07kNcNrNE+tI
         m7Qjsft+9CTn3oAlN2EfTylW5hvGRJMP/JxcZA9d21eUzy7f+z+96vz0VKa5uZgDl8MW
         nHYRev/u5MCfqGcH4E7UHfRgQ4gE6ZkBr4jSmY/xSBfkauW4x6hLaEGslWdy+3LrqDSw
         5o0OpRDqoN2icKP/PYu4njLyaxmcCmHaXpjUJ88dAlIW81QfjWi5ft0MVKmeBJ9PsS3E
         CUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168636; x=1792773436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fE/8k1v1er6yt8K5zlufTxmneZEuI8I3OJXU6lY3dxA=;
        b=1Jt7b+8bMnRbW1qmPG+sLUE4DjHvS6JDpVMIXooUzE4YGhHD8/JZJG0M/NznTMRWhl
         m9dexJ5jxCMTlEUvYyKCCIVEinoDqb4WEiPKFJ+7GTOkM9pAh6570iXd/b/RV+XFDhX0
         Mj1YXqqs2suzxKe2BvrTvCYI60CO/LmuFgd+C6/x5N+hwVc7w/En9bMD9Dx9axXoYx9h
         XlYAIvH2fbv+NFhD6gvKayio8sEzl1g9hIqTK5kip8o1w6/KOd8y7bPrcXR7mLazkrsY
         8zEIvJxIvsBxgQLUz6NLIlBVPcE8vVF5IQNv0kaSrYNqLSo73gXOLjv3lO3n0SGBnt77
         KFuA==
X-Forwarded-Encrypted: i=1; AKwUvBy9WZgRMZ/WLke9kypDWxYYkSOnmRhz9cRNWcJXbS+dOu/YZ0I8gXVw4PRzF8F61r6trls/YuU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjcgOTbDSHyN4z25OGZzvkCUhqIs7Gx8TVGnPThn1sH2G2qp8i
	M0/T69lUXMoxFTjUB3QpLeuvptrjFkKw4gMlqelTQthNKMUYpaLO3FXQ
X-Gm-Gg: AYBFou0MoBpxyqaSX3E5EMqcTwI1k1fqHZDoLhWXwnDHdrcvR296oozR3vtkq1BcgG3
	EiBOduFHC5R3LNQTHxyFOAHjgaLV8SZJ8sXKoQK4/fop8YUsTVMSpRSCABbwGpu/lgHRTRP/FFr
	YubGbh7JVJCP3mUlbVthKakIRqXRgx4OnzgaAI8/3CvMSh5rYE4Y7mkDO4Xml/bzLrQFW20gzli
	vgAM0op6GvsWHMUMGuiBeKnYgZlifBlNLjv90KtOuAqlE6vDAeOM/B6xngJBuSLIyrVhJ9JKnEe
	ldPgL9I3Y91w9GXoqm0a2+6alvPlXXvWLd/VPRETyLt6fUNGgNvMNPJwvNFr+5gt+e+B9qNBTLZ
	PV7bl7PCpbix3CdNJCYpNGbCeXl8dXPctNMOYRTfyLQtwjnywwxBxs5QPZVe6nYbNHQxGMS1ltH
	4fTWDy6F10X2B7Wxe++1QSm3sFAsYDV2csxyeBnU0yRIFshgvIhHBy3PHYpUeCPdz77yscuJLS9
	u+GmlXWVIVju2iXqG9md3E=
X-Received: by 2002:a17:90b:4cc6:b0:3ac:9e76:aa96 with SMTP id 98e67ed59e1d1-3aceebea420mr590463a91.3.1792168635662;
        Fri, 16 Oct 2026 09:37:15 -0700 (PDT)
Received: from MELOKC-LAPTOP ([61.171.228.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm11154255a91.9.2026.10.16.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:37:15 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Anfernee Cao <anferneemelokc5@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: mmci: fix DMA channel leak when mmc_add_host() fails
Date: Sat, 17 Oct 2026 00:37:07 +0800
Message-ID: <20261016163707.3508-1-anferneemelokc5@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmci_probe() calls mmci_dma_setup(), which acquires the RX and TX DMA
channels via dma_request_chan(). These channels are not managed by
devres, and are released only by mmci_dma_release().

If the following mmc_add_host() fails, probe jumps to the clk_disable
label, which only disables the clock. As probe then fails,
mmci_remove() is never called, so both DMA channels are leaked.

Release them by adding a dedicated unwind label, reached only after
mmci_dma_setup().

This issue was found by manual code inspection.

Fixes: b38a20f29a49 ("mmc: mmci: fix return value check of mmc_add_host()")
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---
 drivers/mmc/host/mmci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 416bdb184ed4..4db5c55b2700 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2477,11 +2477,13 @@ static int mmci_probe(struct amba_device *dev,
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto clk_disable;
+		goto dma_release;
 
 	pm_runtime_put(&dev->dev);
 	return 0;
 
+dma_release:
+	mmci_dma_release(host);
  clk_disable:
 	clk_disable_unprepare(host->clk);
 	return ret;
-- 
2.54.0.windows.1

