Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971076;
	b=nFJxo6MA3wilKERrZdk4PglmvbpzsKL5xR1YEoLHcW+Jb6UB4zv2ezTefHm4UFgA4taE
	 2cNwL5Y1spFPCm6qYROLuEgbhVi8PC/YhwrXUIKF1uHSj37NKlVusdTiI6dC2XYfwrQi0
	 Upu4xqpQJ36okHzgPdEVYo09yJdF5hw/z9cbXoVIVWpoae5K10f2nYc00fhgOdDPH9/FU
	 z7ue+vanMouvXRZoioIol1gw2pJ1R5aO0vy/7dk1hrSAfdC52E/dQkzPL5ppQJjnDPzQY
	 ne4NQoorVtpbHIRISm341jx1P1Z3Qj9QUrspS9fYpHc6CVfpYrAhKIB5qpuRIP2+XCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6/3GymnNJZRM/VrW+qCnWfq8A57o4eHJ5rqxoxFgvC4=;
	b=w7Nt41kkMRpAwMbLKb5lqCt/Yx0Qlf4ArSv4mabDPFe/ZJv4+QNvb6OgUOduZb/T9DPu
	 OWYeDFEnJp3zyHtIbl48051bP0yfKLlPNqVMpVUJMp+jR00+vTDhWMERsgi4T8vU95uHo
	 fnFlSX6Jj9pQGIYoFtHgL68Je0fdXgUKVLDTveOvELbksNishzvQMiVjmaOdBARx3+Cms
	 DCEhC8/Tik5UYgVuxFv35BPCIF86wdn1pmly60lPRkR0j82RCT+yBHudAVWEcp56KbeiT
	 3akkLrP9dZBZ8v9v36sUUB2wfNlgGPMxt2jaSDMJC5DrZW5Ml3uzMYUtpS5bfDOb7Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pLKJBcOV;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD9606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECAD9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pLKJBcOV
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc751eddf25so328428a12.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793971075; x=1794575875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/3GymnNJZRM/VrW+qCnWfq8A57o4eHJ5rqxoxFgvC4=;
        b=pLKJBcOVib3l2IvbEA0fuRpzWS7HtxZFSOMT8uvd+t2Gig0EeaMFkEJrROdqrf8GbN
         5Ez2dbXsBKz5TLbIUdyiOMTgmoZpKlaH/qa/nZvmyhmbcn1bSziNwIEuJCqHZnZTqbgL
         LvKj+kaNFpY5qE4SL55AnobiEhBwfTy/p7h/2fGSbVC89y+BUqJ6WdLgXrjmrGW50xls
         i2CP/DdiZMlp+aAj28N2uAijrmnNKZPNvSe7guccM0MhNX+PZQtFMDtygIkuKxe99dRJ
         5s4MU7SqE8ZrcNwXi2dJK3bvXEQtZYjjoHWuglDx/cuhy8JmOIyBexYLILYcz9ylynaN
         iNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793971075; x=1794575875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/3GymnNJZRM/VrW+qCnWfq8A57o4eHJ5rqxoxFgvC4=;
        b=beKC7mYZ00uQpAekG6PpJyT+HvsnR6wCWJXQTmpR1/am3vRgUQA3fOZ9jBbqaedWXQ
         mj4FodQ1Gjsm+qD/Rv7BpXbVI0yCTwxQzrZ3PURLPLg6eX7QO0J4K5SuYF0vuqa5CH8i
         l2LjvpVbmmQnaJ5w48eKfg39QoE+3mb8TTaUoKgytjC2Oec6zxV4u/aKLcp5I4JEfW1k
         0JvkA+SyVuJ3FLhNigyfDHYOtUm9zC8TQVJXIxeRhk8liHMU/Veg7RBRUj+3gv4gt5qp
         UDxKQc4/0pWtXZ83PRpR/cjRIA5ri222icdAuFgXKpVvqeZSNfS/bXbvheLA1m36OlCo
         qwfw==
X-Forwarded-Encrypted: i=1; AL+hErGRD/fpM3aL1sv1xAkrVpuLotdnr3OTBYxLXCZNJKCBiII55+CQDhfhDr8E01JveDiEXaH2Pks=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5L0dQMZ2u5/AUrPASOeBmwkugsWBfxblbaxHsmXXidQbahGzY
	UYclFJv+BelqXZu4E9+rVXtY1OrIrdx6knas/cDE5qA2ocAZTg7LF6yQ
