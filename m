Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265315;
	b=tEhXlZbsKm23r8EWgq6RTTrduvHqTvCkZsWOOKzKJv3KH+EDxiJ1LPlA9z8Pqe3SUc1x
	 MlfAXCUEw/Yj6qUkBwBILM4MgJbKKBthZ4grW0OOEGnY75iX8xKNnbP4O1jiy6VlL1uZW
	 0Bn8TTXgY10p7jiVyfLgOchatCNbpslNF/cNhERmtkWTVkZQPguIaw7qtfkjm5lb4ZKCx
	 XHokTLo52S1GEoQzP88Yx9Z2KdH18slAJn3jux/zA5nvPJv/p/OB4Y2pLAlrQW4yiHMWo
	 ydoNgpbdb4WrIrAnUdP70YVXhk7+RGT1uH6HhsaGFq/37Jog3o08BIn7nzqWpApFwCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FgvFBR0X911CFkft+m8BaNuu7kHa0PuRcgZI2MmyPWU=;
	b=I6rDob004hhXfrWZHZq1+0BhH812R3su6OlUyt+zxWw/MvP54Tnf3BfJNbuu7c76QsD1
	 8CBOeiOyVG7Jhs1RVXPjdgoriraLw0VEmYHTtH0o8icSs4u5tq0c2qXpO/PjKE6FF5yh9
	 FG8kj/Ln0oeZFnqlebDvHFkdgcNEgG5nU0I2F53mTlAZXd3eOxpL22CfeXSawHpAFB/WO
	 ibyIP1VwtiU+ju9QBQJUifCcr6ztM/U8n8bJncrxuH6+pVKoA6w657d65dKVdyRrnuB9T
	 /i4GCuhEM2clu9FbzanjZmsTrh7wCyKXxd6kTXPRmlDhQw+D7Lye06ueqJmIrne9xeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uend4jGG;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5208606A330
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 12:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5208606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uend4jGG
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b76b2f6bd9so3354095e9.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795265313; x=1795870113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FgvFBR0X911CFkft+m8BaNuu7kHa0PuRcgZI2MmyPWU=;
        b=uend4jGGCxFejBsdJ3oJSBWKtcxush/+2myIp/OpATHcWrfYR7rurPdB0Im2IJDpiK
         n2HWgafbTlceIM4yq3IlxFNg9PDyTiRXn5T6Lnjln7WffvULmoS6QwgLDpD15eABi7GI
         zy5npyNmxM1ux0RMLpCYzEZmui+bL9j6Nk1f3fzu0hN4GIHhuGD1yXFy2ckiXnjxXBbq
         ODGcViF5vCFm3VykPI/zncp86bLK/+TkMQsHZ7jnWAp4uxOuB/GDcV1pCAtuhHsx/xK0
         L/LCE/FBSMXrMUQRioNuwTKWsMvlfZZIix4stPhU+TLe/SptaqVCyEFFysMG+em4sZWp
         aQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795265313; x=1795870113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FgvFBR0X911CFkft+m8BaNuu7kHa0PuRcgZI2MmyPWU=;
        b=PnAFO7GhghySZK3gLUNN3Xwx8OuOnZDEQhWP2c7NMHg1qTxJls8RAZp+xeLVJ5VOI7
         vrAIfVGeDvBViNtlaR8cgq+pQF8QXjowh5Eor1rWvU4llpjAgHf0VNyC5wse69gxIPJe
         HxykO2Qxp6/yYarKp/O1eBe69lxrN/tvAAoGe0nC1kAe2Huf2pJxYa/EDc+W+Jkvg3rY
         8isz8Pk3vByM6VGQt3ZNrL83zhUTryN3cIwB2lFHy5TbtSAyjgwPAi7bZ4zFKyIyLnHq
         InbcrlVCvytgRfvmFE/nKa0gB3tgvGb2Id7YHjs3tMip0e3FggpPCYNo/XeToaocavSq
         2D/Q==
