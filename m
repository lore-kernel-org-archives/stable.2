Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971094;
	b=O0vApYuTiI1wtb0G0VRaKpUTNM9ptMoYAS158XttL1oOptRj/bUjcxaOu9V2mwYOemNg
	 mO7N0XxopwPSbNVAh2fX8ACefP4sWSVwv2doOlq5nDmHIoPBrFrv6W7Jm6b5+/xW8JsFN
	 DrF0RgI1bLTtKwPC6yShkuA4HWD5Pn0LHquRWxOnutiW/MDmxb3CdEZumPXyVRBFiJ+TD
	 EoqFoD4e57f0/hqmuomsSfAF7U17uUM7I3PG4RJwotu/mVZuTraiBw693ichlLj6CC+zm
	 J871fQ1hSaJkmfBexYuweUObohLnBSyXov/ZwCY4XmmRSIjXbV5zSWoxGKfE1EZjUJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lyVXxhqVdS/iGnj6NynJN3xUIHVLrLvXHKOHq+9pwkU=;
	b=tEEEAE1vpf/S5x8/S+qcctBtXNtlW1oGFOBjo0zYTDbeHXn9LtKtyweklB8Gi6fHqQ5l
	 zMJs214SGKJLhP/eBN+XQDm2xty8+qSuX5iPEw1j6JPaYougfdVQ9MZOfeZPhPVOD38O0
	 rRnQrpTbY4Xvb7cGvB9xhtCboC5eiuAZ07oa/TclH/Br+7/VL3qpGYNuJsKCqWVNUzYjW
	 aUeBgvSLH1t3O767hMLlj9NpbWX5NkPwNSGwLW2cEk2/OQWgju4tbWwHUnCeYnzdpv8Se
	 tJz6+Gi+4WMq/6VPuNJox+F5omSdAnQS8huR0CMh8e3bGPkf14kiNln9ZAYvgFxZ5pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7Dn4nS2;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C26D606A338
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C26D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7Dn4nS2
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so360147a91.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793971094; x=1794575894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lyVXxhqVdS/iGnj6NynJN3xUIHVLrLvXHKOHq+9pwkU=;
        b=j7Dn4nS2FlTDkjtWUWwow620dude761rH0HztMU08Ws7MnpuJgtahTKaGW+wxQa6Xi
         t8Bw9fPSFTvs3qnx01Yrmo8pvJZloKokkDFR/hMUJkb5Hj8nUadMOspNIAhtVhccdjhT
         3dlFxzhw2IabHdEp7i9bUqZ7AHYMgQAqy97E5WPoQqO6YA9Ol4x7kthmSxUOfDJMpHUy
         H8LFV/D8/ViViNYVEHiZ//WcpfY+F6aF6gp/fCPXHD2dssuwGgLgV4uKehiHxeCzaVyF
         EOMCZb0QlFJ3qFLPUIOjamEAOn7Npd26BFz1RbMHN7GnKFhYyCPGb8Og3ZUILArCcQpo
         7YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793971094; x=1794575894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lyVXxhqVdS/iGnj6NynJN3xUIHVLrLvXHKOHq+9pwkU=;
        b=S2sVOFIE17HnKu18qoNww+Ur77Pov9w/5wC2KJdKk9bDU8/4p3wKBmu6J3lrETd8CB
         i9kxYPiX8nnHGElEyhM7wDLep6g8jXDrnAbTIHMtnmRMDgRc45gbWItey8wZSuCMMR4W
         PvVtNFx0+WtL340YV41qk71FLq17YMCwQfaX/UjmRVf0+TlobyBOkbKjFRjcDhxyN7g1
         j63e6x3sSnOUM+RRCYQjrTWDW7M343wAslf6b5zI/aaopr4mKQhmqmho5wEpS0tP5YIT
         Giu+PiORluHwu5F1VUr4Y0+HOwaaqqIbGfzy9pWq8XEQXj1jCfl4YKgRnKws4zzYUMvG
         3fhA==
X-Forwarded-Encrypted: i=1; AL+hErFf7tRgUY16oGRrAe+yME3T4ZYeOTKlAixpjYrLLSLKphxnmaMe6Jx+QJwTo7VcgYQCdz9B608=@vger.kernel.org
X-Gm-Message-State: APuU4Z+21lub3oF0Wh4AH6nSsMZ0EQDoGUiInmyeIatqeIoXcjd43Dpn
	Fd22We4rIbyj7u7/+CG2GwvwVp8qYJBbPR8vAisM0NS+8K/mvfOtXxwR
