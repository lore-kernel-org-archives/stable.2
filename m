Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033439;
	b=Vkl7G5ym+EBfsp2lMMrCr+MED4+/yFDzCkjxB/Ltvo/EjqqNelo3sX7qtNvUZtMBAJQ9
	 604/y0QERzaECO+BTRGhQNj+Ez9ksdKiTNAWSWWIPjtjk6BAAnd/9QuAeg1j+eoKkZl+N
	 zFoetw5VkWQ6fin7Y/6hk6Uy0OMO9+H6luRs5XMDBXIRek1gItxSBoijgoLYqDgH2tnv6
	 ULo5YeAxV+8RqXpZ0Nza70gEcOkzVqTL71mV4qoOLLPnIHO6aqLpioO3Z3Kumti45eHup
	 936Is6FEEIxHBP1gQObf27T40ZWccwOmTSpDFzSMYVjoQZOUUV3uqs5jj8A8WiobdVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t0SasdD5O78Tua3GaSrEY4WvAvJVfv0N4XP5fK5UX6k=;
	b=QQw5kAIibv7IfXmuVSEYiS5ZdAG5EvDrTehNbbPW3HsU+q+H9s08aBxRiustGvLxRyqn
	 eTgd1ZsMb2ekp8ddjHSrpILYPgQZebJRECc1dBLiyrlH73kUJuV+UgvtE9X4d+uF+Z33H
	 GAuUo/QHae5ALvxch6jcOg4n6t3g+et1B+52E54GWAMGD+mDTSrKHpWK9FPFSpRPcccif
	 Si+2tU1uRrvJZ1qtqH2zSkVUa5jCdX584NI0OKruA0a/foPUxliPOp6kNC5ARMoVLlGsl
	 Il/ss06AtJb1hO9GtpswOu7FR3T5npLZfyxmCysN9vhi7Kvpro6O3HlQNa47r4MaVgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R52Okyr8;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00BF606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 06:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C00BF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R52Okyr8
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9d7791b00so10157925ad.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 22:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033438; x=1794638238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0SasdD5O78Tua3GaSrEY4WvAvJVfv0N4XP5fK5UX6k=;
        b=R52Okyr8y2WeBJ90NdR32XbxQ4qgbDLtcRNASwCSEPonXO5Kc5v1Pd5JlH7qxg8t7c
         HPY9y5VlzGvRuhP4EaDj7pc7SUMPeyuDIQTQiLL1DUvL9dIqtGl4Nzt2muqstyyb7q2v
         PdKzpQhDr7TUrNFAC5DkaiGkscPsqeALksYrgIGWZnMrELUFQYBAu36r3nLl8hwCx8wo
         c8VvuWTirrGqgVcKY1fghZht8PDF26snR6l+PqYD0WOqF1kQlvUjzY+EsQA7Bmbh8jkj
         VsJT3HQTR+TrAfRHK7Qla5uR4B6przejXtwubtfe6IGpJF+HeO7J1TIXySmkxCLAwBW3
         /sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033438; x=1794638238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0SasdD5O78Tua3GaSrEY4WvAvJVfv0N4XP5fK5UX6k=;
        b=dSlhVEvfE0ri4cxK1CN2dg0GDKxFK6QEbTNBgCMQ4DhCxpufFK0baeWF7PDaQ3WbCE
         hC3Y+OhJD/w4Fuow7cDFPfa3M1E7ewkItglSn6ReNQFhqZYbBPkkZ3gQ1WFFFfnTprtX
         IH12kiSmpoQ8+wRrNLLr2lJ9WNcmuwHQTQS6C73t48idk7SEnw0RGd7+1W7DLaL1F8pU
         LhPeWnoEKuL0I6ChXUkDSvIAEXZ9YUDLkVFPDjBWQshUnVHwSIVvmW4D7Oqd4Xz473OP
         xUgE7N5AXfaaWy0oCdnWXjRoWiHocdxZdpfKPF2yGyad379yXhOA7ZqrRSNtdDlQOuDJ
         hsGw==
X-Forwarded-Encrypted: i=1; AL+hErFPWCI9MkcfTWD/wqQucqhjKF73as99zUek5fAhFkQvGhe5W/AXNYxlReM4EQlWsvrhlJ4Le2U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QgwyBKvL78KjRWmd302iB6tynmPZKwDqCk+e9bAzTDjhunTdz
	GqTd2A22U3z7k04Zwmg51Ic2zWd0f3Hr3lHRQXOd0SU1aaEGx3RXJ851
