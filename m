Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F130439F9E
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360617; cv=none; b=Z3eKieTHn7U/RgHnH0+/05pyM7zRrraTRpid62rVoGxzuC6Io8p3gEHBc0S6eidPTH8sHCy1DBBlgRup21nJNZul6Xs+6DJ0CRThQxSYROD+xmYDEPpSppDsRzNs3j67klKSRaTfScnXWvR6zmizFP8N1u6jTDAGV4kbZFBmKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360617; c=relaxed/simple;
	bh=/RXIEdBfSd8D6osEYZ1YidMBoUc4bIY9Xc3UHnj34Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vo+e6aDIv8bmzt7KvF3AzlUHBsm2okzxSArFkNWbaFgkt8FhGCvsXEGTA62TbzjyqVcUGa719RV5eJFXqkkeWPh1wC0Ji6X179IbDBHWB7v8IxCgX1Vk2PZbltMgXUeZ+8h9SE8IZSnDeu9EBZRFtw2dmTjLZs5/yfSR/ResYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspiral.be; spf=none smtp.mailfrom=inspiral.be; dkim=pass (2048-bit key) header.d=inspiral-be.20251104.gappssmtp.com header.i=@inspiral-be.20251104.gappssmtp.com header.b=JSty6xIM; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspiral.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=inspiral.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inspiral-be.20251104.gappssmtp.com header.i=@inspiral-be.20251104.gappssmtp.com header.b="JSty6xIM"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488780459e2so1201385f8f.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inspiral-be.20251104.gappssmtp.com; s=20251104; t=1790360614; x=1790965414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGzeXfDrgiYqRCtYgTkGIXW4Hfhn589xMj/GX/7sOpA=;
        b=JSty6xIM4ZlRXsSf1eqXB3AhwyAGpSJ5ySrIS9PFO10nIyhSY0jYspFbN8UUri9JvY
         yvyoB4XS1LYXD6Geg+yqem6WD2RJQ0Ei93MbSNgginz78F1UjXyr9+XGoAi5wvrg9mOR
         QjTLDmyQU0yh7DdzknFdkj8B8SCTvjraWGvoWTeDHEd3jR4pMv48I8fQM2lR9qlkvF/B
         KmB6f1bLlbzCm85aij8S+1y7FguZjy8oLugghBY3+v2ThuvDwF74DKsvUJbiXNV60FUZ
         lQQdLd50Ec4lmGkUqruLVu2iU2eLv4VYz0OTnxSCaJugrVDxuu+vr6echnyGDiFfkB/+
         m4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360614; x=1790965414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YGzeXfDrgiYqRCtYgTkGIXW4Hfhn589xMj/GX/7sOpA=;
        b=BCmr7hHIlaFuTKyaWs4Z/XMh9UJKaMUX0UgA2t6vFSiJjS7y6TZ1RZ7dmZJuV8mGaK
         XBmE9Q7vzZAyKaZb2s6bXsYjYPZXYNcPaXsCprkngBjw4hwVLGAoCKk0JawEx51Gb79m
         O+vtt1j3tXcmnd81IR9EnW2AJgHdPKvNTWstfvYizvvT8rWAlfZA6JCbMS5JMvGtnGue
         q7RtMQXnzpCLI0kVQBsW3oIjc4NL+Lno09RVqmu0Z8Z/RbGjxcfCxZ6aavFO4mGB2DPG
         YNcV+st1U94UEEqjTAzQ+UmT4sSoD8pa7KFTreMKRiAXu2bQFYg1eJlucr+PwpsO/joq
         9Rlw==
X-Forwarded-Encrypted: i=1; AKwUvBzYARf2YSK7YIlVx+WQkYNPDG5RbJ7dSIJ9LxmwrAyQn60GS7oCKmcANXDheKS83FM0A+3HuTI=@vger.kernel.org
X-Gm-Message-State: AFuF++m+RYNQPcqKPVQj7vs6X0iMAoi/qAD4Rw/X/PRxCEj4Avbgwrwk
	MGthwC9jOvcKS769Nvez8WCeylyhm1dJWrnAHubj6B6ni4KGmYCZLn/Vb1dzhevdc4tdaqRm1Rx
	lRbA/STA=
