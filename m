Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070055;
	b=iVF00dtBU/WvcycG0/2BzcHz9Zg5FhQkEvchfrdzjTnq4dhlbCaLwfVUGjN07lx/zDxR
	 /fbDKIhCn2AyPTgi5fYPIaLQT7dTcn2W+lqNhaCSM1AJC32sW+vi91A5+Kl/Oqb94uKGI
	 KXD2p+gdIwVP+j5lDj8w2osSqrAVL5zowPH96Wo2Em2oneUxZCVaMZtPOg2ySbEeE5Ggf
	 Rc7aCWYuL2tobNM0jPj7+ObYF/SYYfwWwEo2yVx+PTmC7WxPZQhUG7O6XHCxKjWycyf2x
	 lV9aaK7rM5y5BmF550TCkQKOks/qJhvw1mDnnRTQ3JdYrY350niLj+BMV4CxG+F46jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070055;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=ItbgdgnENEoPsdQ6poBV1dztwqhADCnafQjgGSY9xfU=;
	b=psmEoPEW/FIUmKyvRY1+ohoHZAdhh7nQmRBIvlaqyk/gXBK/MrO5/0EskXNvm5sXJAWr
	 yFLdlfeECwjMRGqnc+BVIMjUzVwgx7Vi9eNatxXzXtK169rBQ+AiSgzrZ627+VAPMHsN6
	 /+F3wRd5E+LZlypAMcoljYVMC314zLzoOcHq13Kv1iOOhrX2CQuE0daeOTVAIyxj11D6j
	 tqGtt5k9jj/9A6zfbBlqftD1ZoImQebUka2zJzgxoK4To80RABVp6GOzVeUszDP3r1RL9
	 yhRSFnoCGYCnupNYfehzJ1r0iUO8RF9023HjYGxJsHNf4X93GrU/BrePMt66fSoL8Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D53606A326;
	Sat,  7 Nov 2026 16:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90D53606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QpMeVu9qDB6CAA--.41016S2;
	Sun, 08 Nov 2026 00:47:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bin Liu <b-liu@ti.com>,
 Linus Walleij <linusw@kernel.org>,
 linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 vulab@iscas.ac.cn
Subject:
 [PATCH v2] usb: musb: ux500: Fix transceiver leak in ux500_musb_init()
Date: Sat, 07 Nov 2026 16:46:53 +0000
Message-ID: <20261107164653.481516-1-vulab@iscas.ac.cn>
In-Reply-To: <2026091648-ozone-opponent-8a42@gregkh>
References: <20260916165055.2085246-1-vulab@iscas.ac.cn>
 <2026091648-ozone-opponent-8a42@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowAA3QpMeVu9qDB6CAA--.41016S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww48Jw1DGF1UZF1rJF13Arb_yoW8KF15pa
	y7Gr47CrWDK3yIyF42qr18ZFy8Aa97trWFkry8Z3y3Zr98G3W7WFW5ta4FqFW8Gws3CFW5
	tr4Yqayv9rsIvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUjd-PUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAEA2rvPp4hhQAAsK

ux500_musb_init() takes a reference on the USB2 transceiver with
usb_get_phy() and stores it in musb->xceiv. If the following
usb_register_notifier() fails, the function returns without releasing
that reference.

The reference is only dropped in ux500_musb_exit(), and that callback is
not reached on this path: musb_init_controller() jumps straight to its
fail1 label when musb_platform_init() returns an error, while
musb_platform_exit() is only called from the fail2 path. The reference is
therefore leaked.

Put the transceiver on the notifier registration failure path. The
notifier itself does not need to be unregistered, since
usb_register_notifier() failed and never added it to the chain.

The bug was found with a static analysis tool; the candidate was then
audited and the fix written with the help of DeepSeek-V4.1-Flash and
GPT-6.1-Sol, and the result was checked by hand before submission.

Fixes: 0135522c4898 ("usb: musb: ux500: add otg notifier support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260916165055.2085246-1-vulab@iscas.ac.cn/
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
 - Do not add the Assisted-by trailer: current checkpatch.pl reports it as a
   non-standard signature, and Documentation/process/generated-content.rst
   asks for the tooling to be described in the changelog, which the commit
   message now does. Say the word if you would rather have the trailer and
   I will add it back.
 - Explain why musb_platform_exit() is not reached on this path, so the added
   usb_put_phy() cannot double-put.
 - Code unchanged from v1, so Linus's Reviewed-by is kept.
 - Sorry it took me this long to come back, and sorry for the extra work of
   chasing it.

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

