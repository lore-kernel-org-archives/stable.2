Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952990;
	b=knk3eqRzdLK5T7flyPcDwnH/C4rrlYW5PTYgMrwkQ6CYSmNa85SBw6/lbTIO8EKc2dGc
	 pyHXm1ky1coWdznL9hJRhjGBBmlqwohFPMCc7F/ebx84cDramBJvLSFC7fruDmWPtld6Z
	 IGQuUkHy36yqEX/6nHQrtOzwndQciT+pTpEUv9NYMMmnxo7v2rg3wZThGCd3GVM6Z9gqZ
	 bCRRjDF6GT7I2LLAusQ/ey6ZciIIxhNL5TJU9iaZqUtFACLWbyXiVl5ZkgBox11wp86wi
	 Lwq7v7rajqK+51bcZV9aGGJGN45PAJZkG65axFPXVh/lO4vMfBnzVcJFqeN5gm4rpyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=lVd5+YIpZRZ9srRM38HUZhphNHJ8MrugQ9WKD9A3pC0=;
	b=2/tYMF6G5a40pIF6p5J8BsToFwTEZAYx2FKGNViH6dqYeP2QFcnEgLaYi4fkJqbAhBmv
	 W2vKxk01qcx48/Gila+ZnwNYCikHbrqFYwLIwleP6DyP7rsn3zVR529zTzDITSTWmFCYE
	 O9OrlswSwiyHd5WdD4OxvEsYcYf58gYE9CXaA66lZTlXIhfoUECx372iPCrlLM4Xa+Ijc
	 fw/tlEYjKNsinoK3BCKHWJCRo6BTiBid7DreiAEhJqDNPtil+FBSIwLopTEJqP8Kh3DS5
	 Y1iLjz7vMz63aemOcV3vexPL3v9Lbz1fYcypzQFrP3y13IhUWNFUrmjKvB6dOMmJXjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oHxVPat5;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D2606A31F
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A64D2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oHxVPat5
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so14802615e9.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792952988; x=1793557788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lVd5+YIpZRZ9srRM38HUZhphNHJ8MrugQ9WKD9A3pC0=;
        b=oHxVPat5bjbLKGMUYB16oqlsUm26HDldeAfuK/vg1wzG7yu2moRUuj0VDuZ8y3d1/+
         pfCnRvPMWmBqaDT3rz+oJTDyUf8JexK+2d9tATmkw2TIF4IuQpFvkr8mL/t/ZntCG524
         WRISs0WslGmjSQxXU+jMXmxWWHAp7ZmI7y3yzloA15P791hbEShWUClIQcF3NKWVE6JS
         gpe7WC7IRpLEUKxvs0w6J36Bb0vnxH7mfpLu9pGtcanohpAWtqH18CohXBBw2lXlLlTR
         21cRv96PqEZp7AqJzKTasLTOZZI/qcdNPfEk6LAyPaSt+AaBd2qVUUwpbUFDOHZifyBJ
         hxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792952988; x=1793557788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lVd5+YIpZRZ9srRM38HUZhphNHJ8MrugQ9WKD9A3pC0=;
        b=eJvyxSZlsbTgWScbqaxKKkMD5j5lrst4nVNeSB08e4RVyXiq6hZzA0CWeKCZjVKlCb
         no478VI4b/gJIybq1PfVmom4kcoDPDhXArwe888lwSmOEW0DLO/HfE/G3gdt8OsMbK9t
         XY4oP3z7NH3aYf6i33re632zAqw8rUCYyl5U6+w+uwaISOrjqGoylHuTrJSO8PEKxJlI
         vilIpnsFDirZ3J5jSXE6aO+g3uPnQp1E1ig+C/3Hbd3w/QN+be8ODrQp12Sl/Xkg9DWt
         75/am8uU805HCs+wIi3zHGJJUrdsz8GDOwyVn50Tcb9VJb+FvBTWuOupnMGAJzgrb0rJ
         1h6w==
X-Forwarded-Encrypted: i=1; AKwUvByiMJQm4aI6usK0aGjGRanmZkPekTsMXkTrswR6MhiSnCFL0bdZb0ur1U0tTfXelkPtLgz/ZbY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIh9Bf6cdf/cGwKm2Ezx9W4BZo9LGv2itKokA0B8K3FBQqt+OLX
	6rzJDUKB3TD9+eukE7dXWQTJpcEvyNHEX6LIMm1E3sASsZwsBg/Akjhn09vAdvbsl0Y=