X-Gm-Gg: AYBFou1Un//VWjJ9G1hNCvlFWIn5o+gxnVtoq5KbwRkdgXwKyUQy8IYtYrfGJoUB6Ju
	1hJd2tf5CEoawiQL67MSbSqukyencsPK03rdjjyBJsRPt/O6P74JyU70PrxE1h8O0CQALZgJrYu
	qJuZJP2OiGgNFZ9JGZicACln8EpsUgst9azBX1WLJ3A/4wpPw8eODFIj1iBHiHJGG+f7NHFLmrT
	vYp4lfi4WkuiBINw7HRqo7rWr1scwyAF23uQmhKxph8lewkj7sznTFNX/wACF26k28yFXNfmZJ7
	zk9fruUVYXoVBbedxCrAXJtOCK8kBNmQRjDf7nCTBkcLRIZYUlo3f0GJXfbWGqaTyvIeBL0letq
	D9/yPqbWNAn5xVro1ZxaIm7BOuE6BlnQrIoxVl2XKIT/ZorSBsHLNmW8tiqK/EsAP5Y/97sY1+j
	rsVUAf2BfWeZkyJYnDrIN+JZOsdgByPsFRiAUNa5zs80/4qizetcJbH4LwZZ5WJfZXypzqDjL9w
	GDmNmz9YHVgyYA7gPHqwo941dHubBWOnh7Cl4PH5meF0ONA0zFxY9DkrXMyzsnAU0Zp4cQptmyr
	RcEQPlichq88iD4Po2AUwgzG51KKWBsPqL4hCuz7B4C34cmCtA==
X-Received: by 2002:a17:90b:4c41:b0:3ac:4e18:238e with SMTP id 98e67ed59e1d1-3b0db6fe1cemr2426041a91.46.1793971075070;
        Fri, 06 Nov 2026 05:17:55 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0e2a8d6fbsm1025636a91.1.2026.11.06.05.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:17:54 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] extcon: intel-int3496: drain ID work before its GPIOs and extcon device are freed
Date: Fri,  6 Nov 2026 22:17:26 +0900
Message-ID: <20261106131730.2633139-2-hj351016@gmail.com>
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

int3496_probe() registers the debounce work for device-managed
cancellation before it acquires any of the resources that the work
handler dereferences:

	devm_delayed_work_autocancel(dev, &data->work, int3496_do_usb_id);
	...
	data->gpio_usb_id  = devm_gpiod_get(dev, "id", ...);
	data->gpio_vbus_en = devm_gpiod_get(dev, "vbus", ...);
	data->gpio_usb_mux = devm_gpiod_get(dev, "mux", ...);
	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
	devm_extcon_dev_register(dev, data->edev);
	devm_request_threaded_irq(dev, data->usb_id_irq, ...);

devres releases resources in reverse registration order, so on unbind
the extcon device and all three GPIO descriptors are released first and
the work is cancelled last:

	/* free_irq() */
	devm_extcon_dev_unregister() / extcon freed
	gpiod_put(mux) / gpiod_put(vbus_en) / gpiod_put(usb_id)
	...
	cancel_delayed_work_sync(&data->work);		/* too late */

int3496_thread_isr() arms the work with mod_delayed_work() on every ID
pin edge, so a work instance can be pending or running at unbind. The
handler int3496_do_usb_id() dereferences data->gpio_usb_id
(gpiod_get_value_cansleep), data->gpio_usb_mux, data->gpio_vbus_en and
data->edev (extcon_set_state_sync) with no guard. If it runs in the
window after the GPIOs/extcon device have been released but before the
work is cancelled, it operates on freed resources -> use-after-free.

Register the work for cancellation after the GPIOs and extcon device
are acquired and registered (and before the IRQ, which arms it), so
devres (LIFO) frees the IRQ first, then cancels the work, and only then
releases the GPIOs and extcon device. devm_delayed_work_autocancel()
still performs INIT_DELAYED_WORK() before the work is first queued
(queue_delayed_work() below, and the IRQ handler, both run after it).

Found by static analysis / code review; compile-tested only, not
reproduced on hardware (requires an INT3496 ACPI USB-ID mux device).

Fixes: f94a5becabf4 ("extconn: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index 7d16d5b..40774fb 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -130,9 +130,6 @@ static int int3496_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->dev = dev;
-	ret = devm_delayed_work_autocancel(dev, &data->work, int3496_do_usb_id);
-	if (ret)
-		return ret;
 
 	data->gpio_usb_id =
 		devm_gpiod_get(dev, "id", GPIOD_IN | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
@@ -169,6 +166,10 @@ static int int3496_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_delayed_work_autocancel(dev, &data->work, int3496_do_usb_id);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(dev, data->usb_id_irq,
 					NULL, int3496_thread_isr,
 					IRQF_SHARED | IRQF_ONESHOT |
