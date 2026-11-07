Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047291;
	b=U3NYRXoT+fGh+jTEAaAUf9osQPnawo51JDorgOAh5rAEj/vZTV6fF05fqMsd4uBqHImS
	 kTBj/k1aZXgWATCpnW8SSA/eTjGgshdfna6fGl0l1O5hS3qOk2Dw5KqnqUMhNyyliUQqt
	 k3zIX8DZ5lJaZ2RDoxz2xHZvm1uA3R+90fBR12EotOxKUiAjpoziwvMiI7us4JVI0CHid
	 D+NIH8b4zbOe6r8AWEihyxFtSOswIo8YQW4Ueq22pQgQBX2UHWcodZiqmNx/OmM0dWwJH
	 wTatTmwplIfusX18dVvUcyS82Bh9hFNIQBBhDUr1vTe88G4Bg3oCeXamKkNLXPatvnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047291;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zBqPI4sxNXE8tMe1kNftYt14+6f4rh3tbpcYKQ94E+E=;
	b=iemeiBM+002Bv4B9IO6NBX0dhCmtZoq1f91HBaySLxaUFV8hNLa5QNK8IQ+6kXfXBd62
	 zR7AvdaFhldyY09Q9N2/OTF2MLb2vVm0Y7qzOS4Ot3kNhW+AiuwldBoj5sUc9vVtzXihW
	 HqGekL+U9WO6cpo4AkDrati9Gglf1oTUHvz3QqH060HxCvDe5fRKArrg9xjvP88dfYU75
	 2rr8XmvkTgZNp9QO3glY5U9lhpiLIUn0oWxKzPYMcgxfWFzQsSyEfMM5bhkQL2cFHgMG4
	 TNiAFu7CMatMRBoThpZnbsuhSFXjd4xNtaIqNWHoAyJwDB+yV7lifo5MiwL++4ZfdzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d8Rb/hrw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873CE606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8Rb/hrw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAD81F0089F;
	Sat,  7 Nov 2026 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047291;
	bh=zBqPI4sxNXE8tMe1kNftYt14+6f4rh3tbpcYKQ94E+E=;
	h=From:To:Cc:Subject:Date;
	b=d8Rb/hrwYnFZMgCMmmXlv2Ld9Eh3bZ9oIXeMOJRfS7CZn8co7MkEC1eUTIGjsV/V7
	 N+x9ZX1RiA5B+0sLU4e/H8j6teXPvL2A0oMoLFQ+l1+e4NPOxbM1MvbCGbyfj8xYXM
	 NeW8nBhVAw+L3zKGBlImc/+AVG2MA+dup5e7IJHj/ceYfaLu6Hm44gTg0BZt+b1LJC
	 M5RPOkI8ROaVkG8Nj/hTjk8PIN3vT3GrqKFiqqD+4RJtpjriaGj3IwaUnlzKSuAIfS
	 FbhYO4aSmXhtRW+m0sSJkpCrMiMJOg+xx7NOZKvnUISIjeBD66K9gRRytRpVVXdSLJ
	 rW5Vag7jvBJAg==
From: Sasha Levin <sashal@kernel.org>
To: jakubszczudlo40@gmail.com,
	andriy.shevchenko@intel.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: adc: ti-ads1100: Fix incorrect reading when datarate changed in single mode" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:09 -0500
Message-ID: <20261107052809-failed-6.6-38dbf24dfbd0@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 38dbf24dfbd0a73b89fa2871a7148429aef05531
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052809-failed-6.6-38dbf24dfbd0@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 38dbf24dfbd0a73b89fa2871a7148429aef05531 Mon Sep 17 00:00:00 2001
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Date: Tue, 4 Aug 2026 21:28:38 +0200
Subject: [PATCH] iio: adc: ti-ads1100: Fix incorrect reading when datarate
 changed in single mode

When device is suspended and it is in single mode then changing
datarate doesn't make it actually wait for new measurement, so to
be sure that read after change is correct, functions that changes
datarate and gain will wait for a new data.

Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ti-ads1100.c | 107 +++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 9fe8d54cce83c..03096d7e10914 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -15,10 +15,12 @@
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
@@ -43,6 +45,9 @@
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
@@ -135,6 +216,11 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (!val2)
 		return -EINVAL;
 
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&data->client->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	microvolts = regulator_get_voltage(data->reg_vdd);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
@@ -149,22 +235,35 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 
 	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
 
-	return 0;
+	return ads1100_poll_data_ready(data);
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
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&data->client->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = ads1100_set_config_bits(data, ADS1100_DR_MASK,
+				      FIELD_PREP(ADS1100_DR_MASK, i));
+	if (ret)
+		return ret;
+
+	return ads1100_poll_data_ready(data);
 }
 
 static int ads1100_get_vdd_millivolts(struct ads1100_data *data)
-- 
2.53.0




