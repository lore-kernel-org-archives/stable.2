Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BC41F7F2
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287546; cv=pass; b=mqq17RCxE3W3HW2KV26QgR3Bvrto8sfN/m1bs/pc3Z8VmkyzLuzy8AVwwvV+p8yXkNrxEbdNtZjp0YmceRZQ4/qqgplG/J2c+JeLNkkCFT2FC7RWydZ4AGo8hxkLilqh/uym4odQu0OVgxAa6TZDRVUM3XmadohZwcJNqQ8u0og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287546; c=relaxed/simple;
	bh=7PPsh/wW2qYS0wehKM/K22j5ddH8fM0u5YOYLVc/dJE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Cze+Mn4cFL938vYP/TFDy2rAF0CnbD+vORFhzCAXZeYjrkPjWrHDftSaHAVGBV3Xxtal8WMkCBhbZDBbLq0VQg1p8Bq7GXYTWuA9v7PPZ8iFFVJN4T2FXqvjbeWD4Plgd2CPc+seadfKVzs+v2BMWwOAY7xAWn0ge6iFfVoc3Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpIRWLif; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpIRWLif"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa650c8so46909166b.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 15:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790287543; cv=none;
        d=google.com; s=arc-20260327;
        b=ZUwS+lA9KJgS2jZxJz23P007SGhZpO6H8dpPyKGr7zCqziTIlK0rNpRAeoL3yuGVPl
         7lObZv+9J+WWmTp0BGxeSTBNIvp0QG53JBmGuglkdSIXFgGE7y4si4CwAbKF5MMpt53q
         fxSEeSwTXecJWkR0bEhlbHnp/mjbfGkMQJe8DpKPO34yXVQc2O0LO4Tad/gAs7tdBj2r
         h3Big79lHfXmRVsYU1rIRR8kHIJbuQCjK75sYFcWjQJswdvDBl7z5ZNZkXRmeVzezUt/
         pSTJxjhaZM34AAv+rpnnShI99+dyr5GcLYLhzyybwOYrK4TmvuOiC1JwMJZRM0pgyEqW
         1W5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6kv1ryWLeMdgaQcXq5k3ZZjVELOih2y5Rsy9nUxZ+Oo=;
        fh=nDNkTWPr66LD/3BtQuHXbd/eWkg/9NmHEWld6YLU/GE=;
        b=Q8oIJVJhtkQte2xRCGPDANDGZASNQP3/OY+qjQxrs8TNYAwD7cjlSwxi9kS3nwJiA/
         OgpZAU9MC2bWvkG1U264VM2lYGfe9hHLzkqkmZDClgQLlAAHdF1CnOakWxiYt62iPjxz
         GHt7w7WPRTObBbgxYSZ23ifr9daugFZGWrxEF2eA0lgV/wqWJyN6iBPzINUxg2rlizT7
         JP7a1wSOdX55lskJ/sfyeLMbvucQCSop4LLDVcV5lJ1KhGM2yrpflisII6MP8RzKcHvI
         6hJo6ZO9RxptpbHHMiufI0d93sLkqMO6PTpbPy+JzV3OvMTdN5RKVy303tqUEvcelKN/
         cu/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790287543; x=1790892343; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6kv1ryWLeMdgaQcXq5k3ZZjVELOih2y5Rsy9nUxZ+Oo=;
        b=FpIRWLifOQ3iKnOOs7b8sMZ2HgAjhA4WBWkYE81d4ilFoVu4ymzBc4AAU3OguiSgfV
         AkyOrV3YRKfl6u1pxGUC+dsCXWXP5toONBLAGsURWiITMVCjToWdduZvwq+XakURyytZ
         8SbCUok13xnHJZx1tqZVM4l03RCqK3RRmXv4J/Xc0KjxCKXyjZQSOBgfa9yXOqWC/9z8
         /kuOpYT/F1OBKcUtoxMWVcezsEqlLj3rCFRR8h7NdrO5ea3Q/HHWXg7FjFS4NUuyzG7d
         XC2J1oQ2+e/mYjHYYpL2fPmcFNnFHvIPKQ2r5Ub1d0Soh2HsnDMs84r3F0b6AlCV1p8R
         g1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287543; x=1790892343;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6kv1ryWLeMdgaQcXq5k3ZZjVELOih2y5Rsy9nUxZ+Oo=;
        b=l6/knFeTUqUeYlZvbEludM6zJdwnnkibiUePr1qLmZjQd2aYjYWk4P3DziaEfnJkfo
         zj5HUmmDDXTjWmUpHRJlIqr5luu1XeGDdbFnJY6bOU9oQB3FueiSu0XzfqwlSPKdtT1w
         Z+e/rRCABdAzxOIyxwSOPBAhs2tAZIVmmBymGJJI/vqEd73OaUSm/NU1iWTm54/sUON3
         6k9ao6bjwhockQz/dwlR16pWRE9dHK+4rArROALtujvoWwsDXElXt16/AH96ViQquqr2
         8pmU4TzFvLnuk2oGq8n5ckWwDDy5afJX3jFJz7qw0gSj05iABkJJe67BZ5xhWq74OeOo
         FUZg==
