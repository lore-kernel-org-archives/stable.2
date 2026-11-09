Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243764;
	b=JpyVbNBkT6ZHXOeFi7vwRnNoSA7k+jyUk4oDG9sa6wXch5zZH5zEQh9T8ZSX2fcnG5S+
	 kSKCAcbkOO0Hl/0D5lQGpTeufNvp+BP19rd5E9jcLQehsG7b7KXmsg2i/GR9mzHyEq3iK
	 KNCzjNjoMiT847vqd2YniPorFWREb/4/IqEp4d1HMhndxF8D/0JaG/bkvVF1iMQHlryIM
	 JmDsnsR7s7t4cd+OjbXCs/clpvp1TayruGVzcwT8vYsi+PuSoLsDejweWHzLxzTHjpwbs
	 LJIiE8H96c9bM2q0LiLDuWhtN4Y/gSsvUQTkEGLVQe8oLBVBn8xEAds1eeG1uYY6f9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qY0mbUZdr0ztNMcKxMffZ/lOFKEQtrLqkPhKXm8ABiA=;
	b=reTMERqqyorHXoJMPkeL5Dx3RMQijqVnN+WHA8tkxk66j5kP5XRNY8OxchquYl2u+xqu
	 JY8+LN04oxmf0MkeUDiKjzwBLnctuxfLW0xWcqbHfvU4RBqtzH3giFailmnCDzBI3m00P
	 rwhJ2lbbwmjWZ071ZI+wrvu7K+vysRoe+xnN4ifJeuVU54WerTJbTnpyFf0c090vLCx08
	 pPEQDGdgg2R1qARZJS+d3WSQL+H1De9mwxmdqUJS69E1e+6v/EUkz61gNbQW3our5p4Xi
	 AJRxi5gmCz9AMYJmEiJFTethHerGrdgN9PO4hN7H8+HvR8pDasTQJt0AnJ8Or0B+KKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkcL9Mlc;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CD606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 17:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A15CD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkcL9Mlc
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36dbde64409so2006817eec.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243763; x=1794848563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qY0mbUZdr0ztNMcKxMffZ/lOFKEQtrLqkPhKXm8ABiA=;
        b=hkcL9MlcORBXFvbjWtWcHkl0IKHVpAmxnnQgf2LS6YqMGeO/zPObjXVUOxlRMnVb5+
         s4kcVwj5dlgWXKN2lkV0A5hVitLtkAJLD8ASx5PIpRRX7b5wuc0Kfm3g19216Dw5SFPo
         u+Tu0TOdt2sinQoAkOk8nScZBW+EiANXU7OV2HiV8MSjuxNLjBQM0/xrX9zP3Jaf2im9
         l1PG7TMkj3JLc2wl0eZYUmN+9xj1jq0uv6ug74TTtX4o0H6gzslJDoPAdoqKwkKLrV/l
         lgxFCJUCaDzWnK+9kknncAg6AxD6pbvYdvpg6dFOGTV3KiivH/ehoCltF2NVftNbOPrO
         zKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243763; x=1794848563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qY0mbUZdr0ztNMcKxMffZ/lOFKEQtrLqkPhKXm8ABiA=;
        b=TN0tUbL9XS0PNTiYBvuRtTwt4IdmAcaN1iJ6cvfC8v/sOoNq7S7HU2+8G7pl8DmzNP
         a7DJer1FnizCKFXLq3mVCe19OiFYOA3MOxrP9WFfoFlSZOe1xkhrvX7jtCLoQoo9afLt
         BNTxoCG5RLb1wmqXji7cB5xZl5thBbZMKT7uQXt5B3SxbiX1KnVn2Vmd+UZ3n6yPoFfh
         T5DP8n+guf/JsoYnZginoW5PPtelBR4c0Ko1ualbUbiqcMH+2pOsR/AJxiu/OskhIlgf
         v8+zaQofsN5jLfF3d1xfFGldOprO6zH6h4LM3SvEsOCycTqYov6BERrDlSGcd1EoC/3J
         XiRQ==
X-Forwarded-Encrypted: i=1; AL+hErF1zeHATR+yFm0zK7QVNQKReKMAB7HKU4rM1C9LhuyKcwNSptKjLYkrZhlrL+hEHvzc5LKJkbA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xqS0EW5ntvmd+Vjn1IooXMu2IjdnP784pOal7d3cXHtbfwOW7
	9wi+nYOGrVAgbu8bc1sFGFRS6tVbkE5VLrvhvEvku5UrltGwifmbKXB3
