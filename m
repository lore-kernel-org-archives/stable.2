Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C12383980
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790443281; cv=none; b=sqzAB4/aDuuq7Q+RGJ9FetYtlCjFS9MU/270c9Xj1ysgIBCO5GMz9xBtCVAPm5+D87dHoEkdT0bltdKIxh1/IoqHqeVEuApt2/lfKrnkhrIHrPqyAaFOSaWuo/1SRchC++6X+JC377ph3ll91chsI4eDAfWLLCVcflkVERJmXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790443281; c=relaxed/simple;
	bh=r8HxKt0y8Dn/q6FFwqRAaZx4ISjhVY18Af8HDOWOtJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQf2Wn1zMaGwryKe4H0h+oYHoHklzDhjYYJbLKPe7WCN76eBjFP3IN+IcYm8c/IUnT4slz9kTLY2b1V/9dvcM4JRh6e2XxZ8tH1tolQZ9Nghpk+aU2o2wa9Jn8zzMxUjGY+5OdXYo5FvLezQHQiJOJOorU4QTb8Y9tKpvUmxBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9WTRFjP; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9WTRFjP"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-4938dd40902so954995fac.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790443278; x=1791048078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x02wxXy9eBaknTCUIBHusevlZwUPADcsIU5t7Qklh7U=;
        b=m9WTRFjP3+x/y/m9E6UApbVquVH0q1qW7L3NUrbSpoftdo0lUuZiGJP20tedXsxO20
         oiidejmH/1i8aFkLKLRJZLifwphmEqHXBSqI3qJPSHxhom/lmz3qosv9BVYxi/jF0nA0
         9tsfWIL86kySyL37LSIKaoYS85gsVhtuG+EA8wLbNddMBe+FRGP+OdzS2WCL9KnJrjuV
         gadl5yMH04mSas7tRJQg1ECuHpC5u0RH8hl6KLSWqx6y8Oe4ldnYKMFhvCfw3YU95vNp
         neSO8NqQ1vLW1vQQ2TuYgG7q01zvgxJ6vmA73noTkWyZ8R1H0yMVmk8Cd70nXtLZ05VC
         3rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790443278; x=1791048078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x02wxXy9eBaknTCUIBHusevlZwUPADcsIU5t7Qklh7U=;
        b=Zv9/UTlXe1JE7OInD+TVhsl2c4ia0cdqntW2CTCRu4gqGJ4i+eX5B58xOxqlCthPpk
         fLgqT8xQAk8eDODMu66+qMvV4yYj9DVLRuwW44/rc3OkEEFW+PAzy4gcdiwyEMJbujMa
         cPVjP+Or6BdT0ByC/UEugjQ4QUSuXKCji2GVn+OBWq/nX1SV8BA59FKTvFnDX1z1aESC
         zJcwtsh5WbgiU1WTM1GNnE44WKtwc/EYhs7R/ZToSgGdcoVy3NueJSTE2K9nKF1EHh+0
         /FdS349xh2eQIniENRpoR96OUNOlcVE61iuI5UV3K/uyWh7xBHXIW9rYafuSREQlpYZC
         mQ9g==
X-Forwarded-Encrypted: i=1; AKwUvBxvcsdOPfFCc1vTwYAM5Ji1kKgKuH3e3nec203tcge5442k6X3CiycNlowmpL86XP5yD6Q/ubk=@vger.kernel.org
X-Gm-Message-State: AFuF++kLyWmuAVqqYZdsL2E4TJjkRcyntV3RrgFpHUDuPgHVNVJtgBa6
	g581c1qKbAiU2/gAxf25tXKrrUm6SOT4SbBpcy1KRNTG2oNlsLsnYchq
X-Gm-Gg: AYBFou33PfgMkuBdTzsFfCxflZkRPxN4KPpoNUTfdr18JHU24ZUtqS5l88TI3q8JjHS
	Do88NZUrnExyZ0WnCH3BN/YZPR3PBc5/gpQ19x00MntXtDErP/PTehxpp8RnbfZz+P6sH6Bsctk
	EJ30316mCpltq4++04IoQaTQ/yJyNcffRrNBPmh7s7f5OSrIACk3lmtO+RvfxvLqsmfkLAf4ZkW
	p2XvdYrIN4MopyzJEMgrxMo0SLmVE7MlLLCjD8BpmI5xrg9FlWAhMjcaHxi2DgJYpH4/Uyyzq2S
	l+x1ZczhE6U1FaoMRy+9HOkqDUkB8NxBOYYjdQfNp7PeRJwwdRFO2iDZoKGBzVWHStQlDzbJVT7
	u1NJ5k8AOwne0uhpgnosJlkY332MjAR6XQDljAodI0tvHOKGzo4gdn+QfU1vkAlKoBM94doMCOZ
	ZGDb0K7QTiWm1P+DmmQ2aOJ3XvD84As7n6NocPukEGD6FrTw0KRK7of4R1R2dFOlFHVz8BsHrwr
	q7QQeV27gFc1FU3kQiZv/qlPAopp6b983K0MulUXQDOdmxmHFk=
