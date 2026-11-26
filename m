Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672742;
	b=RzbouEPRJajD0ejqhZTTYsOBLDTjEr3ZM38KvJchvirBD6IBbxoS4Ut0eB+NKv3jD/Lk
	 Lq1dlumUaWt8wAnIoeN2Dtjmg87BwKQ1OZ/ZUTXNvjGC9ycb3xhg6B1atswDqBndbjb74
	 vg0+wT61IVY5JZ0rgceyEwXuRqLr1WuzJ7E3ttyiUy1pFuuFK8Ok9ZgYdpKakeIAj7n2k
	 hs+fSjlIO2w9Hla6NQJZ7iu8H2sz5KWqR7iE0cYKhePaaoN+YI+FdPyvOS1bsvsMqQGdW
	 Hu81YseoxIuNWms0UsqTuISLCu2LHxnT3fw6O28mm0UCmwDLCS5l7FGYb/+GRdOSkSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8ENOEvWpXS/hO0xFIEmj5YuEGPhTN4rxHq1cUYnvsQg=;
	b=QHkKEy0hO6iml9rU4d4ucNlLbNuyKmj7jUmSnDP8d0NSdGUMXgnK9ODEIxV7mrLp1WDq
	 cg34ruk/HjY2FPvH02fcbYKjm7WVo3I5qwoFmZgZBUPuWRFZMLx0SHsvkYgcH+Kpju6a1
	 sGxIFSpFg6ghwWeyWK8g2MskhbENdcwWYqrRv0NLFAKw5ij1oKYrhOGV3bROdbmsXsHmh
	 XAM8wFxzuOZDvxbKDwFPPH8OVlRA457yG6kdAWHe0Sg1hnruPgCRHgTQwKRFCPgq6O6iY
	 2L1WxtMd2g98G+cbzR0CAHP6TWtqm0D2fwLrDQjext0xC/3ms7TZita4RL2XChuYaKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XAsnkII;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF0606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23AF0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XAsnkII
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3acec6677so10061441c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795672741; x=1796277541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ENOEvWpXS/hO0xFIEmj5YuEGPhTN4rxHq1cUYnvsQg=;
        b=0XAsnkIIH/J1m0YQZbpAYLj93XQ5MM4Yp6RCzt/EPqp35wqexoyQKwav3soOPNZH/k
         pzFNyUItCpEqqNkwOXnGxX2YNdsAI7fkNubYsuGmZZn7TIgNNJ624dmST1EFCAzn79ZT
         LOLFgy/x1WIoaBRZGucYAMM9JX9xCN2Mx7zz7WJoHRjxMTNb6eu5HnWxafb5+IlNF2wd
         IaXj477cN4KFwqnP/DHYXoXO62owL4GFaDucl5jxeqBzi53SYPHi098CCh3NwwsdkWU0
         gROe50ilPRpXDIF6UcVqKWhco9aepPw+i16NxOi6Hm3GKl3eywLEyL5fOfz60bLfkDWi
         k5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795672741; x=1796277541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ENOEvWpXS/hO0xFIEmj5YuEGPhTN4rxHq1cUYnvsQg=;
        b=AvTKHwEKq7c42giTbU6NrhduqwZn5wr7p7nS25Fk6ii8Q/iNynfEiVOp4DxOqLw74a
         ZIJXmXJTLCSXD7WtioCslYZQ0tSQ3jkUdqhrbH2dWFUTKDW/2n+0BbKxh8AMJkO9kOrt
         Ls9mwQKeuhMJ2OScFdbX5VUAu+/KZwYSV9UWO9BvHKAZc+wg4QhLUlM9BSxE56FSnysx
         n/dnhJITq5XcJ9GJeYTWLcoBG5MqHrWHeSTMhAbsZlV0WjsQE+y/+LL9xCWmnkv5R+fy
         Ce9kzWaPhySbBUuIbJ2Gmry9Rf5HAjKpYDbE3tNt7Cvkrc665L8NlzaR0boVUAjml21c
         /0cw==
X-Forwarded-Encrypted: i=1; AL+hErEFgPyt/Svg+UE6IOAY35sLITvOikPz5gWu9Kw73VqRm/2X6R0oQ9UTKdy4xtta1XwaKjhTRbU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UpJW+3yYFrDCOmYsLdGY796tpvBpITZUgBxqEG+IBnqJ5DbCC
	xdmgjIinebbfrR5SzYf7/eGeUecUsMU109wCED2OnuYxRkj7E7ydFkQ=
