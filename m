Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638429;
	b=Hq0QJ4tepTzisVbEip61sbuDtBNaD+21GLvEnB2v7OnRRVr7nN9ZoqUEx0OIl615oVL7
	 /q5fXB/K8VgX8cSAMGqTGDJnzcLIA8+IFNLIAwyeB7CaTvYDtyIN7eACSmIqCNkePnKK2
	 CGn4i5otXSTxfz1o/dkJuc0Px/QqFsrh9rqCron+eOD35YQ9QfIP0/I613/ibtFx6C90B
	 WkIKoiUnssoJCdCNlTgpFfrjjowKt6KzwGPTPuwgmM4cQSS4kXFz5KYbi2ilSbPOe81uu
	 7mboX0oZrzveuCZhevm8VCTuFphR2YxOPfrdtAZEuM1a6qGaW5ltT50FUJs2xZwBsrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EZDrRuQAiBl+0xBpIr74aEBgz8ZqoT3E1SlQYBO5nWw=;
	b=vaonRS+VKnRxj4CrNo5bybFFJiNiRkq0lbMGmbSRhiOg21H0gfuCge0tPrDH1OhJIDU6
	 SUuLZGVorj7WI8UZpoQFZEdFFw/VpDwvVwUw1WPQLfzXYjtTGsgyW6SkigXYAp7exJd9D
	 YOJcjYZPp1hzUC2Lr9RHLUxnxkiXEO8XnjQvekoG6KSj60mrQ03SfchBDM4+7+tSdiqgW
	 xlfPJQmyUE6dZsIYoyJoa5OcMew/ygco+v2SWrh8SuECTiP5VgnLftxJKFQyxDhCxcF7B
	 YfyZtFEoIbonN4kZ3RXME+Wsk50a+pzsshi11Yoa7kcSj/AMu0hrzlt8tNcqxwqGofg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vKMIkw1i;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B739606A586
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B739606A586
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vKMIkw1i
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1564118f8f.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638427; x=1794243227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZDrRuQAiBl+0xBpIr74aEBgz8ZqoT3E1SlQYBO5nWw=;
        b=vKMIkw1iqSMJK/cBwek1vfZ/ITnN6S0fylaZjWFbrE0M1vNq5QwgV6ZSOmME6H7JQG
         jp69OZLbTe7D3qmIlP4Q2acbUGUkK+YCFqoslNRxnkbPH3mfuXU/TvJIIpkjO15sLXEM
         S9LwFYcHybz2eXXsFAjB3ymLuCS+efsqIkX+n8zm0tkNuQljKBEihAwM42Snog78uFjj
         2BCFEXYqtE0Oe/PtDzjtELlAfdAZotCuEAS0WrPAvyWXyxf4Caj2BIoNGAlWMxyuNEWh
         FoglrIetER88ZHsOsF+fJwXzAPg++usAqqIbn8J1vD2Umu9mRTKN4ohg+9XtNVbCs0Gl
         iOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638427; x=1794243227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZDrRuQAiBl+0xBpIr74aEBgz8ZqoT3E1SlQYBO5nWw=;
        b=a/2u/Uy6D+2V4ZOeeJk1if+iguFBf0mHvu/uw8pawBbpyZi6bQxCkh9gfMCTGuzZoy
         +//AF4mCAx7S1ZwFH/B7DcM4bLKlafdfXAt+xtOCYN4/5BAGy6YQNKHQm+/OBsf8IWLz
         jqq6vFpwOaq8DYSZ1D6GZXFnvhjoJRsttOu0aek/Qz2zdlrnRQc1GSTs1GGKiaH1IrCT
         DWyyET8xTerKZ0L9rZSokI6oSD1pyYPkES/zgwf0Xw1xpXTxLyjwvUYabeuDVxMPKYtt
         Rfh8DcN549gsTEMFOAcY4j2vNNA3B6TjiOaCQbFHt184idjP5ynXwL+E2rk9u/GimY02
         YDRQ==
X-Forwarded-Encrypted: i=1; AKwUvByI9AeTlKnrkx8wb1Aefp7T7j3IFyn17MpHDttKtLAUrekwlNjUPw++nU6FfIsXENYsXqZBpEg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7dEZlQXBKVbrl14NMt2ydrON03WC8XriFCFUyBuAA23Hhuk2X
	r2p2rC8va6g3CY7RkyrjzVKpdjeJfV4iNweoAegpS9RNOUGYJjPAxrA=
