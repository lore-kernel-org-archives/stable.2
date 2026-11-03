Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699172;
	b=PPMRIgPosVZ2dU3xZZmbebgLJdT8qWyJwdR8SxR3swlcXpsnYQ1xnGw2yIJ1pCLvXaH4
	 K2h5QcUrM80oHqwMXppPenKTN9Kmx/EtGafpAPpBStfwndoMpo83SnGOYBnA28UYJVBAf
	 YmFYXvREXky1XtspBKIpLTn2KPnGMMigQJsGRF3uwM0bnSDxm8I0PxILXnKilaZ2yOsRH
	 Rl80y5+3tGj9c7wKiDKmTm3OTn8yrDkgbNAQ/yxYE8fJsVLsYkNfoZwQ3IYoiTV5X5INI
	 1fKRRQitPxtbX875DMhHAfKTls3sXfltmairWkLltd8CpS2xqQRewJe+oKl/OM7PUDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699172;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=g9BfrTwOVq3RO38kAJOz1W2BpOwCmLhuBLRld4KZ9w8=;
	b=10SxMe+x5jNrZ00VowgDdEYb0UlgL8sm8Zhw3mE6G+7k7Jf3Oi38JrzqY8uCOq/0q35P
	 Ob21jJ17ew8jZnxd6MFN4W7+Lz0qkeoZ4frE78z1mCpJydGptc7mH6R8do9JBp9KIhL47
	 BQbrP2U/QClvEDfePREqBg7/s5GzrGOwZdOKrLw+96fd7z+A6uw5bA4CEWJCwpXcWFZfi
	 oZDp3V3CQWtKjas8isqCO3tcEFdpdoy3puV1G9SiK9ow54ncGi2FmP/c1ywUvBImhayC+
	 69oa0N95LMWfM0PKrjPo+Jy/w5ey+FbFZZEUmRQ/FXeQnIBHmcmLpMBdB+TJOp53SKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80039606A332;
	Tue,  3 Nov 2026 09:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80039606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADn9ZZcrelqpU47AA--.2317S2;
	Tue, 03 Nov 2026 17:46:04 +0800 (CST)
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
Subject: [PATCH] media: mtk-jpeg: Release the encoder device on job completion
Date: Tue,  3 Nov 2026 09:46:13 +0000
Message-Id: <20261103094613.1289270-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADn9ZZcrelqpU47AA--.2317S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfJryUWr47ZF4rXry5Arb_yoW8WFW3pF
	W5K39IkrWUGr42qay8Gw4UZFyYkrZ3ArW5Gryxu34xZ34fJ3WfGryjka4IqFWxArWI9a4D
	Jw1UtayxCF4jkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcAA2rpnIRROQAAsx

mtk_jpegenc_worker() resumes the component device represented by
comp_jpeg[hw_id]->dev.  When the job completes,
mtk_jpegenc_hw_irq_handler() drops a reference to the master device
ctx->jpeg->dev instead of the component device.  The component's usage
counter is never decremented, so the component and its power domain stay
powered, while the master's usage counter is decremented without a
matching reference.

Release jpeg->dev, the component device that was resumed, and disable
the clock before dropping the reference as the timeout work already
does.

Fixes: 934e8bccac95 ("mtk-jpegenc: support jpegenc multi-hardware")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index b312a15d707b..266bfff604db 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -303,8 +303,8 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
 	buf_state = VB2_BUF_STATE_DONE;
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	mtk_jpegenc_put_buf(jpeg);
-	pm_runtime_put(ctx->jpeg->dev);
 	clk_disable_unprepare(jpeg->venc_clk.clks->clk);
+	pm_runtime_put(jpeg->dev);
 
 	jpeg->hw_state = MTK_JPEG_HW_IDLE;
 	wake_up(&master_jpeg->hw_wq);
-- 
2.34.1

