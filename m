Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045786;
	b=yD1HdyU3lyKAYZlkf3xm8uCdS27eHtpQhAFnF0p56r0R5k7QaN08fj3bZCOlf1BUNkmw
	 ii4WoGANdIGtHdScrNy0WnJ4TyRZcXfjzquwZUMdrcSmis8NKRfcakgxzRc1wNUvEL84p
	 ZjnQ6c7Xp2KR579bOXDWdNJ+y72b1frf+HqhANQJuazDHsIq6oSnceRcjlFwhgb5qZleq
	 le1T/FfiFgK4j1sIxb0AqmzCuXI42tBNKBwAcbDrR/30uCzwJbzM2icxeHv7w7XcyQ292
	 h383nKQ4bmXc+BA1Gr3MQDiII9V8/hN+rteIbHDWK9GHjpJJIuiy1XG9TJ25fNtNTOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hjw8ufxY1uqj/hElRvoiFVTy1rX/3DfCiEVnshIZW2A=;
	b=vUIAKncAwrP7u5qSeD2Z0K6zYavu/IYtyubMWDNzxE7i/IWcQqQkK5aDpFo251UC/mZa
	 P4yLA5wsFopBG31gU5Grjl53i+xCHkGzYVQ66hUVuqCOfE6sfAlNf5ob37M55V57BEpYZ
	 8uWAAzJxf0nsyUcsMPI4jMlrqrFVQDP9J2Cqzh4BNCSrT0cHa92u8AW+5Tk7MmvTSWv6D
	 kQYGS6E9hmcGySxsQkf1Xtc2l4C5PZXFJYwcdjFk+ZUvihaXs9UhnyrdRzO/q1Rs0BR0C
	 1aCyw5Ok4mDozRRx0AIsQZfgRNYn0uyKe8PsvXSUer+BFF2Dzsq/f9vRdNOY4QrNxZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWcROtAn;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F90606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60F90606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWcROtAn
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso800036a12.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 02:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794045785; x=1794650585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hjw8ufxY1uqj/hElRvoiFVTy1rX/3DfCiEVnshIZW2A=;
        b=lWcROtAn5ro20ByT9pzIBwjOOXNBIlWks/Fn0Nn7kzh+SexDXRr99TJWnUGEVCa8yL
         UlKZZKVZsKzKCYJk+6BMNZUd9S1eMN9b6s9WkbTROt3v04LvxGDERPFVNoZ07BGY23U6
         ATO4Meb5Vg9izol4qgk4OxWnGDuowW3gpGWJ0BhxYAVg57b7IcynogZ0DcWLQgw+3xH2
         0rpQdHqm2jlmAbGlsrQ/R/ve5ZBrjPSXjjKyBD7FVOjSpyRyMHLCd8SF7SHZEYnkGfs3
         mEgYnru8FvA6WDemNBkKlFhE+3M+BR4JmyCgOqip4pPM8fAwxgLcZTLxod5HL3Xp3tGp
         4gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794045785; x=1794650585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hjw8ufxY1uqj/hElRvoiFVTy1rX/3DfCiEVnshIZW2A=;
        b=taHdtPVEf6OtpvvGdgWi8nd+65Ra1frPrJ/qBoWwJs4k7iCJ+eyi093rKwBJx17ep8
         eCgeLHKy0Njuxivtq3t21Y3rXyoktgc8awMNR+gx1E6YrcNUyV4w70YIDSRi9N+NOGCm
         0QyacOopHMKfv22gqmz3Ai7+iKf619jB4XH/HxDJlGkCxbsWcGmWdGKkBQX8VwpeVbNI
         w2Th8za9GmCWAabvVA9iXf7xlCGm1fMZgU3/XkhaTt/041qm4zEuk0ioqarAY89Li8W1
         +7PXHnJHTmU3sQrXNLznlTjeEo/PoMznNi5PY1I8Nqs0alPFRnMsOTtTVqHRHA6kmzxY
         ewpw==
X-Forwarded-Encrypted: i=1; AL+hErF7AMeyVwgzWGYsajFa2kFbJGLXUOFPBZ5K2MubqK74UPIUaLb/B+xaVRT+dy9fH5UBVVaNwt8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+u0XfYlcJBSfmureQ3vv+ANgSfSG3km2EQdScfHcjJLqsPTLq
	9/Td/RZhiDeMceqZdwtoxG2cfudTvij6w+X6DA+7bqH8SasRPAWxtTZK
