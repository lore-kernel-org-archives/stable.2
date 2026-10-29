Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309112;
	b=hFIIAI74ITzwRGPipDXslh8WnEC96VYAFppKltXNxB4HC4ZJqw+dNlTpuD7cMB8rREu1
	 svtRDSeL0+G9sTJNuDEeU7TLycTBpw7Zq8nr4nBmr4cmnvJJ6N8yAhq4Sfi/xtt0KSo8m
	 s6/Qvj9a2F2+wh1Ej4HTVDNiCm/D51N+tpdt8pCd868lAAwsvH569WZsidT19eXz7g5pN
	 waNY1Is5svyVWj6OPfm0QFTU1qepkPuK/UtaVxRlEA1m8xQzai6nxuonZQbpCe8+sD9+U
	 PRBaVV4KoxxfGwtNYow0+tQGNGyeQUX4uDW9eSgdX0pSC6Za0gb3utX7kEQjl/t8cog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ea9ON9Wj1DOOIT9igutSk+68F684zXNb1sM1QM4w78w=;
	b=HUaujmvARAAWKmWF9xV2jg/vg47YVHfOJws4/LLewUnfljSi4scIIppnO+uy3rP6AA99
	 kdbwQl/CLx7VhyTB1G5r3MeLfdxjIu4BM/U6DLXYqgNFfzke7TlLd1KV2AansaMskADim
	 axkssU+uDd08NiPOrGFTZzE3J8jL7YULwNBeWsmq3PnESE/sPEph1PNrK8ACIxLJbgwXh
	 SssRi6mgfczq65SvqnuQh58jZW1jRZAvyqzBGO7ZKnlo85pc+F62cn0UVJ55D6ZoIGy2U
	 Fe0b4d3R02TWGPxQ7qv3fXWlYxRlZC1S2cMXsqs6Z2mte78wSav756naJ5tV6bm9qlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DsDj15i4;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB5606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BEB5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DsDj15i4
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e0d1da913so50444f8f.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793309110; x=1793913910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ea9ON9Wj1DOOIT9igutSk+68F684zXNb1sM1QM4w78w=;
        b=DsDj15i4i7pobUcNAo7yZfc+jhJrDBUAb38Y4HTjIgS3nngX9MIWiQ2XSsffZApjIx
         l56eMN0Q/efpgHszwkK4tA8LBe0QI12lYCgPtgMlWg+/uYHHHVYif63Uirb8EATF84Jo
         wIXilJliUrbfJCwsgJsQJMaNLrRch1wxjKwvRfgKRFXWeMz4mDHe4YyypSNX7v/uQnch
         M7c5GwY4M+tg5BgvfUzclYnIfyfY5Aebu1bNJmzwbKcExnrCF4e7zUTTy1LqUQ4GmSI5
         NdUk6V+OFMcvMA6I0ufg0vcF8ogFnHdWBtBFvGDo+rErIDgcY/dmMcvfUEekm7AAeBy9
         tgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309110; x=1793913910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ea9ON9Wj1DOOIT9igutSk+68F684zXNb1sM1QM4w78w=;
        b=Q3Mfxz4qyQ/hM5QlKQkX3JgW+e+gBPrYpIkb/uh30caZcNe3OnUrThCKqhenco3ffY
         2GpKzWZtuLb/mqHX/bfAEcldupf5dV1TgW0zSbCL+OBOiPQgAHFuYl0AHmhZrFXptQ0O
         cEGmpX+Z2bH5lPsBGFzw8Ew6ZSlsXpK0zg2pFvRlctSRMfJVIYDEJiDEY/Pn0G7EiirV
         l5qX7oyfLI0rKLCacLIkfN5TETsU+qiulPCl3KrUKUnOQvMCzxyQy2T+x8SQICuwM2a6
         fbZ51yw5fUsGpOo7zDzl6j1HJ/eush6/mw+e/3gaCA/PfkGS9S2UzhoFVyx4cgWOnz91
         KPzA==
X-Forwarded-Encrypted: i=1; AKwUvBxjKdvuLKXCkcJ7/WPBSMWRB03LH7ZoQ2knCiLdlsVq4ktYwlHN3DHS1uMjKAay66X9U+6lWSc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7y7IdTzNNIDOkQkzQe5YjXj8f8/uuKaAgcB5/u+9yh0t6fbtK
	ty0UxxeLN2BeAcBJWGehqxdi7hiMPjMBzstdnMYgvJGtG8fYtQ8tYo4=
X-Gm-Gg: AYBFou10wbbOZOUdOt7l3WvWJngqptD4dP4B1MUTWY+2ADjniM0841f3OTFiZ8YEquo
	TpXsLTw6Pph/AJ0OVXNYGLV2WOgHwNkQhvXUbioa13KzjBpQicAtlTW1NqAxbigepf8c0ZMSVA1
	LOx/9S48dF+xv7ZtxS7pbAcqY47QW9SUe+1EXD7XZOlvyW0SMfsU0pmUTN9lBd6+e5iSGeWfzHT
	zVyd/8r95t+q0XxExsu/ty89JiZKjaDGUciaHz9HmCPE2Wgk0A7mJilKCLtdz/0agrXa2xrdd/K
	XtWQQe0lCIAUupsec81kosdl303aczGX1Wi8pB2Gu9/R7XpdHZ+dnegFAfgt2ztTDf9YmDAp2+k
	BYwFZ24uj0NEqx/g4ZCH/L2dMF7k4fbIVWwRkQTRS/6VneOFQp8UbFhDhaZQm+QIzIobeSPZrv9
	eA1CWEMmdS9qXLZn/T4DjXPpiat848q1slKdMtI9qHWvqFj1s7QC1rvrRyPQbgGw1JhikEY94vA
	pXFZtogIWCZlowdYvrpbev+2boEX9/CB2l3HFo3IthmBBR2a608ArMajYY3XXHa0CvOKSU/8Q==
X-Received: by 2002:a05:6000:29d9:b0:48a:fe00:ad1 with SMTP id ffacd0b85a97d-48e6e2c1d3cmr762377f8f.6.1793309110486;
        Thu, 29 Oct 2026 14:25:10 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb82584sm714873f8f.27.2026.10.29.14.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:09 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] ASoC: rt5668: cancel jack_detect_work on component removal
Date: Thu, 29 Oct 2026 21:25:01 +0000
Message-ID: <20261029212504.2997364-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029212504.2997364-1-tristmd@gmail.com>
References: <20261029212504.2997364-1-tristmd@gmail.com>
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

The rt5668 codec driver initializes two delayed works but only
jd_check_work is cancelled during removal. The jack_detect_work is
never cancelled, which can lead to the work handler accessing freed
memory if the device is unbound while the work is pending.

Add cancel_delayed_work_sync() for jack_detect_work in
rt5668_remove().

Fixes: d59fb28562232 ("ASoC: rt5668: add rt5668B codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristmd@gmail.com>
---
Changes in v2:
- Resend as part of unified series (no code changes from v1)

 sound/soc/codecs/rt5668.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 4154bad276101..0e6594c327311 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2223,6 +2223,8 @@ static void rt5668_remove(struct snd_soc_component *component)
 {
 	struct rt5668_priv *rt5668 = snd_soc_component_get_drvdata(component);
 
+	cancel_delayed_work_sync(&rt5668->jack_detect_work);
+
 	rt5668_reset(rt5668->regmap);
 }
 
-- 
2.47.3

