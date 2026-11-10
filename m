Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281196;
	b=Ec8fN/8F+a5g8Ed6Ibcdug9YF+Tay1nEVvk/+aMYvz8YYO1Y9KYcU4QkQ98C9lkOzJl7
	 i101w3fxkxJabRgxsI5YhlatCfEe6vbdNoOXRfWfpuFKeRgx51LRMtAwvsW3G6rckl0Py
	 im93/dIYcXj+xy1laCqgnCg7OwEoHarZ1YmuvMw/2YbcIpsKAHJYIq0OiruGaheTXvGW6
	 awO8KAxxQtnCOwnXTHD+R4x9mYuOL4E41voPjWRR61rTIUPyqv1Wa4heJ7rFDjk3KVX7e
	 fkSpk9sxP+2k6NG99Km8ESDoGel1RcNoYmvWIK/5XO5h2IOh7Pd5sAYG+psZRllJ8IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iOLSzVEMlXkB6ktOFlZeNchMP2BpCKiNQiqp2R0zhgQ=;
	b=oCGKoSQ+bVW2sVMydYGDiF0bopdq9fIhLj1bUmpVDyKeAx/EG977Lq9x5I+vaewD0eCB
	 HcD4JDZ+eggRzHLhlef+nDTTuOib6mzYge2SE/waRnxVRAP8EUVs5VlitZbMaAPBqj3GO
	 /VJtDrz3dCb81Qpe9zHB8pTaFqlBzv3NlSrywcMXpNjACn55tjVcDeDqwhsSmShVwMlAc
	 o/blZYAO/9UZVu/tUA86eEk1syNji8rM4zQtNDzlnYbB5/azGGci2LhaKLUa1XCphuIVI
	 9u4Bg01GfCJWPJpFMA1viZ7WT9cnJcxQhMBmtFs0UWHgs/rckLP4Wrwf1y+ibIPCXyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DNY0BCZo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E5606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DNY0BCZo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1801F0089F;
	Tue, 10 Nov 2026 03:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281195;
	bh=iOLSzVEMlXkB6ktOFlZeNchMP2BpCKiNQiqp2R0zhgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DNY0BCZolIQyOo2OiTjPD0bBliU529NaQhTMklrgoK4AIrWutShUaN8klVzwTAdiM
	 d2+7FIMDgByaCABzzVjq9GK7bjmrJuXpa/TJV4tXGKOQJ2SBR5HtDIG1Z3yH4A7K8z
	 1HBeH+29dgI5e+dMkIGMyiU3RoS3B/1ulyFtoNxSPCWnFoJubtEuc8m4u7aislLlI4
	 T+OR/8z8iZ2Q+AUpJ3834/NRJFx1BqVyUkzp1yHZZEcIA8hfSCTHBS/yXCRLZx+Rd1
	 lJ3X1Ru1q4KRexCHH5GhfHgVJF0GAU8jN0hXqkdw7xYPXNqtdZ83BrajmEc3j5bnOy
	 rGmyL79z11fGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: adc: ti-ads1100: Fix incorrect reading when datarate changed in single mode
Date: Mon,  9 Nov 2026 22:26:33 -0500
Message-ID: <20261110032614.57896-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052809-failed-6.6-38dbf24dfbd0@kernel.org>
References: <20261107052809-failed-6.6-38dbf24dfbd0@kernel.org>
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

From: Jakub Szczudlo <jakubszczudlo40@gmail.com>

[ Upstream commit 38dbf24dfbd0a73b89fa2871a7148429aef05531 ]

When device is suspended and it is in single mode then changing
datarate doesn't make it actually wait for new measurement, so to
be sure that read after change is correct, functions that changes
datarate and gain will wait for a new data.

Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Replaced unavailable runtime-PM guards with explicit reference management that calls pm_runtime_mark_last_busy() before autosuspend. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ti-ads1100.c | 121 +++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 1e46f07a9ca6a..bea727ff9d6ee 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -14,10 +14,12 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/iopoll.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time.h>
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
@@ -42,6 +44,9 @@
 static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
 static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
 