X-Gm-Gg: AYBFou0uq6LuiFJ9J1TyHI5Oym8Wm12qI8M2YqK4+cwXkX+WIXnlKI8vJLPFsOy4EUR
	Dom52HQDSIlHzJZ0BF88uXAXUEjFXZLgJgw0LXbdEfHWHleFmwhqdEpWjr3/P2QI7+ieSMRgbKT
	wdZeVdeOOj2Tl5kGsK8NtH566+i3FwdfIwb85/T2eK3bzWVHRk9wPC8Zuahpyqlv3/DQwtQt/zw
	+Oz24dtuYjnxJARXvyNaIW1ucIRunlmyOtRoYMP5TiPwcsbnKVLz+TGxTuQfmliZnuCQdOz9HMg
	7bjctmpt7Fp9LnnUYXELRse6AKdvI7wlMCTtcMACYuEkxyQHm/e5fpCuXzXTx1un/RmXjIZBmba
	7MA7rGPZ3u527e7PfN81r76xAal/3zLnR27C/Fw+eJZyyf6kl8grI9xXEattqyJAkPa3yEXgV6u
	nPk8jCE+ulVCtwr4R6ZZBIqzD1VNfCg4y9Je5Dn8UqLkqWhxeyNrRzUe/tnoCjZYTOUQCLqIxNW
	fq6Zlli7R9fspJo732crO5CMIlMcR88h9k5MY9qzi6Fc36cD9MJilwRDkbc5DOzIsJlK6ASXVE8
	HUvDhN3ezHuNKTzJZXnNSNylPahdAXeyQco2XJRCkh0CZD2S
X-Received: by 2002:a17:90a:c10f:b0:3b0:a3eb:759e with SMTP id 98e67ed59e1d1-3b0db6a8de8mr4788271a91.17.1794045784240;
        Sat, 07 Nov 2026 02:03:04 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057c2bbcsm2857110a91.1.2026.11.07.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:03:03 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-phy@lists.infradead.org
Cc: Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] phy: phy-bcm-ns2-usbdrd: cancel extcon work on unbind to avoid use-after-free
Date: Sat,  7 Nov 2026 19:02:53 +0900
Message-ID: <20261107100253.3543022-1-hj351016@gmail.com>
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

From: Hyunjung Ko <hj351016@gmail.com>

ns2_drd_phy_probe() schedules driver->wq_extcon (extcon_work), which is
also queued from the ID/VBUS GPIO interrupt handler gpio_irq_handler().
The work handler dereferences the driver data via container_of().

struct ns2_phy_driver is allocated with devm_kzalloc() and the driver has
no remove callback, so on unbind devres frees it after probe's resources
are released. The GPIO interrupts are released with devm_request_irq(),
but free_irq() only stops further interrupts; it does not cancel a delayed
work that is already queued. probe() queues wq_extcon with a debounce
delay before returning, and the GPIO interrupt can queue it too, so on
unbind the pending work can run after ns2_phy_driver has been freed,
dereferencing freed memory (use-after-free).

Register the work with devm_delayed_work_autocancel() instead of
INIT_DELAYED_WORK(). It is set up before the GPIO interrupts are
requested, so on unwind devres frees the interrupts first - after which
the work can no longer be queued - and then cancels the work while the
driver data is still valid. extcon_work() does not re-queue itself, so a
single cancel drains it.

Found by static analysis and code review; not runtime-reproduced (needs
Broadcom Northstar2 USB DRD PHY hardware).

Fixes: 787f24543c4a ("phy: phy-bcm-ns2-usbdrd: Broadcom USB DRD PHY driver for Northstar2")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
index 171bf09..4b8930b 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
@@ -6,6 +6,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/devm-helpers.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
@@ -339,7 +340,9 @@ static int ns2_drd_phy_probe(struct platform_device *pdev)
 	if (ret < 0)
 		driver->debounce_jiffies = msecs_to_jiffies(GPIO_DELAY);
 
-	INIT_DELAYED_WORK(&driver->wq_extcon, extcon_work);
+	ret = devm_delayed_work_autocancel(dev, &driver->wq_extcon, extcon_work);
+	if (ret)
+		return ret;
 
 	driver->id_irq = gpiod_to_irq(driver->id_gpiod);
 	if (driver->id_irq < 0) {
-- 
2.43.0

