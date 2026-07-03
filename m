Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3823BCD33
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091838; cv=none; b=h2zz3o0NRsqXTcVkP3fAIrrSeDy59ct0h/qLeKcd2KJMDoNfYpKTxInKNvhtmCTySPfkG3MQRYgNmcFbJx9X40N3AAye4FSBCplvje2vsglEUgrMXaKnFupeJ0PUsLqT/q/JPhDUeAyw9tg/JmPtMr+ZhITN58nEUJuaMdwRFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091838; c=relaxed/simple;
	bh=0eHW1w2sw8/QGjlmZcCx6sq7hihGPmbxeRNEM8aLoWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzIn/Gh6LITA+BGJJ7+xMapa4++B4udCsyl9zp0A3x5ZICt6zXAK1WPwva7EaH6ieovjDX6xhzgAVH8BG4+wD1Q8bNPmI/Ak+tM/tgWS9zCSyoUGcFPoR8oteFQkyTHFyXeo4+zGMErJH8hBKPmf1kGXW7RD1f2mkLeU2p8DbIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvHCWAAP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvHCWAAP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b8d99342so186705e9.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783091836; x=1783696636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0Bc1ZmeOfqEtZgb3lF6zr0iTIVchQGs3e/FsoiNOcI=;
        b=pvHCWAAPTk6iA5zpH/Ry+A4wWFRuZFhEByMHyNX5kXmvi1H/aqVBHYuzgn6D8lDjfW
         F06YFAgnX9690y76aNRdIh2Dsxrq80u065H8VStVeLs9I0LhNpAvGFarDfbycBIQ2TZ+
         irm9LfmdWE1bmS2t06SONQGhr8fqrxSyy9x1zzrgOc4kDBXqu2d+muLYqrGsCo1iOYKI
         JcIxxD0t7E4iDf/iqsNi+WXSBa20TwQMfVxfM55riWzdLdmIT0BtWDLylH/bZa/lY7qt
         6sbq8EB6ilJu+QaNvdGAr7WObcG89HSEwNuD99t/pCBkPOQ7ejY4HvzK9uTFKsJXhqne
         SK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091836; x=1783696636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0Bc1ZmeOfqEtZgb3lF6zr0iTIVchQGs3e/FsoiNOcI=;
        b=YrrUR0xG5FL7UVIV1XpXIGCSU4zMA1vms+fzPvYMsW4nivlkeIns9DOmdw25PakLqp
         hHlnHVVj43uEljL48oKWHlmQttT6mXlR7OLtkLNJryVgaDhYhuyl7Yydz/hqVG2r/qPP
         9xTc7TGe5TT3SmiyCsD0gH+dxKJRjlHC8Bh3vXYnT6ovYYzix2swhumbVdSnhoTXtiMu
         vi5MZOYcLiuQQp/GcOTetI6E0Wb8wjfnbChkZDWXLF6UOkxcBAbvdmfZknulURtRcWkN
         7JrngS4THGIhvlq7nOemkdRPYrqVva5aOhAos2ck+mh8RRVbI6zPF3gk3iMC6Mx4ySUa
         5xMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QGth1NKkSkxB5bURXFJy4Coa4rUDfgMkZMLBacjRys9NmhCTC2CqiJ0bbKN4SgTPGr6NuvCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+rbtvqgNiD9OlxqcwCK425BMSt7tnn2sQZrY+DxaIhkWXP5k
	v23GwxTyx0rmcv3VU5lKMqPIOCMEUXW4wMUuzYZItd8Dl8k/XLnUkdlDklblRWHFxg==
X-Gm-Gg: AfdE7cknLRCYm9Z1zxYcWF79z8lAKYtjm/b8dFvbAFsasB/SMQ8ve+Q0QNfUwrrMyYk
	rQw4Z63OcZajtyiSDS6G7gxLMeAz3f86NcvM5MWyol0HAOqDyeeRcVFHiVdSraS1jXn/v/NEEFf
	DfSYENnRbasVM15f5zSDuQkz6ECXDOtqarG81FEiWZvyYIvqKPESW4EPUOHjQ7ShlWHGZv2/aAH
	L07I/Z/Oic0beRPAeXOrHwreppkEdxYJCGUGTBAR5xoIL35HMe8yK+3HJ8ngTR95zg0MoF5W8Os
	MVG1ZdvBkZPUOzX6uAaHKtu+FRk3fQajsNqxO8Hnt5jhbquv5rt5Eeb70QVFm7lXNdGs5WcOO8i
	nl6vdv8Mkw9ulQ6EekBCpv8lfzbzD7/OnnL03DV3VYTsYe+4Dlq7PKUsEzOlxab3QYrA8BDsajH
	Wyti6nnH4x1hJ4G+MTjX9VRX+mFUwaKMSUYAr0SzU6QXcWv5NHYzdOrrS+pDBtfCtCvQkFnl4=
X-Received: by 2002:a05:600c:b4e:b0:493:c1a0:7fdc with SMTP id 5b1f17b1804b1-493d0fe58a3mr22735e9.0.1783091835477;
        Fri, 03 Jul 2026 08:17:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960816sm7277f8f.29.2026.07.03.08.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:17:15 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:16:47 +0200
Subject: [PATCH 1/3] HID: asus: fix missing hid_is_usb() check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-usbcheck-v1-1-e80259ff625d@google.com>
References: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
In-Reply-To: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091826; l=1171;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=0eHW1w2sw8/QGjlmZcCx6sq7hihGPmbxeRNEM8aLoWY=;
 b=wpHZ0pNkb+9kdY42h8/fX9hLQ4JEwlogdTzfqlJmlDZYff14DfGxAFttmL4/rE4CyPaOHW8lf
 V4XZ7Hjg8/CB7J6kvzRpqlUM+x1ZWLCZyUBmKdRQGV/ZNUOrs9WVQQr
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent.
Fix the use of to_usb_interface() without a hid_is_usb() check.

I have verified that it is currently possible to trigger a kernel splat due
to this bug in an ASAN build, and that this commit fixes the issue.

Fixes: 00e005c952f7 ("hid-asus: check ROG Ally MCU version and warn")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/hid-asus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..befa990b3210 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -753,7 +753,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			return ret;
 	}
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+	if ((drvdata->quirks & QUIRK_ROG_ALLY_XPAD) && hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
 		udev = interface_to_usbdev(intf);
 		validate_mcu_fw_version(hdev,

-- 
2.55.0.rc0.799.gd6f94ed593-goog

