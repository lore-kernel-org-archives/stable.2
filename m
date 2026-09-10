Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87654DF4C1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058593; cv=none; b=JjiFiANRv2xAkAlenSqgY0i4/+IJRCz9ALgzIac6wICeEXAKfkNsWGBRgo+IS20j+huJ8kjmI5e+pqBN4CFuGHAIa/cZ3JRKl4pFUlEypWb8HZLGZ8FqgZ4m0dbvDXc1oBeTSrFQC+Pe8EDnbA46Q/lkyYdPg18nrZixwWTNKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058593; c=relaxed/simple;
	bh=YwJCYTSbHiwAaSDw9EEGHp+rfCHA/qhvKcUvmeyXhjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7xDxLllUAF20D7YCu+0if5+kDwX7o6EOzW3E9rfs7KmqWBEIzksGvg0aTwVRwdGl1bpZqfrR6y3kxG5ONf7gKbe1vr/1jNH2w3dNVGKRSxLskKqlZX6HInskIiMxXV4FcLOCPCG1XbGabvdmKyLUismCw3afgP8YzIUwvLPrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTPVMhe8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTPVMhe8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A1B1F00899;
	Thu, 10 Sep 2026 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058591;
	bh=xyfKuggzdAoa9feCbxYo90knyTKN4nGXHEW8CGES5no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oTPVMhe8EuT5uigfQ8f1HwSWEdV2akbU+3ZXg/cAk74Zo1Ki3rIMBgZp9eJKu+4QS
	 cWrB+jMGwwewAPmsQCUA0pT5X6VhaEFTxuMRomwr+Gsy3JApWOAz2rLBDNaS+1/lhk
	 s+88mD38oKhnzvmkroebQ4De3GPBkiWsMESSq3hcZxnFtupxVB4yQtNVVZgxUguNaN
	 dWmvDA/r/TsQK+l4l0foDKWf3rGDhBS8v9zsR60ZHcz/G2CRSfqiYCyNaOca4rbpBn
	 kn5emwBOtgtJHgqcjAEzmGOnPYHJTwCBaRlnLTS8th1+CtA90mihy9r9VZoD1KP/Mc
	 3xgku0GNkPBMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
Date: Thu, 10 Sep 2026 12:43:09 -0400
Message-ID: <20260910164309.1247063-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090900-ended-professor-5de8@gregkh>
References: <2026090900-ended-professor-5de8@gregkh>
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

