Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412D41F5D4
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977314; cv=none; b=rR+lxPJ3h+AghlE5KKXRDyyhaiUg320DwAjUwKKsNd1lAM+52rRuzStOiJ6K7AEjbnp4atcSQJATrluyarLaVg1wE5841k8HMAB0QTTUUd9jkZ0ibhw/4h/B+qdl8Do5n1/uuSBWb80WQrXR3sQ+uVcYm44HzGOECfuu9r6ctC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977314; c=relaxed/simple;
	bh=SQXaYKVOCPGq63Pv3gBcweqQcXFDdnCWhIv2nfPFCI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JK+Zml9ftj+MkXQ6wABxajgLAJuPDDBhtd44K0IieDGtpfPRZWORx2kqGnO5Fna9J2MD2Jgwt+TiTPOp/efn177NCHrpbSOn7a/kGwSkRC455vCb5llxQfZfFgzcxpSKQ0Jqg1CWssyuer7mrlGHxUqPIZxj1wJBYVzubeaotxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbjYw27u; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbjYw27u"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-5338f2a50caso311251cf.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790977312; x=1791582112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v+6auUbc7rikWHN42UUirm8kbUpP8aG2HoKhX6n9Lac=;
        b=VbjYw27uqlBk5msZBRVvCv+m+TpA4XhQnBeATXl8T+XLYkBBeZJ5mWGcBCceWr7yqI
         YJOSTT6NnmqpBViUHBrm7FCxcBiTFXJ8Q9Ldp4XZ6DRoJKbLJPrMLeUL2/WHfO8kKTFo
         sE05HxRoZWg+pkb4y1w6T5/egy44sSlCb3tOZey5ieUZE08t6q+7xHRp8ESOlsoevWxq
         OYl29BfNonP/S78HdStgbKrwjy5Sp8ifYtQ6IPJ2v9haAM6avVaR5oYyXcMaZwP7BIPV
         PwfKoELaOQMEBLVlqnN0MwZreqaCpVlEuqmVTs1oYP2eRNf2kYIcddfxSmjgjSUOVx/n
         UeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790977312; x=1791582112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+6auUbc7rikWHN42UUirm8kbUpP8aG2HoKhX6n9Lac=;
        b=QFgyc9bhamSF8Bv4eDJNz3mG23+OJNd8YowKxV1u1P275tzfGPhovAFr8xZXwfltS5
         S93Wp0cXOqKFpf03eIhrsE5mEz63aVjuNqWPdAVMmScx88YuTnBhMOokQVW9Ouf830Cy
         W5twEpz88XQfabPWYoQ6RpXockXC7x9sPNnHYgmx3aLBsriAjjQjavMKvX5L+sfFg1WB
         JqmX9mSQjR1UohAOY1/r3dcoy5Qp5inTTXsQWVSWoejI2n2trEh3zzjZdql/js/i6VZe
         Zgg6TLyw8V68JGU4xBk7i4AuqdrNB2G6aqcMl3iVmPIVw0Nj/aAuZb0qF4CJ2cjQNKxm
         KBWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyNv1eP1gipj2H15HtKdKhnh6zcgUsKftUMxKQV6syZsCvLvYbRZYBUzw6sUGnAtyfsbBQf40=@vger.kernel.org
X-Gm-Message-State: AFuF++mFAT7YaZ3KHRovfAHLauKJRhIMbb1/Af6oAcGcTVZjMgiPHFKM
	TvP9aQmIgyDrR1nZxCamhPx4uWdbMisGsriEZC7usha1jYQtmBLm6Lk=
