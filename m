Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071578;
	b=eSlckFbQWTEZqPx+sHMktZlw2tBSAV3mMaRXFvi4Rgve/lt4RP+QkY5JXgXvnrnugjNg
	 YBXL1CgAi2rPK2Yk6cxsE7NENhIzGLo2ujVSYsgU4aZCr0b69zEN2TWq5drYDItFxckiT
	 5/4ysfRFIHH9PeBFE1K2jY0KAX3fHIpXC+YahrHYI6zZ8cEJtnGwV/TYuaWnZITT+vLxc
	 ImZhIqzqf83jBktPA/fqIUJKVcWS9+pPLnkZ935DscJH7cm4k1BrIDkZ82E0mg4+3VpN2
	 L8rfjsxpGjB/xXpM3nkpsyAe0QV9VjeSHxkz0wkzOGne8qRzy9ex9Fhbzi1rgb2kugQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2QK2iE7noXFpUwQUNk0LfJ3uQv+Asv37AvrfE0uGxCo=;
	b=XDKGLjhjPiJRwY2nJ3EU3SuyXh/riow4HyMYWHm+aKEXPlRfZ9eInn7cygI+/MKg4QSG
	 P7pwSZlWOqj/B91QC9+CeL8p9yDZMs9wsSHck9TsVaBOj8zVbTkA9yL3/RPVpF5zO9vJE
	 4vHug8weuCWD+LmkgDHmbQj/jiJ8B9ze7oaIZCRmH/Oc2mYFyMKr+WrJPCKSaeXvR4HGd
	 f4meU1s9B/CkWYC7qIrVHRKLr7QKbQUX/EP256KlGnMrdmg2sOILwdzZrzdjO7cqDilcN
	 Ru5WApc7GsIu22iF9CdTDrEnWvqJVnWjmfAjhq3PeclIsJEURaxVANpemg8NL/8XrbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peE75+7g;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15DC606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C15DC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peE75+7g
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-18cdcfc05ffso4526170c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793071577; x=1793676377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2QK2iE7noXFpUwQUNk0LfJ3uQv+Asv37AvrfE0uGxCo=;
        b=peE75+7giTLgdy0neqNE+JHr8K/D+on9j8SKao4hj7hAu/Wbm5v5rH00RFK8CJx1qZ
         mHQ1q2xpj4F/gbbgfG2AWJKh+fSisAgSbnrlcC38YjhxTuXOdgUDGe8gZRDlik8U1Ytd
         DaGFJvYg/aW8JxXWKSwm4R8qAQ9xKP3LWXvhQ2IY8Y+ShvFF89ErNRAYQCo2EFCmNBoN
         RzD9XWfm5V4EbfuKJ5oSAMwOhnmkl7KXzl2vTAbQTFVRTbYULDsiTd8TX84tquj5aRfG
         Nnx6evrTPRvDPH87t9dy8eoVSg8sGJE0W2voOo8dJOTo99BFweHJpu+ARo78Vc0P/DU/
         QsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071577; x=1793676377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2QK2iE7noXFpUwQUNk0LfJ3uQv+Asv37AvrfE0uGxCo=;
        b=h4QzfHGOb+69bVuomX+YuFaZfRDmtp4ZL5npQVKimClFUUE58Y/klCrlLR3X92tUDW
         TkDNSRuls7D8GvHz0jOwQCY2Q3qfHDkg4HAUrtGATIFLWkGRKdTqdVglvn7ojcTiBuDf
         q4uGdSWFj6QnTfpzD1w+nocDizYBk6v1HYCQnJKuIDF10UqA+/yF8duqvukuJCrcW5Z9
         IUXePjQuCSQN8WeeNThHF6B/uXVcL46Ei8+TqE3tOw4JggoKpJE/Z40IghzfhrjrqYwj
         sNmYMJAFHaOVx3bbJxyBVTRhdESV8RRThDZmVhbxB6JqBR4hf6u0kmtd5x9yiVMqdfe9
         e+SQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8rEot7K7S+kE2sGqGln6p0ij/CIgWaYcuGHoAba+35nI4bisAylQbrBh0+WjkN225Ue+R0aM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJySnVjumiHPSxizPxTOylAYxhc/D8t2Pbn68WRGe3Dxm0I2ryQ
	ROwadfMJhlqZ4CGYoHRu7lnm2OOMuvZ97mS+TWD05BPDe2YwxODOgsG8
