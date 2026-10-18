Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5501E497397
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327705; cv=none; b=a1PXGvexyWI1GhZjWkkqg+uPSzeLU2bT8plsJbhP9L8sOb6ijXZEhUqmVjrIksU6m8gt1n7C8fud00Oxrh1CMP/j7HdtMVBBwtS8wMoEku5c12LPPqzyBDE/i2+5+C/r6h50mtnjecLZ0LZ5rwSJqVxzXXcoUhtcb+S/FT9ywWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327705; c=relaxed/simple;
	bh=lN41a61/nKGGG/YTHpOK/9MR+fMHvrEQ5y32R9jcciw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGTsH3OC7pQcwquJGiA/lqA0fpLSaHlLQiiRb4mJkqMSePJ0wS6fdhx/f1GQNmUUYSwheGiqpOgG/KvSqFe/q1Eb4SiNIl0Akcuisf3O8+dUj9jJEJYacUKe1ocQaqz5k6kdmhgnIoOjVqcsZo5VFSRSHPC6CnVsTqes/eyf2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuNjyExD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuNjyExD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1230223a91.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327699; x=1792932499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CsZ2iMRB1tUMxGPpgV7ei32dAx256Q8EZ78cw7J4Mk=;
        b=UuNjyExDUrlOn6vVkCs5mF5LqDTWLaUF0a6+XMJKICgfPVgdzyshJ+Hk0MCfZ7gk20
         77lHy92V2EdUiOp9H26/E3yTdfdh4cS8VvbRlcmZAMZEJWFmvKBreq3Deg8o1x0nfTGE
         AwoIHCBZZ4xiJnWC6F4mL1awElepMlIaog56Heg4Pn+bkObUVOa4UNiUCNKOZFXUw1Fn
         KLDfOL3PacI9tEBhHue4PC/VlgZr1JUORhrCbQTVVCwqc0bbMKbyIle/aLYKNsABiA2c
         y+fkmNSLzX/q7mkmN0yVyV2qbVrKi5nPYi1yoCvaLdB5bbjHwMrfaOMSVupXxtO/YgIK
         Mm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327699; x=1792932499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+CsZ2iMRB1tUMxGPpgV7ei32dAx256Q8EZ78cw7J4Mk=;
        b=DxG9gDyPjt+BJKDvWJ8HGXVc+LERNJGBB3Gr2tMyq0Fe0Vzf9/t+YcpooFrvlTVHjq
         gUCfLzcTQVbBVy3LunoZLZbFztxOIGbSdxf1mVvz6FsCdJRSW39fo02/Exfs5dBGAbTz
         Yml9qToVf3GoTuFmVmLCbnIR1ssJO9a5iAPNmikfMvvjNivZYBLMCYF/wRu1oUHkx4gr
         EgSJkPwKj0HIK38+dfQmsLBs+jZr+De0dOdfZUg+nqxDa42EDS3caa2VeY6E/rldNthU
         D9xsYZbejeIk6BGl1QuSI/WkXNVaV/4gS0+YwS77LIf4Tb7A6ky3/9OP8zPRTtFSkQpy
         J1+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxymaGrW3le22xnjoOLbgWE7RiayInDnPqAeW9Bn88z7lFbnT6dPBpgpmTP5PHaV4T9L2JVHMk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5iyXCH9i9iXo0465lpUFma7KoTIH51Q6hTBYN30Uuw8tbW0sK
	n6QYDV/CyGAOuLFvlVcLKtUQAv7fZY/HjbkVUgAB1C3ZkdV5+8EQUMxa
X-Gm-Gg: AYBFou0V2Ny+EcaRI4p8wYjBisz2EyV9GYftxCVkt4IoqLj05dLJthub3UXR8i5nFn2
	y9+Pm6lssf1YiB0+oI6kfQFYYVVb5lC9oNgzpyM2FeD6YS0wAJn3KDeosrvu/8q68wezJFsZEuL
	/Bko3GsLFjXaj+VioNmiLyA0/+xMpLf8vx5y0DEMsMbmMwuMbxoe182D4kW9sfGnnJAIqADLwOR
	F4uc2whF9Zcjzu31eZeiq32+rgIWTtO45UAEB+ZpL83JcvwOPAyfTKhY+aw+SUdO08PQyHi1F8X
	0byoO324m5aGfEccLb95oDWJ1DfOKH8tVx+NIyQGTcsbOxFcvu3S5L8CiEBTDUCEabKFSwmbqGI
	Kn3G/KjAczgTQcj7M5L/65ZsqDgJ/3gcT248hgByLXDfnpGAQAU1sbIhbEht3VlO1LzxUaJTs3b
	2WwAfcslMA7ECFgjoHNyq0ZQ6SfLD5La8SL6jnC1zc7rc3XmoYgxVVfxxH/vE5HAh3MTF0xoHvH
	plRnW9FY44UmS98urU2LtI=
X-Received: by 2002:a17:90b:2701:b0:3a7:3474:b1ee with SMTP id 98e67ed59e1d1-3acef11c1b5mr4055247a91.60.1792327698656;
        Sun, 18 Oct 2026 05:48:18 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:16 -0700 (PDT)
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
Subject: [PATCH v3 5/6] HID: wacom: add NULL input guards to Bamboo touch/button handlers
Date: Sun, 18 Oct 2026 21:47:54 +0900
Message-ID: <20261018124755.850888-6-jinmo44.yang@gmail.com>
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
index e0bf03123cf9..a34db1505625 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3151,6 +3151,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
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
@@ -3185,8 +3191,17 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
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
@@ -3229,6 +3244,12 @@ static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
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

