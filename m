Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF32ECD1D
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507953; cv=none; b=r9RS89WxUnRMOJ8hNhfR7spXuPM24t0Bb73bX7hte15F4vZlXRMpB/Fpbm4JfXag0ppP+qd3SeY/UuAUMt4Bif1VyF6/mvECBeyTVePdZVqfbCqJPOWX4BaZasGUvj9DBDCu5jBzwX8cNigMAnaWS/70+hzHQW6GiqlaugS1Al0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507953; c=relaxed/simple;
	bh=fLQQ4JIzzuT4Vt7XQPvCoVjlsMWHJ7PoqIP957VnMqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmVLLNdNHSMmRbn9mmKtFVHWeI6rtKoTDOwn2iDKIOjvHoANHGsY3rYqrnElGkcFyHZhrJVPTH2WV/+EmHO3VYDr/OMKraujxI6cCCvPxs6dw+FrsKIptvvPr0fhjccSEYFz9t2sqfRVfMEcKJH7H2Tw+uVUHJ3DKNuInIBRJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inNZalsl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inNZalsl"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso4771919a12.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507949; x=1788112749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I19+PjIQNnODooxQ97qMirgzt/rnck5BIrQXPDznt18=;
        b=inNZalsl0ANHa0i+w0ICoAxv26GI6qIZPMzA6KRbd3R3jgUMQuYdi0CGDsSiJ0SLek
         nyZOfRfhBNZCFJradEUCw3c+UCBPiqhpy1yJeUSNac6VlwfLEZoRad4aPfOIrMSg84oV
         9Si0OT6kIpP2jee34x/Gfj984q6L70wnvKk2O5tuRNz6u2p7ektcOkgMwbszSEg6a8Yq
         46IbboLnDni+S3ciQic8n7Tp2alKQpzb8xQGcndO1yiqZlFQbhlDKqFcKfJXebVprt8O
         Me5evxPyY18InEREs+FrM6Fq7IWYixJTlL4ovBnSYDNJX/0nOqbJ5+MOBq17re0CLfsA
         azFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507949; x=1788112749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I19+PjIQNnODooxQ97qMirgzt/rnck5BIrQXPDznt18=;
        b=Vm839k3wxfkX0PLXeP2f5KMOQdOrw6J3FSFDF3a4tY1wj49SQB8wZ7wU27fsFrlu78
         TZ+ZrlmMGo3aAQFFoPl+GlzyHh5FZnWikWT1nPqNTgNzUbbU2f/Xe3SEfLZh7cWqjpBd
         p/EZhHxvWwpOi+01Iu/TFuvCUAgGW7XLhKSxT6mh/IamqWoiri6yY4VbhQAekt62qoSS
         V4RN1I/1+yuJiQT2/JOoAecPsXJMR+QH5ikQFFydVs7gH11Rz0DVl50404MllQ8GSr/s
         S1BR91hSgI42yg1WcEHULcBFQMnK6/4YZTodxWG4CV76R3yjjkwSO2/z88efN6GZIWzS
         eQYA==
X-Forwarded-Encrypted: i=1; AHgh+RoaVq/ISq1uho7v7GquZHpS5AUjvSX3ECYrvtFt8iUyHnqjuVcHi6Dxfr8llLCAufutzUatQkQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lrwhmZkzKQ6GN/zh4fAH1Fixriz5WtCYQoc4pR7IMUxmm+Xqpv
	+v/jOTl4bRuJM50d6f8hZD5lTZ3fIQ8kC28Ug1dXICMZk2Rfsed+eqWoU5pjiA==
