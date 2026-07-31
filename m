Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57020372B5E;
	Fri, 31 Jul 2026 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481670; cv=none; b=MzZXOWwtEfeNaKIpSZm+MSuwuu4uZmhtadG/7OUu8qRMzg0JrswTWbToUlwy16DMNZYANimuQWPT3W16fzA0Tfb6JdBO2rgtvxczFCVExVlUKWfaksIB/+VHqb0/0WL1uG5xxsLabu6uNnd7kcC1cgB2qTRNyYyWwXotH7ctt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481670; c=relaxed/simple;
	bh=47Oiq8OG+w+OjYYQiWFZiOCnui0yqDOnd2mjMfcETiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdmsG+GDUNAUGKpTtcW3NWNAXTLTcEN91Tvl5eeuxH/I2GsfQbE3ks5jUm1CBSz70IJcIyF6UhcGhvhEhZc7jQZn/EbEyjsjLYMqOy2PLHknPgqwmEDI97kt5isTCyPUtloohrRflL4dOQNBBO5Nb1tIysolxqsAisF4N7diYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GY4gpefC; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GY4gpefC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785481642;
	bh=79W1ViVi75fumG/3jfuSfp8zQq0hxw/soO1tZiCmCKE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GY4gpefCHD3iHAqto3LCDm8ug4BewgokcJ1OFU7DKuJs+9eE5OGEES/XL/RKq/1p2
	 J//7KNkuc/yLFHiBbvLbWT9dRmXwctk9/ZArhmGVf37a8VxP+5m+Ocu2mkyNx6iCnY
	 drmkF7DXlevaHXi+RmzUApxjqSSUUVLiU06U6hHo=
X-QQ-mid: zesmtpsz7t1785481637t1db84062
X-QQ-Originating-IP: ZMFTIrR2AIMnVu0BHEV8rES2vCHnKlBLEGVxVmy8/q0=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 15:07:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7423907543112446876
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: TAD: report expired alarm status through RTC
Date: Fri, 31 Jul 2026 15:07:14 +0800
Message-ID: <8829E8C06120473E+20260731070714.1287959-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M6ndBoZOFDxJ4tzzIIYvWJuJM40DRs1lN5Mi1yN2GdoJlCIZKz9ccri+
	RM/yHPGKtFk4q5V7ZQRczG11QNr/mmwBEvSNNfuyLavfbo2el/YjMhZAJHmOWqzUwM/bFj1
	/eXNFvtURRBIMx9zWfz4Be97DdtkRvl/iB2eAcy6UsXeq6pk7hqafSBfqvc4gGyh9CTvYX5
	gZ7dlKUKpOCh3NqjmLbTQdMA9+aSNxVRrAXLvbUDVjBvLIIRm/Ut1wziqDShzd+hTd14z7G
	MuMEIetoEUQiXkdvo6X1/3kviEibsOeGIxrOrLqC3H/nMasEPCSIj+JZZoQcy0inOPWCdDn
	xpppMboTagfPs0kwen59vgFmyZiK13kg/6ICZYCWzwVxZYJ8OdtyfCivgo7BDpOBY7UfWjo
	X1RCJDPUFQ/NkpgaZ+8+w8A+jG+niiEjcYQDW1wLXBzZNve8w4vsM/Mj2unD9n3NGYwDOq6
	751x1MAMRZyk2O+e3HWO/YKAJ1WtGxFVSFlOhsztSz4ujq1UEAXLgJOHHFd7xfqXtIQM2/Z
	xIWz57+uLJp9oMmSx9ya4HTlmFRdACJtjmwFPcllYwI8e3+FMuR0c2zNMdijDt/8kbJV/VX
	2TqVTKV/HSxvSxuzP3r7jQnops30s1mxz+UkLkZXpDDzCco/OL65diB5GAUari8QBiumimM
	wK/GrTMt8qCgBlp1uEaGqLoJpBcVYgjVuY4eAXaWmGMdceUxef5W0ZCyJRvOV1ZbnktATan
	32w/CxknI1mQ3RaWDfCwX0W7r95VScviEXkkLmMUiKkghYHkVNXFFCO6D5Cfo5Ln93AZnyY
	UPg8d95LvRQAJTL5fCmefqFZ2/EF+INu97tHPuqbILViEUtWQTPHdbKdAJLwNbyDkdRlKIj
	VvQEosv32yGIOZigq5t1cwx5kH5y7hYXNrMtq5a54tIzLKEpxslTjBtQ/7+9n9sKprr0Gsv
	9uqpGhA6a+1AZ6bkAYHmQRrk0jbiHefgtNWyPaMm0jT/XCppB3UI2eNztT7M4DMZ6n65oU7
	ehI/7ztA/M80Y3PhcQuAn8I/IghiqVKSf7Eob5RzcwD2rHQuLA+BGq4ssuTS7/M4gxdysF7
	4ytX+mKD+gk
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

acpi_tad_rtc_read_alarm() always sets rtc_wkalrm::pending to zero, so
RTC_WKALM_RD cannot report that a TAD alarm has expired.

ACPI 6.6, Section 9.17.5 defines _GWS as returning a DWORD bit field.
Bit 0 indicates that the selected timer has expired, bit 1 indicates
that it caused a platform wake, and bits 31:2 are reserved. Therefore,
only bit 0 maps to rtc_wkalrm::pending; converting the complete _GWS
value to bool would incorrectly treat the wake-source bit or a nonzero
reserved bit as an expired alarm.

Read _GWS for the AC timer, reject values wider than the specified
DWORD, and report its expired bit through rtc_wkalrm::pending. This
matches the existing read path, which reads the AC timer because alarms
programmed through the RTC interface set the AC and DC timers to the same
value.

Fixes: 7572dcabe38d ("ACPI: TAD: Add alarm support to the RTC class device interface")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/acpi/acpi_tad.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index fc43df083738..610840c6240d 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -51,6 +51,9 @@ MODULE_AUTHOR("Rafael J. Wysocki");
 #define ACPI_TAD_AC_TIMER	(u32)0
 #define ACPI_TAD_DC_TIMER	(u32)1

+/* ACPI TAD wake alarm status flags (ACPI 6.6, Section 9.17.5) */
+#define ACPI_TAD_WAKE_STATUS_EXPIRED	BIT(0)
+
 /* Special value for disabled timer or expired timer wake policy. */
 #define ACPI_TAD_WAKE_DISABLED	(~(u32)0)

@@ -709,6 +712,7 @@ static int acpi_tad_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 static int acpi_tad_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	unsigned long long retval;
+	unsigned long long status;
 	struct rtc_time tm_now;
 	struct acpi_tad_rt rt;
 	int ret;
@@ -740,7 +744,14 @@ static int acpi_tad_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	if (retval > U32_MAX)
 		return -ENODATA;

-	t->pending = 0;
+	ret = __acpi_tad_wake_read(dev, "_GWS", ACPI_TAD_AC_TIMER, &status);
+	if (ret)
+		return ret;
+
+	if (status > U32_MAX)
+		return -ENODATA;
+
+	t->pending = !!(status & ACPI_TAD_WAKE_STATUS_EXPIRED);

 	if (retval != ACPI_TAD_WAKE_DISABLED) {
 		t->enabled = 1;
--
2.50.1

