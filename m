Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700162;
	b=hMK46Wp1D6rbwNgW7o6NcOyGv2oxumvTUvIg29FAMEy4oTaoSoGcl3BU6xg+d3oZAG2L
	 Wd3t79gb7EDY2M9d6vwrOqpKxuz7ihZu9v5n074LGwLdYsaniNIn0jU0bySuiNfM6UDjo
	 nwxYR5oVM2+roTkEu4jpV1fTJUMEZHpRa/FlIfx7Q7MV8e5KRO+PO7KKOD9bXineRHQxi
	 IbHvvmSpfqGI11oM+hRqp68x5zMeq6ethCpERHcY+K+undwTT/i9q8+zqmuHMZY+2XLll
	 knnmuvZduVvA9e7HSsgqfSaDF3/1XL7l7MpHPARFLymEgyjQ6XHLo14nRC8maxU5UCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/L59GtHvh66Qoj8GKGfFbB0DmYWNSBlgqJLSXZ9x1vs=;
	b=2dnbf762eg1w82J8wtDjx7yPmyTRHD0+gLJgXqELcnd0cuHc11oaTEWToA2t4bTZMRv6
	 Jt+paf7VXwCTBlINzhQu1A4gs71qwAbNi6n2+a9Kd4ai1MEU94JNYHX4slh2jqjCCsrMg
	 yHipa7izlWZ3IO4CensMck6oSh6Bd/QWqyz4TTDdTnpL9fOBoODaizFY8YvccmGrhtRv+
	 VarHkoshGf630WqzPbgz4hEbsLqsDpyZvOSNjqbd3/hcYEbpo2O1fclspoMi2DTtuQO0L
	 B4bd2xGM5ByQ6TaTTB2IAVyJdvqN/D0zwlc4LU19zvIE67mjy+yMSl4sADCmlOhbrjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWImdMzU;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E01606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E01606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWImdMzU
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb628232d2so3902272a12.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795700161; x=1796304961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/L59GtHvh66Qoj8GKGfFbB0DmYWNSBlgqJLSXZ9x1vs=;
        b=lWImdMzU1KImNUW8qT4asW+bHXqUn/R42L3XAwMpWQ3IPo5nIwxl7dT+aYhGDrk90w
         dPRT9/EbY3LZTjrvRDT5e4JGuPjxVbaal0c+tDOnbjcKJPSb1g7Ba5v+AGqB6GAzQqCZ
         xfDaaqKkYWNxWwKfh6nYVT8vpM1uiJPTWdBtkQMFTZyXz0eiFnmQ2aYuylpfL8qpSCrC
         nyLpGlczhkJ3RM2zQNzO/MHwj/QoiBfAXSroJN/jkfiqbW1i+WoRQAorXxlyX/1gpVcr
         DnRPIgx/KjjHp29vJ06+ecFXMUls7vGR6myfrE9FUJm4T+r20eGWLOnVHYYM9h2ocZ48
         pwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795700161; x=1796304961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/L59GtHvh66Qoj8GKGfFbB0DmYWNSBlgqJLSXZ9x1vs=;
        b=mn6HNQLYImxOPUhIjWcSatI3TCSWZcDEtmixE4axXA+cQAwzkBrRNye1qEjEis+vU+
         uGxXcBeLdHXaOweOaF7MzmIskbcPLci/Se4T1Zn/8lXd3hX5oLGclYa9q/zbgZS4Wnk0
         U/fZLQkEZIlw1ekQbJz9Kwhz0U0Biddr4Hsm1kBGAFXQgI14JDYnpXzLgFPdyEuFTGKE
         Rw7XbKlgvrDAJxq59ducIr5mAC294q9u/O33Y0OXKSzsb85H6FHxGyxvv6F8j6dQRjf4
         Bi8oc/3FnuXNAiawS55ffqHGQHIXtuj309ddd6FQtRhWg4cc7lys4FVhGRMJg/9XNUrJ
         +1OQ==
X-Forwarded-Encrypted: i=1; AL+hErFPCwox0Koo6oUDemO3MszOCOn2uZL0l7mr88LD6141ZbcIUXv9RfmR0BAAcKl+gBG5XcfRY3k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mXZFwXbq4JFEs/+AQx20YRn/VVY2dfvQ7MfjkL1n8+9khHYcw
	dEP0GmSNzzq77FCtNHmH88G95+QFPfUPzqCfReMF78M4vMVkzWSk37Y=
