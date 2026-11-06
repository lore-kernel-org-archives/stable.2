Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971081;
	b=EvLxX9UPwdgOKHofKXvwylRwwk2QTn/KFvUjwruKjfZ8fzJwx21i41kbYbEZDCoHlH6X
	 6+3RQmKme4N93etqtZOu+wZIE+67/Zd46fJ7++kQjcXbNJ0AxkycY8UtX4xUBfpoeD20t
	 iDIiCHbxCqDxgQwYin2gZhxUp4aWMOxUn+HEMdru2678aZBcijGPIWGfQpO3jSQUs7MfG
	 pgVN2e+TY2ACxrEdytvNgyUAu7U7S/jsJBp4o+SV4AwcRz+7GkyQqM2M8ILe1cYt43nmj
	 R1HSLQnp1+muEe3XlDGL5+C5JCSS9VcpiKWsOkJ6XfbmW0xbLQz0zkTqyy+Jaz0vo9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QCmCUD5+cRAdCqiqdhrCpwSJ5tYiyygF2+7HyPzxiCw=;
	b=25Z4i+HI7gCICKFmBcwmE+9+RuaM0D3DAlTt0SB/Xmq/ldiEb1rDXrYd25oVpSsVTSX8
	 AR1/VBkdAY22ZWSRV0l7308w7QWD9qy3zq1rVbJa3o59NygB1FLzUH1kcKs3z+029yetj
	 LvRAOmNz/rfInyK3M2qJzAdaFlS08uRli/af6Td3sfrlm79QmOCZRP+qPHAmGvjRAN8MY
	 ko9EL+Qv6LvJHDxxsgeOqJcbbwNa83UutLUEinKU/B00hCkR2doBqprxGqLrFs1tkcTOr
	 8XGUmzBTzMdiHkksKjO1dezuUC/VjdtzvpV51TmjWLyavM9Ar+qYjqDSAhrkVVX4RrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eRQTt+3H;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD6E606A331
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BD6E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eRQTt+3H
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso292253a91.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793971080; x=1794575880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QCmCUD5+cRAdCqiqdhrCpwSJ5tYiyygF2+7HyPzxiCw=;
        b=eRQTt+3HAcikpyyqip2eed0SNs12Pyb+897E3wzePXTtPxRx3tqIHGG/G8Len9CQD4
         POSEb83IziCHdkZkdlc+CIvXOu4N0fZPjRFzetlotDbUC2nmtAc9aMG/RDnngQscifl2
         TPtbBc6p+Y+5KG7Xps+yBXvOsNXkBCPPvvMut448592EshEjgD4PcuVIEV/dKVcSzo6M
         PKEBTOqraLbio9bEw0QeVZliR/FzT7TRrYuYPOIQcQCMUB5el5OfdmErKVAtaVK7EkUu
         8KTpRZGdSQ5rbrhcsxf8C7GozNTjsttQmqZzmMciFOqGpb+YrqzulAGLHuaSwL0aOVmn
         GSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793971080; x=1794575880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QCmCUD5+cRAdCqiqdhrCpwSJ5tYiyygF2+7HyPzxiCw=;
        b=ZLHaeH5L1xClyI2Xfvw1G7M+GL3saip53yePB+ExeeitSAfbbYKjZqcsBns0rsgNd9
         Sy9tGsZkP8rU6CIO2Qnj1O/vFSuO9hBFpVT5Ctexvmy1MWrIDEiBoZfslXPgqHtvJ27U
         7pJhGOMhHM06eCPaPGfvhbDfud2AFtbWyol3EHkZwV53FE8XVd2eZ6Mrsn6oXK7jW5Q0
         SJvU3AuTA8wvjl0IFw6GwhSYzI+dzDkufZy7A9YUj6yU0rE9biZPVoBIiCD0vRkORRKj
         CBdTs/r1Bfoo90LSfniwZw2oz2jRrTGSoFStImnc1190QXgvZu4u/K/mCVsbLrU6g7Pk
         3Jhg==
X-Forwarded-Encrypted: i=1; AL+hErEA4O2Z6NPdrJcqeK0mA2u1GZNgs790T+2dVu7O33qWAOaAKzG1l3+3mNDM713YSDGt/DB01Hg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7T/9VDpbhe5gAp1Z6cG84zljGuRYryCO7fsS7Dpk/Tke58sgw
	VTNNqv4DXnZ0777YrzPMagyWMxTIPhcZwFgrbBAHtGfgxG9O6uhHWsHr
