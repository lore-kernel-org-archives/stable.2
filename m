Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235317;
	b=GskZhH122ys6A9rktrBhjEX0qh3l3qcC++OZ/OwLUxaHTuZerQ0LxmnEuE5pL2HRJC0T
	 a1GGQZUlZf+LRTHWs0ieIUe4ItEhz04it9CweusN0ThMrhhbCZN8mbr6SLURL2alLbv5j
	 7k4ZiHQ0OEFoIqkLZFgpb2r3iNqhjY6FDcO+qQOUfvBUyVsUGgHNd0q+niGkccQK1ngsG
	 2I9CW234J8Jz/P6crC+aHeOkc/twHNpA/Zf+I9vJXfJaT2Otn+q1l0p7G5Y4W5vIEV9qP
	 kpKKkbktauZmMU6kgp0ibxbrWA60Hib1sqk4opr7ZgyLTv2m2BzQLTELh6QEKUXprCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lc/0ZwFHPEMcdqxUsWK2/XQWQDdOny9YCEaM4Qt1bOQ=;
	b=H2ptgA9NkclPjl/fLAeaPKoPsUizEwRUa4PSXbo1NmMxwnX94ofU2MKB1S/DB95utqQ9
	 8G0tSsH0+BdktyLMT8Y4lzUbxXCs7j84JnVMdg6PlQrMosMco64KhfrYArrPu3z+DUd3E
	 7a7dfqD2q5nmkaUwTYRj4ovViX/yxsA+4R1+g9Fv84xXQAD7fx4A84HqOHvoBzAsYgYPj
	 KNxWahKaQNo2t6IOBLz0B9AaXTMf6M17NHcS1hRCIRMSsNOcCc5rLUZ8/mdVo+7ASZLaF
	 DiaLUzV4W0TyPNz3cjHcle0W/gegpm9xpZkloau7NtlwAokBhj5c1LJv+r4GAtw6saQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5+Z3pSu;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC729606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC729606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5+Z3pSu
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so10221215e9.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793235315; x=1793840115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lc/0ZwFHPEMcdqxUsWK2/XQWQDdOny9YCEaM4Qt1bOQ=;
        b=w5+Z3pSuMuIMAYKBb+u3kGyPRwFhURWg11bHVwwE9sFnzClMI9X9hLiSK2VY1DcTyD
         PS2IPhdpiytOqIoli4WnapzgKjVO53J/smHJYVJUDt+Pa74f/tZMRUQNcLnuwJcweJ4N
         aR9BGcvJCyLGTqixwUJP5VA0YgriN0Ufl7dh5cnpzGGH2CR+rfJWVWTTGUSUNLsxXsVl
         X3mU+gHF3p5I88VbZkLXPFztPQMarXYXLSBkTDpDJWNBQcAoAw6QAAnwyyPMkaoK3h8S
         CRehQYqUGT7rQmbati3x2vgpwueCYbiIe6Hcb3PF8FaOCz3gQDLzkxlnOMQUDbIWvGMD
         Ik5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793235315; x=1793840115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lc/0ZwFHPEMcdqxUsWK2/XQWQDdOny9YCEaM4Qt1bOQ=;
        b=DGasFc69Og5ogge2+9YOn7fxcfkEKaGZw1RNT7mmFqM18JklZE8H9JvcAm4IbrzTRv
         uwwa/KbnsODHzNTLkOkqXAyUFr7WrrsZdArGrvw2myhZ7Cf3+tT/TKmmHLoGNldTXJ5Y
         zz9e0TlR5ddXm0NfUO0Hw0AnmjwLmwGLtp21DR4fcSFT6cS9o3PrQcAtXxDY5C+4PR9h
         NJPCZxyPAC1PpwCsCY0ukvXwT/+SaTgaUnBls5Q41bYXv0rud3GiISAQeQ7aFZubnIKh
         qodbTGfDosMEZ3WBvJ2OYuIfRVxE014/SCUtxGL7Zd3tscOGCmxUEH8tJb8/JV0aqIIy
         lgSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKzk964i3LittMPLgiWXjBs5vonE+2aORyFm7K/yM6hAnHX6vioomv4+Sy1+nXHf0sjlaAc3I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6iCiaDys4xph6kuLgE0/OGvcjL5xxQk79y0C88LlxtuUGRI3I
	p0igaGahlpLEeopNFzsr4z1mQh6IJm+BlOkRFNHTs4zUexLeZYZFjCo=
