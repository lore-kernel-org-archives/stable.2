Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605223;
	b=jZwG1l0iRLHMRfSoFsRAaX8uVkDPqKzhdjPGqKwKKMdkknvN27tJ0eSVTpr6rDzKG7Te
	 TwQufptLXWEQCszqVmc6KcSLikMPHLI+xOQEa9gI3AI9ULfM8Vrc2dVm8fqLKflKQKZNT
	 Pr0qXHD08pOKhLAB1cZgWJJNOszYtdzCJya53Bg8A1GcCuUf1tx7TVQsJsKydS2rPq3L1
	 fWHQpPS8nqlGa/T4KOjVluWLEJnoBLm5MfM/doAteilwQYiqa+od5FlMNVqB2QCZKqy1Z
	 yXT18owoEthzcxKXvSninx0bhxJVb2cNYrNpBho0ajPYb8i8WxA1eWWQmpmjNdEOxaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605223;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QqDE+TWaESyD6dQ9Fw01nymUxDu4HbdghokdxjFnS1E=;
	b=uOpCvDB4PMWJ9/+1WYG5rqgoGIWkVq8lcWCAq/nLd1xrUx3rM4uO6gzRHDJnAMczN5lT
	 +UzybK73qlKZyu/RgBd3kQUGXEJiMg3NHfYo/1+aYwtqNDlp70Bq8zrtzoILngjU0Tdj6
	 RbwOi4pujuhByBDTF7INvDwR4lhrKnt03eIMx4Ghuvn3h/3PE8l4XPc/ng/tuQTMRbidg
	 HPOtNLTKWwBoa4N1hAuj/oSmrZW2G+JWdolVmdl3kqoS73gG1IRJDMRFpdCV7Z460P0X7
	 K+v/MEkZ24ZGSG9TUXmkanqPaucySQyLwH4a43815rhrx3ly8i1L+BhpW4mcbifO2BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E//vkd2J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE2606A339
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E//vkd2J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102891F000C4;
	Fri, 13 Nov 2026 21:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605223;
	bh=QqDE+TWaESyD6dQ9Fw01nymUxDu4HbdghokdxjFnS1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E//vkd2JL4sNHcBagTDwEz+etiKcQPGLZejuXkZJUIZbkCK7hFy47sKh3Xrci1qJg
	 vMAL+I+QE5RydQFYIhLZIrfolZpYcHYLlY6CSGWSGHumneCcuX4p0Favce09h/3ZiY
	 cWQy7YiXyQsjC/Gf5I9lGsuIlRAT0Xf6kZBAKDnw6hOlKlR6XYmfJpC6GF+/brx+zv
	 L9F7+xA9kTJ/7PmWJktgrMUUA3+kdyAWdW3kvrPwda3u9bR/wDVkyWS+6n8d2Bk9h4
	 Ji5xvOpM5bvQdw8qh3Y9qMMl2kTZ/Mcarl2Nn/rDPKuNTrh1sfNAs77uScoOgtZWmO
	 XDl/PBib+/qOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hwmon: (aquacomputer_d5next) reject short status reports
Date: Fri, 13 Nov 2026 16:27:01 -0500
Message-ID: <20261113212644.2688639-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202132-failed-5.15-cf8f81babd2e@kernel.org>
References: <20261109202132-failed-5.15-cf8f81babd2e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiale Yao <yaojiale02@163.com>

[ Upstream commit cf8f81babd2e96087dedbb74985bc1781c98f73d ]

The HID raw_event callback runs before HID core validates the received
report length. aqc_raw_event() reads device-specific status fields at fixed
offsets, including multi-byte values, without first ensuring that the
received buffer contains every field. A truncated report can therefore
cause out-of-bounds reads and update hwmon state with unrelated data.

The required length differs between supported devices and cannot be
derived from the HID report descriptor. Define the minimum length needed
by each asynchronous status format, select it while configuring the
device, and reject reports that do not contain the last field accessed by
that format. Keep the published length zero until probe configuration is
complete, which also excludes legacy devices whose status is retrieved
through feature reports.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 0e35f63f7f4e ("hwmon: add driver for Aquacomputer D5 Next")
Fixes: 19692f17cd13 ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Aquastream XT")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Link: https://patch.msgid.link/20261021120408.48495-1-yaojiale02@163.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: Replaced multi-device report-size selection with D5NEXT_PUMP_SPEED + sizeof(u16) for the D5 Next-only driver. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/aquacomputer_d5next.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index fb9341a530511..d3a3795c1cc4e 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -43,6 +43,7 @@
 
 #define D5NEXT_PUMP_CURRENT		112
 #define D5NEXT_FAN_CURRENT		99
+#define D5NEXT_MIN_STATUS_REPORT_SIZE	(D5NEXT_PUMP_SPEED + sizeof(u16))
 
 /* Labels for provided values */
 
@@ -86,6 +87,7 @@ struct d5next_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
 	struct dentry *debugfs;
+	u16 min_report_size;
 	s32 temp_input;
 	u16 speed_input[2];
 	u32 power_input[2];
@@ -189,6 +191,8 @@ static int d5next_raw_event(struct hid_device *hdev, struct hid_report *report,
 		return 0;
 
 	priv = hid_get_drvdata(hdev);
+	if (!priv->min_report_size || size < priv->min_report_size)
+		return 0;
 
 	/* Info provided with every report */
 
@@ -298,6 +302,8 @@ static int d5next_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret)
 		goto fail_and_stop;
 
+	priv->min_report_size = D5NEXT_MIN_STATUS_REPORT_SIZE;
+
 	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "d5next", priv,
 							  &d5next_chip_info, NULL);
 
-- 
2.53.0

