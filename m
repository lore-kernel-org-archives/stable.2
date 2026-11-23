Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407664;
	b=HVe+b1s2GuCDNohVUgpttHd2OTL/N8IZt7gK3th7RjSygJG2SFQk8fGWaOVwS2oQcEUi
	 lIM4S+xDGnwR96U8TAidH3XOcji3KhN/eTbzggzd+XEGTZMvuDta43qkCf1qcBjD6g4Cz
	 MZwEBK4RVd9+K4MwAeih4jg4cEHbN3xU+23/jGCw3c5R5aDjKdPMxKRz4CtZVxIveMoOF
	 ts6axsqZOQ4guBVoKSB/sbPsAFjq9LvayrnJRDyVH5aNoGSz2wVxCKlx7QBhiaLHS/YaZ
	 ARjh7EOfN4YUqHe2udKhRJQ9+rqpP0dzQEWpbcVNS/vuW/Neo0BwHYdsZKLz/6YtysA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QM77UDij6XwSYk3JC8OYB2FX+P8AANH4ekRQtOvst7s=;
	b=3p8xBbB69wNq/1DEtWwZdOu+zYhbZU0Vkl1ZOKbU7drwVTB3O/Q4cGdv6UNCsGni7iUU
	 e+P+4cXEUHhhYRDvdRkBKEcpqfUiKDj0Abzznk2mRvherYPjyiAwX2tBykijBZZphDx1I
	 m96exjVdye4Q/QJ1bJiPzEU+dXWq5h9Si7WoQ9SmSNdbhfVLr8JKP12uWoln1LWQQtAeH
	 /Xjw3EYuDXxEDiCWYk0XwYCak9Ah9P9ATSzXOZjrmaXcU5EszgT04+TVQ0frct43V9b0h
	 3eNQucJaieKGq2EE4Dk2+rRb8zM9cR4aVhpGkiWCOYtUSjDhHNSvz0i6ve5VqHLbN8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xgSKbUeW;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7A606A332
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C7A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xgSKbUeW
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b546061d58so6499025c88.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 20:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407663; x=1796012463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QM77UDij6XwSYk3JC8OYB2FX+P8AANH4ekRQtOvst7s=;
        b=xgSKbUeW26WHi5TH0F2XJfhO+bPd4rfB7Ka0bBEdAokxE5ALhDRZQRCs23BnK+TB4+
         B9RHuwDpg7cvN906V9B/9JSxaViPIhXqvIUiy8dw5udSGi0Jy8eBT20fp62KgRTxavnK
         /+fo/FyJVNuIgpdknYbXBJNpx2tUOZaZUChFBqMGeUqydDRyNKAwTzBVufCHnVPDMNX3
         B/jVFAzpfBhjjrvXHD/mQTmd2esv8dqVZIvo4apefaMKbH+NP8wWFs6ZAcasHEpqaBs9
         5B6RmjizrQ+lDQJFhhx0qhOaRIMcxCIOyu4hjYv6oNlP8PsyVqUgasLKRBxTJ6CJ9MBV
         hXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407663; x=1796012463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QM77UDij6XwSYk3JC8OYB2FX+P8AANH4ekRQtOvst7s=;
        b=OV36SlYGd7vynBGQ+gJvw8fgxXW4NoQfSOjbt0cg8X719y1Y5YfM3gk9lo5kEPoMxt
         5plce5qleM1TiRMluzVXH403nNbtAijo2Ib5CQPUBD4cA3YB6c0wqRWR3BZ9VuG8Cccz
         F/g4BqW3xocik43jUCEZ1fXgrfV/tnLV98hx5wgQqjUtHNOK+XvPpabz7DDBStu5X719
         VdGmzCwDKgmxcsa8xxXgKFK9qw4BqCVce3gWRQjytIKBo7KLaYe/q964gLgq1fTys1x3
         XYqxadXgJA3SaoCg1loK8+dO/2XDBBnjCOmqeJSFSUD+KINgXihtqyVGuDXEv0YWwlZV
         dqKQ==
X-Forwarded-Encrypted: i=1; AL+hErHRfbFgG9CF8h27qBogToBdKYSEC71a6kBQQH6NxDpca9uTrsruUgxRC1BXD/K0eeeRLDZsxf8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bQ7deiaK+Jt9mULSdSNyOS9qcJ1KkcfZIlqqpWelZw2kIeTlK
	r1IWd2sxXJjIQMDR+/79kxamplvBJa+VKAD+qWDU86UF7VouNh9FA7YI
