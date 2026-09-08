Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623985964F2
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890290; cv=none; b=CEfQjhKDD/xhoTaMWkDzT0irf+cWyKCh1UBo/oxGswCBNjWZYAOEiJwEf2j/nlaYU/XtHZci7VkujpE6hBzk8FwtKOFgH/sJvgXjXXDWgSjrckUERa1RQxka8TngYksxG9tT4//oTaOxvYGU4nNPHMkYcSb8zMMpXm2j6XvkOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890290; c=relaxed/simple;
	bh=VPXs8lvIsA9bvQTJ/c/tqiLS8AygmJoObd8lEynnagU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjoE/UsW6OLcft67JYR9riQDvxUV0ax56+HH8DjamuNBBX0CNisACZgC2WtFs03vuVzMWMBsOBSNvppLJrlP2HDd8ccDmh8/ZYwOjoU+HCA1JBBDqz62ybXM+xO6tosdlXLlMPl1XHS3VPmOOArEf1nwVlHvrNgoJAczM8NrgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1tG/qzr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1tG/qzr"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482dbe4d247so2744830f8f.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788890286; x=1789495086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UX8L/BtZO7H1FbvBOVuWTf8zSaxbJy2FpKxDe96gDGI=;
        b=m1tG/qzr56Q03IrHTz5aKjZ6BMEtXRRwyEQ9gsWOLxNBjkAEW9MHw7t4H4YD5XabMH
         PPOKS5uY7aC9HOBbD9iwJDyF8n/P96alx5pGPJC/TUSGyYyRHQjmtb5BR3xzM1gFDnPu
         4tYoqxCCCbgmtCSE1OK7YnxlFwi9InbvT/qA7ZO65sjCym4QsCboCH7XMb/elkfQOUVd
         QhDydQP35ar5zgxl3J3RbjsL6XaRF4dKWs25TaEigV4KqdpNJY9Ucaqx7ESZDb1Tk/a/
         vN7Lu7SFrhIEhgEidVrxPF+AzYlE0hc3YRRjHfgy81o9/pzLWEXstYWk+vBiJIs9UtQD
         FIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890286; x=1789495086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UX8L/BtZO7H1FbvBOVuWTf8zSaxbJy2FpKxDe96gDGI=;
        b=KZS7CoVqpG2GoQPcwuZjwLT5cYz3VnDgr9DVQTaVriPNPZ/0QkYtIta9C9F9IlPhqA
         EtCwhbDAVeoSi/2S36Yw6h5oPOOnLwttbgtRAqVobNKJu4mBojWJsDh1seqrJkL6e6xg
         seEB/SOZjcpbSW5HYsaejdkcJaN+jO0odnFJjnGjKomcWPOwIc0TzJb8mLUegKR9Ct84
         dVjN6NxX8a1knJPQnz7V9LwMg0ZKoUXQevswKiKHXpkpjK1RxBgJtoyiP4aIgZmcCXTO
         tW5zIhfPifWLYo3U1GPItkNqyP8Ohp7vRPuvP8H9XkkZvQGqUqKNHs6nE1gp7DmVQFMJ
         60Eg==
X-Forwarded-Encrypted: i=1; AKwUvBxfq3lXv1Toc/TbhoXgUX927a+oPCinkYyd0txV+mPc4/AzUW6w7dZEMtVsgcsN7A0N4OFwGas=@vger.kernel.org
X-Gm-Message-State: AFuF++nf3PAH4jiMhV4Syu0GbOSlsHDBEHhtewu13MByiiMns4c+1KoH
	UITccaFAaeIb+MUFeA2T4PhW8LbNP/QT/dTZzo+kXQVMVFnKgtzfO2jI
X-Gm-Gg: AYBFou1VK2Qn49zuyids4w2kwGe5LwlhVrmmWJDBjtzM9IjOLCl5Wmz2122Si3kkTk6
	q7f0b3gOG5QVc0zbbL2rWCuIE0rYwgINykZ+b8LWKkel/7GE8UySJx3OckpdPQmEmMAMO9zAHYx
	g1IOgfy+GTe8YrgAirHG1gUAwp2EbNZPe5OxTS/ZrtajKEHVU2inoq08Y0/4iikwfLFaSMRH7jE
	+sqh9B4oTWUmFrGMD8Rgm3WTtbvsyn3LS2UqzMMwpMqS18lBV3H0XAKNcyRKzSsRnjvbcLKYsTS
	asBu4AgpK/t0qCflEPlpyvKUFmccDhQIy/h58AzcTzH/Xef3PAGogGDAsVowfiPEV+GnAPdUXYz
	52bAido48D7ZnfB3J7aF1rqTMNDWW+bs+oOwkjeUNoDECMuUuttU85kG74Sz5qGPVo2ISP+oa5L
	Xfx1L6qcocr25A49Dnk1+NVhkuGXKLAslHAPNaENFkNMn+xf7X6w1ZdgJ8zS43Ovq0UYvkscfut
	kn6tprOuHB0t6VZv60sdI1MTB8yEWw=
X-Received: by 2002:a05:6000:2c10:b0:485:4275:f207 with SMTP id ffacd0b85a97d-48587099a2dmr57344271f8f.24.1788890286214;
        Tue, 08 Sep 2026 10:58:06 -0700 (PDT)
