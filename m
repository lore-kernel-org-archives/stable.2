Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12E3DA7D1
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320400; cv=none; b=m6DhH5TBcUa081t4tZ3M7n0RfQQWnXFeMufLHZvEreVHaEdypjmlSWjnyoZremr3buHwTdzszywO217sBN9RtgVLtCX8mVyTCPT9SZWnOHuoIrokeuhCu9Pj511yAY8E7PWFGsg/yBlPbtHvfgN9z+wOr8CL5ILAJNGsXzTEdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320400; c=relaxed/simple;
	bh=/9jJroci2U2W/cLGUUAnMj5rSdaDkUk8alpovYx9b1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvbM2B1gpBgnMF87TMuIdoqSxRmDoo4cNYH+gLp8CZYWDV8EwRCCqyd4G3Tv/x12XWGrvFPGKw0q5JnhPb7sBPIgqJphyULbX1WOY4yyienmdwrktWJ4NDxL9dEpE32VOPJfDYCkL4ZBSHBiSqYRydoJP4oBJu658bx32nrTUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSGOfGgW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSGOfGgW"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so967916a91.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 03:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320398; x=1792925198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTvdBTA1ASG/CLsQcCPNTtAezqD6MV1QwMPamzS3K+8=;
        b=qSGOfGgWrX6cpb7sKnahvisOstsNgVnUD8wjDv1vX57LGeatjcbNhmleYUXQkxlYBc
         sVcfNNTU5uLzw6D1gH8oGLzMI61RNEYQWzFUYUwuUFmbzWn0znvY10Pl6DuRNmRb9i2x
         9EdQ0To7n4OmXtpfe9n7rWupdCBXvFZbR1jGhUbjXe2v4rZYTBS+4cY8fsPdRL0MQzKm
         C/a+J2fhOOsM5OikGUDrkI2vdsy4/RqEiUBbmnHEOnRLBdojlDwkIYzFdG0PLoXvJFeh
         CdJ8gW7Q2yQElBRzXQ9PMEfgCYENhLksyL5iw7Qz+UiSrpkEixUrZS7ereYrGoDxa/hn
         N5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320398; x=1792925198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTvdBTA1ASG/CLsQcCPNTtAezqD6MV1QwMPamzS3K+8=;
        b=Ih+1MrD6buKNoztkWCb0kuPMWn0QMZBs/vYwYzgdEm7v17NlRiVLJe1fC4IwzLx5D5
         bhF/cT5Cp2pZJ4o9OGImYfbwXpBOAN6imstXzSZV7hSYDGgdeKAzUN1nSKGrgs9B851d
         cGpknQ2d4gfwlk3mWfyHWjSF2KuQEFOs+Dk91zIfbN0JqrRYuXk99/baotdxCxU9ZO5B
         rlNecB9PuwFIGMb2qnFx5g4T63fjSdOlR8YhR2jZOlo5QwrXVCENrl7R9tKI16/ftv41
         mXPZOEzAWStcPWbpEEJR89S9bzPCmyppIR1coMabh6trKyYFT71uKD1mDyJH3jQ6F/fO
         iqrA==
X-Forwarded-Encrypted: i=1; AKwUvBw9qhWgI7ExejNwtvxY7iiOpbj8eCstsBVd5ykZNGj8+kpBblh1Taoi9zCQRZfvZtXwk8S0VUI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwQ8s9YVvkbobWZuu/0th3wxCNGCfIa/l8Yb8MMWGDCSi3z5r+
	CGRaoGGN/IgTE+ojtypjEqy+Nd/hJ5ORO/D8kULbYfzZdScx09qBumwt
X-Gm-Gg: AYBFou3VmSyhQLeWFsWiATdKZi1Oa9KAr9iRzu4X8cjpuAniAI8YpOwS6/zkk+4x+sQ
	b3Jxysy38VmeNZKbNiT4NT236ApvQIpejsynYq/SI7cwbtmYzoU7kK8SJFxxCtVD5Zi+UQreAQX
	R7k071217BZH5sb9vEd7we6wHOKTVfYGymvgfAw6ZOb8PXw6SAn4oDUvagsKpogCA5XR7U2auZD
	W0qF6Ft3mUOKCOrkL/hgcl2W8nYktYwC9vPOzHL6idF0/Nz5DLXD0vAlR0NyM1lJMhYGj7bWrYo
	DjBib4WeA7amf+wDIpH1UZlJ40Z7WgLK3LSrxvDWJH5kWK9qr9dM8r7GbcuaVErp0J2OTlVuFMk
	q+/VzciTxEopPPf78Tf8k6YCdIkUln9GEGSkEFWq2Fi58G2Tsku70PGB9WADKQfaC8hSW8jbsvJ
	4PMBmG1myn+PNvsTmjVRnLMJ2VSmDmIHzMOUrhjzqSjZWbsBsxTHQvchu7uMSTDHLUlcWXtbnB+
	Uu9SQd3mzRo6Ipr8fviOipvXA0Jg0oyKg==
X-Received: by 2002:a17:90b:5825:b0:3ac:7c52:faf6 with SMTP id 98e67ed59e1d1-3acee2963bdmr3584156a91.1.1792320398213;
        Sun, 18 Oct 2026 03:46:38 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a33681sm2949085a12.29.2026.10.18.03.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:46:37 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v2 5/5] HID: wacom: add NULL input guards to Bamboo touch/button handlers
Date: Sun, 18 Oct 2026 19:46:17 +0900
Message-ID: <20261018104617.743771-6-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018104617.743771-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018104617.743771-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_bpt_touch() dereferences both touch_input and pad_input.
wacom_bpt3_touch_msg() dereferences touch_input.
wacom_bpt3_button_msg() dereferences pad_input.

All three can be NULL when the corresponding
wacom_setup_{touch,pad}_input_capabilities() returns -ENODEV during a
successful probe. Add per-function guards.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 12a632ee1cbf..21c2504a085a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3148,6 +3148,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	if (data[0] != 0x02)
 	    return 0;
 
+	if (!input || !pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: input is NULL\n", __func__);
+		return 0;
+	}
+
 	for (i = 0; i < 2; i++) {
 		int offset = (data[1] & 0x80) ? (8 * i) : (9 * i);
 		bool touch = report_touch_events(wacom)
@@ -3182,8 +3188,17 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 {
 	struct wacom_features *features = &wacom->features;
 	struct input_dev *input = wacom->touch_input;
-	bool touch = data[1] & 0x80;
-	int slot = input_mt_get_slot_by_key(input, data[0]);
+	bool touch;
+	int slot;
+
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return;
+	}
+
+	touch = data[1] & 0x80;
+	slot = input_mt_get_slot_by_key(input, data[0]);
 
 	if (slot < 0)
 		return;
@@ -3226,6 +3241,12 @@ static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
 	struct input_dev *input = wacom->pad_input;
 	struct wacom_features *features = &wacom->features;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pad_input is NULL\n", __func__);
+		return;
+	}
+
 	if (features->type == INTUOSHT || features->type == INTUOSHT2) {
 		input_report_key(input, BTN_LEFT, (data[1] & 0x02) != 0);
 		input_report_key(input, BTN_BACK, (data[1] & 0x08) != 0);
-- 
2.53.0

