Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A044A3EE;
	Mon, 14 Sep 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388443; cv=none; b=WI/Adac+91mxT0PQXYuXQTnCcEXQiimtqEOCoUifx51k5WMRD4Cu1TLoHZfUmG2TA5S58QLfCzzXh9vP6d1/z7nuvD+vzvuB+4t5QWneQm5MTeUl6mBuhUAnv0rWXIJZjeQDC123LeWQgWrjcq8iSFGWay1OxOWVjHC4O/fVqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388443; c=relaxed/simple;
	bh=hwWkisWLlLusvjSZQIrnfsUO9jlrzZuQggkbRQCAwyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exGrY/lf16IpKhSWuvCJPDraTXK85K9wv/zvJdXZwMdQ5iY5i5H8euMwXzDylOTD/xNWW5H4ixit8k7Q1p3zEUHcHD/39jbif7e9MyJb7CE095QSm6/kdnjPnIW7oeAV8H8sHY+s6RysEGNqHJFQ4XP8EkyMTtqoWa3RtnrX+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=An7QFAlL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="An7QFAlL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SN
	hzxEUzDCQXbgYBwDxyzQSJpg8CNd9acZ+G4bYi7uI=; b=An7QFAlLFwXTMZF1nd
	iBTtokiQ0ozyO/9loqN6Tn4sSyNaM6itzlhoNcEzFdhUhqHThcMt2iIhaEB9edAj
	DXo5l8UP+pdqXMTW9U4a2j2f+ldvhKxT/NGsycfHcEtUwB7HyFGcLGNM3agf4etY
	HPmMGMJOgsZ5b3ds4Fk2i6EcI=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnL1Rz5qdqIOaXAg--.9654S4;
	Mon, 14 Sep 2026 20:20:10 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mario.limonciello@amd.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmc: Fix RTC reference leak in amd_pmc_verify_czn_rtc()
Date: Mon, 14 Sep 2026 20:20:01 +0800
Message-ID: <20260914122002.1701233-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL1Rz5qdqIOaXAg--.9654S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW7AryxAw4DXF1xJFWkJFb_yoW8ZrW8pa
	1rtFyfCr1DCrW7K3Wxt3Wku3WrZF1Ivr4jkw15Aw1fZ3ZxXFnIgrWFqw1YqF4kZrWkurWa
	qFZ3Ja95WFZ8WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUfcTPUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC1BpcZ2qn5nqyBgAA3Q

amd_pmc_verify_czn_rtc() opens the RTC with rtc_class_open(), which
takes both a device reference and a module reference on the RTC
driver. rtc_class_close() is the matching release, but it is not
called.

Use a single exit path and close the RTC there, in the same way
ntp.c:sync_hw_clock() does with its out_close: label.

Found by code review.

Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for timer based S0i3 wakeup")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 6792aa2c6187..543bd95e4766 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -671,33 +671,41 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	if (rc) {
 		if (rc == -ENOENT)
 			dev_dbg(pdev->dev, "no alarm pending\n");
-		return rc == -ENOENT ? 0 : rc;
+		rc = rc == -ENOENT ? 0 : rc;
+		goto out_close;
 	}
 	if (!alarm.enabled) {
 		dev_dbg(pdev->dev, "alarm not enabled\n");
-		return 0;
+		rc = 0;
+		goto out_close;
 	}
 	rc = rtc_read_time(rtc_device, &tm);
 	if (rc)
-		return rc;
+		goto out_close;
 	then = rtc_tm_to_time64(&alarm.time);
 	now = rtc_tm_to_time64(&tm);
 	duration = then-now;
 
 	/* in the past */
-	if (then < now)
-		return 0;
+	if (then < now) {
+		rc = 0;
+		goto out_close;
+	}
 
 	/* will be stored in upper 16 bits of s0i3 hint argument,
 	 * so timer wakeup from s0i3 is limited to ~18 hours or less
 	 */
-	if (duration <= 4 || duration > U16_MAX)
-		return -EINVAL;
+	if (duration <= 4 || duration > U16_MAX) {
+		rc = -EINVAL;
+		goto out_close;
+	}
 
 	*arg |= (duration << 16);
 	rc = rtc_alarm_irq_enable(rtc_device, 0);
 	pm_pr_dbg("wakeup timer programmed for %lld seconds\n", duration);
 
+out_close:
+	rtc_class_close(rtc_device);
 	return rc;
 }
 
-- 
2.43.0

