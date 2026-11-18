Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966056;
	b=5fOzVQxbZAvInGJCmGFHMRoPjdi2abtHn7mpGP3ezscBDOq8PqyrdYCpHYLRcvcyL8nt
	 DiI4fKw38Hqaz0l9yj7UgicW8rWJv5+QyvHNSCBIs9gtT56HVXiajb2lcbuDGS2J6LM3m
	 7ioG6HPSQvBDUJkuN5CEFkNrc3v8tADQ65zeeXK2HIp/HGYKG1LU+z79+2TPYRTyIaFeP
	 iX6I5jNoG8P/wwQocwkH1gPVYk2iGILziCbIea3Rqwk6EG0fcDd95xEL8MlWDjofW3xHJ
	 o7rxYfuddw4lD9V1CdXMcyF/wQ7H+PKte9NAGOFSBtksB4jMD6hcx8Xn1SROhDLUlSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PHZG0bnEH5ZUBCEviVeul8atAzxQpR4ArhiU80Iqs1U=;
	b=d6TYofevirjkeysA+NyejxZZgGyv/FUCHv0B/ijOtIQYP5VyAj7ohZyhCOYnC4piZFW8
	 bBLd5P/Bmm0xRgGPfpMbCLB9u0CZKOehdfrPkLtPwWK+icOon7iyw/7t2DIMB8pEbAS7U
	 DbHFSrl1ZF6Vf62lubVDD/cxUrB8dPrInDKYH42F2wgQdNZFwbcZIfj9kltL6QnZQD2+e
	 6GH9ZKgl6mTOfcNBKHeOclyuDtPV7diSZ6j+xAV80qs8LeE+1Ixrwrt+t9CjRh9OnZrHD
	 YQYbqB7RWv9J1uUbtgRuZag8/3DlhDIiAHrTIsybyGZYRbLdYj5lmLU8TdFdRjI5znQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cIxGV4xz;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1D606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7D1D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cIxGV4xz
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f2f2edb19so43343085a.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794966055; x=1795570855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHZG0bnEH5ZUBCEviVeul8atAzxQpR4ArhiU80Iqs1U=;
        b=cIxGV4xzHPb8AnycsIS5fHQ+ETu8GWeOn45mTQ3MuAexMBjai42NmFlP3KPJhL1Gqt
         TSt37n6RdKFJvYJSYV7QmEQV5gv02XcZt2EAotbWfA4nmNnkVPl2lkqAzO3hvoWrxOVZ
         KStxxtF+uESBKZvlvURqBy1zQ3eTuIGim6NXE0ukzc4oh0xbIuwrs75Uxc3os1sJa9ke
         ORzRyJh8X+lKUKgZF/8agZoYgVlNezlOhf9vz5mzz348WNMR4wGsSuR3JgcfY2pf4pS/
         xNVrHVEzEw7iRh1p4yaqp9AJJvrR3xUDsA35wSxE6pz0wB7Nid5D1O3A9naU/VZjYKq/
         awtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794966055; x=1795570855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHZG0bnEH5ZUBCEviVeul8atAzxQpR4ArhiU80Iqs1U=;
        b=Ka+uOcM9oggw6NS4//GHQT7BrB6XLYJPM5tQVMNOb1dMlO0bD+Zm5YWDqZK97OxHaM
         25yrRpXkZn1at15WLDTn5AyebsUMK3Y5iDxLOxevxpklllDdaOGOlTB1NbOQ9Fi/GnRa
         uw3M9ZIQu/36nfKojbgPN6lOaxUH7LpFIhHDAQGC9Gy8X9JbQ1t5dI9I+zc4TXHNYinK
         sd8aC1T+6sht0u1wafIaomyQ1IAs6xv+mXgKk2/eGd+tunltxgmK507D1UrTfO/hR9Uk
         bXS9XU1TSwvku7omXUtMeijaNaj5cA4PE5z7/+uTCiUijEMmIRko4octTnkjySc/mG9I
         qP5Q==
X-Forwarded-Encrypted: i=1; AL+hErFckr1klm8jKLWNS9Myr11b0+bGA9/vi/YiBCR3DqVVk5tlB/d5nT8wlts3Vr54RzAHRnMnhEw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lZhC/774sU/XRyz8xXxWtNpsKzfHumBXmcsNLiAV6sem/YpCs
	cDfYfpt8o8QnoOJ3MlNLimo9pW+sgVbf060xCvV8WYs7SZcgeAYzpgY=
