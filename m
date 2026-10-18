Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0949BB4C
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327694; cv=none; b=KmPh7s/g0LL2RhI/xKihOmtofDVmLf7nRb2FFXshGjwB8cSR9Jgq0lDW856ANd+IBjvbyUPKosQywL+z0T0lHrUpTqzMPeFH7YuFtH8bwpG6nMtj09NMIJpaIpoJ2w6Ak1D2tCcsqbBH4hGsmQrmypkhbxbkelQd7UDGe0KbtWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327694; c=relaxed/simple;
	bh=HHtEDiwhC/456QFtVdTHrYlbldjpTf9l9yv6EsNsOKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPWOy4XkohsSAzVnnXfj1ytu8h4dR0mc5jFlwx1ahzZJpqY3QehsEuNejW4Ep13rQS6LTuZH9+f3wZBnoUfeazm58n1dzkGrpemU7WMQ8fSgCxsDUHcr1CajNdW9U+cAz/xQyiadWjrsnhN4LZ1WOdA+ZOawI6ZziOkZaBAwEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abzor3Rm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abzor3Rm"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab98332238so1004388a91.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327688; x=1792932488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjhk5YASASQrh0r4Ye8ElFHJqRenoHts6PBh6/dt8ks=;
        b=abzor3RmCbyI2VfSzIFSAZ6Q5D7AQAJLauAJ/FlsTTQ62a/o//gALnryFSjlbIVS05
         kwtDSIrNz2MiriyZ8SFX8bE0XLBLoJ9qFy792CEE8Lf7Zyhv1mbZpb8BpJ+XbfGwfkth
         DbD5CGdD1j4GZjOBmUEW8rqxFz1IXRSEg9qG/D1QAjpAk+gF6B4FQEKJAimGgiQJUFJM
         iylcQjc9pki57Fm/Zu7+7xahsBHvbOgAtVtWxXp71iyBtKahdLnb9d9r+su2pB+qTGKW
         pZG6ZjSJ9QwPxN4Uu6fmSgYqdXTzG6awkxmxSLNujuzSHof1OxtJAoWLwCy5YVdzM6Dp
         Up4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327688; x=1792932488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bjhk5YASASQrh0r4Ye8ElFHJqRenoHts6PBh6/dt8ks=;
        b=rAsL+c5PqCr+tx2kDlG4Wp8kIL54DcY1m1xACNCQl1Zpa3W+9uB0N2yOqnwYPLiZqe
         aVbN0uMj89TeOuEBtFeT2DUky2xs4asB35JWMx6rpzCRl8V/hEBsG9Zd0vQ+B0LOa9KF
         QgOOwyyOGQ5fxKK4Fh8gd6DQ8mRERvFa8VLIDZvv8Uv6DW3Ox2j/nGV/A+PtlmZRgBiz
         B6Q3JHg4snNjMYY/PCgktKziN9RwZJi2taXdXzilFgAEdKf2KHKwqqzAmMeSkM2ydKQ5
         /B9yGDQQY5pVPQ3IXSUvqCMlvdDztk7dW5WdYO7Clw1VhRly1f97t8/nKwmKxo5zrvuh
         rWKg==
X-Forwarded-Encrypted: i=1; AKwUvBxK2zw1kl3Xhv4keLtDDG4VRNzlvRw9SE0eVM3kTS6qAkoA8JK9dqFlEftCubsXmXV9qV4bgCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6xgNnDWeplVGiOky2vyk/JOEVUURN/pCMuaEhYCy46QsmM1wO
	cDh7gdmnGxZSiNJ9ShNfbvKAegfXx93IlbPum4gpmfaokB7KHYER9tCR
X-Gm-Gg: AYBFou34Po4sIlGXWIJnGUdl1QJBavwhIbjBEFR0RGX1tzMMHfaatqDiWdcpIzhxXcR
	8pOYtILE9OLYK+SkZt+s7HqM1W5EBF4vduNc7ioGhZDl7oLbqNekGw346P8fOES2exHYgf/rJgH
	DafHjjUvI12n/nnEXsoH/kRzkracNfwPqiReKCww+E681o69v2Tt7S3jOX04FMdURp/gG0m7FXy
	ANmzq6FJCN8z7q6BPrcYdLwqwPSvlQojzxwLd2uQPomsJLprf+87dMKY6jcp7ZMi4vSmekOha+0
	eYZ/avKkSAryQPfypH7p7U2xgnntIE37GvW3xaNAOMYiF58Tmre3IDrUiUCCsqHG/ykw8doMQ0M
	RvNkvqQhWJtgljKSFka/KW99vrLVOJ0XWysC6f/U/1VhZsE14Cs+/159RHMVAZmiNdhYNCsugXB
	dnWtahTfdUpqgoo/AxpLm9lUeJcLWvcqBSfujut9/47LDpWMyRQTopzp+LKTQKQoywG00rk0qfS
	3sMZEIkMfD6ymmR8I0WrDWE
X-Received: by 2002:a17:90b:44:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3aceefc61f5mr4344430a91.14.1792327687925;
        Sun, 18 Oct 2026 05:48:07 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:07 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v3 2/6] HID: wacom: check the input devices in the legacy irq handlers
Date: Sun, 18 Oct 2026 21:47:51 +0900
Message-ID: <20261018124755.850888-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018124755.850888-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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

