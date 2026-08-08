Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC6375F80
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786166985; cv=none; b=ES+rXjBwcDu82Gw9Au0WGy4IyVgjDcAw0RkI/sRPtR4L6Q5cBz47VA7lONqTviOMCxLAoRwW14sO2HQogmYAAzIAvGK2hk591s0ld7gpVTaa6jPooaDejluKOI0p2wb5CgPA+VFPzqi9K38N51NgfHG3uLQsgK7MhycJWIr4oEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786166985; c=relaxed/simple;
	bh=Q1wBHzLTIq4tK/+/Usog1Gd8RXUwm0ePB/TUbBnrev4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKZTEx38tQN0ee3Cn1KB5nPTYhoJ8upd8QCDxpUAhnAAH3AncL+MOBm39YtVYw2a23h0J3QLRk/hVkH3IMZv60DuXUHme/euofZHZhW1qOy1zl7KhWqWbkblZxpc3uThPrQTiaY+SLKkifJugC98H+iE2HjEQB7Xq4GYTxsTSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUcLGWss; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUcLGWss"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so186285a91.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786166984; x=1786771784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wDC6YI5r3sz7/q8pUx056+kBWfhQJhpnlyWFVMa4m8E=;
        b=mUcLGWssKgoP7FgjhR+lC7JaDoRkDyfw1n/Dokxm4FVsn9o5p5GcGgwlepQXETqT6n
         oQmRWEDEIXv+oYHX1Atzlj4VKmPegAVP2Jh4COqvgIXJ7ENmhbdnRhV3DN52z2WlsVy3
         ZcRfwpIXDwTNeC5CLMNt+vNqaAvj39DvUyMbwUk7PvaHDIfl92F6phAQpOQqmEXbGqPa
         /wnXUHnNYevkTVqX3mMzMlhx1UOKw5N2yf7PxnbCjtzQSuDs70r1O3c6aSekcI1tAdL6
         BQMjIGiR37qiKwNQwx7rFsSBFBMSa4riRAr1P2EUVOeLbn28hiNZiu8SLmnLXo8Oh/pK
         bH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786166984; x=1786771784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wDC6YI5r3sz7/q8pUx056+kBWfhQJhpnlyWFVMa4m8E=;
        b=Adkl6UIyNUQMNo/WuRPMnJpc51ICQk7O/jkiiiw5eMi94DC4s/a+iJqpM1EW7VI1I/
         D3q91V2ZEdS6oFZlqaQpcHHYMJLzOziVVOHVxe3HKAg+73vR4uNT4IG7WvI6KLFHdO8k
         +MD/GtaxW8vbeYGBwXC9Emud6OrEjSiFpjWB1z7nwqOSB8Xli5PkA8q8U9ioYAQvwCV2
         ExHrbmgBb2dwRwThD9uRuOzRnzDa/sO7sLkFBYqdzHZjsjH0QczFfJdOcI2osWkic/Ls
         uzT7rwNpJ3fs5v4PJ7LOteVwncNy+jxOJYP1NOpWd9laONWn0Q9bspymG0I1+KF8Dwxd
         FgGg==
X-Forwarded-Encrypted: i=1; AHgh+RoDQFuJ0RNbMnmhIZwI3uadf3DVFNvVhr3qAkuOmoxevIcWsYU4Hp9Q/vuqiI60AhMGvXWOwOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC1EeETDE8Y0Gjfpjq4DATxGG97dAWeZZ/M0ofxu1AryiBQyci
	pH2yaJ0f9uHpRy0nNJukeZm7kujU7DvBAfAAZk21H8ZrYO3YYm59STwO+0yyfC6qeZU=
X-Gm-Gg: AR+sD10ovYkTaAqntDzsBymUUlecIA0kg7WQDUpesfZ+1uR1I3MPDqg5K4Gc4k380na
	l3sC/x52d9+kNs2U1JGBJ+UY2eu1A+tqtxoVVNA9D9FJcVhPbGGg2HDoP901piHw7WgDDqM9VoW
	UiIsac7ZMb9TTh87rIy02Q1KEs4frwC4XYL3ARCmnt4FmQW5URrREErXvW6fSvvGhqDlgtwmx8l
	9Oet6ayGao1yFnvJwE3VAttPn4ibvNu0eaunwhKrKPjplQkDV6HOQhIF2FsdVYW7VS+PNbMgzta
	YmDxITDrVq3jlG1Lso/PaVFj7E995GK5kAe7xDjCUix3RDZ+ap6J5N9jkU+NyhcRB+akE6YaEWO
	1yt9A82UccRx3cDMoy4QRMJLQTYe2+6CpZDrIUzB98z2l4+1TBStUgnT2tg4uDVd2o5aJykC/pI
	tgKgQd5M+MQqrEQwLFIdrt1z3nFdGGuD8r6nsOBScXQAg=
X-Received: by 2002:a17:90b:58a3:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-392845e2350mr991461a91.4.1786166983672;
        Fri, 07 Aug 2026 22:29:43 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b358a6c6sm1881112a91.3.2026.08.07.22.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 22:29:43 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Archie Pusaka <apusaka@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Hilda Wu <hildawu@realtek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_h5: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 13:26:54 +0800
Message-ID: <20260808052655.2562268-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

h5_btrtl_open() calls pm_runtime_use_autosuspend(), but
h5_btrtl_close() does not call the matching
pm_runtime_dont_use_autosuspend() when tearing down runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during driver teardown, this reference is not dropped and usage_count
remains unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call before disabling
runtime PM.

This issue was found by manual code inspection.

Fixes: d9dd833cf6d2 ("Bluetooth: hci_h5: Add runtime suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/bluetooth/hci_h5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 93cdde981840..a5e7e9b0ea74 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -1023,8 +1023,10 @@ static void h5_btrtl_open(struct h5 *h5)
 
 static void h5_btrtl_close(struct h5 *h5)
 {
-	if (!test_bit(H5_WAKEUP_DISABLE, &h5->flags))
+	if (!test_bit(H5_WAKEUP_DISABLE, &h5->flags)) {
+		pm_runtime_dont_use_autosuspend(&h5->hu->serdev->dev);
 		pm_runtime_disable(&h5->hu->serdev->dev);
+	}
 
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
 	gpiod_set_value_cansleep(h5->enable_gpio, 0);
-- 
2.43.0

