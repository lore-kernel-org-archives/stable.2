Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309115;
	b=qfC8r5xp8DJBW6hoDGv+NVrrQtldjSD0dzgJHTMKrfccKadjFBR+X8uyeQ1U1o+VP5t0
	 Cg8uZeATufn0FWAuQB+xQbnydcyPoeXTxVBFdpEJkDeNUocho8M+yx9DcZxlr0JoRRH+j
	 WAuMFw/DKWEeJrLV341Qrejui2Piw/4pACRtK3ITxb7uZgI+wGJf1w0/YvIjtzpgiTydC
	 TjqTJRtcRgZViyHGhchYrKXP9GYu7u/Lm1MPWpw53c5JPbPWAJwEe5IjpoFPWixiaVpIC
	 8pqmsU1R//JsgoMjR3LXoBtS0AE8bQJwvD6oRTaMYvnuz7qOc/HonjjreLFUEx4PMqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MChUyy0FjsXEhylIAil1XOOjFV9EQgJr//a7CLkUnF8=;
	b=ymBQCkg4OMEFmeORrS84oxc8SMVBRkM9dNvhPVxd2YeksxBosZlkvmHHjtidBwsl2ogA
	 bnnJUqRGEETKaqGH1E5yOm3H+0x3Zs9XL0rwv9SZp2I37Qm9Wb2tdoSM4wA9tSEc7BqXz
	 PZByoYbzIRIzllHelyN5FFP1ZpnFUOcCHHDy/y31bID7El9IHLUksVoUIj5zZucbXyg1V
	 1KCQurSwo2gzhssicagsT/tnjKisFqCp4V5atXUnJouQx45H/u6SszIkGUEVMbe/TesV+
	 1ufOKnMBSz2X4HpdkwaTBVqfg/CPEca5nkVbs2Tg4EGZ+vOuTx820HK3rPavYn0iOJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R1DKq2ft;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570EA606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 570EA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R1DKq2ft
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so107425e9.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793309113; x=1793913913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MChUyy0FjsXEhylIAil1XOOjFV9EQgJr//a7CLkUnF8=;
        b=R1DKq2ftS+C2KphbonywRP5w/g9uh1dRdz5bT121HDpfB+2Vg77xjS0u6RmC0KWEB+
         7FDvMZjDPRTvpxFh/f4jRomwb0UUkFawM8lUHpQLjoq5LEiBW8AoieGOOcAID6sEpjvc
         keKMGVDK5u4wY0dcJ7rixFGXEtMNzw2T7DSSq03JJVEqR1w5tZ7EiEBg2pJP0VsM3FQY
         CUH6BmKHIuz89Hnw5jVyjK6QTjErCMcu4ZFxm+dG9w/X4rfXQfq6qjTtRMQ+sjaIO0tz
         Ic5YFTB75z65fAyiJbV6xfVgmH3gNGuC9Gb9MedaRoJ2Fp2kWhW3upeH04VZiRegJFOA
         GHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309113; x=1793913913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MChUyy0FjsXEhylIAil1XOOjFV9EQgJr//a7CLkUnF8=;
        b=DqvDXLJ5RW8Eddpsm/vu/uX20JVCh3SIAZAWdZuRF+//vdqvVGgGOwnDfv1AD14Gb/
         pOXwekQi6bGYiuPQaFZgOXpsXlUG9kW2U/QIBVfuq2zWcEf3gPjLf18YPfW+XUSJOE3n
         VCAz89rEIWlxJGFvHp7gxnTwMlTN0h1bwUTvLt9z1yQ7SNkzildboVLN8gI+JxXGi3zN
         U5bwZPkRMpAONF4WIMMZgDSmd295kbddyQdMwrr6XwTDSIIFTHDxF+tEE9DRjDVEjgMm
         Uxl0NqVKn2rJqcySiYP8oDFZOzXZsOx737IOHcgGDxD4IJiIyFOp9itX6vjhHK+fuvFj
         L/Qg==
X-Forwarded-Encrypted: i=1; AKwUvBzAtqNsvs8RKrQv/kS18kt8jOErq0SOIFyYpL5kpi8rA8d5zc7RLTDLjpJtzu7xEbDT0ASodXw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIOoFRPtuCdWS9hv/YKRwNDcUj4dEuXxkLUf00un2VLIZ95N0O
	t0XSmtxjCA+AibrX31hG3WPDNZez85O/7Bi8Zcnmfn/lZA4PNbaPDsY=
X-Gm-Gg: AYBFou3ulMiy/F0HFFPZals2MmOJWiyg8B4WJVR7Qqx7AXSxLh2MoN/P31hI9vRPIAw
	iGShzZuWFbgyibj9bthalCuFri/+TTWMxPdSK5k36BW0Mfjfi7lHlC7lHJI+SAU8S2fzPFTh10l
	di/ll8dR8OmvLilUhBLQRD2+LudqyrGn9rGhoraw69xBlUUjaU5Jan5UNhnA+XxnoHou2blVyz1
	PMTHrcjxlK93cqnOykUwtgrmzQYOy6PUFwRT7e/X80eztw3gCE2IzQNFVjQyhGz6WRpzTE0LuOS
	DlmU5tPzz9OBUC6lnumxmzw6bghaVF70yrmoGUB6yHm4Dsl2quMcvsXo5Arm0kPkAG629zSyi+8
	IB4fD9SCsE6n8XqX937SzBeZHs3p0pzi8z2781cOM2p7fq7RxFE7uDBuAod0jFQv+/tM8XthSrR
	+wL2OgQX1UlFAofkNSAH/J7J6K7UOd+VuXM/XTlLLsvyGoz0gCfZDgeKpvcJF/bVlzjl2YluhNC
	9IkNsKoHCVpT1yIWBiLnbCFE9AjTzezCmzlfxxY61XB/MfrQLej00IBYKIRXxDwxQhMjgNEuQ4O
	ZVYUQYD/ax8agBkBr6m5
X-Received: by 2002:a05:600c:628d:b0:4a1:f7f4:7ced with SMTP id 5b1f17b1804b1-4ac185bd243mr4579895e9.17.1793309112485;
        Thu, 29 Oct 2026 14:25:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb82584sm714873f8f.27.2026.10.29.14.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:10 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] ASoC: rt5659: cancel jack_detect_work on component removal
Date: Thu, 29 Oct 2026 21:25:02 +0000
Message-ID: <20261029212504.2997364-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029212504.2997364-1-tristmd@gmail.com>
References: <20261029212504.2997364-1-tristmd@gmail.com>
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
Signed-off-by: Tristan Madani <tristmd@gmail.com>
---
Changes in v2:
- Resend as part of unified series (no code changes from prior version)
- Guard cancel with jack_detect_work_inited flag since INIT_DELAYED_WORK
  is conditional on jd_src (JD3 or HDA_HEADER only), per Mark Brown
- Track IRQ acquisition to guard disable_irq/enable_irq

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