X-Gm-Gg: AYBFou2ttUwO7Eq7eLuNV8wFJA/NnrxsA+ein+o5AMsmbk4niTl+HhTwHm+93plvaTh
	nXVraG9q0f8ENDQiDxkQX/aqFdZf21rwAODhriUfBs9JoNKXDZKDYj1YeJv4LSvbv12vuMt+0bD
	Vu+wYMv4zmxuv2J0l1hF5n8GBqM6F+sri9MLpAIwXh0WAsa7xnnT273+92znq8E5eu/jVgkZThk
	QPQ+82E6vkVbnGDkpMkUw75xnFlWhNmGvXorYHxySew5w7D3Jja4TFcFHGSQ1FnmTr4TaxziGsw
	gfvXY7QYjFAF6uggbqyOo52Pqmmm7GEZY4yOU6rtpZr08/Fz1RWIDlJ/mXnrM+nomV7zYy4v6nt
	4Q5dI8M2lRXvNqpicrglFl5VWAR1utH6kVTr54wDyMyhGc7hsAZR4bGR4jQ4LQOpp9gWZN3XmsR
	t5+kEZck3WRWoO+hloB2iwT3aRRYL9JKIRs7SnDG58JjYCuWVb80wiC6nzesV/LAtDCkh/NrlI9
	ivGvprwm2SPvUJDIapxy7G6zdd3M5NVp84Ngmm219MumkCMhheigeVpdG+176sC/gr5Wiv0qWST
	r+lAlXqTM8an/RBerw==
X-Received: by 2002:a05:7022:b886:b0:16a:b995:dc7c with SMTP id a92af1059eb24-19935be80e7mr11905109c88.21.1793071576759;
        Mon, 26 Oct 2026 20:26:16 -0700 (PDT)
Received: from lgs.. ([47.82.67.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0d98660sm32317865c88.9.2026.10.26.20.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:26:16 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: twl6040: fix IRQ action memory leaks during teardown
Date: Tue, 27 Oct 2026 11:26:08 +0800
Message-ID: <20261027032609.119226-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

twl6040_remove() currently removes the regmap IRQ chip before
removing the MFD child devices. This destroys the IRQ mappings
before the child drivers can release their interrupt handlers.

The parent driver also registers READY and thermal interrupt
handlers using devm_request_threaded_irq(). These handlers are
normally released by device-managed cleanup after remove returns,
when the corresponding IRQ descriptors have already been removed.

Consequently, free_irq() cannot find the IRQ descriptors and the
allocated struct irqaction objects are not freed. The associated
IRQ threads also cannot be stopped through the normal cleanup path.

The probe error paths have a similar issue, as they destroy the IRQ
chip before the device-managed IRQ handlers are released.

Remove the MFD child devices first, then explicitly free the
parent's READY and thermal IRQ handlers using devm_free_irq()
before removing the regmap IRQ chip.

Also update the probe error paths to release successfully requested
IRQs before destroying their mappings.

This issue was found by our static analysis tool under development.

Fixes: ab7edb149c75 ("mfd: twl6040: Convert to use regmap_irq")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mfd/twl6040.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 562a0f939f6e..7b05d21cd17d 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -745,7 +745,7 @@ static int twl6040_probe(struct i2c_client *client)
 					"twl6040_irq_th", twl6040);
 	if (ret) {
 		dev_err(twl6040->dev, "Thermal IRQ request failed: %d\n", ret);
-		goto readyirq_err;
+		goto thirq_err;
 	}
 
 	/*
@@ -791,10 +791,14 @@ static int twl6040_probe(struct i2c_client *client)
 	ret = mfd_add_devices(&client->dev, -1, twl6040->cells, children,
 			      NULL, 0, NULL);
 	if (ret)
-		goto readyirq_err;
+		goto mfd_err;
 
 	return 0;
 
+mfd_err:
+	devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
+thirq_err:
+	devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
 readyirq_err:
 	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
 gpio_err:
@@ -809,9 +813,10 @@ static void twl6040_remove(struct i2c_client *client)
 	if (twl6040->power_count)
 		twl6040_power(twl6040, 0);
 
-	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
-
 	mfd_remove_devices(&client->dev);
+	devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
+	devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
+	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
 
 	regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
 }
-- 
2.43.0

