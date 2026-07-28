Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BD223BD17
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203746; cv=none; b=e8zfSdCFCtdA7cDVWWTvj/5vK5E/91LMl9KUyAquje9XlYipdhv6+KX4C4CEPC06cauVDLiJaTfawJjoMGFq3Rw2MuooOJQKRDB1LeY711XdJH/fupKwJtR3KHV3iXtQ2Mun4EsnzL3/YZCGk7edz4v8h7jDTg3Hed70YHStiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203746; c=relaxed/simple;
	bh=h2q12AUp9O/kTBbsKAFQ2FqqupG7nckpin9iw1wX3a0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AX4mFlQsJeY27dGVO33HkQhZsqYelXW6Uwg2dB3GhJuwwqkv/WWztn2LlRwR04aLc8m+Ig7IdIEKhyusrZPW6oZxn7QeVPenh0UI0wRtpymtRjntqDgQC/SVjV5hwregPHdsB+06TAwFO9Kl/xH5zqPS1C/due7qhh7rixjuupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxzbf/Uj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxzbf/Uj"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3811f512167so3127945a91.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 18:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785203745; x=1785808545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f0SM9LlpHTwCaw/SjDIWrZU/9QgTvcwL2gvLlLgdQ7g=;
        b=Qxzbf/UjLLbd4zZR+1Ri4Padmej4bP0GJYTHFNJ/FHwmOBNrB81o8IeL6JlWqUJNG8
         CtL2wI3yTe/b+a/kP/iYL4qitwNhWqv+/G4lAOOIwusg0dFAMhUWkRZjlOQbvoo/mNKN
         A9o20Y5+yEQEObhRYzUmnJnk8aDemmqs1/4fZzyoEeWN8dHpDYHBBp0NSrFiPJG/XhYT
         Yka1QbQGfpqS9oxWkWemmBOw413sqv791v2lFchvhwcUp9WdLG4TERN5o6Q3nybuTZpN
         FD3h8NupruxYoaroY346Yit7m726ZjWGks0tl+akZJ7D3kU+11dlUHnD9XtF2mnpXZTa
         xSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785203745; x=1785808545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0SM9LlpHTwCaw/SjDIWrZU/9QgTvcwL2gvLlLgdQ7g=;
        b=aMfF/4JE4fg5cVg22tqKjhG+P6vVpbfAoXOFub9DjENC3Y7AX0aHPmASsOqStXnZ7v
         ru1ovaAelOxtJQHLYfm0gc8R+sE3pgFV5dmw9BWABsBMajCT70vilqL5VL8Cv9aan2a0
         FepE5U0Guo7/pNafXxRtfesdUFHJW4qYICMFEl4S8FuY0O961Eap5rseGAm9EqGukPuX
         Ywsf1HzZiailqon9Jg3792t0xL0gjPSy050lNpQ7AhZba+TZj30/IEDj0DUCxv7VswW4
         dAKBkfQUoC73mVcys1nNYKT3/UNBBhFEiYbHNLJURArmSZoRZ85qNnWujTKhatemHvlK
         +TQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWbPojf+c9g3d8WHg4/3yHI5BDeJ/eR4SG4pt0193M8IKD2z/+jfaYSNXZOweqf60YuPzIQm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0wMmQmjRcX/Yd8F7WRu/498hQtoZeEC09cDMk74mPb48DC1V
	v32W1pldL1LSSrd9x1qFrAc8WJwdVe2kGJ0KqvQMzAnrzi3UWkV58Nx0
X-Gm-Gg: AR+sD12doUNKWf+Qhm9AAxrOQXLIYTMQUIncgzaPXVrhM+uRLbraeT8Qru+0kHtUFGH
	wXjpEQ0hPVeqduo3B7c0YG6chUvbpjj04Slo1fKAIrcpyn9LbS5WqCesvBKiEVXAV/AdcURoX3U
	5+bG654+x0grnU7F5Q0KlacbRvwsxlgr6YSOXq5Tbk7uAgEDwEXTl13A0ZxTn+mpF9gpLK6h7ne
	/Ov6BTR/iBQMUciDxzanaQ8+Qpqua9VZuegP3TI3DDDKSaHmEEaHwqfMXvgBgQzBgXjc3O+8S1Y
	hgSuMHez5ShPkwq5jETCSnrntR+VrdC2WuYgLnmOkRly5+PDrkf9h4hWWzhVUMxJQ4cTFg+Xtdk
	HmDBwNvyBtXzKElL+O7HKVz024OpLA9eEly3mpfRA1KQHjvi2i20oFX8mSgKRKBycJGXQghGxC5
	pNMSBO3B2lJADNhQjsajsk
X-Received: by 2002:a17:90b:4cc2:b0:38f:474f:e77 with SMTP id 98e67ed59e1d1-38f6a45e1cemr358573a91.37.1785203744656;
        Mon, 27 Jul 2026 18:55:44 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f64150874sm529230a91.16.2026.07.27.18.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 18:55:44 -0700 (PDT)
From: yhchen312@gmail.com
To: pkshih@realtek.com
Cc: damon.chen@realtek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Yuhang.chen" <yhchen312@gmail.com>
Subject: [PATCH] wifi: rtw89: 8852be: add .shutdown callback to quiesce device on reboot
Date: Tue, 28 Jul 2026 09:54:35 +0800
Message-Id: <20260728015435.1585953-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yuhang.chen" <yhchen312@gmail.com>

Since hardware rfkill polling was introduced, warm reboot on arm64
platforms can panic with an asynchronous SError when the rfkill poll
workqueue reads a register while the PCIe link is being torn down:

  SError Interrupt on CPU8, code 0x00000000be000011 -- SError
  Workqueue: events_power_efficient rfkill_poll [rfkill]
  Call trace:
    rtw89_pci_ops_read8+0x94/0x160 [rtw89_pci]
    rtw89_core_rfkill_poll+0x50/0x1e0 [rtw89_core]
    rtw89_ops_rfkill_poll+0x40/0x68 [rtw89_core]
    ieee80211_rfkill_poll+0x3c/0x70 [mac80211]
    cfg80211_rfkill_poll+0x40/0x2a0 [cfg80211]
    rfkill_poll+0x30/0x88 [rfkill]
  Kernel panic - not syncing: Asynchronous SError Interrupt

During device_shutdown() the 8852BE PCI driver has no .shutdown
callback, so the device is never quiesced and the rfkill polling keeps
running.  Once the platform brings the PCIe link down, the next MMIO
read targets a non-responding device and is reported as an asynchronous
SError, which is fatal on arm64.

Add a .shutdown callback that runs the existing remove path to stop the
rfkill polling, free interrupts and power down the chip before the link
goes away.  A NULL drvdata check guards the case where probe did not
fully complete.

Fixes: 0b38e6277aed ("wifi: rtw89: add support for hardware rfkill")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852be.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 5bc0a6a99d1d..9aebecbac067 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -92,11 +92,20 @@ static const struct pci_device_id rtw89_8852be_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, rtw89_8852be_id_table);
 
+static void rtw89_8852be_shutdown(struct pci_dev *pdev)
+{
+	if (!pci_get_drvdata(pdev))
+		return;
+
+	rtw89_pci_remove(pdev);
+}
+
 static struct pci_driver rtw89_8852be_driver = {
 	.name		= "rtw89_8852be",
 	.id_table	= rtw89_8852be_id_table,
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
+	.shutdown       = rtw89_8852be_shutdown,
 	.driver.pm	= &rtw89_pm_ops,
 	.err_handler    = &rtw89_pci_err_handler,
 };
-- 
2.34.1

