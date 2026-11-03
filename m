Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702560;
	b=YyFH0svCgALaQcrqb9TeZgD3cMbNYDjKMAuVb3Lgnu5PDMgm5SUyFAbBaATcS5Fil4G4
	 5dCTv+CePmHXbyiNBBGAc3S9QVr5z1P4SD8SKn+Jz2gRauRDu15t4i4DuAWS66HhFF+Is
	 2tz3bN2KmOzTNwX1breNRxr6nQ5AtiYe03ze3oQUehplGivDVH//FVGA6pymLTk83iRR6
	 krwS9JQqODqo2p68Ze6OkAeUHZQGTqKWdSbMMAbWiO8/X6zFBTXBARQk/8SK+N9CuskbH
	 t/zBUGqjhchvxodXQicQRVYuyKsDLHrs8b1unj8a53uWzAiIOR7/ZECrdnrEkfWsglQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702560;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=+zlqU5HK4GJzXTnocF1qUvTVp5xgIdL568uCk9xt6J8=;
	b=iTi+Bqaz4D2ibr6OdrAiTLlo3KnFEPaQHKgqkW3EEL9rgwINsqqgbLFVcw1t3AyQ3hrI
	 KexhBxUR2qSRsXdCTdDGta9ayx20nIJsMnY/HNGBZJx0F4OXXG4KL4lwGcLYO0DM124F8
	 cDTHvDGYXZaVe21YB2nbAQk8DXz5UcKcKnAk38aYaBcNEzcTHNwfzDMxZC8cPNGYl4mUx
	 VI3NkLpuUdAh8wVp37F14B9nUTBPnioVr+gZiSZTJ4e546oAtoypA9cDWXMokhdW5Kg2L
	 ftFyRlx4kL5ONVb/Zzp+uG7T/cCSyHilk0rKcVlHIqqSmv7S1mFjVFZz65sRMcS6EFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A160819C6;
	Tue,  3 Nov 2026 10:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05A160819C6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHF5iZuulqvcg7AA--.3211S2;
	Tue, 03 Nov 2026 18:42:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: bcm: release the NS2 pinmux controller on detach
Date: Tue,  3 Nov 2026 10:42:42 +0000
Message-Id: <20261103104242.1373883-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAHF5iZuulqvcg7AA--.3211S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxArWDury7uFy5Kr1rJFb_yoW8XFy7pF
	43XFy5Krn8tF45ZFW5J3WrWFy3Can7Jry8C3yDK343XF45JrykJFyYgFWrJF4kGr40kr4Y
	yr15J3y7urn8AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	yj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07bOAw3UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQAA2rpnOF67gAAsh

ns2_pinmux_probe() registers the pin controller with pinctrl_register()
and stores the returned pinctrl_dev in the driver data, but the driver
has no remove callback and never calls pinctrl_unregister().  The
controller is therefore never unregistered and its memory is leaked
when the platform device is unbound.

Use devm_pinctrl_register() instead so that the controller is released
automatically when the device is detached.

Fixes: b5aa1006e4a9 ("pinctrl: ns2: add pinmux driver support for Broadcom NS2 SoC")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
index 23ab3ab064b6..a1480641ee0b 100644
--- a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
+++ b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
@@ -1077,8 +1077,8 @@ static int ns2_pinmux_probe(struct platform_device *pdev)
 	pinctrl->num_functions = ARRAY_SIZE(ns2_pin_functions);
 	ns2_pinctrl_desc.pins = pins;
 
-	pinctrl->pctl = pinctrl_register(&ns2_pinctrl_desc, &pdev->dev,
-			pinctrl);
+	pinctrl->pctl = devm_pinctrl_register(&pdev->dev, &ns2_pinctrl_desc,
+					      pinctrl);
 	if (IS_ERR(pinctrl->pctl)) {
 		dev_err(&pdev->dev, "unable to register IOMUX pinctrl\n");
 		return PTR_ERR(pinctrl->pctl);
-- 
2.34.1

