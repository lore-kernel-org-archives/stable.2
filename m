Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379866;
	b=u1hfm5IXA+/tEAJyMia2huVy5ZVEQFqkDNSTxO8hGOPFxKEnQDB07a2nXNE4NJE2uvZL
	 eJtRiQAvTw/kBfYiJCByxa6NJ2zLk1tgFX3zzDo0iemIZTpmtxF8eJwDSXE2qO7NKv0eA
	 h7gbgtFqxVUJc7S/xB0PyvVa1yUr/OCGkdG02SOJ4RLgzYIow6TiPxGqpnHxULJqkIZe4
	 R/X5CocxRPD7BKMORcRXbCPlN6i2tNGbjPckksjUbiKdj0uJr/1ni96S1pj8zm1R4I+XD
	 sJX4HiB1uh9isRAJpWrBj5CMNXhOv9Qo2o5A12Nb/cqAUQ2Uja1WnK3NoupKVEVGbdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FH4Kqn8dco80ci61ZbweWMHJrINyff7bOB9z+yUQ3m0=;
	b=o6ZbVek7i0AwescXWYn/SnjIYmWYHGxlmHtrLA7ZhLZbYUS95Lxdui/Cy5UX+xxOhwb2
	 B6yykTh4b+QoBvC6Ckg3UBCvJ8o3PEH7XAO6I1loqerRRGiZOT85ARBDj5B/kn3NRWJPI
	 ViXMLw/TMRlE9L/q2nk78doXjEsQDewzEx3h+6SexDqJ/DYu2jNdV60Rh2HAMB56ioVPL
	 HvyBUMVrkcdm6uOaE/bc6w3VosLxqW/CjHHkoOPFMjKYTf5yvug96phlw8Zk0v5JsKN/G
	 Hx9ouYhuCYrFIR8DT5qOIWea4zs4sYaCoiQ64uhE1aKbPnzS1XsQZzFe7EHRiJAJtqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=crXTYElq;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1942606A323
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1942606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=crXTYElq
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a210470b49so7651675e9.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379864; x=1793984664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FH4Kqn8dco80ci61ZbweWMHJrINyff7bOB9z+yUQ3m0=;
        b=crXTYElqzOFutlD5BcyY2lnNO9wdIZ6XXNhpB4TGlVAdNu46eNUwo3ezNNXBgwM5mi
         GCjY5dDh1qFWw9TO3YbcvvhL5dTN6IWjTyum6j3D+YFNfpIjNAM/CbxkNykvw5VZbU66
         6kro0i1TFLRlnO+j0sWzd8oWL1AhJoqEZD+t5XuYbcF7p6ewnLc3PoxCZs5RDtnBW+8N
         YjZLHgkYghjotDUu3e2f8mqkJ5hCj9WPUzdmtrCC2H8vvpWRnvf7cvCJPoaCWCblnxuu
         EneyyjB2+empeLFdHl8601ANA8AvT4cIsJvU9FQW4S1qxKpmv9gNlOkf4wQneZZwjZOF
         GDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379864; x=1793984664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FH4Kqn8dco80ci61ZbweWMHJrINyff7bOB9z+yUQ3m0=;
        b=EzeTdpGO1gfFxJ2Y26K0PPFTCt5vCaqrVGOXElbhpfJHj6RRFA0Mj5Tzz4ra7oybpP
         CEjrMD1ppn3suPoMx+aKaFrH4xIBfp9IugOx6KUht30VhgtvuDbChyOlBfk+0IQWhf1X
         Bifu2/mPJ85+mQNmzgQlMBahFo/mB87kz3b57Lo/94u6qx5nQCUHyARXYB94G/b0nZJA
         hkFlmWJrZdpnY9hhOIrb/rDmh0qoHnPgfmHUrdGDGctGQHZ+bH9S0glyG55y7v+UU45B
         FFxOzoQD75Q5S2KYBxH/QKTzT3iCRo9sCAAwqVx+C4JvYpJvunQzCX9d43msInzkiEJs
         vWXg==
X-Forwarded-Encrypted: i=1; AKwUvBxT5xq4uqoKOoE4vb4JZ412ypGjE0s1tpBpucHKWL6Hx1iUAzZAHg5c1fqRwtAnSlVVJehcXOk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3B6Yo+trTZkFKZzbXfWbbltjMfqbl34vP/zgqaknqDDWVn130
	wglfpASMbblyjKVy7EdF4ZIDH523iPyGuf4urQUyemS495TrTKpfpF0=
X-Gm-Gg: AYBFou160gYwCzAm+A0GOIZDYqMO/qG1s5OMRgB6JoMSVL3+TPE1+ji0VgjMkcIyWTv
	uT//vr1UZ+4PHyKAcjI4Iz/vX32aVx3rVw5HdLGitZ+9Wtu4Gg7A58W7c9dfkus9rYm4qevH4ST
	NxLHtXgeqHj+KwW6bnN6gQFwAzsoDv+VR50kXgc4NIuRfLJadW8lLHTBaBoeVI0E1XdqwzYjR7A
	0YCq+ilxVMABeVbbhyYJRFev8XB0VazssBVfFai3ZI3+GYhvEWFpZ5CNgBWwh2tYuKtctUIIGa6
	X2jkR1O0aj87WITGuDq/Dd304oHcdpKYkk7dLHp7cJxyAeYmtAj1ied9il7wB/1yV/FFk0C0hrP
	zT9owrK78ob2ztZ7hMoQSdWLmoe7fRkA03dPPpkNGKSYsEyD2G05asF2FOvMtzQweYPRbFYEJyT
	NhIQ4/QN07+Sxq+iUIFB1XaQ+AgUjD5wnipkD6gsQILZFYOrPKEpFa3DVGQluA5gNOIHIsOvKJi
	YJldkzvfUhWMqTkwf3KwutvJWMcswWUhXhQMvq8j5wcsxBu/XKJasczswiMjOD+804pWBu/0wFQ
	zl+3to+GF/Y=
X-Received: by 2002:a05:600c:1f93:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4ac180f299emr65008855e9.14.1793379864002;
        Fri, 30 Oct 2026 10:04:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf7146621sm75121785e9.13.2026.10.30.10.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:04:21 -0700 (PDT)
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
Subject: [PATCH v4 2/4] ASoC: rt5659: cancel jack_detect_work on component removal
Date: Fri, 30 Oct 2026 17:04:14 +0000
Message-ID: <20261030170416.3561618-3-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030170416.3561618-1-tristan@talencesecurity.com>
References: <20261030170416.3561618-1-tristan@talencesecurity.com>
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