Received: from dd-home.home ([2a01:cb1c:922:a700:4e5b:d129:8f46:873d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm42561836f8f.25.2026.09.08.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:58:05 -0700 (PDT)
From: Maxime Douailin <maxime.douailin@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	Maxime Douailin <maxime.douailin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: wm8962: Do not clear SYSCLK_ENA owned by DAPM in configure_bclk()
Date: Tue,  8 Sep 2026 19:58:02 +0200
Message-ID: <20260908175802.604262-1-maxime.douailin@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wm8962_configure_bclk() provisionally sets SYSCLK_ENA so that the
read-only DSPCLK_DIV field becomes valid, then clears it again whenever
the bias level is below SND_SOC_BIAS_ON. It never checks whether the bit
was already set.

It can be: the "SYSCLK" DAPM supply widget owns that bit, and
wm8962_mic_detect() force-enables the pin. On boards that call it (the
Tegra machine driver, i.e. Microsoft Surface RT and Surface 2) DAPM sets
SYSCLK_ENA once at card init and, because the widget then never changes
power state, never writes it again. The first stream's transition to
SND_SOC_BIAS_PREPARE runs configure_bclk(), which clears the bit behind
DAPM's back. From then on every stream plays with SYSCLK off: the DACs
do not run, CP_ENA refuses to latch, hp_event() reports "DC servo timed
out", and the codec is silent although every register DAPM believes in
looks right.

Remember whether SYSCLK_ENA was set on entry and only undo our own
provisional enable.

The bug was located with the help of an LLM coding assistant, by diffing
the driver's regmap cache against raw I2C reads of the chip during
playback; the assistant also drafted this patch and the changelog. The
analysis was confirmed, and the fix written and tested, on real hardware.

Verified on a Microsoft Surface 2 (Tegra 4, WM8962 rev F): with the bit
forced on over I2C during a stream the DC servo completes in ~56 ms and
audio is heard; with this patch applied the DC servo completes on every
stream and there is no more "DC servo timed out".

Fixes: 75704ecfbb41 ("ASoC: wm8962: Enable SYSCLK provisonally before fetching generated DSPCLK_DIV")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Maxime Douailin <maxime.douailin@gmail.com>
---
Notes:
 - Found and verified on a Microsoft Surface 2 (Tegra 4); the same silence
   is reported on Microsoft Surface RT, whose machine driver is the same.
   Background and the full register-level analysis (regmap cache vs. raw
   I2C reads during playback):
   https://github.com/grate-driver/linux/issues/141
 - Boards that do not call wm8962_mic_detect() are unaffected: there
   SYSCLK_ENA is never already set below SND_SOC_BIAS_ON, sysclk_was_ena
   is false, and the sequence is bit-identical to the current one.
 - The deeper question is whether tegra_wm8962 should be calling
   wm8962_mic_detect() at all on these boards, but the codec should not be
   clearing a bit DAPM owns regardless, so this fix stands on its own.
 - Tooling, per Documentation/process/generated-content.rst: an LLM coding
   assistant did the register-diff analysis that found the bug and drafted
   this patch and changelog, over an interactive session on the affected
   hardware rather than from a single prompt. Every register claim above
   was checked against the chip over I2C, and the fix was built and
   listened to on the machine before sending. I understand the change and
   stand behind it.

 sound/soc/codecs/wm8962.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index af471605122..c314af2c860 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2472,6 +2472,8 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 	int clocking2 = 0;
 	int clocking4 = 0;
 	int aif2 = 0;
+	int sysclk;
+	bool sysclk_was_ena;
 
 	if (!wm8962->sysclk_rate) {
 		dev_dbg(component->dev, "No SYSCLK configured\n");
@@ -2504,8 +2506,19 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 	/* DSPCLK_DIV can be only generated correctly after enabling SYSCLK.
 	 * So we here provisionally enable it and then disable it afterward
 	 * if current bias_level hasn't reached SND_SOC_BIAS_ON.
+	 *
+	 * SYSCLK_ENA is owned by the "SYSCLK" DAPM supply widget, which may
+	 * already have it set even below SND_SOC_BIAS_ON: wm8962_mic_detect()
+	 * force-enables that pin, so on boards using it (the Tegra machine
+	 * driver) the bit is set once at card init and DAPM never writes it
+	 * again. If we unconditionally clear it here, SYSCLK stays off for
+	 * every stream, DAPM still believes it is on, and the codec is
+	 * silent with "DC servo timed out" errors. Only undo what we did.
 	 */
-	if (snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)
+	sysclk = snd_soc_component_read(component, WM8962_CLOCKING2);
+	sysclk_was_ena = sysclk >= 0 && (sysclk & WM8962_SYSCLK_ENA);
+	if (!sysclk_was_ena &&
+	    snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)
 		snd_soc_component_update_bits(component, WM8962_CLOCKING2,
 				WM8962_SYSCLK_ENA_MASK, WM8962_SYSCLK_ENA);
 
@@ -2519,7 +2532,8 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 	usleep_range(500, 1000);
 	dspclk = snd_soc_component_read(component, WM8962_CLOCKING1);
 
-	if (snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)
+	if (!sysclk_was_ena &&
+	    snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_ON)
 		snd_soc_component_update_bits(component, WM8962_CLOCKING2,
 				WM8962_SYSCLK_ENA_MASK, 0);
 

base-commit: 0e2bf66c2f6326c0626c9db22530954ef5c64b08
-- 
2.53.0

