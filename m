Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE439FCC4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057913; cv=none; b=lL6d4ACYWVZbNLQfpRrBInlTncDpVR9aFCW0JXi5wCXnLtrRXW6vN/Du2myVYx2pmwnYoP3I+XwuF4jMTQ2FWL2f/MuD/pS07LALpNWoe1fCsKTRBEzh0/GdJoro3Wzww7ea9uybS5yvnM0OEQVoAJkal6jTesF0qvciWCREefw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057913; c=relaxed/simple;
	bh=YwJCYTSbHiwAaSDw9EEGHp+rfCHA/qhvKcUvmeyXhjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FanEamCstm0HIMw+vpYI5z0if8M6bQX6/Q3fPD52J9f7I+RAwHKkdnf4gUsOZArqXYSj1eCZFySTgajnJXrevvIzv2p9ggdJ5fpAae1bUbFd+xr8nMDGTNYvKrVPnHRCRZkR19drL1aYGyspzIqy6t+ATekwljq3hb7VQy2+VXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClJmGDdH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClJmGDdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5F11F000FF;
	Thu, 10 Sep 2026 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789057901;
	bh=xyfKuggzdAoa9feCbxYo90knyTKN4nGXHEW8CGES5no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ClJmGDdHuvUJtzDVc2pllooZy1MgQNuUZ1riDQOZPyGf8c9/yIldqqLmRZu1Wfyzd
	 G7RjbPO2/q2+kYXYkoEYwpaQCjRJ3/A9YMIM3GDnse6dJEQP0VRYXTXNBzR2ULtgN/
	 2FT/yudzy0YpDW69MY38VA8/3rhz9TdVdfxiLLV1+KVTX3V8iTJ1E9R5tS/krvg9yB
	 ORV8b7oo8GR9mJDiW/cIa3BR0mgWWcN9JDvzW9yTP50VIaP7xo6Jc/Pn1zTJJjPmTu
	 4wNDXt4WQhyINnoMup3FrSwXveWo5qUK8yTPghsZEiEeFp+92Xlsni+B2IkfAm60EG
	 ATnKI11B+ch5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
Date: Thu, 10 Sep 2026 12:31:39 -0400
Message-ID: <20260910163139.1221060-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090959-pregnancy-sliver-04e7@gregkh>
References: <2026090959-pregnancy-sliver-04e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 457b5dbce31209e65e1184716ed3af59cb1c0372 ]

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

Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[ retained the ALME-only enable check because RZN1_RTC_CTL1_1SE is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-rzn1.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 8570c8e63d70c..da1b7087b2d9e 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -193,13 +193,24 @@ static int rzn1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
+	ctl1 = readl(rtc->base + RZN1_RTC_CTL1);
+	alrm->enabled = !!(ctl1 & RZN1_RTC_CTL1_ALME);
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
 
@@ -208,9 +219,6 @@ static int rzn1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		rtc_time64_to_tm(alarm, tm);
 	}
 
-	ctl1 = readl(rtc->base + RZN1_RTC_CTL1);
-	alrm->enabled = !!(ctl1 & RZN1_RTC_CTL1_ALME);
-
 	return 0;
 }
 
-- 
2.53.0

