Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699172;
	b=xw5ZrgpSl6H6WQv4elqaYxkwQ0PomM95qsSEzI4KMjhnUL9M6vt0V7cFR8qQ5G4C+v2I
	 Jz2QG65HOFW5ju2rw5G4HvN2tsQl2JA/MEQ8qd6EtACXwC60kHhY2wtliHn7rNC7C1BX5
	 pAYLxJ9EkQiHq6j7fXdRNqGoYk+RD2lB9DiZA7ev8XaWMkla2Mp3Eq/3f8iahzpsuZJ56
	 J+6zG9I95oKK4V/AQQvZc74XM+oyCiN37V8AVYloJwRCHHI7r7Nvo2pJ5mIb9bkT8BF4g
	 vKHpECm9CpvXZDGPtbPNPsdHfD7Zi38AFPHxsA/AzM9rNwIY1GMYnFrmGfpDYBZkk8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699172;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=kjNW/BEZIJiWpD0QSBrblYoaP+4qh7Pt18KlmN+Uc64=;
	b=tWryj+47IBvFRzy/nt+xTsAlicb3oGfnxr0/uhalPT3ekwv/pGyGooeBB6XVqdAjeZnm
	 0X/PGJ78yut6JC6soUgSvhxFT7busN4/qhoe6zYqeFZESnirAZt9INTZXPyP4V1cl5R8k
	 lRwOpGDU4Kl8k7j35Q/10cVLsMqn+qUxSTbVhIGaXaLjtPXcuu1XTtxN/5pK7WC3qbghU
	 4ekejzQKSjoLFIZ4SUVnr7+YsfiwUYGQnbbi64yCeOXN0ToI+vALh61G/U9r1CU9oM4A+
	 Y/GAm2J4YeBrbKUxgfNBfXbfo1jTkRInVKB5Q3DD/200PPlaVQqyjPIzv1yTaXHPd3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CA606A333;
	Tue,  3 Nov 2026 09:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 800CA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADX4JFbrelqmk47AA--.2367S2;
	Tue, 03 Nov 2026 17:46:03 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Bin Liu <bin.liu@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: mtk-jpeg: Release the decoder device on job completion
Date: Tue,  3 Nov 2026 09:46:12 +0000
Message-Id: <20261103094612.1289250-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowADX4JFbrelqmk47AA--.2367S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1xGF4rCr1kury5AF1kKrg_yoW8tw1Dpr
	W5K3yjkryUGr4jqF18WF1UZFyYkrZ3JrWY9FW7X34xW39xXF1rtry09a4IqFZ2yrWI9a4D
	Jr1jqa97CF4jyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU7TmhDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgAAA2rpnIRROAAAs3

mtk_jpegdec_worker() resumes the component device represented by
comp_jpeg[hw_id]->dev.  When the job completes,
mtk_jpegdec_hw_irq_handler() drops a reference to the master device
ctx->jpeg->dev instead of the component device.  The component's usage
counter is never decremented, so the component and its power domain stay
powered, while the master's usage counter is decremented without a
matching reference.

Release jpeg->dev, the component device that was resumed, and disable
the clock before dropping the reference as the timeout work already
does.

Fixes: 0fa49df4222f ("media: mtk-jpegdec: support jpegdec multi-hardware")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 32372781daf5..017c9b5401c6 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -547,7 +547,6 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct mtk_jpeg_src_buf *jpeg_src_buf;
 	enum vb2_buffer_state buf_state;
-	struct mtk_jpeg_ctx *ctx;
 	u32 dec_irq_ret;
 	u32 irq_status;
 	int i;
@@ -557,7 +556,6 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 
 	cancel_delayed_work(&jpeg->job_timeout_work);
 
-	ctx = jpeg->hw_param.curr_ctx;
 	src_buf = jpeg->hw_param.src_buffer;
 	dst_buf = jpeg->hw_param.dst_buffer;
 	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf);
@@ -580,8 +578,8 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 	buf_state = VB2_BUF_STATE_DONE;
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	mtk_jpegdec_put_buf(jpeg);
-	pm_runtime_put(ctx->jpeg->dev);
 	clk_disable_unprepare(jpeg->jdec_clk.clks->clk);
+	pm_runtime_put(jpeg->dev);
 
 	jpeg->hw_state = MTK_JPEG_HW_IDLE;
 	wake_up(&master_jpeg->hw_wq);
-- 
2.34.1

