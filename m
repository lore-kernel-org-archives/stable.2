Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069177;
	b=mb9b3v9xYMgOPdr/uyvILAN8pqu15EN8GZoey/YNgXfM0IQfa3PT/wUj7WgVNxvogJKz
	 SR+G6elpXWNcv/eA3p/DOFXmFLf+jNuUIE8J0pVLwVTJ71GuCqWdjFbomRWtSN8FihZvY
	 yPwC8uvw6zsOO9EWfc4avvdxNPM93+vVh1+YGrihRV9IPTA7BSFjm0oNAterDThYHR2Vj
	 yegojrrvb3Wq9eUsbTIdpmMcrTi5E7Xeeu12N+h47By6rX99gGUBmH0rV7a7z8aPLzY3B
	 CEZaQTfGdM7BY1OyMIFyY4rKCbzxICYNPayGjflAVGwW4gX2nCySEqs4CW+9W5UeXcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PGT+puAojXJ10M7d5F+nORTVc4mPik48tZJfhJIgcgQ=;
	b=1MSEWfutaiESXbo68JK6z3AzLXDQ74qbWRzUaYFgZo/B4YLr8MwSIKRxUSI3aiQum7Rq
	 Q7Irfg1meyi6uzsvQ2vs/7eqvRNcA+cA1h1PkxEQA7AW0usJ7xGmb09Xdd6kyvWt/xYYQ
	 3UmFuArfMgEIQNgDF+KT3W0qkYvSJf0lxk1MO9VvCPTpDjl2qITMjCJdr2ITd6JGw7x7A
	 hqN8Vmfi754t1hDIV7WZJsoosD4awCwTOX0stkcf9B2GNeOF6XBz4iBi6/lKTI2EJTDIb
	 ZrHUiSDZw8lFb6/cllsvbJbiYFTw6Nhscj3maucmi1pp+ninwOJyvi6s+vc+alWZMyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tBxBQwUw;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C47606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C47606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tBxBQwUw
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e831e86ebfso22644715ad.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 19:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793069177; x=1793673977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PGT+puAojXJ10M7d5F+nORTVc4mPik48tZJfhJIgcgQ=;
        b=tBxBQwUw3LMOsElAatjrmzeCT/o+kwm7rU70vYpvStsNfTivQebNbB4S41E+reNAut
         vBPJYEZw9Al2tLcsK0+O8GSooRxE5X6oRt+UHy9JrVZ2d/LOkrADi8GG3ZFsP7Ne4glw
         BZoGPPf27Wg++Q+2TjK5M9XOH/uM4vXzr6gE+sDNBd+LIyxuw+n3oEQO2qegbvFb5CDr
         HU67wvjRhmgK+NlA18o5tGS8b/EwtF59eqMjNHkrumRV+iYvNvSMf5ZYxcOtPsOwbhSj
         g7MgKYiODe3DijlSrduXjNpZdKp5uVlgbF81OamBofyYH1tDfIa6AnrYoN1LuAuLHvRx
         k3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069177; x=1793673977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGT+puAojXJ10M7d5F+nORTVc4mPik48tZJfhJIgcgQ=;
        b=XPGMW15KcGDszz39c5JBybFlHsggbHqYXkmTS8pWn0KlNUzp72TvrITHF3XVrWtQBi
         MvqTit/DG5WZQtH8ClYnW9ENksuaIaO/Gfc9i56U7/w6D3+8ms1GB7GqCdGwYcstM+dJ
         0fL1buUWtC1wBJ3a6L+S8mHOaFNkMzEqNvcfVaX8Oyj76RAztyWiCXH1PVMVV5ZKlNVF
         x4q306rkgBwtQ5LYCrCSdueMCyZM/0bl5au4szGqMcwyIC2JDMJwflJ7XThicJxI1oSf
         LPdgNJV0RvIj4rMwWvgaynSEqrWKOURIYre2RVqFfIt26M0Sr0YpPJiAODS+OxV9gAWt
         fprg==
