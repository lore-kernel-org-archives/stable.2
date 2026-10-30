Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379863;
	b=GuzeR5kBgNhRnTarGUdTdekFtAjsGV6hCw8cP4G/wHT+nqkdge01NscFbYl7wLZ0Otus
	 Q242f43nTkIGVPCsA7cQmLj/F9qR9UA3Z86LunDv0jZ2f3s/RofVeNUIq/SoOtR1tv04V
	 aO76sXN3Adokha6T9blBxVI7nb5GgQJE8XYEnJ+DGtvY5nhAblnZJHKrUF1azI6rjU/lL
	 ve4Xht5AIbjJS5w0RcddmbDqbpq5zgAFu7+3c9ZwdMsuaDHiiem/m1KBPW0qXO5ynHjmu
	 VDGCur8xsSDTVFG0+BSpVw19HvGw5i3AuZrX7wzuErxH7ekAFNZELLvlyEethT8/pzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pHEQCdfSxii0nq13bXW9c5IyViFN4cTWPLLIw6alyys=;
	b=Z6xtyF+rUoelGA/pbOo0eQKNOqsSvIQ75ryVENgWAR6FaxRpZDXE9v1c9tW4HvSdb1o/
	 JePbocZX95qrJ+IjmzrAOWhb7JSGlXn8SDhD/gGQHsmbzO+ph5wElGKv69Bn+fLCV3w0V
	 Rxf3OHWmumrGshlL6GT8B09quBBBLb4yA+B8HTTofzdh97tIHlVJLp5v5GbpC+QeXzij0
	 JzdKka5LkTZU676MHft4eNLq74kb4JMsUKeskT5o2QMCjHZTsDujQXnkcfmwKPlWXVaxp
	 x9t9vElTLXViMFleKvz7RW91h/R/MHR7bWbaWNKuyb1qB6/FemaI5F5qTubT0nzQ/gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9dK+NiJ;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDD606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5EDD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9dK+NiJ
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso11621875e9.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379861; x=1793984661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pHEQCdfSxii0nq13bXW9c5IyViFN4cTWPLLIw6alyys=;
        b=b9dK+NiJn/FfbTh5Z1ZSaooSJk95Lu/nMaO7kHMYykHBl5BgHUM/GLtCayYhTzLDPG
         gUlFzY92leUSqElBkJeYiRDZJoY3hmp/vYhV2ZMQAOUb+ASqDjWuhg9zrzAH6UFm+LSW
         IBlLaVpuOwgwTbESrbvEgM1tvKabB+72gKbWd9oxtojGDD7PMc8KBonpEJkuA0VuJPd4
         4otCVUDtkypQ44dRZr0v63nJedHHtu8YAqBZC9rk/BlSDBRfEVZsl9tZeEbp8++N+cQr
         0EknJWBSZSdP0Zrty07Yvjb4b08MV1gcUuv4xX5JsmAQoI4s0ai5KuvyKcUJJwtaAhyw
         h8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379861; x=1793984661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pHEQCdfSxii0nq13bXW9c5IyViFN4cTWPLLIw6alyys=;
        b=zrBtSQiSig3hZdUl40DgWXI8I9fwhsCGpGeq29plJtvKoJQcNKDNZjiqBOKeWJvWCp
         ZWUtZkn9uDL8erIJgBgxfvGDmouCSkgEQEq87A20U/dOwE3Df6UhaYN4OKMxSBqzg/p1
         iVJUs/mG5dicemA0gq/k3KstPvgOdL2YoFiyL2xKQUeZcTHImkqrDkVsRncKbFgnPuXE
         wpW6yCJuesZREdpDquEFhNIO6HBPfSkksF7pyBCDiHiQurBGzxSgoMUkjqG2JB0kBQkQ
         J/6JFIFgeMowOTF4UF3DTdrW3byRg/VOP5AU+s19sy0ML5A3ALxNbnKMXBbAxAHshmqU
         D3Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxvpMUSGK2DIq5/4uKPNnA0njvbz1bAvJAkXJKhx1n0KoRRgz6JuY4QbOeLcMrv/qDLSQymwbc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCzYPOnUt6SGeKNlZJBTgKmBZnbC2HlZii2BaHJ7Zh0ETgaTNY
	S2uoyECGfAxkL5F8lSBOuN3wESAr7kPVBLFkX63XZ0Gn9gocpf6EWtamoLun
X-Gm-Gg: AYBFou1+OAgiLJZ2zQEZfTZ93oTp1HmTlpBSdYxpWSQhU/QGhLe4XFmaQ3Ef+fBRmqr
	mjtVsvtpOiWzM5ixSZw9KKsdCYCD9AQzQSPTEOi9yEXvz23P7X8WIno7KNYhMablqkr71mHk3Kq
	4zR3+INvvn1O2Juv/oDIMfGsvhaYRuOIDW/EPykq7JdgnB+4DvSY4Me1hAXWvEagM/fNLeFjtN1
	WFYieF/My6k4YaM5vZlZkir00dXi0g2ZuH+b6e7p6lID56f1Ry82eORN298aADL9v7q5BvANOwV
	/7o+67T8m1lnuiVq82IG77JRPwDTKT4IkrjK7ujDv0DT8rDDfX2bCh0qwokjKcken7msFl6Gmwx
	0p5BFTAYtWwfZaYhYA3kkZQ2JOlVVfHUWdVjGxLsJx3ekn0vIK2uH2vygY+YzjjvwxfVi6lptp8
	QIUI2GrwiWvnxbyICyE80JERRXEU0itZVsRffqmo88yjWbSlzPogOti4XNjhuHoxClc/2Yw2OxO
	K69W6lEoZvzlMF0LhYN8Et1Y7+PhsgsvfMNRzqKEgAPiZgSiVViCstQyelOQlDYr+eteCnP3bP1
	TTd3Au+YKMs=
X-Received: by 2002:a05:600c:8b04:b0:4a1:db17:c7e6 with SMTP id 5b1f17b1804b1-4ac150b2044mr65640295e9.2.1793379861164;
        Fri, 30 Oct 2026 10:04:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf7146621sm75121785e9.13.2026.10.30.10.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:04:19 -0700 (PDT)
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
Subject: [PATCH v4 1/4] ASoC: rt5668: cancel delayed works on component removal
Date: Fri, 30 Oct 2026 17:04:13 +0000
Message-ID: <20261030170416.3561618-2-tristan@talencesecurity.com>
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

rt5668_remove() does not disable the IRQ or cancel the pending
jack_detect_work and jd_check_work delayed works.  If the component is
unbound while work is pending, the handlers access freed memory.

Track IRQ acquisition in rt5668_i2c_probe() via an irq_acquired flag.
In rt5668_remove(), disable the IRQ (if acquired) and cancel both
delayed works before resetting the codec.  Re-enable the IRQ in
rt5668_probe() when a sound card rebinds to prevent permanent IRQ
silencing across card unbind/rebind cycles.

Fixes: e13da14e8543 ("ASoC: add rt5668 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/rt5668.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 4154bad276101..ab63a43b20b89 100644
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
@@ -2533,7 +2550,8 @@ static int rt5668_i2c_probe(struct i2c_client *i2c)
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

