Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980877;
	b=Bl1x59qAGFu2WGYxqk1OD+aHTkHeu/bEcb81aYpKCOVNnPdKKzu3625sfRYu5tRIk2tB
	 6wPZz4CsbYnW+hKxBlH4SA8SY+uHgfQgtxKPA8uZdBncMxiyvFRjW+xDhkCWLgSegyNq8
	 nmCJoxlnTtDB2S262VEqQqgwSw4LR8CepfVEX3z+yIXKMkbHSlYUoliwsEtaqOHkN8TKF
	 AXwoBlr0x6pXhLozEXPrGXGMnmY8d2URWoyVYHpCBQU10ECR7+e5Yk3RjpNnL0XSdMpPk
	 MIVS3AjpQwmV2sy4Bs1rXIKXIb/pjg4rxDLsg1Scw2QH3S1PLPVMd1WjhIEEcst+COA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=On7o3YDJ6A9N2qE/v0Dd5vQ6+keSrhVbU1SUb028uOU=;
	b=fJ8zv+qlWmNHOohVAzoC98XB1uqKF6X0NndoAYdx1KEEr8b5aJzehirdlJHP6cbHGW5h
	 q2N+b0WG0djirLJaqsyNHhVQZHvEl2eVI8Ze+4I94UM/tmaGHkcxh2kIJuMp6P6eKG6TI
	 NNu8qXmC3Juht9IYH7V2X3gu9ffNmhXUHwYvBHEGbWL40POeEwZ1ie74aMMZ6GMUAwx6X
	 fj99iwADEKXdA6ZFW1DFACZT+kcPs3FeeJZihq9hj1Bwr2xgwBm5gY1M0E2Xwi7iZaJRy
	 47JXqJIV4UIYQ1RtDUHpBiP2SqUa0XH9kWw+SefgcTMPYNjhM/33pKyCaj3seXAGI8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrbj77ew;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F20606D805
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72F20606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrbj77ew
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a60f90a924so299856b3a.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980877; x=1794585677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=On7o3YDJ6A9N2qE/v0Dd5vQ6+keSrhVbU1SUb028uOU=;
        b=hrbj77ewuQUUx+lfk2VXUxZ8o8kG2nckHoFyKAlQmdKiLGC2XGSsf90xGU7XjRdxpP
         H2dz8v1tYzzjMNxYTGLSOcQfK34VSi45KPlK0M6C2NwhZ71qodmEbXo2qrkTwSdOogNg
         MDRv95aG7YTffY+NZbjyNzcg2LACsij6XKF2b5zV4GzC0ow+/Yu65T+k+Fk/PqPrQV68
         xMFBQIROlXCiD4eWpqLvN/OMSezqsMt4omG9/xJHJ6L9dKD7R0hUaLqmOUZcMQxyMsMW
         0hoyX2O4rC9blcOTm6Hp6nYemv0XA2Wvg7tAfCJqDJWE6JPkhb9JHRaYgMpXY3OVjCJz
         NIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980877; x=1794585677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=On7o3YDJ6A9N2qE/v0Dd5vQ6+keSrhVbU1SUb028uOU=;
        b=e6GU9OeToskQb0Ld0ODXpVEY9C9zUnAIKxtkTWA2pNsX4cZYDMel+rxcls6vr+qKP0
         6Q6QXbtEX27zmq/cusSq4WEBWpdB5pfBzkw1FPQQUwpfaKCRVF87w/Ae1AIi4Hdbk9Bo
         9j9nLBRHoefrTsjnEOrSwHJkWE/kVUUurw0k3cCnCH2HeNjqaD+Ju4oNgVETH3NasTps
         quCVp+4kcYnj6++YR6eiGe6msMemRbh4QuE7mlicKobGZ3FBmbUODeOxtCDlS1U5Dnlk
         hTgNcckpceDxlZxqdIyfBuK3qDXzaXwIdk21oO4xh4/u7geKSRAUHBhlCcpuAcdNk8o6
         RpQA==
X-Forwarded-Encrypted: i=1; AKwUvBx4FW1dY7kqDTOyI1BZdbxyoRfZkHQqvQIeSosrHwST0i1Si2i6csaxUk2iNvLlF7C8p0YYTQs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RNKGlDYMUOiGtSvo2YU0xnWKe4SEvdIVsmAlw8CYdMnSe5YSF
	hv6SiP2Dk3WrOuPW2Puo4hc5mrtBJKY39ZHhktPtSU+ZiCH9sHr+WrkG
