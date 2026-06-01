Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BF3ABD8F
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322022; cv=none; b=CWovglMttovnho3a2wsx8AkFE6Rxbu00qGfXhz/YN0jHorKtvR8qYSsNpgbytgMC6wn6xpwY1IXZ0UxdRbwUeeyqR0gHB+KXWNH4wv42R+WZ+AivBLhPxTadnNE3F9yMGrY15lwRAyP2iogSvvBkOQrdBebkbkzgXCwt+dk3j2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322022; c=relaxed/simple;
	bh=eVw7Kq1Gr2HCKBnmBeZNVF21xW9pV+sZYqPZkKpPh58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MG5JVEgwdznDMmzywiPEZXeZPH5tVG4yUVVB2h6bxDeSqu8y1hUFY48xXt/Y/4BMfw2RBYXLaG+f6IlJUGd0eArK/WjU4zU4Q+CEUwprJ7L9luJW2tQVnsGXIRwAI5Y7160M5UoWktKpRUq4T3XMo46SX9BHk3LnB8LgjP8PJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh87dNR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh87dNR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC071F00898;
	Mon,  1 Jun 2026 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322020;
	bh=PZqqrANU2C+tfsV9swzek0nwyrWMSTbTuupZoVJiadc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xh87dNR+nA7BTfiFxUgBsfdh6AL/yMXkRD5Lr5UG6pxc1Yzdt95oEZ7dlY99fkvMy
	 ofGVYFDPdljw9uxAZfeEZp+Eck+HXJ1eJe1224ecA8OUvAP9Zk6v5DiW/8C4Ow5XtW
	 W+p1NEFEPY85OhFASFGzS1Hj458pVqDSIQrrTSEdHbkf4bN7YFC6xA3urSexwz8RQO
	 Wl8yZU1pMdwWIwnMba0/7CjimzYJCPPGSgPy82kMYXRD5Od1r1c+WjcxSH71mwSVDw
	 3FrG8PFjj368EpAUAiL9Zw9sVIMYp132JVb40ZP/cQKl1Uznz08WTTnBb7r6VRGuT/
	 QLPngtiWHoB6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock
Date: Mon,  1 Jun 2026 09:53:37 -0400
Message-ID: <20260601135337.798956-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601135337.798956-1-sashal@kernel.org>
References: <2026052841-exquisite-attach-1b4c@gregkh>
 <20260601135337.798956-1-sashal@kernel.org>
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

