Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071905;
	b=pJFACs22aFWDwzyxvvBwsGCz2p7IMQPT7QPRQ8tEbEB+w9O3Hg7gJ2vG0R/zAKNm+W/E
	 e9uGHJUgtObVlEXyP2+kMLB3RlHeQYsoLaLResKAEsQ9qxlOTRHjQcseNqk49b7JCmIEA
	 L8imdWJtuv1XVsuLxijna2ufPahp0i8zcNsyqZNkyQ4/hf2qCPxsSsTxuS4QOhyPIeoBg
	 phfPhbCVeO/5gUfMAL/hunUst82HMv0OYSK003ccgmyj2fp1JipGqHnWv+pusWNOn4PMZ
	 37DiNpcduTkXvsqytwtR2PrvS7YW4+TfP0JELwVqSphDCywE0RFoK7M2mM4cH3eUnyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GzJZLxK0N1nyYDcTPn6m0/DSL3brMWaSJHk89v88tFE=;
	b=E5VXP4npkzoHME+fh1ZbHSO6k1TJYtkRNTEQhnfABubicnLDmpo4nQarfKmhAw1rWSrp
	 XisY8ceCH3R1Dx/1YTvgvUx0zrHUx+ebpLxW6fqILz5hQzfU8q+T009KbuhFJk/ueDUtS
	 qTFz0eldhX/TKT9/14hHKMBI2GFC9sBZOYsiaBwLdp9m26YquHYhquefmqMDnaXtm7Qjm
	 m061FHOahessKGQ9Foi1jyom0QEn7BHoFTlYXTMT2ZY8XQYLP1lLaJaALx+42f8k+nYLB
	 H3zix+RIgCbhSzL5toSIHGy4e8zLHwOWCafZmV9kgdZNACedjuCjujjL4aB0tYwb30A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=meeIzSY7;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F15606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 17:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5F15606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=meeIzSY7
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-491971ac844so1436356f8f.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 09:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071903; x=1794676703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GzJZLxK0N1nyYDcTPn6m0/DSL3brMWaSJHk89v88tFE=;
        b=meeIzSY7RiL12Tn3Dqy72t250PR3HKMAjCIPHV4Omp6Mw3jPK4J3zRT8GCOtu5xHcc
         7pbvxi83nXPIbAcHu2iQaTzNHsPBAsGfbvnuVzokTJjkn4ohQsqtVt4bZ/lweyutZ91Y
         32vE9QA/inLVmrEbueeW5OPZUoq/vGZtQzZmgl9OIwrw4V4KFl2Q3JniZ/qg9w6kbGxC
         SSUyIfn+ifg2OPg4AiA/jGXOU8gj3nmMsCmKI+gKnXUZ2wN3eEXMwWhxPWOT/UN1JdCT
         Z9Pr6Tse8nRiazmtN3PjIw+NqOPcIgOdncSpQ1KARz47z80F/45HJux7AAhZf5AHVO9J
         yDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071903; x=1794676703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GzJZLxK0N1nyYDcTPn6m0/DSL3brMWaSJHk89v88tFE=;
        b=uZOdvwdA1xxKEyJpzNAwumUcTKlXYGOZCqHvf0ESaKsZLbtxVzFlDbfmcm82KTQVHd
         9dj8Q4VYv3BmVwaeOl7xJDsPaVqdQLEYYD119r4aKUbwTWTzzzigGMCcvfHfm5d/ypBq
         /tDocw/axACvwuQicJOqtozzVg1afbMI3X7ohnwOQw4rP9AjryetUEgM88+psbgYbhKU
         m5LAojJM0cmySSjsCJFiHKuMpH4pNIZ4s3VCcRboNmXJctgCY/KBT/jf3m9ccs5g3jlp
         fS6MWeyLCnolDzA9BBvjjqMxPoCcj63QjssTr3Cgkj3Fd+GIxh1Td9C7eXJZuZwwI3so
         mNlw==
X-Forwarded-Encrypted: i=1; AL+hErG5NcuugeTZSn4pf5PdonrKkK1Jf3kkMAHssDPt3C/lM2sILJJwtnmZ2+Q7li+g9BgUVebuD24=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MfiqrZhBTWc3ngsslcL9KAiGLu531krWJlozFJ8xJI7efPG3L
	ezlBY6buXxoWpqIw8cX7fI5zAQSDaGdH1FdHwIh/LFZdptAd7vOtdI4=
