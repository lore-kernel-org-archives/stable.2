Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21837702E
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787518483; cv=none; b=XunPmS3svrW57CZn9fkIs5uFFdOwMJAhHSzb3byx+AqXV9gaM12tbz1yWHZRELMWJicCkUSCx8yem3iaP7Qc0xT5BjzfpdvA0CJCfaFOqeIDBJf2gzT57jkHt1amgkgyG5+Fyi4QZsmf8UBRf7CU88SwT5lGLdqT2QCOfOjeEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787518483; c=relaxed/simple;
	bh=NQ3gSn7f4Sc9GWPgOARPeIhfgUQO1XOcAQm+A2lDw1o=;
	h=Message-Id:Cc:Date:Mime-Version:Content-Type:To:From:Subject; b=Qn5+dqfch70n/0Tvo+b2fSPIFgJonPMpl7m8Yvqa08Fa3pCaZ8iIq/hCyA0XhNXXkgDCOHkeVFrwDIeOiBhYwbtR4WQ9OyXLhn0QHjIB7g+HzR/U73kYEQYefDf/bwFDs63Y/GLXGXnyhSaB/8u9w/khGLe3y2hi8gTvjBiYaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=aZ7I1tQB; arc=none smtp.client-ip=71.18.227.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="aZ7I1tQB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787518472; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qFO7/IC8gRg2zShor8n25aOk34rPV5Z9xdvOOakIZuw=;
 b=aZ7I1tQB6fxcVuzMpTqnF5brz4fWK/mKcI4zg3SUDJBHajZD+BWTmEmIjYAtaz9wvRyqZq
 njfIgmtXfZu3cUGIdz7sC00rGPxihCVpNyOIMxamRxDU5h15cxnAeFRWUF2mdVrYjKgu2O
 kByG72HlMp9DNXd6cnagoY1jXinU2BI6QueTsBWhRI/uJik/EpHhKJhutaW+5voriFVLYw
 qVydX3ZNom2uRrJYeMHRGygFzZ/n2VdLNEhnhr5IwSGr5/KWc7Fap0n9+as7YXHWmf5HF/
 YI2bu1pewp5iJ9V8Q8FXLhdj2DBRP9lLce57xcrBy0A0bMPbAMazcXR6wAvDtw==
Received: from [192.168.9.107] ([111.42.148.29]) by smtp.feishu.cn with ESMTPS; Mon, 24 Aug 2026 04:54:30 +0800
X-Lms-Return-Path: <lba+26a8b5e07+92e10a+vger.kernel.org+me@cherr.cc>
Message-Id: <20260824-oxp-fix-v3-1-599b12c91a77@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Content-Transfer-Encoding: 7bit
X-Change-Id: 20260804-oxp-fix-879390c5e47f
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, 
	<linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Date: Mon, 24 Aug 2026 04:54:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	"Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	"Zhouwang Huang" <honjow311@gmail.com>
From: "Shengzhuo Wei" <me@cherr.cc>
X-Mailer: b4 0.14.2
Subject: [PATCH v3] HID: hid-oxp: fix UAF on pending work in remove()
X-B4-Tracking: v=1; b=H4sIAP5di2oC/3WMQQ6CMBBFr0JmbU1bSltceQ/jAofBzgZIaxoM4 e4WVibG5fv5762QKDIluFQrRMqceBoL1KcKMHTjkwT3hUFLbaWXRkzLLAZehHdt3UpsyLgBynu OVOajdLsXDpxeU3wf4az29beRlVCiUZ0ZyHmnrLtioBjPiLAnsv6j6aI9dN9YMug7jV/atm0f6 fFowtQAAAA=

oxp_cfg_probe() arms drvdata.oxp_mcu_init to run 50 ms after probe, and
oxp_mcu_init_fn() dereferences drvdata.hdev to issue MCU output reports
(hid_hw_output_report() followed by msleep(200)). The oxp_rgb_queue and
oxp_btn_queue workers are wired up the same way. oxp_hid_remove()
cancels all three with the non-synchronising cancel_delayed_work(), so a
worker already running is not waited for; removing the device while a
worker is asleep then frees the hid_device underneath it, leaving
drvdata.hdev stale -- a use-after-free when the worker wakes.

Drain all three works with cancel_delayed_work_sync() in oxp_hid_remove()
so they have exited before the hid_device is freed.

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
Changes in v3:
- Revert to cancel_delayed_work_sync() and drop v2's probe-change
  reordering: with the driver's static global drvdata,
  disable_delayed_work_sync() would permanently disable the works when
  any interface of the device is unbound (Derek J. Clark). The re-arm
  hardening and the per-device drvdata rework will be handled separately
  by the driver maintainer.
- Link to v2: https://lore.kernel.org/r/20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc

Changes in v2:
- Use disable_delayed_work_sync() instead of cancel_delayed_work_sync()
  so the works cannot be re-armed (e.g. via oxp_rgb_brightness_set())
  while the device is being torn down (Dmitry Torokhov).
- Arm oxp_mcu_init only after devm_device_add_group() succeeds, so a
  probe failure can no longer leave it pending to fire on a freed
  hid device (sashiko).
- Link to v1: https://lore.kernel.org/r/20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc
---
 drivers/hid/hid-oxp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 20a54f337220dc2aee3483a14d542b66c487bd60..d8fb6a69d40d43f2595179df1067d42b4b3e166a 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
 
 static void oxp_hid_remove(struct hid_device *hdev)
 {
-	cancel_delayed_work(&drvdata.oxp_rgb_queue);
-	cancel_delayed_work(&drvdata.oxp_btn_queue);
-	cancel_delayed_work(&drvdata.oxp_mcu_init);
+	cancel_delayed_work_sync(&drvdata.oxp_rgb_queue);
+	cancel_delayed_work_sync(&drvdata.oxp_btn_queue);
+	cancel_delayed_work_sync(&drvdata.oxp_mcu_init);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260804-oxp-fix-879390c5e47f

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
