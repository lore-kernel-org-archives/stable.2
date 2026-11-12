Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467037;
	b=uqz5A6hqr3kY0++LPmnEelDstJMv/XKOHg4wRYYE4wiOJADzhNF0nO1coIsA0FIQ5IRu
	 K0hoUQvPXzXVQNI/tqcaBIyvfCVtwdQpr42KYbExbDqb4oUscLj4d95aKEekE42AlqRid
	 dvNgmd2Kr4vlm3s9XHB6MGJoKBMrQajTLgZE/4URYkh7+6Jg/AQeGPKaNFOmJhd1XIlMD
	 eFXKLc4vCuKaDAYhF5534RV4jVHn9m62ywAQ0PdtDZUPUySd/ovLDuBbLaq/i1pEJwLqq
	 m67o8v8GCht2lXb8DZKo1LxFSUzxIux3J3ZRq4a8g2z+qS7U+FMdxmUW7+vfgz0gIVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eyUouVpnZGfif3VWuPv+zR8XYoo75xxjg1KonBFeRN0=;
	b=DY2vnj9ciNaF0bTmyDf1Nw4jjtZ6y1JYCPZy7fIxAoVpa4n5G7/7bpS7PBOZkdnB+96P
	 50mT5d7GjMpvLJnHko8U1SsctXI4UC8SaOqHf/ctrGFL0w5dK+aOrKi7OLg6XqlB5qFyy
	 HoBUKt2vobnvMNkbBbykGCy/LhE6ajIckXbb/ayvQBfHYLEK1bPJsH8sZ/EKBrR32ZZh6
	 ldJtFpob7h11vlmJriDpklss9KL/ferqsd0xsYL4APOYFps2P+Cmbxs2VtjmadvwuOUed
	 uaNeC3t4o0d0vf/8Iq99O9hHkSwHkrTXEI0OGV9E6PYLR3Xp5JReJgqyskQqeAFnOyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4GxaJ2o;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB2606A884
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86FB2606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4GxaJ2o
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91e7af9a67fso27783446d6.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794467035; x=1795071835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eyUouVpnZGfif3VWuPv+zR8XYoo75xxjg1KonBFeRN0=;
        b=B4GxaJ2ob0yOBMg8QtdSBTXjZuj1RHSf8s792QA+V9vftReqKTNlcJ/qAiyLXwGLVd
         9k6n2FtGjJ0kNf32avhaxr3z2REIm8WR1EBjwicJIEhovRgrr48jSzLQZ1h6c+NNxlr2
         yMPGcE3WgTy7ZNT3kclIj2WAb4YHbos65NVxULp31l/G9C6OTiOqqFI5ns3PF4pVCadn
         wNJJZrRLHta62uw25s5DDuIFzZUZPKUoQncX6SUOltXOLBcvsq50WBWFxVJeYWrKlIve
         OJoTeHf/FJLiYpIzacAibny4y7QSY9BmPPnhOS1LKxFq2222lJOX2po0KywvC5yfFVG9
         sabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467035; x=1795071835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eyUouVpnZGfif3VWuPv+zR8XYoo75xxjg1KonBFeRN0=;
        b=Cm95myeXlku2AwoTHi+hWbvVHH8Mi/KUKshgWuvZLsR1YwIfWlli6jzhf0ySyNyC6Z
         TA1C4i9rpeYrCe5z1uYE5KWo184RhPxUqRyvRI1p/3+iq6d6qGiwdoX9YELLKLfB/U6/
         LtCO2p6XGzvmE/IueDw0OKKSMi+dR94dkqYaqNjeaKdkacEZXbci0FCHFe+jpe6Hggf9
         UWCBaUUKp/HKiUk8WVO7nLDJMD+J1lQXOxrKtxx08PMSQKxX3tqXYepkbbs2lh02Qvvp
         S0IFiYn2H+Lceqp2uwDGSjH3jglisoH/ASlVIak1/71V2nj4vfSV7ftupGDO/D/1dbbc
         h7kQ==
X-Forwarded-Encrypted: i=1; AL+hErFj1h+LzwkeGYMH5oKRymH2KWloTkrylfrudAt2LRVQ9mjlPr3rU1aqLnzmN3eqEPdLAHTL7TA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8p6FOMG7MRTNVDtA9F6Xh08gLqt2D1+GAY4wVyrL/hcbex+pC7
	3piuGL/ofeRlNwST1xpxfN0bg0O7P6yyIPbH8qn71xZkMqzOnh+TPtM=