X-Gm-Gg: AYBFou1E5gduO3F+IRuSPyzRI5Qd1B684vOqRVO7uTtpzQ5anwYpi7ifpaihxbMvWbX
	WOetTTnthu+ChZz7fY8zk9nqf7khSZuoowRZvlDuPXdIxAnqTeeG4RetPZFW1CL/YxfSl/bxlH0
	9HBN5pLS7IHOI3neh/nhI/5sxExybrhxP3LPG7jnZOjLxmfPV+P/GUECLGJ3Xqtlgib2ETgETO7
	9rjHatMahpVMJGbGNqm/iksuYVcERVbG5IBtJ4OJxeZR2vt6MpBLyA7QwQnEle6JGc1cLtG24lf
	pVQthbZOIby+dIOtRNUk61sMzeipfBSnzVtRkWt1qj+G1D/E9kyKx3gH2U+xLa2swdvarKdXp7X
	qKs+XidjxJ/3YWrgSIUJzbLxlidgvmM93lW4zxAyeEnNM7q98EbrghCM3dge1m6TaKPImRbTbey
	IjAYpxeM6D8SqT2+FZ8VxGIBGiAMlt9BeAlkK9lJLhv/jBkOHKK59WzJCb75dIhcvRYvn+im/7R
	x9tidTc+r8PQzUe5/BHFNI8AuAoy6mYNf6j+WTgoNj13w7h3PNB7wqwUpDtKskSbeHMh94nIASY
	IWmNnOr48jpBMGA=
X-Received: by 2002:a5d:64ce:0:b0:48f:e879:5890 with SMTP id ffacd0b85a97d-492760da597mr10879426f8f.32.1794071902970;
        Sat, 07 Nov 2026 09:18:22 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc628dsm10434892f8f.48.2026.11.07.09.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:18:22 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Bard Liao <bardliao@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] ASoC: rt5659: fix teardown order and stale state across card rebind
Date: Sat,  7 Nov 2026 17:18:13 +0000
Message-ID: <20261107171813.2561973-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

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
and cancel the delayed work on any I2C teardown path.  Guard
disable_irq() in rt5659_i2c_shutdown() with the irq_disabled flag
to avoid an unbalanced disable when rt5659_remove() already ran.

Store the I2C client pointer in rt5659_priv so all paths can
reference it directly.

Fixes: d3cb2de2479b ("ASoC: rt5659: add rt5659 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
  - Only call rt5659_headset_detect() for JD3-mode jacks; HDA header
    mode registers are set during I2C probe and not re-enabled on rebind
  - Reset HDA IRQ polarity bits to unplugged defaults before
    regcache_mark_dirty() to prevent stale polarity on rebind

 sound/soc/codecs/rt5659.c | 47 ++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/rt5659.h |  1 +
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 68f7d5673e190..b28804fa15806 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3660,6 +3660,16 @@ static int rt5659_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
+static void rt5659_i2c_disable_irq_and_cancel_work(void *data)
+{
+	struct rt5659_priv *rt5659 = data;
+
+	if (rt5659->irq_acquired && !rt5659->irq_disabled)
+		disable_irq(rt5659->i2c->irq);
+	if (rt5659->jack_detect_work_inited)
+		cancel_delayed_work_sync(&rt5659->jack_detect_work);
+}
+
 static int rt5659_probe(struct snd_soc_component *component)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
@@ -3667,8 +3677,10 @@ static int rt5659_probe(struct snd_soc_component *component)
 
 	rt5659->component = component;
 
+	regcache_sync(rt5659->regmap);
+
 	if (rt5659->irq_disabled) {
-		enable_irq(to_i2c_client(component->dev)->irq);
+		enable_irq(rt5659->i2c->irq);
 		rt5659->irq_disabled = false;
 	}
 
@@ -3689,17 +3701,34 @@ static int rt5659_probe(struct snd_soc_component *component)
 static void rt5659_remove(struct snd_soc_component *component)
 {
 	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
-	struct i2c_client *i2c = to_i2c_client(component->dev);
 
 	if (rt5659->irq_acquired) {
-		disable_irq(i2c->irq);
+		disable_irq(rt5659->i2c->irq);
 		rt5659->irq_disabled = true;
 	}
 
 	if (rt5659->jack_detect_work_inited)
 		cancel_delayed_work_sync(&rt5659->jack_detect_work);
 
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
+	}
+
+	rt5659->component = NULL;
+
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
+	regcache_mark_dirty(rt5659->regmap);
 }
 
 #ifdef CONFIG_PM
@@ -4328,6 +4357,13 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
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
@@ -4337,6 +4373,11 @@ static void rt5659_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5659_priv *rt5659 = i2c_get_clientdata(client);
 
+	if (rt5659->irq_acquired && !rt5659->irq_disabled)
+		disable_irq(client->irq);
+	if (rt5659->jack_detect_work_inited)
+		cancel_delayed_work_sync(&rt5659->jack_detect_work);
+
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

