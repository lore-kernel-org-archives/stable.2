Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D07533582
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953304; cv=none; b=eJH0UQDS1vxkflPnoJm/xaNAFVA5DkoTk8WATKhoY+/5xAMn55GVE/7wdTSrlGhz56cAxv5HF+aqjtloA11u7DpJjzzOf5kumDDrUrdxibrrOIXEDSZ46COqO8PwJexJq673RSj2BYdpxtViBYR3Bwsx9l5YbpfaZwh28DeNc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953304; c=relaxed/simple;
	bh=C6ff9KcyqOndaRsGzyeVcjE1aS8hBY1J6uCvEO7yFsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEsb4Fpuj/kJ8uzWOOPU6koxMdWxfXuqBLPQFOa15jPueGlWzF5p88Ua1rS+3ghlCzjep1V96Hen8Edn5YojzM+0CDpOB1K5YUVeNtuf3ZB+wM4ZFCAAIgwTKmbsffXOPqdLNwPD+0/0JTxp3mfKrGq5R62tutRc49akRGHlGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq3cTbc3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq3cTbc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD851F00A3E;
	Wed,  9 Sep 2026 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953301;
	bh=1OGMkGaKi4WvelAN3MNA1pHz6jf0IvkJHdkNzFaqspo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wq3cTbc33prC5/h9nZx4q0QJIry3q1PbTlPG1DQzUrvS8umLkOJob2Aok7sElBt2N
	 l50m8Sw2c8y6bqOSOIvsykNU/5eEtv1PN4VU/fGmZBDYw4ur9Sg3viWUoOaTLzpfcT
	 LdF06AOCSabb1QtfnyH82jwq4jQTCkgmraXUuuKR8LNw4y3Ohts996V5kyKnW4TPgi
	 AyTRdhUJeVCaGLKY6IzBmmQA3BK7pt6YKdWJVlHijZ07j8kbtGskBD3skb70TyW+Vg
	 9VdwK9NSDqDLWZCvZ1JgkowwolfEfkv+j/m6ElA53bUwTvWqFWLF3sNhpnTMuUrhs2
	 KB4WTO0j1lryA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] power: supply: rt9455: quiesce delayed work before teardown
Date: Wed,  9 Sep 2026 07:28:18 -0400
Message-ID: <20260909112818.1847669-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909112818.1847669-1-sashal@kernel.org>
References: <2026090322-effort-tinderbox-8526@gregkh>
 <20260909112818.1847669-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 3e7a1ebc32fad5a558254a478efd401c17a24381 ]

The threaded IRQ handler can queue pwr_rdy_work,
max_charging_time_work and batt_presence_work.  pwr_rdy_work and
batt_presence_work can also queue max_charging_time_work, while
batt_presence_work can requeue itself.

rt9455_remove() cancels max_charging_time_work before
batt_presence_work.  The latter can therefore queue
max_charging_time_work after it has already been cancelled:

  rt9455_remove()                   workqueue
    cancel pwr_rdy_work
    cancel max_charging_time_work
                                      batt_presence_work queues
                                        max_charging_time_work
    cancel batt_presence_work
    return
    devres frees rt9455_info
                                      max_charging_time_work dereferences
                                        rt9455_info

The IRQ also remains registered until devres cleanup and can queue more
work after any of the cancellation calls.  If rt9455_hw_init() fails
after the IRQ has been requested, probe returns without cancelling work
that may already have been queued.  A pending callback can then access
rt9455_info after it has been freed.

Register rt9455_cancel_all_delayed_works() through
devm_add_action_or_reset() right after devm_power_supply_register().
devres invokes the action in reverse registration order, after the
managed IRQ has been freed and before rt9455_info is released, so the
delayed works are drained in both rt9455_remove() and the probe error
path.  Cancel pwr_rdy_work and batt_presence_work before
max_charging_time_work because both can queue the latter.

This issue was found by an in-house static analysis tool.

Fixes: e86d69dd786e ("power_supply: Add support for Richtek RT9455 battery charger")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260723225310.12663-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
[ retained the int-returning rt9455_remove() callback required by the older I²C interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/rt9455_charger.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 6f6adc7446a6d..310cae3f61f09 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1583,6 +1583,19 @@ static const struct regmap_config rt9455_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static void rt9455_cancel_all_delayed_works(void *data)
+{
+	struct rt9455_info *info = data;
+
+	/*
+	 * Both pwr_rdy_work and batt_presence_work can queue
+	 * max_charging_time_work, so cancel them first.
+	 */
+	cancel_delayed_work_sync(&info->pwr_rdy_work);
+	cancel_delayed_work_sync(&info->batt_presence_work);
+	cancel_delayed_work_sync(&info->max_charging_time_work);
+}
+
 static int rt9455_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
@@ -1673,6 +1686,10 @@ static int rt9455_probe(struct i2c_client *client)
 		goto put_usb_notifier;
 	}
 
+	ret = devm_add_action_or_reset(dev, rt9455_cancel_all_delayed_works, info);
+	if (ret)
+		goto put_usb_notifier;
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					rt9455_irq_handler_thread,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -1714,10 +1731,6 @@ static int rt9455_remove(struct i2c_client *client)
 		usb_unregister_notifier(info->usb_phy, &info->nb);
 #endif
 
-	cancel_delayed_work_sync(&info->pwr_rdy_work);
-	cancel_delayed_work_sync(&info->max_charging_time_work);
-	cancel_delayed_work_sync(&info->batt_presence_work);
-
 	return ret;
 }
 
-- 
2.53.0

