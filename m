Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382523;
	b=vgH3R09vXszfIo4CjWVQgr/AODWY6zm4Re456S+MAhtgSupvEcxdZiNjiTr4vxMcaSpe
	 A2axkszcS5sL7RpFSlXVxQK5kuhPHcE47zVvTU7KOH8fUD/oAXlAuFLt79lZxKVqpy5P9
	 WdFnGaFuC/sgOqUQC4SS/X//c6URxG4g/SIC5L4A+UAEpLlPmfvGbR3TaKOuid0p+Eblx
	 ObAlI9jkwykkrqIixYjU7614oLRPi0Yop8rIM+cH8DECCE2qIKF6655rEsVStrbaHUDln
	 lSW6rQNrxdppc7pjr2zjwt/SzKlXS3imltfTs9hMPBcxM5bx8G+VYHsRvS3zU/Wb2gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FH4Kqn8dco80ci61ZbweWMHJrINyff7bOB9z+yUQ3m0=;
	b=baKzawXs51lBWJ5nfmbueeQXB/lHZJlshqE4B953LVMZU6dzgZXLPhk1lY/HdxQfpNR9
	 koOD/N3YriN7cRJDPrpEh/17TIefNbSS6hmR8CCOggnL+Hi8YfzqcfiRko3zMXeLwDald
	 gPhXU5zCBDgfaMOzhEeC9i6C0w9UK1B1g5PewqBz9vjoTZILR+KytlwqBg5iGjzNfy8gM
	 xSW1h5mdBefg0Vi2cQvr4hq7cEJsYWw0g34xXEDqxMcjB915KqcYZcYIZ4HXJRnXlWmjq
	 ipRET4kLAmj62h5J3uHyYwF4nuFIWA4+BG5trUPMqpoWAB0lDgjXnG1mu/aLwoiyDag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P95Q9Rd5;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3260A2603
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5D3260A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P95Q9Rd5
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e47347279so705995f8f.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382521; x=1793987321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FH4Kqn8dco80ci61ZbweWMHJrINyff7bOB9z+yUQ3m0=;
        b=P95Q9Rd5PseHDYfFIJmu4dqQGnogqvpekgrmfUm+JlABfHnAe3n1sSaNYPJb0S5tjS
         Aw7PGPLvrnFvE/kiDqL3auS3EmW3J7zWa30GkzNFcRcwJV0Na1N47vHgnuEKkvyfsx1W
         v48KlD0cDLyzhhEu7LEA480GFCCwYW8U2+mBFGhSBJ30JOjbKLCVr1f3jl8l1F9etkcG
         5dRU8z5cmyDe20v6FojF/6tYYdU1U5Z43F1ajwOy+9ZA8LSOHjuzvvu6DHQXrd6erjZS
         AnjbwbZyk8IhdzO3YVhMMGbYJrYFQLxCge12JaLOwcmNsXNsuf94WPHpxOhl6qI6RagI
         hPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382521; x=1793987321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FH4Kqn8dco80ci61ZbweWMHJrINyff7bOB9z+yUQ3m0=;
        b=MZlLFvmYpgGBkRoJyHudlPyF+NfvzToR/sWl6EJLG7D8g6YM29SkG8BKhDLzIZigd7
         gEfzroSXJ9pPv8Uea4fNIgylCS9fnaqST7R2IgZuOhIHab0CwUaF0K9n86LK/KTulyBq
         HbDJ49Pqjqda/Y3+Jaj1aq1elJ7IyUR1lGolag9cUbkAjGZ9AL+5wXrIwxSs9PTiutVR
         kds8PrN/nmGFQr/ygC00h3/3QMwBGw2NtSebWOYavhEM/gO+HoiXg6cb4ooE4CgF1Fra
         zt4xb3ieqtxKpysjmVNYPttDeYlP8ujOShfw4GBvds70/VoEWpaDElsZnpoXOVa/Mo9M
         Jm/w==
X-Forwarded-Encrypted: i=1; AKwUvBx3F5FAfTQkKw4JoOaWrW6R6gBgSttefBfyzh8191dYxrbLcijO5N6H55Q0jDnrBycC8mTL7VQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhIwR1pRJe4ogmL6s2ePx6zHE+b9s8dWr0fngCULU50HHHYEDh
	MMk5FWhWN1aWZlQ4hKhNQB4CqnYW08VBLkSmKdtYI/gMO06B5XQP+qg=
