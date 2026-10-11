Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6C4349BC;
	Sun, 11 Oct 2026 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791721159; cv=none; b=lJbFzlS+524Wywvno7fhw+hJBgMOq9wG0T2vqUAEWA+LePl1Yq82/NOt4pqoTUrTHgRu16nCOKZWsjuz6JMsjkxcLOxexYW9JSUpRS+rfmCjgDe7zjzR1mUPNV4/t1s9rFLG9XwJoQuJzyTlLdqSvkZIO29/VdjkEHGbRBkU+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791721159; c=relaxed/simple;
	bh=MbWRlKgJ2AlJCjvXVQFZwh/KRWdQd1c4H+FmNjpJzW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xjd//Ue/ch1TIFzov4q7nRsfdRDxsIgECeqXAyJFMGl/wTIM+OlcPg2i2heN2fDtFwE2+WTofqv0zHffKE9IJ2BMPO1gJyJiRFsFOB0wrbLYZlyLN66dKL/a8Z6phFsFDDNLu1f8qJCRVQ3kQ+ZNa1tv7zOlognOfthkxO4nJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V7UX0nh+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V7UX0nh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=QCqtaZNs9+FSdR166uxtT7B6n4OGPOvF4p+wl8RQrt4=;
	b=V7UX0nh+h2pp12s9Oqq86ZRGrhvM7D4fGA3imMv8WKi1LCAQ36z8nt5WcaCThe
	dii7M88/A9KNw5QT1FugOxY8dts+/HqeTwcRYBeuqWKrscZLj7Fxa2QTSw0YOF+R
	twhTJ9464/FDaYcArXHEp39S5qH/ifNCtqa6hJ+PRJU1s=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wA3q+t5fstquMRzDw--.32114S4;
	Sun, 11 Oct 2026 20:18:08 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	alexandre.belloni@bootlin.com,
	mario.limonciello@amd.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] platform/x86/amd/pmc: Fix RTC reference leak in amd_pmc_verify_czn_rtc()
Date: Sun, 11 Oct 2026 20:17:58 +0800
Message-ID: <20261011121759.3267678-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3q+t5fstquMRzDw--.32114S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1fZrykKF15Zr1ruF4xCrg_yoW5Kr1xpa
	yDCF15CFWDCF4UW3W7X3Wqy3WxZr42vw1UKryj9w1I9a4SqFn5JrWkCw1aqr1DA3ykCF17
	XFZxK398ur4UG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUf73kUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9QBNWGrLfoD17AAA3m

amd_pmc_verify_czn_rtc() opens the RTC with rtc_class_open(), which
takes both a device reference and a module reference on the RTC
driver. The matching release is rtc_class_close(), and it is never
called. Every return path after the device has been opened, the ones
that return 0 as well as the ones that report an error, leaves both
references behind, so each S0i3 suspend leaks them.

Release the reference with a __free() cleanup on the declaration,
which covers every return path without adding labels.

rtc_class_close() does not accept a NULL argument, so the cleanup
helper has to guard against one: rtc_class_open() may fail and the
declaration still has to be cleaned up.

Found by code review.

Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for timer based S0i3 wakeup")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v3:
- Define DEFINE_FREE(rtc_class_close, ...) in include/linux/rtc.h rather
  than locally in pmc.c, since it belongs with the API it wraps.
  Suggested by Ilpo Järvinen.
- Guard the cleanup against a NULL rtc_device; rtc_class_close() does not
  handle one.
- Move the __free() declaration to the assignment, as described in the
  comment in <linux/cleanup.h>.
- Cc the RTC maintainer and list, since v3 touches include/linux/rtc.h.

Changes in v2:
- Replace the added goto labels with a __free() cleanup on the
  declaration, as suggested by Mario Limonciello and Ilpo Järvinen.
---
 drivers/platform/x86/amd/pmc/pmc.c | 5 +++--
 include/linux/rtc.h                | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 6792aa2c6187..f96e8a358eb7 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -14,6 +14,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -648,7 +649,6 @@ static int amd_pmc_wa_irq1(struct amd_pmc_dev *pdev)
 
 static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 {
-	struct rtc_device *rtc_device;
 	time64_t then, now, duration;
 	struct rtc_wkalrm alarm;
 	struct rtc_time tm;
@@ -664,7 +664,8 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	if (pdev->major < 64 || (pdev->major == 64 && pdev->minor < 53))
 		return 0;
 
-	rtc_device = rtc_class_open("rtc0");
+	struct rtc_device *rtc_device __free(rtc_class_close) =
+		rtc_class_open("rtc0");
 	if (!rtc_device)
 		return 0;
 	rc = rtc_read_next_alarm(rtc_device, &alarm);
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index c09fc22819d0..0f43b5027235 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -13,6 +13,7 @@
 #define _LINUX_RTC_H_
 
 
+#include <linux/cleanup.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/nvmem-provider.h>
@@ -201,6 +202,7 @@ extern void rtc_update_irq(struct rtc_device *rtc,
 
 extern struct rtc_device *rtc_class_open(const char *name);
 extern void rtc_class_close(struct rtc_device *rtc);
+DEFINE_FREE(rtc_class_close, struct rtc_device *, if (_T) rtc_class_close(_T));
 
 extern int rtc_irq_set_state(struct rtc_device *rtc, int enabled);
 extern int rtc_irq_set_freq(struct rtc_device *rtc, int freq);
-- 
2.43.0