X-Gm-Gg: AYBFou0AD6RFhiiuppuBQqpI0g00JCLeVV9y//OkG4GOgzotnZyk7Eqc50PbQo3t3zs
	myMF1PiSXBdxtZuQodTkTgMPQLtFoB4NQEKckUfMPzldlkl5LFEw077BLogzJGAgt1RSdcouISI
	1Ws2DfFcNcsD8Y9AisbxTSC2tz4slXRXNZJqT50bcRb/sCV9ZEoHPLAtuJXqURhj4DHbGIylcBL
	plNqRLS6AqLzQOFVWhSfYo2P/ik5DOAt7JZTvBkZqhEir3eFOAoL77/YJk7X3UvxW2WKs1Jq8LG
	g/I9aW7DvgBfecSntiIUMJ7dEDXtV27JNqRpe6xM8b3q4BS95+Z2YBElD4fGp5TQl9nHvcQ8xF4
	fjw6Ijz9oqlOIDMPst6qwa5UI17J8NpGWuXdT3RDklvWYyzJYSbOVmQZEv3ene7G+vqmSgZ+/lL
	OJZ6ySRTttDfmL/LRe1k3IfndGcmZJUaxysVIlVpRhbmJGPSdJfmaMaherzQNJLpmQerc9gSuMw
	DGQtBJ8/IA6q4jttvCEM6tJBBNmiP4L/oH8WBZ55MHPkNsjY/8fh1FGL5M65nW9rY2KVL/wBg==
X-Received: by 2002:a05:6000:250a:b0:48a:f073:336b with SMTP id ffacd0b85a97d-48e6e2fcd88mr23121063f8f.23.1793638427498;
        Mon, 02 Nov 2026 08:53:47 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm21479385f8f.40.2026.11.02.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:53:46 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Bard Liao <bardliao@realtek.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jorge Eduardo Candelaria <jorge.candelaria@ti.com>,
	Margarita Olaya Cabrera <magi.olaya@ti.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v6 1/4] ASoC: rt5668: cancel delayed works on component removal
Date: Mon,  2 Nov 2026 16:53:37 +0000
Message-ID: <20261102165340.1558853-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102165340.1558853-1-tristmd@gmail.com>
References: <20261102165340.1558853-1-tristmd@gmail.com>
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

rt5668_remove() does not disable the IRQ or cancel the pending
jack_detect_work and jd_check_work delayed works.  If the component is
unbound while work is pending, the handlers access freed memory.

Track IRQ acquisition in rt5668_i2c_probe() via an irq_acquired flag.
In rt5668_remove(), disable the IRQ (if acquired) and cancel both
delayed works before resetting the codec.  Re-enable the IRQ in
rt5668_probe() when a sound card rebinds to prevent permanent IRQ
silencing across card unbind/rebind cycles.

Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/rt5668.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index cd6245d6b91af..29d70802a046a 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -62,6 +62,9 @@ struct rt5668_priv {
 	int pll_out;
 
 	int jack_type;
+
+	bool irq_acquired;
+	bool irq_disabled;
 };
 
 static const struct reg_default rt5668_reg[] = {
@@ -2216,12 +2219,26 @@ static int rt5668_probe(struct snd_soc_component *component)
 
 	rt5668->component = component;
 
+	if (rt5668->irq_disabled) {
+		enable_irq(to_i2c_client(component->dev)->irq);
+		rt5668->irq_disabled = false;
+	}
+
 	return 0;
 }
 
 static void rt5668_remove(struct snd_soc_component *component)
 {
 	struct rt5668_priv *rt5668 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
+
+	if (rt5668->irq_acquired) {
+		disable_irq(i2c->irq);
+		rt5668->irq_disabled = true;
+	}
+
+	cancel_delayed_work_sync(&rt5668->jack_detect_work);
+	cancel_delayed_work_sync(&rt5668->jd_check_work);
 
 	rt5668_reset(rt5668->regmap);
 }
@@ -2555,7 +2572,8 @@ static int rt5668_i2c_probe(struct i2c_client *i2c)
 			| IRQF_ONESHOT, "rt5668", rt5668);
 		if (ret)
 			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
-
+		else
+			rt5668->irq_acquired = true;
 	}
 
 	return devm_snd_soc_register_component(&i2c->dev, &soc_component_dev_rt5668,
-- 
2.47.3

