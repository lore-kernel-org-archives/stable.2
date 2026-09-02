Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8E93ED132;
	Wed,  2 Sep 2026 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356671; cv=none; b=iqykzoZsMPs05sV8dTr+BhTkyK+EtMkFZrTCA+s3PY+d+D8uzWU6C5oyR0DT4LIQtEZ0k1W2EiJvzDNPvpNy7BmKvEG2c6APYnAUn83E4egFRO7w/gFo80oCRYva5mD2Z9y8XTC0urjEo1DAbOOV15Esuq1VMpn8/Rpr0NMMZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356671; c=relaxed/simple;
	bh=ksvCi63HmeF28t1aPHlaRQrZsVKHit2sBcQsud5G90k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SurYjEoHu3lyNdLZ6wbRtgqXX1qzjm29AD+/yyA5jv1gd3jIsTgAwqO7M2FeIeLBH0SrEaP3p6daS4RJ0wpZpAJH7+3bwhrnADuMwjyu0lBVPkMXEpuEBtlqzVnd5i4Chn/vksGAfd7R77mDzNrba57NZUuQTStDY0iDISNl3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUjI2kPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUjI2kPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE3F1F000E9;
	Wed,  2 Sep 2026 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356670;
	bh=3mrhjEbCA/sWTy8TbRa0j9ysrsB6kLYB42LNQFHC884=;
	h=From:To:Cc:Subject:Date;
	b=OUjI2kPQ3ARXxcyHu6c+PgWhpCouhE3F7kp6xn7PRGOMGcAEPUoPysnBKCrzxjqLf
	 tsjVp4OLKJXUAXRdI8WvlruMi+pfVusvxz1OdSkwId6ywb7DbotE07FtfQ000vBeRx
	 GCSPthh8pgRso9JtX1iyDvKlmVxpG1ayC/hOIiztxhqVNb54nNL5W+1q94DA6OiYRm
	 GFgGjqRGzrdfGcUnFUF64rFOS/na/DxJsCaFF7D9k+1Lf4Gm2MVJaJPRBM5S5NLLkQ
	 yx7897gaLJ/8/SMdqNOJzSuE802J3QhQGYvDvDQ84oW6ZjqJiSwibJyUsFRp97tjJN
	 0d4Jwww5czNUQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v9 1/5] HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
Date: Wed,  2 Sep 2026 13:44:01 +0000
Message-ID: <20260902134417.1270552-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the lookup-dependent 'wacom_wac->shared->touch->product' references
with 'hdev->product' inside wacom_setup_touch_input_capabilities() since
'hdev' is already available (via container_of) and represents the touch
device itself.

Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v7 -> v8: New patch
v8 -> v9: No change

 drivers/hid/wacom_wac.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a29bf051ada7..4436faf2d2bb 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3953,8 +3953,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 					 struct wacom_wac *wacom_wac)
 {
+	struct hid_device *hdev = container_of(wacom_wac, struct wacom, wacom_wac)->hdev;
 	struct wacom_features *features = &wacom_wac->features;
-
 	if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
 		return -ENODEV;
 
@@ -3963,9 +3963,11 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	else
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
-	if (features->type == HID_GENERIC)
+	if (features->type == HID_GENERIC) {
+		hid_dbg(hdev, "generic touch setup\n");
 		/* setup has already been done */
 		return 0;
+	}
 
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	__set_bit(BTN_TOUCH, input_dev->keybit);
@@ -3997,19 +3999,17 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 		input_dev->evbit[0] |= BIT_MASK(EV_SW);
 		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
 
-		if (wacom_wac->shared->touch->product == 0x361) {
+		if (hdev->product == 0x361) {
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 					     0, 12440, 4, 0);
 			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
 					     0, 8640, 4, 0);
-		}
-		else if (wacom_wac->shared->touch->product == 0x360) {
+		} else if (hdev->product == 0x360) {
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 					     0, 8960, 4, 0);
 			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
 					     0, 5920, 4, 0);
-		}
-		else if (wacom_wac->shared->touch->product == 0x393) {
+		} else if (hdev->product == 0x393) {
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 					     0, 6400, 4, 0);
 			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
@@ -4039,8 +4039,8 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 		fallthrough;
 
 	case WACOM_27QHDT:
-		if (wacom_wac->shared->touch->product == 0x32C ||
-		    wacom_wac->shared->touch->product == 0xF6) {
+		if (hdev->product == 0x32C ||
+		    hdev->product == 0xF6) {
 			input_dev->evbit[0] |= BIT_MASK(EV_SW);
 			__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
 			wacom_wac->has_mute_touch_switch = true;
-- 
2.55.0.966.g6673acef38-goog

