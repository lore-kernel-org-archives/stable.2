Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3C3242D7B
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289904; cv=none; b=KjV5IX0nWA1kYIzMiYF8bG6Xnj9p/v5biWn63m4xWBWN5cxBxJqMXKKV7vEDo4ffaxnPen+jH20ffu2CVQvT7MSGjnLH76l3XusBPMHk/rROA8tTjnHlQETWzt0uovxu23iXIxrt8oXEHLxt+gSvUALKoo5JRzqMtcJeALqLWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289904; c=relaxed/simple;
	bh=Ldrass7YZ/p74jIXxz7+C6GAjM5NGsD+baovS0Mp7zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BdOZiwQvXLYC0hZHpRPLTXnI/igXtfoH3v1ljVeosSxpwn1BzpkNikwfnipXyKwHYphmEnXlcIoB51CrfJ8dQOTJ56QSlzkEd6nKlGR2bAcAWdVd+wp/52N4VgZoTC/T515XVysBGZ2U+u5LUwb1zdi5FYL/a6sLyG+/jZ3kwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3ee+uTw; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3ee+uTw"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53648215f9dso8245791cf.2
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 19:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289902; x=1792894702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6h7cwshK4bhZz90I/AWA8AjZrCXIbK39PmBPiXuKICY=;
        b=R3ee+uTwprxc2JW14NDU0JtduFzxZnaWS1T1MlwOEjFRaxm/knlA4OC18hfT/Bfp8X
         Ar8xNgnzfOeyYTj9acl4HCwCqVRaILVss1phmPzkRRKo0Ezre0762/e7a8U4+S/BN1V4
         oVCeLR5kxZ1vfU5QDSR6c4buJMawfIZS+/Y1UmVz/lhh8Vcsg860ZC5fsIZhfdsNF5cY
         iF0SAOjjeFdnE7UjW1mukr63bXq3rYdyOeiA+yYGRuWbCqtbgdkJLhq3FFVhXCNL+2x8
         ixJ7d8NOKYBnDFhMueLibCgHBTZqlDPjepJ8cCcRwEYz22QmZUQGEmfpYuk3rXOeJxFI
         /dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289902; x=1792894702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6h7cwshK4bhZz90I/AWA8AjZrCXIbK39PmBPiXuKICY=;
        b=Kpl1e1eXUhA1hkAhjBtyVp1829W9uFL/rGlJHnZJZ2LQqGApHMmq1XPFwOkH8cLGaX
         JXjAKm75T0SHjETy8V2I4aVN+ORoU4i7DqdgplymKLnftM/69xd62TaGv5XMYp2pJu2s
         qutz+aotoHaqExmlgraBcXWCp/VUg5zx0LzmPWd8tB5t4ZkYcBM4hOZDvVHZFBPRwUnO
         g5ZOeVSFjzoP5MpBpMD10YJmsC5Pf26EiiLZNP56JK7Eoby0R1UMwwZ/7lUOattGS+70
         f5OzbY+YWCVjUPqg427KDK6dfT1X+aHbKPG2PQpj3RQpA9fdxsrw+ymxorq7yGiJ3dzl
         iQ7w==
X-Forwarded-Encrypted: i=1; AKwUvBxUp+cGMJn9KONYASu1oop1vPhgujVc+iIptyO0rxCrFduuOKZaoMGjV2RndJS4Fi8yVAF4/+c=@vger.kernel.org
X-Gm-Message-State: AFq9FYItJ4WL/NLQIsxIaKPUTDfK9Mb7BKSZxNkWkDTUECeIu+cFq8va
	w1cD+Ut1QSOUTnNBmMit8ogFwa0ZKYl6CGpLF/eRz1W3QRicCQMvDAk=
X-Gm-Gg: AYBFou1mc/3sqNBnQ8bJ2L6YLY37dJ4g79ZUmoWtMX8kOwFPgVtdIDNpTUjnyjNldtz
	2qSBxAqLeziuwadJO3Hbwjb/77UvEdPFtSwHSB87CqwYQRFscM2NoZev6Zb9iTYBQlxRwiJ6rd5
	NIBldjdSfb2AAkIB8mexvEVOwhFkry9T+C7qq7BQ+WoKx3Y/8nwo6nue4ZCy/ZdrOqLM4U2vA2L
	deqcRZXl05SPIQTdtDm+dtTTmOF6lnSbh+nkGIA3zig/1Tk2fvJjhFMsWKNMfZDt9EhieaQYxP0
	K7gOyrGQ7z7nyPn0DnkHPFIi+V2/gt69kAz1vDIJUKLSsSWf0gGYYTJ+VAvVoQXAxIxyzFfAf20
	AaDc9XH70lcHZb8em/iNndFqmW2iK7bHS5av8gu03rV7JAGMY494hN4khojewda3kW3ztDgHtoo
	WLutYv0lRY3tiO3C8ZnOdXr20YDQJ5SJH337PfuKRJ/A5+PQ5mt+zU63CGL7DP394Bl4hDWlz8R
	FZyjX3jXIAIs5U0M06lpDfMBOEbFdYl9kLLQqXxkkl92JBMU7ayo+ezSak4KqZY7SmGnDoQS4rf
	o7CviQBAh4ww7cwVPPB0FeBrDd/5
