Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013737;
	b=RQeV+ogBjQKMp4Whm7BAkYgKrEaxDUsXDmIhtSqVhTdkrn7UZYDOt2f1EVe589u/xV3c
	 yxWK0D1vyDHGP/eCLn+XJ02hBVcX3r0u4rSg5cBb3hOd548L+cVbaEAp7XU3y6RYvtj7j
	 uU98vQb1QiNLchmjg2SD2ahgWMwpDsA2AZLV61IpS4qBr2/VTHvsrXZFYWchauCl2GfOD
	 6aQvcZ39ponFZ5JoKDl9eR9YXSPQvPjif/3Vgh4x3JihWSly+XYGhf8MPTmIWujJ4AGyF
	 sDFo1CtRHhkEdKBKlNs4eE2kXpatK+9jfLqxSbZDT5bo6eyqRmkQ1+0QIcqdc5VrLjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ueFejEZrKtsOeSpK53EAFsxF9wHlmejap/cPAZ2o63c=;
	b=A8GNKGWGJxwGXaioIo4bCFk8F2C23pkgyXsVhkZd9lKDTl/gm5KPokK0Uba17ZHAq3CA
	 dnMBRv++Zs8PlmPG6fmExDxAPHFR5Shm2I9uvBVWgoVOqy4caNvrpEA73fDAJr2xxT89y
	 I/3GuX1FI0yoQ0Tc+PwsXA6erzQsE4bF10czIKfq4HmZllcyD/GR+n+IsAqxeNkAT4hFu
	 M2FO/mIxPRdVqU7LA7d84JB7OcJ3E0fEJ/84En2wzWG/Dtq3/BJrZ7lP+kb56Xupos/vP
	 QFy0cnYEG77VDfwAPqQNDtOeMiZIrwZl5Rzgh4Tq+6gpEM43GFbZkeKMjGiFZNCzK1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="K/ZCaCFn";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA5606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54CA5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K/ZCaCFn
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so16386245e9.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013736; x=1793618536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ueFejEZrKtsOeSpK53EAFsxF9wHlmejap/cPAZ2o63c=;
        b=K/ZCaCFnHC+KWhwoXbaL/Nt4HC47qntoDJ8TPLIppmlu74hfqGjICbpN9pJevtvtAx
         eNQ2KlRzB7LneCU8dcIEi2Vop+9r3pTqlSt5L0irBquwocC8istdlOUSkA1EgxHpvsLd
         07csBCH7d24TWeJ5AKXE+H2GA96onSyRJRWmsPZB0cj5deeBHKm8TuOdRUvNXHtlDQPn
         k5uDJo3lDJnr8aEtQiFH6qMMsps1witAAs1evsF6VmAEGmmYYKgreb4q8mVc2RdNi+Ns
         TfYAWl3sK9pCB9glSowlPbUXkWkIZeblC76AJM++agE0iFg5c7m5qN9cuolsLNWKqabi
         SPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013736; x=1793618536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ueFejEZrKtsOeSpK53EAFsxF9wHlmejap/cPAZ2o63c=;
        b=Ys8R/IAEozVUC6ONhgUIuC6xLGPGY7yE/rJwGo7uqahMvYYfskC+yERVIvpNA7FyMq
         qmtGeRofrfWJCASXK7w2jy03/78ZlDNTe5c7da1o4Z5WvY3G0ENuoCoso05h7TSu03S/
         xUzvN66ez2LAfv2I4U6UpPhkqADLztANAcobQebd2p83PM8cQPJMla4heZGpL+slx9xf
         pUjxQl3zoAeo2YyppEf2A+u+R3paIJwANIBBffoiLH7ivbyLmWoTws46GoFsT84VNe+8
         mUHoUqmAAodOi/uqgNgs4lQ0qIPg4Pxl999jwjKIUh5pEByjYlSt3AYPC13igCBhcnzc
         zf+w==
X-Forwarded-Encrypted: i=1; AKwUvBx1xGwgfhHado0MQJxismmbIPAMDofTalUyUAimRHaFo5wAFvM8Dj6BwYcusrnNy1FldPfeXeI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRSV3/kWk/Gj1Fstl6i9QTAKGNMMQthVbejMCAgYJOWUON2K43
	agZHyN50dHTHCCkj8HrYahH1sPFJ2NwvjxQGOkj9D1xHXao1HDI0t94=
