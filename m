Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7E4D7974;
	Wed, 16 Sep 2026 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580500; cv=none; b=LAz8PWTsjQVBN7+QIF5h/KcruFX6TfA0Wa0AkoMO5s9PDojJfXXgmXwTH3CQcOTnLlnQl/PRt1AVQYWXFQj+jbMIDSc5tVbUm+8/yTzIc2geGlw3/X3MJzYp2MCMXoj7dWAtKIfJYr0zxhpwlrLapyvMFvvorVqRIBTXRS57zbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580500; c=relaxed/simple;
	bh=EH0BzP903cSkSkhDTZkQ+8sdinNENNzCjFFusjW4ZFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MBgAoh7503Xb2GKobrEOdaw0RbDXxpw5I5WTNwwJfO0LevPvRst7u7i6V5v5OSV0LLZcv1L9zQiIC5Fsy707/T/QTZXrJkyhu5XFbk/WKcqTBQfazAOoscsr4Hb3YEkyBAK7LGcN7fFmbp75Os4ntkCRL0/2dYx73shs1IkYFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3pD7F1KpqYcxuCA--.22580S2;
	Thu, 17 Sep 2026 01:41:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	chunkuang.hu@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	nancy.lin@mediatek.com,
	p.zabel@pengutronix.de,
	simona@ffwll.ch,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: Fix pdev reference leak in mtk_drm_bind()
Date: Wed, 16 Sep 2026 17:40:58 +0000
Message-Id: <20260916174058.2088709-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3pD7F1KpqYcxuCA--.22580S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur4fJw13KFykGw4kJFyDGFg_yoWkuFb_C3
	ZY9rZrWrsrCr1qkw47A3WxZry2yFZY9F4rJr15ta4Iqry7Xr1jqryqqF9xXFsrXw4xAFyD
	J3srZFyfGF1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6r
	xdYxBIdaVFxhVjvjDU0xZFpf9x0JUtgA7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgMA2qqpVhohAAAsR

When the device is not the mmsys master, mtk_drm_bind() returns early
after taking a reference on the disp-mutex device via
of_find_device_by_node(), without ever dropping it: mtk_drm_unbind()
only puts mutex_dev for the master. Drop the reference before returning
from the non-master path.

Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index c86a3f54f35b..e46f3ab2673f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -638,8 +638,10 @@ static int mtk_drm_bind(struct device *dev)
 	private->mtk_drm_bound = true;
 	private->dev = dev;
 
-	if (!mtk_drm_get_all_drm_priv(dev))
+	if (!mtk_drm_get_all_drm_priv(dev)) {
+		put_device(private->mutex_dev);
 		return 0;
+	}
 
 	drm = drm_dev_alloc(&mtk_drm_driver, dev);
 	if (IS_ERR(drm)) {
-- 
2.34.1

