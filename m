Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713010;
	b=Yoe7eWOL6Kz+3tT2WNtxMPTCgS697cc53xcZMTJwUsbD4uXoHkgmVAkCfrgjGrptd3E3
	 Lt69/JwuLt2jPMgxd1RLZjKGoOelXtu8n1Sil2oPII3+8O8nuLTBg6mmjNaDQFHpSgGMn
	 1B8v/qJHksuZpcrmMV1XFWiuycWPnT8p50ZYpKcLx9fZ/Holg1S8PJMHvrTHp8OgGoZ7o
	 eZBcE8ulkL1eo8bop8FgCYz9ZA6FC54Ql1w+/jOFsb8/AdBmvClYuBAUZVK+tu/SRSbrl
	 KKTUvt3X6UCczYH0kiWXgcP8U928Cv9GLAkb9Lbm9XJQ6jUZE+wOSvJMMf2AtgRlaOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713010;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zboyo7xuqF22szqz2/78yShun3AQQa+X/HTOM7ZYqYY=;
	b=JcSH64EsYTEwuzTqcrnbFPZdA7T7BhqA6H5pmKJRKwg0MJuUt343Xq7oLcczTXYPKF6k
	 IadOYt+OO0OWANMD80hQPhulCd6oBHdyP+1DllB3Lq/WDaTiiVxiHy9R7/CBUtaXsJsbx
	 22WrhQIH1w3Nn7zeEyN0JhWdDn1kLWpa444JwljZ8BmosS7LZ7WY4FrSO/303xilowwmp
	 D7+M4KMspvIjgbTNR/bHUxQrndaCYQYhTQTYIRviQchpsOeqnlmkasS8Vvvl4SFBXb+5I
	 7pzLFqV8jzhoucBOrgmCG02IEdzkbYOpc66FXIEuNKQE/qhgIU72dsB3FUoKdT058nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gT+fRDtT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE62606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gT+fRDtT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61151F000C4;
	Thu, 26 Nov 2026 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713009;
	bh=zboyo7xuqF22szqz2/78yShun3AQQa+X/HTOM7ZYqYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gT+fRDtTZBd8TM9av/lcdudAPGEVc2MnwiDWkT37iOHiOeynwGDgFvcVbz7GRmq49
	 qxeChly+IZp+d6oq2ZQPOYyW5oS0Rsjd674cMk4grEvOi5qkfEFQPXO3X0mHxA2gdC
	 lD2adsYzGn1/KSPy/BHQnN29m3x8KSNTYDvRKgFH9ZHgzq7bcjSy4CDmTCz3jv0K0v
	 5lLvqe8zjwfZme4VHdeEmODd8i3Nhq/2/MVsNodsdX0XhqFvC01I2OG4lTRat7JmgS
	 +QRE+37FIfP4ZpOUnr+y1wNfOpxUtBNLTRbHs5ZsFf+PNo6Wjl7Ryl5VdYddPf7jg0
	 WcfVbmSQ2TPIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pan Chuang <panchuang@vivo.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] iio: proximity: Remove redundant dev_err()/dev_err_probe()
Date: Thu, 26 Nov 2026 12:10:06 -0500
Message-ID: <20261126171001.2690575-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-rhyme-sizable-422b@gregkh>
References: <2026112510-rhyme-sizable-422b@gregkh>
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

From: Pan Chuang <panchuang@vivo.com>

[ Upstream commit 7963090626a5de900d2404e451234ea098012ba2 ]

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Standardize error check on if (ret) rather than if (ret < 0)

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Stable-dep-of: bfa3b177d839 ("iio: proximity: hx9023s: Allocate trigger before requesting IRQ")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/proximity/as3935.c      | 4 +---
 drivers/iio/proximity/d3323aa.c     | 2 +-
 drivers/iio/proximity/hx9023s.c     | 2 +-
 drivers/iio/proximity/irsd200.c     | 2 +-
 drivers/iio/proximity/mb1232.c      | 4 +---
 drivers/iio/proximity/srf04.c       | 4 +---
 drivers/iio/proximity/sx_common.c   | 2 +-
 drivers/iio/proximity/vcnl3020.c    | 6 +-----
 drivers/iio/proximity/vl53l0x-i2c.c | 4 +---
 9 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index f1018b14aecfd..e063bd99af8f3 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -429,10 +429,8 @@ static int as3935_probe(struct spi_device *spi)
 				dev_name(dev),
 				indio_dev);
 
