Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C303446B0
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041543; cv=pass; b=QUyqy6G3s/RezY1h9kCdRUFF16MBXPEnc3U7kc2ItiFKwE6rl3dwyh+2vanVolG8wtwgbRuD/jFw3mIbgJVjAxGUx48B7Qr/S+pBjUPrgH87xqGeQEDnv6v5DhHOWrl4v+5hZb1SfiuUV8orFGfBXpYZzL+ct6xptmQBKVsOqbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041543; c=relaxed/simple;
	bh=DJT11aK4BEheJPP/qY8HOdFg5c0h+5gAbI1rRLgLv24=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bUMhYCtKK165jFbEstgkLF8nHgFZkgAouOJIH3GitICCXBnEQApU6agE3+pMxNU+8fIMYy0rV0qF6FXILJMf24QRZ2+nDOBDAeM9qScqCren/pDhyfLJoRKyMx+7wVZ0DqdA7IuzzEIUHjewIWj8V1/FdcyIiqddz/vhHVLyCEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA39j0q9; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA39j0q9"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c9a3acd40so29964851fa.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 01:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787041540; cv=none;
        d=google.com; s=arc-20260327;
        b=TVF9Go/tgrPer+xn9zz5fidsc8rSrrOHfe6BLF//16ipDCX58LgcfWBfYsdPzGr7qP
         kjgWXVSWuSHmtlYQOhiSz+e/ZnpWxk6Ojv85iVrJJF+BUjqddGKNbKX88u3+zKbQYC7v
         nMgqVQvk6uOhvI7ATbcVEQSyA7KJ66wITZgndUA0SZAa+s0xpEFyiSobNWAR6Q6lh4z1
         D1LD7YO3vWOabKL/toI14OSanehsamcvrWXPFx+a/2S4hpmGBUdgoHXzhoiDmLr4hyqE
         7DS/W0VwW13xMw/y/xJbgTlQm9qfg7NK6tBynQ5J56SaQzj/zCjKj3nU/eDTqKd/1gLy
         X/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AFqjh8HzrXpWibQdtihVChZ+YGjEXJtHt987hhzQmKs=;
        fh=dNgM7mYlNcxLEuKDa+6GeEFAQGRfv/T9wApdaOqQ3ko=;
        b=s5xs6SIXRnaDw7QgwmGrnVO49hZN9xfEhZhxhyltRLkGd3LyzFXn9to21SHEzPg7Ig
         ARSGd68gDNsCVGB5qG9Fo2CfSph3r573k7x5E9v2XZfOC8bwXnHjKhT8wWsDVwcvj57E
         Xt9G03xlJE4/B3Af3DTO1Y8PmFseJ804Sx/Yt1zK2K+mnNKNLU0kSvi1JyxWMUWsS4y4
         Qq6zYvEN+3JHexdoQd1c3C4mi9WZZ+N90J4KgmrxncUGOaXNvkzqwBkegGAx7QQVBG45
         SfcDzmHq66uf4qmo0O/PqlRQS+qLKZKjJVSkdoBa+x0MhhcoTfxGMlLvBxEnUhbSkTJG
         xEGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787041540; x=1787646340; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFqjh8HzrXpWibQdtihVChZ+YGjEXJtHt987hhzQmKs=;
        b=ZA39j0q9mwAJRkAWxKGtroIIAtNUI5Ng8vUyGEgmxB6VhWrqDh+MzBtG8Z2Df/jOoA
         sKW4ziafRZ89eiDGouyVqnt1PXk/1O3QLh6hAYgv5orGJZnbE0oge/pHh7CV+zuKT8G3
         LYAxskEDS9JJNgDdFF9hk2gPRZjlg5mPuwHymO/N4LHUCFpWhP6EkSG1dJnInR4tos/K
         ZHnu9unsPTJl/Jrq0ih0Hc9tXYnz+gZx+gYRTK3A1CU0Zzr1fPiVcUDEj6bA3PZt1fD4
         bD19Mspm7t+57cdMcddzuK7fYPodTw+qhnA2QNdgsfZbCH+MC0arDY6ZNDTbV0swWeGy
         ypRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041540; x=1787646340;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AFqjh8HzrXpWibQdtihVChZ+YGjEXJtHt987hhzQmKs=;
        b=CO8Kz49vX5xvEScXnVufSuuzimAORJwqM37R9/9DOhNWMgJXF8x2DEZ1OWzoLChBW1
         zB9VeQaFnJmU2aigAcRB6kTVN7KDe2LWrMQAcsTEIG0LvH5PNR1GIF+hTkg00VQ7Q7Wk
         qhtlJWNjB+bEZ3jWTpQPc+bcooXZVVPoAVBDNkuVQbs7Pfr66nON8EKxpO08vtGa5gGk
         M9BKXxMLdyepsqTzXEFupmcSB/RvuydjPZywu6cKpDyR83tgusteHdgeF2yVkEWEGISw
         Zu0JW+Y/JwoEn2AfAghNtxNYXuzs8f0sIByrDnxJvxrLePCYmcvzhQWnALoTnIyyr4yG
         DMeg==
