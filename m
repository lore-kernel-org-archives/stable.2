Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5883806AB;
	Wed, 29 Jul 2026 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319291; cv=none; b=FeeynwsNE2+wrGB00KL9Qby7xgO+ksw57IzoHU4xXDNeH8IahKE6brLsMacBtmSD0Og8DXVK5WKpfNR4BdURLx7nOnicP3eUpZyHipqyvBnFQKNtWrkuVUOS/v9xwPLIgO7gqIFtVOtVuo3M1tubPlQ8i7hXtx0ZwTBcw0LV62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319291; c=relaxed/simple;
	bh=4aQLdDhhjOU8waqHyzuwiZYHdxq5zzPOnp57IoXHDqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EycqrpmbV2w9OQ9KB4cXNCMRmSxLy4iXE9xLhNk2qVG5KjpgJ9gePy4fFXFjOptqi1QrC5EybbkNm66z02v160ZXD77mLiaawTXiZ78FcYecuBNEqG0rGiufUVNLuCFRWqNldIG1zuMkMadOdwERNsGmTW2kauXZSoFNsdpN3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=FM8KPfFZ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="FM8KPfFZ"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 480465d4c;
	Wed, 29 Jul 2026 18:01:17 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Hongyan Xu <getshell@seu.edu.cn>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	openbmc@lists.ozlabs.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: [PATCH v2] hwmon: (npcm750-pwm-fan): stop fan timer on device detach
Date: Wed, 29 Jul 2026 18:01:16 +0800
Message-ID: <20260729100116.790-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fad52435203a1kunmc331e47d1165bf
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQx1LVh1CShlCH0waSUoeHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FM8KPfFZBsD/NUzkPpZkK/EsephjnsM6E6Jguk+p7smurd3nrkUHLYjWVngym0H1tizwpvO66XCO2AP9Lgob+Zx+Me3PWg2lVOLc+5wcG5/N8PX8qBL9+cPgWjBNDwb/CNPFYIzpEyBhG9P4qZoji7vI46IB/yrPeK4r6jjO03s=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=UyAoUwGp+dtUW1tSN0Kidt7vtL39LFAfxOb7bc0ykt4=;
	h=date:mime-version:subject:message-id:from;

When a fan tach channel is present, npcm7xx_pwm_fan_probe() starts
fan_timer. The timer callback polls tach state and rearms the timer, but
the driver has no remove callback or devm cleanup action to stop it. On
device detach, the devm-managed driver data and I/O mappings can be
released while the timer is still pending or running.

Register a devm cleanup action before starting the timer and shut the
timer down synchronously from that action.

This issue was found by a static analysis tool.

Fixes: f1fd4a4db777 ("hwmon: Add NPCM7xx PWM and Fan driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
v2:
- pass the fan timer directly to the cleanup action
- keep the timer expiration assignment in its original location

v1: https://lore.kernel.org/linux-hwmon/20260728075535.251-1-getshell@seu.edu.cn/

 drivers/hwmon/npcm750-pwm-fan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index aea0b8659f5..6ff2a6bc06c 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -358,6 +358,11 @@ static void npcm7xx_fan_polling(struct timer_list *t)
 	add_timer(&data->fan_timer);
 }
 
+static void npcm7xx_fan_cleanup(void *timer)
+{
+	timer_shutdown_sync(timer);
+}
+
 static inline void npcm7xx_fan_compute(struct npcm7xx_pwm_fan_data *data,
 				       u8 fan, u8 cmp, u8 fan_id, u8 flag_int,
 				       u8 flag_mode, u8 flag_clear)
@@ -1020,6 +1025,12 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 				msecs_to_jiffies(NPCM7XX_FAN_POLL_TIMER_200MS);
 			timer_setup(&data->fan_timer,
 				    npcm7xx_fan_polling, 0);
+			ret = devm_add_action_or_reset(dev,
+						       npcm7xx_fan_cleanup,
+						       &data->fan_timer);
+			if (ret)
+				return ret;
+
 			add_timer(&data->fan_timer);
 			break;
 		}
-- 
2.50.1.windows.1
