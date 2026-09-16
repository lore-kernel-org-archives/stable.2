Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A83D47A3;
	Wed, 16 Sep 2026 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582976; cv=none; b=b4kZv+pzMDMAH2jQyY0r3gf93FYhEE5KWSGJ3HxneIf2rv6w0igpZrLSwrQcAJCqt5vbW97/YVhHNAZctzBMZpU3XrEwAfwrqkHcM96spcwTvoxU9lQTympvxfsReYslwBvbeHzsgYUDV9DlhaGiuS1I/ChRchdbdFTW82GwRW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582976; c=relaxed/simple;
	bh=mQ0YExcIJuI7ufxK/DWMkUw2Z2lUzNPyt9cMabdlIcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PyOanL9+tZcPgBBXh0A6EvTYDLl6pHNC5kl4+JEMoJ67l9beIhhiAIkjrqaQpQndBDMS1btWh232noauovmxqbA/bUGtiDnP5ZfvRv64CtH9OqtL6VSCeC1wijwdXj/YcyHSMk1PoB44f2BmM/7DF2nHX5vocG0IqMLxLNfWW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHsTtj3qpqAG1vCA--.23703S2;
	Thu, 17 Sep 2026 02:22:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: alexandre.torgue@foss.st.com,
	benjamin.gaignard@linaro.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	maarten.lankhorst@linux.intel.com,
	mcoquelin.stm32@gmail.com,
	mripard@kernel.org,
	philippe.cornu@foss.st.com,
	raphael.gallais-pou@foss.st.com,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	yannick.fertre@foss.st.com,
	yannick.fertre@st.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/stm: Fix runtime PM leak in ltdc_crtc_mode_set_nofb()
Date: Wed, 16 Sep 2026 18:21:59 +0000
Message-Id: <20260916182159.2091530-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHsTtj3qpqAG1vCA--.23703S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1xXFyUCF45WF13Gr1kAFb_yoWfArc_GF
	45ZF97XrWqk3WDZw17Aw43ZryFva4UZrn7Xw10y343trZrXF1UZ348Xr90vr47Xa17XF9x
	Ja1vgFyrJrZ7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJV
	W0obIYCTnIWIevJa73UjIFyTuYvjfUU-eoUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgAMA2qqok+DJQAAsC

pm_runtime_get_sync() increments the usage counter even when it fails,
so the early return on a failed resume leaves the counter elevated
forever.  Drop it again with pm_runtime_put_noidle() on that path.

Fixes: 35ab6cfbf211 ("drm/stm: support runtime power management")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/stm/ltdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index f7e847cfa38f..a95ca3c3df76 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -945,6 +945,7 @@ static void ltdc_crtc_mode_set_nofb(struct drm_crtc *crtc)
 		ret = pm_runtime_get_sync(ddev->dev);
 		if (ret) {
 			drm_err(crtc->dev, "Failed to set mode, cannot get sync\n");
+			pm_runtime_put_noidle(ddev->dev);
 			return;
 		}
 	}
-- 
2.34.1

