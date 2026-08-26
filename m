Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99BF45FFCC
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766506; cv=none; b=oSokdXpXSEkSy4ebMG25evIfy/pISOIceMYwmSd+T45bmjG3p5s95vcFhHjsjKCRI4SNrVyCva7G1J44hBsaVdL9K/7M0LyxajdGqPYl6yJ2wO2Yiq8bc49PBVWsilghHCf2VTX55aHrHBzObzaI05G6Ek64Vjr/h425OsOtGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766506; c=relaxed/simple;
	bh=TSQirgzf9thvAFSdOo0jIaXAmKOqw3n4K7GuA9TzubA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuVoKIWusQqgEY8OifXM2xLmL1TJ0aQGCJ/WFL6pxojawPwJnVC8Qo91wkdVOj6uM2aIYgeuW/LqQ5NJ0LvhfDt0x2vTNqRhhCJmqzSMxBQmcap8TTIqN46ScToqAYUaoRpM7N6dCE2TxOLZQB5Eb1UCYb29D2ipxcv6raOD0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHuPCoWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHuPCoWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7561F00ACF;
	Wed, 26 Aug 2026 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766492;
	bh=uCt+LJftkTGaWvtS0KhF7zhoRv03uEFImsHb8K0fP1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VHuPCoWswbig4LfAbt3L6PYnYsGDL4adURvW+Utl9Z8iQGgWjTPK5tjPlU6O+N2+L
	 /W3u0sC2mi9o7wh6QLhPj4mBvx9Y4PR/aXD7upg2+zmdG9nujPmn+P2MGS9v84Ezsz
	 /hWqyLkUERnpywFuYeYkjC7/6W+XBQacJk5V48nnkKFVkV7LkqVv9yxAyKYLE17d5E
	 nQA+VkZHxnUVOgisq5sw14tQd5i7EJ37ryWwySiVNUvJAgMov7xPOc1x44bIFrVF4f
	 g8LdL3ogDa5mWWdmGXeIfdx3KTuJLHcAj4Gvaf85VvybEKYmTW655KGZ2GfImKaAbv
	 0y/dv56DE2C6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] HID: input: use __free(kfree) to clean up temporary buffers
Date: Wed, 26 Aug 2026 13:48:08 -0400
Message-ID: <20260826174810.2489825-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082543-penniless-skillful-1295@gregkh>
References: <2026082543-penniless-skillful-1295@gregkh>
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
index c1708caa6b6cc..74d04e5c7f0b7 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -419,23 +419,18 @@ static int hidinput_scale_battery_capacity(struct hid_device *dev,
 
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
@@ -1818,7 +1813,6 @@ static void hidinput_led_worker(struct work_struct *work)
 	struct hid_report *report;
 	int ret;
 	u32 len;
-	__u8 *buf;
 
 	field = hidinput_get_led_field(hid);
 	if (!field)
@@ -1845,7 +1839,7 @@ static void hidinput_led_worker(struct work_struct *work)
 
 	/* fall back to generic raw-output-report */
 	len = hid_report_len(report);
-	buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	u8 *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
 		return;
 
@@ -1855,7 +1849,6 @@ static void hidinput_led_worker(struct work_struct *work)
 	if (ret == -ENOSYS)
 		hid_hw_raw_request(hid, report->id, buf, len, HID_OUTPUT_REPORT,
 				HID_REQ_SET_REPORT);
-	kfree(buf);
 }
 
 static int hidinput_input_event(struct input_dev *dev, unsigned int type,
-- 
2.53.0

