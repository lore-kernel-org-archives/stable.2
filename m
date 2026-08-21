Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91FB494A08
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320617; cv=none; b=lsDh2VKBVJqmoG9G9kAAZlJLfyEcdIDkhiqVe935hg98FeGTJYhAjBZBmLruk6IXO6J4Aya4wmjx1MaRy4mh43cKvNogTja620q7iF1u6wEFnegOcYlYnHWMZVjUyUFyJE8YJVVNxARCjTTFGU2icklUo+UoUh/6l/x3zZny5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320617; c=relaxed/simple;
	bh=UTdaoDgRCp5m/9ZYPIxOt/TUt2k/3Iv3XjJlMaJ38PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNulYke4yaXbqBYy5hOXXO8fer86bw9L9fbh45m0ZzKI4TVkVV7utrxCIr4JZi7YxKQbDIqBvUjHLTOzmT+qHWiFjR0xnVkY/IdBGnin4IBGrvL4LlN3X6i2cL7toOoWA4Nh6P4NQcCoH3f63bLjPM7Ty0i1FmPu15EOSbMgrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP7LBz99; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP7LBz99"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso948836b3a.2
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320615; x=1787925415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIn/JR7QSML3LbxalAPrR4Gs+07rBcCA789wVYtHyok=;
        b=SP7LBz99tQGWq5iWJtd6FvXFClJQLZm4iULsiJcipIxbMwwVBOwR1DgTxTRYwpQtSx
         uzPOpOM3/7ZB4+Ygzbe2lREPI9RVwA5nt5ZtXPdHWR9DIdorTpDUR1TgxqdZ//MB3/qq
         vf4yJ5TXlFvuXGjR8kkGfyn1a6RqifzzafkRcLJgCqiKfiwDjGWliDiKxeWMaXdxnSGP
         NPQXhwBBPEcWMlOR0QEMbc0RoqPCJmlbcspKTdS52wVYYh0FCVoGN/fFmQAT3OvtXQfE
         j0yCMSqrXOSXwngKt5ZqOc94lJ+vqHo23ao3T0zdAXhJwjF+2e06aknPU++bdwfn5L0p
         Bx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320615; x=1787925415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oIn/JR7QSML3LbxalAPrR4Gs+07rBcCA789wVYtHyok=;
        b=gJ5dnDsoxdvdQrA58iNNQiYz4g73oJfFyY4UgVySFCgn55pPdrPp/m/xViGi0a/EuF
         6KZHY0TGDu0o9Y35sz+niA6nYz7nv2Ewa7LAMFiG5Rb/mp2ewzbCr6fkn29d8ftOemKP
         UrV1+0h0tt5GFdvmkZKeG8lDdHbnyf+4C/2cSAz/BzBxrBiAB+Ky8wDe/FGULHsDesQV
         z66jDJLh7Q8/3+qeKStAm1mzGs/Oq7CpwivWacMkFifelnCLMFSaRGny2wHgidffaYJZ
         c5HIDphMmJToWsy85B0JQ6YEpvro53ZJzqnU4wi7mL/wMxeMlzufx9kowEc3Fds/lw4B
         fQ6w==
X-Forwarded-Encrypted: i=1; AHgh+Rr3+8kLQ3g9FkTCAm4LVh7yPxE7S4MjiD8h+sCVfSjckKXovjVFVgFLzWVsL0qDXRyxazc8vPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykTjbgwSEk0FYi44or3Lq4myjOTGHmUqwWdCgGsl9DPu2cVqv3
	oilHe4apytiiIErTSCxABzcPU6BbgVsu5NT1dRLSPX8m5wLCwQ3FlX3z
X-Gm-Gg: AR+sD10vCfSiqwAmYsxOgOSGBMb4Sw8neElzFb9PnWbysC0HgjsOpGXWFXeMRbtDImg
	2n4YzalWx/tcXFje1Sd7286r0MPbiihcyyA+fYK4Ixg8LiZX7xw/wxkpFYDnWqYe480bHkv+Lmz
	jZDmRJ5a36Iy0TY10agDmeOyCsRGdLX1IMGnj7sdaryGWdOxtgbzJxlRmU8rh/syL4TBXlwKbZ4
	duiup+fuHTs4rRZck1CiFUHUdopPxv3Gyjl8EbHJC9n5hE6PxDEmDDb1wXYDh8yC1UeYNkDGhaB
	9NNtA5vZp1546LLXkGdBzomkP3sXEwna5hvgeHIu1BkhFQdPqAZGUsShodnrVbUjdf/f7695WdL
	U7H1MsFrEyaxLihaMkpm0jKO7dXRNsyyCNBWVy08JZu/GKtjh95bWgM4FeZSB7uqo1GYX2Hb49u
	XLqnit+yy7e9oGh2F9cgj4tPY+xPCJPrgrpXLiQmbDfGXlPpN2nsGi9qjC9ZxMwsYmnmb5/W9Zm
	4oxSRkzytM0XYyjspRDPKR2ZZLW52BEKrHnyMKyFHK9IyY5T73YD3GNtQAei4ap3bJgZ+wlNzbl
	ry7pmj3IIsybHuSCjrRy/Q==
