Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794029553;
	b=O0rtrk5M9imDcKk/Yxif6Fw0hIt4GXPfSlVPvuTQqhAbrS1osCIAWpaAS4hmVY6TfGHQ
	 OHi7ZSfXMw/4NY8BpNVSh56EvhLbSk3o5M25CSEAlC4dsBeSc/esBILBR5MSlDtBjaSUl
	 3kmorOjqjrpOa44UjKjHBqFTYz14kw9Q2jhjUQuLcxPfUm+g0gCwDmKwmsb4wx9gGpaYZ
	 GmI0dz59WjES6DYWZFEVYp8tKPCtTRti48z9pdjxlZUjliGIICfBlrEbwtK+zxdgBcT8z
	 r5Rr8XX4Y2izNE00VkYi0CXEN3+QFAqU+4Ntjcat++3rcHIPbRe46Li4cK0CV8WG1gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794029553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6sW0z1d5SKi+Jg6QexltnX75AHvo1gx3Slpp03kBvI0=;
	b=36rOKz+Gu6+/ZPUGq6PHDIpegnomYREVlWK1iUqpxxFBoZi7VXZ/tG5nrndx/5cBzfml
	 Gz7jlnDmkCIA1v2IaHx8/YgfsltETip418H2FXxqBqBFwP3wX490FNjz/f2iXK8Ac6nVj
	 DYziL3zOxXifD77RdYoE8KIUFAChu02BgGxUxEoYHMLtgEQaAXeif5fztvGqYKn7h5nKG
	 GoG6jp9S2LsiTWy2B/vTGrnetLse16iHO0M4xAc8DRI9gl87gOkf+qBKD46w7mhFnnatV
	 S7IJUlyYvyF9RI566/uLcero65p8AGujTWBng8AUBLWLUVzq244LQR4/Bm3wCm9BjVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N2RzNSmy;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36499606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 05:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36499606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N2RzNSmy
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so23928a91.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 21:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794029552; x=1794634352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6sW0z1d5SKi+Jg6QexltnX75AHvo1gx3Slpp03kBvI0=;
        b=N2RzNSmyusmLoY8g/mYzOOXpMkwMV+nt4Au5OExq1lWzAth0BoRtgb5KnabOAdMS7l
         Jbmj3h0AnlJT6JMhcEs/L8BfW0tS+1bkTprYeMusbzhRuO+g9fUQCGT0QZSbV1UMhADX
         q+d01OEw21eD+8kOVmqeXwCAhHPZ1RGKL1T0RoAh+QUE5jHGD378S6AHzxVSZss4QnLt
         09ouoXBH6jK98P4lIbQO+UCedHeyY4LhZFmc2CtMRL81/kpXO0iSCXnt1KxssqRSoJng
         tn06ClnIDO8C7dON4lk8Dw/n2RV6jj+jO2MVTrI5/1a1ckG+Kvml4/rT1x+VKfsBi9jr
         G+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794029552; x=1794634352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6sW0z1d5SKi+Jg6QexltnX75AHvo1gx3Slpp03kBvI0=;
        b=2ndDP7LQR1gs7nmh6hEMSufx6gRwlWXVQyKpXceNTqRWyvLBC/XW6JdHDLV3gEYUrF
         OZM+P4m/Y6Hp7cx6DHp7g+m5HtgalDm2vYhfTPtHOF4zvbmXCb3rJ1CVVfjC3mZZ6b8L
         chG0ZhhGXWlOgNYKSuewhal9Jt41+c/eORPFq8te2eE1boquvTa/RiNWk5N6sdbQFHyY
         tzWDYgJ282GbmUK7We35WRaLQv/eKHkYLYS2bUwqhUE1WMZKST9xjStYpq5wl6kJFyl3
         H0k5Mo1hg9A2nKiZg4LT0yyJLV427hjfA4kPeo29X8pOHZvC1c8rfByoWJU4D+uakKor
         8Q4A==
