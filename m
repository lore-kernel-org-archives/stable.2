Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D1448CE9
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764480; cv=none; b=kDAwa0Atlz2twH15Kl+kJPqNdvh70/2wGUaY4Tx0ULUBcyS1p12THgUAr5B5j4yYGztN8vFK8iBAQyJ0JEwZnS5OUHOs47ghJ3a7PX+hgipAMt0nwZ7v52ljiSW2n4IA6Riwxsj2vWQyPezuK+zdBalQ7bVE8f5omUPyz9HCPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764480; c=relaxed/simple;
	bh=dnGSLQO8Jqf7f0eRMp8QEkoMX2MpDOOhmcc4mISFmzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dysx9NaS1M1U5BhNNt36ZXkPwCxeopI2siPCHTqUQkmGPEnoZ2XvjEzwJkPNMuAighvxvHigIg3CToaOPmn4jAJnWkRWieWeu0V5XKL4iSUiiKhmAX/78CkUCrpVka22MQTAJd1PCr6ztigGyRBJIMJgLSwOe6hXlyCGVY5Kn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAa54eTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAa54eTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43521F00A3D;
	Wed, 26 Aug 2026 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787764456;
	bh=8ICNYT/hLXtaUAMCuHnahepNLmx3KvC3HLTtKNgh/zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IAa54eTN8E3N/6xMjVxCvq45AdjCXzxstOOeaIpBufgdrWbIOqcFqE7nUiUyB2giX
	 7UoJ6rPVW7RGblsOcDL9p0YJwWu6J2XKQK0afEhxEPJcjsYpfg+wcMM3YlZOsHuFoO
	 O4LdtNSLZ/golb2IeH2/Mio8mI6NBbldrgX0RtzmB62VPy5uV5xGSf4WfQhQ8wtWOh
	 jo3Qm1s4s7sDlPwJ9larvaHHddFip++vg72tVpaTU5vvbfIRxzyD/+2ljErQQXNHAJ
	 6iZzz+Ias2YTCgcjO8EoblCUk4aZYAC+ojjvaU5iHzAIxQ8aDu/ErjmDBL6nUBWEyP
	 by/C4NA6xWdnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] HID: input: use __free(kfree) to clean up temporary buffers
Date: Wed, 26 Aug 2026 13:14:12 -0400
Message-ID: <20260826171414.2246040-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082541-tightwad-rinsing-012b@gregkh>
References: <2026082541-tightwad-rinsing-012b@gregkh>
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
index 32a96ae2946f1..bc913110fda6a 100644
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
@@ -1832,7 +1827,6 @@ static void hidinput_led_worker(struct work_struct *work)
 	struct hid_report *report;
 	int ret;
 	u32 len;
-	__u8 *buf;
 
 	field = hidinput_get_led_field(hid);
 	if (!field)
@@ -1859,7 +1853,7 @@ static void hidinput_led_worker(struct work_struct *work)
 
 	/* fall back to generic raw-output-report */
 	len = hid_report_len(report);
-	buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	u8 *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
 		return;
 
@@ -1869,7 +1863,6 @@ static void hidinput_led_worker(struct work_struct *work)
 	if (ret == -ENOSYS)
 		hid_hw_raw_request(hid, report->id, buf, len, HID_OUTPUT_REPORT,
 				HID_REQ_SET_REPORT);
-	kfree(buf);
 }
 
 static int hidinput_input_event(struct input_dev *dev, unsigned int type,
-- 
2.53.0