-	if (ret) {
-		dev_err(dev, "unable to request irq\n");
+	if (ret)
 		return ret;
-	}
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0) {
diff --git a/drivers/iio/proximity/d3323aa.c b/drivers/iio/proximity/d3323aa.c
index 30821f5834547..7ac230b342ffd 100644
--- a/drivers/iio/proximity/d3323aa.c
+++ b/drivers/iio/proximity/d3323aa.c
@@ -772,7 +772,7 @@ static int d3323aa_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			       dev_name(dev), indio_dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "Could not request IRQ\n");
+		return ret;
 
 	ret = d3323aa_setup(indio_dev, D3323AA_LP_FILTER_FREQ_DEFAULT_IDX,
 			    D3323AA_FILTER_GAIN_DEFAULT_IDX,
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 17e00ee2b6f84..8488b9a751f2c 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1137,7 +1137,7 @@ static int hx9023s_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"hx9023s_event", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret, "irq request failed\n");
+			return ret;
 
 		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						    indio_dev->name,
diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index 65af31d434531..b3db7f3a49f6d 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -910,7 +910,7 @@ static int irsd200_probe(struct i2c_client *client)
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					NULL, indio_dev);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "Could not request irq\n");
+		return ret;
 
 	trigger = devm_iio_trigger_alloc(data->dev, "%s-dev%d", indio_dev->name,
 					 iio_device_id(indio_dev));
diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index 34b49c54e68b0..c4fc840e11fb5 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -214,10 +214,8 @@ static int mb1232_probe(struct i2c_client *client)
 	if (data->irqnr > 0) {
 		ret = devm_request_irq(dev, data->irqnr, mb1232_handle_irq,
 				IRQF_TRIGGER_FALLING, id->name, indio_dev);
-		if (ret < 0) {
-			dev_err(dev, "request_irq: %d\n", ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 337938657449d..884f8578d7fe0 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -304,10 +304,8 @@ static int srf04_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, data->irqnr, srf04_handle_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			pdev->name, indio_dev);
-	if (ret < 0) {
-		dev_err(data->dev, "request_irq: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, indio_dev);
 
diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 59b35e40739b0..4d4937395d9a5 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -517,7 +517,7 @@ int sx_common_probe(struct i2c_client *client,
 						IRQF_ONESHOT,
 						"sx_event", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret, "No IRQ\n");
+			return ret;
 
 		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						    indio_dev->name,
diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index d0b8f429999f9..768870127ff87 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -648,12 +648,8 @@ static int vcnl3020_probe(struct i2c_client *client)
 					       NULL, vcnl3020_handle_irq_thread,
 					       IRQF_ONESHOT, indio_dev->name,
 					       indio_dev);
-		if (rc) {
-			dev_err(&client->dev,
-				"Error (%d) irq request failed (%u)\n", rc,
-				client->irq);
+		if (rc)
 			return rc;
-		}
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 913ac191a187e..1dc18b978298d 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -127,10 +127,8 @@ static int vl53l0x_configure_irq(struct i2c_client *client,
 	ret = devm_request_threaded_irq(&client->dev, client->irq,
 			NULL, vl53l0x_threaded_irq,
 			irq_flags | IRQF_ONESHOT, indio_dev->name, indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = i2c_smbus_write_byte_data(data->client,
 			VL_REG_SYSTEM_INTERRUPT_CONFIG_GPIO,
-- 
2.53.0

