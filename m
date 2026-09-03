Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F0503BED
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463897; cv=none; b=KUSZl3/DrJ2AhrG2zo5wHPAVDuK0kI462oyIVS56bjnPsFzF9EleHChoRPXThUK4436jnIPFQJPtf9BgnsAgGB4xr6omZzdZtJJdkAv3u+p0gcwSFElbJeZprdYzh7xmmZYBFE8e/66nxnBS0Bvb80Bfl435AzCU2ak39CGdOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463897; c=relaxed/simple;
	bh=LRIB+Ien8LNhu1QGXr1xo2szN3dRaFD/6agQW0q8qxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THeZWPsi6zXOVBGOHC4oXL2FnGpl9Fat2t8bDWxu03G2nvwraMwyAuY438QRzddYTRzfB94Vd2ETUWo/2zT8K6UpmXTa3E2EBFjMvy9osGkkpx2QwEtBJxsKfl6eE/X/zh1IDAgrUjOwocymmBQEEXobYCJtTHGw66bFzy9j8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwdqi28I; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwdqi28I"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc891373e0so2035585ad.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788463872; x=1789068672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4yIetKXnfU6qQx5OfRzSQNhmvwvEsmpVmmGdbC2BbsE=;
        b=Rwdqi28IC2n6hedfuQzzuOvAxUHwIrsve3Gvv5hDjjOH8/BdTlPKNocnWSsZ9iHz24
         Cf+BJGD6z+rNWWJZ5WlUG9TeDcubItwYFJro72JonhFc1nnLyjJ/F9dSmhevIr6UQnIA
         wJshvg0BFGbf+Y5fSBSkZgfoHksoPLpFYdAYUWKh6V88P39NLoeLhRb+8kJiBMm3cEXr
         8q/hpredYakkLfqPSedRw2qfHjPHFjAAkwid8sfU4XUlCpGtOl5Fh/FcBVsVcoHPOEET
         bAuvGHb7GsC34+irRuoncZwGEQ5dvd4T206H1kllv9+yTopMbixMwhS5d+WNqOhPsrOb
         uhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463872; x=1789068672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4yIetKXnfU6qQx5OfRzSQNhmvwvEsmpVmmGdbC2BbsE=;
        b=WDs5ySBhiKhFeduQa/VTpCFA04fCBAzScvmeGWK7SbVO2ZeTnJdcbUA/xsSIsHfq/e
         NgagW9QLLcIDNl4TUu/KWKwsRvWBYCFAOoRILR/s52PyiEVXAHibGpcv9dG762wQXO9s
         Xwq2jJKVM8Ol1pt38p9UWzZU3PFrgCXq39Htiv1fYdml4ckH9sCuprnX/UbnW65oXr0w
         trs6Xn6c7eBoxlKwKGo6VNTlB2G+gsEiE7ymJ446iREIYBvUdemP7qlOlGn2wCUd6G3d
         Wt+0uuKbp7ZOep7jreDIB4+uX+/75Ud3IFuoju9cGBcW/RlOX11MpiXv4wVSt7+moZzF
         0WrA==
X-Forwarded-Encrypted: i=1; AKwUvByU1m85p0zfUKm4vqlEaAqdZHnVF12mm03ut1VUbv5o873XeRI9r209hjAf1gNk/V4VDnDAqSc=@vger.kernel.org
X-Gm-Message-State: AFuF++m4Zkxm5XpobUCb2BJ/dDN3ybD5Hg2F5TJeEFNZ57V69w1sGIde
	5k4URmnMJ1UJhtkEPjUW1SmGIsuRX2gCTbTjG+a2W0kW1CbLYTpW6buo
X-Gm-Gg: AYBFou2xUPy3MNazZ+papCao7Pyo0vnAh1/vEdgZsZ5WviWZtWmA0qMXtpyovNSDEyn
	IzDlyMqV/yUwW43bmrPtjvoyYpjokWOsbb0z5dsmY/VXF6B//lS8j8LaHqriY3klXjum7tPoHXK
	3NVvegKGNU3B+72w+D+a7tSnpiXJlCy36aDTWKurV7PAGt2y+wUMUfsnZI49CVqLsSlOL0Z72eP
	tiPL+N1IIBWHDqPjXUIvXINqlorVAGTGvzZHf5A/0BaKaAX3CmRh//p0C/KR+6rCMsGQE2WayPV
	xgPFKvo2vYrF18OpSEWof78a+bMmtFRL6VXuJQiCw7JvK0fWTnDP4X2NUaavhGl8F1wf4hx4nen
	yNX6eHU7+ldF48vRv+WncDq7/D9aP9CJ1+01LveQhjJMHRWzxlL+OFyP4EW9HWh4Ea/Y9g9afeD
	lw6Rx+/KH24i/xx8/9KDJdhB1MzwqAuWsa5uooHAxd7PXYkRoGkAx8YMeVbaCovFGPLY+4N3HYc
	8jTyJybYiDsfNAGGZrcjz2S4VxazIcdbReNIb+z7dszRQ==
X-Received: by 2002:a17:903:1670:b0:2d9:438e:b70d with SMTP id d9443c01a7336-2db1232c88emr19260755ad.1.1788463872345;
        Thu, 03 Sep 2026 12:31:12 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([223.160.226.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae53ddsm396985ad.78.2026.09.03.12.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:31:12 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>
Subject: [PATCH 2/2] Input: tca8418_keypad - fix race condition in interrupt handler
Date: Fri,  4 Sep 2026 03:29:42 +0800
Message-Id: <20260903192942.21906-2-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903192942.21906-1-liangzhan5dev@gmail.com>
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race condition in tca8418_irq_handler() where a new key event
can be lost if it arrives after the FIFO is drained but before the
interrupt status register is cleared.

Fix this by re-reading INT_STAT after draining the FIFO and repeating
the process if K_INT is still asserted. This ensures the FIFO is truly
empty before clearing interrupts.

The FIFO depth is 10 events, so a loop limit of 16 provides sufficient
margin while preventing infinite loops in case of hardware misbehavior.

Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 9f0aace6bd21..0952370c0636 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -212,6 +212,7 @@ static irqreturn_t tca8418_irq_handler(int irq, void *dev_id)
 	struct tca8418_keypad *keypad_data = dev_id;
 	u8 reg;
 	int error;
+	int max_loops = 16;
 
 	error = tca8418_read_byte(keypad_data, REG_INT_STAT, &reg);
 	if (error) {
@@ -225,9 +226,19 @@ static irqreturn_t tca8418_irq_handler(int irq, void *dev_id)
 
 	if (reg & INT_STAT_OVR_FLOW_INT)
 		dev_warn(&keypad_data->client->dev, "overflow occurred\n");
+	do {
+		if (reg & INT_STAT_K_INT)
+			tca8418_read_keypad(keypad_data);
+
+		/* Re-read interrupt status to check for new events */
+		error = tca8418_read_byte(keypad_data, REG_INT_STAT, &reg);
+		if (error) {
+			dev_err(&keypad_data->client->dev,
+				"unable to re-read REG_INT_STAT\n");
+			return IRQ_HANDLED;
+		}
 
-	if (reg & INT_STAT_K_INT)
-		tca8418_read_keypad(keypad_data);
+	} while ((reg & INT_STAT_K_INT) && --max_loops);
 
 	/* Clear all interrupts, even IRQs we didn't check (GPI, CAD, LCK) */
 	reg = 0xff;
-- 
2.34.1

