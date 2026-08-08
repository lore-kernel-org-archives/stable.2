Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76363AB260
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786181027; cv=none; b=LXWjxmSq7DtoQ6TpsaLNbao5+ZHeRmL4qLCwTBjGLgKBDo0hYCypLkVzscvS3vtuNvGEo92Pg6ZnfiQ/KaIvrOBfXzSoO4r32PCYMDZVQHzYPJGQjnFHS5s1tfxGK8bOMqn3yk6QA7U7ovnHHOzJ00WJTpFswJBbWDseEU19oT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786181027; c=relaxed/simple;
	bh=yxshTvyoAPGWmZZDuR7TLWMT0v330fFFxJAyBybbt2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6ibKB1BdY1rK76QI3tCmnwiwlXwbgpphefeK/mBPTcrZZLitcoKA7mWdlDwYRRZbCsrPE0FfOJOi/6G9feSBZjzqfHAYeN9QZQA8mhzRfaCbFEYB6r6yqwcgEnOak/JPuiAQYNVGC7ei2TgIf0V4J8cEEOMtiyHn7qWLUWSijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5AfFqwd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5AfFqwd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caea3f742bso6240435ad.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 02:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786181025; x=1786785825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PjXi/qxRj8zV1nCYije6O11THncTCuMbmHOZ9Jpz060=;
        b=L5AfFqwdY/dV3KWppV0Jo7CjHmdZrXJlrDEh+BpiHzSO8i7nM/Lth3TYvvYG27L9Zi
         /WWmf7IbfJy4MR4Jf8i6OEmvfIwISKWT4cxz8iZ8I7P5r6qgDEIT3LvXnUcqe5znUNsK
         wc94jbsnEXOyVpagEuEY+D8q/aJrUfO9M5hh/JR5NBRvOGeXopoPYLOZWfn3s6sth6qD
         R9oMq40rp+mwf2YtZB6kk3FeviUhq9z7KDMzcoWQDQWw8sajEUdziGj2to212KM2ENGJ
         2J1NXSMhX1aYmcjVACzh34mWYwwfZ/uEknPZuRQldxTroCGDGNahS4tB3KsajwARQRXD
         WA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786181025; x=1786785825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjXi/qxRj8zV1nCYije6O11THncTCuMbmHOZ9Jpz060=;
        b=E9D7SMsB38zwEO2unX+8ljSYcld6NWIrmtK/ZMPNUE/w/5Hgoxy2LY4nraHpfAABKT
         g+4rbk/Vx0XErsfxYzE3hFKO8SAqEoMbJ0/LFkkJB27MefYwWyaiN1MTe41Fjh9w/mOm
         J/sDDZA3F8bq26PsYyDoHHC8RCZ3TF5vzytvUF9z8hHHrkKGNMgeq6pfXO5ggxTdOd3R
         c6xWRB6zjH5IMDmV1dHnJe9HyrEvEp+jQcvK2Qsiyw3gzmINA79vxNfgYix1X3ugwmro
         mtLbawErvc4WHkY9V3qSmmPU6+bBhflgZ2viLgiEvRfqnk6wTnYahEJcXIQi3sviJHGw
         XXkw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/KMMgJSJc39JZT4e/dcut4Ups7zQpckRqvPaT2TGZBpb8wNPqNwcEUrZm9mtg+lxyGdkh0ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyC6q8g6/eIpHVip+ZJebDFgSXSuuidT+SyFbZqII0QKO2hjh
	dqIE2MkWsQ3jue5nsPvl+e0aQvyktxZWhSCvqTaOLHZ/D2ij/z6KdIx6
X-Gm-Gg: AR+sD13Ek2hNcklFzI66svt6Ku8LR2txh6tmHw/AzEIfsE5TyGZ/4coPVmW/0JDAk64
	I/8ziHnIlxAy8T0sd8KhikHoBgCdJelXqtRE5eUdvTqFw+h/tT4CXawgE70tjdQ6sF2RBIGOsnO
	sil1pww4MWCJjLyT9lknVQTrENOJRrMPrp0cOH4clf+JUaYkgDruQSDswqCvPqkio7PTqcFIhNz
	71i0OByaNhLsz7OR+itqaWXDak9U67X8VPskQ9lDsySZ2pBnLnrLQ2qiZFeHAeeHkEUM9WmRg3w
	DuvAOJCVUmvmjQAP9T91J+/zB6frNIn/HZ4MkQaxpfofU10wG1wnvyx1G9oD05AEVFPrn5rBKwx
	r39Hj9rQdjqytKrdXIZet4ADetLr0TqfqPhHriRBx99uUVAXSDaQ4xiQljZhpa3mvF6Rf8/XJE6
	qZ6P5vkRyJp8AnMU9eEubG5wpxfLXnD+Hu8Q1764eUpbl/zQKNmfctrg==
X-Received: by 2002:a17:903:17c3:b0:2c9:e86e:aa0a with SMTP id d9443c01a7336-2d0ca165189mr344277915ad.0.1786181025137;
        Sat, 08 Aug 2026 02:23:45 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbeaa88sm17171945ad.39.2026.08.08.02.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:23:44 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: ccree: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 17:17:34 +0800
Message-ID: <20260808091734.2727295-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_cc_resources() calls pm_runtime_use_autosuspend(), but neither
the probe failure path nor cleanup_cc_resources() calls the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and device cleanup paths before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 4c3f97276e15 ("crypto: ccree - introduce CryptoCell driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/ccree/cc_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 061e68a31c36..b127ec64a087 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -567,6 +567,7 @@ static int init_cc_resources(struct platform_device *plat_dev)
 post_regs_err:
 	fini_cc_regs(new_drvdata);
 post_pm_err:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
@@ -594,6 +595,7 @@ static void cleanup_cc_resources(struct platform_device *plat_dev)
 	cc_fips_fini(drvdata);
 	cc_debugfs_fini(drvdata);
 	fini_cc_regs(drvdata);
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-- 
2.43.0

