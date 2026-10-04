Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87133E37A
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 04:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791088497; cv=none; b=K+krd0B21Hm94Edo9XIc1nmGnrCvUqbdL4Flx7sI5hcuMDcg1mhCt46s6dgE+Y3TKsrFOmNwFoHk/bVoEsYDfjTr6Olmqm/fwlamCccVhaDhddYOUH4C7Wr29p/3MwqA1ArFLfdRKLYSiG/D4lKc7Y/RAEm11NlDwqIf0mbOZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791088497; c=relaxed/simple;
	bh=Vmps6vY9NLS9tyiubMVQem9SCekTglBk1P9mmvjIZiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSBtawZErW9MLKszP+iFZ34laaR1Ouulu0kx1eEbnSq4S1V0w0aw1tbcBe7qYssTrtkVza8bpYTVIuuWRDwAQ386TCztMYgBitLcedtgzrPgLhok85rlf3GczgiP0dnui60xtIwQRkmsyphGHXm/D+bTcRaBrWDQMtg+aGOOfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On1xZvLo; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On1xZvLo"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93caa7d3af4so82216485a.2
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791088494; x=1791693294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLz4nHVaS7y0EmUWAv+zVMASjUD+Cyg6g4C6h0mdgTk=;
        b=On1xZvLo1JWOkk28nNcPnubT0+E4OgI1QpeUlJvfmln2c/Er17uZ+lsDYY5gd4ZE4f
         8eHQFq/I8jPtngi1KIncR6ZxyqayVKs380IniJYYNR/wVtvatmklrtpXL2QiyapKCv/n
         UCGUTltDppv+0Zb5Ejaxh3dVKeVP/rZZtp68eRtHJ6blhHu1zCTLlXES3sAA2jDOKogk
         fTt7bsQnwuAx68xNj/pND9As9QR7wso36B0AboOvjtmZQVRzldECx3/+PyeI4RWA6hwT
         cbK0wUib3WnRnxM81sY3yN3gC/+z5g9aou3yfM+cRCkinmQShSPvw5cGqco2qnPBfpHT
         54PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791088494; x=1791693294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLz4nHVaS7y0EmUWAv+zVMASjUD+Cyg6g4C6h0mdgTk=;
        b=mflSh6Tif7rDGqeZueq6nyc8/upC7/8oVnbvmIbJNY7IKjhHDfa5NRlrMvx0f6pueb
         KJBCXDTMaFPrJlDKRirow0zB5Th0m/Cm48hfLVYJFWuLWg1Y7lPzM4P/K+6J/LicleGi
         +77hbOmq3BU4jScsyNqBi/TTuRcF3GttnK/KpbVcsn/XN0aUjlZtJMHGrloeQ96qi0tC
         f3s0RVonFDX7M2BGMQwawearpHOcTRTpttqXXAzBXz2PF/klfJaIfCK4iYJU2ogZkMNJ
         7djns8rq6HaQ/qzl8vJ6XzjRwAYhixCXxut8ANUcHv7Y6yTWwB231jvOukXIR0q6m3Cj
         JzUg==
X-Forwarded-Encrypted: i=1; AKwUvBw66k+X8DIRKNiKuZLM2DjqIP3nH8oDzu+EUVnGEIg58rwSsJUITN0nq/AIh2DkO2U2GXEwwcE=@vger.kernel.org
X-Gm-Message-State: AFuF++neDLyZAx9kknYiN3UBRaCJXewUGx78osy8FNbplkxlUtLmrLJB
	+HgfySAdPJEUALe4c3NwjgtjRBzeSKz0Hu8U1ADzzqdCF0IWgcwGVuo=
X-Gm-Gg: AYBFou1DsVy0CNRAT2s705u0wfTuTeCNmFxPtBwdU1nCapVZnE1NdhZzBJAuNjetfw8
	sxDfDgYo1KaWcw6tDzdU+po2mBYNTNMTZz6oFDnD88BRoALJFh8gFFxq1JFuZbMht58j0OZesUV
	LJ7E5SbmrE/eirVBF0Tsnspn57OyP/HIBmwK17tWu5DHwp7rYyP5PIUJSzOJBuVEld2LOVRcd9+
	/UJ4aiym4ovBk7e/lb1DTAmj+FTPfPO6rMPBZ8QG0mScUI5Vp8wlIa8q16GQltDSg24a/GEj04h
	jLm2rX5rmsS5FCu1wQOysPaZ8Hi/HPyK3r+LaVdJt1y/327C7G4rIjFL3RVnC4HaykIVA50Kckp
	iQcRhZGyAagYjyVwN2ee7Y8XQ/2pWkNBXfABMm857AeZf6ATURwuFFm/cYPu9Gti4x6iPBc6jql
	dJ4sTkbb8Oc56m/xH42P19YubZp1nKxQO+9IECzFZm22ABvjSOZe/KhXH4zjDWl93c6K0WarJR6
	C8UKruoOUnbxhHV+Wc1tmihtAFARow7GJOomGjbA90vwm3cV+9/2cmKk+fJXgStIW8og3yCLazz
	VUt5NvJ/ukgwvfJ5O+RTfB0M5ZUN
X-Received: by 2002:a05:620a:4113:b0:93c:80d8:57ec with SMTP id af79cd13be357-93cf1a611b4mr1231450885a.64.1791088494588;
        Sat, 03 Oct 2026 21:34:54 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca21d8fcsm596671585a.26.2026.10.03.21.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:34:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] ASoC: stm: stm32_i2s: request IRQ after regmap initialization
Date: Sun,  4 Oct 2026 00:34:51 -0400
Message-ID: <20261004043451.1138613-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISR accesses the managed regmap, but probe requests the IRQ before
creating it. An early interrupt can reach an uninitialized regmap.
Reverse-order cleanup can free the regmap while the IRQ remains active.

Request the IRQ after regmap initialization so probe unwind and
removal free and synchronize it before releasing the regmap.

The teardown ordering issue was found by static analysis.

Fixes: e4e6ec7b127c ("ASoC: stm32: Add I2S driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 sound/soc/stm/stm32_i2s.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 83b51893b37c..7fcf23bd0aff 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1185,7 +1185,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	struct reset_control *rst;
 	struct resource *res;
-	int irq, ret;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -1231,16 +1231,6 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 			return ret;
 	}
 
-	/* Get irqs */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
-			       dev_name(&pdev->dev), i2s);
-	if (ret)
-		return ret;
-
 	/* Reset */
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rst))
@@ -1265,7 +1255,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 {
 	struct stm32_i2s_data *i2s;
 	u32 val;
-	int ret;
+	int irq, ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1291,6 +1281,15 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->regmap),
 				     "Regmap init error\n");
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
+			       dev_name(&pdev->dev), i2s);
+	if (ret)
+		return ret;
+
 	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
 	if (ret)
 		return ret;
