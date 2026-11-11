Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388666;
	b=CVDA9yxsAJ4JnkR/O1EqluZz8SBuYUTtHyRksrFnHn24AMY467HB6QR87zHfF9oglYQR
	 1KsKjRDyYLz4aOD1ZLIvlBlrglLGrbeIlHjLj8VLJ4oY56lQwQOBamKGo0eQInfFjjGXB
	 HIvFfEhw42UgzdlmIuZBi6NZsAd88CTbGjak34iyTjS8RppbNxcrXtUCEKljRrqWPXOTU
	 10MWscRUqPL7qxnyXB9zSn3/RgCkB+2TYSyaWZydOc5WxrbQsOHGrV6992MzJtrCVcveL
	 XTEfVSfryN2kl6tld/Kufgb5Or9/05P883U7qZVqhjg5O0Y+wa9sW1nURY0ba2e7MxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aPNp2WgpgPHRfZu0DFCm+CGOWcM+7olBPXi5wHu617Q=;
	b=vFSGfreKOLLTYraDnppM26rfGRKrdxeqrKX9RjmSdv/z7QC+YHmwiidb9pLaTfgQnb30
	 ZlaeCwBsgR8Ar3lD1ZAQW34dvGNtcU8OPBtUGZAxQC3nTAMKqjLj3EepROlgH6NUMwiyx
	 0ko0O5GGd6tl6fAUZsLoBdxkK8TzSOmAw/dWQEKWVLuRJimGx6pczVUg6jfyqzBLvhkCD
	 z2nGbShpYy/n4t9sHGW3cGRVlTMp6sPzy2T/Q/RCdYOtQ3Ae/akVA7RsfCZTwhXnQIo6b
	 PvVNhDxuIA3ibbkZAQ+BQSXmE6nQbPO5xHd+Ai35A19280HtPzUzvs4wNDTc3kJiCCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jKX6NVZN;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380F606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6380F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jKX6NVZN
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so5832470eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794388665; x=1794993465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPNp2WgpgPHRfZu0DFCm+CGOWcM+7olBPXi5wHu617Q=;
        b=jKX6NVZNw1uXNnffh/MRSTKG72UpipJB1RmTou87Sz/ovtnkneTDYdHzEWYde+rcqo
         lV4ywopn0vb4Yqvo/qlDiCqDmTNsS7D3sjFLlNijGpfxgEOLsO84Xr5QffWdmoRyKLZF
         nyuJCpIbnQmlvld0IKHHKfWZA7gZ6nqkPobtbQdkh92pKoghNiwOOKeEUSI8gLsXBXLE
         Xq4Uv6dfzNzFFUUlH9jIxHnHWO2uJzCsEuTzcxiZtZ6tz9wZMFEeqw88Y7Sc6YbnDNeT
         zqUx+we2i005dqyhfKkdql2cHp6VViEYZ7motGmAdjUDaS8f+Fe23/vPAk/ZIoJKhbUf
         3xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794388665; x=1794993465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPNp2WgpgPHRfZu0DFCm+CGOWcM+7olBPXi5wHu617Q=;
        b=wuRyWnb3TjqnKySUeC/4YZeq6X2Kae/btudAPLDn/SmpNUk34kUxtmbbaEv7BhK3kb
         ZkLI0vzVqsueFDnD+CZd8Tm3mEyivdKLGtO/BKod7I/OvfIa38/B3kqF1oVK6So2H7xJ
         c14PSMXKU1Vw50r6zwp+1XAt/n6o4JDP0d3G6VriI/LoEVo/Rx/gPtJPijzRGgOI6ABN
         LnGmjFdPVD17VK/lEE1HWSlzIT44EXqzE/oLsfYHiXwgif/+OW2kKSMGLqM2bIJo7JeG
         sXOfPpEjG9r6y96wmLD6bqg5GDE2r5xmkhGFImejJ5kCe2tE/ZbgBduBEjd9Nbc4LDic
         rCMA==
