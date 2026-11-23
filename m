Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438992;
	b=v7l6kiD+ooHpXhhl25+S0bt/Nxi9EyRmZ41yFzUZc7HyRungQyy0LUfIavR6SWW9jLKx
	 yjixP/IWCmXyQUqlslzRksAXYKkEhdYX1LKKlCPefcKKAoGWwkEG3sNxyjtywTNPM+nUG
	 yAatKaBI+kr0qL4TFShzTHEPyL6yVO6vrUAeOcwAv1dZoV7PTMgbipzSIQUzNOX6tDJaO
	 ZpK49M6dCbLwMKnvdaE4/XY36OjzKzlqXjv4kO3rTL2vZn7/DxxPYf8dnTpAJLS7Ost19
	 qSIKJiBtUPgMEOOjhYLRu2LsBaR+iWJtQUHwMiqO7jN5UnYBjjHfqn9HuqS+iZ+reMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mDrXuY6jqpxWSzFXHtwGni325RaMm1gVLFRBB2Xcank=;
	b=Oa7yggSMA+FFSv8e6cS/vmU3T5S7nUGWSmXhW08RuXg8D2E0hr4V6zvDEJedFY3aPGx/
	 lwkwRR4p83GnqhZ6opZxcv9n5i/B9Rxn4Oj8PtF4FHhAX+iIJReRUJajUJ6UgcvKETt/w
	 Xt31UJgwWPeq1Ixs3M6V5lh8ro2KHMo+8pgKpQOo7FlRmaZKZRO17dtIKA01PeLIhCuK5
	 ebsRFUidBhMClCUh0ZchCyzepCGR23psVnMlZ5RIOpXd61mGd2DLjsV/MCYcQyTg2N14r
	 iylbsaOUP3/BAh5N0ap0atRx8UjUaRNqvEaLA4ICxtHNbTcZ2/rSsxtfDmaKfix66dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="Ut/Dl8iF";
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12277606A334
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12277606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ut/Dl8iF
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4322d310e7so574625666b.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795438990; x=1796043790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDrXuY6jqpxWSzFXHtwGni325RaMm1gVLFRBB2Xcank=;
        b=Ut/Dl8iFLFDYyi6KA+M8g1eQVi5UmVpRDZM/alCboO32jfq7OUx56WDkOfKT/HhWnF
         tWoVJjnNTuPECYPXsh2Z4654mOf2Ku9FIOJCyBE7t7xFA7RYL0b71HsvGWCrxULvVwMe
         mFgLB6mfBicaRauVR34P7+0O54OstPnb4smIPWwCd8TE2+e4kFRKMleg+WNw8neAsrh8
         BbFCEjmXHHRAJ9u+EIXJF1wwD2RyQdWvw5MmCUMXsg+IN2zdw87T6buPwguI/7e3rAEu
         P/Z3MvdJC3OhrCpM23pkV8mGiLnp8i0bjzrOmZICQhc89bNwO45/Tgf3OiiAFimk68zb
         mMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438990; x=1796043790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDrXuY6jqpxWSzFXHtwGni325RaMm1gVLFRBB2Xcank=;
        b=JQ0lJxA68xxHl3u43BSU5sky5lBOSr0JV6fyXKR2vMl/oK0pbKEEJVDUTRd7XF7d8H
         Y3gF8orR4UH/wczJ855tvTGMpOBWKtqo25UNH+ykCew8ordRFrehCKwmsppo8hbqDwmO
         ExH+FGG8auyme+lV14gtrtte5yswocxaJ6G9TT08wxvqhI79JbwXhzHEALuDvT7I+hND
         oQ1mzVRl5KYbnF9Eb3JS8AhyXs+xTB0572O2NuEHa9w5K6tVDcvn364z82VHSPm2CHxn
         f5YAsZsPbkNMV/CScLPJvJ59ItRSd3xAjGKNRAPI/kivYD0OYVrjETtr+/11bSPb9LZs
         5LmA==
