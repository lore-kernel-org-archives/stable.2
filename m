Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A48346766
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942338; cv=none; b=ql+UOrzjBJ31RMvjPg2pWKYHCYqBVHVcZSyF8CIOq7heP+AFzOobtYF5TgxrDvdk+fAGjl4dDmWxvCyGEV+pTD2sy0kQU2nWTFUXrkazZz5tSp+Ty8wHC5yTjSJEfvxBf+LJqiJpTAP/EypWnwPTLJ/1SnmKFcgcGnOgjT50fkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942338; c=relaxed/simple;
	bh=pe0ZWEl9hpbKNM4POdPYU+xRMmXadYbOlA4SMxHiFR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVx1b4C2sUq+0KVgG2gjQ7ZrryiUCuFj8G3T/N0rCN4DtPOKQncbVmGXqufF0B+bVDlTuoQWjW9rB8BZYQe+FH+T+xWtWfzo7njhWQ7f+VxO+mzPGRFV9qkd+ACT+YMheForncU8TqQFyqd7vFbem1DDmlLcC+AbvvJO/bg/MlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv0+jPSE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv0+jPSE"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848882fdb18so2129541b3a.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783942337; x=1784547137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bQ5YkObDJn3q5yEXBMbpydhpxp/loGCG/PfQF+sLSPI=;
        b=bv0+jPSE1dp5ZtI8P/S87t2/8h78QGDfYyX573LFTRf0PpyXoPEHJYMVsp0rxN3pvU
         WhnbRpWiC4HRBwlYPNKSpyzmZayODlgPXb2CCE+xzEYamoDqOAMkrv3pU7LKYoF0fVjb
         SGCorSeUAcWUziKrZT/NxlDs68RVWQ46RrOACsmftat89aubRSEZTzrFTVyBPY250HOu
         2HP+7TGAZgyAvKMZCPktusOfcOr2VPGuqrVbgynriKbyXNHvjEEZLMo8scsLb26ySwpi
         ggQG1+1hUPylCGZIvvFtHFbLQGVn2GWRU1hBy/aLAgNPjLSxo+YPxpk4bCKCi8QbMJa0
         V1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942337; x=1784547137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQ5YkObDJn3q5yEXBMbpydhpxp/loGCG/PfQF+sLSPI=;
        b=GL19ewor3q8Qu/CgCkwLoqvePsGybT0d+UAEb8PCZgdN2lG2ZzdS9cEQLN+0PZRcqM
         VSQvXMrVT3BsSwt8RowsyLvHy6TWuw5bjqazdbYlH/rfxqt7gBH/1Tp4/z5DXw0/TfSk
         FmlYuyftyzFq2Y/aKb27T+g1bNTA1bB1wAsOA+4/Wm4eXsTdtayjOxfEvwsaZPtYunX8
         pjeUx7mUwjXNVsNZRPKWvj7tCZX99PwLOU+06Gp/22z8+WfzDTUHSAtHjC2q77ShLws5
         Up0E1gseliDk6WoK8NgsSNRyXAu56E50DDwJ7iabIDsioP08+LP5jurxt+L1rHGpBSk8
         1+rA==
X-Forwarded-Encrypted: i=1; AHgh+RrHRokyLUlT+6sD+p1+XyAErAsNoKjwVbR/uBs6uN4MjLruZS3QFBZoqB3JgtRvE0hKOF6L/0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RS8hVr+Iyv8TZ8fG5z8UQHwB2eRPjdIxayltBquIN2CyVu5V
	L2k34S46BviJ5g7sKBSz7M39d0hfCWJoWeKkVZi0fFJes43p0qwdhaka
X-Gm-Gg: AfdE7cnsUM3WTMJoq/EnbfYM1D+CI7zkTXXLJEzQp8ityw16c0Eovu4o/qV/NKY5uDR
	mUN90RF3EULS/6B9ye/C4STWXEgbg05rD3y1vf+ZbAur3xpjhGFEL4GAiF3ku90/6ytVjO5U9b0
	KC+SBU+pDvTWG0On+aJ+USSn5b8V/IwHhcdoO6xHxFF32anZgpsTdd5KajuCCZ0rD1TEenIiopW
	DlJ31K7k5h6fTzJmdJEjXzpwvXgkezx/gtzBXy08bGwLKqV6Lc8fQsJmQISQLEnUn79Bv7FRb6W
	YmVN52qj8HXYvbIykrqK/fGiEhLu8Pv9EqYx3VCVIaC9+nBip24651sMnDa3e4CeANpie3zwq07
	8XVUp6CWGIYYBJGm3SvEgFHvPmeXqCQRntdgokhjUjrPrKpgRWoxIplgiWiITd0pfWLAPovU=
X-Received: by 2002:a05:6a00:18aa:b0:845:d286:1fa8 with SMTP id d2e1a72fcca58-84889768958mr8641367b3a.55.1783942336528;
        Mon, 13 Jul 2026 04:32:16 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84880a4abf1sm4318802b3a.16.2026.07.13.04.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:32:16 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Johan Hovold <johan@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2
Date: Mon, 13 Jul 2026 19:29:57 +0800
Message-ID: <20260713112957.884640-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_hdmi_common_probe() gets the DDC adapter with
of_find_i2c_adapter_by_node() and registers a devm action to release the
adapter device reference with put_device().

The HDMI v2 remove callback also calls i2c_put_adapter() on the same DDC
adapter. This is not paired with of_find_i2c_adapter_by_node(): it drops
the adapter device reference before the devm action drops it again, and
it also puts a module reference that was never taken.

Remove the extra i2c_put_adapter() call and drop the now-empty HDMI v2
remove callback. The common devm action releases the adapter device
reference.

Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - Add Reviewed-by tag from Johan Hovold.
  - No code changes.

v2:
  - Drop the empty remove callback, as suggested by Johan Hovold.
  - Mention that i2c_put_adapter() also drops a module reference that was
    never taken.
  - Fix the Fixes tag.
  - Add Cc stable.

 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
index 7bbf463056c9..ffe456238a2b 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
@@ -1499,13 +1499,6 @@ static int mtk_hdmi_v2_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void mtk_hdmi_v2_remove(struct platform_device *pdev)
-{
-	struct mtk_hdmi *hdmi = platform_get_drvdata(pdev);
-
-	i2c_put_adapter(hdmi->ddc_adpt);
-}
-
 static const struct of_device_id mtk_drm_hdmi_v2_of_ids[] = {
 	{ .compatible = "mediatek,mt8188-hdmi-tx", .data = &mtk_hdmi_conf_mt8188 },
 	{ .compatible = "mediatek,mt8195-hdmi-tx", .data = &mtk_hdmi_conf_mt8195 },
@@ -1515,7 +1508,6 @@ MODULE_DEVICE_TABLE(of, mtk_drm_hdmi_v2_of_ids);
 
 static struct platform_driver mtk_hdmi_v2_driver = {
 	.probe = mtk_hdmi_v2_probe,
-	.remove = mtk_hdmi_v2_remove,
 	.driver = {
 		.name = "mediatek-drm-hdmi-v2",
 		.of_match_table = mtk_drm_hdmi_v2_of_ids,
-- 
2.43.0

