Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED03D3CF2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453683; cv=none; b=I2RvLIR3nPsQG4fo94uUke0CKisVkobloezLUJ9nh/i9UlPwYnM2uutedNsmuT4bB9xuHAN0f7lETY2OU1TP3PmaYYkm4LQ7gjKcGqASObGGkd6Zkan3m1zOMdBEmLSdJIsbEur2GwdnBnlhb0ckpR89l47UTTdRE1Vj21vgoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453683; c=relaxed/simple;
	bh=m+LYu4JehDqB5qW0PDlMYvYoWovIUAqNI1Hb+p8fYAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/UquG/YtK+WpxOvjO9zCjkS0rg3qX53q0cVXcwpwHqgU011NvNGrrJaFGb8Cs5PqhvIk/CNfzwJB1zAOPRKb/0wPHW5fxJjxgSVSov1zMHxbtUx1fO9unY3WovXxv9F0XOEl8OqS2J3Ym4L84r8/LEnPZPxlKwEahkuptbgWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEu0MBbR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEu0MBbR"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46066e640easo235280f8f.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 23:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782453681; x=1783058481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BomNSlobdw16KsyTDdkpLrFE3caPS+V2Wnh8kZXiEc=;
        b=hEu0MBbRzZRgdimmdYGFKnQjBtsdcD7lTnyFEBvx+6Sq1uK5LanbQlxtbRWUfw+IcC
         XhIRpZqrHNp9mHibbnQR7wsUacIA8VRYPLJwN1AEQUBTWBzlyK581iUu6ZowiEG8k68O
         49maZfxZL64wsj5eBzS9KRrX+Y8RQhWGJ2xNIoLgiV2G5yPOrEFD+L04JOE5EThLp4Of
         G4hqd0wkDcFfWXOtBSRh+7snwIBPgepPobEE4KiP/3Yc8YgVwwVQtxNpWYEi05G4/0o2
         1chrDGBN+L84KLg3SjtMIqqI7mCnPqXT/uVLeMSVYCmlNRCbFvZGS27/dV8XTsJ6ozBd
         zpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782453681; x=1783058481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/BomNSlobdw16KsyTDdkpLrFE3caPS+V2Wnh8kZXiEc=;
        b=UaJxHUThrZ+cac/lMgjxBHmbAFYhVp+qsxBajYsE0FfvTMpuqmtd6yNgeRcGMUpAR8
         APBExRir3o7C+LNco8+etipbaO/oqpmFBBkj6V0DdEvt+I+NACeGWtHOa/box7/vlZ2+
         10wytukxS7T7q6br9xm7Nv6MPCCIkvTs6EoeGOhNL9ZUboPhf8+5IUS5QwjyxMohnFxT
         fc4GuHgZ+AgSaMY4UbLvG0h6ppO5WumHQeoPPfrfkOBSoHi41BQZNbpmQQMuZ0Q8XnQi
         vzyS1Mab5dtwCqsnTOr41mB1w+RN/W2bnLJSl1iuLZLYJb0H1oFjFV5ZbeGD8ZZyRXsI
         7VsA==
X-Forwarded-Encrypted: i=1; AHgh+Roa/aMMlC9h7nqWxGf9qfADw5B7UZWZrJ84vPMRkJLAbp5tPCxr7zhwsOApep4MOzdOXz5uFm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VE3WBM/KQhUeu7NLjBKKgzvqwy1Vmij0KvwZ67osOeOxyBPz
	LeYosUqp/px9DXiCckpQojGQrbmQRkMvXwuM8fQR1zOh3FflRU75Zu5WPNv4aw==
X-Gm-Gg: AfdE7cmWdVk2Rh8kvJW3yMqiMYVHhrlH40QkX24PYMsGKy7b2/5LpL19tkcrt/bUeYT
	fs2zO1ttUIFkHS1pZJM+JRYL5QvvCEYB0BwBhQ9DTdffIOKW8spZAte2xNUAl4VKaFy27HG9b/T
	x0mGEdtXYO9WcqhtjcaCQa6wTMafbqCOAzOezLYtO/M4nqk/d1J5GKr9dYcJoLlDF804i769yI+
	8Wg0G44a21ynM5jZ6DzErTM/nXR/rQyTKXkmsKTpVJX/Tfld9vKcGbDzC3Dxr2Q96NrMItmIUu5
	h9Gnr8FxIWJpFhgwE0To0AQ7GcQznNn1KwE9AENd1y2J2fpzqkUt0n8/IXoX4cmnd2LfvkaE3jj
	a4PyaO1MmM+0ndlH1pcEAzyHHcCWynV04+IGAQuJ6gP30bVukNxdOM76KJwVKl7riQX2g1K5erO
	9Mft5AQM7akr1oBY7nhUcHhmPJINCw8Rorz5DKgMCuVUM8BwPUGnI7SQJ3vfs=
X-Received: by 2002:a05:6000:24c2:b0:464:28e3:a09b with SMTP id ffacd0b85a97d-46dc18a5a2dmr8936974f8f.37.1782453680405;
        Thu, 25 Jun 2026 23:01:20 -0700 (PDT)
Received: from camaron.. (147.red-88-9-50.dynamicip.rima-tde.net. [88.9.50.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f0db007b3sm2767936f8f.2.2026.06.25.23.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:01:19 -0700 (PDT)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: linusw@kernel.org,
	brgl@kernel.org,
	vicencb@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 3/4] gpio: mt7621: be sure IRQ domain is created before exposing GPIO chips
Date: Fri, 26 Jun 2026 08:01:11 +0200
Message-ID: <20260626060112.2498324-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626060112.2498324-1-sergio.paracuellos@gmail.com>
References: <20260626060112.2498324-1-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function 'mediatek_gpio_bank_probe()' registers three GPIO chips using
'devm_gpiochip_add_data()'. At this point, the chips become live and visible
to consumers. However, the IRQ domain isn't allocated and set up until
'mt7621_gpio_irq_setup()' is called after the GPIO chips setup finishes.
If a consumer requests a GPIO IRQ concurrently 'mt7621_gpio_to_irq()' can
be called and pass a NULL irq domain pointer irq_create_mapping(), that can
corrupt the mappings or cause a crash. Fix this possible problem seting up
irq domain before GPIO chips setup is performed.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: a46f2e5720f5 ("gpio: mt7621: fix interrupt banks mapping on gpio chips")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/gpio/gpio-mt7621.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 57384ef74703..1b0b5247d3c9 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -466,12 +466,6 @@ mediatek_gpio_probe(struct platform_device *pdev)
 	mtk->num_gpios = MTK_BANK_WIDTH * MTK_BANK_CNT;
 	platform_set_drvdata(pdev, mtk);
 
-	for (i = 0; i < MTK_BANK_CNT; i++) {
-		ret = mediatek_gpio_bank_probe(dev, i);
-		if (ret)
-			return ret;
-	}
-
 	if (mtk->gpio_irq > 0) {
 		ret = mt7621_gpio_irq_setup(pdev, mtk);
 		if (ret)
@@ -482,6 +476,12 @@ mediatek_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < MTK_BANK_CNT; i++) {
+		ret = mediatek_gpio_bank_probe(dev, i);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

