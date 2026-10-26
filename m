Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015556;
	b=RJJIQuepGZtUvNGApWaL1QK/N4q3ODOXzb6X0Yh3LJLhm7805QU3+a761coy1JamLSto
	 9ZrepYOM5dasKNMydadTLIgZtu3q3AkA/3B8WLnp76Rbroo/E1kXGtQ0AbTzS8c7yZJRX
	 zvNCNEhYQ06SwLCVfXGgOqdHK52p/T3Zx7uG6IP6/8tzGxg6iqp4zQlwLi/4W+78WpDC1
	 Xdk3Xtbx5VlKtUSidKSQawrvY+LTjbxSSHkI1dcDdfafrnqgvMbeLWZ3ck13xpJPSz3Tg
	 zzOSQl2OQdY1DMfxmbm8b9QTLqp4qBqpfyda/VVmCDOTaebqku3hnj3Q1yzksxZEt0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vt/79XA/yWxO2ogj1KSk8egFEeSfwKKUg9yTYHPXecQ=;
	b=S/tnjznjPFnJGv5fC8Jcp0W1ZHybOkCMNzbBoiRVDK0GBhjfm7oLDcvRDDdtPuR0iP8q
	 xP++82OnBd95R+nJtC/6D5TYSHb9/UxqBjH28xHfzkkr2LKfn2l6KVict8e1temhWZPns
	 UZS2Xk2K1vLY2Z2fIIbfrthAOCUiM2lzZfC3DhKLc68q8xflmjDatMTtDcdbHoxvDT0QP
	 H9esAk+Ouf4L/e/zmYYbaP+BxqawZQhMRBY6a2UnUmZvvkdRgAo+CPYHpfxNTjHdAwRPL
	 Y2JG0ati1Y4Wdvsm+g7JjG8Hb1l05rhUi8Ltxg690+Y4jvVo0TVYJeNAqxStKmzYQDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IsWxLjyv;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62372606A32C
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62372606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IsWxLjyv
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1253910b3a.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793015555; x=1793620355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vt/79XA/yWxO2ogj1KSk8egFEeSfwKKUg9yTYHPXecQ=;
        b=IsWxLjyvSS+yJR2TrqdixNFLlM5rTDb7uGtRIyBFo7Hkb3usvDA6pa/LO7PUAFYFm0
         jL38qgPpgv7tHi8v89bgFJqnUY1Cb5oudLNTw9Z9i/L1MOPyrevjKh5uO/m5w5OWIKZD
         yVSwWSrA3VEE/eKsrUv45Aw7PuG+L+0XAuCtpt9Ppm9VjKRaHh6dca1MFxfhriz9SHXT
         NKWMp/2+cHiGiYxdlCoJCmwdkzPp7cbleL9PvimiNxdhLHildiwD6tJL+vKrgom4h/Mz
         lFjOiTkcr/W71Re3NYhieMIM1wukkhA1IjrlnCWOYkGqheQSYffVJOohK4+bTpdYtWDn
         3lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015555; x=1793620355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vt/79XA/yWxO2ogj1KSk8egFEeSfwKKUg9yTYHPXecQ=;
        b=QOHQ5ZBkqYZGWJsg/uFmU9i0zvid6+AmrjnXR/5g2EoHmNpYogTtf32yYOrLkj0S1e
         u2NhxjK5USjzpGqgEelEMEfRmfcPLiFZm7vmOuUK0aD9keR7BfQgp4jP2FQwGFjOKo+N
         6nJUKWndVYhxh0SDxHjlTPieLFTFcR4I36h3UTDaoF8Yd9jnMrY+x1C82nuUDPR7IzyW
         2Cn7FS/aqLh1w4oS4XJG97iO4t2I+ZNalIecryXJBWD8zFwIa2/Yy3NdbF3qTACgUV5Z
         i6XOy2/baKgxyU3ImAYGZChumT2N07F4ruACpC4ZaIkzvA7cclcTC0KP9G8cYscpK7kU
         2JUQ==
X-Forwarded-Encrypted: i=1; AKwUvByFtQ0OCouQgrUhWBjZLc2RZi8N7tK4nrokedRc3uSBTlPjM0sDRpZ87eE7rVGolreHk3rZU+g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKydPkcreZPhMMNEZ4qszQkB591dhgYgV+az5io1/r7uaLj267c
	z4OQqIFsNmxsaGaj4AYekM0xma8vgBoE8PE3ryjHxWhlBP8NLT6XdPL5
X-Gm-Gg: AYBFou22k+Q/DzFHOl4S2M967D2m4Z5Voq4eexc1WImwZjxqvzzui2WA3WIa+nEUdT/
	cHtkmYtaJyq8214TGb5WzmR/gHcleHV0GNnRg5AC6CUaUaFSufipermWeRudUAgv4tD3fLm9/DC
	CPpvbiuUpuWMFqXtQeSdhe1a28a+KDsNx/h0kjADujo+zvWxdHRbPxKggQ/Vt/vMRM1sLTGu3L6
	uk2SOA3W7GSOUgnlz7zyhPvPF/l6QyiUt5jYav4y3EB+H5Nqo/seisOIunRbg4+xuXaVqDk5VyK
	MwQBlTrhZ5jOtbCIPcjFNvnaTLeW9F7WWFxemFljl3ElMGD4UWcFWMLIjsL1ktbQyUfz8C833Jc
	gaNHNZVhYzBvzv2JfVTEGsj2hKsqvDByItCare0JFluPg2m1VPaFOWiKf5sA7AIyZSgANA5Mueu
	9mARMcW2AMpACn+Chhc40Cvzox0xegpAq51gzIxRefsNGAMm75Y0rlV82BMNSiSVj1804R41eyy
	DKbNCWjaRS37o+f+A+OCLGykGT+YZf+1CkLtRV0jifbmordFnw18g==
X-Received: by 2002:a05:6a00:1808:b0:87d:ee98:606 with SMTP id d2e1a72fcca58-8a367f0eb74mr4959061b3a.23.1793015554801;
        Mon, 26 Oct 2026 04:52:34 -0700 (PDT)
Received: from lgs.. ([101.76.249.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36ada2805sm1233497b3a.12.2026.10.26.04.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:52:34 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpio: brcmstb: fix UAF after IRQ domain setup failure
Date: Mon, 26 Oct 2026 19:52:26 +0800
Message-ID: <20261026115227.41779-1-lgs201920130244@gmail.com>
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

When devm_request_irq() fails in brcmstb_gpio_irq_setup(), the error
path removes the IRQ domain but leaves priv->irq_domain non-NULL.

The probe error path subsequently calls brcmstb_gpio_remove(), which
checks priv->irq_domain and attempts to access the already-freed
domain through irq_find_mapping(). It also attempts to remove the
domain again, resulting in a use-after-free and potentially further
memory corruption.

Set priv->irq_domain to NULL after removing it so that the common
cleanup path skips the already-freed IRQ domain.

This issue was found by our static analysis tool under development.

Fixes: 0ba31dc201de ("gpio: brcmstb: consolidate interrupt domains")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 44ca798cf832..3b1aaea63951 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -513,6 +513,7 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 
 out_free_domain:
 	irq_domain_remove(priv->irq_domain);
+	priv->irq_domain = NULL;
 
 	return err;
 }
-- 
2.43.0