X-Gm-Gg: AYBFou3aeBRrI4bDoN1TDjFItIldOCXI8Vc4ID/sc9JZCVpqBgQe0r+w3P1XzlQ37V2
	kxfFgGIRiSkogoZDMDMfvhVo77YurpMG2CyDkcz+vUnH1UHckaaUzzCC2TeNdrSGtlIC/Ki/xWl
	PjoY0EEbsD4wSrSPYEv8bKK47Lu93yneCYZw/F6Ke8CQ8pKhd8om+xa6UO7pXXaP33cMrPFUcif
	2qv4J96F8LT8YR+UY6kwKMlV3QOfepurkQ4BANGzDT9rp02fFrc0hr0IsMKs5ID6X/XQFYSHYbM
	LygpRFax73l7ddyCULRL26NiSoX8OMgPNkoDfS7N67YtNuTAozv9NXOYj5Q5EDgM4oXP4ve1Bzo
	14mpBTJ3EK1p0PXVposr6fm5jbKee6vjQvZi+/huoipU2PeroQqYZdhI5s2Yl0xe8DRR2TLM14m
	sV+bYlBgb5xFIgOuxNpycdZdVCvW+TNbQx/6zTk4JbydxZpyQ5GK2cnX5wmY6XzDVDWLpTZAwnh
	o0G3c8cHlH7OW3Dw05lutNdyyB3BUje6PE++07Zrzfj8xmTiYRaIjtuBqgJ9O3U76wUgSTtDSPA
	qXxtFxGIwCUzD38RmAOf+tFZKDi8jLcfEdtGyxgrIVkWzUQ0AuyH+abyg/q9ZraJULwefbc=
X-Received: by 2002:a05:6a21:880e:b0:3e0:b1b2:2af9 with SMTP id adf61e73a8af0-3ebb2aa0e0bmr2982479637.60.1793980876624;
        Fri, 06 Nov 2026 08:01:16 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a7fbcbsm727930a12.25.2026.11.06.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:01:15 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] power: supply: ltc2941: drain poll work before the power supply is unregistered
Date: Sat,  7 Nov 2026 01:00:55 +0900
Message-ID: <20261106160057.2754689-2-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106160057.2754689-1-hj351016@gmail.com>
References: <20261106160057.2754689-1-hj351016@gmail.com>
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

ltc294x_i2c_probe() registers the self-rearming poll work before the
power supply, so device-managed teardown drains it too late:

	devm_delayed_work_autocancel(&client->dev, &info->work, ltc294x_work);
	...
	info->supply = devm_power_supply_register(&client->dev, ...);
	...
	schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);

devres unwinds in reverse registration order, so on unbind/unload the
power supply is torn down first and the work is cancelled last:

	power_supply_unregister(info->supply);		/* frees info->supply */
	cancel_delayed_work_sync(&info->work);		/* too late */

power_supply_unregister() ends in device_unregister(&psy->dev), whose
release (power_supply_dev_release()) kfree()s the power_supply once the
last reference drops. The driver holds info->supply as a bare pointer
and takes no extra reference, so it is left dangling.

ltc294x_work() re-queues itself unconditionally every LTC294X_WORK_DELAY
seconds, so a poll instance is essentially always pending or running at
unbind. Its ltc294x_update() calls power_supply_changed(info->supply),
which unconditionally dereferences the supply (spin_lock on
psy->changed_lock, pm_stay_awake(&psy->dev), schedule_work on
psy->changed_work) with no use_cnt/removing guard on that path. If the
poll instance runs in the window after power_supply_unregister() has
freed the supply but before cancel_delayed_work_sync() has drained it,
it dereferences freed memory -> use-after-free.

Register the work cancellation after devm_power_supply_register(), so
devres (LIFO) cancels the work first -- while info->supply is still
valid -- and only then unregisters the power supply. Nothing queues the
work before schedule_delayed_work() below (external_power_changed is
NULL and ltc294x_reset() does not touch the work), so moving the
registration is safe; devm_delayed_work_autocancel() still performs the
INIT_DELAYED_WORK() before the work is first scheduled.

Found by static analysis / code review; compile-tested only, not
reproduced on hardware (requires an LTC2941/LTC2943 gas-gauge chip).

[USER: add a Fixes: tag. SHA not verifiable in this graft-at-7.3
 worktree. The bug entered when ltc294x_i2c_probe() was converted
 to devm_delayed_work_autocancel() ahead of
 devm_power_supply_register()
 (drivers/power/supply/ltc2941-battery-gauge.c). On a full-history
 tree, blame those two devm calls; confirm the 12-char SHA +
 subject of the devm-autocancel conversion before send.]
Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 6ebb555..8f8a8f6 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -531,11 +531,6 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 
 	psy_cfg.drv_data = info;
 
-	ret = devm_delayed_work_autocancel(&client->dev, &info->work,
-					   ltc294x_work);
-	if (ret)
-		return ret;
-
 	ret = ltc294x_reset(info, prescaler_exp);
 	if (ret < 0)
 		return dev_err_probe(&client->dev, ret,
@@ -547,6 +542,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(info->supply),
 			"failed to register ltc2941\n");
 
+	ret = devm_delayed_work_autocancel(&client->dev, &info->work,
+					   ltc294x_work);
+	if (ret)
+		return ret;
+
 	schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
 
 	return 0;
-- 
2.43.0

