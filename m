Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351974;
	b=X+RHkxR12+uRiMQfCpDhVWeZXJpw1uGpQvCR/0+WEVfUfa7WMueX2ZjjtRTPXrAMzk4f
	 vrBjt0Zb593p1LG+ADMpOpIQDSZTi9GfM3IGzdS6wjrkiiccgiUykt7hdKJSAkIjFN7oM
	 RgxkbeHGLr8xftsFnBRhAHgmx0Soa4OBxLrs269+/J9sS8tF43KyGGKfHM1gfiL6ZeeZK
	 r5RB9fFjmYnBc9GWdC2TiGoGq4zduInSgpRCIOiGDgUb0tWOz8LE8k7PhBRSHzLz2EJ/F
	 WouhcA5vGVGcI0586WXAsnUa27ptqb3Xq6G+WpXBUjvQIvE12hKYJ+iAh3ZDEOZaBkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=x/pvyTEDDINaCH2/Plef7rmiayj2JRdx93dQs90JIcQ=;
	b=cIGoe/0P6CpIApHLA7NQp872m5dfNCrWiwKk3z6acvS4x6VKyeJOhnhc/vHARSeJFtIh
	 MgX0b4W2Q3Ny5GjPwKD+fJI1dJ/wQaWabLqkkFxywLDy/CmYPZJ8Qy3CYeJ/mXlYu2LB1
	 Eig1hGPFctWfdVS7aWk/VjE7M2557B8Qjq6Pl5qGkBh8UCZP9j/c4ug7U7w6f3PTz5CVK
	 UA3yasW9vhhrr8iFTqpx57mu577OGNZHKQRUWS4NGQMEqivKHIMMnXwsxuPomkMTZWMFf
	 pl9w8ZQUaqEcl258BquHfyJhXNedRU4ns3A6hmCmtzaNlwAKJOYnMirUGyDx64swiAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JYtpHh50;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075C606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1075C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JYtpHh50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-49412eb1474so1643594f8f.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794351972; x=1794956772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x/pvyTEDDINaCH2/Plef7rmiayj2JRdx93dQs90JIcQ=;
        b=JYtpHh50jVlNZ9WITT6KjHyD/eQCT43momtC/hJgRqDwFDaAX+OGK5oMi9xNeIRoC6
         5bjceO/QaqrQLty+BBADLbWKm3Zju53S5bq0HNQAL1EQCud+F3fOlhEe9BfNJxHJoZ4P
         iC0yaQyA1i/ywWyryYlECV3EgXIsyvFxwr/FXMmxEocDRhQngdViK/wMkVXIFm0QWtBu
         cslXVq/IbzZL3cKVNfne+CO4KxKWzQAxgiF89wFxR5g1ApSka0Wj4HQxHwCeH1Caul9o
         P6LR8hIZV2Ov4sqhTRjGGmPp6qK3IX3pe0SJ/6z1LAbNl4z2QNfXTnojhxbtpA97ZOqZ
         7HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794351972; x=1794956772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x/pvyTEDDINaCH2/Plef7rmiayj2JRdx93dQs90JIcQ=;
        b=MCrI5UtRVStNSsNJ1uap9rC3aVTEJI/Bd+ImSfpH3DjKslFoFHWhYDW9ObHz2Y5wm5
         Y62SaJKEIx5g4GyD7RsXNtzBt79qeSe9FhwQW1HvsNoRNSBRFg/orIdb7wShpv81EXky
         3hDjM4pvPr68rCLHkyFh9lLHQI2DqrRxR2hv5r4Icua9keOnlHRCzIVgaOPQncqqZIKI
         dVZR3SLFShnM6QDJsX3okCKfYT7ip+FTiOnZxiuMnuSzisNTmx50aAi7Gnbmyu/zfypa
         0JfpT4W1NvueUIWMNZirvj7rPOjJrbyNUihtbDvCfl622xFWuQ9zSXu9juqxAuWXKM6Q
         U3Mw==
X-Forwarded-Encrypted: i=1; AL+hErGf/d95Md7qkqjju8HmivoXft15ml6onGgI8b8VsnzSDZKbHCuK9qVPNImtoaiwfpgjxL9Z04g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9loyMEFDJ8NGraA317uXa6sMtJmlcr/07zxtHuIn2HLXiZ2S9L
	siPSR3r4MhoZgDF5e6S67Pf6s8tt7J/4T50JyW3vQjj2TdUCitNNo+I=