X-Forwarded-Encrypted: i=1; AKwUvBwWWwI+8CA69mVl/WqulubP0qhPDP+TdAx8YOKJWUPXQ50v+EiYyFjtxmIvT17spljhyU+8yu0=@vger.kernel.org
X-Gm-Message-State: AFuF++ktZkSBIyPnTjGzmB53ugl3glaKig+lT14eAWDsc+iVwk2fmMNe
	Bo6C92E8ImawwB784w6plnnArdKn3PywEgT/zkgWNlvMKUXv63PajeToXB/raY7kNSkB3veW20Z
	qmwXZzHS4ZubFkcYTkydlgskjPwzztw==
X-Gm-Gg: AYBFou1+w3pLtK3EL5608891wgzXgjcz80g1AgZBzcxqyKux4b9XeArZcQ15cyyFfMq
	WH1TqjGYDsUCU3uZu47fW+G8HrgxAClFyKXSe4rIqKDU05lSlquZd3OIucpnn5GQu5+Wi43KlTL
	J6H1X7Qtr8CRPhYbOAh7mwFdq0Qny6qLsC6jGckXo/IHfFP19OVriIwXpS7uBGIhB+qAzHGexMe
	FqX/pBMmdDEyfv0/9L7Xt1mvGktwnUqdzR8eItVDE5tEY6+FqRf/z0ZRyNAlBXILFxwfwrlASJt
	Y4qEBP1xkZU7JccpNDL3wG8QQWZTY6tO/LFV+fF+HHgLeNiwR4YifyRh+/6a+hPwWWIG4ofv10n
	jOnOeIvh7cvtqUFoW/CwU3LYfTZeXyyVI4/tqZdF+85W0A5M0oO+zU5ycmOs9i8/r
X-Received: by 2002:a17:907:97c3:b0:c20:21be:ea75 with SMTP id
 a640c23a62f3a-c2ac2314317mr320652666b.8.1790287543018; Thu, 24 Sep 2026
 15:05:43 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 15:05:41 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 15:05:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mhun512@gmail.com
Date: Thu, 24 Sep 2026 15:05:41 -0700
X-Gm-Features: AclHuK9Xiiy-R-_FFYfGSBij1yu3Nb9Lv8izicpagfcw0kj18_ng_woEl_xQff8
Message-ID: <CAGEsz8G_s8_HRnHH8s+NvXWXV8Uz2xRDY+He9M57v_fW4H42VA@mail.gmail.com>
Subject: [PATCH v3] ASoC: wm8962: Stop IRQ from requeuing mic_work on remove
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, ae878000@gmail.com
Content-Type: text/plain; charset="UTF-8"

The WM8962 IRQ remains registered to the I2C device when an ASoC card is
unbound. wm8962_remove() cancels mic_work, but a MICD or MICSCD interrupt
can queue it again before the component is destroyed. The work then
accesses the component and reports to the old jack.

Mask microphone interrupts in wm8962_mic_detect(), wait for a handler
that may already have read the mask, and drain mic_work before changing
the jack pointer. Install a new jack before unmasking the interrupts.
Call this path from wm8962_remove() while the component is still valid.
Leave the IRQ registered for FLL, FIFO and thermal events.

Tegra's card remove callback runs after ASoC removes the codec component
and PCM runtimes. Drop its redundant microphone cleanup.

