Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794035936;
	b=XCbukRvQ8NfH8WGkeUkWACDl81WW4zikFCeorej0cDvSdLoamXX5AzE4yTvg6zszmelY
	 +03mcx+CjxXgWw/kEZ6A0BOXxs97ReQgH6SixBcdOj/qukYi6chAZHZNdgt76RYQA6M9A
	 nwwv7bza+2QdTCfkNNEVVA4Q+7XcFFy7QVlDkutK7RdSUgfr0I52ZHR0bE5FhFi8tYiIl
	 aX6m760Vbuy7Ya3XzY17WCFS1gkv00+lldVpMGNfEhyyfseYiJSV7h9sM2Y/+CZOilyz3
	 OYrkU3rUgsELqx3lMtdn9VZL7Oq+mj1sWqziAye8K7FEAH/vM6EM7M/s0hL+VWR0JhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794035936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e2RBvV6ZC2qSudUbd18r2yO6oRHwMggBhLaocYC4YVg=;
	b=V5DA7u/i5I4AWBI3TykU/vlrU9kXAZ+yuTFNplMRAdS5qVngn9iyu8JjPDNErSC0JxmR
	 fJgtkOW6yp6Jaj8qV0UgtG3LFwtvB2VxKZV2CGtbqRnFZKu88CLJfkMppUksbrO4/T3jD
	 3pdUHOwy0Dp2GhXqPobFNnu3c2p8lQyTP6gaRVIWKBq8SV0mWtS0RUdzMbUTCx/9kFKTt
	 2qwXTS5OFyLvpeg/y0eZLSam2aVWxelyKGUn5efnirPy8irOIlSsw2/9/c/Af8CEiUdf9
	 OuoVW0cq1X3NUJ9ES139D+bP/yt7s76blyEh7PmJ9CVS/TsyYVvE0GXaJuJ7VcMeNrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H75OZMkX;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0670B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 07:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0670B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H75OZMkX
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a9f9473029so1029575b3a.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 23:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794035935; x=1794640735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e2RBvV6ZC2qSudUbd18r2yO6oRHwMggBhLaocYC4YVg=;
        b=H75OZMkXSjam0NOi3FZTiMVbVJF2RYmjV9H0u/a4VttNJxAm5Sx5cn//1UR34WbQbI
         Fk0vCUFMXQ+zZcuOW1sSveqJXFgZcGZ3yZAHTMsbroZ3o3MmkNF1LIJMVA3HX4EFqNgR
         exgw9WPmdb1u58gPSC9A5Q66r+U+Uwz2fVU4tuWPJPtpTpvhaJ4AkL4LfNy1fNraTg18
         vEzDRDc4CxJKXdDqwJ9Y4Od4HJvsyN9Ys0do8JWY1hXQXWW6USlEs7auSegDvFjzGGJ7
         1FBbKGFbOpt+cIMypYL5W0OMGUfakv5YoYFj6BUS6i6gxHTOhO0Q4rLkyxSyA9jl6rGg
         IXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794035935; x=1794640735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2RBvV6ZC2qSudUbd18r2yO6oRHwMggBhLaocYC4YVg=;
        b=1T9kW2Quwhw76GepB0qrzhLtM+GmKKgLL6f7VAGiHs3BXcWH012sWMZaU7vChnCy34
         BUHOecFgKv5Jwnyi/fsZ1xb+Dh8tEhtcDqDlSgggrJhGM4VRb9o692E9Gi8Txwohu7Ex
         XbrnRYj7KK9rtwfrpYpIvhDJK3TAyBJbXilQCPg8Aqpzf1lm6keaXMIJQpZFQM2mE3NU
         1h2+ZxbF44+2zQOwfk1t8zlcofYrX9Lptr7r3f5nZC+OhV6jwavySlfFU9SKWos/PLsH
         Jmy+G4c9z2UfMfeKttnMAXfsP77EAYdpPQ01tKPIQLO+l/F9wuk0z8G/wfkNr2O3cwih
         3fVA==
X-Forwarded-Encrypted: i=1; AL+hErG7t109/cu9u+JqPeGTN0roDEc+Nm+GF3VIJxImNxT2S+qIoCkLWE6+L2aAGk2cfn4DHcjLx1c=@vger.kernel.org
X-Gm-Message-State: APuU4Z83GRGb6WB8OeZ4U9+dTsYXBDTgf/W/U8waOZr29FedzrFQUDJh
	YCc9asP9ZsGuG9VzsUGsLJPwlDMtoQrBM1LeYriYYpko4R9363Tba2KF
