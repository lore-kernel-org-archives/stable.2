Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21233568549
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999275; cv=none; b=MWjnOjzAGxX2MFclpO1dbNNFAr7Z2VfdnGnqAAP/3xRYDp2dPBn8w/ZCbCnMuQnTBGKm53aETyIdvaATk9bXH1ZxikJ8TVrGBq/jsETaiXR1FgukVIAURNhNNaruBabx0hLt10yQ2gS11+3WOUXONLVk+JrXzYRSTbRAoXz4Foo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999275; c=relaxed/simple;
	bh=KvOj9elpd3Jkkeq08+mMPj08ZLLt/WtGD9D/KXwwPtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lgn21lvpuRKsSXBvGfbZVgkRUGpGWiMyE9MxAxYc49dMFX+3R7W3ADfD5x3SIP+CwPO3pTx1FOYFod7YOUMJmXKw++IwbybG75PgnNU5Cmt1JLsNwDfbMc+s54BKwI1FDGs+4+BZ1D9srxdmt0DhJ96cFn+YPfxMn851NNr5hzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzHpeQw7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzHpeQw7"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c3156e7705cso222640166b.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999266; x=1792604066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VIDYdGNKUB1e/3PxpKxX9vkb9H1F2shBQcc4U18udes=;
        b=rzHpeQw70CqFBH5BcQnWgLlrhk+PFdX9s+OfBP4OoFXBpjRsgGfcoocZzeaBWIej/h
         xkFTtxg9ZlIporAcKwrgHJ9U3kaDqSjvsgkMs1OHSXKwoFzofgGUcDGMGyI0Dz0ot/jI
         Gm+iNu/mVyZ/YD0W/i70vGNrLGvz1Mzj3VW+F5CqtaC+SpJb52wRdkdX3C1QoeoDRhri
         ahSuK/QGAdZMlYYJoYmNjSG3dnjYIfe9B7aX5OL37/AwFeB9pURU0gcYDZw4a2564DgI
         JtAyRCpxuydiovLOux1fcg40pO2dIYCedFW/esgLmfm8QjM00fBeZSQzEXj6x5NPzZW7
         Ye9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999266; x=1792604066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VIDYdGNKUB1e/3PxpKxX9vkb9H1F2shBQcc4U18udes=;
        b=QPg/vtVOlw9SXx66UmQcxbRriTI4CXTQFa/GftiATXVWQy54TnFLXovedw3K3X2Gwq
         3Ca34WaF1vG4FZR4tyZikfMiabwpA0kaCO3/RLTtJZKw1+VBEid0m3s09HyO5sHSvC5H
         wn965aL/HgVQR2F6OlnnOCzFNPBFiw1mPfA/Hcw21oICTc4RXXkXmSvz8oU7Hz/xNJqI
         FMEjXlCVTQ5BnlUuNrHr3VnU4jxBH6S61LQQJ2GFqf/kCKKF5OTE9sAVa7dYzqHY0ZpY
         ilQC3HDJKah2rdSrmr4kNzrMlBx39w9wTH+WHd4LkIBeQPBTFSuflExJLOrdvb4eRabq
         RLvA==
X-Forwarded-Encrypted: i=1; AKwUvBxvfMPMbrQ0ZGmKL2HUbEx6+SB37FpRnGwqtzC//Z8NYDU0t61IYgvc+F2nqvO7wUMfbHEocTM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbfHMr1D2Qvledu5mFu/7Dl5nFKCMrFhzKp8aQHiIzv+Y1oMGw
	0mEUal0kju+nxJ4KEbdqeIEOhsZBLIfJlWPRYtqMTBMXQo16slkpJpwTrzRmBs32
