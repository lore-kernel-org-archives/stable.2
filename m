Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E8417BFD
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768105; cv=none; b=H8wrMwpe97BjuSdZRZXskuTvEK19EO8ywZRCtM5T39W53A9DXnh3W4J8xPNG2319fEttsJccNk/4ywpxSZdN0sZ+c0QrbUHSsYllqpmCzFE+S1vxQpQN85iKJvCcwWItC45iPxHyueQYDw03kH/wK4aHzOWJB3U9G1Xi+EYCsBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768105; c=relaxed/simple;
	bh=NdAboDuOLqP9r3rS8jQyd300GdkgXGkqEAGWwCKIg2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aiZEsyrewdLdva1aas8+g9G/bQ9ZMYv0bOOKSVYFn1+ZdGDWhfJhQgkjE3JupmFEn/IpSNlVjeHnn0eAbf2dgac7zatPCrcJF1bzGOlxDwjS5D3/Apgv0eawHUAj34M56JSd9ePp5dEGpHGDuWR7gaai7CBE7AW94zssQu2UYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954aff6088so18973035e9.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768102; x=1786372902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVwi5SS2DhtslphVSRNDsHwdJ8hwzelyA1BXN11cays=;
        b=ZmMKa9g4mIRB8FlYOTcJTIV5DXw5nW64tkGe0p7dII4m45Tu+Pki68LO6V7bX6YYYY
         oMUhnwzRU6Tc63WPeI48CmG1bJQTXNJFT21cIKn/sZlJGQcWDowsq8ICWyOuyutRP9cy
         BBCt7CqvoiyliGK/1beNgfKD14ah9l/+JJMyBmMFgdIMZagrD3QnnzGPwGYPzNKiruPz
         2QczQb9UzhUxbEYQltSmmJX6yAsAtSyBYwjLPNeEfA3pUmEVfJ9tdydRo9M6cVaD9mwv
         ipf6scYQ1/fiMZGH8EKC4EGl6hoIEb+5EVIgXaVXOdwDE8Emk2GQUrLON6mLeFA5/vkq
         Zibg==
X-Forwarded-Encrypted: i=1; AHgh+RrJN8W851bY07ixQNM3sng/9puUrHPOVoevE+dd9f0PJtb0X+XRM+RxhlyX2TJNmNsFyFQL0XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6lRMYtmDnzII4jkpHv5qmNNnzab5jq6DWMddaxYBGr4OkTgu
	Axa9FQNTFlY0A1iW6KaT7e1Y6a5DhTSRpWf2YMh34mGxLH+OFBiIGb+L
X-Gm-Gg: AR+sD13e/F5E8hbodlQBGGVHQYit2Ymx3RVWq2rQ1qpO8BJO5/QiouiT56ogO4y6jeO
	RfY5YAR0SI9vf189wAyro7NTP4UCPACUGlQbm3bRJKAKBZZXFk/jEOTFG3F0uenakmpTzFPQP4Z
	sJDil+heXTULZ/v1R/yRIvVQcrrS7nUugCe4ToKVc9GC50/HxhVGmkYiw5I9rLvaxIdP6Qs086e
	fTBxibRH2v/Z0/VPDya1QgqEbMfOj6NBobTQHFMYcR/X81YSzD8qZ5MKFuXrOCHbLXTXZawGaMt
	KYkIiTuwv0rQRKbzCVV6XMIoBMBB6ijBjGmbDtn9BCAimNP5NTrIcn6BqxnlOLkaleLAFMtFrwN
	RGjnGfdlYVuCaCFeqHO986XkxylP+sQ8l7burbwt9lTisu5/BUz6fPmQSW7Svh8S7fmA1Xoj9MJ
	5NRdOLbEwI+H9dlqJCn1umBFl0iwAuN87DMAKKFu7C69QSEY62tChI7I3LR1MeNehci/VFnVuWL
	x5fwilnpCI=
X-Received: by 2002:a05:600c:1d29:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-4980c66c867mr238381095e9.2.1785768101578;
        Mon, 03 Aug 2026 07:41:41 -0700 (PDT)
Received: from xavers-framework.fritz.box ([2a04:7d84:aacc:d760:34ad:268d:e7ae:c44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498081a12a3sm350878155e9.8.2026.08.03.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:41:39 -0700 (PDT)
From: Xaver Hugl <xaver.hugl@kde.org>
To: dri-devel@lists.freedesktop.org
Cc: wayland-devel@lists.freedesktop.org,
	kraxel@redhat.com,
	Xaver Hugl <xaver.hugl@kde.org>,
	stable@vger.kernel.org
Subject: [PATCH] udmabuf: vastly increase the size limit per dmabuf
Date: Mon,  3 Aug 2026 16:41:20 +0200
Message-ID: <20260803144120.11524-1-xaver.hugl@kde.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffer sizes can get big very fast, and the previous limit of 64MB
is easily hit nowadays.
I hit this problem while working on better multi-gpu copies for KWin,
where on my 5120x1440 monitor with scaling applied, some apps ended
up using a resolution of 8192x2304, resulting in buffer sizes of
roughly 75MB.

As another reference, with merely 32 bits per pixel, buffers reach
- 33MB for 4k
- 133MB for 8k
- 530MB for 16k

With 64bpp, those sizes would be doubled, and even 4k would hit the
previous 64MB limit.

Signed-off-by: Xaver Hugl <xaver.hugl@kde.org>
Cc: stable@vger.kernel.org
---
 drivers/dma-buf/udmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 2f94be1df525..8cbba7ddfa00 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -20,9 +20,9 @@ static int list_limit = 1024;
 module_param(list_limit, int, 0644);
 MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
 
-static int size_limit_mb = 64;
+static int size_limit_mb = 1024;
 module_param(size_limit_mb, int, 0644);
-MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is 64.");
+MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is 1024.");
 
 struct udmabuf {
 	pgoff_t pagecount;
-- 
2.55.0

