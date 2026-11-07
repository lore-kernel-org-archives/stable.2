Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034990;
	b=VLpo+Y5xrzFsJkE4dzSG+7WwUp0BcbI7nlpifwGDyOOYelqxgJundwrUtcPe3yMTSupK
	 cMxWO30USK6csIilENEGWV5g3GIQxZQrTr+lrcuEdqJVU4jcWo3Dd9JEwbah9PT+gZsIw
	 Rug94P7IMzH2JqT/zb2QOcbN4QTS5qDNz4QZQav+25tswXZW6HsNkzCYP8bfBlJ40apCZ
	 kKt9AucsmDFdtJ3yJxP9YUNs3IQ/7GNMDldSI+kh21lBtyjzVq6L0E+129HMJWktqdzB5
	 ubiPO5T0JMbF4c7mnk93eezZXQlARzIbHJRuJcAZ0YNYveVNHm1O0/OTH3Jv8brg7Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bFEfHL+TsS1kVBZGSFsslYDN/djqa+P4kfXVi1Yph7g=;
	b=JV5+drkCJu6fwfl6kNcQGeLjOAgZC+Zx7hb62jujTpaUvS/I9X7F8x4Zj9D+ji0GD18K
	 XH4AEdqBdE7fQyTimBYT8buZA/vq7WH8s6jVv1ZA8rRZe7u57WhmKimvDYz21iEampMLR
	 +EpGGaOwNodgXqYpIYqry1IGl5z8vK7aZyBRTGV9FryhzXqkwD4cFbvMk6cR9P5kLXxc9
	 ATT+olvzPIFZboyxIT7BP2tbVadWoep9V7lSyez+TVVfgVAvvIJd6wxjREQHiX1TcPeix
	 nE30AepxKg5z4Elao9e7ZxiF+BX2Q/u4ehUR2pStrlCI8s8UcHx3D30ka9PNe02YkzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GcmYpw6e;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FBB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 07:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80FBB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GcmYpw6e
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1140370a91.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 23:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794034990; x=1794639790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bFEfHL+TsS1kVBZGSFsslYDN/djqa+P4kfXVi1Yph7g=;
        b=GcmYpw6eafQhXUAXEwA8jwummuHvOzaIwSi0Y74SZr4ARQSCpITqDEnVzsgzgEsFFK
         8XA3N+FlcWdCRo6cxvHhjVmbXoQCBTMnvihWtnebvnUL3NP3Kkpim/1OsujmN6CK+fW1
         geLraiZRO6B8jG4UZdjv+zwi43Jlr2aXeZgNaBPowHqPglGKqkButi623n2sV2Bvqsrv
         t+disbEPHRq8Qd0BP166jNXPM9Gqr5OHyQmNU0ce3pgBHLxLRP9CqDP2hWoTHyRYQzdY
         0oQlaX9hiO5XM3aPoarRtrL9S76WG92mEJ3+29HAyk72Et5dbOW6rKyGY9BwwARORPD6
         pEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794034990; x=1794639790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bFEfHL+TsS1kVBZGSFsslYDN/djqa+P4kfXVi1Yph7g=;
        b=hfDHopTG1fOmRX5fzIv6kDUW3U3myuaxYyY40zlH4wQJqzoiC+kulXAoK9LVfsM7cg
         Nrc3HJ4kpuvAevknERRfdoNM2ADTa5yDKc5cdeLHMBBZrygJ5qxA73+hwHj/MIOHSC5M
         i5o4Y17oOyCh6mPav1/Xgkz367RrZsONw+nzc/MH1oJcHwZtIGfe5+H0mrawGoOkqYXv
         qKkWkmwWQAQT5QoxA66I71IpDayXeRjfVXsrW3WOzK4raUG5r7Di3ysYo6x3H0LOg2/4
         k8tlmulNrQTwcV6w1vh1FBJ2+5keAm2VeHeAJWkjH0iaeRTjy7y9u8p4aC2V2/gVFz3i
         AGcw==
X-Forwarded-Encrypted: i=1; AL+hErEMvbXzfknY9GrkZnN1eBvxIHXa73jAs9tF0TMwf6Ms+k3m6lPGfX8z4PqRQ7TgL/v/ZOKWKM4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0cj4ZgVio/8Uu54Rx40LTFy1NZtBvxqMnP5Q7+i+Sw/1CKX9m
	tN98X28bjQUndG0u7b3q2dL0PErnsVIMKui/4VNFKB1lTRlqGKnk4WOX
