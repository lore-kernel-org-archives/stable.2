Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA251DF980
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742725; cv=none; b=InC3Yr0oQYL2ExqQxEeZSewsdV1v6DCflKjfQUgy8z0adehQ+cOgzO+Bd9y0R4/UM+4Ncb+nnXmlvVg8oCl/my+TJtTcKdx6UhSbh/F5zDeAlof5tZ2x37ksb+GWLfco0NmfiChGvBtYCIDi8alaDvZf8cAKeOUCAt1+hkDqqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742725; c=relaxed/simple;
	bh=m/4hXS2IdJ7WmhfIW+vikoIRhfNBchsBEas+x5G5gck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEp0TRijf6AI0um8Q7Tdmq171LaHrHIjeTPwfCcH3EVhPj5s7RpRDiGUcWkOxyu44U9hQTYkW+oG+V8HhhYixWqfJycVDtTlmrKlDlcQGk2s7SeSHxxuyArtF6tTpHEucc8LZjbtsdK6W8NDcdOFcQ56r2m5Na/BmLG3/xXn3ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=RKWXVEYu; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="RKWXVEYu"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30bcdf8232fso962486eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742723; x=1782347523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1/oI52PH3Wx5JT2tPFDsg2lMC2FQDBSZ3x4aPzc6k8=;
        b=RKWXVEYu/1JO3Blg7tvuxhTxGDmNRpRpfhtTXzU+tH4nr/0N3NGJsiaGMsEqb6afvS
         b8FTS/posyBPNhAGBjBHpxuEl3CIcf5/6HUjEnIHRP4oz1hIr/igEYAWMdzv0Q4FRXeq
         g2xXioPnShxvospuVxRDIA3ZW/QKgkeHAVhdbTGnQvRF44rjslHkuEbQhRy459VgNUOo
         GvGf33Jwz3lkPPMAEMguFw1G701Gz2xYxtjdfkWAh4HKt3UhyTrJqjwk8Ux8c20r8Tp4
         vL2A816VKOeUn1mrIrDo6UUMNDNQKq+hDm1V4rm+ZAl3u21HSnPSy9T3sALW0PvsN9qV
         8CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742723; x=1782347523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1/oI52PH3Wx5JT2tPFDsg2lMC2FQDBSZ3x4aPzc6k8=;
        b=T2Sx8cRmz+vNSoyq0hIQbWO2rHaXBSk8Txx5xGU+vDa7U7S5jaA6EdND4zgupwcj9J
         Q1jG5vh8EafFQALzO7WGJqYC4TOuvkMTvscimpvl4zchadFypnqxJ/TnC653eGvITfiB
         dF8Wy8A/EeuCplxYZFB+HXTN8MynQKVYiLXANY4P+ITkeiVW1YjgUv7+svv9MoBGFpgc
         Tao7MHvNXrgFkp9o/fhqKQ2oeyQ5uAsebIf3we2fOU1+fsd3Q11/IK8GcxO1IPy3OmMX
         LalqZ4D7+sB/PWVswPmWilA+UWt1EbiDwPXOSQIeNjJUPSNaQ3iwY4N3dIZIO5c6cpcW
         GeOw==
X-Gm-Message-State: AOJu0YwuL7fZbN8MgQOg6v2QbQSJGQQC4vyrcV6sWNyiytBPpzWvrlwZ
	iBSYuhdFrCwuUqIWmC3Clefc+01EUoD1OVXMrVcqaHNdojWi1D8BzF3h6yss0ReNAE8=
X-Gm-Gg: AfdE7clOvprTtgkvYe934UMIuaRZe8Q/fO9sJFcZtBIKsA4k2PJok1eCHxirwvSUIhp
	UZwcgjfaXsN9BoXdfk/hpmRk6ImPAWGm5peyDTiNXvxgdK5aTyELyhcA6ilDhnlfiDWq/NwEOE3
	02A9w8aM99aUghYaMTbzCKtHiVgxixwmr+jccKsPgpDfPt0OVbrLMpmG6yBKgv7LS12FaaP7TC9
	/3e6qqyS6gK7l65cMcmaQAncbMWzmXjGmqmd0clJwdj3hynouqXbdt93ttkb1+kYI15ZVf8nk07
	+nx3CVXdKWVde7iXZTXjoZcZRc8zB1oQOCw98L4U3rSVhWJ6heLTVrwX4nPgJrPvdfop3PQlw+e
	la2mWK5maGf5HhIF4eosdfWINrnkISkqf0KBj/xXUX2HA0KkwMudfOTlpnEpOyWabL7mX/YxbIk
	jhThtX/1mU0Hz7v452b3iTprmY1INULzRddA==