X-Gm-Gg: AYBFou3mJIjN/eYHO5ntQFktLgFgQuq+vPswZxIUrkjgigx7YzTdPijZUeBmPMb/5Jt
	h6Ggye6GVH1Sv5Kpu3P+e5w4PdkcnofLYsArVcDupnfyo4gFzlQ4Uas199A/Ogd/KRkcEQaQdJ6
	BrMYQLPeLxBrGUGGQOD0nFfpWI/Ge8kJr7uLHxdUUT3sf2XMR/U/BLj7a81u1SJd1Ge5meTFCj2
	JYKARP0e6PJMD9wkOl/IJ/L5ssVy8LrnPft/u80mDGP5eU/6ZUlWGyCWiKu/42rENrufyRADzsj
	rBLCLkEDllRjJNGeHSamgAQtIZQOPygWI2Zss+e0kmyKZoMpAnAZi5zF/+KIiaIjo8rwxn6dMCQ
	VAUt3e8IJCBNUQMGbZnthonWJUDorH7hPVZF6DQWUNe1AlpviQuZyN5m1Fc0+FW7RMiJXoiSn73
	ppxxih+W8+QahZlxiS22fjWdPArepzSoBOSddPf6rYt038stdM8QIR2cNQafwhdkPIxnyZEFYB3
	8PWFUFIWPRe8/rFxUlDgiFboy9PvNXgJZL5ndvhwUR9l3oaNTfmatSQx3i/pD5gRGPKAmcfXX05
	DLqyrbfDgySVBt1pi6RXe6MH7QM8nMM99xi9RtOvN2RSb8QANnfzJpT1MIb7NKYWsERu6g==
X-Received: by 2002:a05:7301:18a5:b0:36a:15ee:c20e with SMTP id 5a478bee46e88-37258658bc3mr7702403eec.33.1794243762677;
        Mon, 09 Nov 2026 09:02:42 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265618e11sm13726894eec.7.2026.11.09.09.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:02:41 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Ray Jui <ray.jui@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Raviteja Garimella <raviteja.garimella@broadcom.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] phy: phy-bcm-ns2-usbdrd: cancel extcon work on unbind to avoid use-after-free
Date: Tue, 10 Nov 2026 02:02:23 +0900
Message-ID: <20261109170223.1829473-1-hj351016@gmail.com>
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

ns2_drd_phy_probe() schedules driver->wq_extcon (extcon_work), which is
also queued from the ID/VBUS GPIO interrupt handler gpio_irq_handler().
The work handler dereferences the driver data via container_of().

struct ns2_phy_driver is allocated with devm_kzalloc() and the driver has
no remove callback, so on unbind devres frees it after probe's resources
are released. The GPIO interrupts are requested with devm_request_irq(),
and so released by devres; free_irq() only stops further interrupts, it
does not cancel a delayed work that is already queued. probe() queues
wq_extcon with a debounce delay before returning, and the GPIO interrupt
can queue it too, so on unbind the pending work can run after
ns2_phy_driver has been freed, dereferencing freed memory (use-after-free).

Register the work with devm_delayed_work_autocancel() instead of
INIT_DELAYED_WORK(). It is set up before the GPIO interrupts are
requested, so on unwind devres frees the interrupts first - after which
the work can no longer be queued - and then cancels the work while the
driver data is still valid. extcon_work() does not re-queue itself, so a
single cancel drains it.

Found by static analysis and code review; not runtime-reproduced (needs
Broadcom Northstar2 USB DRD PHY hardware).

Fixes: 787f24543c4a ("phy: phy-bcm-ns2-usbdrd: Broadcom USB DRD PHY driver for Northstar2")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
Changes in v2:
- Reword the commit message: the GPIO interrupts are requested with
  devm_request_irq() and released by devres (not "released with
  devm_request_irq()") (Ray Jui).
- Place the new #include <linux/devm-helpers.h> in alphabetical order,
  after <linux/delay.h> (Ray Jui).

 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
index 171bf09..4b8930b 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2017 Broadcom

 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/extcon-provider.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
@@ -339,7 +340,9 @@ static int ns2_drd_phy_probe(struct platform_device *pdev)
 	if (ret < 0)
 		driver->debounce_jiffies = msecs_to_jiffies(GPIO_DELAY);

-	INIT_DELAYED_WORK(&driver->wq_extcon, extcon_work);
+	ret = devm_delayed_work_autocancel(dev, &driver->wq_extcon, extcon_work);
+	if (ret)
+		return ret;

 	driver->id_irq = gpiod_to_irq(driver->id_gpiod);
 	if (driver->id_irq < 0) {
--
2.43.0
