Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07269383999
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545995; cv=none; b=GTsBAcrt9eXv94apxa9Nu0yPAjcVtrWfJEwBhV7BQPb6Jxs27C+Zj9iKsRxiYjkKKvHfXH9LnCRP9SPHA3kUm86nhd19BeJb/j8V+9udNUAlYnetO/vSV7YyqV+0L6cttn9XZDmzAIHE/InoaWMATB3Yul7LvNrqlKL/WDhIYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545995; c=relaxed/simple;
	bh=RSXFKRPGW3JJIe/FbqRa1KwSFmcKDXevUWoOD36dQKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUntrzNZhxczD5DVTCSODw2JzJlZRKVCo7tHWbJ0PQgy4GkT1WpiiYf6fx0PNIl3KhUopKc9vaZUdxocli8eOf7Q4rgSr2oEiyhd+bBV4g0eRIpNOSUzSh1R7IR90NYfTCsGQrTXPj4i5bMHI6hVyG3d8XKvuC8nSS/VlUXOPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU6+5cz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU6+5cz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6EB1F000E9;
	Wed, 12 Aug 2026 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786545993;
	bh=FkrFyCdjCP7pObilQi8chkxMvMdRHeVU5uahb+0W4MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XU6+5cz7gpjOVFSRYOVcnkFWNFpNwceMfOw9mP8RR628jC+xMoYf/redf5dbTWR3k
	 PU/XDmhWCE/S8iXTLHNPsFwFlQh0tu/XF18/DC5+ogWZsjnEgrf0gXniGvDkYfDJO6
	 l6c1Y07BhYuHA40dQbXZuwUzfNFOBKnSAhotxlsGebEiSe125LrUb+eev+0ESi8dX7
	 pW2TpmExp8JrlMlu4QejWUwHRq52PCgtqAINbizvWBR9gpfzbEI5pWVWDaMeUNysLe
	 P+T271PfWJ3aykDNR48Jq8YQbIBfBZ5eQh9VDdy8YQhpjLBOupj1xG3BWaq8rSQkgy
	 D83SR9pk2auqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongyan Xu <getshell@seu.edu.cn>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hwmon: (npcm750-pwm-fan): stop fan timer on device detach
Date: Wed, 12 Aug 2026 10:46:31 -0400
Message-ID: <20260812144631.2227395-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080503-visor-oboe-4814@gregkh>
References: <2026080503-visor-oboe-4814@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyan Xu <getshell@seu.edu.cn>

[ Upstream commit f27f6976ea269219c1259a7c2f8c6dfe782540a3 ]

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
Link: https://lore.kernel.org/r/20260729100116.790-1-getshell@seu.edu.cn
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ changed `timer_shutdown_sync()` to `timer_delete_sync()` since the former is absent in 5.10 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/npcm750-pwm-fan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 11a28609da3c7..dd34009c9400c 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -360,6 +360,11 @@ static void npcm7xx_fan_polling(struct timer_list *t)
 	add_timer(&data->fan_timer);
 }
 
+static void npcm7xx_fan_cleanup(void *timer)
+{
+	timer_delete_sync(timer);
+}
+
 static inline void npcm7xx_fan_compute(struct npcm7xx_pwm_fan_data *data,
 				       u8 fan, u8 cmp, u8 fan_id, u8 flag_int,
 				       u8 flag_mode, u8 flag_clear)
@@ -1003,6 +1008,12 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
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
2.53.0

