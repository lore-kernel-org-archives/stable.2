Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBEE387566
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346669; cv=none; b=mQxSRLXx363Xmd2+6Z5GfZmQBEQitwAHsy3VMtxps5kILZTF6AdneXQg2RhJCgWgETJXmBXFcV6kZFoJQMI3OJ2OGPp4nJ2FVkGPgMTO0AfQW8L295iCYzNZ7C1NUlS/tvt6Kxwf7AvtG/vANVn/1gqt2kjKX9tqK441aCkrndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346669; c=relaxed/simple;
	bh=G8py0KfqTCUThOelxLCduHUIUi1Im6OxQnN8n8LKgdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0g9evkXia6Qb0sWQsx0xr0T8xCwKlCpX63m79Mf6t3G/UAD7/jbbSisekrUHrBpOoAoacCHGQ96N0T1qDZ5zUYUXRKpOKVhbmZ707GNaj1jyrmJ8PIoir7a/yFzso/bkI8QFOOr/N1xolTxM+arrou+y0GXIrZ0yn9Y+KZlL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8dZQz+8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8dZQz+8"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1133978a12.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787346667; x=1787951467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CU1oP/ljlYx+FVX14t93B7e35BUmi8NVJJ5FxmAJfS4=;
        b=X8dZQz+8ob8TBEAglcNHwCSbz2hY3zGwqtd/rynrRJq5sT6MBvyuqp87ITMzx5D6FQ
         uh/1UiIhyuOb+sNHN49eNQmS4eXQtzBuxPvjQFJJ8QfVafLPziOcvjlLArHrC0HT2wbY
         4lT+qMazTQY7EblfgKGd/GtjOC++67DZLEpJdb4y7m4p4hJbizQQOBSm/gBgxeJ1Rz5l
         830c7ECts+mFr3yNRUYzSwdkKdaiOliguyMEJaGg8l5SATZHrwE6CX1+/q/gzGQcy9Yf
         2tBHZBNw8WKMnKq5jbx6B8kX4ZT/rR2eRQIkEcOpmNmGeBsSLJ2ju/n+pFz51gpBvLst
         Ro7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346667; x=1787951467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CU1oP/ljlYx+FVX14t93B7e35BUmi8NVJJ5FxmAJfS4=;
        b=BKWjpJ8SiFyowcpPmS30+xfzfabYit8HDRqCzXae9Y7xfsNQw1MH/gvsfcDMKS20ws
         dRwN8dngvw/auFqXkzWUBgA0tf7fsw2j9BEc+5IzddxWxjL3h5VsHaK+jcOTOflnltmy
         OO3GfRehL1QBDLypEBhMEHQWhw0eS2KJTDRa/H6Zrie9QVRZ07yTkCx+bCN3iQwRondn
         T6iRC44D/Rd48q9OyR41CnUXoZ0rRvCWJevTIhmiv4pMZAC3DNrOlyFAypmHY7TKMbeY
         U7mJWY/7ONHASfKkS+EK1yQrY+3PHLc7IfWWHv9a5BPJInHq/3G5XQNiaqEbz7wnp4/T
         HWNg==
X-Forwarded-Encrypted: i=1; AHgh+Rqpirgbn2lW58cIihUDhZTNgMrm8Yr8SrexWM+vSsh3uyMCZ+wNwUlWsj53+sQPgwKj6fMU7Bk=@vger.kernel.org
X-Gm-Message-State: AFuF++kv8fvIam0qcbyIO/tSE1Fcf9ODXfHgR+L9eLHUTHSDyEm/LTfb
	8Gwn/xGvLJUFaqhkm1YPQ8OojZEhn4CTm3D9ZYJxHANxRmL9XfLPB/Vi
X-Gm-Gg: AR+sD12+bcPBmU9F31Oc7YtSQ1gjDMFkwLmO9/MhzCXmmuTGy9FKvMPyhL2Z9P1BEIE
	go3x6ugpBNuiEvlBt1wae66jHfViAEeovA8flJetb+UO6seRIRfxA4OeiWemK8T9Lo9FmifKxvg
	YEQzp/MjwQPYiMXGDLe5zobSXei8MdH37ACApFCG5NTDK8XlMsyBj5SyX2BLwcnKo/D+2DYdSDB
	twphe4fgswbo7IYSW/bBZwLpgAy0CKIT1urPAUUx6UUJlyY+a2k9Ksl/waI+2v2b8LWh2JJvkbO
	QfSkHP21fqn0ZxqJlQPPrwdysOCYBVOjP5P1ugqZx2g+C99CGHfXzr0liQlZAR6u1N8PRdHrb+g
	8WGO/i52t7qqsTKVOtvVQi0czRSuVazkYLUgjSVxXi4jQxCkWcp4E/RPzS/DoeCrO8FbB9lMyd6
	AJUAeMEdtWS19v2u1536tlDNkTfTm0fUo3VeMhdSj34rSSF8ohzXTWuWN1aHyZU9yznTapIfFiA
	4t71PA+HmbCoy9dDj5law6PGIi8XR6aovcjloQqJlZ8857nSv6r07bUdRGGPxxFpLR0N0VY
X-Received: by 2002:a05:6a21:8cc9:b0:3c3:a3f4:5485 with SMTP id adf61e73a8af0-3cd4ba0d216mr3000476637.6.1787346667011;
        Fri, 21 Aug 2026 14:11:07 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:194c:dba4:ea1e:d7d1:affe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm49755257eec.26.2026.08.21.14.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:11:06 -0700 (PDT)
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
Subject: [PATCH v6 03/17] rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
Date: Fri, 21 Aug 2026 22:10:18 +0100
Message-ID: <20260821211032.13554-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5->v6:
- No changes.

v4->v5:
- Added Tested-by tag from Wolfram.

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
index f81d691c8b9a..56284a4320ae 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -261,7 +261,6 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rzn1_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time, tm_now;
 	unsigned long alarm, farest;
-	unsigned int days_ahead, wday;
 	int ret;
 
 	ret = rzn1_rtc_read_time(dev, &tm_now);
@@ -274,13 +273,9 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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

