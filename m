Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971085;
	b=iU16siNj6rfPMR4+ugyhLmL86qsdXB6pb6G8gNu05kz5VBdLDC7iCv1WQsUe5ikOb6DF
	 kmSAMiOjA57UGW6xyWfMFMRQATIK86I2xKjw+6iYWr23RGL01FIIO/HVpBVFKGoXxcWQn
	 XUIRXswKwP1V0rw2C8fauXJnS5VJZ19j1lVS5D5cgRK+GOq7DggFG+85ovEwmiYgiE72z
	 IpAWMNS4uiRPgSpogBJoP8dBClyBvZ7lVFaCKHcxeNn3vSoUb44X5xi5q/+cXdBdXAt4e
	 cy09BpWG8InOjY6G5GwYlKzcbd2m9OTD2/dublsA4NheAZZm6CcWpW5Po7rVxg5OGWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Dz7o2nl3YbVAvhy6+Qf4x0LfNDPFm8y7nAlJp4YSP1Q=;
	b=TdFMtV674ZWZ4MlhU/9x+tp8XwreldrnxHrMlFkH8V4zZPFFlmc+GdVpqHJ5wMYRvDn/
	 peTi5c1mbNGUtlByl34U/Sc5lT1t6rtWVyZjLEPnQaBcUZrup9Fe40Po5L/Ptp2lRjKiq
	 bxRgifzdtWUED9Aqs4Jnk7w3Vp7zbhEqi5SK9YyGNIhT6R3vi8uPIZ0vb0nS4CzCqWV1R
	 f/3IclL+dVzU1jZZftvGj430BI0e83or1IQhl3QP5VJlj0p4/uR29uxFEX3mK+L+Dt+V9
	 jWsODxE3f5e+QZzDzXOvlDYEwgg9lgqXakdZ9D8eC/xQJk6EpuMzzHnOMMUhfcdIBJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A/CMeiFO";
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48096606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48096606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A/CMeiFO
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso978163a91.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793971084; x=1794575884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dz7o2nl3YbVAvhy6+Qf4x0LfNDPFm8y7nAlJp4YSP1Q=;
        b=A/CMeiFOpwChXu+gGgOnhDCfiXDypN1UICLSZACPhx5cv7EENCB7NnLkEnA+YSiAF3
         OY3jcSURjpf6OO2+qspOv7CQTuoSUIqtWtOOuSJKTssTGtIZQO+Utdshl6kO+yVAYnFX
         2jr96VKUbNi8h/xVMsog0LwbAS4BVHyci6ZQ7Pk94BlE2zlje9hq2bJfj68FneHdQZC/
         vMh25aYAVS+CLD2xCJS8iQiQTjU3FX9ya8DZlSl/NsaB27ZFasPtQJG3wjOvwwqw785p
         EYWxeYuoDXleahTrASk0Z0stV8NR14gNs2wlOe0bj4lzHc3+xAV8kfocfrMnSsA1MpCQ
         ahxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793971084; x=1794575884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dz7o2nl3YbVAvhy6+Qf4x0LfNDPFm8y7nAlJp4YSP1Q=;
        b=ViqvtnSkaNipIBA2pqcXzuk4d5kWUUukEdyA0pN99RyYE1jE4bGLHLg8tt5TgnLO5M
         B94kJvbBQYV9U6YBPbFXOvRi+f0BtTmLZk/TfRk4DWfIpnS3F8Qf0MizshTYVXL59flo
         Co20M3gJJw7MM/Do+1UtaW8i+MqYbsP7+uOLbRk74EqLjj5GTayDS9trJKra1y6ho8mG
         i6DWVY1He0OagdLUTOKtm3TeUjhR+uMJJx0vDMS1Yi+gfztRFYoFH9foMb45HycPnYgK
         0S9zqpDL6EGyQ601pS2rTsAPpWLKusGM0kroyhdSVtRcmb/AD4sQDB8Q+0gGu1qZQf58
         xHMw==
X-Forwarded-Encrypted: i=1; AL+hErG5j7AEPH1PKhyQiXaBCGWle5mejAQIZC8fuK9CS/t5mcdoY3wWvtjYkSQg2PZCeiBipg2fJhs=@vger.kernel.org
X-Gm-Message-State: APuU4Z84DuCIVFa2VBEqtPgm6Bid4eOGivncPvtanqR3dO9wv4Uj8+1/
	vTjg4jpx/GGGxuo+W0v+TARfOr+mrVkFFyJmRBDYlrLH/jMzoc6Vj5+S