X-Gm-Gg: AYBFou1xQa9Ax0yiOJdXGSvcvbTKcfTtRICUBa5T+8sz85vumuC2MVVacxDYPZUP9vk
	f3J0Uv5bjZFJIfxWPME4lpprJ3QNF1RkIThxxWkYkOiJp9SRdeHT1+gvHEy/8oHL2nh2BIR2z8I
	r1SyW3Bmx72k/VQbTt2uzPKu1nLVJkvEYZwtTrUOkfIb/C2l9mJT2hCGrJcWP8VzGoJxP5lqxqd
	hDAaPKbC86ecwyEJ6HBiL0ZMn4z3AoAr8NP5gs4E8pyx5ticzHeFrb3MBrJ8a8rWCFP0ng9X2v+
	MvQVxJ+xerSucl82Mwcj8Tvbyg8ztpqQ6BITHskP44PB3gcb7wJLgfD0givqwcT6YiW6XHtvdVZ
	ynyUBsuSgt2GKk4OzTkVW/zCbbbjfo6gF3lxcfkCN5nCrg9ojpg0fx2QzLAml3sEv4MejG4Ugiw
	zdZ8UfbnY7S9ekyIqJ0M+WUjyEKotn6uNn+CqrKeE7+vyjlNJhhjeTVhfsqTG3K3ShT6jr3tk9G
	Ljtlebx+I1v9TX5
X-Received: by 2002:a17:907:c613:20b0:c33:dbe8:291c with SMTP id a640c23a62f3a-c33dbe82d08mr732381966b.20.1791999266201;
        Wed, 14 Oct 2026 10:34:26 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:f08c:65a8:f8e5:f310:5a71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963cecesm9381366b.21.2026.10.14.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:25 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:07 +0200
Subject: [PATCH v3 08/11] hwmon: chipcap2: balance regulator state
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-chipcap2_locks-v3-8-27ebfc2c5b9e@gmail.com>
References: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
In-Reply-To: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791999252; l=2089;
 i=javier.carrasco.cruz@gmail.com; s=20260924; h=from:subject:message-id;
 bh=KvOj9elpd3Jkkeq08+mMPj08ZLLt/WtGD9D/KXwwPtw=;
 b=QBCfaQn7DzynwXDeiqhHQI1r1lSPXZSFg54KCEy1PoEQxlhK7WhZEOc26YvOQVA2c8kZYJxqz
 pNulMyiwcLSBvv2Z/jykYA5tIosoMDoM7BJ1wPJWMZdnNghuaalLfbf
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=VV+hcMoOj1Sx6xSiY0W/FZNAskGZe2AagSMVj0PsmAs=

The current implementation does not guarantee that the calls to
regulator_enable() and regulator_disable() are balanced.
regulator_is_enabled() might return a negative value, and an always-on
attribute in the DT might break the symmetry anyway.

Add a regulator_enabled flag to keep balance within this regulator
consumer.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 837b1830f2e4..952789fdb9db 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -91,6 +91,7 @@ struct cc2_data {
 	int irq_low;
 	int irq_high;
 	bool process_irqs;
+	bool regulator_enabled;
 };
 
 /* %RH as a per cent mille from a register value */
@@ -120,7 +121,7 @@ static int cc2_enable(struct cc2_data *data)
 	int ret;
 
 	/* exclusive regulator, check in case a disable failed */
-	if (regulator_is_enabled(data->regulator)) {
+	if (data->regulator_enabled) {
 		data->process_irqs = true;
 		return 0;
 	}
@@ -132,6 +133,8 @@ static int cc2_enable(struct cc2_data *data)
 	if (ret < 0)
 		return ret;
 
+	data->regulator_enabled = true;
+
 	usleep_range(CC2_STARTUP_TIME_US, CC2_STARTUP_TIME_US + 125);
 
 	data->process_irqs = true;
@@ -147,11 +150,16 @@ static void cc2_disable(struct cc2_data *data)
 	data->process_irqs = false;
 
 	/* exclusive regulator, check in case an enable failed */
-	if (regulator_is_enabled(data->regulator)) {
-		err = regulator_disable(data->regulator);
-		if (err)
-			dev_dbg(&data->client->dev, "Failed to disable device");
+	if (!data->regulator_enabled)
+		return;
+
+	err = regulator_disable(data->regulator);
+	if (err) {
+		dev_dbg(&data->client->dev, "Failed to disable device");
+		return;
 	}
+
+	data->regulator_enabled = false;
 }
 
 static void cc2_disable_action(void *data)

-- 
2.43.0

