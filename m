Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5989409623;
	Wed, 16 Sep 2026 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543279; cv=none; b=bpJMiVx4Cyg7+JGz7WOm9lYP6xvC/B+QzWnKiwY/B/GcwmZeIFXq+FHRKGGFd7Z1BInRud0mt7cjElafsfExV2CrGwgyRxAiN32B6FPOkcc7eC5bCJc4QwCsIPOKV2Yyr8BCxIUBnPFnxvWhKSDKtngNgo3Z5MyxI+SjyJ13bI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543279; c=relaxed/simple;
	bh=gurnQ7mS9wql9AVhvGW4GnYPC4RJBT6T11So43XKU1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bzmKnof1+zY1JbGbBDdwYdWxsU3NmTIdDqoGneD+yp0JsbUhRdEnV/5FqXihna8C+zn2OUpnD4LXhBqbQfHJBp9RmTP5Q5rBA/ZneIriQmqLmpudoCQVqsGWGAYMR96UwupeOEU3X3P7MBPZIhwkAaeKcKnIfWG2/Pi7gAzqYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wkBIQ6pq3w3fBw--.65491S2;
	Wed, 16 Sep 2026 15:20:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: alim.akhtar@samsung.com,
	dri-devel@lists.freedesktop.org,
	inki.dae@samsung.com,
	krzk@kernel.org,
	kyungmin.park@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	seanpaul@chromium.org,
	simona@ffwll.ch,
	sw0312.kim@samsung.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 10/20] drm/exynos: dpi: Fix OF node leak in exynos_dpi_parse_dt()
Date: Wed, 16 Sep 2026 07:20:12 +0000
Message-Id: <20260916072012.1967169-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wkBIQ6pq3w3fBw--.65491S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4xZw4DCrWUCrW3Wr17ZFb_yoWkZrg_CF
	1xZFyxXr15uryvvrsrAF1fZr929Fn7uan3CayIvFWayw15Ar4YyFW3ur18ZrW7uFW7W3sr
	G3Wjv3W7tr1xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUCNtxUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2qqP7kPgAAAsL

In exynos_dpi_parse_dt(), ctx->panel_node is obtained using
of_graph_get_remote_node(). However, when "display-timings" child node
is present, the driver uses display timings directly and ignores the
panel node without releasing the acquired reference count.

Call of_node_put() on ctx->panel_node and set it to NULL when
"display-timings" is present to prevent reference leaks.

Fixes: 86418f90a4c1 ("drm: convert drivers to use of_graph_get_remote_node")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/exynos/exynos_drm_dpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 0dc36df6ada3..0b64d1031951 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -168,6 +168,8 @@ static int exynos_dpi_parse_dt(struct exynos_dpi *ctx)
 		int ret;
 
 		of_node_put(np);
+		of_node_put(ctx->panel_node);
+		ctx->panel_node = NULL;
 
 		vm = devm_kzalloc(dev, sizeof(*ctx->vm), GFP_KERNEL);
 		if (!vm)
-- 
2.34.1