X-Gm-Gg: AYBFou0YHQcvKbVnQOlNy+UN20ZQK9ZnKEHyMbdLWw+tjrMoFYOfrZlNe6qlD8s10yw
	N4VkzcImFLeqVfcc6czowyKuNsKddge9JXDqY9EGyslc3VzMAKD/izMtMunOF06DEQXmD4Nezab
	MCsdgjW1HqXLS3WOW/6ieEGlqxxFh2z8E9np26KJdpbBP0RZXzsifiGUn5Cj4UYUDgoHzgVz8Hy
	2CncxhTKTioDOfsjWkbvZq49EsFQbO96ldSVoPYbkzu6E95KJDlI28ajnNwLqLN0yWQPpYW+3qX
	IrhSljJEhVALNiq427PozHZcVxMoW+xVwbNbYrJtH2PtjZNTlPZXYU/OvawdPhcEQxrW+iOCuTn
	gco2BrKF3LrVVBzavWMA5KjAdiKnZlJUhn9oWaT1jQ2krQy3hCmLiZkbHyvXjxjy34nWtvTCYxw
	yKvIs6LKY2cMlZFwRDZwfjWHl3nK80b8iFbhhhB5uuvaGTlgxbLka4dLRAIMX55sJhCeucwsuXc
	ErGpHPWXmqhl01TkLtgW+rYgfNRZlMm1ir50OALNxc5O1RMc16Hd8fANVzEJ1QpH7SYTjZyRNDJ
	29iYyBfeKUUstm3Y1WvNK51wOmcXJcnI6g==
X-Received: by 2002:a17:90b:1fc7:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3b0db6ed2f0mr2460315a91.60.1793971093785;
        Fri, 06 Nov 2026 05:18:13 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0e2a8d6fbsm1025636a91.1.2026.11.06.05.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:18:13 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] extcon: max77693: drain MUIC IRQ work before extcon device is freed
Date: Fri,  6 Nov 2026 22:17:30 +0900
Message-ID: <20261106131730.2633139-6-hj351016@gmail.com>
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

max77693_muic_probe() registers the MUIC interrupt work for device-managed
cancellation before it allocates and registers the extcon device that the
work handler dereferences:

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

max77693_muic_irq_handler() queues irq_work with schedule_work() on every
MUIC interrupt, so a work instance can be pending or running at unbind.
The handler max77693_muic_irq_work() dereferences info->edev via
extcon_set_state_sync(). Its only early-return guard tests info->edev, but
info is itself devm-allocated and freed last, so in the teardown window
info->edev is a dangling (non-NULL) pointer rather than NULL and the guard
does not fire. If the work runs after the extcon device has been freed but
before the work is cancelled, it dereferences freed memory, i.e. a
use-after-free.

Allocate and register the extcon device before registering the work for
cancellation, so devres (LIFO) frees the IRQs first, then cancels the
work, and only then frees the extcon device. The dock input device the
handler also uses is registered earlier and thus still outlives the work.
devm_work_autocancel() still performs INIT_WORK() before the work is first
queued (the IRQ handler, requested below, is the only queuing site).

Found by static analysis / code review; compile-tested only, not
reproduced on hardware (requires a MAX77693 MUIC).

Fixes: 74047eaa2281 ("extcon: extcon-max77693.c: Fix potential work-queue cancellation race")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 2c567e0..f151787 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1128,6 +1128,20 @@ static int max77693_muic_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 	mutex_init(&info->mutex);
 
+	/* Initialize extcon device */
+	info->edev = devm_extcon_dev_allocate(&pdev->dev,
+					      max77693_extcon_cable);
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
 	ret = devm_work_autocancel(&pdev->dev, &info->irq_work,
 				   max77693_muic_irq_work);
 	if (ret)
@@ -1156,20 +1170,6 @@ static int max77693_muic_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* Initialize extcon device */
-	info->edev = devm_extcon_dev_allocate(&pdev->dev,
-					      max77693_extcon_cable);
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
 	/* Initialize MUIC register by using platform data or default data */
 	if (pdata && pdata->muic_data) {
 		init_data = pdata->muic_data->init_data;
