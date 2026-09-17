Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7E4B8285;
	Thu, 17 Sep 2026 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639500; cv=none; b=BbXmA6d28VagtEhJBxSjF2/heC7cipffvkP52Hhzjt2+6mjkHyeD863kn3MY7STYWhWMzI5xVJ4ILy04RtGrKM6wjhnCwssG16ZTT3x32cKd/Bn7R1AAm+CIVKXHT43P1xN7Kp+JCYxX6sw8WDy7BRl6kBvSaVLxIRAYreUgf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639500; c=relaxed/simple;
	bh=Ak7fvPogaLyU9xIV3FE8AiWefrYMu//zBqTl4UnO6Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s9i3aAlEW9sMqCghOmxoEaCpBS/PT9DCxDnbRzdTA1CE9YSJpoCD15aGBkprI/jMl1IT8TzajxiMm4lionOFIXtpDDFoZ6+B/TYrWQQ5Iaz2p1q8r//ZVIZssZIUsQqU9h1RrSBKuXwbNBJtmyyUfOZNs0S5CVpTfk5rYFKcfUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAnlT81u6tqx0B+CA--.291S2;
	Thu, 17 Sep 2026 18:04:37 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: angelogioacchino.delregno@collabora.com
Cc: bin.liu@mediatek.com,
	hverkuil@kernel.org,
	irui.wang@mediatek.com,
	kyrie.wu@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	mchehab@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: mtk-jpeg: Fix runtime PM leak in mtk_jpegenc_worker()
Date: Thu, 17 Sep 2026 10:04:37 +0000
Message-Id: <20260917100437.2145943-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnlT81u6tqx0B+CA--.291S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4xtrWfJF47Xry8JrWxCrg_yoW8AFWxpr
	WYqa4jyrWDWw4Dt3yUAw17XFyYk34Fgr1UWr4fC3WkZws3J3Wft34UZFyxtFWIvr97ua48
	Jw40q397Gr4jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxUqdHjUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgINA2qrq3Y+CQABsg

pm_runtime_get_sync() leaves the device's runtime PM usage count
incremented even when it fails, and a failed clk_prepare_enable()
drops the reference as well.  mtk_jpegenc_worker() jumps to enc_end
in both cases, which does not call pm_runtime_put(), so the
reference taken by the successful resume is leaked.

Use pm_runtime_resume_and_get() for the resume failure and release
the reference explicitly when the clock cannot be enabled, as
mtk_jpegdec_worker() already does.

Fixes: 5fb1c2361e56 ("mtk-jpegenc: add jpeg encode worker interface")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index ed1d5858c942..23691f695b56 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1622,7 +1622,7 @@ static void mtk_jpegenc_worker(struct work_struct *work)
 	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf);
 
 	mtk_jpegenc_set_hw_param(ctx, hw_id, src_buf, dst_buf);
-	ret = pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
+	ret = pm_runtime_resume_and_get(comp_jpeg[hw_id]->dev);
 	if (ret < 0) {
 		dev_err(jpeg->dev, "%s : %d, pm_runtime_get_sync fail !!!\n",
 			__func__, __LINE__);
@@ -1633,6 +1633,7 @@ static void mtk_jpegenc_worker(struct work_struct *work)
 	if (ret) {
 		dev_err(jpeg->dev, "%s : %d, jpegenc clk_prepare_enable fail\n",
 			__func__, __LINE__);
+		pm_runtime_put(comp_jpeg[hw_id]->dev);
 		goto enc_end;
 	}
 
-- 
2.34.1

