Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E53B4EAB
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 04:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790482321; cv=none; b=J5PZVZLzJZYY7YN0C33lmUFnwacuTHhwnCPRmeRSBnhbWTIiutBffLl9wwCsUqgKrgPTDhFRQ4OVpPLy28gOhwlrSF+hM7J1CGVXFLyDsEci6R7zX0LfgzCS4RV1MGPCJb1rnA/WHZUQQQAmtJ0/jeC3wpXa+K/Qy8G/cAqw6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790482321; c=relaxed/simple;
	bh=HXf56oErQjQG65q13Yi3D6/ymaSMnfZ0TRs868zw6dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwrR+FEbv5vB+nf61M8G4/cbnoXYqofl5yKHn/y/2C/D7AECRuGF/WLx8ID5nheb7bVfQsYVRSwXe30QVgzDFAnkYVR7z9hm0nd4mr0J2uRxIm2DLpOY1FGTfZvfG+XXMHS5SGGFewZHDfkjZ0aq95WuCzYlOmG3bcrgthfIZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jv1FSGnJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv1FSGnJ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so1093734a91.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 21:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790482319; x=1791087119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxqqTfPgcHP/3UHVQZ7AF9YfTUK4AxdRSJHHLinpKho=;
        b=jv1FSGnJlCYeY2be6O2/+m/tRzCawJZHqRX0Yoqz1+4vbwoBqTaXTpqZBl7HTmw4Nm
         lnkA5NOKfE2Y+Z02MujdEOzb01Hg+xuQPuSMIAttFi5REt5ADZ6d9OgJwo3gZGO4I4Hh
         49XSohY7CmaEd0LUJwuavlAC0Pg4QdMg6qlnCdb+GYgSDeZ/O7jqRbLtimWgn9ImBmZs
         n+v+d+66dQZwAth+0fI1uSvqzC7gfY9eB2lqjK1ySLYBfLjvDXSAW2Wbm81+Tqjfw/yf
         sCFyL85JUPHoxRnSy84rJJjqmCiD0JCBoxGDRjrDB48T31GBh1N6oDRvKGETR6gNljBc
         gTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790482319; x=1791087119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YxqqTfPgcHP/3UHVQZ7AF9YfTUK4AxdRSJHHLinpKho=;
        b=IDlnU6FQOgN+3gR9YawdpGk9qDlJNn7+Njs/rpVMCgq93k3tzTeY/YELh434tqkZEy
         L+KacyAfgGORkatpjZCuYqmeJ44p75JzPx1RZJs9SQeK4zERqhcdB1FeIp1cyRppO0NO
         rajAS5DrSrY6KqYc9PW16eVWbQQV4a1D+FLPc5QSZni/3tyrJB1bsGcFT+WhlykzLL5M
         BvBGEll91qnRE+jau45X2+4XSzjc8oNXCR1mIu+Mlfvk+6QgNdutS77Hnm0P+5yehPnM
         icH4y3xzNrGTGvD7aCxlET7hh+lU80ZHTMBZ/SakqYQLRzDDWl8eOyZS5FvojRAQSByS
         BRnA==
X-Forwarded-Encrypted: i=1; AKwUvBxE4AxmSjj/dJfwKBBR3UTHPs3DPiDg4s1x8/ITql9wuxvLwQ2SAUwlYH5clCJoUvx7Cg3VgZg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKfSKiae5PuZ0Xvo5CDqNEysIZiaeCp/6CQgIvLWoZEyC5iRTO
	MkcUVigotIWz1XHkwVmh1YUUq2Aa8tMPgca2rlz9qZyzbc31+hojSX9K
X-Gm-Gg: AYBFou0oknsCSGuvHKdFntFXQR9VnJHDdi12LpkEUn+pjBUkU9P65vUwNlrpMGV2+yd
	utm4BuXMosCpIsHfFuyJg6O6B/cInUVlKQPLRue8Tx+nCpjU5Fgm7gWHix+s1+EKrG6EIFBV+Qi
	PMijWDrp8hHz+GITQZbZAkuxyTmH/1QPp/29fqhv9lF+NX5T/wc2U6wJ223vJTWgsBAF95QyTAf
	7s+qk9bZuwWLBUNCCM6gZqGoC/nZz9mGKcK5MbGAG/FxXcCwhz0Gd79/MGfLi2zHPTOWpVEjj7k
	ozpjHGOVDxARc3wwAvS3hJV3FClHdq2N9UEBqzWPtu4XW75QsNdavelKtQoF680kFjo3QnP520T
	7DjNGOlhR0katusO3xnHm8+nI4DhIiNx1Al0Y0KEdu4BFlGmGQ0CO8VPl9qUnXXQReBGiP0cqdY
	n1cOOHFFSvNFD8lCNJtL0IzqcJzpDqKlzisgOqhsJSuOW88Z3T+0uB3tnGdyXr/bdCzfw1BpEZu
	VO+i/kjovPoZy/JmKnR/emr169Ue0CXGw==
X-Received: by 2002:a17:90b:4b0a:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3a0985eb6c7mr8588729a91.24.1790482319266;
        Sat, 26 Sep 2026 21:11:59 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4f6345fsm5542732a91.1.2026.09.26.21.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 21:11:58 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] HID: wacom: check the input devices in the Bamboo handlers