X-Gm-Message-State: APuU4Z9wse/UorLR5rp+FR+pYwN7T4+y0C9eOv3Eg1aCTO9DaSagWwOu
	JRfbgsVGz9OknmNctaAaxgU/TJDIpkUglv9ccw81dwbpo2RSrizs//XA
X-Gm-Gg: AZFdTZdMYHk/9+fXa3wtFaDsy2p5OQIzR/65P+yYGnwpdqbd02FJ+UAPtJfTRFpwR7M
	I3MpHi/T1ULkRYCc9AugsWL3XHRm+lUwf1MM5qOW5MBSJpM0ZIeOQtjAodHOIvxwTdIjnEx4nO+
	RuC9h8266mixUodzQbOcR7+1vmj/gpY9h3o6FTHPTU3hvYcyy+BtHVvFV2ODwYIdvBGV/PFrVf4
	v3iocQWLymO93TEjoN7Z6wxCjN4QGP+zicEhuCDvcd9TzFhT8/77W/J/CBe9KmI9tGtS1S2YOiA
	K2WpFv/Gur252GYODZ04SeAxuSOF1tagD0/MkX6Ro0LoUKRhcINL+JWktLhE/0ZW+RdijZwChyy
	rCaNHuOVd8wZeM9IU8S/cx44S7GyX3Ahcqp/KN670Jl/se0qrjC5K5+DQiDnjlq2d8vRII8R1n+
	g1TfAa7xuLsgFIand+u5L+kz9kM8A8Jv8rt46NjixUb9dlFUPoKeBwNqux0hJ5cZ380KljcWoeU
	G6clroPWC7d+MRTbQDA4QP8oLrn9SG2eOqndB4CA1IBt54P0tCVY8EQOKwIhN1yoDSWC6oLG9CO
	0dGNmXNWkuAMNsqvJgaS6SV79+jIKiwK4hwxIJnORpurjA==
X-Received: by 2002:a05:600c:a55:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4bb88827db0mr145226565e9.30.1795265313087;
        Sat, 21 Nov 2026 04:48:33 -0800 (PST)
Received: from bullo-XPS.home ([2a01:e11:1020:c3f0:892:8c82:19f1:6d0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm153428355e9.8.2026.11.21.04.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:48:32 -0800 (PST)
From: Bullo27 <matteo.bulloni.27@gmail.com>
X-Google-Original-From: Bullo27 <matteo.bulloni@mail.polimi.it>
To: matteo.bulloni.27@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmc: Add T14s Gen2 AMD (20XG) to s2idle quirk list
Date: Sat, 21 Nov 2026 13:48:12 +0100
Message-ID: <20261121124812.12165-1-matteo.bulloni@mail.polimi.it>
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

From: Matteo Bulloni <matteo.bulloni.27@gmail.com>

The ThinkPad T14s Gen 2 AMD is sold under two machine types, 20XF and
20XG, but only 20XF is in the s2idle quirk list. On 20XG machines the
Lenovo BIOS SMI handler runs during the NVMe D3->D0 transition, so every
resume from s2idle stalls for about 10 seconds with a black screen.

Measured on a 20XGS08D00 (BIOS R1NET68W 1.38, Ryzen 7 PRO 5850U) with
pm_print_times: every PCI endpoint's pci_pm_resume_noirq returned after
~10.32 s, all finishing at the same moment. With the s2idle_bug_mmio
workaround applied for 20XG, the same callbacks take 38-82 ms and the
stall is gone.

Cc: stable@vger.kernel.org
Signed-off-by: Matteo Bulloni <matteo.bulloni.27@gmail.com>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -56,6 +56,14 @@
 		}
 	},
 	{
+		.ident = "T14s Gen2 AMD",
+		.driver_data = &quirk_s2idle_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20XG"),
+		}
+	},
+	{
 		.ident = "X13 Gen2 AMD",
 		.driver_data = &quirk_s2idle_spurious_8042,
 		.matches = {
-- 
2.43.0