X-Gm-Gg: AYBFou3XaI4PiKN2mMKeOTS+Gw7y7TTd0wXeKjshaeDEAeGaXbnGZ5cPX+ynAaO1yz5
	N71okbg5iY+ILfQ7qymuV5G/9LNGuMcRmvnbNqSBZoZP3GeMCJ98jJNWOQBsvio2pNwQvXgoSTS
	5jJzdHYIfr2K5p1bflGUbOTsyv/eDE5zsol7fZ1Me2UHfFGKJAxLUvh3o/6zapEhrMqo6v30SZ1
	JjEVcxWkb1Qnn6dxPPi/0JkL/47Z6BNz6kkXyMCBoIiRZYoU+zgftYYiNE3PsvAe+2Rfe3woP5E
	bDm5bMpn9zaMZnQ2Kb8VeYJiIgmlmKi3QDhW8JpsDNcig3IOUidetgpWd6VEegT9Us0JazLg5ql
	vyXOau+3rrFk6WH6GHjWSwHgYtgBg/LZzZrMYThnyQxT8g9t/HfqML5OWLwgyJrpVxXrWXQJNbq
	D380kLQ0L0Sr0/onSl+YFFjeoR+iMgEbWi2nXhB95lIswAszV57khUOD09eMiL+m7zb47w+LlAC
	4WDbndkPwa2AH8W4pYJU6gD/VUDN42JGgVN1lPkQjLVqmuEHDf5bf4iP5csJlplBREMQPGkNeJe
	UzGZOr0OSMZJwZzzm1IdeNzN0Ht6
X-Received: by 2002:a05:6000:4013:b0:48e:d27:bef2 with SMTP id ffacd0b85a97d-499c77414eemr523745f8f.21.1794351972234;
        Tue, 10 Nov 2026 15:06:12 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49842f2a1f9sm7568795f8f.15.2026.11.10.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:06:11 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] ASoC: rt5659: fix teardown order and stale state across card rebind
Date: Tue, 10 Nov 2026 23:06:03 +0000
Message-ID: <20261110230603.2110759-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

The cleanup in rt5659_remove() does not reset hs_jack, jack_type, or
the component pointer, and does not mark the regmap cache dirty after
the codec reset.  On card rebind this leaves a dangling hs_jack pointer
and causes regmap_update_bits() to skip re-programming jack-detection
registers because the cache still holds the pre-reset values.

Only clear headset detection state via rt5659_headset_detect() for
JD3-mode jacks.  In HDA header mode the SAR, 4BTN_IL, and IL_IRQ
registers are set up once during I2C probe by
rt5659_intel_hd_header_probe_setup() and are not re-enabled on card
rebind, so clearing them in remove would leave mic detection disabled
after the next bind.

Reset the HDA IRQ polarity bits in RT5659_IRQ_CTRL_1 and
RT5659_IRQ_CTRL_2 to their unplugged defaults before marking the
regmap cache dirty.  Without this, regcache_sync() on rebind restores
plugged-in polarity while hda_hp_plugged and hda_mic_plugged are
false, so the polarity-flip logic in
rt5659_jack_detect_intel_hd_header() never fires and subsequent
plug/unplug events do not generate an interrupt.

If the I2C device unbinds without a card bound, rt5659_remove() is
never called and the IRQ keeps queuing jack_detect_work until devres
frees the private data.  Register a devm action to disable the IRQ
and cancel the delayed work on any I2C teardown path.

Consolidate the IRQ disable and work cancellation into a shared helper
that always sets irq_disabled, so that rt5659_remove(),
rt5659_i2c_shutdown(), and the devm action all follow the same path
and cannot double-disable the interrupt line.

Store the I2C client pointer in rt5659_priv so all paths can
reference it directly.

