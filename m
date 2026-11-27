Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782490;
	b=W/IyZXg1ZXceir0Rm9Wqlsr/yzqA8QMkHq8BqO45j34kQX3206GknGh8mWTLEeSjuMzR
	 FHgnuMbh2L6yOLPBECtB2jrlhVO8fef1DHn9geinVQrIxUDI5CoiUNA2qVCf+DrHYp6CG
	 rfLV9ser1gQWORiTy9bim3fNre5ALfRCVEBu99LclJzQmJbYZ7ARA8ppGZowCUEee7dvF
	 AXYW7PFbXB5Pl5VAuEAZElY0sXcn0pW6RwGUs5IvBGOrqYUtfuQwxdb7t3UsRSTnO/uJw
	 HFZObBssUb9r80pSoTQ4E/EIEKKpLF0QoeDLq94bvDGvebrDt7n9e6jtukUHfcP7UDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ffGLnC0aeYuZNoJ1T080BFlrB7SMYKCZd8bWmNL/oEo=;
	b=LT88BqhsD6UN9L/XMWuUJk59rBR4J5uhKq39p8uqPudBXcGA1GdTDTe7Z+G9zEB2yccP
	 MO1WF1tPTgut6KXm1ghQmc9aHHoUqxDcLnRVa0lVdqKw6U+GTIkOh7dxox42d5y0RXsXR
	 2d86uTNRLqwrZiXV+LkSMQadLxW8DSS8ff/y2Md/xGpI+j5eRePvbrXm91dApEsHft0po
	 ZvS/5h1xQPp/3PFTxqj6MDBX3wgVl9reyAQw76ZOgVFebXTgjERQItspgpG/AAuFZsLe5
	 XwWHRuKekuA6XhZ4DQ6DsRHs8nswRpUzOTEf46FTQ3siR/OdP7EngI3BOOP3LcZfsIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pz3sVaTt;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4BD606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE4BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pz3sVaTt
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b51a9606e8so1045146a91.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795782489; x=1796387289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ffGLnC0aeYuZNoJ1T080BFlrB7SMYKCZd8bWmNL/oEo=;
        b=Pz3sVaTtpbmmaBVlyFQbjlZtmm4IGqjrlNDNkTpfn9JeMnRlHFz22C3wGHd+Rit3xS
         SHu1UnPm2Bp+hOU4ekoz9u+z873wqcgNMDHd5CDCybsUOR5ixWEjwVjG/wkzIBS45J/i
         lZIqaoui5H2yforNM8BkfvnsgkmtRFoq7jVYYtgYMeCx08pbfDdE83ZkLTACRuUHaC7t
         uNTSCpE4+MoTjjXYlNJb3wQ4JThBA9xDshxeisC9ZLEk0nHYmqHTBfZMkHIZcaNDzpl0
         pkcljDr5ukJteFtoUnuuUnrQxXMhNDnru4ON6Abf3QrO7c00w1jUlD8vK/ZmdU/292Bg
         ziiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782489; x=1796387289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffGLnC0aeYuZNoJ1T080BFlrB7SMYKCZd8bWmNL/oEo=;
        b=Rwhe3+BFaOHGSIyLGhA2DUoUZf73TvGQRFTj+vQqhF6CqNK87EmcroItQuseWnlzaB
         XLg+Lr6SjvAFrn4q2UdaHL5J9SRpGrtQ8EQSEqHc6kkPZsTwCoLRHoJu1vHukFzzOziD
         1ty7CPBKWAyRHvXYf1UGFKyX39XaXXNxYDDcupttZcLom1xpz3H2iDNJBmexKWo7RGYI
         P5OTSvkJPG9WY/Gj8Sp9/r1qc6Mm/mO1NXXw7KvulGAHo26TTbRZGj9plJzCcwb+tJMk
         d5lUcSODk0c/emcDmiLnZELkSo9UjqVU+ETOFO35OYFcX/oMxpeFu7Qrr2pqWUTTIj/N
         n0XA==
X-Forwarded-Encrypted: i=1; AL+hErESR6CqSRFWFaym6G0lSunVwakLS4v1cxhSotEITLQog9xOFb6N1zIfnR0KfHxzWNzeZA+W8Tg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jHO5QXn3aKifC2o6k4zU3g8Fjciz8pzFwjwmu/XELX1LaQTNH
	zvVU+6fIH/bRAmUtekCmj2EqQVRAuQGFElY13Dqcm5mtVBrCVsMZsYXk9M03FQ==
