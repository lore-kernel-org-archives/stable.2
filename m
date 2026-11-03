Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699175;
	b=K1NlETBOVkua2LRKv8+OkcVqlci8cdhWFf+63T3W6nYMImzAqkq36I2QTXGUm2jNl0kl
	 +g/dkUd/ixPOiaYTcipwBT3LP395z6zd3mvw0iu6/BSe5nuioV+RRx5GA0t/VlH0SHgIN
	 o7p/ts5+zIMkoX5wNcNWq/wE7IfjY80jWK67BPsy7YZ32qhnsqwPkaOwLAfnPm3PmVxAq
	 oYF5Lpgq8IDcJb8+SDW2N2MKURXZnPOMndVZUCyHnXydOPporPPh1wCDIIgp7Hr9Yto8y
	 0fEHV0MoO6z8wnViAN1Ht2fIFe/8u0ftBWfOZOVI5SntYU9cf2Wx4x0r7ba4mfFEjAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699175;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=xCN7lqAWIy/cCPtTII2CEGih4Pfe5RnE8KoxouGg1fQ=;
	b=b/1bEn5YHe4ootEUv6VSAUVeIT53iYmvmSzDz3j5M7CFwGWxI3q4NWn2uUahMMt+P+Gt
	 IqsE/HadaWlAtqYhSSKXteRYMVkQebUpWml5+sruc2ZnRs7weVetGs83ZK0XtYDTE54yk
	 e0kKNvg0sCF03DoaeGbiIm6NhGH/ZfNLd+aKGEHSvuS1p/9WAVU+0y56rKb4BaaTFwK4q
	 4LwX9CpFgEsYqFyMyMYdLDCEPR/n0U5mLCRuuo4R0Gs4nqgwO8QhpbVBMEwFg1f1G5Gid
	 GQ47flsad3hvypwYHACnATp01W2vMedARm+qkK8rqtn/yKncGGk+JuJBgUfZz/4/xPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC2606A32E;
	Tue,  3 Nov 2026 09:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72BC2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3hpdjrelqCE87AA--.6196S2;
	Tue, 03 Nov 2026 17:46:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: radio-sf16fmr2: Unregister v4l2 device on probe failure
Date: Tue,  3 Nov 2026 09:46:20 +0000
Message-Id: <20261103094620.1289464-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAB3hpdjrelqCE87AA--.6196S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1fKFyxWr15JrWkXr48Crg_yoW8Gw1UpF
	WDua4YkFy7tr4UZr47WF10ga4Fk3WSv3yfuFWDuw109rWrKFWxArZ5XFWjya1YyrWxG3WY
	qry2q3y7ZFW8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXID
	7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcAA2rpnO5OMQABsM

fmr2_probe() registers the v4l2 device and then initializes the TEA575x
tuner. If snd_tea575x_init() fails, the error path only releases the I/O
region and returns -ENODEV. v4l2_device_register() takes a reference on
the parent device which has to be dropped with v4l2_device_unregister(),
but the callers of fmr2_probe() only kfree() the card. The reference is
therefore never released, and the v4l2 device stays registered after a
failed probe.

Call v4l2_device_unregister() before releasing the I/O region.

Fixes: d4ecc83b79cc ("[media] tea575x-tuner: update to latest V4L2 framework requirements")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/radio/radio-sf16fmr2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/radio/radio-sf16fmr2.c b/drivers/media/radio/radio-sf16fmr2.c
index 2cc91e576fcd..85d67257295e 100644
--- a/drivers/media/radio/radio-sf16fmr2.c
+++ b/drivers/media/radio/radio-sf16fmr2.c
@@ -241,6 +241,7 @@ static int fmr2_probe(struct fmr2 *fmr2, struct device *pdev, int io)
 
 	if (snd_tea575x_init(&fmr2->tea, THIS_MODULE)) {
 		printk(KERN_ERR "radio-sf16fmr2: Unable to detect TEA575x tuner\n");
+		v4l2_device_unregister(&fmr2->v4l2_dev);
 		release_region(fmr2->io, 2);
 		return -ENODEV;
 	}
-- 
2.34.1

