Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067836;
	b=uF5CwbX8FbpdyfshUD3G0iGd8xJspTWGS7uGCOqFfcZLvvvVK/jJ7l1nqkPLRwMfm6+R
	 O/gRJmWPvkFk1IKQSci5ZyBn8Ya44id04l1IBYPnZjR3x4nHOa9uyJGU714UN8/0Q1Gef
	 672WJph+3ZCSKHqI1G9S+usoxIMrvdLLmQiUKmuNyEIOoYeXhz78+kxI9wAINYzhb0pEm
	 F5SsM8a3tnn3kWlFv6wrDTotYhhIma4c5YlcTd5TmplhokCrl+KAGhUKpCC6nBNC9Msie
	 WUugJEBQSzkyuv+0hLEBx5dh1L8sl6HrkOzSXyrO9AgIfex0vylMCmoh63KwvVaj1Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uwEFi79yypw+F9MqhNVtBH7gc48f9U5WRmKQQsYkJH4=;
	b=0HAqazfQw/3lR+XfdmpxQlXQulBrjhbVSTJh4OulG+CdrDvyAICZR0LYAVDzNgSotnjo
	 UoSzmdtGx/mD5hIjI7b8jY92+RhKhdt8NjPnyFOioMp0zop5x6v78b0emwJrkL9xeJJle
	 mbK1tLEsSfSS5a8XjJCNhshFGcFUMhvkye16njNGLSnGqamOTm7tPKtS2SiyjXLvHIZAl
	 wt4Ma3F0WfpEP3wwQG/6GTnPK2DFRQDdBOEuOgDVOTaq8R+KH05B3D7z7WsnoC/Dj42fk
	 SyI6T7Kmj4OzRIBlAs0KVMPkGjxu2VeYBX5BW5wBhwR/1/xC5mcEYmc5/WRHkikZ/NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pjkWoDCD;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69656606EEA6
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69656606EEA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pjkWoDCD
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so10686905e9.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067834; x=1794672634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uwEFi79yypw+F9MqhNVtBH7gc48f9U5WRmKQQsYkJH4=;
        b=pjkWoDCDj8VX4ohntZKjDf/i/q+6xa7iNdoahxM6ivfkd1kw2eckcpGLG004ts1z0v
         /bHKOQ7ZelZJuU+Io1ttXStvxlyJsUBSIwPQqSoiqBoB5tsFwAF7OgmyY7fseiECNtgL
         d9RKg6GJpENwRRMMdcylAvhS2GhfnYep32ROez5BbxPqs1d7jadZXUiCNFCNax2uUkqZ
         Bx890MLHVuMSqZKfG3KXwQytf6AhNu670ShFG3jCqSwwGhq/Li9psRQUOxx7vvRUEnNY
         LjDqn3hr2Rd7YI7ml4Ig7tJndN30gH+4Gw4/fiSuDV4G1C674myIAoL3NBBzJA+e60Br
         3Lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067834; x=1794672634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uwEFi79yypw+F9MqhNVtBH7gc48f9U5WRmKQQsYkJH4=;
        b=IvoBUwa5GjtY8WEAyNFGr3X8vLH7gz6wRoB7GqYt084KTWSsEz3ybPlxsGGTaedYKG
         P1gu4tvy1f2ZThzfAylM4FHuXY/QyeOlCrpdIrxXzHVIeWZ5JVDZHp50DQMdUfO0wRsO
         LWgvfP9nif/CdQjxk56uHnn9AlHC5qnAZB40Jy6Z7JdMHVd7OWjWBQG+xazT7aAdVWN6
         5H4GeckWh3k5VUsvgEE17P8RPX5s0ybeoi1DT+DXMwXIvkh4cP1XKR2tEPVS4YkCKfni
         xpZK2npKqVgEsZX9x6vgzkY9+yqknuiMCQ3QTypCD5xiMcBHw9EtOquHtq54IMFMwx13
         ILdA==
X-Forwarded-Encrypted: i=1; AKwUvByDjMm4GSBCzq0jn3qT/1zkwngKcufKRh1xrRlm7HdrNXwqN4BOhDkDjHORVPnoke1ATSg04CA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DgYpEWa+/LxydPTRnTrLaWqy81kNiqEkxWbRyHg7K0kI5z4zC
	4d3hVnrqT2SUiZFkSZiptuBmsHNUjHA3nkQsqvuRamFnYf0mU2dpPaQ=
X-Gm-Gg: AYBFou1CUnWeOuF53VttGGB2Vaa24QnLzeki5Ai0TJ8drVJU8moN5RQTtlU67+GVkWB
	DR+wwF4Em/bKWHeX2Wfb4DAeDMqQlQ1V+pxpyA6Q0Jb/LHaVTDu37+abfdk2/LUiQ9mePrN8u1/
	60jmMAo5djj+5XnUlwBs5jMS3XQHHn4UjDrTOndw90/8a+kfo0U6ZIiqIxohh/nlgCYyAeMyeOG
	gep41oFuc7vt7+imY1+HVGAJAdxNEHBVFdCD93aSreBJoCYNCblPWKgVu7+z862lmM69YJjBWIz
	eKTcC08TxZ5DcClPrr2F29pB7szvHFnj0b6silXeak3YRBZ85x+URLfdojteXIcO0jCcdssbi3U
	TT1vkXwalAFK+IusvD8zOq3yfDMLA6FU2z7nuKi8qKsWtQl+rmjF30OL7j8xz/deMDdjzmvc2xR
	dUJRs8rodPcowp1uTd4HW0Hycij5BW7cmTxrDnIkd1VmqQkS8t+FGIBGOvyBrCYcB+z12+HqSo7
	7mBCgu3TqffO5RJVOHyQSxjYlYhkS+PyXDUYX+sNfMfZ/viWCFIQgvoLdUTHZIQ30XNWOKj3a27
	gO6/yC2PkTkSioKuPN4Sw9C/XaJJBFTMfWF8cw==