Fixes: d3cb2de2479b ("ASoC: rt5659: add rt5659 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v3: Consolidate IRQ disable and work cancellation into a shared helper
    (rt5659_disable_irq_and_cancel_work) called from all three teardown
    paths (remove, shutdown, devm action).  The helper sets irq_disabled
    in every path, preventing a double disable_irq if shutdown fires
    before the devm action.  Add regcache_sync in probe so the cache is
    resynchronised on card rebind.
v2: https://lore.kernel.org/linux-sound/20261107153543.6912-1-tristan@talencesecurity.com/
v1: https://lore.kernel.org/linux-sound/20261105145204.5614-1-tristan@talencesecurity.com/
 sound/soc/codecs/rt5659.c | 50 +++++++++++++++++++++++++++++++++------
 sound/soc/codecs/rt5659.h |  1 +
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 68f7d5673e190..1b61323fc7ed6 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3660,6 +3660,21 @@ static int rt5659_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
+static void rt5659_disable_irq_and_cancel_work(struct rt5659_priv *rt5659)
+{
+	if (rt5659->irq_acquired && !rt5659->irq_disabled) {
+		disable_irq(rt5659->i2c->irq);
+		rt5659->irq_disabled = true;
+	}
+	if (rt5659->jack_detect_work_inited)
+		cancel_delayed_work_sync(&rt5659->jack_detect_work);
+}
+
+static void rt5659_i2c_disable_irq_and_cancel_work(void *data)
+{
+	rt5659_disable_irq_and_cancel_work(data);
+}
+
 static int rt5659_probe(struct snd_soc_component *component)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
@@ -3667,8 +3682,10 @@ static int rt5659_probe(struct snd_soc_component *component)
 
 	rt5659->component = component;
 
+	regcache_sync(rt5659->regmap);
+
 	if (rt5659->irq_disabled) {
-		enable_irq(to_i2c_client(component->dev)->irq);
+		enable_irq(rt5659->i2c->irq);
 		rt5659->irq_disabled = false;
 	}
 
@@ -3689,17 +3706,28 @@ static int rt5659_probe(struct snd_soc_component *component)
 static void rt5659_remove(struct snd_soc_component *component)
 {
 	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
-	struct i2c_client *i2c = to_i2c_client(component->dev);
 
-	if (rt5659->irq_acquired) {
-		disable_irq(i2c->irq);
-		rt5659->irq_disabled = true;
+	rt5659_disable_irq_and_cancel_work(rt5659);
+
+	if (rt5659->jack_type && rt5659->pdata.jd_src == RT5659_JD3)
+		rt5659_headset_detect(component, 0);
+
+	rt5659->hs_jack = NULL;
+	rt5659->jack_type = 0;
+	rt5659->hda_hp_plugged = false;
+	rt5659->hda_mic_plugged = false;
+
+	if (rt5659->pdata.jd_src == RT5659_JD_HDA_HEADER) {
+		regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_1,
+				   0x10, 0x10);
+		regmap_update_bits(rt5659->regmap, RT5659_IRQ_CTRL_2,
+				   0x2, 0x0);
 	}
 
-	if (rt5659->jack_detect_work_inited)
-		cancel_delayed_work_sync(&rt5659->jack_detect_work);
+	rt5659->component = NULL;
 
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
+	regcache_mark_dirty(rt5659->regmap);
 }
 
 #ifdef CONFIG_PM
@@ -4328,6 +4356,13 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
 				   RT5659_GP1_PIN_MASK, RT5659_GP1_PIN_IRQ);
 	}
 
+	rt5659->i2c = i2c;
+	ret = devm_add_action_or_reset(&i2c->dev,
+				      rt5659_i2c_disable_irq_and_cancel_work,
+				      rt5659);
+	if (ret)
+		return ret;
+
 	return devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_rt5659,
 			rt5659_dai, ARRAY_SIZE(rt5659_dai));
@@ -4337,6 +4372,7 @@ static void rt5659_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5659_priv *rt5659 = i2c_get_clientdata(client);
 
+	rt5659_disable_irq_and_cancel_work(rt5659);
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
 }
 
diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index e10b3844501b9..1118e6ab1887d 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1793,6 +1793,7 @@ struct rt5659_priv {
 	struct snd_soc_component *component;
 	struct rt5659_platform_data pdata;
 	struct regmap *regmap;
+	struct i2c_client *i2c;
 	struct gpio_desc *gpiod_ldo1_en;
 	struct gpio_desc *gpiod_reset;
 	struct snd_soc_jack *hs_jack;
-- 
2.47.3