X-Gm-Gg: AYBFou3DhVf9hnElX8vBwr/QyrzClqXVUzaLXHOqMsBazvsDx7T/YCO9ksj0wKvxCB1
	l/sr256eudnRHwIMnv28Uh0CZUVY1vC8/Kotguvro2JZla9uvqHf77EkmJQYQmL8ECptV7uRh4b
	2Xo0rqGIylgfXIHWhF4JWUGc550uf7DWDhIrU0S1aytu+hJaabJ5lGmzSHUEmO3rFc0Ykk+tycZ
	k2U1djwIF8b+E1nYRsVnwONPUlECbRHIU21ZKki2Sl7a7K67n15kmRMENYkZruSLLUgcuoUucyz
	+oksFQGj+FZ81xs3z7anM8rgQGKoSQkIV50N3RooQ0lfNZoP4f6FEssmfRj4TdYAvjlyaHEfZoG
	tC+nHzCL8OldakUYNdPUjuMWQnLtu+l4HMGu/jN0WYsS7JeFv6vjWn/SSwnwh5oeerrteccjSMo
	W4lKRzcCFASVxsfgk9yCLnbuy9AA5oi9Wa451+Zf3I7J3ASBBBTRntBDbcHJQAT1P+hHfiWjXql
	dvcSYdJpThIik2BTYvmMx9hLIVou6hvnvgFLDvgMVCsP9vLJSRuXXMhaBEPDqbztDCAGjvSNP3e
	Mix2cKZIKMo1111wFELXFYXlUz27mcLsZ1hmFcRNEF6Gf9KIuAKtBuUGe7ZQWFPt/oq0WQ==
X-Received: by 2002:a17:90b:584e:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3b0db6e8c8cmr1498160a91.25.1793971084246;
        Fri, 06 Nov 2026 05:18:04 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0e2a8d6fbsm1025636a91.1.2026.11.06.05.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:18:03 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] extcon: max8997: drain MUIC IRQ work before extcon device is freed
Date: Fri,  6 Nov 2026 22:17:28 +0900
Message-ID: <20261106131730.2633139-4-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106131730.2633139-1-hj351016@gmail.com>
References: <20261106131730.2633139-1-hj351016@gmail.com>
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

max8997_muic_probe() registers the MUIC interrupt work for device-managed
cancellation before it allocates and registers the extcon device that the
work handler dereferences:

	INIT_WORK(&info->irq_work, max8997_muic_irq_work);
	devm_work_autocancel(&pdev->dev, &info->irq_work, ...);
	...
	devm_request_threaded_irq(&pdev->dev, virq, ...);	/* arms work */
	...
	info->edev = devm_extcon_dev_allocate(&pdev->dev, ...);
	devm_extcon_dev_register(&pdev->dev, info->edev);

devres releases resources in reverse registration order, so on unbind the
extcon device is torn down first and the work is cancelled last:

	/* free_irq() */
	devm_extcon_dev_unregister() / extcon freed
	...
	cancel_work_sync(&info->irq_work);		/* too late */

max8997_muic_irq_handler() queues irq_work with schedule_work() on every
MUIC interrupt, so a work instance can be pending or running at unbind.
The handler max8997_muic_irq_work() dereferences info->edev via
extcon_set_state_sync(). Its only early-return guard tests info->edev, but
info is itself devm-allocated and freed last, so in the teardown window
info->edev is a dangling (non-NULL) pointer rather than NULL and the guard
does not fire. If the work runs after the extcon device has been freed but
before the work is cancelled, it dereferences freed memory, i.e. a
use-after-free.

Allocate and register the extcon device before registering the work for
cancellation (the redundant INIT_WORK() is moved up with it), so devres
(LIFO) frees the IRQs first, then cancels the work, and only then frees
the extcon device. devm_work_autocancel() still performs INIT_WORK()
before the work is first queued (the IRQ handler, requested below, is the
only queuing site).

Found by static analysis / code review; compile-tested only, not
reproduced on hardware (requires a MAX8997 MUIC).

Fixes: 87ee8de23c9d ("extcon: extcon-max8997: Simplify driver using devm")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 9cddf08..a54e7c4 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -650,6 +650,19 @@ static int max8997_muic_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 	mutex_init(&info->mutex);
 
+	/* External connector */
+	info->edev = devm_extcon_dev_allocate(&pdev->dev, max8997_extcon_cable);
+	if (IS_ERR(info->edev)) {
+		dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
+		return PTR_ERR(info->edev);
+	}
+
+	ret = devm_extcon_dev_register(&pdev->dev, info->edev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register extcon device\n");
+		return ret;
+	}
+
 	INIT_WORK(&info->irq_work, max8997_muic_irq_work);
 	ret = devm_work_autocancel(&pdev->dev, &info->irq_work,
 				   max8997_muic_irq_work);
@@ -678,19 +691,6 @@ static int max8997_muic_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* External connector */
-	info->edev = devm_extcon_dev_allocate(&pdev->dev, max8997_extcon_cable);
-	if (IS_ERR(info->edev)) {
-		dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
-		return PTR_ERR(info->edev);
-	}
-
-	ret = devm_extcon_dev_register(&pdev->dev, info->edev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register extcon device\n");
-		return ret;
-	}
-
 	if (pdata && pdata->muic_pdata) {
 		struct max8997_muic_platform_data *muic_pdata
 			= pdata->muic_pdata;
