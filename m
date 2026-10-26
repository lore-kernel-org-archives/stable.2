Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013738;
	b=qV/H3A7076QlW/ZwE2aLd5i+TenwNfgz1IuwcWa0Y8P0o77T+xLQkPTre5PhQ660eNsu
	 vUXgX9qV/yfwn6WIMH8dm7DrP+5Wfp96hpPqS8Ly0mhlSY3teXwMz/rf1xKKfQ7VnxT+2
	 rA4UVWLC0mH+4/sKAhmFsgr4Q0zTBLQ5WxNvNkyj0J7cdSgsbV5CveXHI+IKB3Qd+7qmU
	 4BA3zbWYV/TLu3M4QDwH74FktWCY9IWb1TVnPwQXIX1LzA2+caYw8Uz0Blb5JwdQ/s3QE
	 rK1zQPnnoBCn/61HJ1VlhT8Z93UqvnA8VlHq6z0j2XQNq8zeRdhmX+Z0v7aGWMIwDxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Zze3WV/bZ/nENgJuAp4NPKKGDAirXyPeBw8bCP7Z3UE=;
	b=R1GY/Azs6mjyodHbbE90AUAh2EEG1GmeUIMwSAkH+vSgzcPmT5D28ODTDHE1tcx0vE06
	 6duMmE+6tF6tt77dTUmIKX40/9KBj3sSt3JnFz3X6C2p54/P9VBw/plg5Xayw8QXpXiNu
	 EolPhfTW1oXittloagRX1VkeznqIgIAYsEkn8HwiKOKELm/4gwh/4TDK8CNDQFHo7fdI0
	 Y9alOYsqYNn+F8UCrKj+6JXUuDYzbwZHvkLdDaDh5HEt/6UBv8NIVe6vD4+jp+n678zK9
	 79R+LGfuyTbruXJvzqc31WyDJb0F7pw/n0DfpDVxPijAKIkszoM0JNVcD0A00W6Cm2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dYWGpYgZ;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314460A263B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5314460A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dYWGpYgZ
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so17307035e9.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013737; x=1793618537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zze3WV/bZ/nENgJuAp4NPKKGDAirXyPeBw8bCP7Z3UE=;
        b=dYWGpYgZ7PegEG+nlFt7hw0dkDWlcodfSSqXH4LU5zKZ1ZPaVnrEaGx1XTK0S2nRlU
         99LvYfPrZeTUclCYRWA8QSojLv7qK8CQoXoA5Y+WDAopm483+E3CSLWgqpix25cd5ShH
         oQ86PHdh2JQB1arIeR1qTCcPteE2gJhi9UF4dirQIsfp9RlmoHGy0bVHG2EfPtTzKm5L
         p9Sbn6uLdTIZduVVcLeRJyl4q51Dd0iAW+XhesBMsXIIVIhG8sC08U6wIAW+NSQNrI2F
         FsfccwDmkleNwrYDihiP6jyqrwXHsG1QeW4qAZLn1E7YLrLE6EGb3isRVcGq6afZWUj6
         YBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013737; x=1793618537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zze3WV/bZ/nENgJuAp4NPKKGDAirXyPeBw8bCP7Z3UE=;
        b=alVS9a1tgj6YkjXiKLNziG3ApnU4w4rOAB/iuJHbBRpT/NzWSls90jTRnZ8lHbB9xh
         18Bl23kDk8hwtam95iScEPfP196Orkl7QaqoKAORaelfNkUXrBCMWaijfKGtSvXLAGM2
         RtJWYbpzZh2PHpw4oV0PBh360FQRvGBQa94unM31DLdoQikiqJVKs5f6HyP+GnoSvd+2
         INz8+6e3QZxh/kIfdGKBbx8uVQTHT6FzSgpE9+h1HRw0zLZzK4GGngYm9/0mtpqRnC6h
         C0O7KZvvf6QFl74ILx9Zo9XSm/5JkwWByG75TrXSiPrSkbDfWxHH6p6vGWoQhQQF8yJ6
         DQaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxn1xAcVTkE/qgUwFKremtCrQHPnZF5TsPu4TsLdYL8ZDI/M5bQWTkfUm3TUJk8li/NdNmpWOY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs/cf80wwqS80P+NK2Vx4JXRBHs9x0r6umzDuUp1c6t+714KPi
	8Hdn2wI4Ie2ILtVGtJtOUhyK65TNG8YBO+dgNp3i8wJB1VCAL6pspKI=
