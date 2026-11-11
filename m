Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365269;
	b=vAK/oI0PPMRzkwEiC4UOzoyn0NPj1HY4/qDh5dNgKmABL13GCX4T0uouje0vBoVT3q3G
	 A9oxGQDxIYIrtiCkWQqkFL9buu5bHJp7nvM7wgTU+OJShtVVZTNrrRAnfDc6hZIKNVrAG
	 +b69qzu7h2q5CszU3OxTQ5bV3yjzlhciqF/GCHLBbpVSupLXwdGLJGUX456CNuXCr0/1t
	 xQhQCTzj5R+lke+GkuT2BxbDkr3foNIeoORoVrpLUl2+UayJ5GlkQSpu9YKbCuHtplo9f
	 HUOhdB5FjYpwCgzd4kgKgQEM34GKl8AFer20VKmmEp4ZQ50b7FoNiTGn98UNVuQNVHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5o8kdg2y2/IjDiTiz7lNgaMG2zkQsxuHSznzYDd73Q8=;
	b=GD3XG36MTQToa3/64jXbW72Sg0qSgB71QOR2lZoqQSO+xIZX/B/6jsyJE1A9n+v7tbVc
	 NxT2mbYMOULT2qDNJb5+utoIIz7vnaRKBHme/Lik3Pk3HAb4xns0LWhMbrf7JHgazcF72
	 N/9IHQLRFwTXrWKBuY2gh4gyvNTjgqUWnUb0PJeWUQDUZMcAPlV7legfLim8rcRyq1ot/
	 5hl0nvVNrIOwKx53dVB9/Ntv7rd1PErJ3iRxjWK9dIXmk2P09MxJejs0xWW5nVkAbAB+Q
	 b+el1G688TlGPj17rpfUc/dzEOGbS9+ymj+TkT5dN4fDjLp+xr5l8cwZSr4T9Uw/j/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h6qcoz/l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E49606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6qcoz/l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991531F0089F;
	Wed, 11 Nov 2026 02:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365269;
	bh=5o8kdg2y2/IjDiTiz7lNgaMG2zkQsxuHSznzYDd73Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h6qcoz/lb8BHjUTzvfF4O9vLpGpHSqjrPVUfbGajNUEqrnX7kXU8B+/jDnWgo1Kam
	 SWY0DfK3AuOUxRbSeoBWnJLN2E41cRd+g3EiDt9kJ8lQ70uNtRSfnVvUl1IyN/37Z5
	 1Edkn6IWA5vfRBYnVhTkpBuRY5hY7hF8renlWFbLxBVbyhtN24o/yy0lS9VnqZQ3EM
	 IMQNWyOmFft8Fckys509ZeQPSjb7GYHeOCnrklFkp8qlu4xlhqXPo47kkK+JGTfzPm
	 eqakNXVLak59BXiHSsstyJIw0Jxzm43rbG/7YlsHOkMoxhJRvpgPHI/82sSDuq0bHd
	 CVZ0F7dviTcDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] power: supply: bq27xxx: Ensure poll work is cancelled on remove
Date: Tue, 10 Nov 2026 21:47:47 -0500
Message-ID: <20261111024632.770463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055820-failed-5.15-db560f4b1c52@kernel.org>
References: <20261107055820-failed-5.15-db560f4b1c52@kernel.org>
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

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit db560f4b1c5253853f978385db066220e0c218dc ]

The di->work poll work is queued from the poll callback itself and from
bq27xxx_external_power_changed(). The cancel_delayed_work_sync() in
bq27xxx_battery_teardown() runs while the power_supply is still
registered, so external_power_changed() can re-arm the work after the
cancel, and it runs after the driver data has been freed.

Register a devm_delayed_work_autocancel() before
devm_power_supply_register(), so on unwind the power_supply is
unregistered first, after which no new external_power_changed()
callback can be dispatched, and the poll work is cancelled only then.
Drop the now-redundant cancel from bq27xxx_battery_teardown().

This issue was found by an in-house static analysis tool.

Fixes: 740b755a3b34 ("bq27x00: Poll battery state")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260903081312.225535-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
[ sashal: added devm_mutex_init() with error handling to replace manual mutex setup and teardown ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index d4c694045209f..6486a039951e5 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -43,6 +43,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/param.h>
@@ -2141,9 +2142,11 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.of_node = di->dev->of_node,
 		.drv_data = di,
 	};
+	int ret;
 
-	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
-	mutex_init(&di->lock);
+	ret = devm_mutex_init(di->dev, &di->lock);
+	if (ret)
+		return ret;
 
 	di->regs       = bq27xxx_chip_data[di->chip].regs;
 	di->unseal_key = bq27xxx_chip_data[di->chip].unseal_key;
@@ -2161,6 +2164,12 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_desc->get_property = bq27xxx_battery_get_property;
 	psy_desc->external_power_changed = bq27xxx_external_power_changed;
 
+	/* Cancel the poll work after the power_supply is unregistered. */
+	ret = devm_delayed_work_autocancel(di->dev, &di->work,
+					   bq27xxx_battery_poll);
+	if (ret)
+		return ret;
+
 	di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat))
 		return dev_err_probe(di->dev, PTR_ERR(di->bat),
@@ -2188,10 +2197,7 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 	di->removed = true;
 	mutex_unlock(&di->lock);
 
-	cancel_delayed_work_sync(&di->work);
-
 	power_supply_unregister(di->bat);
-	mutex_destroy(&di->lock);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
 
-- 
2.53.0