X-Gm-Gg: AZFdTZcDFKr0o4NUvj5oq+fg8t1pVPRYL9Db02s1guV+vyKiyLJjQEvbeJyAUCPDmv0
	b84W/sMmSHgW1AAM/R7DMuTQiKH5ZO2sp83lifWrJ+T3YM3z9jO9VVphDcowkqkV2WAngorbIvG
	DnxQENpQAkLEVyNvam+k0QQSf6qIRWjfJ/i21CB1UwgCZ1kJBTDQrbL2lMb2GG19/KYNWkb1DFR
	F4f6XimOepAP2pDaHRdW7mWX6qKLGce15Hus0cOeLTKtmLgWb0kOzM8/SWMaJ61nmB2ma+Rs5vK
	8ft5if2MgppG4PJ9JoFpsbqhBEI2Nleq2ij1pRdKR9W8Gw+YojWJ6PRil+elx2uaTOrXvPdU/c0
	Z7tdpfuts5kv6ZQYV+Tvz/xSyvGC5BV8oP7gfWjwyKSEOs/i6BEfC/qNPJ9aGNT5JrXWYp6WdPb
	RNrj+ITklLevS9GdYUC0JodGFJJNuyLhGu24NKnPdjBJ4VN6OCycIP8sSQFiQ/kCdtYH8LHhYkw
	8eEbfc6QaNlBnvk5MYUI+M79FfQe7nXUZGSTHxNkdeaaFiYwAHN4iJt6b7sLb3/YvTsKN3KnvQi
	NasbHPnkMjvs65qVlh12sqdf4JR1GVZ/qA2RLEfOLlgl3PV8MPS6RyyrSz2/r/YmfMu7pZSQYOU
	N3+gmcic5Y5N4
X-Received: by 2002:a17:90b:3e81:b0:3b3:ff66:4097 with SMTP id 98e67ed59e1d1-3b41c92a1cdmr18216781a91.26.1795700161363;
        Thu, 26 Nov 2026 05:36:01 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b6fe711sm14480336a91.1.2026.11.26.05.35.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 05:36:01 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: ssd1307fb: release PWM if panel initialization fails
Date: Thu, 26 Nov 2026 21:35:56 +0800
Message-ID: <rc-b1-20261110-vc-112-b07bbe936b75@gmail.com>
X-Mailer: git-send-email 2.50.1
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

On the SSD1307 variant, ssd1307fb_init() gets and enables the PWM
before it sends the panel init commands over I2C. If one of those
writes fails, ssd1307fb_probe() jumps to regulator_enable_error, below
the pwm_disable()/pwm_put() at panel_init_error. The PWM is left
enabled and requested, and its references on the PWM chip device and
module are never dropped. As the PWM stays marked as requested, a later
probe of the display can no longer get it (pwm_device_request() returns
-EBUSY).

The sashiko AI review bot pointed this out on 2026-09-26, while
reviewing an unrelated ssd1307fb error-handling patch.

Jump to panel_init_error instead and drop the now unused
regulator_enable_error label. pwm_disable() and pwm_put() accept NULL,
which covers variants without a PWM, so clear par->pwm when pwm_get()
fails instead of leaving an ERR_PTR() for the error path.

Fixes: bbc79089ae2b ("video: ssd1307fb: Add support for SSD1306 OLED controller")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263%40kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_FB_SSD1307=m, CONFIG_PWM=y, CONFIG_COMPILE_TEST=y; baseline and patched ssd1307fb.o, no new warnings.
No hardware or runtime test was performed.
The path needs an I2C write error during panel init on a solomon,ssd1307fb-i2c device.

 drivers/video/fbdev/ssd1307fb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index ef4bb920c6ff..dbe5dc67e044 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -403,7 +403,9 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		par->pwm = pwm_get(&par->client->dev, NULL);
 		if (IS_ERR(par->pwm)) {
 			dev_err(&par->client->dev, "Could not get PWM from device tree!\n");
-			return PTR_ERR(par->pwm);
+			ret = PTR_ERR(par->pwm);
+			par->pwm = NULL;
+			return ret;
 		}
 
 		pwm_init_state(par->pwm, &pwmstate);
@@ -794,7 +796,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
 
 	ret = ssd1307fb_init(par);
 	if (ret)
-		goto regulator_enable_error;
+		goto panel_init_error;
 
 	bl = backlight_device_register("ssd1307fb-bl", dev, par, &ssd1307fb_bl_ops,
 				       NULL);
@@ -823,7 +825,6 @@ static int ssd1307fb_probe(struct i2c_client *client)
 panel_init_error:
 	pwm_disable(par->pwm);
 	pwm_put(par->pwm);
-regulator_enable_error:
 	if (par->vbat_reg)
 		regulator_disable(par->vbat_reg);
 reset_oled_error:

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
