Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081888;
	b=AN0pOII8Kf74Fff8ZC2+sTh0foKRHy0ew3OrT8FGXVbH/ljhtlKKLwd9txg/VmETBrdD
	 a76dsRMSuFZrZa9tieLaonn6ROEsl0v231PB1/MDjbGxyDk23uvCvcEwnrnGt/aVz1Xrn
	 V3XRmuC7062/7fkomHPK5psvtvqtIyEp5c51XD5G+9nWLwEwYFTBOOZKOApDEB4Zmv5Bu
	 EjEHO9bWPs0dhHwjAxxJCBiQ1U1muL0WaCPYI1T+Li7Nx1Mmy8LPUEeYkRYZTEjUuQyyS
	 fhSy7yZUv1KYUzqlsZVX/0ZkEhGBmTvcscugXmteGlcLG9FZJR2sSQumzAGBOTqnVbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=aoPl+pQm9ZHcIGL4Om5Oc2NfD/t8KVMY3eNtZkgFANg=;
	b=xSrx4lH2JT7KTLwxqSt0p2ALpAGmYZ7oc+v6DR3Ss/nw8oJh1aXJ/B6YJSPLNa1EFmUL
	 wd/FGzryNMdBW2pEpS3GlfHkJDB80Sdhod23Yw86garapxXqJ2eGPyjBfMtqKs9n2aDJ+
	 nx6cmHIuTXRoMnmUurDHHGS1mLrMdJwAyu/ZinVeLnmS6SzgQ0oxy2EeE+ETk/KW9SGnI
	 25cbKLHyjRPzUhyNomv2jW21xfFoIVWpAhCkY8O3KwR9vU48WtZ2f5m0CE+pMI+ujNmCI
	 nfSqV9z+dekQGp7H1h+jqttrdnaepQ4ptSKnQEjy3gLLISuoXX6hmJhwQPa1nZkdo1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=FWeDOLMX;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477560A2617
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D477560A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=FWeDOLMX
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50abd5b4fcso268547366b.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795081886; x=1795686686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoPl+pQm9ZHcIGL4Om5Oc2NfD/t8KVMY3eNtZkgFANg=;
        b=FWeDOLMX7eEjKZwV4FINw51BroOkvQE1Ee9sZMTI7oinGpI5vzMgLfaFEliLunRZ+c
         2abObKZcLrZs1rxgD6kcSoL9855bUYx56B+1LZTacZFu7FtJwPYl/HUTMVqtLE27OWll
         Xx90WS26Pw5KnX88ygisBJfnAWsBm8iXpSPPRQfOymrbM3MpoJvIGpuLSjo2LhTGxoXQ
         cz7gzYjpu0HH7cP3ppKGKb7iu25zHGXZm5UcBFhQLt7VqBgAFN+Rg8Sa7xjSZCqm7UQo
         t59bB+tXUhLXJgF3N/RmBLs6Y1Lm/RzP9dHvJBkZpUi6PXF/RgdF+Qf8SRcixWpgNXxo
         ptiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081886; x=1795686686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoPl+pQm9ZHcIGL4Om5Oc2NfD/t8KVMY3eNtZkgFANg=;
        b=DOI/HWjGvV4e9q2YDF2mk4/9tTUHmsywcIRCsbOSb3HY5CXUhnrt5Wv8oLrSZ1APkD
         twN4BjrqxHULrRAEHDTfbI8Bg/qXpObMv3gV0jF6tNwRUBRLv5yV1yW5bQdiuk8UkZnA
         YlsvoRa+uz35oJKlAIT+zzi7K8Q3da2fvZvUH2xFfs3LE2IT3TkkR7QNVQxlkLhUSaVs
         vAxNTWzF3Z95IPPoUzfJrbbWEE4j/btBFcnkp/1fmEnShoos2UmKVqjHfWetYDPqoOGB
         hZo6fgnMTZbDE8BwTfZ5Nql8WPstfYcplcag5t5iO3LLQgqe1FSyrB40ljHt/OZoxD+2
         7GNA==
X-Forwarded-Encrypted: i=1; AL+hErGUs1MTzLfMLXlSg62KzrFpn+OUCGamE9ZYDHlz8NZyg7rcBTB9vIBFjttF4Y9ylVpI1FJ0jlU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/c1LkhX+gaOu3LJB7/6do2J8VegBk1/WLVl9yJXEQZBqmF3OQ0
	K1CpRG5/Ldjc3QZMqKhfBtaFWQ1cOnhgSRT4WcnyTlqZerEpFQu9Pmv0snITNvxF+Ac=