X-Gm-Gg: AYBFou2uUAVm1YNDLW2zWG75TnK2ybFxPPqTYRIjZGv3KI2ZAzrgOB7FJzjqZoA0r6t
	BWKmem4tO+yaZ0SnefZ5s8WSiHzs68vsIP1W1jApQiyEWODReZfGrTserb6E/25SnsFnxRGS7Fo
	1rCo2EZJT8IWWggueza+NmuKdSyyK9O8QLShIJGOpi5CU42RqHDIeFT6mi/h3+d7vqSHeyhH1pc
	Npa8TZ781ug8BRZZFOExdvbP+sUmdmiHKFB0ERDNTJP/fOczRRhXHMvBKSRQ2q5jZsPqMLM9wly
	fr7BHP4bKEhmYEEWJInbklWtQdPI2HXvg0MOG/gTqzM0VfPfwy5CvHLF8/lifkt/gafsY2vYwan
	WnMAtLuOftErYWwBVoc+OPv9d7vbIku50rj/LCBHldudtz3qSKVrfUg/dfxgNDF31bls8c864CE
	IYD0gmIFnC9BI+zK3zWX/LVcV+2yU/G7dcr9f+XXdOuIBmprdRDpI3ZpSUskdY8CCra1UH/+BVz
	qjgzWR0AMPlcQv1p8/Cq2bVmRqpDJgDJIoy2A+ZXGeZPc0Cutluqy4KzGA44njWGLltSCI0TvqR
	DZbDKe9iKJ4INTYOHzbMcpdDiFg5
X-Received: by 2002:ac8:594a:0:b0:532:dc4d:58b3 with SMTP id d75a77b69052e-533cbc8efe0mr74768671cf.38.1790977311661;
        Fri, 02 Oct 2026 14:41:51 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533988343b5sm36227531cf.1.2026.10.02.14.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 14:41:50 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: common: usb-conn-gpio: join IRQs before canceling work
Date: Fri,  2 Oct 2026 17:41:47 -0400
Message-ID: <20261002214148.459052-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO IRQ handlers can enqueue delayed work after remove has canceled
it. A similar lifetime issue exists during probe: once the ID IRQ has
been requested, a later VBUS IRQ setup failure can unwind probe while
the ID IRQ is still able to queue work.

Managed IRQ cleanup happens only after remove or failed probe returns,
so queued work can outlive the state it accesses.

Request both IRQs disabled and enable them only after setup succeeds.
During cleanup, explicitly free and synchronize the installed IRQs
before canceling delayed work. This closes the producer before joining
the work it can queue.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/common/usb-conn-gpio.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 421c3af38e06975259f4a1792aa3b3708a192d59..60badc9a2db8b8e7e621141307de3c1729e8f101 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -29,7 +29,7 @@
 #define USB_GPIO_DEB_US		((USB_GPIO_DEB_MS) * 1000)	/* us */
 
 #define USB_CONN_IRQF	\
-	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)
+	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT | IRQF_NO_AUTOEN)
 
 struct usb_conn_info {
 	struct device *dev;
@@ -262,7 +262,7 @@
 		if (info->vbus_irq < 0) {
 			dev_err(dev, "failed to get VBUS IRQ\n");
 			ret = info->vbus_irq;
-			goto put_role_sw;
+			goto free_id_irq;
 		}
 
 		ret = devm_request_threaded_irq(dev, info->vbus_irq, NULL,
@@ -270,19 +270,30 @@
 						pdev->name, info);
 		if (ret < 0) {
 			dev_err(dev, "failed to request VBUS IRQ\n");
-			goto put_role_sw;
+			goto free_id_irq;
 		}
 	}
 
 	platform_set_drvdata(pdev, info);
 	device_set_wakeup_capable(&pdev->dev, true);
 
+	info->initial_detection = true;
+
+	/* Enable the IRQs only after all the setup has succeeded. */
+	if (info->id_gpiod)
+		enable_irq(info->id_irq);
+	if (info->vbus_gpiod)
+		enable_irq(info->vbus_irq);
+
 	/* Perform initial detection */
-	info->initial_detection = true;
 	usb_conn_queue_dwork(info, 0);
 
 	return 0;
 
+free_id_irq:
+	if (info->id_gpiod)
+		devm_free_irq(dev, info->id_irq, info);
+	cancel_delayed_work_sync(&info->dw_det);
 put_role_sw:
 	usb_role_switch_put(info->role_sw);
 	return ret;
@@ -291,6 +302,11 @@
 static void usb_conn_remove(struct platform_device *pdev)
 {
 	struct usb_conn_info *info = platform_get_drvdata(pdev);
+
+	if (info->id_gpiod)
+		devm_free_irq(&pdev->dev, info->id_irq, info);
+	if (info->vbus_gpiod)
+		devm_free_irq(&pdev->dev, info->vbus_irq, info);
 
 	cancel_delayed_work_sync(&info->dw_det);
 
