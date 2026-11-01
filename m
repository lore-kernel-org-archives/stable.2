Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793503622;
	b=JnEbHyxcGdc1PyxQNlfonoMuxogDQXmrLzir2ZlNBEPTQMu6RG2PEpGpkiqiRlUe0dhB
	 qkBpS0IoT168UyHQ7oUDHX7eKXPExZZQyt7I8wSLb0MjkWObh0JyeGplT5EYBFxsv7y39
	 ZqhoFqGdO/kqak+0xpxMggD+Dpoe3pRoM9IWJutZBu5UtcHP0S5p7L5/vrO6t2zLm1qrn
	 cBQbBqZJEn4Dw8jwIB8WyIeuSVmjldUjZBIbhAt0kbgca/R5EEaQHJVk9ALrCbDZw0W6J
	 ErKkLIqs9mGojeHbljIz5yqxxKSBleKHjWcMblFJqOiCPLG/20D4f2BbKgNEcWaxBvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z+poO6efwcGNj69j/DfV8JX7ZC/OFlxZpiE6eh71TzA=;
	b=rSpq0cRurzmAAEKugZTKEWK3bWAUUgO3yEoIsu8qBnfeze8NSdaVlVlsxxok8CeutX2N
	 Urw8xGYhGEd2I1Ey5IeIEX907ZU6tMqcUal4JlD2hVrjr1DTiWYvJd8zfHSXfNF3T7nuu
	 IPr0FFUh502gLUJTO5LsXbhdZwgtEOkkcnTHMzeKT1l0fHFsjYfsCBnJNRWhp47+g5Bco
	 KifyMuYkiyucfUzb2ZvSrj3mwi7j9e03essQrJwuztOYi3dzQL6cjpfge8cm7TEf6zY3F
	 S/Au0PzxW2PoWcn+QHtgMYI0a0lSnLF3BBPt7ZlxANiMUNoC7qGuDOYV9+4gNbj4pcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EP0qY+sw;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D51606A327
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 03:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45D51606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EP0qY+sw
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e831e86ebfso11203145ad.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793503622; x=1794108422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z+poO6efwcGNj69j/DfV8JX7ZC/OFlxZpiE6eh71TzA=;
        b=EP0qY+sw7BT9C40L2DjSQr1CG4y31Fg9l/l0swU3caaz+JKEmVDp1NgRJmAT30C2Pi
         /v5HnIXDgXhIAlvaQwGaJWYE+gYaGpHZekD6iy/3GAZL1/98ksvYA3t8K+pfEVvAe0P5
         amlTeHnb1YXgnXgs3ys9OPWeUXDEe7Dy9AeOwH4pv5mkUI4TirWjwph+ne3CvVhZPG36
         inSXD2soCbRG24X2RbCWvTnJ0QTpQ/qXqIkYOr/EXvmHg4X8cUtt095oTNOgGOQS00w/
         QAXcmZkktq4JsboxwR1xwRiWVbA9cRAn4Ca9ZSf0TNnc/j2HAPlk3kMPGEWaaNvOgJr9
         EVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793503622; x=1794108422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z+poO6efwcGNj69j/DfV8JX7ZC/OFlxZpiE6eh71TzA=;
        b=ij3vZe2aftC4O99O49BBvY7G4/qaM8XnmEXKYjZZSko7LEAe5v+1TOTTrJHkPpiyMZ
         sVi2xC0Y2AgrKh5W6FyjvmoEl2IGx4nDyJvVgdEJzLspr39QEq57oFnykxaqC4OwUHt+
         xDxskVz0TtEEFOHPUYgFSJeg+2McSj/MRNXM4Sv6vhOLrXwmXCPxpGaaWxT2BEI7CcK3
         7xOT95zm6KQmMPYdzKng9djLh6FmBJv5d7d3I/hHKxn06s7Pza5p8Q7+sbz3RlNB+vuN
         Op6C4oClDKHqsLd+oJzT3fUizT4p+nGAlM5u76H9Epc3iHgIBnvJWcR2TtJLeQsYj1Ps
         Od5w==