+/* Timeout based on the minimum sample rate of 8 SPS (7500ms) */
+#define ADS1100_MAX_DRDY_TIMEOUT_US	(7500 * USEC_PER_MSEC)
+
 struct ads1100_data {
 	struct i2c_client *client;
 	struct regulator *reg_vdd;
@@ -123,10 +128,86 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
 	return 0;
 }
 
+static int ads1100_conversion_busy(struct ads1100_data *data)
+{
+	u8 buffer[3];
+	int ret;
+
+	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return ret;
+	}
+
+	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
+}
+
+static int ads1100_wait_single_conversion(struct ads1100_data *data)
+{
+	int data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
+	int data_rate_Hz = ads1100_data_rate[data_rate_index];
+	unsigned long poll_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, data_rate_Hz) / 4;
+	int busy;
+	int ret;
+
+	ret = readx_poll_timeout(ads1100_conversion_busy, data,
+				 busy, busy <= 0,
+				 poll_us, ADS1100_MAX_DRDY_TIMEOUT_US);
+	if (busy < 0)
+		return busy;
+
+	return ret;
+}
+
+static int ads1100_start_single_conversion(struct ads1100_data *data)
+{
+	u8 config = data->config | ADS1100_CFG_SC;
+	int ret;
+
+	ret = i2c_master_send(data->client, &config, sizeof(config));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C write fail: %d\n", ret);
+		return ret;
+	}
+	/* Need to wait because of change from continuous to single mode */
+	ret = ads1100_wait_single_conversion(data);
+	if (ret)
+		return ret;
+
+	config |= ADS1100_CFG_ST_BSY;
+
+	ret = i2c_master_send(data->client, &config, sizeof(config));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C write fail: %d\n", ret);
+		return ret;
+	}
+
+	/* No need to cache it, it's status bit */
+	data->config = config & ~ADS1100_CFG_ST_BSY;
+
+	return 0;
+}
+
+static int ads1100_poll_data_ready(struct ads1100_data *data)
+{
+	int ret;
+
+	ret = ads1100_start_single_conversion(data);
+	if (ret)
+		return ret;
+
+	ret = ads1100_wait_single_conversion(data);
+	if (ret)
+		return ret;
+
+	return ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_CONTINUOUS);
+}
+
 static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 {
 	int microvolts;
 	int gain;
+	int ret;
 
 	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
 	if (val)
@@ -135,6 +216,10 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (!val2)
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (ret)
+		return ret;
+
 	microvolts = regulator_get_voltage(data->reg_vdd);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
@@ -144,27 +229,51 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	 * bitshift so everything fits in 32-bits yields this formula.
 	 */
 	gain = DIV_ROUND_CLOSEST(microvolts, BIT(15)) * MILLI / val2;
-	if (gain < BIT(0) || gain > BIT(3))
-		return -EINVAL;
+	if (gain < BIT(0) || gain > BIT(3)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
 
-	return 0;
+	ret = ads1100_poll_data_ready(data);
+out:
+	pm_runtime_mark_last_busy(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	return ret;
 }
 
 static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 {
 	unsigned int i;
 	unsigned int size;
+	int ret;
 
 	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
 	for (i = 0; i < size; i++) {
 		if (ads1100_data_rate[i] == rate)
-			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
-						       FIELD_PREP(ADS1100_DR_MASK, i));
+			break;
 	}
 
-	return -EINVAL;
+	if (i == size)
+		return -EINVAL;
+
+	ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (ret)
+		return ret;
+
+	ret = ads1100_set_config_bits(data, ADS1100_DR_MASK,
+				      FIELD_PREP(ADS1100_DR_MASK, i));
+	if (ret)
+		goto out;
+
+	ret = ads1100_poll_data_ready(data);
+out:
+	pm_runtime_mark_last_busy(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	return ret;
 }
 
 static int ads1100_get_vdd_millivolts(struct ads1100_data *data)
-- 
2.53.0