X-Gm-Gg: AZFdTZd8T11S69NVO83sRSoWpV5W+T0dsS3+n0iCVXlNw12SUAaFUsOsbsMWewGmA4W
	T787YHgL6pJmlMkpiC7XG/vmHTHphwlXojs/Q0ufD/9vQYO3CjrI1LVC56TiihUG6TlCjhrdQSn
	rWGR+/sZA2TepkRqduN3ibzUtM7QkQYKbdO6NQhsy7nweGV/2yWqEYDqiQFaSR2fy3WV9GWKg0S
	SOdkoQhXF4+550Nq64cpOmOkglLSs9Uz7PocUtMrSTrQ20MMgttZjIjFkcal6ppihiRvhuXZemP
	WHS+HiLxrtnSBto59qUzil6Ksras3+BeSMb5OEwTGeYERfzxpr0Jr/v7OGDr+41IHX8j4Y77tCj
	HC52zeBGHvU8suToFbm6BmTAs5tvCRJle4vwkpR4j/yv+hyN+4HijStoGf/Z5qsbSfGefWgvct2
	zHvcmhriy90xrLddk5+NlPcoZpWinzTUofFD2Oi8f0tYL3+YogUSeIxZx7CTniuoX5r+ACeJuWg
	l8chUMbr2wiSCS/vQjSVDtIJryTcMFHESIaAt+zuLjjsSB88gwmAt+bk+tRPduta/hv5e5PzX6q
	gjXOSxmPk3NbZJcNlt9Fc7OuCIlI273pIkUitbD3hp/JJuWm6DJVJNVbOLkZU2Fuw0X0lrfG/Jz
	gjaF3fJnoVY9CeKHGT2Zl1kzqBoRrA7zR5PuLbN6IRA==
X-Received: by 2002:a17:90b:2ecb:b0:3b3:acea:46b6 with SMTP id 98e67ed59e1d1-3b41c95e795mr22986239a91.58.1795782489182;
        Fri, 27 Nov 2026 04:28:09 -0800 (PST)
Received: from envzhu-ertl2024.taild6e5db.ts.net (115-179-78-224.aichi.fdn.vectant.ne.jp. [115.179.78.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b495035339sm25088215a91.0.2026.11.27.04.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:28:08 -0800 (PST)
From: Yoshifumi SHU <envzhu@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Radu Rendec <radu@rendec.net>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Brad Hawthorne <brad@sim.vu>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Yoshifumi SHU <envzhu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "irqchip: nvic: Fix offset for Interrupt Priority Offsets"
Date: Fri, 27 Nov 2026 21:28:01 +0900
Message-ID: <20261127122801.4189591-1-envzhu@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This reverts commit c5e0cbe2858d278a27d5b3fe31890aea5be064c4.

nvic_base is mapped to 0xe000e100 (NVIC_ISER0). Thus, the Interrupt
Priority Registers (NVIC_IPRx, at 0xe000e400) are offset by 0x300 from
nvic_base, not 0x400. The reverted commit overlooked that nvic_base is
already offset by 0x100 from 0xe000e000 and incorrectly changed
NVIC_IPR.

Link: https://lore.kernel.org/linux-arm-kernel/b0be3be5-3a7d-469e-9166-a3414a52cbea@arm.com/
Fixes: c5e0cbe2858d ("irqchip: nvic: Fix offset for Interrupt Priority Offsets")
Cc: stable@vger.kernel.org
Signed-off-by: Yoshifumi SHU <envzhu@gmail.com>
---
Vladimir asked for this revert (see Link:).

Tested on MPS3-AN547 (Cortex-M55) and EK-RA8P1 (Cortex-M85) hardware
against v7.4-rc4. On EK-RA8P1, confirmed that the driver now writes to
the correct addresses for NVIC_IPR registers.
---
 drivers/irqchip/irq-nvic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 2191a2b79578..9438891e66f2 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -26,7 +26,7 @@
 
 #define NVIC_ISER		0x000
 #define NVIC_ICER		0x080
-#define NVIC_IPR		0x400
+#define NVIC_IPR		0x300
 
 #define NVIC_MAX_BANKS		16
 /*

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

