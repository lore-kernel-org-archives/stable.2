Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097438;
	b=NoxWhuYwklFBxRURCVUt0RLPptaV7zqt/aJQvzdDu2fFQ2Ca9BilIRS25/2Zn3ZkzmI9
	 nbldX1awzz4Tn5iV7CycDLnJODj5ANlcxvkHfUz29nqNm9i4d9BdI+3bnOYBl0w+jEJGY
	 aw6UEFEKlAwAW2ocYOWG8wtgNK+M5GUO275WIK21R+xgE7U6hy8tOU/XimW7plm5NY9OV
	 /UHdMOqNWn4o8gWLtm47GXrbzY66/LhcUpUvANrQeXnuH/TxH6uheayIwFBUVKr1nhRUs
	 0xeMgGhyzatfQgbq7btec/5u99gYhVnhrE9owhVKefymMJtwoOq+v5N9iEnnblYabLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097438;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v3IV5GjyYHp40SH6f2bDGiVTh8la4nVL3KyO8OOxJS4=;
	b=CQdSKq5qeB2t0Infc8acprZMiPhFd2DsiL9THd5/owJfVu3zIksXR6hgnKsKONWK1B97
	 zNmJ0i77G3seAC/olTFiaaa0SV9laHmB4jJyG/7fBl9Y3dAxNPnL7vVi7QZZ7Y0fAETOg
	 zmlWV1sBUy5NjhOdrIYDfg2Uln+0+xfTQmNgiLTg6roCk0xLJ9GVw9jlo3Nz5+BdLhIwU
	 z7L0OG1IEc+SlZP0gOx1NvjThztYn6pkSjUqQAnbFJbBj5wv4UTyb5+LGea5BF/JsFV/o
	 Gw9dIwUSJiY/rt7jY/7REO3xOFYd0s1M7t1B1GzlrfP2byYLOcLeSQOuz57aPdqMOaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKocDqCs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562BF606A31A;
	Tue, 27 Oct 2026 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKocDqCs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F051F01828;
	Tue, 27 Oct 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097438;
	bh=v3IV5GjyYHp40SH6f2bDGiVTh8la4nVL3KyO8OOxJS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QKocDqCsCLZJBZxgErLPtnUsqJS1Kb6+eexVeVjVFbOggi+oCPmYFHwQOXBEOYf4j
	 7/VuiDHu6y4lX4UivJjq8bebJ0HCl26xcCLOhpqtMeY8lUb0Ef1xWMUmMfGoyTkUuC
	 x9h/du+Q7teYYJMosYgr1/h2Qj69RwLab0pqhg/3d34ua8G/urBGUf6I2VBaaURiKr
	 X8xxzSEoCcbbd1q7gWBdCfSTOlPE+/6cv7fnrOGHQmeqTQuaTOirrczTTC0lsACEoe
	 41s9Ph45Dbwjko7uSSczcB3650BsyjtugSW7+uqrCtKBIbhgrJsTtch0RI/KJkz4sn
	 owG6+fhx+zFhw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Gyungoh Yoo <jack.yoo@maxim-ic.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Stephen Warren <swarren@nvidia.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 11/27] mfd: max8907: Manage power-off handler via devm_register_sys_off_handler()
Date: Tue, 27 Oct 2026 09:30:40 +0000
Message-ID: <20261027093306.2812695-12-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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

When the MAX8907 device is configured as the system power controller,
max8907_i2c_probe() assigns the devres-managed device context to
max8907_pm_off and registers max8907_power_off() as the global
pm_power_off handler.  However, max8907_i2c_remove() does not clear
these pointers upon device unbind, leaving pm_power_off and
max8907_pm_off dangling after devres frees the driver state.

Convert max8907_power_off() to a sys_off_handler callback registered via
devm_register_sys_off_handler() so the handler is automatically
unregistered on device unbind and the global max8907_pm_off pointer can
be dropped.

Fixes: 9582fdcb6fcf ("mfd: max8907: Add power off control")
Closes: https://sashiko.dev/#/bug/linux-d73d6689-d160-447f-9b3c-710fd4c4b6fb
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/max8907.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 7bac1d651771..dab5706d4115 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -15,6 +15,7 @@
 #include <linux/mfd/max8907.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -173,11 +174,14 @@ static const struct regmap_irq_chip max8907_rtc_irq_chip = {
 	.num_irqs = ARRAY_SIZE(max8907_rtc_irqs),
 };
 
-static struct max8907 *max8907_pm_off;
-static void max8907_power_off(void)
+static int max8907_power_off(struct sys_off_data *data)
 {
-	regmap_update_bits(max8907_pm_off->regmap_gen, MAX8907_REG_RESET_CNFG,
-			MAX8907_MASK_POWER_OFF, MAX8907_MASK_POWER_OFF);
+	struct max8907 *max8907 = data->cb_data;
+
+	regmap_update_bits(max8907->regmap_gen, MAX8907_REG_RESET_CNFG,
+			   MAX8907_MASK_POWER_OFF, MAX8907_MASK_POWER_OFF);
+
+	return NOTIFY_DONE;
 }
 
 static int max8907_i2c_probe(struct i2c_client *i2c)
@@ -256,13 +260,23 @@ static int max8907_i2c_probe(struct i2c_client *i2c)
 		goto err_add_devices;
 	}
 
-	if (pm_off && !pm_power_off) {
-		max8907_pm_off = max8907;
-		pm_power_off = max8907_power_off;
+	if (pm_off) {
+		ret = devm_register_sys_off_handler(&i2c->dev,
+						    SYS_OFF_MODE_POWER_OFF,
+						    SYS_OFF_PRIO_DEFAULT,
+						    max8907_power_off, max8907);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"failed to register sys-off handler: %d\n",
+				ret);
+			goto err_sys_off;
+		}
 	}
 
 	return 0;
 
+err_sys_off:
+	mfd_remove_devices(max8907->dev);
 err_add_devices:
 	regmap_del_irq_chip(max8907->i2c_gen->irq, max8907->irqc_rtc);
 err_irqc_rtc:
-- 
2.56.0.307.g5fe7bd680c-goog

