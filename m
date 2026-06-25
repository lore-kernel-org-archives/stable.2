Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558A3002B6;
	Thu, 25 Jun 2026 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366257; cv=none; b=peJ1WYG9g8Y86hQaaYYayS5yD+bnoZqseWgG6LV/qLqBFvvLHPIyNgxt6M00GHHpZI0Rn/FvjRZqoJZIB03QMrUbVZKoM/duE+v6sYpGrFjxzikg3sMXo54Iwia5JxmBhNb9vboDObRc3P0WLwA8QEplFYxzg0L6d7as3diqzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366257; c=relaxed/simple;
	bh=hYaeWvyT8RRBkZc2MHY3IbWDhFqr+C4jedyaPVyZj8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtqkBFcFb2uDCK4PU9D67Ia2GSt9/gZSggKiRCiQTxEdSAJC4WHiCUq3ndJ3QOx8x6AcTeAc7L+CrSa5iVeUzwvxekPkYtPyqlk00caL1I2BEHJ4XOrK7yCJSuU9mZwW7n7w/9f4LO3javnD+2GD+1+0y32uJ0ZIbbvS/LjcixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowADXI8cpwDxqYponFQ--.8394S2;
	Thu, 25 Jun 2026 13:44:09 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Dan Murphy <dmurphy@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2] iio: adc: ti-ads124s08: Return reset GPIO lookup errors
Date: Thu, 25 Jun 2026 13:44:07 +0800
Message-ID: <20260625054407.82228-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260624055325.32388-1-pengpeng@iscas.ac.cn>
References: <20260624055325.32388-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXI8cpwDxqYponFQ--.8394S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryDWry7JFykKw1kur4kJFb_yoW8Ww4xpa
	n5XF9xtrykCr10qw4xX3WxuFWrC3W3Kr4UWFWxJw1Duw15Zw4FgF13tF1avryUAFy0qay3
	t3yUKrWUuF40vw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbzpBDUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

devm_gpiod_get_optional() returns NULL when the optional GPIO is absent,
but returns an ERR_PTR when the GPIO provider lookup fails, including
probe deferral.

Probe currently logs the ERR_PTR case as if the reset GPIO were simply
absent and keeps the error pointer in reset_gpio. Later ads124s_reset()
treats any non-NULL reset_gpio as a valid descriptor and passes it to
gpiod_set_value_cansleep().

Return the lookup error instead of retaining the ERR_PTR.

Fixes: e717f8c6dfec ("iio: adc: Add the TI ads124s08 ADC code")
Cc: stable@vger.kernel.org
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes in v2:
- Split from the v1 combined reset-failure patch.
- Keep only the GPIO ERR_PTR/probe-deferral fix.
- Add the Fixes tag requested by Andy.
- Carry Joshua's Reviewed-by, as allowed for a split version.

 drivers/iio/adc/ti-ads124s08.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 8ea1269f74db..73ad6ea9ef5d 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -321,7 +321,8 @@ static int ads124s_probe(struct spi_device *spi)
 	ads124s_priv->reset_gpio = devm_gpiod_get_optional(&spi->dev,
 						   "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ads124s_priv->reset_gpio))
-		dev_info(&spi->dev, "Reset GPIO not defined\n");
+		return dev_err_probe(&spi->dev, PTR_ERR(ads124s_priv->reset_gpio),
+				     "Failed to get reset GPIO\n");
 
 	ads124s_priv->chip_info = &ads124s_chip_info_tbl[spi_id->driver_data];
 
-- 
2.50.1