X-Forwarded-Encrypted: i=1; AKwUvBz6wUSxJAZQGdgVFJCUhWH95EzbYO7C60AgZbwutp3vBIJMD1flHe6F4AlRg3jekWi06uYtwxU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SNIAxawea13hPhP3NxDTfuoEMa0tcS4DY7Z/ZVM9As8WRcOtW
	+/37EAhNwwXoWRWKWYOlZUtGKyemDw2zi/Rv90HCExL7p1I5ezSohIFQ
X-Gm-Gg: AYBFou3I4MCojanK4ZUuTDjhAC0GUVIQwHKTVWENTELBOSo2het/xYgC2YuwBOaWNUg
	SNuhXNLvr3TixpV8w2WUjWFtrf1uvDQwnGLzKU8LNEsDqJ4CNr2Uwu9E9dHfJMfIHatSbGBlUmm
	AghJul6dy9q1cSNVc4VF6PYbvpYHTF/+dOdU0BWtA9nxBWbMmkXw3zFb/aOywPkGT7FCxgYihs9
	A3T6CUI1Ew8H18v/GEUVrFcvmAduWWXLmGLtQc4VZyCh9xAQVUlnBSyIHtVvNQPpvlfeO8A+YYP
	ZKbG/lieuKYAytQS7kyoNjWnoqCdLvj1W1uJcJCdbWdQAVa6UkALAv/ZSUhQRMEkDCLU8IYWYMl
	RK1DjsxQRXV6JvQr26NGAkF6Kw9aM9VVAl9esGFmSSf+G9sYD2Vnf/D1H9B756A7R1FzJIjzJz/
	zN/Y3ZKUQ/jTl2tv7vqj6gCZS4FuN7Lqpg2haixrHY7WcqYzW4/CTX8GS7CKh7emAMMzvih8Tsi
	WAKBV1+HPxfndlrAHf56CsRZV6oEzcdKxr/Plx86Ff0q+cGX47s6ooHxFFDN7x8n2OSSp8WM5q5
	mXGW5cb2HsuPxVc4lhglW2kGDhL82ZuI582am+S5+osy7c4lnjaHkw6NMztrNs1yo0Y2jQ4ggD/
	2iO6cBxmIpCZvCqbujLkOJKEUQp6IY4VzDev5NQBuLz9zKS6vxUtrhB1unKnH5DI3RgzUlgJVXz
	thDfE=
X-Received: by 2002:a17:903:11cf:b0:2e4:4eed:5cc5 with SMTP id d9443c01a7336-2eb364c02f9mr64614275ad.38.1793503621559;
        Sat, 31 Oct 2026 20:27:01 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392a5f48sm17193685ad.64.2026.10.31.20.26.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 20:27:00 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pwm: gpio: unregister the chip on driver unbind
Date: Sun,  1 Nov 2026 13:26:46 +1000
Message-ID: <20261101032646.11397-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

pwm_gpio_probe() registers the chip with pwmchip_add(), but the driver
has neither a remove callback nor a devm action calling
pwmchip_remove(). On unbind the devres callbacks release the GPIO
descriptor, cancel the hrtimer and drop the reference taken by
devm_pwmchip_alloc(), while the chip stays registered: it is still in
the pwm_chips idr, its sysfs attributes and character device are still
there and chip->operational is still true.

The chip can therefore still be reached through sysfs export, the
character device, debugfs and pwm_get() from a consumer. Those paths
call into chip->ops, which point into unloaded module text once the
module is gone, and pwm_gpio_apply() re-arms the cancelled hrtimer and
drives a GPIO descriptor the driver no longer owns.

Use devm_pwmchip_add() so that the chip is removed before the hrtimer
is cancelled and the GPIO is released.

Fixes: 7f61257cd6e1 ("pwm: Add GPIO PWM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/pwm/pwm-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
index 5644d78..cffdbcd 100644
--- a/drivers/pwm/pwm-gpio.c
+++ b/drivers/pwm/pwm-gpio.c
@@ -212,7 +212,7 @@ static int pwm_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = pwmchip_add(chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "could not add pwmchip\n");
 
-- 
2.43.0