X-Gm-Gg: AYBFou0/vCWAC+Mnu+zQBwLhb1IUiktWab7LA8pAoDOO0E6DjCwT7TypWie6DSSjTlI
	ScrWDKp5I/i64Sk4IrwblgSf52xOfohYEUWtccP7y7WaDf+YI66PSu8zVDBJz6xQM9Mb5+RFQKa
	aB+N/UF9kOoO/w/hkwHxcXKYHYQQT5bDf4FI0WWfBep1xcys0wnGGryFdbj4vzoAvzW0YZT7stu
	OX8cMNI+pZtpCUzOBfv6hhqZfm09iIHBVE8I3MyHM8qhuvcCVVANM8xIvc5w76J2pPidefXIQqh
	Mvk8OzoBXlhTmYKmrn5dxGtkrL76WMyKLbC/joc83RWijUpvBKevloEK67qRbK8vpTrRFsHYLbI
	N/W8zFItJRODbizruPZG0K9o6S0iRwTfbuL/6lYdAbZKxYuqGdM9hX6LO69LSi8G4kWRwTrBDL/
	Nqx+mzNppZ0I35AVSutj/LXoi7BH9gkAAgHTrhlBBoLjlJpfbwDr2X82oo/84TORRIYL517RzeF
	5FyLw04rukOVH75FhqaSO5IZg==
X-Received: by 2002:a05:600c:3e1a:b0:4a2:526b:d3fd with SMTP id 5b1f17b1804b1-4a35aca72b1mr122086875e9.15.1793013736741;
        Mon, 26 Oct 2026 04:22:16 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f59750sm129141265e9.0.2026.10.26.04.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:22:16 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Bard Liao <bardliao@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Jorge Eduardo Candelaria <jorge.candelaria@ti.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 2/4] ASoC: rt5659: cancel jack_detect_work on component remove
Date: Mon, 26 Oct 2026 11:22:10 +0000
Message-ID: <20261026112212.2519775-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026112212.2519775-1-tristmd@gmail.com>
References: <20261026112212.2519775-1-tristmd@gmail.com>
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

rt5659_remove() resets the codec via regmap_write() but does not cancel
the pending jack_detect_work. Since the IRQ is registered with
devm_request_threaded_irq(), it remains active until after the component
remove callback returns.  The IRQ handler (rt5659_irq) schedules
jack_detect_work, so a late interrupt can queue work that runs against a
reset codec.

Track successful IRQ acquisition with a flag so that disable_irq()
only quiesces a line this driver actually owns.  On component remove,
disable the IRQ to synchronize with any running handler and prevent
new enqueues, then drain the residual jack_detect_work synchronously
before resetting the hardware.  On the next component probe (card
rebind), re-enable the IRQ to restore jack detection.

Fixes: d3cb2de2479b ("ASoC: rt5659: add rt5659 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/rt5659.c | 17 ++++++++++++++++-
 sound/soc/codecs/rt5659.h |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 3097ee6d4e89f..340d3e7be7a40 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3664,6 +3664,12 @@ static int rt5659_probe(struct snd_soc_component *component)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
 	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
+
+	if (rt5659->irq_disabled) {
+		enable_irq(i2c->irq);
+		rt5659->irq_disabled = false;
+	}
 
 	rt5659->component = component;
 
@@ -3684,7 +3690,14 @@ static int rt5659_probe(struct snd_soc_component *component)
 static void rt5659_remove(struct snd_soc_component *component)
 {
 	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
+
+	if (rt5659->irq_acquired) {
+		disable_irq(i2c->irq);
+		rt5659->irq_disabled = true;
+	}
 
+	cancel_delayed_work_sync(&rt5659->jack_detect_work);
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
 }
 
@@ -4290,7 +4303,9 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
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
index b49fd8baf4e7e..4df7d7dd99e16 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1813,6 +1813,8 @@ struct rt5659_priv {
 	int jack_type;
 	bool hda_hp_plugged;
 	bool hda_mic_plugged;
+	bool irq_acquired;
+	bool irq_disabled;
 };
 
 int rt5659_set_jack_detect(struct snd_soc_component *component,
-- 
2.47.3