X-Received: by 2002:a05:7300:6115:b0:2ce:3aa1:d39b with SMTP id 5a478bee46e88-30bc9f5410emr4044909eec.20.1781742723170;
        Wed, 17 Jun 2026 17:32:03 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:32:02 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 32/38] hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock
Date: Wed, 17 Jun 2026 17:31:22 -0700
Message-ID: <20260618003128.3112824-32-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
References: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
[ open-coded each `guard(pmbus_lock)(data->client)` as explicit `pmbus_lock_interruptible()`/`pmbus_unlock()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 40 +++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index ae119caa6517..e303517d74f9 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -173,7 +173,12 @@ static int adm1266_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		pmbus_cmd = ADM1266_PDIO_STATUS;
 
+	ret = pmbus_lock_interruptible(data->client);
+	if (ret)
+		return ret;
+
 	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd, read_buf);
+	pmbus_unlock(data->client);
 	if (ret < 0)
 		return ret;
 	if (ret < 2)
@@ -195,11 +200,19 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	unsigned int gpio_nr;
 	int ret;
 
+	ret = pmbus_lock_interruptible(data->client);
+	if (ret)
+		return ret;
+
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS, read_buf);
-	if (ret < 0)
+	if (ret < 0) {
+		pmbus_unlock(data->client);
 		return ret;
-	if (ret < 2)
+	}
+	if (ret < 2) {
+		pmbus_unlock(data->client);
 		return -EIO;
+	}
 
 	status = read_buf[0] + (read_buf[1] << 8);
 
@@ -210,10 +223,14 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	}
 
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS, read_buf);
-	if (ret < 0)
+	if (ret < 0) {
+		pmbus_unlock(data->client);
 		return ret;
-	if (ret < 2)
+	}
+	if (ret < 2) {
+		pmbus_unlock(data->client);
 		return -EIO;
+	}
 
 	status = read_buf[0] + (read_buf[1] << 8);
 
@@ -222,6 +239,8 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 			set_bit(gpio_nr, bits);
 	}
 
+	pmbus_unlock(data->client);
+
 	return 0;
 }
 
@@ -236,11 +255,16 @@ static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	int ret;
 	int i;
 
+	if (pmbus_lock_interruptible(data->client))
+		return;
+
 	for (i = 0; i < ADM1266_GPIO_NR; i++) {
 		write_cmd = adm1266_gpio_mapping[i][1];
 		ret = adm1266_pmbus_block_xfer(data, ADM1266_GPIO_CONFIG, 1, &write_cmd, read_buf);
-		if (ret != 2)
+		if (ret != 2) {
+			pmbus_unlock(data->client);
 			return;
+		}
 
 		gpio_config = read_buf[0];
 		seq_puts(s, adm1266_names[i]);
@@ -262,8 +286,10 @@ static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 
 	write_cmd = 0xFF;
 	ret = adm1266_pmbus_block_xfer(data, ADM1266_PDIO_CONFIG, 1, &write_cmd, read_buf);
-	if (ret != 32)
+	if (ret != 32) {
+		pmbus_unlock(data->client);
 		return;
+	}
 
 	for (i = 0; i < ADM1266_PDIO_NR; i++) {
 		seq_puts(s, adm1266_names[ADM1266_GPIO_NR + i]);
@@ -286,6 +312,8 @@ static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 
 		seq_puts(s, ")\n");
 	}
+
+	pmbus_unlock(data->client);
 }
 
 static int adm1266_config_gpio(struct adm1266_data *data)
-- 
2.54.0

