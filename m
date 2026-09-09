Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDA46AA6C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946691; cv=none; b=lUrYiDKaTkJwywVfrmbFkA7pe3vt3FKmygAQ6HuYiJKXgY5IIywf0Uvnf1ifbsEtpKMGTchvyh/xS7uIAkJySm2a6JxbHG33suOiILaYB1txAsaygQht47Aj+pGh2J9hNz2eVPFCzkXmfitvT1axzXluPGAUpPufKOK7A60gcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946691; c=relaxed/simple;
	bh=TJrBofayrr5IQa0N9BWAYkowtFuvEjjK5Kqy3uoUpAI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iJRq3WSuMjVkRokEAwIOanYLMp5C/Z7eUd8ZwLFZ9YePs6EMKrnoMA+e8V8omWNkY4dH4glm4qtQvrdwTxbiozt3uR0s3EmsgRkulR5Ef9dNs9xSeuOFsLo6UIh14Gj6qZJjmafKxuxKFtpk3y44gukcvZwo3VV5eAC0HwMpeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BjJ4REa2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BjJ4REa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F941F00A3A;
	Wed,  9 Sep 2026 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788946687;
	bh=uE8eb38BXSjHs+uZFXjsJSzYdm6JW945ZQqdizZREJg=;
	h=Subject:To:Cc:From:Date;
	b=BjJ4REa20sDd+gjSUGjEv52qF/7QRIDDPUM9uVvmMNamqEOxdyXzNSlFkAOGIqawF
	 q7mogWwaW3Pmry9OMqEq3rDezRVPI9/hrlnJOseuI+1aEvq0Zkd9PzIlEn4dnpDx24
	 XgkZ2wv6XgzckmNF9JN4U4EUvPqRlUUui7wbQdNM=
Subject: FAILED: patch "[PATCH] rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm" failed to apply to 6.12-stable tree
To: prabhakar.mahadev-lad.rj@bp.renesas.com,alexandre.belloni@bootlin.com,wsa+renesas@sang-engineering.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:38:00 +0200
Message-ID: <2026090959-pregnancy-sliver-04e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 457b5dbce31209e65e1184716ed3af59cb1c0372
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090959-pregnancy-sliver-04e7@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 457b5dbce31209e65e1184716ed3af59cb1c0372 Mon Sep 17 00:00:00 2001
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Fri, 21 Aug 2026 22:10:19 +0100
Subject: [PATCH] rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm

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

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 56284a4320ae..d4cba0d415b6 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -235,13 +235,24 @@ static int rzn1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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
 
@@ -250,9 +261,6 @@ static int rzn1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		rtc_time64_to_tm(alarm, tm);
 	}
 
-	ctl1 = readl(rtc->base + RZN1_RTC_CTL1);
-	alrm->enabled = !!(ctl1 & (RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE));
-
 	return 0;
 }
 

