Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202052;
	b=aRhdPgIboEVZ+JOYFHj3qtSS3fr/Au81cAT2/ViNOKgZvT4vqJWGKwmAOKHRICz1rhLf
	 GtXprqt5d1hNaiogChvT7Iz+iAOUJ3KqDYLgm13/ZcyAxRznsqBCuG7flH8xzM0p//6Y2
	 KqjLUYdQigwJ9Iqz5o7qVhQHxSCX8c5tYtvJs6yPCF1ovnv1q8x8t1cyZXMblsMl1HLO3
	 0lELmwlnVRTnI98zBqnAfLft5Ol/KHJJeqQRH4otMFDdTlleHOg7ks80+lUFVR1OnJ3Oe
	 zj6wqJt5EfgS5TVFgGVIKQubxDslgGic9zEuA3CoLvjCX4lth8rIOLuL6cr+bRsZJWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9XmdIKDNqOq1IqNyOaH9sp5VFW9+Oyqd3k96RmqKjnE=;
	b=jpCNMlVZomgNZizxtiAy+VX23gqLt7A4C+QRzDGbj7YRXObYh4dFdecVeW8LXT/hL/Vc
	 FyZtWtMfioGZQuX/q1ROBqOjgngm/jnZtOBJgqtZK26Yo/gKrCNdtIfZaY+4RnfAlfcit
	 B37qID4h4piBglENfD2yXf1IfmiBW2kWN5LqxuyV8WwiWrrBpydWwKtumyuKQt75/2KYg
	 ifdrY8Wi+lBm8sblb7Cvc//coFCceJ47ZbDDXLMgYEKW4MFGwzyo+Q/rtjLMI9daibeiJ
	 xz0xGHyQESX9uG9UXYiMV/FRm8I2yZRo3bzwxMBVS9EFq7q8pI1sxqNr33dS84+nytA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USCAZclK;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0860A2631
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C0860A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USCAZclK
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-862aca1ed4dso609706a34.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202049; x=1795806849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9XmdIKDNqOq1IqNyOaH9sp5VFW9+Oyqd3k96RmqKjnE=;
        b=USCAZclKpTAGAq772/HU3Xz81Eg5tL3nv/vGaFsUbt9Vaw+3SGs4v6Nf4VfDh60iqK
         gr7kDSmTj0H8PxyxjsgdkB691dJ180xtqBkCWyI/IggJsycfLNEDU8tl3Oo/9KCy1N3n
         XIm1/9qFB15saRRsKIxK8z9fQK7RYbFsWde2OOaoliYL5sC4j+BtPZeVMqS6rSZbwp7K
         BAN6CPzBzf9B/kcP7EGmx9D5kc41nlYrNSrYQy/1VcbG+7my4FnU3EE7Y+bsTAzYEgSs
         Qjkuvuju6DqND8StWjj3J+cp4kqWc06H8Nx4NDoRqS6PikZdWKSN1sUrZbeQB6rmVa7W
         h61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202049; x=1795806849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9XmdIKDNqOq1IqNyOaH9sp5VFW9+Oyqd3k96RmqKjnE=;
        b=r+NThIgHfQ9OEoKPl56egk4PXggH04lNsgCdJAO4AjWY5+lPI3alv9h0xViH/GW8zZ
         9wOCN0l7Oz+unZMVG0+tDTYNpnu+DHaIG0kFXEAQQpYa4VeN4HkSH+SycmaiJ7lFRqZf
         gssqaa2xDawDVQt6XLY6QZbXygWDQ1s+DLHm+zp4bTFlhac3/pNKV1839wFpzK0i8+PF
         mQAo/wykEefIs9II/OpvEGAip9wjD7uQTotKvFKwLjIWhSUGN2bvodFnrY2VOvo/J7qe
         T7LVv9Pr3W0C7I7tFWaDhhEtHkyEKGy3zTpvrkizyetqkZV+CZ7GqMrzkHzFdlhApoQz
         lkFA==
