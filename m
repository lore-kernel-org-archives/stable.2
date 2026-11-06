Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971089;
	b=PdxFUMSCSxQgVcoK5+CH6VbOwUiVaii+Q9ywsDIPHC3VbZWdDrCQF5YEjeYrzmsyjJwt
	 55Dwn4j9WBzH7Y4XueoO5IJMv8CI0x455/cVscMrdvO+xrFtxafVfwrQn3EqIi1m9EGcC
	 0OU0YJV9543Vi0BgMg6ZMfZq/+Y3FkCZJfU8+ZjiR5XLX4NYaLeJkKFlw3+mKHPsG3fA5
	 M6xo8NHSkS1xKRmlvcbeWd/b2gY8jRTdQpyohf9E2VO/Gkgk+JvnRQdO0rJCisWB93Et5
	 Y4JTbHy8PXlQPJgxysIlyq1gKTeIOqGA1rqdd4genZ3tvBsEYKYrt2FmKLPFV1hJV6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QSnpNaaEOoXXG2VcIJ6KvgGQC8uNyedzDQWKO1AUfXU=;
	b=GzNnTDbZqluKFtl3kZnCAaUCvbibzzCk3dBAUqGVdvanE7405QNJeK/P0Q2hrgY5/c/p
	 oU0RoQhFO1OjHAu4+KDz2YJR8Oajptsfl2Q7dG5aiCnjers5wU6iVH5vaH3wj6MfVszJA
	 a1Y9XnML02ZYk/bkXcYk4BDHQod0EIXvn+42AVTNcDcq1C04I7+UrN5oDviHUvU5o9Rmt
	 jj8T4vvpDBomeXARtvMaO2FvkcUodgOjLjFkCwwkYJRUu1muiE0sJnNUJEIWr9Lq9tbKw
	 F87/NuND0MDQbE9Lv2eRQin8pH2EoD+jhFbE1/8Wo55F/SEzSBhGF21Gg6UhDcKK7lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cdtb/odZ";
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76F606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA76F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cdtb/odZ
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso217315a12.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793971088; x=1794575888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QSnpNaaEOoXXG2VcIJ6KvgGQC8uNyedzDQWKO1AUfXU=;
        b=cdtb/odZNYPZvberehssdAp4j1PHi0Ykb+E1KuZluoXkDGqVL+KLjecettJ/jp6MTH
         g32DMbDG8ltUzJlxXitp0Uwo3aBQaw6PbodLg7XCOjpObfcsZBErr4KqKOXySnhpItMo
         Gjh2qHVPMhXT3YjyGc6/yVItgFbAsPRj2wLtt+zgNFwQU9k50RixcQXz6SdW7b4UbXWc
         4i+oRJAhpQFVRaV0Rw8xIg7t+AUo69IqotbQHbV7Abiu+ApQbTWAeyiJsBMZXLqZkgc0
         3cnqHd3ePQ7jTmXpsA6bJhy9Yxj+9WOkyB3PpYEm5pui1Jc+1taeYgbUGVl4ebtZLUUG
         QjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793971088; x=1794575888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QSnpNaaEOoXXG2VcIJ6KvgGQC8uNyedzDQWKO1AUfXU=;
        b=rPMHLe+stpIf0oW5fzffaoQ1ipZWBFoG02VSNqMy2q4b+R518AfJhJ1cFsuo6HTdKD
         2MFRwXx9k80KPMmVOF/dFTCDr2MbwJJ5ofE56ay2SeFmKL8BatBVPsx+syEnQD8wAH2Y
         /VP//wO1BiYBV3MO8VtmlELB9vPccZhTPG45dk0Em8nFZ9Rjw5YQdorKs1sPKYdJjNBv
         R6sVFoqEd60N+ROQXYD6GlS+eM5iRrWqjBsnEGCyRP9JxC40Rk1CBZDIK7z790XSxLdd
         vn09JLYPKgetKHiLt3ypBDK9Ni4wY424pne8zl5277EMLgjaztrzUQKwY85ccRUk4IY+
         7X4g==
