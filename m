Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364001;
	b=QUBFi4RJmR+cjP86Wy3eDFut4XqrsWNgl5NTgSBQFbU+IBIfumf4USwvb1x8VYR9Eu0T
	 l/rAHrl8QP3Cnes4UmZc7Z6nFyeMXe+U2/PMyonWx474GDhnn9dcpDNc2HB5YnuKfAWco
	 M/sACCMvccMET1BBpdg+hCnOpx3XZYqO0zrHCvjT4vkEAsqy340vp9ccFUvtqvPqG4tYn
	 Y0TC9RM5jLKAbPsTdqyugSL1FW3bMNrVzjivEse2dq3+31WUWADY219hCqdOmfdK/8jV5
	 tqMPxzTGHt3/k4EHjYiX2Gxo/PGY9DaoB5ss28kv5utjqPcQgVAgDNNnEhJeVRHNeNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364001;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8Plu/cikFWE/FKFdq84iqoxxA/IQ9HZR/mHJJ9/RgDI=;
	b=dYtEaOefBiLQsB2Y/ueyrWZ+AS8vKqlk9TG5AuOokBre8cfTBhbvIz0BxaSWBBP8SIzf
	 3qn326H2Tgd+uNkxseqRTonNrqdw1OduMxv5WkD4sENLeitpkW4GLDgdA0fY+E+4Vg9TX
	 95GH85pnReKzLQvXTJPe6p36nMryxNxLNv3N+fNW0b0MFE9bRtdmFs+SFY3ARQVjJCl5j
	 KIQd7STjGLCnZNgEHWR1Ivg3vsrybj6Ui3lbhdnVayc3bTUxIy9mLKK9hQNj9ZldaFk86
	 pj3P3iehA8252F42F1I8LWodj1mTSvEYyUhUXfpQpGOAZG789kWN8tUZOgf+ANR7ciQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYN9l6hv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F920606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYN9l6hv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B941F00A03;
	Wed, 11 Nov 2026 02:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364001;
	bh=8Plu/cikFWE/FKFdq84iqoxxA/IQ9HZR/mHJJ9/RgDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BYN9l6hvYHhWBIN1yg/3Y2KumEcAKo/i5A/LblRKPD3mDPFTponqncDb44QJIGIGi
	 9DQKwzPSAMfIJBgJUqQP65LgAPI57KLeMReSCJiZyTT8wpBeFV13qGv5TQT454eEPs
	 P4z3DJwcvyEJ5SFtAh0/JjaxC3r5plwyRAqiIhluIKSC+xbMYPZx+mYSXEJi7P63FZ
	 eFzZ2R7593BI0/aaiAgZINTCSXGxYtDwuTDsnqGiZ+s2QopCGOZUgV9NOBsalKV0yG
	 Dg1Rp8FkPJ8Uu9xTM0l2HVKPpyT40sGaWRNrUwIq7eY6tOTGL4goh85dwMovPRW7km
	 EXcAN0yBz2N1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] power: supply: bq27xxx: Ensure poll work is cancelled on remove
Date: Tue, 10 Nov 2026 21:26:37 -0500
Message-ID: <20261111022629.681261-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111022629.681261-1-sashal@kernel.org>
References: <20261107051652-failed-6.12-db560f4b1c52@kernel.org>
 <20261111022629.681261-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index b0dec20fb37e8..59d9e2d99c3f3 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -43,6 +43,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/param.h>
@@ -2160,7 +2161,6 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	};
 	int ret;
 
-	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	ret = devm_mutex_init(di->dev, &di->lock);
 	if (ret)
 		return ret;
@@ -2181,6 +2181,12 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_desc->get_property = bq27xxx_battery_get_property;
 	psy_desc->external_power_changed = bq27xxx_external_power_changed;
 
+	/* Cancel the poll work after the power_supply is unregistered. */
+	ret = devm_delayed_work_autocancel(di->dev, &di->work,
+					   bq27xxx_battery_poll);
+	if (ret)
+		return ret;
+
 	di->bat = devm_power_supply_register(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat))
 		return dev_err_probe(di->dev, PTR_ERR(di->bat),
@@ -2207,8 +2213,6 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 	mutex_lock(&di->lock);
 	di->removed = true;
 	mutex_unlock(&di->lock);
-
-	cancel_delayed_work_sync(&di->work);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
 
-- 
2.53.0

