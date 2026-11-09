Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223906;
	b=5WXsKVp3xw2lMLzoiWS6ntltP7P9tpWd23oi9HTQTLqfs4/ll3Qz8FpkOLwHq3zYTew9
	 gLuiZFxfaBkgm92UoP6EK1NOOzhRgwnMpXF34ktpTNz877gA/TPXTlG0o1k2GV/x4d53n
	 YlHEJIGvWjRN49yl5PqFONmn/eYtGL2xlO4gSVnnuyAkcazKrnzetm8zw6OG9XIChw+jR
	 tDF7yebXGT4SoSvMpkGDckpA6DwPZhpUkQgzu8JOS7e7ggojKiB5uCNahBfUhYGb+vLxy
	 1F5pKhI4KFYJEtRap/mgWcIiZVj/5H5ODacREWF3H12lTjXLKVjkc7GP+t05r0d28dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bIa1ynwYPh6ExB4St17D8gCLUqTxfSws2zY1owFapPk=;
	b=AP3ffjjNhQYMsrGVAuOFrYAATWwnzzbj0C5DfCvzHNSQYVTx8ZTSUrKQMXZcjm3zfB+y
	 181qLHaQDh75KYY7Kwg0xFa9h/DyHIDqhxW0ZDMQOd5JlcywjMqIuhNRyYRRTTk3IMf1I
	 ZDZHQ8vBoymsA60pbMFfyvpOlLH+kuusihGVVQrcxJqohD/B1YH3Z3wSQhDgW0Dws7vOk
	 jczB077u/H/lADcBvWryIFmdjYkMFTnubb0hLNJo84OmbWeec48VQNIpM+8IIk7SMpZlp
	 LJzvHUHzj6oFL3p9IMizUq+vYSme1X6SkE7yoCuKuIzmK3uZ/YMWWM1kRT6djuew/3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZMAYU6u;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21675606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21675606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZMAYU6u
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1931ff67a29so1963395c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 03:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794223905; x=1794828705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIa1ynwYPh6ExB4St17D8gCLUqTxfSws2zY1owFapPk=;
        b=NZMAYU6uFUwUQfR10zJ0gom2mrhC6KEARAAK7SbAgFMuz/8sRumMHfJipcQcoCs50j
         T+UzH9+2TDisbsCBJmw34cQed6RgOKg+bC4wCQWqLtEqh8NyWlTdjsEUt+9koU4n2SjF
         Z04h+MoOz4M5KC7DqpRGQ+8iHhjfcLlzxXgYOADMBXZsZ1QYv5txSUfTlubDUprim10p
         1o48vHi3PjMcVDLLk3lR4Nt6PfO/8UlWZ1FSY/Uofrw8wqeJ4O8Xv/CmEZtM0snmuloD
         26nK8OnuAElYYeUYfhhg0aQIVhVWNU4FyvDiDWLVJJ8Milif2k2s+otQlmFd507wBMcD
         uacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794223905; x=1794828705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIa1ynwYPh6ExB4St17D8gCLUqTxfSws2zY1owFapPk=;
        b=fhKr1+lkLXlYNRnFIOWuen3HzRWFPLrPafD2yZJnHt/S4xtW67jgwqTg19IKZWZoRT
         sYDd+q/Fa4CabJfIUBEAGD6QLfEiwsluWIaWMd+eXpniNC1Z92puG5fjcxAYqcOHLAB/
         LY+xskkH86WwpcqResPbU22dzXcqZeFI3zCGpOeLJrgW0hfnvNIZ72+m7nHw2QFxog4d
         USJpMOh6ifpOHuLvkKNSkjkoPOdqMEWzTCp4wm4pFvQd+qVoXo8J0wsOw1OFD7WTM+Wa
         eHNUIwJ4nsvZpKf9pW0Dn7PeUssWjR8u2WmfVJqv2x3+84L2rDp7awznHFrOloOYNrgr
         a7nw==
X-Forwarded-Encrypted: i=1; AL+hErESW1aFZ0mmJCf/OECYjx4HNJe3LKNOAX41YIg5/SgWcgrCmgcvQ0Qg3NND2QRBoSLky5Fk5PE=@vger.kernel.org
X-Gm-Message-State: APuU4Z99x9R5ybBzi4xL1DCvVtXaOuilcX6MiuPgHeKrS1dfIa3cleRs
	2EzLhMzrT2M0z+aixGH6dqfkDIgMixVimT5N/4oDwyhAKjszCsbQn2WE