X-Gm-Gg: AYBFou1LPzTYIEIn3yr8hfUAuSW/OnvtNEIftoRVMhog/P2/eO8FqT+RcRa3iicJk3a
	t7KTin/KysraIFNS2x2hNRT5VOCvGdVxgzz6uTX/BEaEGzM5q1PnhDYpwM8dVtgbpcqJSiiw4pO
	lrI9QZGbeDc7hQvo76JGZxsvcHAmuzZ/gjYTsk0GOa3VY289W2Iaqgzufan4+dgsYqBtlq2Vazl
	sMb+sRwIgxm3Yqi97PGCU2VC0+LjVMOyladFPBONXrkTArfS/nXSYxUy/1OLkMzLv8kGJLVYbWM
	ilOlf1BL23p384Fj0H7DjB+mAfZi5nFVnHlF0AbeuoN6nd1zTGS31vBA8mHj335sflrubjLs/vk
	k/D17Qr3UGb8ic5nYL2XgrBRM5mGKZEgrc00PTWMn403ZaAA2Agj+zQ/lr9UKk+kdbvZAos1k4c
	IbS0hUUIj3+Xup4XnL/WYpZioKGcPzH0cGUbo24obVxEqej1jkLi5E412AwheFNArCe0JqFjf67
	QBE5Hm2pZDUv0q2IZu82X+LDZPJDGtJ1eCXrqbxqyencWfnzDgsLww4AZa8eFbaoz8IivQuuKtn
	ICNlOpaY0FSiMYX2LVTrSn5o1gdrh7K8z3+gnkaJtGjvOa69A4P92rmsIsGpR2B+BEazwQ==
X-Received: by 2002:a17:90b:4a10:b0:3b0:a38a:6715 with SMTP id 98e67ed59e1d1-3b0db7109dfmr2536524a91.59.1793971080497;
        Fri, 06 Nov 2026 05:18:00 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0e2a8d6fbsm1025636a91.1.2026.11.06.05.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:18:00 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] extcon: palmas: drain ID-detect work before the extcon device is freed
Date: Fri,  6 Nov 2026 22:17:27 +0900
Message-ID: <20261106131730.2633139-3-hj351016@gmail.com>
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

palmas_usb_probe() registers the GPIO ID-detect work for device-managed
cancellation before it allocates and registers the extcon device that
the work handler dereferences:

	devm_delayed_work_autocancel(&pdev->dev, &palmas_usb->wq_detectid,
				     palmas_gpio_id_detect);
	...
	palmas_usb->edev = devm_extcon_dev_allocate(&pdev->dev, ...);
	devm_extcon_dev_register(&pdev->dev, palmas_usb->edev);
	...
	devm_request_threaded_irq(..., palmas_gpio_id_irq_handler, ...);

devres releases resources in reverse registration order, so on unbind
the extcon device is torn down first and the work is cancelled last:

	/* free_irq() */
	devm_extcon_dev_unregister() / extcon freed
	...
	cancel_delayed_work_sync(&palmas_usb->wq_detectid);	/* too late */

palmas_gpio_id_irq_handler() queues wq_detectid with a debounce delay on
every ID GPIO edge, so a work instance can be pending at unbind. The
handler palmas_gpio_id_detect() dereferences palmas_usb->edev via
extcon_set_state_sync(). Its only early-return guard tests
palmas_usb->id_gpiod (acquired before the work registration, so still
valid), not ->edev, so it does not prevent the access. If the work runs
in the window after the extcon device has been freed but before the
work is cancelled, it dereferences freed memory -> use-after-free.

Register the work for cancellation after the extcon device is allocated
and registered (and before the IRQs, which queue it), so devres (LIFO)
frees the IRQs first, then cancels the work, and only then frees the
extcon device. The ID GPIO the handler also uses is acquired earlier and
thus still outlives the work. devm_delayed_work_autocancel() still runs
INIT_DELAYED_WORK() before the work is first queued (the IRQ handler and
the explicit palmas_gpio_id_detect() call both run after it).

Found by static analysis / code review; compile-tested only, not
reproduced on hardware (requires a Palmas/TWL6035 USB PHY).

Fixes: f94a5becabf4 ("extconn: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index d339b86..f7496e5 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -237,12 +237,6 @@ static int palmas_usb_probe(struct platform_device *pdev)
 			palmas_usb->sw_debounce_jiffies = msecs_to_jiffies(debounce);
 	}
 
-	status = devm_delayed_work_autocancel(&pdev->dev,
-					      &palmas_usb->wq_detectid,
-					      palmas_gpio_id_detect);
-	if (status)
-		return status;
-
 	palmas->usb = palmas_usb;
 	palmas_usb->palmas = palmas;
 
@@ -265,6 +259,12 @@ static int palmas_usb_probe(struct platform_device *pdev)
 		return status;
 	}
 
+	status = devm_delayed_work_autocancel(&pdev->dev,
+					      &palmas_usb->wq_detectid,
+					      palmas_gpio_id_detect);
+	if (status)
+		return status;
+
 	if (palmas_usb->enable_id_detection) {
 		palmas_usb->id_otg_irq = regmap_irq_get_virq(palmas->irq_data,
 							     PALMAS_ID_OTG_IRQ);
