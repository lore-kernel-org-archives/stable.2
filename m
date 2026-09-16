Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C944D0CD8;
	Wed, 16 Sep 2026 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577500; cv=none; b=YTRl5FyeczrpOlLYRlI1jmue9TZPsaC+GWNSBbwk6ZHzUjUGprpPcPAiZsob4HWay8IKITVCOyrJF0G0MymZd/8Sw/f6FnHPUakSGTsLM3APpt62W9pjtLhwaXD3hXtBSnIYdVhxMSjdiKryIeVtyHmnsShIQk8wuxNJSe2fcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577500; c=relaxed/simple;
	bh=xxzakaPh0lUhoJAtvNnYoK1Ln5B4KdJOK7jGOreOChI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VvnMWX3141Yp3RUx1AduAvYoGRTJIJv2VKpAs3GHxALxMjaaXBsKUP1sW99lcSdomoTJcUQD98S4yw8Rmo0NoYqzaSofH6XjsI5mpXtZ5p/J8aq5egRbx8tOkQ6t4a1W/KD+c3qa1DPPHyQ2cIHEvzgiQzQfiK4OvNCevEsI88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH7zkKyapqDvxtCA--.22407S2;
	Thu, 17 Sep 2026 00:51:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: b-liu@ti.com
Cc: balbi@ti.com,
	fabio.baltieri@linaro.org,
	gregkh@linuxfoundation.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: musb: ux500: Fix transceiver leak in ux500_musb_init()
Date: Wed, 16 Sep 2026 16:50:55 +0000
Message-Id: <20260916165055.2085246-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH7zkKyapqDvxtCA--.22407S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtrW5AF45uF17ArWxtFWUurg_yoW8Jr17p3
	y3Gw48CrZFgay2qF4jqF4rAFy8Za92yryFk34xJ3sxZrsxJa47GrW5Ja4FgF18Cw4kAFW5
	tw4YqFWUurW8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	UPEDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAMA2qqpVhTIQAAsH

ux500_musb_init() takes a reference on the USB2 transceiver with
usb_get_phy() and stores it in musb->xceiv. If the subsequent
usb_register_notifier() call fails, the function returns without
releasing the reference, leaking the transceiver. The only place the
reference is put is ux500_musb_exit(), which is not run when the init
fails.

Put the transceiver before returning on the notifier registration
failure path. The notifier itself does not need to be unregistered
since usb_register_notifier() failed.

Fixes: 0135522c4898 ("usb: musb: ux500: add otg notifier support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/musb/ux500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 8c2a43d992f5..14c5e986937e 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -155,6 +155,7 @@ static int ux500_musb_init(struct musb *musb)
 	status = usb_register_notifier(musb->xceiv, &musb->nb);
 	if (status < 0) {
 		dev_dbg(musb->controller, "notification register failed\n");
+		usb_put_phy(musb->xceiv);
 		return status;
 	}
 
-- 
2.34.1