X-Gm-Gg: AYBFou1dLizZ/gRDrhhr+rmkzuVWvpdFjFVwboJ6OpFgF6z9d40a4C8+TgG6YE6B2RD
	M8q1IMhsaKtUbyHJ1J4ddyuOpKqeyqKLwdTMqs27rgLiQWOtaWo11T3PAyav7MqIbw+G4Dl0k9+
	xbBV3e6kiSV6Lg2rG1rr7/ruxalMQnT20u4b1wYW+jMembrWBKYYD2Eexwp1cB5MyCTZo3YZSQe
	k3NDvSrdguWL6gB5LNXC5F9PaYMlk16EzxhR+hbR8Cl2rE+g3ST6NLm/rFvwbIILpRR+UcIOeax
	OmtLVO3VT2uHt7QI05LyCTwpKld1y8wW1y3MEUWeSuFlD/3XJApzVJN7gVshhr5vZBgh3OeuIar
	cloy+qg9C1bCaUrAqeCjh3nE+Q/3A5nnQfVMiQUZT6sdoFYcxJ6H7PjGJm7EQ2G1CxAeW1KtVHG
	f72PlHUQbzHKWc3doEYWjwY8vqHovBzNH/SfcsMqe0fP7fhk4iGfmhTbW6RvWuJEftUMALRhBEP
	8KxjgeAyYD85w6J0cqKm8JpLzDGJoR4A9DSlc/hIY9FjKapZmYdPuINsygx9CxEHdg56jRPqxu+
	2etfX20v+rE=
X-Received: by 2002:a05:6000:2603:b0:48e:932:aef3 with SMTP id ffacd0b85a97d-48e6e30417amr7527190f8f.23.1793382521184;
        Fri, 30 Oct 2026 10:48:41 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm4492926f8f.40.2026.10.30.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:48:40 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Mark Brown <broonie@kernel.org>,
	Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v5 2/4] ASoC: rt5659: cancel jack_detect_work on component removal
Date: Fri, 30 Oct 2026 17:48:35 +0000
Message-ID: <20261030174837.1839402-3-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030174837.1839402-1-tristan@talencesecurity.com>
References: <20261030174837.1839402-1-tristan@talencesecurity.com>
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

rt5659_remove() resets the codec via regmap_write() but does not cancel
the pending jack_detect_work. Since the IRQ is registered with
devm_request_threaded_irq(), it remains active until after the component
remove callback returns.  The IRQ handler (rt5659_irq) schedules
jack_detect_work, so a late interrupt can queue work that runs against a
reset codec.

Track successful IRQ acquisition with a flag so that disable_irq()
only quiesces a line this driver actually owns.  Guard the
cancel_delayed_work_sync() call with a flag that tracks whether the
work was initialized, since INIT_DELAYED_WORK is only called for
specific jd_src configurations (JD3, JD_HDA_HEADER) and cancelling
an uninitialized work is undefined behavior.

On component remove, disable the IRQ to synchronize with any running
handler and prevent new enqueues, then drain the residual
jack_detect_work synchronously before resetting the hardware.  On the
next component probe (card rebind), re-enable the IRQ to restore jack
detection.

Fixes: d3cb2de2479b ("ASoC: rt5659: add rt5659 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/rt5659.c | 20 +++++++++++++++++++-
 sound/soc/codecs/rt5659.h |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 3097ee6d4e89f..cdf499fb36d67 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3667,6 +3667,11 @@ static int rt5659_probe(struct snd_soc_component *component)
 
 	rt5659->component = component;
 
+	if (rt5659->irq_disabled) {
+		enable_irq(to_i2c_client(component->dev)->irq);
+		rt5659->irq_disabled = false;
+	}
+
 	switch (rt5659->pdata.jd_src) {
 	case RT5659_JD_HDA_HEADER:
 		break;
@@ -3684,6 +3689,15 @@ static int rt5659_probe(struct snd_soc_component *component)
 static void rt5659_remove(struct snd_soc_component *component)
 {
 	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
+
+	if (rt5659->irq_acquired) {
+		disable_irq(i2c->irq);
+		rt5659->irq_disabled = true;
+	}
+
+	if (rt5659->jack_detect_work_inited)
+		cancel_delayed_work_sync(&rt5659->jack_detect_work);
 
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
 }
@@ -4271,6 +4285,7 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
 		regmap_write(rt5659->regmap, RT5659_IRQ_CTRL_2, 0x0040);
 		INIT_DELAYED_WORK(&rt5659->jack_detect_work,
 			rt5659_jack_detect_work);
+		rt5659->jack_detect_work_inited = true;
 		break;
 	case RT5659_JD_HDA_HEADER:
 		regmap_write(rt5659->regmap, RT5659_GPIO_CTRL_3, 0x8000);
@@ -4280,6 +4295,7 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
 		regmap_write(rt5659->regmap, RT5659_IRQ_CTRL_1,  0x0040);
 		INIT_DELAYED_WORK(&rt5659->jack_detect_work,
 			rt5659_jack_detect_intel_hd_header);
+		rt5659->jack_detect_work_inited = true;
 		rt5659_intel_hd_header_probe_setup(rt5659);
 		break;
 	default:
@@ -4290,7 +4306,9 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
 			rt5659_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5659", rt5659);
-		if (ret)
+		if (!ret)
+			rt5659->irq_acquired = true;
+		else
 			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 
 		/* Enable IRQ output for GPIO1 pin any way */
diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index b49fd8baf4e7e..e10b3844501b9 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1813,6 +1813,9 @@ struct rt5659_priv {
 	int jack_type;
 	bool hda_hp_plugged;
 	bool hda_mic_plugged;
+	bool irq_acquired;
+	bool irq_disabled;
+	bool jack_detect_work_inited;
 };
 
 int rt5659_set_jack_detect(struct snd_soc_component *component,
-- 
2.47.3