X-Forwarded-Encrypted: i=1; AL+hErHFImE5vGiEwL6AUSmtgnObRqZAu+cYe1XEaKNOKLnFQx6H/sQTK/8zJAjhhaOFeAyu2DxzI8A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EI2ABQC7+yANoOsbJm79OX+5P20GxO//oLef3e8zeCpCNWa9m
	AvcpDrx8oQFVvvOZLk3MvL1fMhLRE8DiNuObeEhbHlnC5zDTKdKtDNEK
X-Gm-Gg: AYBFou1MUFDRh/EIS0+GqNXUBRj1ogQVhcElZjyL6S1GD71ndv2cCHCpJLJim1LS5Pm
	42JT3OoXFL+x4lf2l6T3D3YWBlzgeQ8/nIS3o6pMCVSydwXishqM/Dbn6hKx5LH9Wmxof8eRylw
	iGDLA/ITNFQOsX1yMs00srIkkIEA8lWxaa8JHTjAGtJLCeb1zCaYqOSdtYuj5+jaqyBO1xnxl+x
	vgWcrr7hNVLZOHG2PrA9I8o7nppSQCMFgYSnjxsBoCQrFj2x9Yk1pigOR1PD6bkINWHBjP7UYm2
	/fWEnSpVH62kC6+3Z95F3Ep23Qth6krB7h92XKoYQQIeVRwKop/X6YaqegIenb7ZHdRGwajbNjj
	8zHkB1uvMLLkXwwuPa61zQh3+aaq0uJU6QWCwzwoWCo+phesL6Q8iuz6wdgukeLHlvvSecROhMp
	UojTmHcF8YBNr1esG1l9VOfd25HtTH3ICxezLKNcfPKl43ToflhZCiTlUKXmV5dSu2ssTlcSKfu
	mNm4VvEEawmZBk498TFW0TWPQVgmEYzWCiMvdoz323DVd4Ji0GSnFVeS/X6xLEc7+vSbwjunMlH
	OomiyP0IZ3CPU25R8RFHFj8boKuLbOQiffyH98g1g5t9GF5+
X-Received: by 2002:a17:90b:580b:b0:3ac:a203:e092 with SMTP id 98e67ed59e1d1-3b0db609a2emr2299339a91.1.1793971088077;
        Fri, 06 Nov 2026 05:18:08 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0e2a8d6fbsm1025636a91.1.2026.11.06.05.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:18:07 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] extcon: max14577: drain MUIC IRQ work before extcon device is freed
Date: Fri,  6 Nov 2026 22:17:29 +0900
Message-ID: <20261106131730.2633139-5-hj351016@gmail.com>
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

max14577_muic_probe() registers the MUIC interrupt work for device-managed
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

max14577_muic_irq_handler() queues irq_work with schedule_work() on every
MUIC interrupt, so a work instance can be pending or running at unbind.
The handler max14577_muic_irq_work() dereferences info->edev via
extcon_set_state_sync(). Its only early-return guard tests info->edev, but
info is itself devm-allocated and freed last, so in the teardown window
info->edev is a dangling (non-NULL) pointer rather than NULL and the guard
does not fire. If the work runs after the extcon device has been freed but
before the work is cancelled, it dereferences freed memory, i.e. a
use-after-free.

Allocate and register the extcon device before registering the work for
cancellation, so devres (LIFO) frees the IRQs first, then cancels the
work, and only then frees the extcon device. devm_work_autocancel() still
performs INIT_WORK() before the work is first queued (the IRQ handler,
requested below, is the only queuing site).

Found by static analysis / code review; compile-tested only, not
reproduced on hardware (requires a MAX14577/MAX77836 MUIC).

Fixes: 14ad76825f00 ("extcon: extcon-max14577: Fix potential work-queue cancellation race")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index 5476f48..1267769 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -674,6 +674,20 @@ static int max14577_muic_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 	mutex_init(&info->mutex);
 
+	/* Initialize extcon device */
+	info->edev = devm_extcon_dev_allocate(&pdev->dev,
+					      max14577_extcon_cable);
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
 				   max14577_muic_irq_work);
 	if (ret)
@@ -712,20 +726,6 @@ static int max14577_muic_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* Initialize extcon device */
-	info->edev = devm_extcon_dev_allocate(&pdev->dev,
-					      max14577_extcon_cable);
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
 	/* Default h/w line path */
 	info->path_usb = CTRL1_SW_USB;
 	info->path_uart = CTRL1_SW_UART;