X-Forwarded-Encrypted: i=1; AL+hErEW7G3Lb5KwPzic+W7KZapUsswhpgVCGd+OpKzNcRHARPjPmZZSi76K2yOU1c5qOKcv6l/5KMs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hVto3jdiI8lLc+NfnQ5mHPRNR5NN0MYOX66eLsNWLP+63hqFu
	6ZIOYHomAQrFgOqLBldAI56MjxZcBcb/RMQSmb8dRJqRli5gnWymrbj1ZLaRKYOC
X-Gm-Gg: AYBFou3Ig/foSQpnNCw+cvLgr+62ih7u/FzHOZ1AtWdY9ePCGO1U3aG0g5F88326Tx8
	PTEG1+u6qzTNjpRupt/+bZtKOVjiSywXEAHIcYkXI7AezZYckYL2hBpmY0QXmrxHbatuX/mWkOj
	V4nDB46GMWkt5K14QTLx9bZe0mGytRFuN70qTTRhBiT2iogytsT73a0BgMwpKydwAhqthgIGAkE
	sSJI72ozT/6zEBBZyS2GIVU2OmSgwdkDs5BnhpYrY9usO+jZcUNZHqaRRlnjICiVLfmXb+xjYLD
	AoK4KLMcKJtO7rKuYjJvCkmy6m9NI5Nge8y10+CI/crVpEVAbGtcCGwV9hmCbSbM44KMGtxubae
	VGcNzwI5vRNAfsd3N1kCSBgxa6gjTCU+k+pixs5NSaA4ILfpFhQk9FsSgaDSTwzEvttFs8hBYZ/
	Z0yzN4ib7pkFfGQkziEe3IyRafkSAHUc1QFQNmjcZWbEZcznjmS0kEhR0YIq9qfHMmSjDYk8Mak
	J+fTJUz7wzCEAcKuOreZSXIj9xdW8cHWPBISexOA70eQbKtM6uG3/Npv/8RZe9eIBz5nf7f7dbD
	s6Lv1VGZ0K+KSEutZnmGb3CkMn2uivteuSAqaHFaHBrG/gQX
X-Received: by 2002:a17:90a:d24d:b0:3b0:db75:4bcf with SMTP id 98e67ed59e1d1-3b0db754c65mr3213278a91.42.1794029552419;
        Fri, 06 Nov 2026 21:32:32 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101bc4586sm1246851a91.2.2026.11.06.21.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:32:32 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: ls2kbmc: cancel the reset work before the driver data is freed
Date: Sat,  7 Nov 2026 14:32:18 +0900
Message-ID: <20261107053218.3326443-1-hj351016@gmail.com>
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

ls2k_bmc_init() INIT_WORK()s ddata->bmc_reset_work (ls2k_bmc_events_fn)
and requests two device-managed interrupts (ls2k_bmc_interrupt) that
schedule_work(&ddata->bmc_reset_work).  The work handler dereferences
ddata via container_of().

ddata is devm_kzalloc()'d, so devres frees it when the device is
unbound.  Nothing cancels bmc_reset_work: free_irq() (run by devres)
only waits for the interrupt handler to finish, not for a work item it
has already queued.  If a BMC reset interrupt fires shortly before
unbind, the queued ls2k_bmc_events_fn() can run after ddata has been
freed -> use-after-free.

Register the work for device-managed cancellation with
devm_work_autocancel(), before the devm_request_irq() calls that arm
it, so devres (LIFO) frees the interrupts first, then cancels the work,
and only then frees ddata.

Found by code review; not reproduced (needs Loongson-2K BMC hardware and
a reset interrupt racing driver unbind).

Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/mfd/ls2k-bmc-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 408056b..c44291e 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -12,6 +12,7 @@
 #include <linux/aperture.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
@@ -371,7 +372,10 @@ static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
 
 	ls2k_bmc_save_pci_data(pdev, ddata);
 
-	INIT_WORK(&ddata->bmc_reset_work, ls2k_bmc_events_fn);
+	ret = devm_work_autocancel(ddata->dev, &ddata->bmc_reset_work,
+				   ls2k_bmc_events_fn);
+	if (ret)
+		return ret;
 
 	ret = devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrupt,
 			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc pcie", ddata);
-- 
2.43.0