X-Gm-Gg: AZFdTZfj9Na8703y666ly7l+gh1eRQj5u2SD0d3bAgHAFFUicps1xludONOU9cpAPTf
	tKoT4GPXYYBb00kmOy/12a9rvYotOdcbxNQyXzOiQcus4Br5fORkZRldvyOgYStGcK3cIwc/bdE
	9dxxxtvucl7tafTsBrHLOlHfQFj7dCMXe1I+1YjOADT28MoBFZQotCWWzgnCyJ+1+ZsTZVxDAI1
	pqjDYpyqefPbVmIMGmNabymYRu3srgrhDbtc0McMaCMCotd3tePR92Td6GC4EI4U/ZWGioq/4k2
	0Cob1n6eOoXYxEcKYYZKwQvOCr48TGg/QZYOxyoqgj4OMX+CLdL5T94PPpiGqX7G3qTyHaBVRvO
	epa8Ww2ifBQzS3c3PPjjfl/RFw5jAcXHB1VJR8HK0GCsfoKSEQbzTAbYcdLoY5K8jdNt4D5hmAq
	jrK6CZ9+2XTIR1ah+H8V1LstFtp2tY3+6r9WplZ1RZ4Z7+/HQIhaVEL49l9FaokvX3mAYbMu1FJ
	wvHV4Z9nXfj7TbZd3bJo55RaI6mhFMdbaxl8mIZHFmNq52iqpwHRRcN3QBw/w90DMYVCO6X8z3f
	v2WAArQJ8BgRsN4O0F5TAaZVlrFKXMsB5NYvtPSK6jXYpz61FsuOUNHQ4txwEAP7PURWq0OMiN6
	BZ6QDOPJrwbxOLz4XA7/ketxK+3Jt8q2xs2QYTV0hX2pDZ7Y=
X-Received: by 2002:a05:7301:c005:b0:386:a0c0:5e59 with SMTP id 5a478bee46e88-386a0c0757fmr6668638eec.20.1795407662629;
        Sun, 22 Nov 2026 20:21:02 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm30804737eec.15.2026.11.22.20.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:21:02 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org,
	"Claude Opus 4 . 6" <noreply@anthropic.com>
Subject: [PATCH v5 2/6] HID: wacom: check the input devices in the legacy irq handlers
Date: Mon, 23 Nov 2026 04:20:11 +0000
Message-ID: <1dd28b561f3380cf3b76bfe096ba676a83f33229.1795405057.git.jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795405057.git.jinmo44.yang@gmail.com>
References: <cover.1795405057.git.jinmo44.yang@gmail.com>
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

wacom_penpartner_irq(), wacom_pl_irq(), wacom_ptu_irq(),
wacom_dtu_irq(), wacom_dtus_irq() and wacom_graphire_irq() dereference
pen_input and, for the latter two, pad_input without checking them.

As described in "HID: wacom: check the input device in the shared
report helpers", a partial interface leaves one or two of the three
input devices NULL on a fully successful probe, and wacom_wac_irq()
still dispatches to these handlers. Seven locations fault, each
reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
device plus a single UHID_INPUT2 write.

For wacom_dtus_irq() and wacom_graphire_irq(), all hardware served by
these handlers is expected to have both pen and pad on a single
interface, with two exceptions: GRAPHIRE (pen-only) and DTUSX (pen-only,
no pad buttons). Guard the expected input devices at function entry,
skipping the pad_input requirement for those two types. For DTUSX, also
guard the DTUSPAD branch in case a spoofed device sends a pad report
anyway.

wacom_dtu_irq() gets a check too. Its only dereference is in a
dev_dbg(), so it does not fault with CONFIG_DYNAMIC_DEBUG=n, but it is
unconditional in the source.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c7bf0e5988e5..d5c2efcc09b8 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -128,6 +128,12 @@ static int wacom_penpartner_irq(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	switch (data[0]) {
 	case 1:
 		if (data[5] & 0x80) {
@@ -174,6 +180,12 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	int prox, pressure;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_PENABLED) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d\n", __func__, data[0]);
@@ -233,6 +245,12 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_PENABLED) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d\n", __func__, data[0]);
@@ -263,6 +281,12 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	int prox = data[1] & 0x20;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	dev_dbg(input->dev.parent,
 		"%s: received report #%d", __func__, data[0]);
 
@@ -289,16 +313,26 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 
 static int wacom_dtus_irq(struct wacom_wac *wacom)
 {
+	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 	unsigned short prox, pressure = 0;
 
+	if (!input || (!wacom->pad_input && features->type != DTUSX)) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: missing input device(s)\n",
+			      __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_DTUS && data[0] != WACOM_REPORT_DTUSPAD) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d", __func__, data[0]);
 		return 0;
 	} else if (data[0] == WACOM_REPORT_DTUSPAD) {
 		input = wacom->pad_input;
+		if (!input)
+			return 0;
 		input_report_key(input, BTN_0, (data[1] & 0x01));
 		input_report_key(input, BTN_1, (data[1] & 0x02));
 		input_report_key(input, BTN_2, (data[1] & 0x04));
@@ -349,6 +383,12 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 	int rw = 0;
 	int retval = 0;
 
+	if (!input || (!pad_input && features->type != GRAPHIRE)) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: missing input device(s)\n", __func__);
+		return 0;
+	}
+
 	if (features->type == GRAPHIRE_BT) {
 		if (data[0] != WACOM_REPORT_PENABLED_BT) {
 			dev_dbg(input->dev.parent,
-- 
2.43.0

