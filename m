Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8A538D68
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951843; cv=none; b=sFZDPSP2iDQv4qD9VS8Z1Kmsh3njZoIWD7MIjJnQk+i3f3PaAoA/nRpCtLI4zG7k8Wwfw7zxCmRduDBO3oV257bchBPNWExwSd21YDrNvfKiyGxJsqvoRj6T5kleTiYC0uIGNCrB0qkVRG8qqHe4tH8vn3MDzvws2H8Y+ldcBmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951843; c=relaxed/simple;
	bh=ekOmJ/Pxpor6drkFOY8VwP8zxQ+suVgbLtDAJ2TEic8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0HeH+Y652a6YbyZn9PqV7H/gH1I+HlvURYuFE+RJHZ/MmFbtLR7GzmkL/4/v4eAf8c7yxr9O7ID4RLqhG+IE74v2yOc4q93NdHPxpA2OmlOhJKria0oqAYrOpBPBcJCGauQfjLBC9BStc6nZJ0MB638I+VtIjhlyn9SaIwc/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsyVCrLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsyVCrLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A451F00A3A;
	Wed,  9 Sep 2026 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951835;
	bh=p6Jauh7qjFjMT3oDR8EeQ5p3ozQD3EHpynZckpJY6nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GsyVCrLZaqgVOwj6nr20ryorPVX6HUyO8xVO+FOj+nxotbyhiqTxm3+Ca09u3h03H
	 7eMApRP7Qrj3pPmHXq5j8xjeD07echK95/QjWmE090jH6gRLOmGs51JgLYJzP3hoik
	 OupZyliuRO16E0dXK67Ra3xWx1dfSjEjxSG+tvDywfmcKdeCUXP2JoHtxFtrSo1bIY
	 sw8av3dloelzC+49XSXa1lcgZ6vjnHnUC9NzNPae4Scr1zJMdGWa70mAvpzUw71icE
	 EXRfqKb72K23mtfswKc7pRiRO0V3c4JnBU1zAa2W1w5jnKoWfCR+Rs5vPBr2slUw38
	 HVqZKOm9LGRyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] power: supply: charger-manager: register regulators before exposing sysfs
Date: Wed,  9 Sep 2026 07:03:52 -0400
Message-ID: <20260909110352.1705903-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909110352.1705903-1-sashal@kernel.org>
References: <2026090321-dosage-uproar-b130@gregkh>
 <20260909110352.1705903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit c57cb36f76eb7ced45f57af1a890d8f3a6d76342 ]

charger_manager_remove() and the err_reg_extcon probe error path free each
charger regulator with regulator_put() before tearing down the power_supply
sysfs entries (power_supply_unregister()). charger_manager_remove() also
calls try_charger_enable(cm, false) after the regulator_put() loop. A
concurrent write to a charger's externally_control sysfs attribute that
lands between regulator_put() and power_supply_unregister() can run
charger_externally_control_store() and call try_charger_enable(), which,
when charging is enabled, dereferences the already-freed consumer handle.
When charging is enabled, try_charger_enable(cm, false) in .remove() also
dereferences the freed handles directly. Both leave use-after-free windows.
Symmetrically, probe registers the sysfs entries (power_supply_register)
before acquiring the regulators (regulator_get, inside
charger_manager_register_extcon), so userspace can reach externally_control
before the regulators are available.

Split charger_manager_register_extcon() on the sync/async boundary:
charger_manager_get_regulators() (regulator_get only, no async producer)
now runs before power_supply_register() so sysfs is not live before
regulators are available, and charger_manager_register_extcon() keeps only
the extcon notifier/work setup, still after power_supply_register() so a
power_supply_register() failure cannot reach extcon setup. This keeps the
sysfs setup/teardown ordering symmetric without introducing an asynchronous
producer on the earlier probe-error path.

Move power_supply_unregister() and try_charger_enable(cm, false) ahead of
the regulator_put() loop on both teardown paths, and adjust err_reg_extcon
(power_supply_unregister() then fall through err_regulator for
regulator_put(); get_regulators self-rolls back on its own failure).

This does not address the separate extcon-notifier-driven deref of the same
handles, which needs its own synchronization design.