X-Gm-Gg: AYBFou2qSDE6wzUplsLSwUdeILnm03/ZsAHQySV0n5wU9KmssJIkR3F4PmcH0geBRok
	2qQ5cu0n9kD/M129PwNODxtzb0QvmpNDVj9iLgoN2zh8IERyfdLqiqVmP6kls9RIMXHEEEY0lnq
	diyhqDhvwvJjkrIYeTQhSQAzzGYy4sJa59Fuc+c+uviwOoR6uFzLB0gelgdCsE4X2kiFMkiOL8a
	l1nKLR6dNw6WtXlwXdbwqHyFBYl6Y7UtnyKsxSMdZnVHAFMRLvw6y8JQqpl4lzWKrDjrWrX/p7W
	WDnAED9mGZJiGlA0RYNoevfbdmXhRL+0kCh299kkInANLgZefq0FipQ0JQbjisLCgPV/+hnMM7k
	MMnngB3dIA7QS8hrStBOvUoJAc5iUUaM85uN2XgfPyXYm3X4NSXhtZKrnHnxwVrDf6hSG/FFqBY
	s3gDZw8vVl+Rioi97q9vReyA4yZJV8xq1jAuc6jRPXeEw0vbyhP9Pn9ysDRYOkG3YsYM801fh24
	zaYXWYTgIZiZvM4iqV1NOvrFb2re9u9HbRnkhkX02Io/Mb9RdjDX9n5QdZ+XbHcs98u9JnNJHVh
	K7Eem0TKy64t1/6CUhrtbIldO2CNh06U8N2WNhMQn+YrASUfZ5okG/Llgw3ADO6+/kA7GL6VOEf
	uuWRBQMp1RUY=
X-Received: by 2002:a17:906:8f8a:b0:c50:5996:5b89 with SMTP id a640c23a62f3a-c510e219138mr480420266b.23.1795081886208;
        Thu, 19 Nov 2026 01:51:26 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51231bc213sm95057166b.12.2026.11.19.01.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:51:25 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 19 Nov 2026 10:51:24 +0100
Subject: [PATCH v4 2/3] media: i2c: dw9719: Update DW9800K driver
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-b4-dw9800k_cleanup-v4-2-df26c431595e@fairphone.com>
References: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
In-Reply-To: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 stable@vger.kernel.org, Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795081884; l=4881;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=rR/uSR6FC+oVbJMW9ps010sQx6WkZ4oy9AD9qxw5jIE=;
 b=DpULb/h5PTjtt0PSNy9pvRAVvuv7bvSa72vNW3KbU0KgiLkAHuEv4Rb0KyCk+pu/EvcwbJdA3
 O/gw60nW0FnAalBove+6U/7ZUom1QfXUT9S/FbndkUbJ1m9rJ0XfkoY
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

The previous DW9800K driver code was created without access to a
datasheet for the part, now that we have one we can clean up some
misunderstandings and add some features for further expandability.

More specifically:

Previously we were blindly writing registers to their downstream values,
Now we know what the correct default values of SAC and SACT, and write
to the correct bits as specified from the datasheet.

We found that the device does indeed have an ID, and add it to the
switch statement when setting up the default device properties.

The largest change would be the implementation of "Ringing," this is
actually an internal switch bit used to differentiate whether the SAC
(smart actuator control) modes are enabled. if the "ringing" bit is
zero, then actuator modes DIRECT and LSC are available(based on the
value written to the Mode register). If the bit is 1, SAC2-SAC5 are
available.

For the devices we tested this driver on, no new values are being
written, but now the option for further use of the DW9800k is available
to others if they wish to do so.

Fixes: 083f7f0dce16 ("media: i2c: dw9719: Add DW9800K support")
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/media/i2c/dw9719.c | 68 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/dw9719.c b/drivers/media/i2c/dw9719.c
index 3b7ba88fd67c044ef9005a0aac6a5d26ab939a90..2879dc99088005cba2567b2a73627c91c270906b 100644
--- a/drivers/media/i2c/dw9719.c
+++ b/drivers/media/i2c/dw9719.c
@@ -68,9 +68,18 @@
 #define DW9761_VCM_PRELOAD		CCI_REG8(8)
 #define DW9761_DEFAULT_VCM_PRELOAD	0x73
 