X-Gm-Gg: AZFdTZfh/HZSAVdabvf8v59+Bn0smlzmaH8R8XqI8kOcT0DiOEAUhwJxVtko1Q275wd
	BiZXm6Y1LNYcv7r/IWmOM4L3YQtYY0wnFuCKFmah08qyDp9QUpXRE/N8MT8keg1muVEbxALqjpK
	gIResaCyiZ7/5xCGJJc74XiFzjY5NS94PmghwNBIb4Ff7W1/60PsBDJLytZ2B+jxght2uryKT7H
	r59Eihuzp9tQcaIVyvJbFSiIv66gv0onQ1sTSDRwii+JR8lDFUBvgucYokGiuHEZb8FvKkxYq9B
	iEbLCgTvESVSCwSo/P2D2sXJy8D7yjnAT3n/AwmzqQylHSFprDm87pGivAKEVsu7b9FMq12coyA
	A5fZeElMHvzLGlQXSlrJQgEZ7tjglKAmQ9mRehkIUox3RixCmSIVZx+1QxIk2BFPXltto1dKXrm
	dxMfV0mRsIWgawXNQmTJWo0Xjgm1/wjzv2vLvUoGALAwNAMinvLYN5W2HXzDg/7PyWbtX8QMlW5
	Qf0ALQsjX/0D0or7bIvfHIeHAdqF3pi9vZlZjsosuQrQf/qBmi3PBO9crFgMswyx/82G7MKDQsD
	XJhfA3Lcamzmoh3msgzBS3hlpcCIKbKKKZrM0pIcMnClLcV0xLfJoFN20Gk5MMLWkto=
X-Received: by 2002:a05:701b:2816:b0:1b5:3b83:5374 with SMTP id a92af1059eb24-1b5568cfbd9mr18022188c88.19.1795672741112;
        Wed, 25 Nov 2026 21:59:01 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm45249439c88.2.2026.11.25.21.58.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 21:59:00 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/exynos: hdmi: put bridge reference on probe failure
Date: Thu, 26 Nov 2026 13:58:53 +0800
Message-ID: <rc-b1-20261110-vc-19-b220c856ecbb@gmail.com>
X-Mailer: git-send-email 2.50.1
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

hdmi_resources_init() ends with hdmi_bridge_init(), which takes a
reference on the next bridge with of_drm_find_and_get_bridge(). That
reference is only dropped in hdmi_remove(). When hdmi_probe() fails
after hdmi_resources_init(), including the -EPROBE_DEFER returns for
the DDC adapter, the PHY and the syscon lookups, the reference is
leaked, once per failed probe attempt.

The sashiko AI review bot pointed this out on dri-devel on 2026-07-16,
in its review of an unrelated exynos_hdmi patch.

Drop the reference at the end of the probe error path and route the two
early returns after hdmi_resources_init() through it. drm_bridge_put()
ignores NULL, which covers boards without a bridge on port 1.

Fixes: 2db0d298f22d ("drm/exynos: hdmi: convert to of_drm_find_and_get_bridge()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260716132919.A3EA81F000E9@smtp.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_DRM_EXYNOS=m, CONFIG_DRM_EXYNOS_HDMI=y, CONFIG_DRM_EXYNOS_MIXER=y, CONFIG_COMPILE_TEST=y; baseline and patched exynos_hdmi.o, no new warnings.
No hardware or runtime test was performed.
The path needs a bridge on HDMI port 1 and a later probe failure or deferral, e.g. a DDC adapter or PHY that is not ready yet.

 drivers/gpu/drm/exynos/exynos_hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index d67a493c8fe4..cf570be8fdc3 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1997,12 +1997,12 @@ static int hdmi_probe(struct platform_device *pdev)
 	hdata->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdata->regs)) {
 		ret = PTR_ERR(hdata->regs);
-		return ret;
+		goto err_bridge;
 	}
 
 	ret = hdmi_get_ddc_adapter(hdata);
 	if (ret)
-		return ret;
+		goto err_bridge;
 
 	ret = hdmi_get_phy_io(hdata);
 	if (ret)
@@ -2079,6 +2079,8 @@ static int hdmi_probe(struct platform_device *pdev)
 		iounmap(hdata->regs_hdmiphy);
 err_ddc:
 	i2c_put_adapter(hdata->ddc_adpt);
+err_bridge:
+	drm_bridge_put(hdata->bridge);
 
 	return ret;
 }

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