X-Received: by 2002:a05:6a20:ac44:b0:3cc:f008:8123 with SMTP id adf61e73a8af0-3cd2fd9e554mr13238918637.8.1787320615049;
        Fri, 21 Aug 2026 06:56:55 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:773c:1c8c:24ea:eff6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19972277eec.19.2026.08.21.06.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:56:54 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 04/17] rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
Date: Fri, 21 Aug 2026 14:55:55 +0100
Message-ID: <20260821135608.275233-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

RZN1_RTC_ALW is a weekday bitmask where bit N represents weekday N.
When no alarm has been configured, the register has its power-on-reset
value of zero.

rzn1_rtc_read_alarm() uses fls() to convert the weekday bitmask into a
weekday number. When RZN1_RTC_ALW is zero, fls(0) returns zero and
fls(wday) - 1 evaluates to -1. This invalid weekday is then used to
calculate the alarm date and can either leave tm_wday set to -1 or
produce a fabricated alarm date.

Treat a zero RZN1_RTC_ALW value as an unset alarm weekday and return
without calculating the alarm date. Move reading RZN1_RTC_CTL1 before
this check so that alrm->enabled is updated for both configured and
unconfigured alarms.

On a cold-booted board with no alarm configured, the following was
observed before the fix:

    root@rzn2h-evk:~# cat /proc/driver/rtc
    rtc_time        : 00:00:19
    rtc_date        : 2000-01-01
    alrm_time       : 00:00:00
    alrm_date       : 2000-01-07
    alarm_IRQ       : no
    alrm_pending    : no
    update IRQ enabled      : no
    periodic IRQ enabled    : no
    periodic IRQ frequency  : 1
    max user IRQ frequency  : 64
    24hr            : yes

After the fix:

    root@rzn2h-evk:~# cat /proc/driver/rtc
    rtc_time        : 00:00:25
    rtc_date        : 2000-01-01
    alrm_time       : 00:00:00
    alrm_date       : 2000-01-01
    alarm_IRQ       : no
    alrm_pending    : no
    update IRQ enabled      : no
    periodic IRQ enabled    : no
    periodic IRQ frequency  : 1
    max user IRQ frequency  : 64
    24hr            : yes

Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- New patch
---
 drivers/rtc/rtc-rzn1.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 8c70dbf8c7ec..e0fdb591ba91 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -234,13 +234,24 @@ static int rzn1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
+	ctl1 = readl(rtc->base + RZN1_RTC_CTL1);
+	alrm->enabled = !!(ctl1 & (RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE));
+
 	min = readl(rtc->base + RZN1_RTC_ALM);
 	hour = readl(rtc->base + RZN1_RTC_ALH);
-	wday = readl(rtc->base + RZN1_RTC_ALW);
 
 	tm->tm_sec = 0;
 	tm->tm_min = bcd2bin(min);
 	tm->tm_hour = bcd2bin(hour);
+
+	/*
+	 * If wday is zero, no bit is set in RZN1_RTC_ALW. This is the
+	 * register's power-on reset value.
+	 */
+	wday = readl(rtc->base + RZN1_RTC_ALW);
+	if (!wday)
+		return 0;
+
 	delta_days = ((fls(wday) - 1) - tm->tm_wday + 7) % 7;
 	tm->tm_wday = fls(wday) - 1;
 
@@ -249,9 +260,6 @@ static int rzn1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		rtc_time64_to_tm(alarm, tm);
 	}
 
-	ctl1 = readl(rtc->base + RZN1_RTC_CTL1);
-	alrm->enabled = !!(ctl1 & (RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE));
-
 	return 0;
 }
 
-- 
2.43.0

