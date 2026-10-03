Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DE8472
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791001413; cv=none; b=OnNY7lIy+CyV3CMEsmkV0kQWyAcpaK+eQHvEiAUHwj56IkPx//0OmUDttjOLVeuwGaMCjmBtugEu7VInAb1bobiVmLq1IITFAsyff4nem7wGQ4vxHAZxVmu+kOufP2AnpKvZo6R+JP8210/RGrRHZuLWP6Ug45XLKkDOWh2VIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791001413; c=relaxed/simple;
	bh=3+Kg1V0kj613TsEBc4TB23pXJMX7fcyj2k5xKdQo3zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hx72miYLvxJm+OBA75KQ2PQoigXIXbwhwE5xmZtAnnr/bcpg5S28RMZ386GhKdauHv463im2TxOEjiVTI2Nkge8YIqM0/kJxPPbi02bJEW/8tLwmDDqg94NXv6Lc+gsuY2BxBoY5lkP74Zb9TM8QknVwtJFA0WMmtBQQMdM3sNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWnPBhoJ; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWnPBhoJ"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-535092f91ecso77041cf.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 21:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791001411; x=1791606211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+74pISs7YohlWcbEiaQCNxOuQFMKqMT5VFcFBzXMKws=;
        b=LWnPBhoJD9IBKysXnCC339Lm/cQc6sS7GYv/7MnzsUfGdJRKSNNKtADgqq8tEEbD4U
         g/iXauQt/ja2wHweennjhewMnRWu23CH/PbMmllcTQML/+8s9oep8m55SLev2VBS5+1c
         tjaRlkSH4r6LOaf1zUHtgb3Tx9dnjcWTnBEeelXb1g2T8+gzCS5Dc6aPYk7HF+K/myId
         ba3IE+xDgyOdMdvfsNgSKoDBQk1sI3gsiGFt8id7Dz8+lReIeZT6+uwr85TRcm+c1Mym
         qSTnsm9Av5QBFApJB+FVhexT2fQEP2bur6GkHZEPTp6SyfQo34KSpOm+iivkPbDPMI13
         aJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791001411; x=1791606211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+74pISs7YohlWcbEiaQCNxOuQFMKqMT5VFcFBzXMKws=;
        b=a8eNO7PzX2UATnk0DSrRBthqOaJ2MPoBzVBQOGyKLsDQadXhG9nb5fZjnRj4ndVOSl
         44V8fCCz9PjxJq/R1ul9GJWtiRbjSZd4LF2lrdZ1TV1WNExPDsomnIqSzgRj5aZ7jK+q
         JrTZ5L0M2Ey683ZQdLIJMGMQvwuJolzdJ7298OwX+JRcvMOAykMk2hr0kbQeiPaBV00Y
         kAwYCkRMzMIdA8E9nYOHUXvTZigi7Xhbqeua/nAn8xk+rGdSfmmSb96VW9r7Zi0KLGHd
         hlK+jkQzCl9p2o+PwyuChDtlILhkp3/TBW94iN3CJkZAeeQ6NHm7gNP3oYtVK0+9VIpf
         9klQ==
X-Forwarded-Encrypted: i=1; AKwUvByfsiZ1io4OmWY2O+ZCN1p6kXNKJTSdchBtRSij8EmOLk1a+el/3OWVa+HUgZ+0ESLBTBaqvTE=@vger.kernel.org
X-Gm-Message-State: AFuF++ljyGX6T/B01/laoMP9FDlxPKHtuk7UUdA8e36YwejQFRneVn56
	IEJL5I7vVFL381qEzo6bvbuu+ite1W4em0vqnNUXI8WyNsEq+x3XH7g=
X-Gm-Gg: AYBFou1OcKxBxrBQdHHslPpPT1MPJ6IxDBNEXZRpSIxjXBMTjvZW9DNOzP20tHwmoH3
	uErbLI3n2F/RIBp5sNTYNeD9ujrsPOxu9opyDiLfYUI6LAbNohxl6zu+NyF8CAV2D//Buqu+3fe
	WV6ldJb8SCGjuR9C6eOVO1x2prunF39kHW/75LapEjOAdkNgIJ3Lf1IzEVujH/lDY3qUm3v0Ulp
	5NZE8YiofLADiv2vnAOKuKVMRfrxQHQOH6YdkL0Tx6RB1wto2pVgN8Cu2lqD7mSuU9ZFwysvOVF
	KeK3CbslzL3XlhBS1UZKp5ta24twrs2MUeJzAobPcucfBOJT3N8QPo4q0jpRf4LqMD/pUKfPVR9
	lyt4b0IllUqaM7Xu5l00XjvT/uiO1RpkwSkS3cTyXD2opemtpWiLKAi4N1wOlTJhwMg9rvi+RkE
	/xvoLofBIczRAj/luTqzNv0N4oCbGiyrR8ULqhIM4wmng3UOSxmCWL3A7siiNCDvZ9Hok4c0pRk
	FFuQXP3n9qBwQoAF+Q7VqhpmgPKAwvIUTCPfSd320rupfxV8iK3pPDoSlG1jAA4dt9Au3bF4RpQ
	WrA8Xw==
X-Received: by 2002:ac8:5d4c:0:b0:535:e41:533 with SMTP id d75a77b69052e-5350e410892mr44212181cf.24.1791001411180;
        Fri, 02 Oct 2026 21:23:31 -0700 (PDT)
