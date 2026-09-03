Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C384C77AF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447794; cv=none; b=VP02geZ2R8Mzqlbq65sbKMB6OOBPyGLlz3NDh2tlwfQFSGuMwPy63nnRqsNGkurk/Y9qfEUldXpAq3asFfxHiEQAwWLj66jeycLh7qProSt2GYewcBOWFtInnkFSzTuzoE8YOnjT6n4cAs/lErpa+dBr8JEaG1sFKwhSRXs8x6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447794; c=relaxed/simple;
	bh=W0aSVINQ4WBQBgEh+hhrp78+xNaNnGCBpY7bIRuybdE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M/rLiElb1maK6OLMsE5eouL2xLpkhWRMOc915VNRLdao4KvruL0a6aY9tCS8AvBFQTygfDXM5U9/xsCdM/dBTsd82mGoufmD9J/a2flOIoWfeKiepdLt7pU74HjushMCFERPgMPKjN9YNcELdKpyom3eH6e0HQ/EXmj8MK1DhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sb8NePAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sb8NePAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16BD1F000E9;
	Thu,  3 Sep 2026 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447793;
	bh=IpOWKJTaZ/IZI6wGqx/Wkkqj79GyO2syLjcZcDB5y1c=;
	h=Subject:To:Cc:From:Date;
	b=Sb8NePAvWhdJcuqCybBA7XOrsAKgKxG5VKQC+rONqNO3KLRqKGOEBo9TAEX5TAUJP
	 WNeNvUY92h1EvO4wxzgVHhfaIlkqpzUJ8lZuoysl7n+vm5P829MKocjlXLi6kUU+IP
	 tBWpGPdeLzeP0Ppacyi5+8IZSVeKoiPrTvRFJ5nI=
Subject: FAILED: patch "[PATCH] power: supply: charger-manager: register regulators before" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:38:22 +0200
Message-ID: <2026090322-humbling-ninth-d3ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c57cb36f76eb7ced45f57af1a890d8f3a6d76342
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090322-humbling-ninth-d3ad@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c57cb36f76eb7ced45f57af1a890d8f3a6d76342 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Tue, 28 Jul 2026 03:01:23 +0000
Subject: [PATCH] power: supply: charger-manager: register regulators before
 exposing sysfs

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

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 71b6e49a835f..fd4cd9cd2ce2 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1014,6 +1014,29 @@ static int charger_extcon_init(struct charger_manager *cm,
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
@@ -1036,15 +1059,6 @@ static int charger_manager_register_extcon(struct charger_manager *cm)
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
 
@@ -1580,13 +1594,23 @@ static int charger_manager_probe(struct platform_device *pdev)
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
@@ -1620,11 +1644,11 @@ static int charger_manager_probe(struct platform_device *pdev)
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
 
@@ -1642,12 +1666,12 @@ static void charger_manager_remove(struct platform_device *pdev)
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