Date: Sun, 27 Sep 2026 13:11:38 +0900
Message-ID: <20260927041138.4112920-6-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_bpt_touch() takes both touch_input and pad_input, and
wacom_bpt3_touch_msg() and wacom_bpt3_button_msg() take touch_input and
pad_input respectively, none of them checked. An interface that declares
only pen usages leaves touch_input and pad_input NULL on a fully
successful probe, and wacom_bpt_irq() still dispatches to these
handlers.

Four locations fault, each reproduced on linux-next 20260925 (x86_64,
KASAN) from one /dev/uhid device plus a single UHID_INPUT2 write:

  wacom_wac.c:3100  wacom_bpt_touch         touch_input
  wacom_wac.c:3117  wacom_bpt_touch         pad_input
  wacom_wac.c:3130  wacom_bpt3_touch_msg    touch_input
  wacom_wac.c:3178  wacom_bpt3_button_msg   pad_input

for example, with vendor 0x056a product 0x00D4 (BAMBOO_PEN), a pen-only
descriptor and report id 2:

  BUG: KASAN: null-ptr-deref in input_event+0x44/0xb0
  Read of size 8 at addr 0000000000000028
   wacom_wac_irq+0x8185/0xb3f0
   wacom_raw_event+0x68f/0xb60
   __hid_input_report+0x398/0x4d0
   uhid_char_write+0xa99/0xfc0

wacom_bpt_touch() serves touch and pad in one report, so its two blocks
are guarded separately - an interface with a pad but no touch must keep
delivering pad events. In wacom_bpt3_touch_msg() the slot lookup moves
below the check because it dereferences the input device itself.

The touch block of wacom_bpt_touch() is reindented into the new
conditional; git diff -w shows no change there beyond the two style
fixes checkpatch asks for on the lines that move.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Fixes: 3116871f4273 ("Input: wacom - split out the pad device for Bamboos")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 56 +++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 11544adb74f5..dac67885f81e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3118,31 +3118,36 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	if (data[0] != 0x02)
 	    return 0;
 
-	for (i = 0; i < 2; i++) {
-		int offset = (data[1] & 0x80) ? (8 * i) : (9 * i);
-		bool touch = report_touch_events(wacom)
-			   && (data[offset + 3] & 0x80);
-
-		input_mt_slot(input, i);
-		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
-		if (touch) {
-			int x = get_unaligned_be16(&data[offset + 3]) & 0x7ff;
-			int y = get_unaligned_be16(&data[offset + 5]) & 0x7ff;
-			if (features->quirks & WACOM_QUIRK_BBTOUCH_LOWRES) {
-				x <<= 5;
-				y <<= 5;
+	if (input) {
+		for (i = 0; i < 2; i++) {
+			int offset = (data[1] & 0x80) ? (8 * i) : (9 * i);
+			bool touch = report_touch_events(wacom) &&
+				     (data[offset + 3] & 0x80);
+
+			input_mt_slot(input, i);
+			input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
+			if (touch) {
+				int x = get_unaligned_be16(&data[offset + 3]) & 0x7ff;
+				int y = get_unaligned_be16(&data[offset + 5]) & 0x7ff;
+
+				if (features->quirks & WACOM_QUIRK_BBTOUCH_LOWRES) {
+					x <<= 5;
+					y <<= 5;
+				}
+				input_report_abs(input, ABS_MT_POSITION_X, x);
+				input_report_abs(input, ABS_MT_POSITION_Y, y);
 			}
-			input_report_abs(input, ABS_MT_POSITION_X, x);
-			input_report_abs(input, ABS_MT_POSITION_Y, y);
 		}
-	}
 
-	input_mt_sync_frame(input);
+		input_mt_sync_frame(input);
+	}
 
-	input_report_key(pad_input, BTN_LEFT, (data[1] & 0x08) != 0);
-	input_report_key(pad_input, BTN_FORWARD, (data[1] & 0x04) != 0);
-	input_report_key(pad_input, BTN_BACK, (data[1] & 0x02) != 0);
-	input_report_key(pad_input, BTN_RIGHT, (data[1] & 0x01) != 0);
+	if (pad_input) {
+		input_report_key(pad_input, BTN_LEFT, (data[1] & 0x08) != 0);
+		input_report_key(pad_input, BTN_FORWARD, (data[1] & 0x04) != 0);
+		input_report_key(pad_input, BTN_BACK, (data[1] & 0x02) != 0);
+		input_report_key(pad_input, BTN_RIGHT, (data[1] & 0x01) != 0);
+	}
 	wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
 
 	return 1;
@@ -3153,8 +3158,12 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 	struct wacom_features *features = &wacom->features;
 	struct input_dev *input = wacom->touch_input;
 	bool touch = data[1] & 0x80;
-	int slot = input_mt_get_slot_by_key(input, data[0]);
+	int slot;
 
+	if (!input)
+		return;
+
+	slot = input_mt_get_slot_by_key(input, data[0]);
 	if (slot < 0)
 		return;
 
@@ -3196,6 +3205,9 @@ static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
 	struct input_dev *input = wacom->pad_input;
 	struct wacom_features *features = &wacom->features;
 
+	if (!input)
+		return;
+
 	if (features->type == INTUOSHT || features->type == INTUOSHT2) {
 		input_report_key(input, BTN_LEFT, (data[1] & 0x02) != 0);
 		input_report_key(input, BTN_BACK, (data[1] & 0x08) != 0);
-- 
2.53.0

