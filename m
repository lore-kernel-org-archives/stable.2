Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455DC3B27EF
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322515; cv=none; b=GV0GK1oaeevbDZudEr96MwHMmHX1aaeUSXyK8LHKm2ZSDnvAiaRstbkJRnv+UN0PQAv9yyeU/A/VPCqH/oZFCXM6J3fCD5aBvyzVS2ggRQk0BvS/z4R7B5fPafn9rOkzlLlxcYQRZNSY0I64zJUCTvjOvq/JiFuT6eKMtZZ2kWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322515; c=relaxed/simple;
	bh=eVw7Kq1Gr2HCKBnmBeZNVF21xW9pV+sZYqPZkKpPh58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI98V2XD6IAjOKmy30BjuKgz2zwwUcKLJGMZF3zmsnOvW/y7aey0I23OBFsCVhCvtj9FHFjMXe0xPHMhVa0NsYCyMQjIoxrmhsNY8NfRQzG6FC1C+hziT2BdPcRVGa3iyzYOw1FkH8v7QupaXfnFyJuNO8fAu5LiSIzyc7sght0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmJBXF9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmJBXF9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E1E1F00893;
	Mon,  1 Jun 2026 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322514;
	bh=PZqqrANU2C+tfsV9swzek0nwyrWMSTbTuupZoVJiadc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HmJBXF9It2DxlMgMGVZEpWW5Ocd12hBF1DEfhG0Eo4varzB/mCbBJok29xiYVjAMm
	 6Z/5L/q3GaKsvoLjqVP8jKxClR7NktG7NC77P7DymI5IZKvfA+wAEOdMxcRQSRE7gV
	 RtiUCgr4qYzPQOEQR7VanYBxq+srXd6IScC2dvEM/spQBDVPZ2b8tIku/o9eDn807f
	 GjZ6DkKrdeX2EG9rWAjci5OJ5c8aLEnk22oLM4pq4c/lrvgSQuSjmmLI9z2zSiFuvm
	 Jg+GfkKDpZof25Yy1VHog5HI5BHe2e9dfcf4DLzE8q5iic6SKOzDgbIwt0ABin45y+
	 WlQCqLfN08KMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock
Date: Mon,  1 Jun 2026 10:01:51 -0400
Message-ID: <20260601140151.802636-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601140151.802636-1-sashal@kernel.org>
References: <2026052841-exquisite-attach-1b4c@gregkh>
 <20260601140151.802636-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

[ Upstream commit bab8c6fb5af8df7e753d196c1262cb78e92ca872 ]

adm1266_gpio_get(), adm1266_gpio_get_multiple(), and
adm1266_gpio_dbg_show() all issue PMBus reads against the device but
none of them take pmbus_lock.  The pmbus_core framework holds
pmbus_lock around its own multi-transaction sequences (notably the
"set PAGE, then read paged register" pattern used by hwmon
attributes), so an unlocked GPIO accessor can land between a PAGE
write and the subsequent paged read in another thread and corrupt
either side's view of the device state machine.

Take pmbus_lock at the top of each of the three accessors via the
scope-based guard().  The lock is uncontended in the common case and
adds only a single mutex round-trip per call.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-6-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1266.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index d90f8f80be8e0..e077944ebd6f5 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -172,6 +172,8 @@ static int adm1266_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		pmbus_cmd = ADM1266_PDIO_STATUS;
 
+	guard(pmbus_lock)(data->client);
+
 	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd, read_buf);
 	if (ret < 0)
 		return ret;
@@ -192,6 +194,8 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	unsigned int gpio_nr;
 	int ret;
 
+	guard(pmbus_lock)(data->client);
+
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS, read_buf);
 	if (ret < 0)
 		return ret;
@@ -230,6 +234,8 @@ static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	int ret;
 	int i;
 
+	guard(pmbus_lock)(data->client);
+
 	for (i = 0; i < ADM1266_GPIO_NR; i++) {
 		write_cmd = adm1266_gpio_mapping[i][1];
 		ret = adm1266_pmbus_block_xfer(data, ADM1266_GPIO_CONFIG, 1, &write_cmd, read_buf);
-- 
2.53.0