X-Forwarded-Encrypted: i=1; AL+hErHzY7PSyzOMzKil5hb5EEmL3S+/9fXI5hFBs1M5EPwUNXNCTS2at0La+XbAKwGkAW1gFDBMnW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vQMEw/envgBbTfdybNo1B8rCswVeQuMFD7qfIZVeN62tef9we
	4DoLZM4XgeftLlyVo7A7PRxZ+cuNrufMp28IJRuSrchqUp7x/hdZHL++
X-Gm-Gg: AYBFou2YRufbI99zxtwO0O2aWZLZQlmjdNF6rrgbDxZlSkUu0G26/dGmF3VYRgrT4EO
	qcfc6ZP/slyQk9sJna9BLqUatuP1palJMF/37d0S26jczJYCOD7nlLzvXbOA53eI/BF6qYQnKBe
	m4l+RdTKibPKzIXxmAariAxK+DX4KSaaLNnSv42sQ7AL7ItiIIAGXFoC00E+sYKS0XCkE6hEqjz
	N0+qFWWbZ+xNw8RFFaR+EudrB6wTnzF7EUMFRvva6ytkScvQPYbdNmpuJX5V/RMCvA8a8GTv8Hp
	JzYL+XuBOHq1meWM+ZPjIX69sj0dZppZ02vw1wiP2uXCecSi556QcUQ85A07zmiLo0iVPAOfZYG
	OlY0XHkhmKuOmSxaWA3m4M2YV46BMDExX3luhc2J1eg3QJ9KoXdfJOy0mUNpNrgk8yHglBYaj6G
	g6Nq7e45U7YZsfd5PUHfK/lhPE6JMK0YgKCmHDgq1hAlLg5blryYqY85T4t2lS6d+6+6iN65ALU
	In3m2v+s9RW7PswsiGjj4oyJ3gR193d+MhZ2gGq3ChH/1NhM2l+/oUtgbljIe1RLjj/Z45dhFQL
	5C94c2ecYiG2K/kHD/1q7EmWXJFwLWYzxxtxG2Sx2MaSLJqQRPiQO7nJr1lUSFfT3fDnUUd5aTg
	NrJnloxl0fDlk2Lve9x8xcPI5x21tk2opAWdbBM2g5XpeqbbOzSaDhe2IWwc1gEpXl4HYX+YhiU
	pov2W9etTtPAMLVVw2Gd5JSTulYga/WChrw0lauHjwGpZ1M+jRtnY+
X-Received: by 2002:a05:6830:2705:b0:862:9bc5:5c24 with SMTP id 46e09a7af769-8631596f074mr4518795a34.31.1795202048618;
        Fri, 20 Nov 2026 11:14:08 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f3964sm2654782a34.14.2026.11.20.11.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:14:07 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:13:58 -0700
Subject: [PATCH v9 8/9] dmaengine: dw-axi-dmac: require an IRQ before
 registering the controller
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-8-48ab58961d6e@gmail.com>
References: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
In-Reply-To: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.17-dev

If the interrupt controller is not ready, the DMA driver can bind
without an IRQ handler. Clients can then submit transfers but never
receive completion callbacks. platform_irq_count() returns -EPROBE_DEFER
in this case, which skips the IRQ request loop just like a zero count.

Propagate the error so the driver core retries probe when the IRQ
provider is ready. Return -ENXIO if there are no IRQs.

Fixes: e32634f466a9 ("dma: dw-axi-dmac: support per channel interrupt")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 2eeb902eaad3..531705f8f89b 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1518,6 +1518,10 @@ static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
 	int irq_count = platform_irq_count(pdev);
 	int ret;
 
+	if (irq_count <= 0)
+		return dev_err_probe(chip->dev, irq_count ?: -ENXIO,
+				     "failed to get controller IRQs\n");
+
 	for (int i = 0; i < irq_count; i++) {
 		chip->irq[i] = platform_get_irq(pdev, i);
 		if (chip->irq[i] < 0)

-- 
2.53.0

