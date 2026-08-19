Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003B449B37
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136010; cv=none; b=QdJGTpA/MJ9Dc9GxzQrNQcXAXbLYzs626e8nclZjUN82tyQb/rBcfGuxBF/mypLr/51F4LHRGJ4drKEPKAQVHusBJJvvBj9Zpn3G1pWrzCoqRuPuwUVctoO+unehGvA4EKqaZ00FMvGS/s9YnPyRoiOVpNfDQtGRYKMUg5BeP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136010; c=relaxed/simple;
	bh=5fmAaxImXhb9DVCIm6rQf2g2DAKEL8lDwCzTCOBuKFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2p1tW9A29MNgNldnYtRaFL5V+5uT9n9qM0tRxYxdeS9c0hnz98eiBV8P5CuoaYSTOigu+a0hBqc4yzHTubvAifojG+qkgaixXs4BZbe7pkWqtiB0j05Oxo3yLlBpmyaEkrqPjlyjdjTrpDE5teTSF19GJGl7fBYKsAupHNktYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0PrZVgO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0PrZVgO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso844619a91.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136006; x=1787740806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35kkPCJ/2LvdcW4cQVn4DKW/qTDdzoABPZcDG7evXUU=;
        b=T0PrZVgO0rdklDQmpw0xoLn+Ea3FEtRRQfEVgilN06KnmANu09WhO8uQ0/DYof8o7m
         hff/6EPz3gqYREBJGAyyqhNIKdqyhLCeZgs7ioSeU2JMB+2GrDbItgZ7ANHzxlY9UyJc
         P5qds2Ep5yXxOBQTFlcBr8cSunKD9YvJpmYLmrkKi3JbaKLxpEOJ01+2xsnh6/itdxol
         9S24dAm4O692POu6B5anzck6FsMdt/0JCdxaKL8dHugYm4uVeaiwwBRmq9ILuj7nO3lD
         wKWhZAmT3wkAx75zYfD906F10URWzfBY3d5xFEu1Et0Bob8uPLmX/U12KtilG30iuSn9
         hOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136006; x=1787740806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=35kkPCJ/2LvdcW4cQVn4DKW/qTDdzoABPZcDG7evXUU=;
        b=D/4kSARYDPjJzQpq88Imhzu0LhsnWxop3LVl7gHPjkCLhsFjHF9M6j/sSEsskly3LC
         NvV48MO0n0CSXQKraEseJ+z3gMi1uVlhCMVb+UZ7nZTHQZjtmAGQHPkOkoxTEeJJ/Aui
         v7ORZJWY+977km9kDoHcHjX4knR7tNQ6Kf5VYWpUpmslPT2RbHGXOkkWNoEpL8m1pAaJ
         v+PXzUFk10IPTcPp+pYDw1PQjwBQDTMKgsYOAuYR1nw5JY0FSGDsUayM6YRsXi75ETku
         CIZUXYNz/3t3EXpzTiuwneiwGDHDfO4PUsP+HpCY8QANOccLE+mPkptFxeAbdJf0Z4fr
         EsVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgGvWxwop0OfzWrffBl4vGq8bESdOI+qJYhygFFHOdklDhtMmmuKIfTo2PqTKbr8XyUb1QCR8=@vger.kernel.org
X-Gm-Message-State: AFuF++lIy88sCpz8GxBT0TONFWm3RxGQevw3CpSjKhlByAEBPK7kmx29
	8zhnJ5GuiqBpipiPOZGffx4v0ReKwxIUgKfX9/YMGeWfwd1DB2pZNsRX
X-Gm-Gg: AR+sD1040G5lmpQXDC7BZVZ7bNKGNl+uDgsh7ap0n8GW3mq9z/p5AUhbVFFyqRM9JzG
	4ckw+v0/9fRzYWhAYrThTOsZW/gSpCiZ799VbL825+e6o6vC/czPBaDBr1DGL5xMOQqzNuUksmj
	10OnjJUOi8bh7NzEaDiaeYW6y+0YOuqjPN8bN8qTmXnDZroClYxRIFcYJePVCCiLvd7ZJ1X5IjW
	fA8IJgOQi+6niC6WCbapt1DOyHNnAJlX87rYZvwpKXvYNiNFnAmSzeD9Y7COCVG0+AYvrwQDcQv
	SofgvO2L2mTCvdu6QjhkQtoAlnEHaKRuGl5KJg8LQ38ryXxnxmenXIEHq1Gp/uluURvKpl8KjJf
	qHthdRfAg/e/1E46TRU+eEqu6VXrjUbrR5QKFuX1EFASRmHY3ecTo0vD14yfFmE/769/is/ZDGc
	DSJO2e7QJCV0wmxS2FplXBwrOAPVJ8efaSgmp3wZfhJ6Z9y+dqpRLmFIzsbIr9QR1ZvQBQkFRih
	SM9Y2Z2Xj0h9+pPzPBe6bLLIGalGnwRc0gQSkzBl/nVQDHzolWxXt9rmcSgh9vuEQnLV3FsZ/JI
	a78k2wcuEA==
X-Received: by 2002:a17:90b:4d0b:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-3958127d8bdmr6290926a91.15.1787136005521;
        Wed, 19 Aug 2026 03:40:05 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:efb3:a897:a9b5:e171:c935])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm11169630eec.8.2026.08.19.03.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:40:05 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 03/15] rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
Date: Wed, 19 Aug 2026 11:39:14 +0100
Message-ID: <20260819103926.2136712-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rzn1_rtc_set_alarm() calculates the alarm weekday from the difference
between the alarm day and the current day of the month. When the alarm
crosses a month boundary, this difference can become negative. Since
days_ahead is unsigned, it underflows and results in an incorrect
weekday being programmed into RZN1_RTC_ALW.

The RTC core already provides a fully populated struct rtc_time for
the alarm, including the correct tm_wday. Use tm->tm_wday directly
instead of recalculating the weekday from the day-of-month.

This avoids the underflow and ensures alarms scheduled across a month
boundary use the correct weekday.

Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- Made use of tm->tm_wday directly instead of recalculating the weekday
  from the day-of-month.
- Updated commit message.

v2->v3:
- New patch to fix weekday underflow when alarm crosses month boundary.
---
 drivers/rtc/rtc-rzn1.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index aa27ad7f5941..8c70dbf8c7ec 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -260,7 +260,6 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rzn1_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time, tm_now;
 	unsigned long alarm, farest;
-	unsigned int days_ahead, wday;
 	int ret;
 
 	ret = rzn1_rtc_read_time(dev, &tm_now);
@@ -273,13 +272,9 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (time_after(alarm, farest))
 		return -ERANGE;
 
-	/* Convert alarm day into week day */
-	days_ahead = tm->tm_mday - tm_now.tm_mday;
-	wday = (tm_now.tm_wday + days_ahead) % 7;
-
 	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);
 	writel(bin2bcd(tm->tm_hour), rtc->base + RZN1_RTC_ALH);
-	writel(BIT(wday), rtc->base + RZN1_RTC_ALW);
+	writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);
 
 	rtc->tm_alarm = alrm->time;
 
-- 
2.43.0