X-Gm-Gg: AYBFou2DqYEAV99+/O/HkN6AQs0JxDqEou0WaYzY2FCDO0YFY7kZT/XoOpyihv9RLn+
	gyGPbKPluA0V0zTYFcUoUXN1AItz/3c9um3fDE1ijws5zEOsangNntLIlaUi1ya05KuYmcD23+4
	ZFH5qU1YlvlMhz+xP0iC7xantMw0wwfuTJX16x2vy/so+fZzZO2DiKoIr1c+xIuIst4Eh8H63LC
	0xto4/2gKUq1CXkq3Py8Ccat4PzR79Tw9rkQs+FLqRYpDymlWX9SjskDKxWX25+v7Dok8fOAz3d
	1lwxT2EC3M/iVS9c/NlL0a7GjD4KiBmDAktumhUtTF+A5f+WC3pUsUvw4PlHg2BhSu3yomhTc3w
	01BM4UOFWi0NXWZOfYUcI06aEjf0h35jcD4BqdGyEjZtdyhP5LkUlZ5/9Xa1HP726oKeHGdLpsP
	iLETMeTao6xWC8CnVN9EWRcOl/lLi1CglqFIajDUyHfSKJqmZB5HdIg4dAFLV7ujkWvJhJ5x9af
	AS3HvJHVcVz6bi+Jbh8A2iwMeiaw9j1WRrpxhqtQ6aeGM4FBZhG6z9Fmd0v0ac4AMn05Udin76m
	xi+DAsWr/T2+1V8ayuwAZ1f8mnt+pQ3BDDh1pYbeXoW+Km7OdeQsSIgGaArf8uRY5sDPVQ==
X-Received: by 2002:a17:90b:510f:b0:3a5:c08:4c41 with SMTP id 98e67ed59e1d1-3b0db724f88mr4471992a91.50.1794033438122;
        Fri, 06 Nov 2026 22:37:18 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc23b547sm1597066a91.0.2026.11.06.22.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:37:17 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: CL Wang <cl634@andestech.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rtc: atcrtc100: drain the alarm work before the RTC device is freed
Date: Sat,  7 Nov 2026 15:37:11 +0900
Message-ID: <20261107063711.3388440-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

atcrtc_alarm_isr() schedules atcrtc_dev->rtc_work (atcrtc_alarm_clear),
whose handler obtains the atcrtc_dev via container_of() and dereferences
rtc->rtc_dev (guard(rtc_ops)(rtc->rtc_dev)).

atcrtc_probe() requested the alarm IRQ with devm_request_irq() *before*
allocating rtc_dev with devm_rtc_allocate_device(), and INIT_WORK()'d
rtc_work last with no teardown cancel.  Because devres unwinds in reverse
registration order, on unbind the RTC device is freed before the IRQ, and
rtc_work is never cancelled at all: an alarm interrupt arriving around
unbind can run atcrtc_alarm_clear() after rtc->rtc_dev (and the devm
driver data) have been freed -> use-after-free.

Allocate the RTC device first, then register rtc_work for device-managed
cancellation with devm_work_autocancel(), and only then request the IRQ.
devres now frees the IRQ first (so it can no longer schedule the work),
then drains the work while rtc_dev is still valid, then frees rtc_dev and
the driver data.

Found by code review; not reproduced (requires ATCRTC100 hardware and an
alarm interrupt racing device unbind).

Fixes: 7adca706fe16 ("rtc: atcrtc100: Add ATCRTC100 RTC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/rtc/rtc-atcrtc100.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-atcrtc100.c b/drivers/rtc/rtc-atcrtc100.c
index 2433df3..51a38f0 100644
--- a/drivers/rtc/rtc-atcrtc100.c
+++ b/drivers/rtc/rtc-atcrtc100.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/module.h>
@@ -301,6 +302,26 @@ static int atcrtc_probe(struct platform_device *pdev)
 				     "Failed to get IRQ for alarm\n");
 	atcrtc_dev->alarm_irq = ret;
 
+	atcrtc_dev->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(atcrtc_dev->rtc_dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(atcrtc_dev->rtc_dev),
+				     "Failed to allocate RTC device\n");
+
+	set_bit(RTC_FEATURE_ALARM, atcrtc_dev->rtc_dev->features);
+	atcrtc_dev->rtc_dev->ops = &rtc_ops;
+
+	/*
+	 * Register rtc_work for device-managed cancellation after the RTC
+	 * device it dereferences and before the IRQ that schedules it, so on
+	 * unbind devres frees the IRQ, then drains the work, then frees the
+	 * RTC device and driver data -- never the reverse (atcrtc_alarm_clear()
+	 * touches rtc->rtc_dev).
+	 */
+	ret = devm_work_autocancel(&pdev->dev, &atcrtc_dev->rtc_work,
+				   atcrtc_alarm_clear);
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(&pdev->dev,
 			       atcrtc_dev->alarm_irq,
 			       atcrtc_alarm_isr,
@@ -312,12 +333,6 @@ static int atcrtc_probe(struct platform_device *pdev)
 				     "Failed to request IRQ %d for alarm\n",
 				     atcrtc_dev->alarm_irq);
 
-	atcrtc_dev->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(atcrtc_dev->rtc_dev))
-		return dev_err_probe(&pdev->dev, PTR_ERR(atcrtc_dev->rtc_dev),
-				     "Failed to allocate RTC device\n");
-
-	set_bit(RTC_FEATURE_ALARM, atcrtc_dev->rtc_dev->features);
 	ret = device_init_wakeup(&pdev->dev, true);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
@@ -330,9 +345,6 @@ static int atcrtc_probe(struct platform_device *pdev)
 				     "Failed to set wake IRQ\n");
 	}
 
-	atcrtc_dev->rtc_dev->ops = &rtc_ops;
-
-	INIT_WORK(&atcrtc_dev->rtc_work, atcrtc_alarm_clear);
 	return devm_rtc_register_device(atcrtc_dev->rtc_dev);
 }
 
-- 
2.43.0