X-Gm-Gg: AYBFou2D1wcUhj6F7tX38n0qxFeyFBzr8JXl+KUCHnWL5mh3cISRwyRDhtjmKNRQGkj
	kOU8bJZ7lFv2JDMyQYqCExDlPxL4ovOmKmIh4nwjSXXdQiY47dQKS0n5U3AGUpFgouYKY88vBa8
	KvzlMBsU1OPyAZNLce0Y26Xq+vTd4US1Kk86x74QPBrhtiMJ0+IFfz4IGUtOspbi7UWw589w1mN
	ZE97p0xxURyupzJxZZbNhE/fzy3ysVSitEZvqN3gfYL4p2DkrFUaw6f6BBAeJnDAiI9BfE+ylUg
	u/TeMS1/g1w0bF/CFxZmccJ+C8CeC7K26FR/0aSk8CetZWuiIsHKocZPWtTLc4aZAEqVdTWb0Vz
	0YrQQMy3RQJu9BSMqQ9tbC96/BonD+ZF/ClMFunGD+r4SuqUxMUn7JIXsFfO0TSiZZTKwAoIlyX
	wKro7KZTAfqf8/UNfmVWDjL82tepzXiCt1h3ixcMnyfxuvDfDgDiX9wx7RYTL6sgAKBfxbVEiM9
	Hzj9vwZ2A7TU8KWTyQKS0Cv1ZnRwREQnkwZsxUNHqJXmRhJHg/PjZWUfLKn7hBYBWzMdhO1kFny
	geL43yEY9KVLir3YQXrbD4yIA5ncuMuU+s7lB+RKhh98Ayn6j4Vn6Kj1+0pGKXJ9FHZv1W9R/g0
	VEHv/Jj+/gzKTyMpADcLm6Y5hYkNWipLRp3XXPrYsLqTxLohytG6WIypC9xpalg7gnpmWKX3gvo
	LCLGMDzH7a8v5CTvH4iyDF8kpCXEDiQTWK
X-Received: by 2002:a05:6214:451e:b0:91e:ef41:a7d2 with SMTP id 6a1803df08f44-91f04091198mr84093396d6.24.1794467035222;
        Wed, 11 Nov 2026 23:03:55 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f11e2cd01sm18137816d6.38.2026.11.11.23.03.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 23:03:53 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] extcon: max77843: cancel the interrupt work after removing the IRQ chip
Date: Thu, 12 Nov 2026 02:03:52 -0500
Message-ID: <20261112070352.38787-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

max77843_muic_remove() cancels irq_work before removing the IRQ chip,
so an interrupt can queue it again before the MUIC regmap and driver
data are freed. The probe error path does not cancel the work at all.

Cancel irq_work after regmap_del_irq_chip() stops its producer and
before unregistering the MUIC I2C client. Apply the same ordering to
the probe error path and initialize the work before that path is used.

Found by a static analysis tool under development.

Compile-tested with W=1 for arm64 and x86_64.
Not tested on hardware.

Fixes: 27a28d32b4f2 ("extcon: max77843: Add max77843 MUIC driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

    Based on next-20261109 without Hongyan Xu's cable-detection fix [1].
    The patches conflict textually; if [1] is applied first, keep its
    cancel_delayed_work_sync() at the start of max77843_muic_remove().

    [1] https://lore.kernel.org/all/20260728075429.838-1-getshell@seu.edu.cn/

 drivers/extcon/extcon-max77843.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index c16606b23855..0d45c374fcb4 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -825,6 +825,9 @@ static int max77843_muic_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 	mutex_init(&info->mutex);
 
+	/* Support virtual irq domain for max77843 MUIC device */
+	INIT_WORK(&info->irq_work, max77843_muic_irq_work);
+
 	/* Initialize i2c and regmap */
 	ret = max77843_init_muic_regmap(max77843);
 	if (ret) {
@@ -879,9 +882,6 @@ static int max77843_muic_probe(struct platform_device *pdev)
 	}
 	dev_info(info->dev, "MUIC device ID : 0x%x\n", id);
 
-	/* Support virtual irq domain for max77843 MUIC device */
-	INIT_WORK(&info->irq_work, max77843_muic_irq_work);
-
 	/* Clear IRQ bits before request IRQs */
 	ret = regmap_bulk_read(max77843->regmap_muic,
 			MAX77843_MUIC_REG_INT1, info->status,
@@ -923,6 +923,7 @@ static int max77843_muic_probe(struct platform_device *pdev)
 
 err_muic_irq:
 	regmap_del_irq_chip(max77843->irq, max77843->irq_data_muic);
+	cancel_work_sync(&info->irq_work);
 	i2c_unregister_device(max77843->i2c_muic);
 
 	return ret;
@@ -933,8 +934,8 @@ static void max77843_muic_remove(struct platform_device *pdev)
 	struct max77843_muic_info *info = platform_get_drvdata(pdev);
 	struct max77693_dev *max77843 = info->max77843;
 
-	cancel_work_sync(&info->irq_work);
 	regmap_del_irq_chip(max77843->irq, max77843->irq_data_muic);
+	cancel_work_sync(&info->irq_work);
 	i2c_unregister_device(max77843->i2c_muic);
 }
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

