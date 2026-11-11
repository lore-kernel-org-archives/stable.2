Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365025;
	b=feKIMNlpMcKTNh+Ytd7d1nvVbb0DG6oEaiAUcWl64GFLeJ2crwSa3Dkzp4wnpCcHG9K/
	 uBcHQPNepET7tsWi99GMPs6ZhEUZMuMzU/IyXJeI8IJxvjJQkTZ3FarLyarT5oDR50v94
	 yp3HQ0aUrDRglAx0LLZH5cvy5ORuzrZvTNBcsGZg5sUA5srLvBxFF7EKVsc7YLtJ9oG8C
	 66RHSw4v+dOyOxOzwUXeeXG2WK+sJ+KFt/s+02wjKdKpTKULL3U/y2sBFZsZqEjWZE8UY
	 boG5PGm4nlL3vcj9udK3TVXjk09UUsSgNxLITiPsVVQXTl1BNt3dBPWjNnO6Vk9o/tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365025;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7rNI7s/znd7YiV8uFLOV38Z26XRmIR9CssTgm90hB78=;
	b=2Ck1YhDp3cG4I7a9XeuNo9d4e0zS0bRPIygMYoEEJsztr9d9NMtuWRXCxLRDHOqSwHGn
	 BwkOp+2fwnhYnH5UdTzon3u5W9W0WNsCvIAovDY46FtHx02d1rf1qZquJlm7DbjZnWDxI
	 lam1o4Rv4Z+lD9EPXM29nHst3izvaHISS+Q1UcGybSNgDCil5nkHPHJiWQdrDMoS5IThp
	 nf12jBqaQHcLsoTUbEPCUgbbvPgNCVFcPrk/KmcBLyE8f2PvLduym1zJCPTrKRg14cujo
	 n/6JLXqdMmCXoM1LpdrQKG+47jPxHd1JgbcRZav94LMNgaWkY6xfX+vO+IdlB6PCxzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kONKV705;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D541606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kONKV705
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600021F0089F;
	Wed, 11 Nov 2026 02:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365025;
	bh=7rNI7s/znd7YiV8uFLOV38Z26XRmIR9CssTgm90hB78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kONKV705g62PgtebKxEbkPGOKRnt7AbV5zKEh8moiJogS3WpSznGPbyPlZlloWD1o
	 TEvGgJ0xk4PPU3lwtDqg95ASmtVpNp7cj2hn0aEizRoYFFpOT80VqOfIQhI1eaoxGC
	 UvQ4pfpOmeYCn8B0qCTfUYHH8nvxRfXirN83rABnmUEPo5PRm61PrqPGgvwPCnIMN7
	 1A40F5AqXZJWTmy6Q5Hc0OAPGvCHZFZjGhmN1h2VFfjPi7g2v1Yg1DlmTat3pHQaLO
	 GQ+uC2ALeMfUdd2e7dT44lx1dF4ksGK4ptVACVLNifRR+/EvUcZNEq7diliOOZiNql
	 VgFA2LSjmkZuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] power: supply: bq27xxx: Ensure poll work is cancelled on remove
Date: Tue, 10 Nov 2026 21:43:43 -0500
Message-ID: <20261111024118.753556-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054139-failed-6.1-db560f4b1c52@kernel.org>
References: <20261107054139-failed-6.1-db560f4b1c52@kernel.org>
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
[ sashal: replaced manual mutex initialization and destruction with devm_mutex_init() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index a818b002af21d..57b3de34c0242 100644
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