X-Gm-Gg: AYBFou2iGLUKa1gLI+mtHATqjqKAE2EQseCSjRRGaXdK9G91AXdfXPgT/tzN7yXp4i3
	yTetUa9CkmmTMdD5iztu1JnZhUd6jIm7qHNH2H/FmVa5p6cJ5uHtJ0FphCgvKHJJj6xi64ehl2p
	hscdhGq+Op/lNgXrN31+cQUOIeHW+yz4eHtCcW7knAOQ9iXfeXarX6p7n/vIOlxkcX1/1tzD7xV
	czZHa9u2Ibmgjs2l46Q8Vr84fZHxCnK7eziNzChspRjwDlg2/Lpn+xBiTzHedhlHzdpQEi/gLX5
	nmYdow8bV/K3fBkRYNOCWGTPAkcNMz/FQXoN0pvNVSfmxf/QPDLAwdGGKVsb+wnSfHbd8fjulmX
	5fQu/+StYhF3FD8JjQDhFKJHg3BXSCjoJ96coKmG5MmvByr3JbUd3OEAbkOtHC9TNcZNznYBbNK
	PuM9jEJhLURYnCf9hulDjiziJ0UtPacWT7unnBG6jQ667hMhYKw39+vtx9URswrxl2ZMtKN8Cu9
	Pgs9B+6/+Ji5DYPW/Ct4NI+2R4evgS/4a1GuN2Ex0USKkVC0aTQW1HPAWq9vbgnhhF9MUDe8ktu
	J6/1tUTnWxsFGPfp4f6JbshxMGWlVeLrwT7RhqwCGtKzvWZx
X-Received: by 2002:a17:90b:2792:b0:3b0:cc6f:1046 with SMTP id 98e67ed59e1d1-3b0db7109d1mr4442933a91.67.1794034989765;
        Fri, 06 Nov 2026 23:03:09 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057c1c2csm2220866a91.2.2026.11.06.23.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 23:03:08 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: pch_udc: drain vbus GPIO works before freeing the device
Date: Sat,  7 Nov 2026 16:02:58 +0900
Message-ID: <20261107070258.3413402-1-hj351016@gmail.com>
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

pch_vbus_gpio_irq() and pch_udc_dev_isr() schedule
dev->vbus_gpio.irq_work_fall / irq_work_rise (pch_vbus_gpio_work_fall /
pch_vbus_gpio_work_rise), whose handlers obtain the pch_udc_dev via
container_of() and dereference it (dev->driver, dev->pdev, and
pch_udc_init()/pch_udc_reconnect()). Nothing cancels these works on
teardown.

pch_udc_remove() -> pch_udc_exit() -> pch_vbus_gpio_free() previously
only called free_irq() for the VBUS GPIO interrupt; dev is allocated with
devm_kzalloc() and is freed by devres after removal. free_irq() only
waits for the interrupt handler to finish, it does not cancel a work the
handler has already queued, so a pending or running work then runs
against the freed pch_udc_dev (use-after-free). pch_vbus_gpio_work_fall()
polls for up to PCH_VBUS_PERIOD (3s), widening the window.

The two works are armed differently. pch_vbus_gpio_init() assigns
dev->vbus_gpio.port and INIT_WORK()s irq_work_fall *before* request_irq()
sets dev->vbus_gpio.intr, and pch_udc_dev_isr() schedules irq_work_fall
exactly when dev->vbus_gpio.intr is 0; irq_work_rise is only initialised
and scheduled once intr is non-zero. Cancelling both only under
"if (dev->vbus_gpio.intr)" therefore misses irq_work_fall whenever the
GPIO is present but the IRQ was not acquired (gpiod_to_irq()/request_irq()
failure, or a device interrupt racing removal before interrupts are
masked).

Drain each work according to how it is armed: cancel irq_work_fall
whenever a VBUS GPIO port exists, and cancel irq_work_rise next to
free_irq() under the intr guard. free_irq() runs first so the GPIO
interrupt can no longer schedule work before it is drained.

Found by static analysis and code review; not runtime-reproduced (needs
EG20T/ML7213 pch_udc hardware with a VBUS detection GPIO and an interrupt
racing device removal).

Fixes: 637b78eb31e0 ("usb: gadget: pch_udc: Detecting VBUS through GPIO with interrupt")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v2: drain irq_work_fall under the GPIO-port guard rather than the IRQ
    guard. irq_work_fall is scheduled from pch_udc_dev_isr() when
    dev->vbus_gpio.intr == 0, so the v1 "if (intr)" placement skipped it.
    Spotted by Sashiko AI review. The separate pre-existing missing
    cancellation in pch_udc_shutdown() that the review also flagged is
    left for its own patch.

 drivers/usb/gadget/udc/pch_udc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 99b3ce2..5351bd9 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -1406,8 +1406,12 @@ static int pch_vbus_gpio_init(struct pch_udc_dev *dev)
  */
 static void pch_vbus_gpio_free(struct pch_udc_dev *dev)
 {
-	if (dev->vbus_gpio.intr)
+	if (dev->vbus_gpio.intr) {
 		free_irq(dev->vbus_gpio.intr, dev);
+		cancel_work_sync(&dev->vbus_gpio.irq_work_rise);
+	}
+	if (dev->vbus_gpio.port)
+		cancel_work_sync(&dev->vbus_gpio.irq_work_fall);
 }
 
 /**
-- 
2.43.0