X-Received: by 2002:a05:622b:c8:20b0:535:1683:5a71 with SMTP id d75a77b69052e-53645ff1af1mr42415901cf.38.1792289902347;
        Sat, 17 Oct 2026 19:18:22 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa68f8esm61881881cf.29.2026.10.17.19.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:18:21 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v4] ASoC: wm8962: Stop IRQ from requeuing mic_work on remove
Date: Sat, 17 Oct 2026 22:18:17 -0400
Message-ID: <20261018021817.3859256-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WM8962 IRQ remains registered to the I2C device when an ASoC card is
unbound. wm8962_remove() cancels mic_work, but a MICD or MICSCD interrupt
can queue it again before the component is destroyed. The work then
accesses the component and reports to the old jack.

Mask microphone interrupts and disable detection in wm8962_mic_detect(),
wait for any handler that already read the old mask, and drain mic_work
before changing the jack pointer. When installing a new jack, unmask its
interrupts before enabling detection, preserving the existing hardware
sequence. Call this path from component remove while the component is
still valid, leaving the IRQ registered for FLL, FIFO and thermal events.

Tegra's card remove callback runs after ASoC removes the codec component
and PCM runtimes. Drop its redundant microphone cleanup.

Fixes: 0512615db6db ("ASoC: wm8962: Convert interrupt handler to direct regmap usage")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v4:
- Always disable microphone detection before draining the IRQ and work,
  then unmask microphone interrupts before re-enabling detection for a
  new jack, as requested by Charles Keepax.
- Keep the redundant Tegra card remove callback deletion; Charles
  withdrew his initial objection in the follow-up review.

Changes in v3:
- Mask microphone interrupts, synchronize the IRQ and cancel mic_work
  before replacing the jack pointer in wm8962_mic_detect().
- Use wm8962_mic_detect(component, NULL) from component remove and drop
  the redundant Tegra card remove callback.
- Keep the IRQ registered for the other interrupt sources.

Changes in v2:
- Do not disable the IRQ from wm8962_i2c_remove(); card unbind does not
  unbind the I2C client.
- Keep the devm IRQ on the I2C device for FLL, FIFO and thermal events.

Found by inspection. Compile-tested both modified objects with GCC 15,
W=1, x86_64 and COMPILE_TEST=y. No hardware or runtime testing.

Review: https://lore.kernel.org/r/arY6GbRBjKxJDKVn@opensource.cirrus.com/
Follow-up: https://lore.kernel.org/r/arY%2FVSKn%2Fsq32sr0@opensource.cirrus.com/

 sound/soc/codecs/wm8962.c      |   36 +++++++++++++++++++++---------------
 sound/soc/tegra/tegra_wm8962.c |   13 -------------
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8a9598161b35..253b41fff8ab 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3230,21 +3230,29 @@
 {
 	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
-	int irq_mask, enable;
+	int mic_irq_mask = WM8962_MICD_EINT | WM8962_MICSCD_EINT;
+
+	/*
+	 * Mask microphone events, then drain the IRQ and work before
+	 * changing the jack.
+	 */
+	snd_soc_component_update_bits(component, WM8962_INTERRUPT_STATUS_2_MASK,
+				      mic_irq_mask, mic_irq_mask);
+	snd_soc_component_update_bits(component, WM8962_ADDITIONAL_CONTROL_4,
+				      WM8962_MICDET_ENA, 0);
+	if (wm8962->irq)
+		synchronize_irq(wm8962->irq);
+	cancel_delayed_work_sync(&wm8962->mic_work);
 
 	wm8962->jack = jack;
 	if (jack) {
-		irq_mask = 0;
-		enable = WM8962_MICDET_ENA;
-	} else {
-		irq_mask = WM8962_MICD_EINT | WM8962_MICSCD_EINT;
-		enable = 0;
-	}
-
-	snd_soc_component_update_bits(component, WM8962_INTERRUPT_STATUS_2_MASK,
-			    WM8962_MICD_EINT | WM8962_MICSCD_EINT, irq_mask);
-	snd_soc_component_update_bits(component, WM8962_ADDITIONAL_CONTROL_4,
-			    WM8962_MICDET_ENA, enable);
+		snd_soc_component_update_bits(component,
+					      WM8962_INTERRUPT_STATUS_2_MASK,
+					      mic_irq_mask, 0);
+		snd_soc_component_update_bits(component,
+					      WM8962_ADDITIONAL_CONTROL_4,
+					      WM8962_MICDET_ENA, WM8962_MICDET_ENA);
+	}
 
 	/* Send an initial empty report */
 	snd_soc_jack_report(wm8962->jack, 0,
@@ -3592,9 +3600,7 @@
 
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
@@ -97,18 +97,6 @@
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
@@ -129,7 +117,6 @@
 	.owner = THIS_MODULE,
 	.dai_link = &tegra_wm8962_dai,
 	.num_links = 1,
-	.remove = tegra_wm8962_remove,
 	.fully_routed = true,
 };
 
base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