Found by an in-house static analysis tool.

Fixes: 3950c7865cd7 ("charger-manager: Add support sysfs entry for charger")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260728030123.230202-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/charger-manager.c | 54 +++++++++++++++++++-------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a20e7aaffbaa8..7f7ddecf2250b 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1017,6 +1017,29 @@ static int charger_extcon_init(struct charger_manager *cm,
 	return 0;
 }
 
+static int charger_manager_get_regulators(struct charger_manager *cm)
+{
+	struct charger_desc *desc = cm->desc;
+	struct charger_regulator *charger;
+	int i, ret;
+
+	for (i = 0; i < desc->num_charger_regulators; i++) {
+		charger = &desc->charger_regulators[i];
+		charger->consumer = regulator_get(cm->dev,
+						  charger->regulator_name);
+		if (IS_ERR(charger->consumer)) {
+			dev_err(cm->dev, "Cannot find charger(%s)\n",
+				charger->regulator_name);
+			ret = PTR_ERR(charger->consumer);
+			while (i-- > 0)
+				regulator_put(desc->charger_regulators[i].consumer);
+			return ret;
+		}
+		charger->cm = cm;
+	}
+	return 0;
+}
+
 /**
  * charger_manager_register_extcon - Register extcon device to receive state
  *				     of charger cable.
@@ -1039,15 +1062,6 @@ static int charger_manager_register_extcon(struct charger_manager *cm)
 	for (i = 0; i < desc->num_charger_regulators; i++) {
 		charger = &desc->charger_regulators[i];
 
-		charger->consumer = regulator_get(cm->dev,
-					charger->regulator_name);
-		if (IS_ERR(charger->consumer)) {
-			dev_err(cm->dev, "Cannot find charger(%s)\n",
-				charger->regulator_name);
-			return PTR_ERR(charger->consumer);
-		}
-		charger->cm = cm;
-
 		for (j = 0; j < charger->num_cables; j++) {
 			struct charger_cable *cable = &charger->cables[j];
 
@@ -1582,13 +1596,23 @@ static int charger_manager_probe(struct platform_device *pdev)
 	}
 	psy_cfg.attr_grp = desc->sysfs_groups;
 
+	/*
+	 * Acquire charger regulators before exposing the sysfs entries, so
+	 * userspace cannot reach externally_control before the regulators
+	 * (and charger->cm) are available.  Mirrors the order in remove().
+	 */
+	ret = charger_manager_get_regulators(cm);
+	if (ret < 0)
+		return ret;
+
 	cm->charger_psy = power_supply_register(&pdev->dev,
 						&cm->charger_psy_desc,
 						&psy_cfg);
 	if (IS_ERR(cm->charger_psy)) {
 		dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
 			cm->charger_psy_desc.name);
-		return PTR_ERR(cm->charger_psy);
+		ret = PTR_ERR(cm->charger_psy);
+		goto err_regulator;
 	}
 
 	/* Register extcon device for charger cable */
@@ -1622,11 +1646,11 @@ static int charger_manager_probe(struct platform_device *pdev)
 	return 0;
 
 err_reg_extcon:
+	power_supply_unregister(cm->charger_psy);
+err_regulator:
 	for (i = 0; i < desc->num_charger_regulators; i++)
 		regulator_put(desc->charger_regulators[i].consumer);
 
-	power_supply_unregister(cm->charger_psy);
-
 	return ret;
 }
 
@@ -1644,12 +1668,12 @@ static void charger_manager_remove(struct platform_device *pdev)
 	cancel_work_sync(&setup_polling);
 	cancel_delayed_work_sync(&cm_monitor_work);
 
-	for (i = 0 ; i < desc->num_charger_regulators ; i++)
-		regulator_put(desc->charger_regulators[i].consumer);
+	try_charger_enable(cm, false);
 
 	power_supply_unregister(cm->charger_psy);
 
-	try_charger_enable(cm, false);
+	for (i = 0 ; i < desc->num_charger_regulators ; i++)
+		regulator_put(desc->charger_regulators[i].consumer);
 }
 
 static const struct platform_device_id charger_manager_id[] = {
-- 
2.53.0