X-Received: by 2002:a05:6870:7886:b0:475:e066:771a with SMTP id 586e51a60fabf-491e95119a5mr7660296fac.33.1790443278638;
        Sat, 26 Sep 2026 10:21:18 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493356565b6sm5407325fac.9.2026.09.26.10.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:21:17 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: lee@kernel.org,
	pavel@kernel.org
Cc: afd@ti.com,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] leds: tca6507: Fix use-after-free on unbind
Date: Sat, 26 Sep 2026 12:21:15 -0500
Message-ID: <20260926172115.543800-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the LEDs are registered with devm_led_classdev_register(), they
are unregistered only after tca6507_remove() has cancelled the work.
Unregistering an LED that is on turns it off, which queues the work
again from led_assign(), and the work then runs after devres has freed
the chip:

  BUG: KASAN: slab-use-after-free in assign_work+0x414/0x5b0
  Read of size 8 at addr ffff888010d5c0c0 by task kworker/1:2/65
  ...
  Last potentially related work creation:
   ...
   queue_work_on+0xb6/0xc0
   led_assign+0x223/0x340 [leds_tca6507]
   led_classdev_unregister+0x26b/0x340
   release_nodes+0xb3/0x140
   devres_release_group+0x247/0x470
   i2c_device_remove+0xbf/0x1b0

Set up the work with devm_work_autocancel() before the LEDs are
registered, so that devres cancels it after they are gone, and drop
tca6507_remove().

Fixes: 1b5c2fa7081c ("leds: tca6507: Use devm_led_classdev_register() to simplify remove path")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested in QEMU on a next-20260925 KASAN kernel, with the driver built as
    a module and a test-only module that adds a fake I2C adapter and a
    software node for a TCA6507 with two LEDs. With the LEDs on, unbinding
    hits the report above (38 reports in 20 unbind/bind cycles), and so does
    unloading the driver in 2 of 3 runs. With this patch there are no
    reports in 20 cycles or 3 unloads, and the LEDs come back after each
    rebind. A W=1 build with GPIOLIB is clean.

 drivers/leds/leds-tca6507.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 9afe2722986c..503a465a07f4 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -79,6 +79,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
+#include <linux/devm-helpers.h>
 
 /* LED select registers determine the source that drives LED outputs */
 #define TCA6507_LS_LED_OFF	0x0	/* Output HI-Z (off) */
@@ -735,9 +736,15 @@ static int tca6507_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	tca->client = client;
-	INIT_WORK(&tca->work, tca6507_work);
 	spin_lock_init(&tca->lock);
-	i2c_set_clientdata(client, tca);
+
+	/*
+	 * Unregistering the LEDs turns them off, which queues the work again,
+	 * so it must be cancelled after them: set this up before registering.
+	 */
+	err = devm_work_autocancel(dev, &tca->work, tca6507_work);
+	if (err)
+		return err;
 
 	for (i = 0; i < NUM_LEDS; i++) {
 		struct tca6507_led *l = tca->leds + i;
@@ -766,20 +773,12 @@ static int tca6507_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void tca6507_remove(struct i2c_client *client)
-{
-	struct tca6507_chip *tca = i2c_get_clientdata(client);
-
-	cancel_work_sync(&tca->work);
-}
-
 static struct i2c_driver tca6507_driver = {
 	.driver   = {
 		.name    = "leds-tca6507",
 		.of_match_table = of_match_ptr(of_tca6507_leds_match),
 	},
 	.probe    = tca6507_probe,
-	.remove   = tca6507_remove,
 	.id_table = tca6507_id,
 };
 

base-commit: 05b4738b0078f7d6f154f68068a11c8a0635e9df
-- 
2.55.0