X-Gm-Gg: AYBFou1HtHkz7D8xMcFepbusDd0Coaza3Zf9E4QoAiOU5jK5raV2GjjSVkJyAYl+B2F
	PiBnmwScm2Ri8cELHsTFwD+aNMCy4dKgJkmqGeIPvWS7kgFW+TzpiZNoDZsXH2pZjfp2EVXhySn
	iQrCf8PfH+SYzKomQipg5kKjzi89c+b61xqqaO04cdsSqaMcRsrMzeMWWfGtrL3qdJCwd8ps0dS
	5VJEJHdihK7vPb8nynYA9nzrWUCt9nxnuV0M6pU3NjDnf9ASIRsO1FyGg4xufALUSQJqgQUkQKZ
	X1nRwy9J7uQs2LBrK8chuqid0xdjVJ4sHsxvcM5rWqXMA93YdSLtGqyrJ0bqTCIPlH6L7pV6Glh
	ZNvUUuhineNtEnRm/Nt8uzp0qo+UHkb861Oh3tL1i2zOz4TAIiwMFpCDaRAYiJYz6mRcW/D8pvW
	WeWHrlibqpsIgp6UpEdVo26S+h6LUthFYspI5zuB9hHHhpDdgdXVIyI3IqBgTZiKUKjqHGj9zTZ
	zdi4o/UI3IHrSwv42GOG5RWgAJJgFlM7t7QgVDAwwkODxQY
X-Received: by 2002:a05:600c:6207:b0:49c:fc6c:be13 with SMTP id 5b1f17b1804b1-49fe66ff146mr124005245e9.25.1790360613975;
        Fri, 25 Sep 2026 11:23:33 -0700 (PDT)
Received: from vger.localdomain (178-119-186-126.access.telenet.be. [178.119.186.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe667ae2fsm165253895e9.13.2026.09.25.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:23:31 -0700 (PDT)
From: Tom Verdonck <tom.verdonck@inspiral.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Verdonck <tom.verdonck@inspiral.be>,
	stable@vger.kernel.org,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/3] hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check
Date: Fri, 25 Sep 2026 20:23:22 +0200
Message-ID: <2952f070f82913aea96eec25d28008d3b9058656.1790358356.git.tom.verdonck@inspiral.be>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790358356.git.tom.verdonck@inspiral.be>
References: <cover.1790358356.git.tom.verdonck@inspiral.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260925182322.UwS83UF1BlZH8Lh0MAGWKhijgQ4PFwody2IQAPzOgno@z>

tmp102 records a one-shot deadline in ->ready_time at probe (and resume)
and, on every temperature read, refuses the read with -EAGAIN while
time_before(jiffies, ready_time) is true, in order to skip the first
~35 ms conversion.

->ready_time is an unsigned long compared with time_before(), whose
signed difference is only meaningful while the two values are within
LONG_MAX jiffies of each other. Because ->ready_time is set once and
never refreshed, jiffies keeps advancing away from it, and after 2^31
jiffies the difference flips sign. On a 32-bit HZ=100 kernel that
happens ~248.5 days after boot: time_before() then permanently reports
"not ready" and the driver returns -EAGAIN on every read, without ever
touching the sensor, until the next reboot.

Store the deadline as a 64-bit jiffies value and compare it with
get_jiffies_64()/time_before64(), which does not wrap in any practical
uptime.

Fixes: 3d8f7a89a197 ("hwmon: (tmp102) Improve handling of initial read delay")
Cc: stable@vger.kernel.org
Signed-off-by: Tom Verdonck <tom.verdonck@inspiral.be>
---
 drivers/hwmon/tmp102.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 50a8b050d8da..8c8463ddb6c4 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -58,7 +58,7 @@ struct tmp102 {
 	const char *label;
 	struct regmap *regmap;
 	u16 config_orig;
-	unsigned long ready_time;
+	u64 ready_time;
 	u16 sample_time;
 };
 
@@ -106,7 +106,7 @@ static int tmp102_read_temp(struct device *dev, u32 attr, long *val)
 	switch (attr) {
 	case hwmon_temp_input:
 		/* Is it too early to return a conversion ? */
-		if (time_before(jiffies, tmp102->ready_time)) {
+		if (time_before64(get_jiffies_64(), tmp102->ready_time)) {
 			dev_dbg(dev, "%s: Conversion not ready yet..\n", __func__);
 			return -EAGAIN;
 		}
@@ -354,7 +354,7 @@ static int tmp102_probe(struct i2c_client *client)
 	 * Mark that we are not ready with data until the first
 	 * conversion is complete
 	 */
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 tmp102,
@@ -387,7 +387,7 @@ static int tmp102_resume(struct device *dev)
 	err = regmap_update_bits(tmp102->regmap, TMP102_CONF_REG,
 				 TMP102_CONF_SD, 0);
 
-	tmp102->ready_time = jiffies + msecs_to_jiffies(CONVERSION_TIME_MS);
+	tmp102->ready_time = get_jiffies_64() + msecs_to_jiffies(CONVERSION_TIME_MS);
 
 	return err;
 }
-- 
2.53.0

