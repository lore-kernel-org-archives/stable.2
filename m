Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD81BD9C9
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996690; cv=none; b=PN9+Dw6e+mG4otsLsz4yXpyONc2ET8xZwK9Q0wvj2ixh/7Cinm+HkuZvBg+TOJTUfh16GS8m5w4D7Lb4Hu+m+ahziVjpwkIlBk6PxSqhEshFYqlNVKqWUq9w5+v4Z8zqN1IvEv3DukQNRvgaKvh/wbcAqh6LhlDJdg022JXaaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996690; c=relaxed/simple;
	bh=4BYVqjUglUdukgdquAFjv91VzVsZy6yCRbIPkKsP4hI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XljTl9Juau3gffH3bbHe44Ocz1k/7D3mMP2NtRMLXri6UPukpjgRBDiGBAquIB9hYLlPK9FdliyK4s2TO80hYSqY08l2MfJXBTUDKdAWpcAPfQj5XO85v0yllK+/qoWQmTfEo6zxL7pJJdJ27YZEJrsfduau9NavD1sAmqLpxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTKAOkMt; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTKAOkMt"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53396adbc53so1838331cf.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 20:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790996687; x=1791601487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbQpt4XN2R0/yiVPfAFgl5CdQcTGytdEwK5oHePqLiQ=;
        b=NTKAOkMtGo3EeQ4qnu0C65C29P7ibVmiO+LtvTQxVPRzC8sCXFUkXXwsHgTd2a7urg
         ccnmlDHizCQ4Kigyq5StOhY4Gmfv/V0yU9ZLmxgd2g1Qx/Om54zELfYOOSSlRpNDIjk+
         /cG67JNQZBDRciqEe6nsPrXnBseKH3UkDkGjfBia+CBqDryBLjkXWM+T6gRtvVjEfu82
         dVguZRFF5gbjBfYwWjtWFYYa+UeW9tOmWnPINEZJYbwu7bgKqeOocyI/8jFUK581FTUu
         ZHrqsZmnDaEEPVOx5Eu9gAZ1YkpftMVELoAjzflSB1/a31Spphh0vUn4rIlDUsSrQpbK
         iGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790996687; x=1791601487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbQpt4XN2R0/yiVPfAFgl5CdQcTGytdEwK5oHePqLiQ=;
        b=n/jDgM3tAdK0J7yy+xV9n8zGzc+3qrKLMAo4svD6BspTG5YBUAk0wQPGxF+ujB4uzh
         GoZm4RnN5baupuePoihDDLMXZtC5XJjJ6uYIqxhfn5PDvh2mMY7HtAcxaX9VkIgHwOdB
         LNqadotbLWgWwmR8W5wm4kDUv+6uzlO/QE/K3cYVbsBEX7wKX/lUy+A3rDs0PFwaolS0
         kEXQXcLaYDaUQRbliCS+rQx1pdxPTxFwVK9VVH9mwSikxYZLOk+hDPdYup5RQoK9wEZO
         wJ+FgNuzN4t0qpocxHWd16CuYtVgy/9wIyBE0+8Qlqn6LoNPTiGoUk67+ZkZUq7dlAsl
         bsfA==
X-Forwarded-Encrypted: i=1; AKwUvBzKaxU1SEcYoCiMIIPsz9vsQrQ/SSAKJSJIGBHUdzaBUeuOIBcZ0+svNGIiRKHqI7lWhbPN0+8=@vger.kernel.org
X-Gm-Message-State: AFuF++kjsDQ6nh9OPqISl+GLkLV1Fyk4MqGi/Ma79gT6CpZLkYjEQncY
	UxjFT1GMegZuihDmkwoEkWQhFPTwlMR2DVHA/OuJcCsEFcv8fglOAcI=
X-Gm-Gg: AYBFou0L+k671lQaeuo8EQIyAnsQOZ/wZ4Bx6rMO/BEYngKyyY6f9xOw65Vm5dLLFt5
	0CJbI8EGxTY0k6kzWE5FKhBpYT4f9mxp4nljP9YLXO0c9/MrbkzKyLlk800BT4tsfQv186fhpmG
	N5dTF8e2/ai70Z2erS6uWs3/twT0n5ibBfHMkRy2wmIpBE1SUFizPEUHQrgLBiO1PhYTmrnm7Tq
	ZG6Y0WXk2c7yrSJ+858QeE+/hU0xvx3IGEZ9gyvp8GHi/GeRzX7Oai47q9ZkvcNwxYBQNTxbtlm
	l4wCB6aPdJLqT23JClcuxdrRdcy61XK0oTqpZ24VP9If8+u3aIk5O/u2J+qVHHXHa88hA29Ozqd
	N9JTRk5Mue1urKePKFgRzmvQv0Bgx7MynWB6nRBqu/E2ea5MtiM88XpEDL34kTqxgSVkAEJ0HKc
	xvQT+Mp+3VK0I2InkaTKEGbAPRqSsHQKdTYnUDg+6Phky579HrBKZAYiKJik2RC6ETSDI3hJ9FT
	InPUcL144XIzQcGj5R5JEFkr+NYydkiuXMcwH4JNUlJQIbH1qChmWUF+Iz9wKP+dGD8logjvMLN
	Jy/m6tfaWyWqW3YuBYIBPoTTfN5B
X-Received: by 2002:a05:620a:2851:b0:93a:14c:32ad with SMTP id af79cd13be357-93e50bfed26mr274906285a.0.1790996687163;
        Fri, 02 Oct 2026 20:04:47 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bc8faesm34443696d6.28.2026.10.02.20.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 20:04:46 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] backlight: lm3630a: Cancel delayed work before destroying workqueue
Date: Fri,  2 Oct 2026 23:04:39 -0400
Message-ID: <20261003030439.599330-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt handler queues delayed work to read the interrupt status.
After free_irq() stops the producer, this work can still be waiting on its
timer. destroy_workqueue() cannot drain delayed work that has not yet been
queued by its timer, so the timer can outlive both the workqueue and the
devm-allocated chip containing the work.

Cancel the delayed work synchronously after freeing the IRQ and before
destroying the workqueue. This also waits for any running status read to
finish before the chip's resources are released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8f49e59ce374..8ef8163c7fef 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -591,6 +591,7 @@ static void lm3630a_remove(struct i2c_client *client)
 
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
+		cancel_delayed_work_sync(&pchip->work);
 		destroy_workqueue(pchip->irqthread);
 	}
 }
-- 
2.53.0