X-Gm-Gg: AR+sD110ipOjheF/HZ9m3JBfPI5TgTkSubDNVnUxa/OtV5elQHbxKaiHz8M8t8PRwV1
	BvKWDcaDluOBsOcKtfMeSVFyDmu5wNiEDpR5oxnA8DQsqjp3LHOH5P86+WrkqnsJ3XCl7pijVe1
	8ZkYctoaRqf2Pqo5dHhd4UP4zMMNqBV6YtR/PMelHijW3YmhOMa7FMsYhcAiTLT4N1vSq7NV+oK
	iMO/YEFUZ2toIVIs/NmSGHHanFLuUxvTYgLrY0dqqX8qR26BmtbxGVUkI9dZIcwnP1DmTfEQUm4
	e2D9vlsKqKiB341GRZ2aenCuxjN674PpF8LNJOYzYxmQvXKLecPOX3S+w8ZJR884PWiWYhom7Gv
	TxetdWmxJc7eFU2ut7Gml6zERsdHa+KQgHPbcika8x8H2DesBLjj7+ehgmVLWVV850BqQy+Vly7
	0UgVF6k+wQITgcP/Jr3xfs1t6PNO2hzflXb5RSqekHb6xTExGi64k1mqudhMP2s2/DYpaNW6/o9
	Pb8xw==
X-Received: by 2002:a05:6402:50c8:b0:6a3:87b7:b516 with SMTP id 4fb4d7f45d1cf-6a582b25777mr12416486a12.6.1787507948478;
        Sun, 23 Aug 2026 10:59:08 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:9afb:38d7:b606:f380:289e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199cb8sm4153933a12.16.2026.08.23.10.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:59:07 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 23 Aug 2026 19:59:01 +0200
Subject: [PATCH v2 1/4] hwmon: chipcap2: fix channels in humidity alarm
 notifications
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-chipcap2_locks-v2-1-6a26c8e9e2fc@gmail.com>
References: <20260823-chipcap2_locks-v2-0-6a26c8e9e2fc@gmail.com>
In-Reply-To: <20260823-chipcap2_locks-v2-0-6a26c8e9e2fc@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787507945; l=1798;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=fLQQ4JIzzuT4Vt7XQPvCoVjlsMWHJ7PoqIP957VnMqs=;
 b=9DUBcEZ9MfS/ltCluXensv7cQ6cP7LfZorGh88txRsFUX+EwvMAMqF2RGAFz/vH3vAEqb42Zd
 RGRLru7TivxAIWPl1JUrYOhqOOpzQoBtyAkat3Mxk0WO0XMFGsXdH3/
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

hwmon_notify_event() expects the channel number as its last argument,
taken into account with the type parameter that it is a humidity sensor
type. Given that this device only provides one humidity channel, 0 must
be passed. The custom construct to enumerate the channels makes wrong
assumptions by listing all types together (temperature and humidity).

Remove the custom channel enumeration and pass the right channel to
hwmon_notify_event() for hwmon_humidity_min_alarm and
hwmon_humidity_max_alarm.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 086571d556b7..9bef767b589e 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -92,11 +92,6 @@ struct cc2_data {
 	bool process_irqs;
 };
 
-enum cc2_chan_addr {
-	CC2_CHAN_TEMP = 0,
-	CC2_CHAN_HUMIDITY,
-};
-
 /* %RH as a per cent mille from a register value */
 static long cc2_rh_convert(u16 data)
 {
@@ -499,7 +494,7 @@ static irqreturn_t cc2_low_interrupt(int irq, void *data)
 
 	if (cc2->process_irqs) {
 		hwmon_notify_event(cc2->hwmon, hwmon_humidity,
-				   hwmon_humidity_min_alarm, CC2_CHAN_HUMIDITY);
+				   hwmon_humidity_min_alarm, 0);
 		cc2->rh_alarm.low_alarm = true;
 	}
 
@@ -512,7 +507,7 @@ static irqreturn_t cc2_high_interrupt(int irq, void *data)
 
 	if (cc2->process_irqs) {
 		hwmon_notify_event(cc2->hwmon, hwmon_humidity,
-				   hwmon_humidity_max_alarm, CC2_CHAN_HUMIDITY);
+				   hwmon_humidity_max_alarm, 0);
 		cc2->rh_alarm.high_alarm = true;
 	}
 

-- 
2.43.0

