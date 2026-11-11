Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381803;
	b=uhwhfRM8LGBTJw7Tbe6Z5M37nFqaIkfRTS6egwd/dycwhKanY+lZ4G3oOH12vwR/xGSm
	 ZaC+eHif7ZqKAAAocZzZ6+ZnFDsAEwCMI+ia8Zpok4gCTwBcTMtQSgyO4NzPlM3hIBm2m
	 h+JMYkDgO3Gp7IYDnHvNQXceddbxu37xZ//nBzYd/lU+YE3PqubBzv7fGi7tKSX2pkh1l
	 exa1lJRZfp6g6eXsfWKsMViltydICkuzeNVcV74/izGa5F0hL+HZ7cnfZPxaqrAtyFNwQ
	 m6AVlbER3Cp3zQ/jcAuNg3Fe9IKzhMQfkTk7TQl2qEVyG8m4xRzE8N6/vTSHDUb82Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AUKPS5RA8eXgoyfSnvQNUOAbgh7hfsrUJVAkmo79Ccw=;
	b=HaABfb/XiXAT0cELIhmbXSsPL7EgLrae8qY4OVxsFVVfTjf2XYONhR2BMvm4laZNzHS1
	 ycxWkDuMcPyAwFUZ9V+fh+khDeuUcz92lsGEpqjov3AwwaXoJojOFl30U5dMy6aTTk4Jn
	 be5y7qR6LLqeY9+sr76GJ4XYufD74WprsI6pHo80ewFWkDWxdrSuKowZPCtqD+KjQVPhD
	 kc8XLzftB8NCN4SyaKRc7byr+/+lb/cEUZX5iJrvuRPiIbmyGH4ZWmpoBqgGmMUx+ljfF
	 FICVo1xwlbSldNgtiNWXeSLikiWwgePJLb884e8UDkKaRAtyCqyL4f/N8deyybDlrQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D2MkHM9b;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67AD606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B67AD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D2MkHM9b
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so6018802eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794381802; x=1794986602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AUKPS5RA8eXgoyfSnvQNUOAbgh7hfsrUJVAkmo79Ccw=;
        b=D2MkHM9bMVmn5KJjXCcY7Zf8IrlcQRW/j7MZfCz5t8C4trhHu6yVTgIJqX18vkhH6T
         yLp06YE/BU+HUh4VO10HdZlhwZpXGvDWfE6uBIA0EMM/lnXiEW/9U3DuuvYe0ObpI8o3
         ZP3qEXCYvt8L/Q029eGUcaEgOFN24c2VCu1yVc11KHpGLhyximDhkH0cHtiHOZM4rtgX
         rsMQtEJGvcn7hNMDhy3Yzvsz43VEAI+FYvEhGxN1p+keNAOQ410Oqa9VNAE1Ocu5AhiR
         2vBxfeS6KaFMeONHK51HLuSDa0Le9PPSGeI7hdK7ihCRqgUXBe6uqKuRw1h7ry/+/I17
         6c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794381802; x=1794986602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUKPS5RA8eXgoyfSnvQNUOAbgh7hfsrUJVAkmo79Ccw=;
        b=unpfyYxqLfd3D2hc8ZpXZKOsiOU6v4lfD9CRWkI5iDHV1wyPwa2T1oVFjuEMghahVZ
         MVDhNIK+An/40bZFy82lGlZAtWMF+07iKhqd88hrZZfhlHmoakrq57rLKx6GUajb1ce5
         ++c3G5luzYyeMCgFuwEMZZRfRAO/xjU1xJ0OKlkbmKnWJvx6lXJU2RHOg7L/sHi/swXO
         Y3oBrd79ll4ABETKq3+suvBth0khUKm9yQWQAAAd704dVPfy1tbFyvYO7gMTOkqwe5oX
         petHe/czELaiVa/gMDLzFGNwJdD1DkvvX0ORxRjgIBBcRMgIDNacW7jr0ltIOmLZ6h3D
         6gow==