X-Forwarded-Encrypted: i=1; AHgh+RrReCpVO7/tyVOVtQEufv3fNS63vTq25b+pU1yIWBZH+2XId5FQ72FmNMk27rBYHHi8sCmNtVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXvT+L0FAaI1JxfUdgC35KMixe4hFwnmitGbv38bhPg3ekuA/
	/plT/rqROOMY3uFO5NNEXZTm8Um5Vcp53gCjvsgGAkMqnkx6YEQ3ioGAwB4pzQ77qJlb8CgDC9v
	/bBFUTeNa5RA+EqqaIFvwAw84z4JYUcA=
X-Gm-Gg: AR+sD113X4jfhB9M2v6kmcJnqMTemsheOcJ8NRTVHfNKi8is3GmpvK6asKhXXU6/Wqw
	QPkFyv1s1QMOf7Pc6/Ts6xzB1J6PeljJ5IDOsmYJUDVqgiar7rlTS73kcxumnLGiKRmUbEyJJfp
	Feeru4NIfav+XCNA0UCmndtOg5w5Bqm5ACLgfAWLU/VhK4Gz61blStUbU0YNZHNu793pNaVlVii
	kZ79EmDrjTLyPDFyvA+/R9fg/xtFFiddimz48q6ZwzBcI+Mx13oVShCueYkvdduh/+o2cyZxMws
	JKRFDswBqRxJNHovKhspH4FYXMoObMHiO3ho/e0NPmRj/Q==
X-Received: by 2002:a05:651c:2103:b0:39a:ee64:36f4 with SMTP id
 38308e7fff4ca-3a17516851bmr8813871fa.1.1787041539838; Tue, 18 Aug 2026
 01:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: PANZ <panz.development@gmail.com>
Date: Tue, 18 Aug 2026 10:25:27 +0200
X-Gm-Features: AcwNN1VRNToSE64_qqetuINC4oPAxG8EulkO8jxh2qP4RjtvZkYBWSdc6WMgTOM
Message-ID: <CAFinCN9OV6fS8acwZjqsp9WR7r9tKk2afdc0y9RuAsmmmJpWnw@mail.gmail.com>
Subject: [PATCH] HID: asus: fix touchpad multitouch initialization regression
To: jikos@kernel.org, bentiss@kernel.org
Cc: denis.benato@linux.dev, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In Linux 7.1, commit 7253091766de ("HID: asus: do not abort probe when
not necessary")
and commit 0919db9f3583 ("HID: asus: always fully initialize devices")
introduced regressions in the probe sequence for ASUS I2C/HID touchpads
(such as on the ASUS E200HA):

1. asus_start_multitouch() was placed inside the claimed input check block:
     if (drvdata->input && (hdev->claimed & HID_CLAIMED_INPUT))
   On ASUS touchpads, (hdev->claimed & HID_CLAIMED_INPUT) evaluates to
   false during asus_probe(), skipping asus_start_multitouch().

2. The asus_report_id_init loop in asus_probe() was executed unconditionally
   for all devices, which sends keyboard initialization feature requests
   (asus_kbd_init) to touchpad endpoints, corrupting touchpad probe state.

This patch fixes both issues by:
- Skipping keyboard report initialization for touchpad devices (!drvdata->tp).
- Moving asus_start_multitouch() outside the claimed input check block so
  multitouch initialization is always executed for touchpads.

Tested on ASUS E200HA (where touchpad functionality is fully restored)
and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).

Fixes: 7253091766de ("HID: asus: do not abort probe when not necessary")
Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
Cc: stable@vger.kernel.org
Signed-off-by: ppanzenboeck <panz.development@gmail.com>
---
 drivers/hid/hid-asus.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..7f19ca1e5a1b 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1294,12 +1294,14 @@ static int asus_probe(struct hid_device *hdev,
const struct hid_device_id *id)
  return ret;
  }

- for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
- if (asus_has_report_id(hdev, asus_report_id_init[r])) {
- ret = asus_kbd_init(hdev, asus_report_id_init[r]);
- if (ret < 0)
- hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
- asus_report_id_init[r], ret);
+ if (!drvdata->tp) {
+ for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
+ if (asus_has_report_id(hdev, asus_report_id_init[r])) {
+ ret = asus_kbd_init(hdev, asus_report_id_init[r]);
+ if (ret < 0)
+ hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
+ asus_report_id_init[r], ret);
+ }
  }
  }

@@ -1327,12 +1329,12 @@ static int asus_probe(struct hid_device *hdev,
const struct hid_device_id *id)
  drvdata->input->name = "Asus TouchPad";
  else
  drvdata->input->name = "Asus Keyboard";
+ }

- if (drvdata->tp) {
- ret = asus_start_multitouch(hdev);
- if (ret)
- goto err_stop_hw;
- }
+ if (drvdata->tp) {
+ ret = asus_start_multitouch(hdev);
+ if (ret)
+ goto err_stop_hw;
  }

  return 0;
-- 
2.47.0
