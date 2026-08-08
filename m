Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73CE3CCA15
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786186633; cv=none; b=QfmihCzlTBT0Ig6gqB/IXzlyv7fmQ3mbh51dZ8pizdhOicVLeIY1uMCTvqOxIDRFkF8v6tr35oAiGtX077QvLRD+X5aBM9VKIeyNf+BOvQDSHaZkpUzx9EsbzBtQy13SFkc5fcZtmIMu1KPaQ0oa6cTucUE1tFSBq+4PNBDEBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786186633; c=relaxed/simple;
	bh=tb66UxTSAQrQUkai6y4yVLMKfp5NW2EVJnReCmrxdwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNCEWyAKWyVcfh8prB3MLeS9z0A6WNYSfpustPXd0P19NgM+eXrSPWC9OZNvrnF48YkmT0o1vRvrK1RVT0RLi6+pcainTm1iaJ2AT3q+7WLaALo+Owba8vsn5tGi8vIabY9KhGfBBQUOS6EXUEXoWnKngxa5uo6fxURTyhgsHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBqLjq+g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBqLjq+g"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ceb096e675so4393065ad.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786186631; x=1786791431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Be6DCppg/DEo+f3Oq+NlhfXUFVlwKCwHdneTqVx4xfY=;
        b=OBqLjq+gA5gThtZGrTiw2PGoIq7592z7KWZVoTZViQkVoyhaNFQDEMfBpul7CEybEp
         ZxBieoJ4jXkaCpw8BLEMJ0L73PxPd3fEScInk3Qy6MCdQ9/jdsaQgqNsLrPsTjrSPYUp
         EK4FiS++xvz4OwzkH0YxatHY3bEE21IDQUjFvAJUlQm7tDCvV2UMm5CTVWuq1XtBHCk+
         /395/SbmNhFUbql64hkV8NoqX0s/vWv8CkoYQdCdC7Q0lVxZOmxoLvJc+8SrNblGUItN
         mh9rAgcF9lmSpuRzeS1Xz6ahZmWcbGa1TVG/u/1dkFHd/VBR7N+39UerGefGsXKgBVZc
         hp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786186631; x=1786791431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Be6DCppg/DEo+f3Oq+NlhfXUFVlwKCwHdneTqVx4xfY=;
        b=I8QZm6CoqVqD8OjfJkCLSu6aMSlOx7WG/pUgqxz8L63srKh3rJ6Ai22zjB/VY6o3O/
         tvGtHgtHHLYnriW+J+etzkYFdkuLgYSpfYoGifDuT1YrQ/zWZHPONCIghbcObIPkEuEJ
         1sEOjox/Og8uIFY60AbvgfIRe80nKO3mPhhP5aKgeUgifLh4J8n6TJ0MEGoVcVae0gMZ
         2wYo+BwT4SXvFGAa8TbrECDEiPJ5C1dlQ9Usl9JtAJY9SUjSg3gf0QVFMeZLo66jOvN5
         JolCO4TftyLlvF9tvo/lzn1CS8b+0KM+6ygIWT5aJ994DmQZlR5a1R7oJ0S4IJk+Ixty
         Yr7Q==
X-Forwarded-Encrypted: i=1; AHgh+RpIB7TgPZv1K42A0j+3e33yQ6TXP9BCtcSPINekLTpNlXfBsU25bWjoVstfjTQLInvf4YA36jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3sBIdyLqMtGdkmQnqvT8/bk+0CZj9kevPyzGR3kMXvWmZ/x/Y
	SxRrYY/oUrW7xF9L9L0aQa6TNTcawi2AslbMSjtAXBJng0Z4N74iRD/W
X-Gm-Gg: AR+sD11CmTCP2wUDlvh/lXDGGpebtqMR0qUALnyDyHtG98PZALLTcgV+Kb2dV5YurDR
	876BIBRxJfztnnRCtj4p8bFo9HRtxVO0SldlW6Dzelh45OqPtR1giy7HFWqFAOxHGa3k/cLB1c0
	dp4tOV4UDucnNsgAYLFUWHOix8YbO9H86b1wF4hOol5wr1dCuOg6Jg8/ytAyec2265bTqbS5+Kw
	0nUnbZz2wPjxAk1gvjVF7Uud69Pw0aNBM++i2+40UInOjGEE9OLHO4ice/eJPyUC1gweFFEmeX2
	fHMBe3DXf6yAOWU0WyWYm7hZ79Hz2S+ihUbnYf1K62ER5w3URF6BVxCcz25UbhgUkHyzGx6wcF2
	mrreJSvsrmQnCN0CY+S2vixy9AqWp4+HgaXvA+vqEocVovket5erTnxvC0ffrTrzmGSleeKL/e7
	WKAb/fmNWlwKOw3AYsOLNhpaC3en+XSXSn2XSkrNFj6TfhqSfJHA==
X-Received: by 2002:a17:902:e5c1:b0:2d1:134:b86e with SMTP id d9443c01a7336-2d2a845758amr69362385ad.2.1786186630914;
        Sat, 08 Aug 2026 03:57:10 -0700 (PDT)
Received: from lgs.. ([118.193.39.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14da67e21sm17661175ad.37.2026.08.08.03.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 03:57:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Srinidh Kasagar <srinidhi.kasagar@stericsson.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: ste_dma40: fix autosuspend cleanup on probe failure
Date: Sat,  8 Aug 2026 18:56:57 +0800
Message-ID: <20260808105657.2762974-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

d40_probe() calls pm_runtime_use_autosuspend(), but its error path does
not call the matching pm_runtime_dont_use_autosuspend() before
disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during cleanup, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call to the probe
failure path before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 8d318a50b3d7 ("DMAENGINE: Support for ST-Ericssons DMA40 block v3")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/ste_dma40.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 0d9ffa3e2663..e2ad50e0fec4 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3654,6 +3654,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
+	pm_runtime_dont_use_autosuspend(base->dev);
 	pm_runtime_disable(base->dev);
 
  report_failure:
-- 
2.43.0

