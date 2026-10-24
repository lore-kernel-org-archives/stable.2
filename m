Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812653;
	b=Ix31rScjTDqV/8hoH56IzGWol1EHAoO7bx3FQ+oG32/goq9F7Sw/qOQCE1AfKlrhwwjt
	 ACL8ahg2VW9MN9ZCkEhDkVNBEOByuL7BvmxUcvUcqzGv8hGNWFQkUPoIZoNmg6bDbjt01
	 gAwsfQC99nURUczo00E57H8z+yoZsx7jo0dea0TkVVKgpJbNfHmj2NpDaLv/M9cEYGsKI
	 2EWGWd1ETdfwo8NvoNQf0QhnMu3YYmzkWiDe+qQedsB9LOjU0ocaolREro9QHQWy2ljqy
	 i+lgIfKXooi8Vn2XlrUD7VxuB+w0gZNfe7Nrl5rjj2QzrcH7umYp28F/90cxR4omSUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bjhk5YASASQrh0r4Ye8ElFHJqRenoHts6PBh6/dt8ks=;
	b=mLiFAiDkeWYLG9riAuh3EatbfZdh/MTYFx3iTKbM+yYPrImZaWScPsqTAwSMveJN6oE5
	 3OmsNABaQwN7p+Il6hY3PlHtiK0VQdzHv/S24ln9nyhtTylcFuD5KdFC72AOb9TFmClNP
	 BpKfG6CxwlWNWTE2egp5X0gibLTOSDyHjtdJ+mn+COTTgp4K2ijMsC4TBjx5+MkTxwR4E
	 39iohcQLVA6hrZBoBigzOi/pjRiw46qMX8WVUO5DBohA7O3EJ1IBPkphQWTde51uSEut7
	 5XK8+Y8vcL6VqrHewHR2V07AsKDXib+aTP0OWgPn3n5xFS1SHIse+nkfqqK+uzsqLPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OaYUfg69;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D052606A31F
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D052606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OaYUfg69
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-368581df789so1657996eec.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812651; x=1793417451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjhk5YASASQrh0r4Ye8ElFHJqRenoHts6PBh6/dt8ks=;
        b=OaYUfg69N1J1Iso7WW7ZdQub0LS/FbjQzBk2ABKdo4pTNiWo6tI09IS8IRhvOd4abF
         pLbBjQ8fXiDA3TzwOCuK51w9RcfcJLHQsmUW34gM6cpKsDRue3QGjLSqvQDCcNwMvxDT
         aSiqvir0m0dN7kuglHbZcGA9kM5IRM9NvmsZROdiPbLcAhDyXBK82RSaTUwvOJUrHnjW
         pyblJW2jLR5EZrxRKBnUB07KvRbGZkIBIXMj01B8iYuTl1VPLgHDHFsgIrq0e5CbSG5C
         7bxCSSOF+vw2l+q3RNr0sctKW+XCTPCWDjJK+X1nwLohO8arg3SvbV5fjixlIoR+3Whg
         /WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812651; x=1793417451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bjhk5YASASQrh0r4Ye8ElFHJqRenoHts6PBh6/dt8ks=;
        b=TExjUdUqrQ1f9gFG9NDhMW5JEYn8+Gk04qblRb5E6oDMqIW/+19BowmCTcMRaGp/11
         f8G21XEBQtBl53skuoQsWHKwUbYmnIjE0jLSsahzUlTUe2VI8+IvOtGTQiA04CuTcPUd
         t5vSTWxtEGbrui339fvamLI0DI1HMXB8/my/uBIJDRTwaTxV+QXhJVx2x5T+qdh/TVEU
         9U8/zshNXBmogjNmPNb/5h9mLh5HZYy0FkiIiGxytY7cb5EQn3tcV3EoH4t1FaKFlysi
         oOmnAUQf6iDdT675pTD1pNEiIjjo8n0oeckLj0JS9iNc08IRrSAzyiNnL4U/gPObMXbO
         YH4w==
X-Forwarded-Encrypted: i=1; AKwUvByr/Si8GO98H87v0oyIPi9fYdZaSG/WtGTNV8RdN+oHdZv9J8YYB8SyUqs7D+8o9cRsD5THIGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqhaF3YKAcFiiU7duca4PkV9XS4B3GhuPKV2+D+PBapT5ZH0xL
	Xao7BG0efrhUxKiMPqQs86CSM0nCBXMCanEz/8NTkw6i5Il3sBubff22
X-Gm-Gg: AYBFou0EuV9kXZGisLixMtQDHs1HA2km3is5hYYClNpQFfDW9d/xnhjDrwwlRuyzfoc
	3kUZwsRHwSOUc/inJvTrP082m3gTNMB1GQRCCRVS4lYGXjSMBGx7pjseh9HbJwf90RBTiWEh5ir
	Hw8m7k33TculwfyeLg3PRyfNEIeNzvKhEf6mt/nu8CcT8x0GZO5zH8UH0repbGgn0KaouUB9hAv
	DUOIjyd50MUSlu3Om0k5KpC82Xk9ljwrE8Oxp+u+HYpEHkYE5XHPscijFVhnOLfsCitcDobkksm
	oDW7RGIqEaGZYe82q1TP+kyOLxuyJuy7akuoSUZ7j3ixdT6+RpskLCWi70z3Ob5pBzk8S+UBOWp
	TBBaNOjl9lnQqKtiYMkMDTOcsQzD7LKmSzgU11o1RvM4LVwKktUFHou72EakO6ioZPIyengMHxc
	mp9ADbzMMLEMoq48gDhKFimUwrAW5+LUfvoSXejsv1eGIgwTtKSHdMN1CWxQCUWVTOPEHToWJfU
	sH6NxhFNa789c+S8Z0MNr9vwO4u7MKX3gy62xaz2P63dWP2A533fH+i2bDI1RaoqPZ3sYjMqDUI
	IYoz8spgL5P5Bkfs1uo1loJTCEAf
X-Received: by 2002:a05:7300:f582:b0:360:aeee:9b8a with SMTP id 5a478bee46e88-369e8483665mr1419425eec.8.1792812651295;
        Fri, 23 Oct 2026 20:30:51 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:30:50 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v4 2/6] HID: wacom: check the input devices in the legacy irq handlers
Date: Sat, 24 Oct 2026 12:30:36 +0900
Message-ID: <20261024033040.316652-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024033040.316652-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261024033040.316652-1-jinmo44.yang@gmail.com>
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
---
 drivers/hid/wacom_wac.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 567b01882eb1..bec8dbec5bc3 100644
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
2.53.0

