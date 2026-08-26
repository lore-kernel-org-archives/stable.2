Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31793F99E3
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767437; cv=none; b=kkvzaGX6mlsUZicLPmv+Da3BR8wKwMa7qtfRV2Qd0QXH6xBbdHxzq3+Im2JyLPYR8LAt18QB7K234CXaF6pYPn4ZcvzQKGCDNMeqtA7EcRqQfOZs+sk31qENGYsm5dcIFE4cC3KPzOxTqpCfaQLLPA1l4cYhatiQelhhMP3Jfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767437; c=relaxed/simple;
	bh=BOEbcoYv2e/niC+ffCePgfwcfZv2DojbFYJ1weMtorU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgAeuEDlyf/TWYuzcCpdfN68YAsHJdDgHo9wAO1SlPhiI4AcFFIs5Y/vn+ibHGj1Ak07/G19jVKJRYTQpR4gXYjIoUFJD0e1efCBC6KeGw06aCCX6UBvoD9oix57FpHoOw66z+OW8ohufBkg8RBusjwEfUUAghM2mSw6i02eCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnxMzywO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnxMzywO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365601F00AC4;
	Wed, 26 Aug 2026 18:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787767429;
	bh=lqYka0q5L3YJ7ckH39hqcAIsqL3z8VtGmACDMRkr47w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dnxMzywO3jtJ3KBVH/nOt/7SuX6/qv5smkEluN6IDsurDewLevMRcumgu00VIRe1N
	 ULMnmf03oA1GxhIArcPvgjx05KYv5c1k095VPL8nvVVuHajHs3iXu2D65K6yuGTRSz
	 g6v30LlDTep0M+RBW5KvB1UUTZ3BFnmktsAUx20v1G1mmL8L+wXgcbJ39nMeBYiDx9
	 IEVJ47A6WVLMXP8VCzX9q7J0xhitDZB+rJ1HwBICA+/EygQhP4t4fSfSUlGXdCDDta
	 vpmXp8GHDJo6IinFaP8rfnveoKcqDHetpoGgejPQaAyrY7N6bMs2n2RhbZV4ybmLnB
	 lh2uTG4IkfUow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] HID: input: use __free(kfree) to clean up temporary buffers
Date: Wed, 26 Aug 2026 14:03:45 -0400
Message-ID: <20260826180347.2651671-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082544-slam-derived-8e30@gregkh>
References: <2026082544-slam-derived-8e30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 142068281f5138a9888d488e6911e8d9f7923c15 ]

The __free() cleanup automatically releases given resource when leaving
the scope, so use it to make the code less cluttered with error
handling.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: d07644524b65 ("HID: input: read battery capacity from its actual report offset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7c53a94106169..fb69ffa21132a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -432,23 +432,18 @@ static int hidinput_scale_battery_capacity(struct hid_device *dev,
 
 static int hidinput_query_battery_capacity(struct hid_device *dev)
 {
-	u8 *buf;
 	int ret;
 
-	buf = kmalloc(4, GFP_KERNEL);
+	u8 *buf __free(kfree) = kmalloc(4, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
 				 dev->battery_report_type, HID_REQ_GET_REPORT);
-	if (ret < 2) {
-		kfree(buf);
+	if (ret < 2)
 		return -ENODATA;
-	}
 
-	ret = hidinput_scale_battery_capacity(dev, buf[1]);
-	kfree(buf);
-	return ret;
+	return hidinput_scale_battery_capacity(dev, buf[1]);
 }
 
 static int hidinput_get_battery_property(struct power_supply *psy,
@@ -1811,7 +1806,6 @@ static void hidinput_led_worker(struct work_struct *work)
 	struct hid_report *report;
 	int ret;
 	u32 len;
-	__u8 *buf;
 
 	field = hidinput_get_led_field(hid);
 	if (!field)
@@ -1838,7 +1832,7 @@ static void hidinput_led_worker(struct work_struct *work)
 
 	/* fall back to generic raw-output-report */
 	len = hid_report_len(report);
-	buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	u8 *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
 		return;
 
@@ -1848,7 +1842,6 @@ static void hidinput_led_worker(struct work_struct *work)
 	if (ret == -ENOSYS)
 		hid_hw_raw_request(hid, report->id, buf, len, HID_OUTPUT_REPORT,
 				HID_REQ_SET_REPORT);
-	kfree(buf);
 }
 
 static int hidinput_input_event(struct input_dev *dev, unsigned int type,
-- 
2.53.0