-#define DW9800K_DEFAULT_SAC		1
+#define DW9800K_ID			0xEB
+#define DW9800K_DEFAULT_SAC		3
 #define DW9800K_MODE_SAC_SHIFT		6
-#define DW9800K_DEFAULT_VCM_FREQ		0x10
+
+#define DW9800K_RESONANCE		CCI_REG8(7)
+
+#define DW9800K_DEFAULT_DIV		0x01
+#define DW9800K_DIV_SHIFT		6
+#define DW9800K_DIV_LOW_SHIFT		2
+
+#define DW9800K_DEFAULT_SACT		0x20
+
 
 #define to_dw9719_device(x) container_of(x, struct dw9719_device, sd)
 
@@ -90,6 +99,7 @@ struct dw9719_device {
 	u32 mode_low_bits;
 	u32 sac_mode;
 	u32 vcm_freq;
+	u32 sac_time;
 
 	struct dw9719_v4l2_ctrls {
 		struct v4l2_ctrl_handler handler;
@@ -140,10 +150,6 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 			dw9719->sac_mode = DW9718S_DEFAULT_SAC;
 			dw9719->vcm_freq = DW9718S_DEFAULT_VCM_FREQ;
 			goto props;
-		case DW9800K:
-			dw9719->sac_mode = DW9800K_DEFAULT_SAC;
-			dw9719->vcm_freq = DW9800K_DEFAULT_VCM_FREQ;
-			goto props;
 		default:
 			break;
 		}
@@ -165,6 +171,11 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 			dw9719->sac_mode = DW9761_DEFAULT_SAC;
 			dw9719->vcm_freq = DW9761_DEFAULT_VCM_FREQ;
 			break;
+		case DW9800K_ID:
+			dw9719->sac_mode = DW9800K_DEFAULT_SAC;
+			dw9719->vcm_freq = DW9800K_DEFAULT_DIV;
+			dw9719->sac_time = DW9800K_DEFAULT_SACT;
+			break;
 		default:
 			dev_err(dw9719->dev,
 				"Error unknown device id 0x%02llx\n", val);
@@ -185,15 +196,52 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 		/* Optional indication of VCM prescale */
 		device_property_read_u32(dw9719->dev, "dongwoon,vcm-prescale",
 					 &dw9719->vcm_freq);
+
+		/* Optional indication of SAC timing */
+		device_property_read_u32(dw9719->dev, "dongwoon,timing-control",
+					 &dw9719->sac_time);
 	}
 
 	switch (dw9719->model) {
-	case DW9800K:
-		cci_write(dw9719->regmap, DW9719_CONTROL, DW9719_ENABLE_RINGING, &ret);
+	case DW9800K: {
+		int ring, sac;
+
+		/*
+		 * Enable ringing for SAC3-SAC5
+		 *
+		 * sac_mode	reg	Mode
+		 * ===========================
+		 *	0	0X	Direct
+		 *	1	1X	LSC
+		 *	2	00	SAC2
+		 *	3	01	SAC3
+		 *	4	10	SAC4
+		 *	5	11	SAC5
+		 */
+		switch (dw9719->sac_mode) {
+		case 0:
+			ring = 0;
+			sac = 0;
+			break;
+		case 1:
+			ring = 0;
+			sac = 2;
+			break;
+		default:
+			ring = DW9719_ENABLE_RINGING;
+			sac = dw9719->sac_mode - 2;
+			break;
+		}
+		cci_write(dw9719->regmap, DW9719_CONTROL, ring, &ret);
+		/* DIV is 3 bits split over the bottom bit in reg 6 and the top 2 bits in reg 7 */
 		cci_write(dw9719->regmap, DW9719_MODE,
-			  dw9719->sac_mode << DW9800K_MODE_SAC_SHIFT, &ret);
-		cci_write(dw9719->regmap, DW9719_VCM_FREQ, dw9719->vcm_freq, &ret);
+			  (sac << DW9800K_MODE_SAC_SHIFT) |
+			  (dw9719->vcm_freq >> DW9800K_DIV_LOW_SHIFT), &ret);
+		cci_write(dw9719->regmap, DW9800K_RESONANCE,
+			  (dw9719->vcm_freq << DW9800K_DIV_SHIFT) |
+			  dw9719->sac_time, &ret);
 		break;
+	}
 	case DW9718S:
 		/* Datasheet says [OCP/UVLO] should be disabled below 2.5V */
 		dw9719->sac_mode &= DW9718S_CONTROL_SAC_MASK;

-- 
2.43.0