Received: from gmail.com ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b1aee5sm36666866d6.10.2026.10.02.21.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 21:23:29 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] HSI: nokia-modem: stop reset IRQ before killing tasklet
Date: Sat,  3 Oct 2026 00:23:27 -0400
Message-ID: <20261003042327.655834-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset IRQ schedules a tasklet which accesses both the modem and its
SSI protocol client. Disabling IRQ wake does not disable the IRQ, and the
managed IRQ remains registered until after the remove callback or probe
failure cleanup has returned. It can therefore schedule the tasklet again
after tasklet_kill(), leaving it pending when the modem is freed. The
existing cleanup also unregisters the SSI client before draining the
tasklet that uses it.

Explicitly release the managed IRQ before killing the tasklet, and do both
before unregistering the child clients. Use a common post-IRQ probe error
path so every failure drains the tasklet before releasing its dependencies.
Track successful GPIO exports to retain the existing partial-probe cleanup
behavior.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: eafaebd987fc ("HSI: Introduce Nokia N900 modem driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/hsi/clients/nokia-modem.c | 38 ++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/hsi/clients/nokia-modem.c b/drivers/hsi/clients/nokia-modem.c
index 88924d757616..688ce742d358 100644
--- a/drivers/hsi/clients/nokia-modem.c
+++ b/drivers/hsi/clients/nokia-modem.c
@@ -131,6 +131,7 @@ static int nokia_modem_probe(struct device *dev)
 	int irq, pflags, err;
 	struct hsi_board_info ssip;
 	struct hsi_board_info cmtspeech;
+	bool gpios_exported = false;
 
 	np = dev->of_node;
 	if (!np) {
@@ -165,8 +166,9 @@ static int nokia_modem_probe(struct device *dev)
 		err = nokia_modem_gpio_probe(dev);
 		if (err < 0) {
 			dev_err(dev, "Could not probe GPIOs\n");
-			goto error1;
+			goto error;
 		}
+		gpios_exported = true;
 	}
 
 	ssip.name = "ssi-protocol";
@@ -179,17 +181,17 @@ static int nokia_modem_probe(struct device *dev)
 	if (!modem->ssi_protocol) {
 		dev_err(dev, "Could not register ssi-protocol device\n");
 		err = -ENOMEM;
-		goto error2;
+		goto error;
 	}
 
 	err = device_attach(&modem->ssi_protocol->device);
 	if (err == 0) {
 		dev_dbg(dev, "Missing ssi-protocol driver\n");
 		err = -EPROBE_DEFER;
-		goto error3;
+		goto error;
 	} else if (err < 0) {
 		dev_err(dev, "Could not load ssi-protocol driver (%d)\n", err);
-		goto error3;
+		goto error;
 	}
 
 	cmtspeech.name = "cmt-speech";
@@ -202,33 +204,35 @@ static int nokia_modem_probe(struct device *dev)
 	if (!modem->cmt_speech) {
 		dev_err(dev, "Could not register cmt-speech device\n");
 		err = -ENOMEM;
-		goto error3;
+		goto error;
 	}
 
 	err = device_attach(&modem->cmt_speech->device);
 	if (err == 0) {
 		dev_dbg(dev, "Missing cmt-speech driver\n");
 		err = -EPROBE_DEFER;
-		goto error4;
+		goto error;
 	} else if (err < 0) {
 		dev_err(dev, "Could not load cmt-speech driver (%d)\n", err);
-		goto error4;
+		goto error;
 	}
 
 	dev_info(dev, "Registered Nokia HSI modem\n");
 
 	return 0;
 
-error4:
-	hsi_remove_client(&modem->cmt_speech->device, NULL);
-error3:
-	hsi_remove_client(&modem->ssi_protocol->device, NULL);
-error2:
-	nokia_modem_gpio_unexport(dev);
-error1:
+error:
 	disable_irq_wake(modem->nokia_modem_rst_ind_irq);
+	devm_free_irq(dev, modem->nokia_modem_rst_ind_irq, modem);
 	tasklet_kill(&modem->nokia_modem_rst_ind_tasklet);
 
+	if (modem->cmt_speech)
+		hsi_remove_client(&modem->cmt_speech->device, NULL);
+	if (modem->ssi_protocol)
+		hsi_remove_client(&modem->ssi_protocol->device, NULL);
+	if (gpios_exported)
+		nokia_modem_gpio_unexport(dev);
+
 	return err;
 }
 
@@ -239,6 +243,10 @@ static int nokia_modem_remove(struct device *dev)
 	if (!modem)
 		return 0;
 
+	disable_irq_wake(modem->nokia_modem_rst_ind_irq);
+	devm_free_irq(dev, modem->nokia_modem_rst_ind_irq, modem);
+	tasklet_kill(&modem->nokia_modem_rst_ind_tasklet);
+
 	if (modem->cmt_speech) {
 		hsi_remove_client(&modem->cmt_speech->device, NULL);
 		modem->cmt_speech = NULL;
@@ -251,8 +259,6 @@ static int nokia_modem_remove(struct device *dev)
 
 	nokia_modem_gpio_unexport(dev);
 	dev_set_drvdata(dev, NULL);
-	disable_irq_wake(modem->nokia_modem_rst_ind_irq);
-	tasklet_kill(&modem->nokia_modem_rst_ind_tasklet);
 
 	return 0;
 }
-- 
2.53.0