X-Gm-Gg: AYBFou2Ag4Lm0iOyF7Vn0X5Rxsft97WWA5Vl6+Qm2bd9zRNTTrdKaRt0cA1xxWF+bt0
	fd3/OPJ2LeUc+/tQYjY58gnKdXc3nVona5Ooqts6LOPFgt/RxKQBqmpdvBnZVwt/3mwZXXoxOA5
	S5ln3ICDvH86FMaEhjdPreBUjjaVTMlizcFMFJqqv5ueP6/1dhE5QgG2O+7q6K2GTU033/QiGvU
	v3pG7viaNNRf8ANJIFGprnOfP929YOqpNwer+IxwX2jB30VLiZnF0Q6SuaivDFircJi1kkhyc0i
	BI9UQNU0syMhiF2OeHw4hLvolVRdz8WqI2nYPlOro7j02rlqAHz++1w1AOO4FDwEMo3CWZOFeB1
	isqXmXh/UOFQRsV+PhD3ENWtZGAd1nfAVNyVqFuxdFO6MVBbyj9OVuYPAH/h40aKvRP0QslT4wd
	IaeYhhLpgD4ndHHfD372Fg9sOfCGKNWehTT6v9nodaoTLO1C9Occ9jAWFaWTWrNFG14+0qfd2fS
	2lG/Y7re9Yp+sat5AObmkibIY7JDXNb20TYhAqpj8qClMk7YxFrrBLMg4892FTz4jxBs2rmTQ==
X-Received: by 2002:a05:600c:474f:b0:4a1:cd83:b23e with SMTP id 5b1f17b1804b1-4a97452869cmr90177805e9.0.1793235315145;
        Wed, 28 Oct 2026 17:55:15 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f41895fsm23855575e9.5.2026.10.28.17.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:55:14 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v9] ASoC: rt5659: cancel jack_detect_work on component remove
Date: Thu, 29 Oct 2026 00:55:11 +0000
Message-ID: <20261029005512.1927850-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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
Changes in v9:
- Guard cancel_delayed_work_sync() with jack_detect_work_inited flag
  since INIT_DELAYED_WORK is conditional on jd_src (JD3 or HDA_HEADER
  only), per Mark Brown

Changes in v8:
- Split codec series into individual patches
- Track IRQ acquisition to guard disable_irq/enable_irq

 sound/soc/codecs/rt5659.c | 19 ++++++++++++++++++-
 sound/soc/codecs/rt5659.h |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index a061028a16d82..255552af59f7e 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3668,6 +3668,11 @@ static int rt5659_probe(struct snd_soc_component *component)
 
 	rt5659->component = component;
 
+	if (rt5659->irq_disabled) {
+		enable_irq(to_i2c_client(component->dev)->irq);
+		rt5659->irq_disabled = false;
+	}
+
 	switch (rt5659->pdata.jd_src) {
 	case RT5659_JD_HDA_HEADER:
 		break;
@@ -3685,7 +3690,15 @@ static int rt5659_probe(struct snd_soc_component *component)
 static void rt5659_remove(struct snd_soc_component *component)
 {
 	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
+
+	if (rt5659->irq_acquired) {
+		disable_irq(i2c->irq);
+		rt5659->irq_disabled = true;
+	}
 
+	if (rt5659->jack_detect_work_inited)
+		cancel_delayed_work_sync(&rt5659->jack_detect_work);
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
 }
 
@@ -4272,6 +4285,7 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
 		regmap_write(rt5659->regmap, RT5659_IRQ_CTRL_2, 0x0040);
 		INIT_DELAYED_WORK(&rt5659->jack_detect_work,
 			rt5659_jack_detect_work);
+		rt5659->jack_detect_work_inited = true;
 		break;
 	case RT5659_JD_HDA_HEADER:
 		regmap_write(rt5659->regmap, RT5659_GPIO_CTRL_3, 0x8000);
@@ -4281,6 +4295,7 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
 		regmap_write(rt5659->regmap, RT5659_IRQ_CTRL_1,  0x0040);
 		INIT_DELAYED_WORK(&rt5659->jack_detect_work,
 			rt5659_jack_detect_intel_hd_header);
+		rt5659->jack_detect_work_inited = true;
 		rt5659_intel_hd_header_probe_setup(rt5659);
 		break;
 	default:
@@ -4291,7 +4306,9 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
 			rt5659_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5659", rt5659);
-		if (ret)
+		if (!ret)
+			rt5659->irq_acquired = true;
+		else
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
 
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

