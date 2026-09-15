Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698A3911D5
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437975; cv=none; b=qx4Z8ibpwy8cdcJPqCdKCva6UmjyeSVlsbP6qBx3GfWPtqV9hV9Gc4W359avYlTxSpOo2uylnrt5eranpYfnggTcGpBzVa92KxyO4yaQFPVaRcIZR/4ZEd8RSTybZwu8t5Lt31I8dGLpzdGVVSz5jzMeQwXgwPl1B9Anjnx5Oxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437975; c=relaxed/simple;
	bh=IsSRvZpTd2ytDnUVH/h7zanvLZg8RPBZ5DIYyIFl5Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+ZopHlfqP/HhxHBdq8eT6XPkSK11+Df6ZeX+VRowczNEowELbH38LVSxqRXQvBRxBbryKYE/rrNUNEhoP5BNtmP+uFMO7jCEUI5zWMk3GJSt9sCcFEMN2Vi3TbHJ6cMuE4rmESS3psLBt/7XzI1DejaAFA28HtrvR13xSuaz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AG3kMNls; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG3kMNls"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcb5cb1so35637576d6.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 19:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437973; x=1790042773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ad5dKOxCgmzRzr/3vr0OMGOG7uBSvPVGD8Z4whsnBTA=;
        b=AG3kMNlsdxOD9XG3KD+NKo/HvJvLb4//Iw4dWZIrQ62VZJgUr6gz6T3LJawwES2F6W
         LbMJjSoe/IMZK6UhIoXiHaZvZvUrisihzv5URSB24WrTuqCV+RWuG0Ut57TX93WD1M7W
         KiWUPhKjhmxqsdxKT2gwUAuLM/LjDbh2j4hnZJd5pNP/EtgsvmFfftle40YxAiVhzX7o
         mLOadgQwZ6+KOoEbf5OI746/yFknYtlllv6WSwJ41Cia92CUuWbvGplnV1djBOx9dWet
         cNaA1cBIzDuP1u6RTY1KSUAWpDjbRGVt6gM7nrHHKIHnGggmA0/nFA/FWOf5CgGI1U4c
         KuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437973; x=1790042773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ad5dKOxCgmzRzr/3vr0OMGOG7uBSvPVGD8Z4whsnBTA=;
        b=unmZLr+pMg1ry6xbqSF1L5bhA3qbBE8gRDdc0cb3PyX8DRPjl9C20TwxjqcDMWzo/u
         tK3Y5/gPHrPoj0E3IEl3kzZAODvX7TJjg32FshN/dQAdmXTLZt5hSee8hDQekiEHhNEr
         CB01/O1leAxBxseLfyXUCFr1ebQEsFZvf318/v1IyVk5Er6/S8/3ZaHk0N6p+8MeFsqh
         q7rbNAIfLZP1GtMWcyAIXH1R4ExBPt37kNsZKcMLbKewIRgZEIiL0qskPOa6A540lw5o
         vT98BHvOEe2KUVb4pZxsvlmeUnBKAnPYd7CA15IVaHV4Y7O80A0hBrDmIul26e6iVhlS
         Emug==
X-Forwarded-Encrypted: i=1; AKwUvBw1d5dThag8VA7sw96b9qpjOpWecmsYxaDKdBFYZ6k80ACHnA0x9BHtKfFPDksRE6lydLmU2uU=@vger.kernel.org
X-Gm-Message-State: AFuF++loX6LIPrTEYMsPmSaH2DYQR6Q8DepayIIV9/zEiLheu/0aojuw
	tFZ/K1X8DfC3RoVnlSkRdIZUoafI0/e0OU4YzrYlRhaRrf+D/XMgl5Y=
X-Gm-Gg: AYBFou197XCD9yrkDmWkqGT9AgW4A1v6J3TfvkIzW9HPzBt983+5a9s3ICW5ERw8JT6
	ebmh7aXJ2eosuK8U+LLFgwosopZFMVMuMB+mm1+RyCya6y3afcqG+8mxzHjlrbZrlHGGslQb99D
	LyQGwh2n81TaRY9ANd56wLa95bvNtm7mXBQB/5X/euIN+XPh05nbESo4Gb/kizpHzW5rSU9vrXF
	mBhOFgfuXDaXDe5xlSYOvU3KFPE9i7YR56DcA/etjY6OEUHTMp5L0zjnbrMLkzBev8BDHBvY3cj
	d4wnWRhoSX5J21iqoop2MYFbjOf6AvQD03vnUjO/muHfqw3ATvCtQxDydAlBxWiCDwqLLk/2rGu
	sRRfBUR/Ok6+TFdRAKL0t1HHX5Sznf2mHoYjBgCehqq9N69uKcpcOsevdaU4aOWsyJ+H72YquoK
	sj50JzBeDBlWfjrrEYu4/9Rbojy52u0eAUfY8R7vseXzuV8R6Zp3THGR72NUl9o2GRALVQIThsJ
	IPpxlfoAA9nwCBfTwb4o2wGSSCEUfzJhpPjq+Aikl7+EnYoQlOs3462GD+jDJXH24GFfij+4qny
	6/msugJqJgkOD10bSFLovUSPEvTAX8L0JbmJeSMRiTex0aw7aR3hjf0pIJYxseMswBFp8g==
X-Received: by 2002:ac8:7f81:0:b0:531:179e:ea4e with SMTP id d75a77b69052e-531179eee80mr50338711cf.31.1789437968264;
        Mon, 14 Sep 2026 19:06:08 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45cb06sm109618956d6.11.2026.09.14.19.06.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 19:06:07 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jan-Simon Moeller <jansimon.moeller@gmx.de>
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] leds: blinkm: Remove sysfs group on allocation failure
Date: Mon, 14 Sep 2026 22:06:00 -0400
Message-ID: <20260915020600.91955-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_multicolor() returns on allocation failure without removing the
sysfs group created by blinkm_probe(). Remove it on this path, matching
the helper's existing LED registration error cleanup.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 56e8c56c9af0 ("leds: Add multicolor support to BlinkM LED driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/leds/leds-blinkm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
--- a/drivers/leds/leds-blinkm.c
+++ b/drivers/leds/leds-blinkm.c
@@ -691,8 +691,10 @@ static int register_multicolor(struct i2c_client *client, struct blinkm_data *da
 
 	mc_led_info = devm_kcalloc(&client->dev, NUM_LEDS, sizeof(*mc_led_info),
 					GFP_KERNEL);
-	if (!mc_led_info)
+	if (!mc_led_info) {
+		sysfs_remove_group(&client->dev.kobj, &blinkm_group);
 		return -ENOMEM;
+	}
 
 	mc_led_info[RED].color_index = LED_COLOR_ID_RED;
 	mc_led_info[GREEN].color_index = LED_COLOR_ID_GREEN;