Fixes: 0512615db6db ("ASoC: wm8962: Convert interrupt handler to
direct regmap usage")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v3:
- Use the existing microphone interrupt mask in wm8962_mic_detect() to
  stop new work, then synchronize the IRQ and cancel pending work before
  changing the jack pointer.
- Call wm8962_mic_detect() from the codec remove callback and drop the
  now-redundant Tegra card remove callback.
- Keep the IRQ registered for the other interrupt sources.

Changes in v2:
- Do not disable the IRQ from wm8962_i2c_remove(); card unbind does not
  unbind the I2C client.
- Keep the devm IRQ on the I2C device for FLL, FIFO and thermal events.

Found by inspection; I do not have the hardware, so this is not runtime
tested. The modified codec and Tegra objects compile, and checkpatch
reports no errors or warnings.

 sound/soc/codecs/wm8962.c      | 29 ++++++++++++++---------------
 sound/soc/tegra/tegra_wm8962.c | 13 -------------
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8a9598161b35..7b09de65a009 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3230,21 +3230,22 @@ int wm8962_mic_detect(struct snd_soc_component
*component, struct snd_soc_jack *
 {
 	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
-	int irq_mask, enable;
-
-	wm8962->jack = jack;
-	if (jack) {
-		irq_mask = 0;
-		enable = WM8962_MICDET_ENA;
-	} else {
-		irq_mask = WM8962_MICD_EINT | WM8962_MICSCD_EINT;
-		enable = 0;
-	}
+	int mic_irq_mask = WM8962_MICD_EINT | WM8962_MICSCD_EINT;

+	/* Mask microphone events, then drain the IRQ and work before
changing the jack. */
 	snd_soc_component_update_bits(component, WM8962_INTERRUPT_STATUS_2_MASK,
-			    WM8962_MICD_EINT | WM8962_MICSCD_EINT, irq_mask);
+				    mic_irq_mask, mic_irq_mask);
 	snd_soc_component_update_bits(component, WM8962_ADDITIONAL_CONTROL_4,
-			    WM8962_MICDET_ENA, enable);
+				    WM8962_MICDET_ENA, jack ? WM8962_MICDET_ENA : 0);
+	if (wm8962->irq)
+		synchronize_irq(wm8962->irq);
+	cancel_delayed_work_sync(&wm8962->mic_work);
+
+	wm8962->jack = jack;
+	if (jack)
+		snd_soc_component_update_bits(component,
+					      WM8962_INTERRUPT_STATUS_2_MASK,
+					      mic_irq_mask, 0);

 	/* Send an initial empty report */
 	snd_soc_jack_report(wm8962->jack, 0,
@@ -3592,9 +3593,7 @@ static int wm8962_probe(struct snd_soc_component
*component)

 static void wm8962_remove(struct snd_soc_component *component)
 {
-	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
-
-	cancel_delayed_work_sync(&wm8962->mic_work);
+	wm8962_mic_detect(component, NULL);

 	wm8962_free_gpio(component);
 	wm8962_free_beep(component);
diff --git a/sound/soc/tegra/tegra_wm8962.c b/sound/soc/tegra/tegra_wm8962.c
index 31f9d9181595..a79d464b6a80 100644
--- a/sound/soc/tegra/tegra_wm8962.c
+++ b/sound/soc/tegra/tegra_wm8962.c
@@ -97,18 +97,6 @@ static int tegra_wm8962_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }

-static int tegra_wm8962_remove(struct snd_soc_card *card)
-{
-	struct snd_soc_dai_link *link = &card->dai_link[0];
-	struct snd_soc_pcm_runtime *rtd = snd_soc_get_pcm_runtime(card, link);
-	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
-	struct snd_soc_component *component = codec_dai->component;
-
-	wm8962_mic_detect(component, NULL);
-
-	return 0;
-}
-
 SND_SOC_DAILINK_DEFS(wm8962_hifi,
 	DAILINK_COMP_ARRAY(COMP_EMPTY()),
 	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm8962")),
@@ -129,7 +117,6 @@ static struct snd_soc_card snd_soc_tegra_wm8962 = {
 	.owner = THIS_MODULE,
 	.dai_link = &tegra_wm8962_dai,
 	.num_links = 1,
-	.remove = tegra_wm8962_remove,
 	.fully_routed = true,
 };


-- 
2.53.0
