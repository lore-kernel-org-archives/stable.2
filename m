Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374928;
	b=VCJMHg99zvnw3vhoT3TOAi5MhH2oOwq1To9yxW7Yy4XdP7ZoPweX7jL6NA+L9uM7x0zs
	 M3J2RLF64NLaYMvOnvcj3QyWOkBaQnzEQETjMZB4eSgZxdFSopn0zuYZI3xOwdlt17H2n
	 pb7GDrH4GByeylF2hNpRY5Ef4lBWKH1SV1QEYfZG9pFDKjbSwbylRgH1OXYXrj2/8cnVH
	 s7lvAwFsDaVWAf8zPPZ7juQHPjiRuhObX+Fu9xyyROST6A0o0qrfmJLamJEN96ERGpzgj
	 eoyE3miufC4sjYPsXRMFDT2cYKAWVMkIjdXfstQcuRdVUuu/qHZEdFEk2ouvXX+GtSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=71/PhvdcY4MYCOZ7yipaT8Gh3d0QBNm/V3YoucupFGg=;
	b=zFCjRWbwBbNI2RTLUraCeKTPscXEZG3H8ETV54rcenxOQ+rVBXr/Dp6dG7zaAVQvnNIR
	 XpFhxqUDkuAR2YPER4s63Oyzk7L4BYVG2d+5dIFUvMCOeYJALRt2K8hwir/p+sutJL0X2
	 22dcmZjWyq8y6tmiyDn1EDuoxw1Esab3kiyaiqzqc1uSfp+R0ZZgFLhU0L251bAEU/p9b
	 ZIt4e+INGmiEAvpTwR2cFuebCzsyYaPMHswgvSXfGUStT77bJcEsE27kyRMD9ZLUr6RpS
	 A0ghkZY9uXSNBmd2YW1MzSkp2Vz2dq1eUSxiDuFY+E/Ej9H22+mM74rC0gQYR+LQbyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOxhZfYm;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0CC606A31F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F0CC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOxhZfYm
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso6036735e9.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374927; x=1793979727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=71/PhvdcY4MYCOZ7yipaT8Gh3d0QBNm/V3YoucupFGg=;
        b=nOxhZfYmYfLK7lY03jY8+VzT7+a+mWQI/c4bBH+huJ9hU28sG/lMQ/D+KInfS1eumE
         rMiqtzYyngcNNxsBP2rz5Oi7CGUrLbxN9MfqASpLJ3sMqXSYPVqw5vkQvpDHbDdGSVlv
         E7tOlk5PEaR7BUgm9xSrljvtf2Varg/lwiVHnfUa80yxt3DNfhu0k9MY4SMM14JHt8t2
         sxmCi3J/F4MOU4Zq/aBj2njG7iSRLq478Q7Y52roB95kRYVSLeOKfbz6pweIAmk5aviB
         rljFAvbPFaHV8Yu4dh04Pvkt4YrYvnD2rSs3pj8BFHOVFTxzsdekcMOI2F/2O3UAlJPF
         HOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374927; x=1793979727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=71/PhvdcY4MYCOZ7yipaT8Gh3d0QBNm/V3YoucupFGg=;
        b=k6VRH3iF6LQBej4LTtoI1u8hqqpDl20oo2i2BdXwZG8ydZ3ZToJZuZjwdFNPyxDTZ+
         5ftHqc7h5sPGCeEr13SlJcRtbZ5zJSE5vcTLlsrdDj3qbJksStCFH5adR8rslANrvrmZ
         LlxKlQTuC/5z2V/tqRK68A07yVcK7y4b9A+DkWBw792UDjVUhgdVNg5sfajkSqvMd/Qx
         QZ4UMV7udusZ3lKcD+ntAfPqj2QJftqs9LVJ7gJJzN7kcYcG2madS61Qj0KgSoysgTJ+
         2g2duP26GiXL+yVghmJ/vljRy94WL04ixSpxtbT1vqqeo7MtgE+8LQcMfP1WaGaUgmxv
         FfXw==
X-Forwarded-Encrypted: i=1; AKwUvBzpnyX7xDqOkBojCz3qvbsznXS8ecacu7haBnJYhakIHBjb6+zneK3yrrhlHkQqWEvs7p1qAAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0wyDMz1YmnWeq6GMCzx8oQZsHyXF2nCYxnVzkw9xFvCfEtYzF
	+1FW2SFbLm133htQr/VrGzyjNj3Y6noT6L0PMZC4UqmdwNq3gxYRRc6vD7/C
X-Gm-Gg: AYBFou2DW/AMGUAF0kutu+Q4Z5ZKHe6HhsmWbPPk1w3RnNB7oYGN9q650hFAUJrVsKc
	DYRKmk7cWModWOP7J92/TqFFuyIQ2Hn+8BJVYXbM3sn8TPGqBlFOKq8+pVnD2mWLZeqqJugauEH
	l5J8s9FYHbwV1xATti2J+fckbm6wJoMJXqDJtIyNIQNUjB7DAjqHguOo2aFnN10Wuxm/CduQblv
	neMEdIK/YBbhEtQlJsC+LDxtBeuL6Pg1gjV36L8sp3gYCjYDI65BVkYl/KCyHTRBLUlKZok8gNr
	3LZ5k/O4WOfPE2KQRCzks70wd+iutUi1k5VbREtB8/bwXekx3/exTcz8c0RUJFyJe67yhg9EgHz
	/fGX3/tLe9AfG99Ju1AUyFqnD3Sf0eFPVt1reV4sDM4e1/fjqQlRI/bsC9wih8H0/97z+va8ytx
	8QSX1SM38TRu+ibTo1CKExwdxIvREZQf7MnGfNlzyFd29hs668Lffg3GtCEXOfGz2txd9nek0n0
	irvOnLIGXzbr0j0iVqLxOoHSO6hFMsN2+PlCP43ced3nauwXpxlUw9KXrGq7fANmW8IbvkmjcY3
	RESbla2aViw=
X-Received: by 2002:a05:600c:3547:b0:4a5:cfc:1e95 with SMTP id 5b1f17b1804b1-4ac182dbb5emr58789785e9.33.1793374926469;
        Fri, 30 Oct 2026 08:42:06 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f047bfsm144419935e9.3.2026.10.30.08.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:42:05 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/4] ASoC: rt5659: cancel jack_detect_work on component removal
Date: Fri, 30 Oct 2026 15:42:00 +0000
Message-ID: <20261030154202.2989936-3-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030154202.2989936-1-tristan@talencesecurity.com>
References: <20261030154202.2989936-1-tristan@talencesecurity.com>
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

Changes in v3:
  - No code change from v2

Changes in v2:
  - Resend as part of unified series
  - Guard cancel with jack_detect_work_inited flag per Mark Brown
  - Track IRQ acquisition for disable_irq/enable_irq
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