X-Forwarded-Encrypted: i=1; AL+hErE5OYpJEqbfLgdG8L2lA3Lz0rmsocXh31HPQSaaa4FzaHzSDnHRYL7GZ8UvMf1oobeLbmIX2n4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+q77/1SLHCLUkU1PYT1EvF+Byvw9W6mH8BpP7fW/63moFQoyPQ
	L0kFqMhPz3AwKk/idaaPL3T6KX2YakzulsxG9lszGCzBNwXn5qDK1tsDsYVjASb5clc=
X-Gm-Gg: AZFdTZdJAqQwET576pR2655bP6NoMxVIL7AOp9jwef2NDcbQk1rLAgODybe0ev/Ps7L
	wm0MemoLfGF+/946+fXEgegmGh8GIMxEIBWdh9qlB18FqwHpVzcY6X6eAyAWjIdwDwT074iVelk
	zzApGGpMJUZD+P5BScK1Yq2GldshZ8GPb7DNWAqW8yjCamVd6hoNefoOvYqOigAk/Ro7RZbVRVc
	Orw+eC6LI+uYcvGeYvlr9g5X3CV7vmCUVBEhruOmvUap19DifOcQQutufk/4J7VFIAiSpGcqHme
	ATl+8M2C9LLYi9hfDa1ndaa7gQMe+MEDbr63Pr70d90665CbRvyPbBzspLoYa2yhnO5Qv9+Wc5+
	ocwW7L4OL+BvClidqrPUFEOjf2Ye41eAfJF+rVVvvt0VjjWO0G3q28ZtMppD+SYYm2fktpLTtPy
	h9QDHNQJqlO0P5/nBI/7Bv/oUGcFCPLxRvOu6wA9s/pmEeGrJ0jk2iGotpPR2xcZN60sDX5zZYH
	Ucd/X6p9IofOi0ZgdjI1F7NsCTIqDLeU8gDMlraYHUkG7vNeq0SIH+oeUZB//xJdcCcOl3iyLeK
	Vt/iCHtzICQiy+VDffFrGZkvsqAZK75soiWIjzhv2GVfHcO5ZDx+0TlfMU3Pps/RuXx3Fq8dnnG
	oSMqhF7qg3QdVrHKwRf0W1m6jvg6AB50F4JbQ4ko=
X-Received: by 2002:a17:907:948a:b0:c49:9383:a28 with SMTP id a640c23a62f3a-c513ab42e45mr946851266b.35.1795438990465;
        Mon, 23 Nov 2026 05:03:10 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85ecsm401379466b.70.2026.11.23.05.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:03:09 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 23 Nov 2026 13:03:07 +0000
Subject: [PATCH 2/2] usb: typec: tcpm/tcpci_maxim: init wakeup before irq
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-max77759-wait-v1-2-6fa54a751bb7@linaro.org>
References: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
In-Reply-To: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

max_tcpci_probe() requests the TCPC interrupt before it initialises
the wakeup source of the device. Since the interrupt is level
triggered, an already asserted alert can trigger the interrupt handler
before devm_device_init_wakeup() is called. Its pm_wakeup_event() does
nothing while the device has no wakeup source, so the wakeup event of
such an early interrupt is not recorded, meaning the system is then not
prevented from suspending for PD_ACTIVITY_TIMEOUT_MS while handling
that alert.

When the driver unbinds, devres works in reverse order and in this case
removes the wakeup source before it frees the interrupt, which leaves a
similar window.

Call devm_device_init_wakeup() before devm_request_threaded_irq(), so
that the wakeup source exists for as long as the interrupt handler can
run.

Fixes: 6f413b559f86 ("usb: typec: tcpci_maxim: Chip level TCPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 6e202171f57a..2bb306b6b1f9 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -528,16 +528,16 @@ static int max_tcpci_probe(struct i2c_client *client)
 
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
 
+	ret = devm_device_init_wakeup(chip->dev);
+	if (ret)
+		return dev_err_probe(chip->dev, ret, "Failed to init wakeup\n");
+
 	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL, max_tcpci_irq,
 					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
 					chip);
 	if (ret < 0)
 		return ret;
 
-	ret = devm_device_init_wakeup(chip->dev);
-	if (ret)
-		return dev_err_probe(chip->dev, ret, "Failed to init wakeup\n");
-
 	return 0;
 }
 

-- 
2.56.1.750.gf70dc682cf-goog