X-Forwarded-Encrypted: i=1; AL+hErEqnqVXkPswt5TbiEroiE9Mjc7wsZVrkg/WZsrhsQfgnS7vZxBb5b7x8Za/yKz3qSfRd9vfsuc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dQ1u3JDodnjsI0XG5VBZBUE8fyPE0IR6bJj69bDEjRFPXLR7d
	6/u7nzBTt2YBjwE0g4BZzZYAGHXk1BzmmoDGIXI5Dkqng2AOhF0aqw2s
X-Gm-Gg: AYBFou3sOIV8r/BqLtKAD+qkspbmHojtvnr51Dyiv9SwmMIskj4Y0cBPUPzhFfHVKUW
	JeYSfdrt3s4X/BZN267M5KOijYq/GfYOPneQSoUeRdRNpBoU9HgFLdAWtzhBWo79sWm4kwA1VUG
	X2lpysITRBTh5jG1ypBaRZjsNKNKZ/iNIxFX11BtuAPwGcNTH5UdqDepwdxxpN/BZVpQsnCPbU/
	OBu4p5qdVZVrqcHSr7mgPYuN/KXN3E8+6X3E4JnmJbvKPkfxoafZh460l08z2ms6/lVO4PZfdgJ
	jjrCseOpK/u/+7kjQZmmyxO2UQa4tMCWFipF9+wp6WtS+WpVftEs65up2YXqL4TWr7fJLDYmRMA
	DdUEXTitbiZrH+R9yidZt5nGVS0Bm3rgMpyrlSLDf0tFtS3GqOkxEXRJ+VKpkzvdiM9iniEOmEA
	HqENJu1U7Bj8yyl3UmaSiiIUCqJMApfXXeCVYqtlszIENSG2vCNii1YImNZGh6hbAKEzw5Nj86t
	Va5XdCWMaBQ6AND1nAOGj/nILjHE6H4i37JOyoxchA8jB8ezXns7NcGoKgoAvQ5oNgSQc/H1NZc
	+F+24IeiGrcXtl1CXltJbPlqZP4wiHAqqUwCrGDhAJBp1vDj
X-Received: by 2002:a05:693c:8950:10b0:35f:2858:aa4b with SMTP id 5a478bee46e88-3768675505fmr2135460eec.30.1794381801419;
        Tue, 10 Nov 2026 23:23:21 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e76e2sm14542312eec.24.2026.11.10.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:23:20 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Kevin Cernekee <cernekee@gmail.com>,
	Neill Kapron <nkapron@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <balbi@ti.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: bcm63xx_udc: don't sleep under spinlock in udc_stop
Date: Wed, 11 Nov 2026 16:23:10 +0900
Message-ID: <20261111072310.3005580-1-hj351016@gmail.com>
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

bcm63xx_udc_stop() clears udc->driver and then calls msleep(100) plus the
PHY/clock teardown while still holding udc->lock, which is taken with
spin_lock_irqsave(). Sleeping in that atomic context triggers "BUG:
scheduling while atomic" (and a CONFIG_DEBUG_ATOMIC_SLEEP splat) when the
gadget driver is unbound.

The lock is only needed to clear udc->driver, which serializes against the
interrupt handler. The settle delay and the bcm63xx_select_phy_mode() /
set_clocks() teardown only touch hardware and are already called without
the lock during init, so drop the lock right after clearing udc->driver
and run the sleep and teardown unlocked.

Fixes: 613065e53cb1 ("usb: gadget: bcm63xx UDC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/usb/gadget/udc/bcm63xx_udc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index ba91b1ebbf57..269063d19f10 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -1847,8 +1847,8 @@ static int bcm63xx_udc_stop(struct usb_gadget *gadget)
 	unsigned long flags;
 
 	spin_lock_irqsave(&udc->lock, flags);
-
 	udc->driver = NULL;
+	spin_unlock_irqrestore(&udc->lock, flags);
 
 	/*
 	 * If we switch the PHY too abruptly after dropping D+, the host
@@ -1861,8 +1861,6 @@ static int bcm63xx_udc_stop(struct usb_gadget *gadget)
 	bcm63xx_select_phy_mode(udc, false);
 	set_clocks(udc, false);
 
-	spin_unlock_irqrestore(&udc->lock, flags);
-
 	return 0;
 }
 
-- 
2.43.0
