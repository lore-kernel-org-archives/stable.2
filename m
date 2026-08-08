Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76DC4A32
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786175212; cv=none; b=Qkbm0nlb41Bv5js9n5PWz5NJWGq15qTjRbuK7diT2DXFb/kPGKIDY3D/cvzxW2y4JpqWEGUcsFgklTfrfwBxu+ojeQUXawPjUAfVtHaws2Hh3Ule+h6n7fxc8e+pJAIpk6/Ivf9HiPa4Ett6dZ/8EFGiBla5Du230SQdHvkJHLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786175212; c=relaxed/simple;
	bh=96QeQH404kv11psTBdIwIsvuB/DrYdWj1xbBgm0+lFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJnRZoDboZ5isFo20mWlMw1dXLW+EmLwLsl/aeP3uGw/dblPEXviy5D4bMwllmrfRKKUfS9cloVn8YWufxq1PLe7dARE3o6L3on3tOETGeT8uvlX4Xscg1vzlNeCGDUo2FcXijVuI5ENs9qva4Yj1Q+meG9R/DTDfajbuf0zJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qf9fXShW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qf9fXShW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38deea72eebso262063a91.1
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786175211; x=1786780011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9y4KPReC2ZyGezILlDFx1J9Ati94r3HeNKJB0BgmAUQ=;
        b=qf9fXShWiigPkYBXYy5M6V6sXeN7anCf7YcsupKeAgm3gNWkqr4WCR8PA4YhPqYaK0
         TYA0chvNplVKfQ7j0JmcEGL6fcs7HHXw1oarfigCtn8dgKm9WFAKRx7+0y2KWk/mBQPf
         CZbFPoy5w/xZ/Kju/vw4aUzAbc7uod3Ewjke/2LsBjNHfPJr3WhbgO/wGufq4R6/W8Pq
         Tx0yF3lcrQUC5iR2Q9AUjQ/0Ga5mQXzjNJ45ilto3r8sKOYQWmWLJBAJNyaSVD7G+i8X
         UOyRT/7pqY++xOpYWxI9e1V/ymV2TIDceQO2dYo9F95nmPpeXxENrNfP3GoE1q6aqJJf
         uWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786175211; x=1786780011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9y4KPReC2ZyGezILlDFx1J9Ati94r3HeNKJB0BgmAUQ=;
        b=DcQsTbfWekNEpqiNMjfbKdDfTEsTj4jDkvxQKJTQXLB5C8Ot1EJUejQ392kGSafuWQ
         7lmRsDmogoXrBRtGEEsT7o+JDMp9sg407Tx2mXq7AduTBcLrDANOhFCL72ng2u2L8/2j
         EjkuXPUB9ZmRJI+wTre1B+T/YMLFvX12qs19DK+c+/oyZP+K/z+Jw7v8s9ED+vsfNBcM
         i5cGiz4S9H8v6k4RIEgxl5ZP7Q/VBoo0J8fVIvt46+6MFa+YqtiwT+gqR3FDVoCo1qva
         APGR64n0iftlW4xokni5OYtPdw9YjQ91vAg+1AV+s6ZRdMqmuDceA9t1Hvb0a5/6dDi3
         q8/g==
X-Gm-Message-State: AOJu0Yzk3tr68iT70IW8ZcQlhsxXAPd/xYkRaH6Hgn6Y4WVHZOO4pLQu
	SQhteDq//RXr0m39ShujBHVhJEKnqpJxUj3mVU+qODQdgLax0Tjo4+jLfcU3HnLid4s=
X-Gm-Gg: AR+sD104lvNAyRkyAYVSxfngY3KFLCbdUKKZ/7/ZDjRDndXhxEPi0/7s6xuQ34sfkRL
	y7GZeboVmM29L/zZuENY/HwDXiTfcV36XW/Q7byKJQegd7nuwrx5zSyCcndqUXgsdF97z9mTLeH
	CQKpwhifGrLjKBRZ9kBfiIhcrNlTyvEUefwPtjJSN9QS8pAbaE3ti2JTdGhklsI39uxDZKAdDvX
	zxX58I+ZMvGvb91yv4R0z+9CicsKSlcSRyyfnfJNnXCgYjKQfCilBuir+zw+B/ZrB6yqB5brGh9
	wbhOG1Xzbh/64DLA1fLMLfcrXHgSPYwqblp4xgzEbHhqENF4FxlqWG09sM+0JFnuC/v5G7+umdI
	FB6jXF4CUyJDygD38m3d8DeHGk8eP1UF16826KGZ/9a4hMp5rmc3Gwz5kVZs5j72dkq+zAeBbDE
	v2Z/SJXjooQcuUP+lA8Cgt+zoUs8cHEGQssd8iesltyHyT3W4/4IfaoBxc1w==
X-Received: by 2002:a17:90b:2249:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-3928242ffc4mr4644954a91.10.1786175211057;
        Sat, 08 Aug 2026 00:46:51 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fd95794sm5282123a91.7.2026.08.08.00.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 00:46:50 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] hwrng: stm32: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 15:45:10 +0800
Message-ID: <20260808074510.2655473-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stm32_rng_probe() calls pm_runtime_use_autosuspend(), but neither the
probe failure path nor stm32_rng_remove() calls the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and remove paths before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: c6a97c42e399 ("hwrng: stm32 - add support for STM32 HW RNG")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/char/hw_random/stm32-rng.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 9a8c00586ab0..6de4c52bd4d6 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -370,6 +370,7 @@ static int stm32_rng_init(struct hwrng *rng)
 
 static void stm32_rng_remove(struct platform_device *ofdev)
 {
+	pm_runtime_dont_use_autosuspend(&ofdev->dev);
 	pm_runtime_disable(&ofdev->dev);
 }
 
@@ -592,7 +593,14 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_enable(dev);
 
-	return devm_hwrng_register(dev, &priv->rng);
+	ret = devm_hwrng_register(dev, &priv->rng);
+	if (ret) {
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
+		return ret;
+	}
+
+	return 0;
 }
 
 static struct platform_driver stm32_rng_driver = {
-- 
2.43.0