X-Forwarded-Encrypted: i=1; AL+hErHsO9kf6FOEECLK/I36wKHMINM0ZTQo4EUIZq5BhPjehOh5tbSu27FG30izXzXmv5Fss5dfnyI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oDUCQBh/l2Bds58Q8GdSn2/FSHdiSfx9A5HOCjHyzTcfajkgQ
	0AePtlYK+QBD715ST0XVYr8o/25ARly6ie3J8cytecBaqjHpJ3C9GqWf
X-Gm-Gg: AYBFou1VNmftcCLgtcKF6zpx5jr91MdyB20Hj4bR2X98zB/sCYnG3AnMoy0D1Xkuxhy
	HCkaO9by/LECC5uSN9EXSBIy+DmoTrVjUEv56sBqb057AXG7zXVB3xqEsnlmuSxnDWHG1SiHWnl
	uyGbxRI+wLqRoptp71LzH0HaBv7ck+jfMVj2xh3GovUVsmLYoxx5OlQtTe6xASqDuswjr9A91iL
	NmbnGEDQbtVDu6YrM23GBusqrVXad0LqCf3Q929LXQYybWJK+k4Z33p6R8jYZ1T4TKwVpL3Zv0G
	+q//Yu3yvFgGToUS+0JI1KfQrbKqnfJb6S7udCEXodFlD69j2zeb5mOj7B8e7Jr0dpmXYQ3Q8eL
	QuC1mcF7UHVCN43Kv5uHLqK16xZHeIue2kQgsLD5xitDDKp44gaovmFEDdii23RSt1wrXu2Xg24
	2K0hmYO2Y7scVlcgcvN+xW2Zwb2VM4JTNFnF2YLdUNTfbkfP9n37TYA4PwQK+mzbhJkZktMfQOp
	s19OOOridIYbmSPTiLpoE8O2wHlt/Wys6r6yWNJvEq0MdRGBfCM/YEQq+tyio5NrAm/SqGVxDE1
	P7i9iuVQlrhCIMd12xhVXvaO4UDPZx3bp4Iroi6tLi4vq2xWmWRdiI7o4DL4V0ssW6md+yVm0nU
	1Tx8LY+GTXwG52YQrzMZ1TqZO6AGB380BrUNrQGXl5DDy9OTk
X-Received: by 2002:a05:7300:d94a:b0:36d:4135:cd7 with SMTP id 5a478bee46e88-3768617ce1bmr2715415eec.18.1794388665237;
        Wed, 11 Nov 2026 01:17:45 -0800 (PST)
Received: from DESKTOP-DIIS71I ([5.18.141.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512ec1sm13540869eec.12.2026.11.11.01.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:17:44 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nicolas Belin <nbelin@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	deeb.rand@confident.ru,
	shda@confident.ru,
	lvc-project@linuxtesting.org,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] drm/meson: fix NULL pointer dereference in meson_drv_bind_master()
Date: Wed, 11 Nov 2026 12:16:57 +0300
Message-ID: <20261111091657.598-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

If the allocation of priv fails, meson_drv_bind_master() jumps to the
free_drm label, which calls meson_encoder_{dsi,hdmi,cvbs}_remove() with
a NULL priv. These functions dereference priv, so the error path oopses
instead of returning -ENOMEM.

Only the drm device has been allocated at that point, so put it and
return directly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Compile tested only.

Fixes: 6a044642988b ("drm/meson: fix unbind path if HDMI fails to bind")
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 38bf2811d..a9b707062 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -204,8 +204,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 
 	priv = devm_kzalloc_obj(dev, *priv);
 	if (!priv) {
-		ret = -ENOMEM;
-		goto free_drm;
+		drm_dev_put(drm);
+		return -ENOMEM;
 	}
 	drm->dev_private = priv;
 	priv->drm = drm;

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.39.5

