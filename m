Received: from mail-qv2-f20.google.com (mail-qv2-f20.google.com [74.125.230.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA94E0B73
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669273; cv=none; b=Zs1cAOuHTYE4S7kh5/ZG8pxnok68sVT/4j9Vt/dWrQlb3t3P8t6zHpDdyrJl9s8kxRYREJpwCwxKFnT+MvodgE+xJp2YXb1cnL+dw+w+TuoWUZwUztAhaOmtZlUElRheNNSKmPEDU/6x+MKtlHHmPzoAJMt7lSWUPoBSbnZjKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669273; c=relaxed/simple;
	bh=6QaB1vCAHPDrZfq2UMtr0C/Dsi8/MZihkvuPXytBOdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aN1BjtDRXReBcdeINKBeWkpVkHUKEVOxFPvHRcm12tGyRZIu0KC8WfvN0+84HGwMfooJLwsDc1DYYisWZxPAX1A0+0wTW6mGzQN3Z3DlRFiXWKx2q+jmZ4Gt2sozOZPHE27TlEb66MeFEsBpuLqHCmilr4l61vGzjNkSHxgDOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsJyOlk0; arc=none smtp.client-ip=74.125.230.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsJyOlk0"
Received: by mail-qv2-f20.google.com with SMTP id 6a1803df08f44-90cdfc9b6e4so9962506d6.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789669271; x=1790274071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wxvIE5VyPmqRXC8q+9POUQDnnJS4uUoBxGmPT77wF0A=;
        b=hsJyOlk0GVVLp/TJvSOu56tX9ctJP+DNB+uKybx7JFxZmmvpr6c0/U+kKMuPNVG2Y4
         aAjxscp5NAuG8QiTHHS0ZLCGoF8NIKN+e2u7UzoLXoi5N+Sl0pZQ4Xrw5qsJYfKwBuAS
         tueGevEmShuRGR+ocbUT4uflEm0V7NTLsRYX27nFUO/NkT/KXZWRM+W1tZa9efWJWvrb
         pZAhk92jcp6inapGjbjKfPs0gYKE2QzWRMoyp6qRWJH1Ui51FXzmxU4w+LGbrsf0PN/N
         nU5wwShf22un+trMZTgxa2W+B79efUK3D29fSBlkKVcUpE70q0YCrGNTTQGq51PXnwHG
         BvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789669271; x=1790274071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxvIE5VyPmqRXC8q+9POUQDnnJS4uUoBxGmPT77wF0A=;
        b=eeGUNgrd2cK/EXpAUkHxBz/r52iewnuWFR5yVS479MJDIzbuq238tmMeiTIEnEZZVA
         jmQeB+svoekG9K6HgkLpCM4RldQjvk+kKnuoI9yMxN7heAjBDIHUqXTj3p4lYrlHugWy
         HBhweMf8A+4KLpPr0ifEP/XmRvW6l8yrtdZNTe6MKKFdlOR4gLfKWTKUMnWLoFT0i2SK
         PZNQ8Lf0+3jM3qgvHr80z5lrX9YHjgeGp/vGPMMCoVj9chUK8ijWV2ezZZQAroCFGslX
         yw4nDtguUkFYKrsA1q9Re9JEgR1RvC7Sk3kNdSDl5B8H8HwtrT9RbjPkz74kB14Ld1EK
         S0KA==
X-Forwarded-Encrypted: i=1; AKwUvBxrWzNbhpAqTvqcA1E37ZhBAO3z6dlsBzkgWH6dvDYiYYy1OPajxmLm12h0GbAY4840VhubSfI=@vger.kernel.org
X-Gm-Message-State: AFuF++l5VgjZBjfJwrsrTJTR56pvU/AWUEWLz+HF2s0Engyrg5Exz4/t
	r4Dts6MqPtn6cAKwKSyKNZXezaLWXSBHFLNnMVatGZxar1yKttMISvA=
X-Gm-Gg: AYBFou2GvwLfATMx2uKMuxPfQwxptCcK3H+6F/2rJgeS5t5Qyt1Ejs/mZ6KUw8hNPXK
	c3G51f/aFGYeLgktNW0jJs/F4dnRvdyWz/0BX4KGr8eIQHkKk10VbpNCBUqmf3yLqrzPRst9weX
	eXgs9ElFyQWlW4Cb5epNyXiDZqFwghTssnpz2D7EyGXopP+akuoRUu5OurUGwaE0e9C/QAudnM4
	XMENX53rlJbHNUpP8IJb4Fmyiob1BbrUNmEcd28Qfn2Tewm8Yrxa2mt61HPklFfA4GP+cQFHoGN
	DDI5ur/5IFNdKpA897KG+U6n6ijh2N2JMQSxKzGVqjnEfCqPOaBU20q//hYwO+TYVvLG4aGK7Hg
	zVlnGjfNWc4XZ8jx3HPqyKTbdLfB7wMixLTMD//q1tRkMZK7I6Vjq5YayWYoMKHjOJeyj8uPLx2
	MBlKRMHqetEoxw6GyaHg7IqvJiVeHln40loN2z5uV4bjHvt6sVrju8xFkbCJJPYxJcyx77VHH86
	bWLesQRP5D44pyHZnWXB7KkgMvuUdlu5k6IhPmP1OC4oeyknLROqnaauS4Y1mwp3JFZ8neInROp
	1YICmCFHaAB95qLUMVpOZaPMb1BE5b7laQIdXYNdIyHDc7tW
X-Received: by 2002:a05:6214:4119:b0:912:3c52:5f34 with SMTP id 6a1803df08f44-91254bd0194mr797506d6.31.1789669270580;
        Thu, 17 Sep 2026 11:21:10 -0700 (PDT)
Received: from localhost.localdomain ([104.39.169.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252cc7ce2sm3684976d6.34.2026.09.17.11.21.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 11:21:09 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: hverkuil@kernel.org,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] media: radio-maxiradio: balance PCI device enable on cleanup
Date: Thu, 17 Sep 2026 14:21:08 -0400
Message-ID: <20260917182108.32566-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tuner initialization failure and remove paths omit the matching
pci_disable_device() after a successful pci_enable_device(). Disable
the device on both paths, after the final hardware access on removal.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Add a Fixes tag for the initial Git import, where the PCI enable
  imbalance is already present. No code changes from v1.

diff --git a/drivers/media/radio/radio-maxiradio.c b/drivers/media/radio/radio-maxiradio.c
--- a/drivers/media/radio/radio-maxiradio.c
+++ b/drivers/media/radio/radio-maxiradio.c
@@ -159,10 +159,12 @@
 	dev->io = pci_resource_start(pdev, 0);
 	if (snd_tea575x_init(&dev->tea, THIS_MODULE)) {
 		printk(KERN_ERR "radio-maxiradio: Unable to detect TEA575x tuner\n");
-		goto err_out_free_region;
+		goto err_disable_device;
 	}
 	return 0;
 
+err_disable_device:
+	pci_disable_device(pdev);
 err_out_free_region:
 	release_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
 err_hdl:
@@ -180,6 +182,7 @@
 	snd_tea575x_exit(&dev->tea);
 	/* Turn off power */
 	outb(0, dev->io);
+	pci_disable_device(pdev);
 	v4l2_device_unregister(v4l2_dev);
 	release_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
 	kfree(dev);