X-Gm-Gg: AYBFou0dtXCsGjexwLfAL3LGOSsWtybBxP+dwBdz0GblGkjVofefmoijHuNpQ33MEwA
	QGyEqQr98uMaWH5PmxQ/S7zk5UueU3veq+t7/rmpXFPmLtQ9hRIuRdYfZCQYazNxVQEIMbDa+t2
	XC2lyPji0gO1wiMTGJrIT3f5/OYaM9IrCBN207q/WpjuTtdATjFPsPlOsSavHO5RkoLVghnCJBl
	kpGWtlXZopi4/UewtY+o/VHEZq9isZv9PL3U0a/OhUQfsmDOqEngt+LRyXdIPdIXjWijM2AevNU
	XZc+8CC3gP56bIj1uTj3O9k32waMdjGtIXiEfs6Q9rDJkRjGfpyJbBZhPGJCoDi3Sbjh4v/pV1m
	HVqU6bvBSefcqC6YqjiVunE1VcmWnHwkd7m1B7pnBEa0Tbzb4KbyabOCCbLreeeDxvjzwkeOmeI
	qjp6XAITRDq43OdxSZ5A8pfQxPkqTAoraTZnMzGtX3wmBb2NOKI4WJcDnczMJs2r/sv598aw7Ck
	GjRc6hi1VukEjFBdKiTYz5BzyxkKQyIePQdK6zjHSX6xbkBsctVbzsBDs2WNJAFcajyPmL/Quon
	dc7YJPVQH3GR7SoDBaUzJ2rlkHZuMc8kLmyIz8ElX4Ib5MMGMgQP/cwSfTZJSstInxx6Un190fB
	QORUCXlRvVKJ8sFSFG4w2hOv1IaQfIs+6QYlpeIM7IefeFX2E4GuoT59hnO464Nqf3w==
X-Received: by 2002:a05:620a:2887:b0:93f:6375:aaa0 with SMTP id af79cd13be357-94999632575mr258573585a.80.1794966054585;
        Tue, 17 Nov 2026 17:40:54 -0800 (PST)
Received: from localhost.localdomain ([104.39.87.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7d3f19sm60825585a.38.2026.11.17.17.40.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 17:40:53 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ASoC: rt5663: Stop jack work on probe failure and unbind
Date: Tue, 17 Nov 2026 20:40:51 -0500
Message-ID: <20261118014051.75468-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

rt5663 registers its jack IRQ before registering the ASoC component.
If component registration fails, freeing the IRQ leaves any pending
or running jack work in place while devres releases rt5663_priv.
I2C removal can leave the same work behind.

Stop the IRQ handler before disabling and draining both delayed
works on component registration failure and I2C removal. Stop
jack_detect_work first because it can queue jd_unplug_work. Keep
both works disabled through device teardown because ASoC link
cleanup can still call set_jack() after I2C remove returns.

Send earlier probe failures directly to regulator cleanup, before
the driver has registered an IRQ or started jack detection.

Found by a static analysis tool under development.

Fixes: df7c52168ee1 ("ASoC: add rt5663 codec driver")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Drop the duplicate subject from the body (Mark Brown).
- Cover component registration failure after IRQ setup (Mark Brown).
- Share I2C teardown and keep both works disabled through component
  unregistration to block late set_jack() enqueues.

No hardware test.

 sound/soc/codecs/rt5663.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 58b165e8b6e12537196a775338de1da1667ad82a..5e95ab2666594ea1a8f2a59338cbd513c8c97c4e 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3520,6 +3520,16 @@ static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
 	return 0;
 }
 
+static void rt5663_stop_jack_work(struct rt5663_priv *rt5663)
+{
+	if (rt5663->irq)
+		free_irq(rt5663->irq, rt5663);
+
+	/* Jack detection can queue unplug work. */
+	disable_delayed_work_sync(&rt5663->jack_detect_work);
+	disable_delayed_work_sync(&rt5663->jd_unplug_work);
+}
+
 static int rt5663_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5663_platform_data *pdata = dev_get_platdata(&i2c->dev);
@@ -3724,19 +3734,13 @@ static int rt5663_i2c_probe(struct i2c_client *i2c)
 			rt5663_dai, ARRAY_SIZE(rt5663_dai));
 
 	if (ret)
-		goto err_enable;
+		goto err_jack_work;
 
 	return 0;
 
-
-	/*
-	 * Error after enabling regulators should goto err_enable
-	 * to disable regulators.
-	 */
+err_jack_work:
+	rt5663_stop_jack_work(rt5663);
 err_enable:
-	if (i2c->irq)
-		free_irq(i2c->irq, rt5663);
-
 	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
 	return ret;
 }
@@ -3745,8 +3749,7 @@ static void rt5663_i2c_remove(struct i2c_client *i2c)
 {
 	struct rt5663_priv *rt5663 = i2c_get_clientdata(i2c);
 
-	if (i2c->irq)
-		free_irq(i2c->irq, rt5663);
+	rt5663_stop_jack_work(rt5663);
 
 	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
 }

base-commit: fcfcd6db32adbdfe81c1ded257200e3ea6815d9a
