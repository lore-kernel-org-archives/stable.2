Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033F3A785D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453680; cv=none; b=NdCXBqnC/3dig/4sZHGP4cKmp1/YtDy6hvhfOWui/w3gdWruXayJdYJ/d+NpMN8bRnW5LWCTr1UCYWBDb+PcM2CGlRl3Hpd8RyU2zVn/tw67kxPm//zLQ8RWnijlguRS6Ilx9XklsL323dMA+AJ47EMbkewmI/grPFDDdvIpNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453680; c=relaxed/simple;
	bh=iSwEpx/CUEGfLuiQrFoaRk79VbQrqojiYQTMnyvUGk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLqgX+ycw7JdrHdewt8WvTsMFRigGJBgFPSJ4wV/WyDsbBYi5CFZ2GtP7pp8i2Z2/PbOjjitsvnojjlj1uDTj339QisFsNrRQx3HojzOesySWVkC720T6sRTE+ntgnKepjGNpqy40nEkR7hkorH9KZYe+LEAbUuBhj1w4SVDe/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1dHtOJn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1dHtOJn"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46e22950091so299516f8f.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 23:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782453678; x=1783058478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF3w2+PI3g3PecGuSaGiNiP4orJyCN+FZOEsoFgdgU8=;
        b=U1dHtOJnbZME7eLBauxP7F+tJarty+gYWBJtW6BvUPSye1KLI/00uNdhJapHLtNbPD
         3fLA7byDDmNzpz7otgPJogHSS1yrzI09jWVykICd7HSHh2hkzoA8RMoXk/NjVJjR8xT/
         jBfjrylAqYsg6XtVv4vpSWdRO0YwDWGi7TgN1j4Rz6qx2Q2FqXzMN/IB+PihowU6cM5c
         zCzEwBFuFbDFO60JR48VvZFq97MxbyX6rvB1bdHJKqD3HguWCag9UMd9YuUMmzdbs+dc
         Zv+hwTeLGv9Wf+OahWiJJGv070X7RBY+/OmN4I/QQ8pM8zR5EN2fh9yo/MKjS5fZNGcT
         wR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782453678; x=1783058478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QF3w2+PI3g3PecGuSaGiNiP4orJyCN+FZOEsoFgdgU8=;
        b=qXSa60U5ZEALLkjmvphRYEo+/N3Q+W2og1z4vt9z+KdWByqNcdeQFbGfgw8Xc/Y03z
         QGrCFRDRt1e571MlDKu90rgocIqllMKHWiL+uSgkjpXxZmIXXqKgU9QgrMBu05MmtcEr
         oEYgG3qX1uNUMptgjIkgE8zPFp7zjn2uawWKT1+Mngh4XthS2qS5XNJL2tl0xgnxJYJh
         x/E07AmXCCOaqlSWPcuH9NlTWuQmhXrvOp2ZIEatIYKpz2a/lTTfF/e/K51moV4yJZHM
         pDzz3EyUqRUKoU7fI04LpaGTbTNEiV3plNGij8PTRUuRZi22q8Udchg0F/nRB2xQ1ohJ
         2pjw==
X-Forwarded-Encrypted: i=1; AFNElJ+vIqJ3OK1bZjDlM/ieIFKV9if4D8X12jGJEGTcZfMVbUz3Rl2NjfzilzWDbIPM8sPYb+clBH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBLvl1Kw2qG1nxIxbfNFcBlJY8p1a3ByM06v6W/8F1FfkTySW
	2UatyNN8hWjIRcy7f4NKKBmSA/jUDG/hXX6Jd3gokXdKznnLTl/kNO7U
X-Gm-Gg: AfdE7cn+qq5EooGvH9ySG8qMy60y1e8AbAj3itpasHWQ1eq+rjiHnM4L+1afRPxIrLn
	HAXvt47vPPSuyVyDy7fj6HRkZeL54KJlTriogTl4VvciM9+8nPVZsyV9OeXF9JpKWKrkgOOjIxk
	ZL0KENzYgZNy+iy60fX9lG6m5aX5vh0NuOe0lKrqW84iVzn1daHWnuKd6YDODctqSN4R29puzIN
	Y0tFEN3I3qLmDEWk+/9lmKs3wE3UAL/8Svlrn6epPmQqwBgwogcANzBq+1cz/DNrOsEnocM+LKS
	6meOfhvNDWbxEIchu3l4UUQ4Bh0OQwsMv2peUdF6DrmDb+3XjoXm7atjDVDwPHkyGYPGd/IAGPp
	kMONHDhlG+2qD2l1Lj23X44GVH+T3J2JciT5e7QKBrICO+50J3elBma3shuRI6RDm9gprR1a67/
	XTrq0MFMaRYbe3aWHEzYz98bsH7c/QDbB5DeeQ2/3lwd35ZgU4Cn616EpEIx8=
X-Received: by 2002:a05:600c:1d86:b0:490:be1e:6ce6 with SMTP id 5b1f17b1804b1-4926686d388mr70772295e9.9.1782453677684;
        Thu, 25 Jun 2026 23:01:17 -0700 (PDT)
Received: from camaron.. (147.red-88-9-50.dynamicip.rima-tde.net. [88.9.50.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f0db007b3sm2767936f8f.2.2026.06.25.23.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:01:16 -0700 (PDT)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: linusw@kernel.org,
	brgl@kernel.org,
	vicencb@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 1/4] gpio: mt7621: avoid corruption of shared interrupt trigger state
Date: Fri, 26 Jun 2026 08:01:09 +0200
Message-ID: <20260626060112.2498324-2-sergio.paracuellos@gmail.com>
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

The bank-shared fields like 'rising' and 'falling' are modified using
non-atomic read-modify-write operations. Since every gpio chip instance
represents an entire bank of 32 pins, if 'mediatek_gpio_irq_type()' is
called concurrently for different IRQs on the same bank a possible overwrite
of each other's configuration is possible. Thus, protect this state with
'gpio_generic_lock_irqsave' lock in the same way it is handled in irp_chip
'mediatek_gpio_irq_mask()' and 'mediatek_gpio_irq_unmask()' callbacks.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/gpio/gpio-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index a814885ccd5d..ceb99641baee 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -187,6 +187,8 @@ mediatek_gpio_irq_type(struct irq_data *d, unsigned int type)
 	struct mtk_gc *rg = gpiochip_get_data(gc);
 	u32 mask = BIT(mt7621_gpio_hwirq_to_offset(d->hwirq, rg));
 
+	guard(gpio_generic_lock_irqsave)(&rg->chip);
+
 	if (type == IRQ_TYPE_PROBE) {
 		if ((rg->rising | rg->falling |
 		     rg->hlevel | rg->llevel) & mask)
-- 
2.43.0

