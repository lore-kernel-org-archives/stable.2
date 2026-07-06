Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2279D3A1C9
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302952; cv=none; b=UI97wnhMx3tBo7H51tWSrGnrxgEob6z2Np+0oKVGZHYP3MY29imYA36qUYyNcIsuOE99Cwda4iDLfc/h/3ohO3UTUDgs9X+xPek7Uyhh2NK00vuIObOBKXVoC0tdKa0eXq6UFhGuaLEfjuy8zc8Ao/cPrn/8sFmwelUUgzzRVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302952; c=relaxed/simple;
	bh=fke5d2bOur5p1Gx0fsd1ETls+k12o1A0rrGDjqUrOp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wv173vxxxPMDv9LgF5QHFMnMygNveUNUeUo/wodHOn73YKJjayv/Cv7TSW8/1I73aEDYni9ZAGKaOPob3iUFDj4oeV2tqXBzCcPwxddJgPxVgrUps5b2iZvUR9xp5LOlHYo74r2yJNIsQlzZWRhArK0SM5ms389Z9hzVzsJPeNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5mLEo0c; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5mLEo0c"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8471013fac2so2699274b3a.1
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 18:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783302950; x=1783907750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hc+/IIfPHTQ5W3C46gmAKHbZoREmTGGCL3gylifCnJk=;
        b=p5mLEo0cCf0pk0O0GQmc17Po/IG2mp270CchGafORTRjaKHAaE9a3Os40zxEpUeKZ7
         QbsNN5Ww3hYjhjMvJ+K3DUPEmIst/MGvqSJpfbrn8KBIb3m80SEB2E7zznewZ1UEB1Uy
         LY0PJO6wzhgwJGX4ME4plh1YFQc9wQTyv83BBpyaco6vXUsDOqQMMHMoTc4GSqsUKGMY
         bEtKoSByGPgOMaKyW5mmP/+lbyjKezv7FOeXxfAj+UF9RrWPqzGXxCl+WGlG0wZsY8Pg
         dOIbtrjnx0mzjnnC55iXu0snTvgMUql2fnXmLzN7lUAqhEgpqMEbIRxRqK2E5Iolq+iW
         g/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783302950; x=1783907750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hc+/IIfPHTQ5W3C46gmAKHbZoREmTGGCL3gylifCnJk=;
        b=REuww3j0P10HIS5PoJkytqxg2nJaDQC4TmCPmogT9B/ys2iX1T5i17fjQm+cxcBDeE
         vSXzAuT/8J1fF2Ar9RkjP4ixipiNQ59wpbNzZpJth5naIl3/rMOYDsdENSHm1qdEfp7K
         Mhd7U2Tbu8HaQRACaM0+BJjpBeLej7dPC5xE6pIeSo9I0SMFtbYDaTtO5faSU/ApRSrO
         ae1NQBWEnLxyXK06wr+K52i48MBVM4pSppbJRbffV4jaH6p9Loxuk9Q1ZlSRyxcyEb51
         0nOVfrWQHOpUMgCc9GxQ4l1Z2smS5jVm6vRe5NjWOmt49t9s4ZN4TnDIzqzk/apQNO7N
         3bBQ==
X-Forwarded-Encrypted: i=1; AHgh+RohJDPC9DhaB1wak6KmGkrCrt+naD4K9B2TmBl6C5UfnCmxsEDVFt/hVGVBw1l7hGuB5N7KIEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrLtc9EpXs9YhHOelvNM7e7bcwSneXlcWftHInwaWZRFZzR6/O
	SNOcWSIRZyBUjdRQL+Wj9PxJ0BZFxSxi5Lul26wfyYFpGA4toqD/mkE1
X-Gm-Gg: AfdE7clid+tGQJ43vvXQAJBve7iS/COu+oG+tEqhJJfGXHOErIx0fGYdWIzV77Tvgyd
	9jf9TfKdFMZxT/w+iS7TTlWkDRKe1R+jmxNG6l2fMWaMUn892rJoCwwiS4QsbNML99q2CFpkOgr
	RZebqGJTPiJDRbl3/Z5gCjRejJJZhksIk3o07KPgrlC6T5fHsLhSh+e003hy/X0MDAeYtJxac7t
	eNX+dUdS1nHSe/Eqh1Ajtc/O/i53PND4Vd50y37MxtVxOYJXeDQ1zZ0xZv5B1kbJ0w+3WvAlz/U
	Ie/8Wxs6nF3ixLMkuyGiz+fhdli30apvKZX7mvJMwo3Sm1IPKkAAUq7FVzjzYsRWYiQwAJLiXwr
	nkyIb/ap4fQHgLziFlAv7vZ9OD+lbw9PeyvVu4xm8WLcqaWHmkzDLoVvo4/UiE2lS2gWoh1V/0Z
	W7MpA=
X-Received: by 2002:a05:6a00:2d23:b0:845:bcf0:118 with SMTP id d2e1a72fcca58-847f6f55a19mr7186973b3a.41.1783302950430;
        Sun, 05 Jul 2026 18:55:50 -0700 (PDT)
Received: from lgs.. ([101.36.107.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b96c04sm2832348b3a.22.2026.07.05.18.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 18:55:49 -0700 (PDT)
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
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2
Date: Mon,  6 Jul 2026 09:55:07 +0800
Message-ID: <20260706015507.453222-1-lgs201920130244@gmail.com>
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
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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

