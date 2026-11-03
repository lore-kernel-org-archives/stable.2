Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694930;
	b=xbRt4daAmwPTNyuV5ev5LcFueaE10ZPh6Ws58DkuUdbo+ge9++6GEoufa/qDASGGhTpc
	 4bY1u0C/SEWbU+nFVRIofhsrAN3Zsp8iizWOA5xsYlH1yQwdkRxJkyZzPlI01AM2BhicH
	 lF0/0kkMJ27nijdKxidgnOuaOI2+X6g1lVvCglUrKO4DU3UF7taWXc1+BKO106Gw2C2He
	 7YOskJxPgE13B8Z7yzDAezH5qtPH0QB7xjwL2cgDplepm8hddYD2zHdSOD1o7giLqCvHp
	 6goDrebgiIxfufSa7RSGOh9PS5B3kyC18uAgRdsccbdhuipehHBjakCzIO70P9m29QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694930;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=/++6gQgv4rDBRyHw0HFXknbo6zEY8ME7pabSVyOedNw=;
	b=r2JfvndCYhfTyPbuDzM9GLEA8u1FTMMsZjgsn2zwa0T5prrJK5sTl/2WS4i1g3FYSfPa
	 YcR15HZs1pucWokUfaovJxjxgUxPZMshg4IUkzclEwJozPKrehJdF/top0iiw1uUzTpMg
	 9pPREpfVihFsytrT0/SDfIBm9Yz5ay7SZAlNilBdIPurTC9uzXoN93x/M8zoUJYGiv+5o
	 lQAbTnqKMi0ENOX9PfEFJ65Z1hw236BPKqnCy92MatpaSkmoMieHEBKmZ/w8mSl3YFM9Y
	 YGawejgkDNHEDCqRx8Q+MD9mh4IK7eog/57H1UNZpsGDMjSokkzppHhjFkF4KAKXhgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D19606A32D;
	Tue,  3 Nov 2026 08:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D19606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wJHMnOlqqII6AA--.1383S2;
	Tue, 03 Nov 2026 16:35:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	yunfei.dong@mediatek.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: mediatek: vcodec: Free encoder controls when setup fails
Date: Tue,  3 Nov 2026 08:35:33 +0000
Message-Id: <20261103083533.1176842-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAC3wJHMnOlqqII6AA--.1383S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy3Ar1kXr43Xr48Jw45Awb_yoW8Cr18pF
	yxKrW2ya4UJFs0vF48Aa18ua4YkFWfWryxGan0v34xA3sxXr4xXryIva4fZFZ7GrWDKa45
	XrnFv34xWr4jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMAA2rpWwr-jAAAst

mtk_vcodec_enc_ctrls_setup() can fail after creating some controls. On
that error, fops_vcodec_open() jumps past the control handler cleanup and
frees the context, leaking the handler's controls and allocation.

Use the same control handler cleanup as the later m2m context creation
failure, and remove the now-unused label. No m2m context is released on
this path because its initialization has not been attempted yet.

Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c      | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
index 4e4541b2fc8e..dd47feea6acd 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
@@ -140,7 +140,7 @@ static int fops_vcodec_open(struct file *file)
 	ret = mtk_vcodec_enc_ctrls_setup(ctx);
 	if (ret) {
 		mtk_v4l2_venc_err(ctx, "Failed to setup controls() (%d)", ret);
-		goto err_ctrls_setup;
+		goto err_m2m_ctx_init;
 	}
 	ctx->m2m_ctx = v4l2_m2m_ctx_init(dev->m2m_dev_enc, ctx,
 					 &mtk_vcodec_enc_queue_init);
@@ -191,7 +191,6 @@ static int fops_vcodec_open(struct file *file)
 	v4l2_m2m_ctx_release(ctx->m2m_ctx);
 err_m2m_ctx_init:
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
-err_ctrls_setup:
 	v4l2_fh_del(&ctx->fh, file);
 	v4l2_fh_exit(&ctx->fh);
 	kfree(ctx);
-- 
2.34.1

