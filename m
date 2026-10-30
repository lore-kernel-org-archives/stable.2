Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382522;
	b=izaSEe8S1lZGNNSjp0U1XElnIfmrpJynGsMju+1T58ODaluB6PnYM2dDnRyypXa9TLPy
	 NprijmiTHT0aQD3NGrqxAhpiBq1Nq0gkxQ9ary9AyUNzuATW+IZmW9MvjI2O3MiAlcAid
	 JEECfJWJg+lt2HEFeklkHouXP35fQN5Nv+r/0dBlfXAtaw0c4xCpWKli4lvl/Zrae6rGF
	 bLaZ1Fj253udIVixtaLYacvsvcg8NA1CxEM7k0DFvf7sN5LsZEIz+QjQuaLSTFYNxHhs1
	 S75BpuWt+LpERGu8QfdzccNqn0O6faciEBFIOY1A35XFRBmZ2u/oqSx9sMGpV1HPZgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=blJPEsm3yTlzl7Q9Z+trIM/D190QszcHUFXY8FNDqQ8=;
	b=jiO7M1DBqteBP77XdujM+9LfuL7UJMl8aVsoRd5JgbOY3ac89/y/UAehysbAq4R4WVOS
	 kaBbLG1hav2Tm7z7do9y3+PooNR20NCz3HO5h4jDEwFArVNyE1QJ8cVQvHew6AG1vcE6p
	 UR9L6I9EPl20og0n0Mm+NgbH7WwYzabPLtYTK026sN7joDm9WKYdgaO8lX5/8UHwdztjD
	 RTZe9TWs0+i9lure1qDGklHmt4dpT7z27Dou9H+mAsJA0stIbwCws3iDBHar3LYGpmF8l
	 FX5TjhqzoZEfM7WVqOeU4gd0cVp36qK4ZgIXqV7CGZpXuzeencIsoGbRJXYL1ebBRpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6K3xeVT;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ABF606A33F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11ABF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r6K3xeVT
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so865750f8f.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382520; x=1793987320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=blJPEsm3yTlzl7Q9Z+trIM/D190QszcHUFXY8FNDqQ8=;
        b=r6K3xeVTQJ+PkrzeYC608YNPD6yjhqOeRCT0Ld7O9l9pcjCJpuQOFqmvhcp0gYnwwf
         1Afh4QbuQT4Mvs0Sph+T4x46w03fy2txJVPTC8TZEcaTRNKUglVdS9O3Y58KH4oq1hoC
         r43cV9LMqrXe+bziOUmeesY6pHwHJNJ4NjvptwNG+MJ5AWUoyjC7zGx861eWKl0C5EQw
         mrPrj/wZ6NIpmcB9hgiCdF02Yn+DGvDRkndQG1ePHN/MdsSAlDpU3dkQLAy8Tc/FtK/a
         fNWF34q51AwFDJgVn1smeEAXRP5f+lhthMwJwe5d9uS8Ic9DhAks+wvh4l3luSZ7TN9F
         Cb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382520; x=1793987320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=blJPEsm3yTlzl7Q9Z+trIM/D190QszcHUFXY8FNDqQ8=;
        b=hSXzb8jcTJ2D4bNunkgbgoplPEipNNEMiAtxZTrXUi5jZsyrKXKCjU46JNM0BYvh8m
         m0+U0zhwp7pTrc9QQTlckR5nI9LP07UO65KoJDgdTbHImxFoTG2BnV3dDfY5cqShBQrR
         Q0m0tkKtPCJzemrJr9uwD55tvNZfIsX1ovrDIinFOq4tu4vGonRa2hzWGbmxBnHcbv3v
         d3XXUnADWfiWeoZmvAJndTb/kVLE/TUFhJDajcjV4lVVGCp7uoXi+N6Auu9iBKPK5jKW
         cx3z/LpgnTwxHU51348nxgBa2lO999xRYjI58vYnhRho3WoZtpBhBbuY7rDQkURCy/yh
         Rj3w==
X-Forwarded-Encrypted: i=1; AKwUvBxfOirLD2pRVXgUOrEb+qV2LrCaF99L2QGFqU0Kmx3oH/cQEVMAkoLCEvt4z8vcij4+EJeKhiI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbdP6ARnA448G4vJakO3Mv25SFEzCUNWpq3eYBgHBLtOFKIs/J
	ICvukPmCJPLi+SAz/nMwLNvi7KzR/tUvoeT7RHtpurLsafHDMVemch4=
X-Gm-Gg: AYBFou3Gqgq6MTwjRx66+J27n+TC0QA0XCYgW5zy8LNXTHQ+HNaGV4FFBulZk8fSARH
	oLhnPfI0Edu9JrPItJYzUvg4snONdf0gIldzk9WfBpnPGCiVZuJ/ig9ZEhX9BWKQ/17xV7ZZ6jn
	ZqMOhOqplFaXj7GfDblXfbsvRHJKLRRQBvhYI+ZEPPhvUBNaD3PIAPcNeQRU/mJyiO0ppunuYc7
	z44nUZMEMOAc836Rm1YRaKaR4IbawyD2ALZcNjYjpAgE6a00eKuNVpjQXKuoefc7XLMZXA5JZgj
	QwL6imspYjTY+GrTtAKtAVrx+qtOXh4QUaEzRfupZnMdC/a6peL9SlpuuRKOGn+D9C0Ad/YKLDA
	csfa8mZS0GcuI5T2pn9E1pkVgEJX91VHcAD10k6cQLSkZIkiqh5YqsTOivLHmeH3eOk5v/0rN99
	/qjiOjEftwkVDvs04TNZDv5pza95/L5QasuujQ7Tt0HHtPv0mBfqEopXuy2zBi8mkQf3fbF99q4
	ZTB82z5s75fAnxRQRen5iIdHg7TWfqzCaY2Cv0Lbuz6wD1udhrOV71GTFwnEr9I9bJy1gFyOhqy
	liTcuPGryrU=
X-Received: by 2002:adf:ee0c:0:b0:48e:349c:af4a with SMTP id ffacd0b85a97d-48e6e529534mr5117683f8f.50.1793382520291;
        Fri, 30 Oct 2026 10:48:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm4492926f8f.40.2026.10.30.10.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:48:39 -0700 (PDT)
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
Subject: [PATCH v5 1/4] ASoC: rt5668: cancel delayed works on component removal
Date: Fri, 30 Oct 2026 17:48:34 +0000
Message-ID: <20261030174837.1839402-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030174837.1839402-1-tristan@talencesecurity.com>
References: <20261030174837.1839402-1-tristan@talencesecurity.com>
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

Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
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