X-Gm-Gg: AYBFou2j+TJFTGDKVXn4Rb4DrmViGTHftTCo7LBU4xX4ew+ipLalGWptlxtT/XssFcc
	jLM5s51Ow/z1pOQptYG5f5AkJGIFY9BpSMsKuW8LtY1PeOBLE++t7X8+aN5llABntQeOm9wwatQ
	lpELwvYtPB6jCdIDUWPPqyz4G8T0X0mlq6iVfKAiXE7Qmg7LGRWDWAV8VUHursQ0rxwN0whHMPr
	1gp1oVbIBs8xoXMgvgMZcR22ClElrZH14R5t30pJpN3VLGJDxaVT2ygTTW16rGo2qQNvzUzQ83g
	+odk3gxu+/k1rwr3dsh5z+W241Fa1tXK7gb8nPAKTesLjm3cPDcXVZo6tbiaMjpB4wmoJSi8kZa
	B5j2ZiF6Oh0nFtbHov3qfb0HooOXEvmWDDWQ1Y2+vfhBow29f4RU1XyojjbAltng6MoIRL0p7kA
	bdx7bq3rWEAD4r1eTU25tG9w1YcklsYuozW2mQi72cHkEw7zRNt9VZdjVBUWsAG7gT8WICRlnYN
	4RUahaCG1jPGYsfWELrhCpcHxEN4LzWq3xeez8q6GbDSHT6r1LDQlY=
X-Received: by 2002:a05:600c:1f94:b0:4a1:e774:370c with SMTP id 5b1f17b1804b1-4a35acbcaf1mr81227785e9.30.1792952988059;
        Sun, 25 Oct 2026 11:29:48 -0700 (PDT)
Received: from [127.0.1.1] ([85.105.252.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2e8f25sm138255175e9.14.2026.10.25.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:29:47 -0700 (PDT)
From: Bartu Alev <bartualev@gmail.com>
Date: Sun, 25 Oct 2026 21:29:36 +0300
Subject: [PATCH 1/2] platform/x86: asus-wmi: clamp keyboard brightness
 hotkey updates
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-b4-asus-kbd-fixes-v1-1-fa4dcf7d2a69@gmail.com>
References: <20261025-b4-asus-kbd-fixes-v1-0-fa4dcf7d2a69@gmail.com>
In-Reply-To: <20261025-b4-asus-kbd-fixes-v1-0-fa4dcf7d2a69@gmail.com>
To: Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartu Alev <bartualev@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

Brightness hotkeys (NOTIFY_KBD_BRTUP and NOTIFY_KBD_BRTDWN) pass an
incremented or decremented level into kbd_led_set_by_kbd(). The driver
assumes the new level stays within valid bounds before queuing work to
update the hardware register:

   scoped_guard(spinlock_irqsave, &asus_ref.lock) {
      asus->kbd_led_wk = value;
      asus->kbd_led_notify = true;
   }

Unlike asus_hid_event(), kbd_led_set_by_kbd() never clamps this value.
Pressing brightness-down while the backlight is already off stores -1
in asus->kbd_led_wk. Subsequent presses decrement the counter further
(-2, -3, and so on). When kbd_led_update_all() runs, its "value >= 0"
check drops the work item, leaving the hardware state untouched while
clearing asus->kbd_led_notify.

Userspace listeners receive the unclamped value through
led_classdev_notify_brightness_hw_changed(). Because that interface takes
an unsigned int, the negative integer wraps to 4294967295, returning
-ENODATA to sysfs readers. The keyboard remains unresponsive to upward
brightness hotkeys until the user presses brightness-up enough times to
cancel every negative decrement. At maximum brightness, brightness-up
leaks 4 to userspace, which exceeds max_brightness (3).

Clamp the input in kbd_led_set_by_kbd() to [0, ASUS_EV_MAX_BRIGHTNESS].
In kbd_led_update_all(), refresh the local value from asus->kbd_led_wk
under asus_ref.lock before notifying userspace, so coalesced work items
emit the clamped state instead of the initial snapshot. Stable trees
need this because negative values break sysfs reporting and make the
brightness hotkeys appear dead until the counter climbs back to zero.

Fixes: 7525566abd360 ("platform/x86: asus-wmi: add keyboard brightness event handler")
Cc: stable@vger.kernel.org
Cc: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Bartu Alev <bartualev@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b33ebdb21aa21..2478361b9b531 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1807,8 +1807,10 @@ static void kbd_led_update_all(struct work_struct *work)
 	if (value >= 0)
 		do_kbd_led_set(&asus->kbd_led, value);
 	if (notify) {
-		scoped_guard(spinlock_irqsave, &asus_ref.lock)
+		scoped_guard(spinlock_irqsave, &asus_ref.lock) {
 			asus->kbd_led_notify = false;
+			value = asus->kbd_led_wk;
+		}
 		led_classdev_notify_brightness_hw_changed(&asus->kbd_led, value);
 	}
 }
@@ -1961,7 +1963,7 @@ static int kbd_led_set(struct led_classdev *led_cdev, enum led_brightness value)
 static void kbd_led_set_by_kbd(struct asus_wmi *asus, enum led_brightness value)
 {
 	scoped_guard(spinlock_irqsave, &asus_ref.lock) {
-		asus->kbd_led_wk = value;
+		asus->kbd_led_wk = clamp_val(value, 0, ASUS_EV_MAX_BRIGHTNESS);
 		asus->kbd_led_notify = true;
 	}
 	queue_work(asus->led_workqueue, &asus->kbd_led_work);

-- 
2.56.0