X-Gm-Gg: AYBFou0ppO9qGMKIiY5+NblqQ9SH5thrusckoPANg5jtvvAk2YgZF96XD6av2/1PnRP
	dhu08n1TD62nyf0lYl03IvC0/VKL+FQGD8ylBskHDtrFlikcxtYWPCXIdk+HvqaIk4Z/KNjKu7k
	Ds+a+4OWPpgWsg5f1zhvhLWNKgRokzl5mAOuV9R3pEnJkYITonX38qE92k1L8zSrsY7CWRTDgLK
	DmWffCF4py0URuMUGs+hr76vLfrCgt4WURRGMlqegZmczZLaD8rtkPpX4RYXeXxHA57gRPqZ4T9
	3OeMS4OCcq4+l9C21+BcKAXbMB68E/bOi+LzMG0H/c3/vy14/w8uvxxfioSdMMWBfYS0b7KDPy2
	gVd/2qiSpdM4s+1Rfb7lI6dCujGXOkqLp5Qje0WjPsIPeO4v6MB3lkrtfUyuT72jtPINEkLHa8S
	m/ZvQpvlHoFvYwa6ZZuouY3p2LWZdZl8QeM2rp5wXZ3rr/e7l6rMO0wZSBX3/4AE2MHQLf00NUL
	L40RYroGGWTNWz4DAxTXF7X
X-Received: by 2002:a05:600c:870c:b0:4a5:4589:24e2 with SMTP id 5b1f17b1804b1-4a545892686mr70915305e9.7.1793013735596;
        Mon, 26 Oct 2026 04:22:15 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f59750sm129141265e9.0.2026.10.26.04.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:22:14 -0700 (PDT)
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
Subject: [PATCH 1/4] ASoC: rt5668: cancel pending delayed works on component remove
Date: Mon, 26 Oct 2026 11:22:09 +0000
Message-ID: <20261026112212.2519775-2-tristmd@gmail.com>
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

The rt5668 codec initializes two delayed works (jack_detect_work,
jd_check_work) but neither is cancelled during component removal.
If the card is unbound while these works are pending, they fire on
freed resources when snd_soc_jack_report() dereferences the cleared
card pointer.

Track successful IRQ acquisition with a flag so that disable_irq()
only quiesces a line this driver actually owns.  On component remove,
disable the IRQ to stop the handler from rescheduling work, then
drain both delayed works before resetting the codec.  On the next
component probe (card rebind), re-enable the IRQ to restore jack
detection.

Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/rt5668.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 4154bad276101..01b14c62fde7f 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -62,6 +62,8 @@ struct rt5668_priv {
 	int pll_out;
 
 	int jack_type;
+	bool irq_acquired;
+	bool irq_disabled;
 };
 
 static const struct reg_default rt5668_reg[] = {
@@ -2213,6 +2215,12 @@ static int rt5668_set_bias_level(struct snd_soc_component *component,
 static int rt5668_probe(struct snd_soc_component *component)
 {
 	struct rt5668_priv *rt5668 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
+
+	if (rt5668->irq_disabled) {
+		enable_irq(i2c->irq);
+		rt5668->irq_disabled = false;
+	}
 
 	rt5668->component = component;
 
@@ -2222,7 +2230,15 @@ static int rt5668_probe(struct snd_soc_component *component)
 static void rt5668_remove(struct snd_soc_component *component)
 {
 	struct rt5668_priv *rt5668 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
 
+	if (rt5668->irq_acquired) {
+		disable_irq(i2c->irq);
+		rt5668->irq_disabled = true;
+	}
+
+	cancel_delayed_work_sync(&rt5668->jack_detect_work);
+	cancel_delayed_work_sync(&rt5668->jd_check_work);
 	rt5668_reset(rt5668->regmap);
 }
 
@@ -2531,7 +2547,9 @@ static int rt5668_i2c_probe(struct i2c_client *i2c)
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
 			rt5668_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5668", rt5668);
-		if (ret)
+		if (!ret)
+			rt5668->irq_acquired = true;
+		else
 			dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 
 	}
-- 
2.47.3