X-Forwarded-Encrypted: i=1; AKwUvBzIo7iVwC1FFapNyDaFQMo+VGk5MiF8AxP8PbjvXqvdkGlAnF49qFt3X7wLHQx+q1Sudi+6YxE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/AkilzkRivlG6ZQEdb3rVbd03n3pnz5BA6IEz9MTQI1maoNNO
	3RisPV47wAzEGvgXb3o+mDNO4b/l7KIX6HvQsOh94W2XfHt6lC+ZBn6+
X-Gm-Gg: AYBFou3MpyFHMkSZ2arezi1fjdNbanuhohN//nPcply3quld4+vRgX7KTSgrUFrwOL/
	y0A0OQuiPRhY8ATidJUTvGMaXJyrojpspUIY45p+NXwGISSr7R9tHcoMi1pm6TDoGOkMRtgvBx9
	ZPUJKNy90vsK693t7hTpCHf6UjQl5qAE+Uybtqy0CV+6vwYblGfh6MItmW/DQhaslGDhDTH+3Jb
	na3/DZszxqar5aKQ+Xhe1RT0G/PumQL+H7qZRekVq8UlTnBZ3eTkXLE6WmcBYCsERb7Glyc9N1n
	gRP8bs/ecwFmmGMeucdaTva4+InwsUMwISuc+ad3zP16oYwk0zAUyk6usrKEGg1TjXpWkDZ3SZy
	q4gSFH55simKbhyPx9cZYyNYTwQ3pFZgtdraRRW94LM7xNyPJG4Ccg/Gy+z/9PSmEq0E/5/CMNX
	GCZzwrVW4M4nDtXOFcIhiIgYE7ynMkSkXikPAcm2YEPHP3cYnr6PGWXCxGBQ1qPUxY55Z2V6Qsg
	sY9/0W/HvZwrM/YMxeoh7NPPNLWfTRPv3MoHlqWKJed/3tndeITU6zYgye6dAaAXbBHatNNag+x
	hGnY/O4vGXQbjrnlA6fMpAC3YnUC
X-Received: by 2002:a17:902:ea12:b0:2e9:87a2:b4f8 with SMTP id d9443c01a7336-2ea9c83f108mr69673795ad.29.1793069176577;
        Mon, 26 Oct 2026 19:46:16 -0700 (PDT)
Received: from lgs.. ([101.76.249.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bdd5cesm2324565ad.30.2026.10.26.19.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 19:46:16 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lee Jones <lee@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: hi655x-pmic: fix IRQ action memory leak on removal
Date: Tue, 27 Oct 2026 10:46:08 +0800
Message-ID: <20261027024609.117371-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

hi655x_pmic_remove() currently removes the regmap IRQ chip before
removing the MFD child devices. regmap_del_irq_chip() disposes the
child IRQ mappings and removes their IRQ descriptors.

The hi65xx-powerkey child registers interrupt handlers using
devm_request_any_context_irq(). During child device removal, the
device-managed cleanup calls free_irq(), but the corresponding IRQ
descriptors are no longer available. As a result, the allocated
struct irqaction objects referenced by irq_desc->action are not
freed, causing a memory leak.

Remove the MFD child devices first, allowing their device-managed
IRQ handlers to be released while the IRQ mappings are still valid.
Then remove the regmap IRQ chip and its IRQ domain.

This issue was found by our static analysis tool under development.

Fixes: eb10245fb37e ("mfd: hi655x-pmic: Add powerkey device to hi655x PMIC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mfd/hi655x-pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index 5cb392892c19..3a7ccc9d30b7 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -147,8 +147,8 @@ static void hi655x_pmic_remove(struct platform_device *pdev)
 {
 	struct hi655x_pmic *pmic = platform_get_drvdata(pdev);
 
-	regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);
 	mfd_remove_devices(&pdev->dev);
+	regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);
 }
 
 static const struct of_device_id hi655x_pmic_match[] = {
-- 
2.43.0

