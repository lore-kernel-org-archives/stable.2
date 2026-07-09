Received: from mail-qv2-f0.google.com (mail-qv2-f0.google.com [74.125.230.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978C4071FA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591936; cv=none; b=PNrHCTsbuDcaWx1qYCdvmdxCN0UIZ9lOQaYCNxXf+H1yW2W2UuSyCzUQY6/NfZ0HQBu9Q1IjvMkVhdQYu4rz1w8p3EjO5N9ql7MYAiszPs1iycIjruEA9hBHcZ6N36cuoMsCP0PEU0k7kNf3fs/fjzzL8AcECK2FVH/1/8e7ZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591936; c=relaxed/simple;
	bh=GCdlr8/NsEt0Ik/GfaGOfqZRlBRMmJVLZ2bO+TtxDuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xaqa8tRmMOF6DrC+2w6sSZVLBkXm4uP8frqDbOdQqtYNIw1J0YUD9FPb+eKvswBnMtgC0Ouu+1kEPGsJrvUV2YRzSjRszbqfXj1RPm+vPkRU5xIMDgVRQ85dPfxm6sQdRbq9xFCoC1QU62R11fk7Fokod/xlgSZcI9xcQOqK3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=g1hkvvSR; arc=none smtp.client-ip=74.125.230.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="g1hkvvSR"
Received: by mail-qv2-f0.google.com with SMTP id 6a1803df08f44-8fda6ac0586so8991886d6.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1783591933; x=1784196733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e4OFFqUr3cMwftxVsDAGAhl16P7ZSnRgEXR+2YXB4XU=;
        b=g1hkvvSRMNptSQttAwLqvtpnSTXSQuI+OpX/W0Bu2lg3ARJBMkfSQvbLIV2jZzxAhw
         +0czcjC5JoYR19WFKZoICdkw9D2DHEJBtGdHDsM+cFbyj5/5Oeiejsf/nwpaJv2YdWZ4
         bu1nmUzAzKssrN3yo229ldkvWGQT7XtYAYjD61sUjZXgcFfWBP3/GxhwIReXN+QWSuXo
         4rqrgIdlJ/iN4vP7ZuUXQWFaUOGWP2Xvp4kNv2AyEnHomy0L/JzZuzwQvcmIY0pd38HN
         DL8pEz3QVf9pF/mexr7PU6avU44HPONyAoFBNikEl/my6uJCMoeJtG0nlZIbylNEpFMc
         8b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591933; x=1784196733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4OFFqUr3cMwftxVsDAGAhl16P7ZSnRgEXR+2YXB4XU=;
        b=HQ+vlpU27Nc/WLUKTlgP7gBquIXEhHBwgXCnhWT8bA3dga7Y07OgDnd8EtE4ZD2838
         eB9/Pst0E7JxN2qWuzTL+I4eR0GGSKabVUichoLtNc/RmhbHu6pWmmjjjsgT+N/9Af3M
         aCX3nUwV1beBbviszzciJyXXTy5x49K0EDBiA3j3Rr2oX9TgLGZDCME0w+jkepbkhSk9
         ihKgGukEGM1olyOTYWtbbDuiUEHisz8Q3cMwmcSy6NvQZ3QqF6ADpzfpKu0ihwbyABxE
         MbGpmdFPn/AOrwLfqhDrNy9LNZHa3sTgxCB5aoVNDmO12U+cHkPcaVKNNq/DbquN/XFX
         AT+w==
X-Forwarded-Encrypted: i=1; AHgh+Rpv5fq3YSwJ3Y0B7gzECgXiRvN15xZjbqKA4H7yaGfCsQSIqBXK5NyGRUYCJ7osGc8cazdnz5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCPBUu7s3JjmdODr7TYgyjjI+AUqvQzUfSnxOs1DoWcfwDZSX
	XLM6A0Aq4gbwJoChZ3GS98578TPP9FcyvhUcfVAkdzUtU9cUqjejUlCDg2iy6EWCjXs=
X-Gm-Gg: AfdE7cmHVb2A2P0ih6kB/TH0m1U3uktcrf1igrB5XQGtNvJnNqDo8i7iPHgaXI9uyWo
	v3XbQMdzgjb/oG/kPoOuNV5QcfYcSJaIsCzfzHzlHkjS27A+YKqA6vXhuLG12C+m7FcldoL9S0P
	k8YN88HXfOOAnkCvFpsiSaIfnuHZMy1KR9BDTRyGjOIdQQnasnhLFRutj1q5Woqldveu8RC4SCs
	5MoSXOL1hsf6nN/R60L6sxGX6MR0ZDGEQql/bd+UTNhdYcM4ys4SYp0hZ+CipsD5TmKLaBd74c0
	e8VIvk8dWQHFHekB7kmK4ovUFM6e2hNx1HxO7UBRwrztnb9A9RVlOtuWxNtbBfRJNV2BpEmydoO
	MoT6DuZYvKksIqh+C+Td3oT+3dcMvZW8EqbErYtwIid/VT5LXxFfa9TQYWVsoP8ckZm/QgfPGaM
	3JFVlwof9vmu/z0Ula9g==
X-Received: by 2002:a05:6214:5d81:b0:8fd:6e22:c7ea with SMTP id 6a1803df08f44-8fec3908a88mr68112506d6.59.1783591932952;
        Thu, 09 Jul 2026 03:12:12 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8ffd56c4cd1sm14178166d6.16.2026.07.09.03.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 03:12:12 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Lee Jones <lee@kernel.org>
Cc: David Lee <david.lee@trailofbits.com>,
	Pavel Machek <pavel@kernel.org>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] leds: class: disable sysfs before unregistering LED devices
Date: Thu,  9 Jul 2026 10:12:08 +0000
Message-ID: <20260709101210.104975-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Closing a uleds device removes the LED class device and then frees the
struct uleds_device that contains it. The LED class device is also exposed
through sysfs, where attributes such as trigger, brightness, delay_on, and
delay_off can remain open across unregister.

That creates a lifetime race. led_classdev_unregister() tears down the LED
trigger, software blink timer, brightness state, and trigger-specific sysfs
groups, but it does not first block LED sysfs writers. An already-open sysfs
attribute can therefore enter the LED trigger or timer paths while unregister
is tearing down the same embedded struct led_classdev.

For uleds this can become a use-after-free: after unregister returns,
uleds_release() frees the containing struct uleds_device, while stale sysfs
or timer paths may still access led_classdev fields embedded in that freed
object. KASAN reports use-after-free reads and writes in __run_timers(),
led_timer_function(), and uleds_brightness_set().

Fix this by entering the existing LED sysfs exclusion protocol at the start
of unregister. Take led_cdev->led_access, set LED_SYSFS_DISABLE, perform the
trigger, timer, brightness, and trigger-sysfs teardown, then release the
mutex. A racing sysfs writer either completes before unregister starts or
sees the disabled state and returns -EBUSY instead of touching an object that
the driver may free.

Fixes: e381322b0190 ("leds: Introduce userspace LED class driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Lee <david.lee@trailofbits.com>
Assisted-by: Codex:gpt-5.5
---
Trail of Bits has a minimal PoC that triggers this crash on a custom
kernel build, which can be shared further if needed.

drivers/leds/led-class.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index a51b0ed53886..a697d6740011 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -616,6 +616,9 @@ void led_classdev_unregister(struct led_classdev *led_cdev)
 	if (IS_ERR_OR_NULL(led_cdev->dev))
 		return;
 
+	mutex_lock(&led_cdev->led_access);
+	led_sysfs_disable(led_cdev);
+
 #ifdef CONFIG_LEDS_TRIGGERS
 	down_write(&led_cdev->trigger_lock);
 	if (led_cdev->trigger)
@@ -636,6 +639,8 @@ void led_classdev_unregister(struct led_classdev *led_cdev)
 	if (led_cdev->flags & LED_BRIGHT_HW_CHANGED)
 		led_remove_brightness_hw_changed(led_cdev);
 
+	mutex_unlock(&led_cdev->led_access);
+
 	device_unregister(led_cdev->dev);
 
 	down_write(&leds_list_lock);
