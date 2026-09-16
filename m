Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1BE3BA225;
	Wed, 16 Sep 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581072; cv=none; b=hHF6afmKi5olyXglSLdjB/w99+XuVfE2sFZmAaCw0SRBTS4FnpMZIZMwwBKwLyw2sMB4zaIA7t5/618dxPH6qMxJrsOkxhO4DbeX7sOfAPLMnKxdDjHVhdggxfLVAnNxlHcUw+5ytBQ6/J6E0QI0CqQR+Th8aCiC5YKxYJWryL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581072; c=relaxed/simple;
	bh=BVv8BY4/Rzc0tTjFsbar678ZUQmCqHNmaMe7G4dldJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SbL3Wi5xQ++X/M9qSbVagPiYK8QBQ9u8N6l4uRp7jOffAK3d0lDkU47X2/xWMFf7cA3mAeAW79jH2q2CgZ7g9DBB27PROjiOHRGTymtEddEPdtNgn1jycEO9ghIU+g7JD9EVN3y/nnkDaeqt+U1N6BhPtMGGmb7ZWhc6Wn1qGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnETzz1qpqsexuCA--.46259S2;
	Thu, 17 Sep 2026 01:50:43 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	jagan@amarulasolutions.com,
	jbrunet@baylibre.com,
	khilman@baylibre.com,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	martin.blumenstingl@googlemail.com,
	mripard@kernel.org,
	nbelin@baylibre.com,
	neil.armstrong@linaro.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/meson: Fix remote device node leak in meson_encoder_dsi_probe()
Date: Wed, 16 Sep 2026 17:50:15 +0000
Message-Id: <20260916175015.2089358-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnETzz1qpqsexuCA--.46259S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWkXw47Jr4kAr1DZr17GFg_yoWkWFb_X3
	WrAFyDAr1UtrZrtr47CrWxCFZ2y3W5uF4093ZrJayfCFyYyr17Xay7uF1kXF17ur9xCa1D
	J34rXr1fuF1xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJV
	W0obIYCTnIWIevJa73UjIFyTuYvjTRRD7VDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQMA2qqpO9uFwAAs1

The device node returned by of_graph_get_remote_node() is never
released. of_drm_find_and_get_bridge() only uses it as a lookup key and
takes its own reference on the bridge, so drop the node reference once
the lookup is done, as meson_encoder_cvbs_probe() already does.

Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/meson/meson_encoder_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
index 5f2eeeaf93b8..4e1ebe617e49 100644
--- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
@@ -120,6 +120,7 @@ int meson_encoder_dsi_probe(struct meson_drm *priv)
 	}
 
 	meson_encoder_dsi->bridge.next_bridge = of_drm_find_and_get_bridge(remote);
+	of_node_put(remote);
 	if (!meson_encoder_dsi->bridge.next_bridge)
 		return dev_err_probe(priv->dev, -EPROBE_DEFER,
 				     "Failed to find DSI transceiver bridge\n");
-- 
2.34.1

