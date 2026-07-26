Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255501F942;
	Sun, 26 Jul 2026 05:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785043014; cv=none; b=qs2KiyYhvGGjFAUXPLX0Ft+FNivOeomAeWC6f50gN2kosXX6sQdazSxDWq8RzJPLetPcm+L3OZNtlK0Qk1hRIQzuuoH2hhozIObXZlioNVbGp2KhGrx0udeJ4jA1iXFOo8SgFmHtrz55/Ri+lNQIHvdDE9rRVlsaxeU/8npzPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785043014; c=relaxed/simple;
	bh=EmZGfhVZplLDaIXdntQ0ZUohR4FiaFQsApsVoO5QC7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ST8bSVm9q0SEJEU9ke+UWReCa2ewMufxucdMw9BpLR6TMCvX8Jg72OSAf3GLa/n+G+LkacXdqmob8M7TUPmjKTdkhlfhUSiQREoZ9DSpQ/UbLaS6NUfINht34RARvW4Ctoe2g0/I+edsnMJ6UNcl3RkwkszA+9dUyIAf5PtjSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCHVSk2mGVqA7Q+AA--.15339S3;
	Sun, 26 Jul 2026 13:16:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgA3cXQ1mGVq65uSAw--.57198S2;
	Sun, 26 Jul 2026 13:16:37 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	myungjoo.ham@samsung.com,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: charger-manager: tear down sysfs and disable charging before freeing regulators
Date: Sun, 26 Jul 2026 05:15:40 +0000
Message-Id: <20260726051540.35579-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgA3cXQ1mGVq65uSAw--.57198S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?FkVv1AXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WPnfcF85k2qTd83kH1bbSkBONGCk98AN9gDAzS++nRB9riY
	KvbKan7pevNwvR0525Op9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxGF4xWw17Jry8XF18Xw1rZrc_yoW5Cw4UpF
	Z5CF9Ikw48ZFWFqr4qk3W2k3W5CFs3A3sI9FW8G3yavwnxX3WUXr1UAFWSyF1UJr97XF42
	yFW3t3WSyFy5WrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU2LIDUUUUU

charger_manager_remove() and the err_reg_extcon probe error path call
regulator_put() before tearing down the power_supply sysfs entries
(power_supply_unregister()). charger_manager_remove() also calls
try_charger_enable(cm, false) after the regulator_put() loop. A concurrent
write to a charger's externally_control sysfs attribute that lands between
regulator_put() and power_supply_unregister() can run
charger_externally_control_store() and call try_charger_enable(), which,
when charging is enabled, dereferences the already-freed consumer handle
via regulator_enable(), regulator_disable(), regulator_is_enabled() and
regulator_force_disable(). When charging is enabled, try_charger_enable(cm,
false) in .remove() also dereferences the freed handles directly. Both
leave use-after-free windows.

Move power_supply_unregister() ahead of the regulator_put() loop on both
paths. It ends in device_unregister(), which removes the sysfs attribute
groups and drains active kernfs operations, so on return no
externally_control store can be running or start again; it does not touch
the regulator consumers, and psy->desc references the devm-managed
cm->charger_psy_desc, which outlives the call. Move try_charger_enable(cm,
false) before the regulator_put() loop in .remove() as well, so the
synchronous disable also runs on valid handles.

This does not address the separate extcon-notifier path, which needs its
own synchronization design.

Found by an in-house static analysis tool.

Fixes: 3950c7865cd7 ("charger-manager: Add support sysfs entry for charger")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/power/supply/charger-manager.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index c49e0e4d02f7..c1df512f32a8 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1622,11 +1622,11 @@ static int charger_manager_probe(struct platform_device *pdev)
 	return 0;
 
 err_reg_extcon:
+	power_supply_unregister(cm->charger_psy);
+
 	for (i = 0; i < desc->num_charger_regulators; i++)
 		regulator_put(desc->charger_regulators[i].consumer);
 
-	power_supply_unregister(cm->charger_psy);
-
 	return ret;
 }
 
@@ -1644,12 +1644,12 @@ static void charger_manager_remove(struct platform_device *pdev)
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
2.34.1

