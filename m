Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33F388E5A
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798954; cv=none; b=q5VL76Zp2WfAuFf5jEvifv1+9sUClGEPW4ApoJvC0MAnsQFXEBl/2hQ51UvgoH7IDACCkSS3GPJM+82e5eECelH9oEUlOhmw0koAtNYS7WLJmSxvaoXRlr0DeQxQ04lt6ZaIdA/Y9SY95+EGX7i20ewRR+L0F3bw2UMJ32hFW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798954; c=relaxed/simple;
	bh=OuyjxBWgEpGzFof5aUCl4B4FVBpU/yyef9DnNzJ/Hrc=;
	h=From:Message-Id:Mime-Version:Cc:Subject:Date:To:Content-Type; b=RC61DUg94Yenx0MneAJfA++Rq7xBlzyFSBijHGqiZ0XaERSa06aPO9ns1EAJc2qw5mdHIMm+Cegduolf+S4JCFNuR7QH3jaxgt3RvqLCjRAgxIsBlPNV3IsxECOTx5Q4HB6KByD0Bls8MMGjvFQ+PkKSKdhNkaby34EYp8uX3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=EZyszHLL; arc=none smtp.client-ip=209.127.231.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="EZyszHLL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1785798942; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=u5odJSIa/si0f6OfyBko5IXp2Ehgx5VfQJD3r16gr4Y=;
 b=EZyszHLLfWeVfdR/kwyYwoOhR1VbR80O6TvxLfjr7siiTxmPDg4aESBuw6vzCzzd8Cj4I0
 mnVqTW6NfPi/IYs9qic4N/EaJkJw5C/1CK2sqRsNlteWkyhaImByTazWzjp/9yUGDHoMpC
 KDE2ENDwXpu+sv782HbRWrwgxt/3aprIJVL3eMlTub7K9wuhlRo0NJhunsLqFyDHAYCjLz
 pfLT51oW8U721F1iVw43TaVfwcpg6g6Nx2l5RYt59Nmi5BK8SYDDFkwyU4HkjMUb3oxMJ0
 NhPvrWiJZ67FjSACinYSWv2wbREviO/qKx4sxlIj9lz/Wz/jJfv7SAMNK/HhoQ==
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Change-Id: 20260804-oxp-fix-879390c5e47f
Cc: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH] HID: hid-oxp: fix UAF on pending work in remove()
Date: Tue, 04 Aug 2026 07:15:32 +0800
X-Mailer: b4 0.14.2
X-Lms-Return-Path: <lba+26a71211c+f35465+vger.kernel.org+me@cherr.cc>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	"Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	"Zhouwang Huang" <honjow311@gmail.com>
X-B4-Tracking: v=1; b=H4sIABMhcWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE vPSU3UzU4B8JSMDIzMDCwMT3fyKAt20zApdC3NLY0uDZNNUE/M0JaDqgqJUoDDYpOjY2loARyl bLlkAAAA=
Received: from [192.168.9.107] ([111.42.148.195]) by smtp.feishu.cn with ESMTPS; Tue, 04 Aug 2026 07:15:39 +0800
Content-Type: text/plain; charset=UTF-8
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Content-Transfer-Encoding: 7bit

oxp_cfg_probe() arms drvdata.oxp_mcu_init to run 50 ms after probe, and
oxp_mcu_init_fn() dereferences drvdata.hdev to issue MCU output reports
(oxp_set_buttons()/oxp_gen_2_property_out() -> hid_hw_output_report(),
each followed by msleep(200)). oxp_hid_remove() cancels it with the
non-synchronising cancel_delayed_work(), so a worker already running is
not waited for; removing the device while the worker is asleep then frees
the hid_device underneath it, leaving drvdata.hdev stale -- a
use-after-free when the worker wakes.

The oxp_rgb_queue and oxp_btn_queue workers, wired up the same way and
also cancelled with cancel_delayed_work() in oxp_hid_remove(), have the
same problem.

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
hid-oxp was missed. The fix mirrors the cancel_delayed_work_sync()
approach already used by hid-lenovo-go / hid-lenovo-go-s.
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
