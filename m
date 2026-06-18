Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374E1DA23
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742721; cv=none; b=r4q2gIp5p5GtJSo5EsQWY8agG2ZQOZagW+VgTJQwkZeD02xEss9GRErrchYKey6t+g6w/81Sej6H/axKhmeriE4fZ6DWGLb18a/bgYtishDqy3AIxeue+vc+bQxStPfMqUSk1/IA53LTY+MkpeUNSxscLSjCOnweIQEuHuIIUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742721; c=relaxed/simple;
	bh=66b2b2L7f5XB9oMADHLje40r4GaDbMifzqNR5NRL7eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URATCpa+2BAPzt4F+KIMiUh2ZLcex1pPLn63RjUXfp9WbIEFvpXzljDAKzdFqvpaZoQfV34IoXcY6eW1bsj508QZCTaq70bxnMBn4wjmHRIX8u/Cg2J83AOZDdVbymqdD4qqT00PmKbFNsK4bCXL7dR3S9ykk+QSutqDWS816zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=R3mE5Td8; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="R3mE5Td8"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30bd59b6eb9so731850eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742719; x=1782347519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBFai0TDDF5pG4kZsQ7P1FhtdKfZEdiSnmOvfbySR8s=;
        b=R3mE5Td867r/rphGdSHrTM5EbF9ufthZNinsTSqLhbTTRnHuz4Nh7jy9tgSRsLuJG+
         gyxGbb3WfF1dkCnhIoGL/n3qBbXIABrfg3bIyKMeUwnx7pBNtvzqXKZXpnNBu+2tZhZw
         hWMmfnF1g7mc9sYrNDq+BS5AOJNx6eGzQmmpjvUJfZNOntbHYtmkJOhvF9UblUcXrzfq
         InwFq+e6d/d7PFHks517ilpoZ5A66/e0rYcsV23xaRp1Y314JvSjhCosVQagB/f05wxR
         7u8T6++FudnLNk1XibNmjgwCgAYek22cMbEcO+L6daYy9aYqS9h4NaO90cre77NsZ7nl
         zffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742719; x=1782347519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBFai0TDDF5pG4kZsQ7P1FhtdKfZEdiSnmOvfbySR8s=;
        b=nDkvIt5O3ce+WaW//G78rHw9sLOr10gqsB08VtGGVr9QfTyPCaN747O9Xb3wANsyFN
         VG/TzqS/yyGlpUVsF4O1vJHidMm8s4YGAtUpq2OHcWaPMPRolyYLvt6VPK8rpS/Rg4K3
         bpm4vzF0f8x+oEBJPQA3KvEeZLXHkGC4DIpq9czSE7QHG94JO56kAaDgVnlK4+tm9F9Z
         deiLOjItgEaEYYkliPkvY4X9xJbR5sCOydgSCB0GgJy8Ju9aeAPGs3aedpZAFEBBlk7d
         DHswWvWcv8ekvZ//TDwvChsKPkkHtvyyCBa0DOI5oe+jdejJTYUGvH6M/mh25U25uUNe
         Ou1A==
X-Gm-Message-State: AOJu0YxOuql/nj+c3ULaGTkUL7Eg94iw8XlBsWc92PW4ZXSpn8/EHJQ0
	DazYWyWDZ9rPBZvBv17cfXlZAthbLmSilvqZQC/CCBFi6ohoBoIXMj1g+ad963yDZEs=
X-Gm-Gg: AfdE7cm8FWnCqTndYnVRSNwRKDI1MBFBV+8jw9bZ8fccUNnMcUMzluTDm623R1JwPBt
	PpFU/q96kca5KQKDJPJyfdVopZl6myIc3AYDsbMPKpoj8B3kclB8nthg0WNs2J9+jBbYwerAX/r
	8edW6DTAHgcRRDch1iGXiFD8FAhehXIlRQ9hdh3Suq/90MEtaXvhaPHRzvWlRdSt8EfknBwlnQ5
	U4ZSFmVzK4VsTeGkno3nUehP28IRm2TtPxggoMupw/XyIly898LkeHKW5/sPO12WLBNm8e4wz/Z
	ub4uunDgdWXfFIFqcuL3nCp3+oht9h6SCiXNE8rp36571PomKfnO3QtHcEm/wgZci2ORq9cMK/7
	N5tPVB67/PmmzGNlwifvi9f0kcqNG7fqVE1wGuwaIj99mdAhMhfx9lc69phVQt0h7canfXM1/e+
	5xMZuyhzRglgizzZzqHftcqtj6TpSRq95f/Q==
X-Received: by 2002:a05:7300:cb82:b0:30a:e531:31f9 with SMTP id 5a478bee46e88-30bc9ef94c0mr3856457eec.10.1781742719172;
        Wed, 17 Jun 2026 17:31:59 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:31:58 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 27/38] hwmon: (pmbus/adm1266) register the gpio_chip after pmbus_do_probe()
Date: Wed, 17 Jun 2026 17:31:17 -0700
Message-ID: <20260618003128.3112824-27-abdurrahman@nexthop.ai>
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

commit 491403b9b76cf66abd81301c5901aa4a4549f1e8 upstream.

adm1266_probe() calls adm1266_config_gpio() -- which goes on to
devm_gpiochip_add_data() and exposes the gpio_chip callbacks to
gpiolib -- before pmbus_do_probe() has initialised the per-client
PMBus state (notably the pmbus_lock mutex the core hands out via
pmbus_get_data()).

That ordering is already a latent hazard: any GPIO access that lands
between adm1266_config_gpio() and the end of pmbus_do_probe() (for
example a sysfs read from a user space agent that opens the gpiochip
the instant gpiolib advertises it) races pmbus_do_probe()'s own
device accesses with no serialisation.

Move adm1266_config_gpio() down past pmbus_do_probe() so the chip
isn't reachable from userspace until the PMBus state it depends on
is fully initialised.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-4-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 5395cfbb3821..c3fd4d05a762 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -466,10 +466,6 @@ static int adm1266_probe(struct i2c_client *client)
 	crc8_populate_msb(pmbus_crc_table, 0x7);
 	mutex_init(&data->buf_mutex);
 
-	ret = adm1266_config_gpio(data);
-	if (ret < 0)
-		return ret;
-
 	ret = adm1266_set_rtc(data);
 	if (ret < 0)
 		return ret;
@@ -482,6 +478,10 @@ static int adm1266_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = adm1266_config_gpio(data);
+	if (ret < 0)
+		return ret;
+
 	adm1266_init_debugfs(data);
 
 	return 0;
-- 
2.54.0

