Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E654937E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953487; cv=none; b=Sse8N91BwfeeJ0X7wXv4lyeV0Wa49W11cB6CjDGXNSW2DJ5sB2wcxcC91P/9+wVdAVy7BlCmyaI7GZFKHRdx/T0+uLuZe9d3U7cFXNfyNuvrEvpqiCXOoMqFDe6+UB4ecULZXJzgCyBYnrQCIXJHuUlXF4yMjMooY1pzaog1n50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953487; c=relaxed/simple;
	bh=C6ff9KcyqOndaRsGzyeVcjE1aS8hBY1J6uCvEO7yFsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2Y2LnFTr06US3Bzs2YKdD5UuYhS94pYTKuZoStcoEgVByfp6KtjYB/r/6jlgqYh0aosI4a0TzGTBXGOv5ESUeEujL5rs7veoOqLfPJPw4bh72ifVPLWIf4Iy8L9kSiSjQbiWxn8RnDTaJWgdqu1aorU8dbyqu2WwNgU7O4mNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhRC2u1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhRC2u1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA891F01567;
	Wed,  9 Sep 2026 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953483;
	bh=1OGMkGaKi4WvelAN3MNA1pHz6jf0IvkJHdkNzFaqspo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mhRC2u1coAv+XJZ08coT3vjoyEtIQ/T97+Fwnok/gcOMAyeVyzscB++hNs4DfE+MB
	 lSZdUMTC/OWKsGz0PsJUooIq04vkoKGB7eACiboZdqVEMIBbdeuhY3pOO00mIKeHs2
	 +xV2dfWRpAhIpG3UsAoakbVLIUTDCHDjTcLUVG2c6DZoYAv3LHun+vlCpI3+cd4i92
	 ZeDVX0cpO3/QA6Uj+R8Rv6dKoPh8/5je8CYhRR1tZq/w7iepiZy61AEEntY8hukgeK
	 9Nv6pJSE0RTvqnTqhIjhge6fwFOKUL+BTZZwNClkQdqf4oOBitzXKLW2tPQLrUVI7E
	 ZXyIzQjbDGc2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] power: supply: rt9455: quiesce delayed work before teardown
Date: Wed,  9 Sep 2026 07:31:20 -0400
Message-ID: <20260909113120.1865251-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909113120.1865251-1-sashal@kernel.org>
References: <2026090323-starlight-drainable-44b5@gregkh>
 <20260909113120.1865251-1-sashal@kernel.org>
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