X-Gm-Gg: AYBFou3FtN58TgknpuIIcfAGDz0YLA1we2rKTJIq6+IjM4PFzRWOKH+d6ovual60rSE
	LTboAsXS8T1F2PW+nNTgLrP37FICvM4aXuAfPZCV8mPorvCST4eV9CoFCSKM4nbm6P6rYJXiYMc
	8SbsRocQBCLjCkXU2/NKHI7IifWK5BLb9TngsorlUDIiqvA3XOEkxbFsuqhWMso2z6G7FZ8bKVr
	iI1/EtvAvFGuyR1FLj3snydSFmj8ryrh/OLFMSt6kwh9v2huXm2YNc2NZRVr+X2TxAF3WXnAehe
	JxDP8BcOhxdkCCVuHF3X7fTNWN8VhViNkB5FC2spJJzxlIljkzz+civP/GuUwQigL2VQicQjDAE
	2mFpQT7dq33jmgMnOABpqo+ws7l+CAoXFy1N3bT+vrv93KKghFmr8ugWvFa48SICOhxzDDJG2J/
	ZgYmr+6t0u75ebN8hVia7RKI9TrVlE5H45xeHJY/ZP4/Ovz11v7dh8XNVlgLUe1GAuJ87hfSHrj
	OQ1DU2gvRSixq9um9Z5EWJYH/tBrpMW8tjKjzYwQaJU84xmw7blqxZDj9K6S9rGbie4TVpTtqZJ
	fR03kqsW2GTw35eKDjViUH+YU8ruxY6HNXgYNs92yO7mbmLo86+lBlUTicbJqfkCxUy2fQ==
X-Received: by 2002:a05:6a00:b82:b0:89f:450d:90f5 with SMTP id d2e1a72fcca58-8b37aca2e17mr4908542b3a.11.1794035935229;
        Fri, 06 Nov 2026 23:18:55 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b356c287a8sm1234364b3a.3.2026.11.06.23.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 23:18:53 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: lm8323 - cancel PWM works on unbind to avoid use-after-free
Date: Sat,  7 Nov 2026 16:18:42 +0900
Message-ID: <20261107071843.3427985-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

lm8323 registers LM8323_NUM_PWMS PWM works (lm8323_pwm_work) and
schedules them from the threaded IRQ handler, when a PWM ramp script
completes, and from the LED brightness_set callback. The handler
dereferences the containing struct lm8323_pwm and its ->chip, i.e. the
struct lm8323_chip.

The driver is fully device-managed and has no remove callback, and
nothing ever cancels these works. struct lm8323_chip is allocated with
devm_kzalloc(), so on unbind devres frees it once probe's resources are
released. A PWM ramp completion interrupt arriving while a fade is in
progress schedules pwm->work; free_irq() stops further interrupts but
does not cancel an already queued work, and led_classdev_unregister()
only flushes the LED core's own work, not this driver-private one. The
queued work can therefore run after the lm8323_chip has been freed,
dereferencing freed memory (use-after-free).

Register the works with devm_work_autocancel() instead of INIT_WORK().
It is registered in init_pwm(), before devm_request_threaded_irq(), so
on unwind devres runs free_irq() first, after which no new work can be
scheduled, and then cancels each work while the lm8323_chip is still
valid. The handler does not re-queue itself, the re-arming comes from
the interrupt, so a single cancel drains it.

Found by static analysis and code review; not runtime-reproduced (needs
LM8323 keypad/PWM hardware with a fade in progress racing device unbind).

Fixes: a48b2d4a0091 ("Input: introduce lm8323 keypad driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/input/keyboard/lm8323.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 8eac63b..388b790 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <linux/platform_data/lm8323.h>
@@ -564,7 +565,9 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
 	pwm->desired_brightness = 0;
 	pwm->running = false;
 	pwm->enabled = false;
-	INIT_WORK(&pwm->work, lm8323_pwm_work);
+	err = devm_work_autocancel(dev, &pwm->work, lm8323_pwm_work);
+	if (err)
+		return err;
 	mutex_init(&pwm->lock);
 	pwm->chip = lm;
 
-- 
2.43.0