X-Gm-Gg: AYBFou0kEqXjtvFRqXpqw9bqbCoh6w/iz1SNp/bIbfPiQSP3vYL2rTO27OhwQNPHtmP
	oWmrMWQ1sXmPNA9tkfhEPhzQwf7cmxQfUIYWHL/kTTo2igZIKTXxM+3jFRyxwQ2Iw/9wg2lCLmg
	sBcPZ5YGetVpEXAyVuYJnVxesWgnW97Cy4FhtTT8YdVj1j798hSUb2JbJY91yG1XbirwBbkuQSs
	K6KBtTH71AlOaRss3c/GgmNWvIpYdy6Xm1/nqDcGOJX3mYwVMcFLoqDQgz8ghV4Q7eKYHydnD1r
	p+TGBAYty/xTlGgyyo4f0+DELju6dLi675L1M8nLcc4kleuBo8XUsqRfvQ8/cuBmnrqvdcM9Hcv
	+/w7x+4Air7iV5QLHW1eXHyQMCZLx/t4y167ytvMBK5PPYDliHOFR21wbFpvFm7tMvuvOAxdCtP
	DKnodnQHfs5ORrf5y3nxp4rw4n8Z1OqifcIFAvc5iLv0EcqCxjmRzIPdXyznfn2NImE+hJyr4Uz
	6jRX2q+HquZtflrXOua1ZWyqGXLtus4jGYRNgGndPWslXvf8NOfed2KPfK2i1oicHvwk9S9vUpH
	i0ctvHQjKrRC5NkXv6tzJsunrAnGEYXKQJS8vJI3PMl4zECAw3Aw4Bv+XeSI0oaL5f1Ebw==
X-Received: by 2002:a05:701b:2401:b0:1a1:47b2:5512 with SMTP id a92af1059eb24-1b39feececfmr6126165c88.26.1794223905110;
        Mon, 09 Nov 2026 03:31:45 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771f0e0fsm17762322c88.20.2026.11.09.03.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:31:44 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-phy@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] phy: rcar-gen3-usb2: cancel OTG work on unbind to avoid use-after-free
Date: Mon,  9 Nov 2026 20:31:21 +0900
Message-ID: <20261109113121.1534929-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

The OTG role/VBUS interrupt (rcar_gen3_phy_usb2_irq) and the role sysfs
attribute schedule channel->work (rcar_gen3_phy_usb2_work), whose handler
dereferences the channel (ch->extcon). The channel is devm-allocated, so
it is freed at unbind, but nothing cancels channel->work:
rcar_gen3_phy_usb2_remove() only drops the role sysfs file. A work
scheduled just before unbind can run after the channel has been freed, a
use-after-free.

Cancel the work via devm, registered before the interrupt is requested so
that on unbind devm frees the interrupt first (no new work can be
scheduled) and then runs the cancel action before the channel is freed.

Fixes: c14f8a4032ef ("phy: rcar-gen3-usb2: fix mutex_lock calling in interrupt")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
Changes in v2 (thanks to the Sashiko AI review):
 - correct the Fixes: tag to c14f8a4032ef, which introduced channel->work
   and rcar_gen3_phy_usb2_work(), rather than 2b38543c8db1 which only added
   synchronous extcon handling
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index b5ba751..35e519a 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -1171,6 +1171,13 @@ static int rcar_gen3_phy_usb2_vbus_regulator_register(struct rcar_gen3_chan *cha
 	return rcar_gen3_phy_usb2_vbus_regulator_get_exclusive_enable(channel, enable);
 }
 
+static void rcar_gen3_phy_usb2_cancel_work(void *data)
+{
+	struct rcar_gen3_chan *channel = data;
+
+	cancel_work_sync(&channel->work);
+}
+
 static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1277,6 +1284,17 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		return irq;
 	} else if (irq > 0) {
 		INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
+		/*
+		 * Registered before the IRQ so that, on unbind, devm frees the
+		 * IRQ first (no more work can be scheduled) and then cancels any
+		 * work still pending before the channel is freed.
+		 */
+		ret = devm_add_action_or_reset(dev,
+					       rcar_gen3_phy_usb2_cancel_work,
+					       channel);
+		if (ret < 0)
+			return ret;
+
 		ret = devm_request_irq(dev, irq, rcar_gen3_phy_usb2_irq,
 				       IRQF_SHARED, dev_name(dev), channel);
 		if (ret < 0)
-- 
2.43.0

