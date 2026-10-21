Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584913;
	b=X8zzfAVWTaVbVAH+2XdNYyCO3QjIUU+5FmXZCPMhbnO1DzkDxLO4NrVfi8cEgIMVPbRE
	 mVqkAqOtxn3826FpokQFhoDp7vefSScJCRIC+thstibpd+rnZDkkciNNIIf54Gjva/C5O
	 KBam0wj5MX0iCaAO0ORdk4qIbGdA7x+V2dq0jaNgKl52CiZb6ynMMuDzcizHdGbwHdOLB
	 DJ4a4EY1ooFImWE0e+ov8HbL7SGIRUkwPLpbypmo1KZhVPiDZ0lsipAQ3SY8jTPvSVFQ/
	 PNGecnFORTJX8nT0TTWf5jyy3OwLB3ADek4P8sLlTyI9BKnrcm0eKoGk7jDD2QfGo9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584913;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PiYeFnzfwHlkjTQ+eA/0wscevPQtvBkPEp8lt8rq5bA=;
	b=C1Ck3VNGP7dcfAws8pD7JaCS8i8VCczn6vcRqejRJCYvKBGaXhO3NkUoianrc0LQHWzZ
	 NuyCpHQmqPq1nzv/IRma2FVi5320nEKes3SOPhzL8eYdrPz4rXyH/eERU4DPTy/UaJvF8
	 OnbSEoM3hBPranlN7nOwFqTW9GLE5zkj0iLUrkCewWEL8d5uoX7ngN4+v8pi9wN0fpzS0
	 KcG2w3NprBNovlRlOSlgzhlzTgXyrVaMHw6PPnRUUCuAAWEgkIyfRxrN6bf8ZCbLS7fAY
	 7JJA6bSx7grdU0y4qUX5jQgPvadjJT4gmnalPkdlNYlFd8UCg0MMYSaK0Jxw8G9yObw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8Adj7eF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77160A4AFA;
	Wed, 21 Oct 2026 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8Adj7eF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABC71F000C4;
	Wed, 21 Oct 2026 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584911;
	bh=PiYeFnzfwHlkjTQ+eA/0wscevPQtvBkPEp8lt8rq5bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f8Adj7eFCqpdiOzX+nrgmViaHr2MGceEUk0xq8+EyfZeS6GapHiSZN0AcwCI9Rp8g
	 0TfTs3BFLR94R/zQqWl+jbvrbwHioG6QqYVs0fr2TM/WIRfzrTQs/ayajM6jEysMlk
	 och5mcI3/j3fERNQDI0VcEgKOayIqxKZq3Tx8OjqSgIeCpfkVBnUnfzwllvnehjv7y
	 lgtqPAGBWSb02z4rj+o6jgnaUGU0MrUsry7WwiUBnbddfxGRJPXlyzYNWV6jalLjkO
	 64Jy3zKmMwe/Hw0wtqcBQVkisjNm0Icn8OpDDZYfz3wPsv0dKaUQK2i7ReOx8R8PkR
	 +PSg3c8+oYFgA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Gyungoh Yoo <jack.yoo@maxim-ic.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Stephen Warren <swarren@nvidia.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 12/28] mfd: max8907: Manage power-off handler via devm_register_sys_off_handler()
Date: Wed, 21 Oct 2026 12:09:34 +0000
Message-ID: <20261021121245.3111563-12-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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
2.56.0.218.g1ec904b173-goog