X-Received: by 2002:a05:600c:3e0e:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4b6df9be2a8mr99966095e9.28.1794067833456;
        Sat, 07 Nov 2026 08:10:33 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e326b7afsm77532595e9.2.2026.11.07.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:10:33 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] ASoC: rt5668: fix teardown order and stale state across card rebind
Date: Sat,  7 Nov 2026 16:10:24 +0000
Message-ID: <20261107161024.1233587-1-tristmd@gmail.com>
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

The cleanup in rt5668_remove() does not reset hs_jack, jack_type, or
the component pointer, and does not mark the regmap cache dirty after
the codec reset.  On card rebind this leaves a dangling hs_jack pointer
and causes regmap_update_bits() to skip re-programming jack-detection
registers because the cache still holds the pre-reset values.

Additionally, SAR and button-detection registers from a previous
headset session remain cached after the hardware reset.
regcache_sync() on rebind restores this stale state while jack_type
is zero, leaving the SAR source on button mode.  Clear the headset
state by calling rt5668_headset_detect(component, 0) before the
codec reset.

If the I2C device unbinds without a card bound, rt5668_remove() is
never called and the IRQ keeps queuing jack_detect_work until devres
frees the private data.  Register a devm action to disable the IRQ
and cancel both delayed works on any I2C teardown path.  Guard
disable_irq() in rt5668_i2c_shutdown() with the irq_disabled flag
to avoid an unbalanced disable when rt5668_remove() already ran.

Store the I2C client pointer in rt5668_priv so all paths can
reference it directly.

Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Clear SAR/button register state via rt5668_headset_detect(component, 0)
  before codec reset to prevent stale detection state on rebind
- Guard disable_irq() in rt5668_i2c_shutdown() with irq_disabled flag to
  avoid unbalanced disable when rt5668_remove() already ran
 sound/soc/codecs/rt5668.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 29d70802a046a..c8aeaf25a7fd8 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -45,6 +45,7 @@ struct rt5668_priv {
 	struct rt5668_platform_data pdata;
 	struct gpio_desc *ldo1_en;
 	struct regmap *regmap;
+	struct i2c_client *i2c;
 	struct snd_soc_jack *hs_jack;
 	struct regulator_bulk_data supplies[RT5668_NUM_SUPPLIES];
 	struct delayed_work jack_detect_work;
@@ -2213,14 +2214,26 @@ static int rt5668_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
+static void rt5668_i2c_disable_irq_and_cancel_work(void *data)
+{
+	struct rt5668_priv *rt5668 = data;
+
+	if (rt5668->irq_acquired && !rt5668->irq_disabled)
+		disable_irq(rt5668->i2c->irq);
+	cancel_delayed_work_sync(&rt5668->jack_detect_work);
+	cancel_delayed_work_sync(&rt5668->jd_check_work);
+}
+
 static int rt5668_probe(struct snd_soc_component *component)
 {
 	struct rt5668_priv *rt5668 = snd_soc_component_get_drvdata(component);
 
 	rt5668->component = component;
 
+	regcache_sync(rt5668->regmap);
+
 	if (rt5668->irq_disabled) {
-		enable_irq(to_i2c_client(component->dev)->irq);
+		enable_irq(rt5668->i2c->irq);
 		rt5668->irq_disabled = false;
 	}
 
@@ -2230,17 +2243,24 @@ static int rt5668_probe(struct snd_soc_component *component)
 static void rt5668_remove(struct snd_soc_component *component)
 {
 	struct rt5668_priv *rt5668 = snd_soc_component_get_drvdata(component);
-	struct i2c_client *i2c = to_i2c_client(component->dev);
 
 	if (rt5668->irq_acquired) {
-		disable_irq(i2c->irq);
+		disable_irq(rt5668->i2c->irq);
 		rt5668->irq_disabled = true;
 	}
 
 	cancel_delayed_work_sync(&rt5668->jack_detect_work);
 	cancel_delayed_work_sync(&rt5668->jd_check_work);
 
+	if (rt5668->jack_type)
+		rt5668_headset_detect(component, 0);
+
+	rt5668->hs_jack = NULL;
+	rt5668->jack_type = 0;
+	rt5668->component = NULL;
+
 	rt5668_reset(rt5668->regmap);
+	regcache_mark_dirty(rt5668->regmap);
 }
 
 #ifdef CONFIG_PM
@@ -2576,6 +2596,13 @@ static int rt5668_i2c_probe(struct i2c_client *i2c)
 			rt5668->irq_acquired = true;
 	}
 
+	rt5668->i2c = i2c;
+	ret = devm_add_action_or_reset(&i2c->dev,
+				      rt5668_i2c_disable_irq_and_cancel_work,
+				      rt5668);
+	if (ret)
+		return ret;
+
 	return devm_snd_soc_register_component(&i2c->dev, &soc_component_dev_rt5668,
 			rt5668_dai, ARRAY_SIZE(rt5668_dai));
 }
@@ -2584,6 +2611,11 @@ static void rt5668_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5668_priv *rt5668 = i2c_get_clientdata(client);
 
+	if (rt5668->irq_acquired && !rt5668->irq_disabled)
+		disable_irq(client->irq);
+	cancel_delayed_work_sync(&rt5668->jack_detect_work);
+	cancel_delayed_work_sync(&rt5668->jd_check_work);
+
 	rt5668_reset(rt5668->regmap);
 }
 
-- 
2.47.3

