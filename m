Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0BE190462;
	Sun, 28 Jun 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782656587; cv=none; b=N5we6YWIqy3p7cI9G0nHP3GqIHtrdUt3wsedndEjCQSp+lJuUZXhqStpkh0v+26LJhQZvHdQ3i3F6o+oA4vO5tWPJ8KDq+x0FmJ+OBSjvRWIQUlfVKe/Yde0DSNNXs/0vhV2g0KissQgfKrzXtebkRu4yiZ093OKTBsP2ZOl3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782656587; c=relaxed/simple;
	bh=65Ql2KUq7jW4vofmyKLRkuByMJ/5kZJQVrd8+qcqvAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jh/2wbqndN9fgKHuA8jMDT/6vE4J/96SjcAyuO3RRWycqyY8iQ73IM8sBeJB7y5FL2Dftf98zK1JZp6zdNQpSm9LJxxgyfr0NfrglDQ1/bBT1yKoMx9Y/dTU0Ikym6lsHAgTCx4E9yT/vqPqZWPAOf4ewVikox35RGitnUUR3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowAAXnP8_LkFquD7IFQ--.8366S2;
	Sun, 28 Jun 2026 22:22:56 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/mediatek: fix of_node leak in mtk_drm_probe loop
Date: Sun, 28 Jun 2026 22:17:51 +0800
Message-Id: <20260628141751.47090-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXnP8_LkFquD7IFQ--.8366S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8ur4ktF43Ar4xKw1kuFg_yoW8Wr45pF
	WDKFWYyrW0qr4xKFyvyFyUury3A3WSqayxWr4Yg3WxZwn8tFy7XFyFqay7KFZ7AFyxC3Wa
	q3Z8AFyfury7AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOlkVUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMMA2pBKkEGVwAAsb

In the for_each_child_of_node loop, private->comp_node[comp_id] and
private->mutex_node are assigned via of_node_get without first releasing
any previously stored reference for the same index. When the same comp_id
or mmsys_id matches multiple nodes, earlier node references are
overwritten and permanently leaked.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index c86a3f54f35b..58860f7071a9 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -1138,6 +1138,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 			id = of_alias_get_id(node, "mutex");
 			if (id < 0 || id == private->data->mmsys_id) {
+				of_node_put(private->mutex_node);
 				private->mutex_node = of_node_get(node);
 				dev_dbg(dev, "get mutex for mmsys %d", private->data->mmsys_id);
 			}
@@ -1154,6 +1155,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 		if (!mtk_drm_find_mmsys_comp(private, comp_id))
 			continue;
 
+		of_node_put(private->comp_node[comp_id]);
 		private->comp_node[comp_id] = of_node_get(node);
 
 		/*
-- 
2.39.5 (Apple Git-154)

