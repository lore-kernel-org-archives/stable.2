Received: from va-2-54.ptr.blmpb.com (va-2-54.ptr.blmpb.com [209.127.231.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF44334D4
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837064; cv=none; b=SswGd2ZPdcG0xBKTySZ/fLs/eIe+RJGFMOIKgjnfC1di8L+u02p5bCrGJ5MjkhjzZYv01KQVaf5WMVBdlvAUD4NUueho5wZtecKO9KIJfrnpwCq4FjM32fPNeUDDd+bLbjHCRBEYQMVJbYgEeLMBc0FcKHyplETdam1sMLkngyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837064; c=relaxed/simple;
	bh=PllK0pyn2cHhRpegMjYFIhXeXddygZ0H5loZWAJmlJ4=;
	h=Message-Id:To:Cc:Date:From:Subject:Mime-Version:Content-Type; b=R1GqkcT2KKz85y/vV3Uyubs94BA+qZWgA4AksJ6DwLSjlOmwepZAwBnKxSq8yogX8QfUQyfNnrHzgNKI21/s2tasbtJ7MYSMOclfE5zpn1qZmPmtdtJOIo9T/2xS4QupK+/WLBfKMrECzTFo0M8+ZTP906/ovDew8HgfTjVIaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=kU913vBg; arc=none smtp.client-ip=209.127.231.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="kU913vBg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1785837048; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=93G7QUyO/8KOqjQwFuFq3XJtKN9m29vvNua5vmaR2wA=;
 b=kU913vBg6kFMMB02gdNF0CyRBl2G5zakxgIiz+7vmt4Ru2d0vuA4W0LEPGB+EhBXLGN8IV
 g0+9rwTKFHRsIiOsJKFDOj+t8a0hOPZcMzfmG5vML6pY96jJWUgGeREi/Cyf/gEziqhtiP
 SAOkF0kf8t1eyCCUTpttIcrca8LL7vrcmqq3KP+w33mnMKaI++VozSrMk/S3bnsOXUWOWJ
 ksGWUeYrUSNXTur/59IcxlMeXmDOc0Lznag4pTBuiC2MqjmEC/bHdTiyDHdXyrpj2eR6ui
 tP02Yf6SQlXst5lKzR8sjyWH9PZx8xcFdY0Wk245oZD8jG358JlxI4RCnAevqA==
Message-Id: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc>
X-Mailer: b4 0.14.2
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	"Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	"Zhouwang Huang" <honjow311@gmail.com>
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, 
	<linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Date: Tue, 04 Aug 2026 17:50:30 +0800
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Received: from [192.168.9.107] ([111.40.58.243]) by smtp.feishu.cn with ESMTPS; Tue, 04 Aug 2026 17:50:45 +0800
X-Change-Id: 20260804-oxp-fix-879390c5e47f
X-Lms-Return-Path: <lba+26a71b5f6+e4b66e+vger.kernel.org+me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH v2] HID: hid-oxp: fix UAF on pending work in remove()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-B4-Tracking: v=1; b=H4sIAOW1cWoC/2WMQQ6DIBAAv2L23G2AomBP/UfjwdClcBGzGGJj+ Hup1x5nMpkDMnGkDPfuAKYSc0xLA3XpwIV5eRPGV2NQQg3CCo1pX9HHHa0Zb6NwPWnjodUrU9P n6Tk1DjFviT/nuMif/X8UiRJ7OWtPxho5mIcLxHx1DqZa6xeNvXAonQAAAA==

oxp_cfg_probe() arms drvdata.oxp_mcu_init to run 50 ms after probe, and
oxp_mcu_init_fn() dereferences drvdata.hdev to issue MCU output reports
(hid_hw_output_report() followed by msleep(200)). The oxp_rgb_queue and
oxp_btn_queue workers are wired up the same way. oxp_hid_remove()
cancels all three with the non-synchronising cancel_delayed_work(), so a
worker already running is not waited for; removing the device while a
worker is asleep then frees the hid_device underneath it, leaving
drvdata.hdev stale -- a use-after-free when the worker wakes.

Use disable_delayed_work_sync() for all three in oxp_hid_remove(): it
drains a running worker and, unlike cancel_delayed_work_sync(), leaves
the works disabled so they cannot be re-armed by oxp_hid_raw_event_gen_2()
or oxp_rgb_brightness_set() while the device is torn down. Arm
oxp_mcu_init only after devm_device_add_group() succeeds in
oxp_cfg_probe(), so a probe failure can no longer leave it pending to
fire on the hid_device the caller tears down.

Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
Fixes: e4c850a6e750 ("HID: hid-oxp: Add Button Mapping Interface")
Fixes: 2f424f28fb39 ("HID: hid-oxp: Add Second Generation Gamepad Mode Switch")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
Same delayed-work use-after-free class as the 7.2-rc6 sweep
(hid-lenovo-go, hid-lenovo-go-s, hid-lg-g15, hid-appleir, hid-letsketch);
hid-oxp was missed.
---
Changes in v2:
- Use disable_delayed_work_sync() instead of cancel_delayed_work_sync()
  so the works cannot be re-armed (e.g. via oxp_rgb_brightness_set())
  while the device is being torn down (Dmitry Torokhov).
- Arm oxp_mcu_init only after devm_device_add_group() succeeds, so a
  probe failure can no longer leave it pending to fire on a freed
  hid device (sashiko).
- Link to v1: https://lore.kernel.org/r/20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc
---
 drivers/hid/hid-oxp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 20a54f337220dc2aee3483a14d542b66c487bd60..abd622ff1b26b312ad9c8a4375822832f8371533 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -1501,14 +1501,14 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 	drvdata.gamepad_mode = OXP_GP_MODE_XINPUT;
 	drvdata.rumble_intensity = 5;
 
-	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
-	mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
-
 	ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
 	if (ret)
 		return dev_err_probe(&hdev->dev, ret,
 				     "Failed to attach configuration attributes\n");
 
+	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
+	mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
+
 	return 0;
 }
 
@@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
 
 static void oxp_hid_remove(struct hid_device *hdev)
 {
-	cancel_delayed_work(&drvdata.oxp_rgb_queue);
-	cancel_delayed_work(&drvdata.oxp_btn_queue);
-	cancel_delayed_work(&drvdata.oxp_mcu_init);
+	disable_delayed_work_sync(&drvdata.oxp_rgb_queue);
+	disable_delayed_work_sync(&drvdata.oxp_btn_queue);
+	disable_delayed_work_sync(&drvdata.oxp_mcu_init);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260804-oxp-fix-879390c5e47f

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
