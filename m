Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382524;
	b=ObGLRKIAUD/zkPe1+NM3X/aPQTc/NTpxkM5vx5dbq80qaui7ccWxquIPcDFRoETUJL7W
	 Gn+hlApCgs2BPQq7R2g57+slXxr+A1wE9yOUYTKcyVsAu3jI/RDYjRoJmmBmH3z6Ja4bK
	 2FO3NwTwhdYTB6DxH+a+ujRzJg9aJa39a4+dQAj9BqL9LaRedMXMizBvTwTFuyr0auOWN
	 q4GNjJPLqPXmX5vw5CPxn0i0yYu8YmQ2Hfg5ZaxymBmNACS/9Nvf+f/nu7GAFe38lWW4a
	 tvgTLCyPtp2xQrYekZf5lXqoQ/ffKigBuQPXH8jkMJZblcu5vYfUsUmZIv6L5TxvWwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lvTI4kYswy8nJRdl9QxlU0eMLqhgVMDUC7UVIheEm08=;
	b=fnxcNbeuDQP08ANDz5MvG1jaV9kixw2nLIBYlNjwqJGgZe4/itxWMUQj/llB3k3VRn8k
	 Z6IzfhZFlsImoumzqT/HBEBdQjxkmAyWAKHUh77GZfI6toj36+K7/+SNd8+YzuChCEJrG
	 fkh3TLHve6oP0kCToB3q2EOwW0HRNP63LR52XWXk60VONhw5BaB9t72947ZQXOWYeTVEU
	 nAUt/3vhKvetNIt01OThewsWqwkIkKg1qIzdZwp5MqYVZF/RD38KwIf5o90YikW/FzVG7
	 0zbexkzgegcCQ/ts0Kma2k3KwwFKtYtko4HdiYkfk6SYOELItq1q07f8q9oTQ11Gghg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xePqTgOQ;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787960A2603
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D787960A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xePqTgOQ
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so10933955e9.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382522; x=1793987322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvTI4kYswy8nJRdl9QxlU0eMLqhgVMDUC7UVIheEm08=;
        b=xePqTgOQXy02kKEI5qIDlow66ax495Fx8PTmPoBZcHAWs9rNUPtCQjj/g5lZIUOxl9
         CvIPRIpwpjBo3NA25bLyr5QMbBLEDgtqTPc21i0SBg5e86v/2Sg17AXCafHcuMhvZrlf
         ZjLi+Rvx/ynNBK9AbWxggIDpdyy4m6cMgynThIlDEvE0Ul4b87vBdgz4sbzZDIdurH6T
         gfIHT7OD4GCyEPkL5Sqrpn+8VgmK4VPx3cYWMB0JddZjAlFnbLfD3+SkN+xO2BA7qBUk
         dbJjUL/ouuvLA7cYZAg8nuAt7SNCECTNmPkKus2kgF7xMAm5AOWh7XeZGPOSOCwiAmeb
         /+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382522; x=1793987322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvTI4kYswy8nJRdl9QxlU0eMLqhgVMDUC7UVIheEm08=;
        b=w9Df0X7iehD7HN5fTORIq6R7Lcyny0fFhclvAgakJJgPyhBM4UCpjepGjwy6/yP9bq
         iSaAumft7qfKdAFEJCEJX5XXxm2SfC2Wbr88pMfTkYwHz7K5hKG7uEAgrc92wjm3fuxq
         wjcmSwUjicBNbjEJoYAbcDwoGLvFYAt9S3O7eyJAMDu8eS3QBQf3AGtDmgU9cfxWEdTT
         9E+g4eIAxbHoT8yVBWsjbKBaNjvIMYu61cOk/xXomqGmI+zkX5ha+3AZk7Bz+5Ct2FKq
         /ug0DnQPyqzdkF7K7QyEpZtNC4naLIUia1Q80UaOb74ndAhQrrt9ehpCI+ULyEGksasI
         TbNw==
X-Forwarded-Encrypted: i=1; AKwUvBz4gSqXILtxUMEKKHjbscd97BjjwgdRjKgJ1rRm24d8mT8uhzVfOI2vHrzkDe8JcEqW+J2HnWs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLplsPg2DYgQhYrcXX/84xIobSgOPZkmecEjqu7O2XvU5McRAmk
	WVYzGPS5ddfUIFAFiBM6/2Dk6vQokkcWySz31lf7xmlS8g9+n5xcOrQ=
X-Gm-Gg: AYBFou2vRb4IyRFBC33/cLIvhotAj8zpLOh13b3a0omzeUGGaVZv0F5Q8xgi74MwKAo
	yCnSaYSM4+peHxnMa6iJJVHp5CCMdcCJvi8cNsbFRx5gbDusS3kzdKVJyGU9pQplb0DwfU/zfDE
	YuKyqDBKStCKc6Sp8+tY/7Xk17+jsUTb9IzTcIi15psMtMMebznDUm2W5sw3mdgIpA0pVZA1kyc
	7qyKpdFsJ7oGeVoON3UcrDIFkJMfa5kBenHHtvh5fVCZZJl4I2jvxrquy0KLA0I9pBtNyjeFC1/
	IiHttkuV2GYNCcLhgnGE8MawzGvI4xin6PD4N/YUZxl2Jj2P9nogRNqnAFn6SnC5OpL/0NhCHVz
	z9lsyLvIuyK5Mv0FbNWr4H8CFjR+wk4sOYAk54qeROB2+D5IEbtXmD/TW/k//V6dq+5NEwybcOX
	ytmmzGcmEkdbQ9HuS7a+ONfEmrndUoGaQ9YC/mPaANojcsHRdg3wgCvEDpNUbb8Z4uOSKncCK17
	eDD5KHgy/r0WNTKcSKQFQr4M3Kk6j+LCBhZesx/DneeL/wJxliaZXs85PsU3LBowqRklo7x5j6W
	5pKvTApaAu/2EFM+4udLnt7HdEN1Z6E6
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4ac18993ca7mr71817565e9.32.1793382522110;
        Fri, 30 Oct 2026 10:48:42 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm4492926f8f.40.2026.10.30.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:48:41 -0700 (PDT)
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
Subject: [PATCH v5 3/4] ASoC: twl6040: cancel headset jack work on component removal
Date: Fri, 30 Oct 2026 17:48:36 +0000
Message-ID: <20261030174837.1839402-4-tristan@talencesecurity.com>
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

The twl6040 codec driver initializes a delayed work for headset jack
detection (hs_jack.work) but the component remove callback only frees
the plug IRQ without cancelling the pending work.

Free the IRQ first so that the threaded handler cannot schedule new
work, then cancel any residual queued work synchronously.  This
ordering prevents the race where the handler fires between a cancel
and the free_irq, re-arming the work after it was drained.

Fixes: a2d2362edf9f ("ASoC: twl6040: Add jack support for headset and handset")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 650836f9615fb..826bde1a9ba46 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1136,6 +1136,7 @@ static void twl6040_remove(struct snd_soc_component *component)
 	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	free_irq(priv->plug_irq, component);
+	cancel_delayed_work_sync(&priv->hs_jack.work);
 }
 
 static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
-- 
2.47.3

