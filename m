Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6E3ACA5D
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477317; cv=none; b=fkCXBa5zAnTADX2BSWuscA1Fh2tBUHZZ0gBGuotpQ1up6e880M1nbYU+buseCkhws8k7UJz1FjiwBD9KRHhRc0kZ1O87Jv8vS4s4SOVHtI0j4YZ/tA0vRbUdVvabVbqr0ZplejWWk7fwRnnQTGIqpMNHlpYHmCxNtCZjOEt4dkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477317; c=relaxed/simple;
	bh=xep+DbUTODAyiI61W5CCxIKqMCWLvMAtORFdzKJXX9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHaacgGRtt0eMQ/b29DDQ/JkzmXFeBE2B/yrZC/NhtI1MjD4hsyXMif6LPsNOstSOlChVx5zyORnst5K5DEURTN1r42C7izS685iWHO4ulc3A4IJEv4FiQMlJUZSgAAZ7LJTkNf9qCti+t6Cg/ozFXxsRe7lCg/NWqudMi+EEC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjMADF1t; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjMADF1t"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954df200ddso9811745e9.0
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477313; x=1785082113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T7BUDbPgvu4uYiB0I4Tcu6S0zkTXWIU92UBF/zE/Z4w=;
        b=SjMADF1tT0usbm7wnGnkIj1TQk1PFlrmf7UpAX6ZxPtSTvo+iSsa2MevZoaGPX661i
         cZsBtHzdEWDUeq92jJVJwUcevx8ZHtKQzk4TG+ussm5Tp3nKo6v5y5rTQosTsm+mU207
         /t0ytK70budYwCQ/m466hM3B7uGo5qExOJTROHS7Pws6qTXZJ05ZAQIsUUMo536SNoYv
         /MjAUTCCaLmTt3QL1Ezp40sUdQ2lFzOP08SKwJqpYx70jBWvNsrMRwAuYvXLyNo31GXG
         8baPzVay1CyBznmdn/IcbW+D78dYSoIZnIU+0uI9T3zYVtiJWHT/L/72dmXkSlUa/RRy
         CdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477313; x=1785082113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T7BUDbPgvu4uYiB0I4Tcu6S0zkTXWIU92UBF/zE/Z4w=;
        b=dtZlC/LIgVjvRZz1wtrvvk5R7ApgqZoTk1Pwrg1vus0mKf+k1oKc5SR3cA2rrmcyWb
         rFPdHLyy+6xke9BTdRL3lxjDay/7LkNi9bfgG2JkGfuFqq7yuP/GDtaWj3NV8H1Fmc3B
         jAZIAzceyadZmbTk56FpgsCi6pFMAXiBKv4iWFomsDm9WOj5UpOqcuzpK9BLjwIdNBqg
         6DA0Gj9+HnwDT6Bk9pykyj86T+veBtPVVObyVlfF9QIAIqcVRnOpFHEAMwAaXt9ID8dX
         zNdoE5qhtUl6xs75zaEVP3kMhsNWvP76Ob5PmQwA2fKbHlperfYRTXBcvVwhxXSkj20i
         U8Gg==
X-Forwarded-Encrypted: i=1; AHgh+RqX8Z2Bjtk4fKyzxW/UoLYqQsDKfQiWXmfm/Qh7jcx4Mj5R1NfXHnYR7yB83TAw+XjWosFwmwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNt0YnsoR50CsZ56CjYqhhKAhnVM2fD054lxM1I7+b105Q3bG3
	duMPdZSUzpy3DNtIXCRfcH8Xpc9gYjqZBq+dYE3YRatJYkytCaWyBjBp
X-Gm-Gg: AfdE7cnJWxlefe7kYquyc/m1cLr+hAXs/Me1K2txL9WA24LEzazTY2+f7SvXpTA6Yhq
	SGO2X/sTFkoztsdHlXtjDqr9PU5WCWnWGXrJwMmSgMWQntlzh3oQ3LRhcUOeMHQ20hGBDDVdJ0D
	uNBQAsIyW2+88hTDEBuIFgMTQzdE7CVhJQz754iDLyGccqnvH5Uu5wujekyC1p8WAbwIMbGeEbU
	AF0zCzMP8lo08ltqZzzGthQ4aoPvv/Ip6iLFoz9e73K5upH9lYuj7pMboejtjntL1ti/+yBse5/
	VsY/FTt3J65B3biAe8L1d+RFu+iiOiKZM3ud1uBroK/AbfXJNp4vfg8CmhaWpiwnZ6bXXcstOhg
	nX7bsePoZXQRCB4s6JTF1MrSimI+u22C4XWxGCZt5zoV2VZRoVZuZE07YgzokApEAe0FVup44ZD
	O95LK6VlW7/WDWiCNeVPjUOOW0bkp5TxLIgvmVDd8IUX+8RQPEv1uJKFQ9OeyoIKJlhUaVaxHYj
	OiJ50g3lLr1gLO8iY+O8h/M0wJQL0lGwqqTMpoX8bMbY61818VsgLkTk5V5FttZ+ihJ26WN2PtZ
	J9QcBNPA2g==
X-Received: by 2002:a05:600d:104:b0:495:4182:4442 with SMTP id 5b1f17b1804b1-4954a50c563mr76711935e9.22.1784477312656;
        Sun, 19 Jul 2026 09:08:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm223826745e9.12.2026.07.19.09.08.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 09:08:31 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] tty: don't oops in tty_unregister_device() when no cdev is registered
Date: Sun, 19 Jul 2026 18:08:11 +0200
Message-Id: <20260719160812.35407-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719160812.35407-1-kmehltretter@gmail.com>
References: <20260719160812.35407-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial_core_add_one_port() keeps a uart_port when tty device registration
fails so setserial can still use it. It marks the port UPF_DEAD and
returns success. Removing the port later reaches tty_unregister_device(),
which unconditionally passes driver->cdevs[index] to cdev_del().

The slot does not always contain a live cdev. A serdev registration error
other than -ENODEV returns before tty_register_device_attr(), leaving the
slot NULL. If cdev_add() fails, tty_cdev_add() drops the cdev reference
but leaves the slot pointing at freed memory. The later cdev_del() is
therefore a NULL dereference or use-after-free.

The NULL path was reproduced with failslab during UART bind on qemu's
mcimx6ul-evk and raspi1ap boards:

  Unhandled fault: page domain fault (0x01b) at 0x00000038
  PC is at cdev_del+0x14/0x34

Clear the slot after cdev_add() fails and only call cdev_del() when it is
non-NULL. This makes a non-NULL slot mean that a live cdev is registered.

Fixes: c1a752ba2d6b ("tty: don't leak cdev in tty_cdev_add()")
Fixes: 8cde11b2baa1 ("tty/serdev: add serdev registration interface")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/tty_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6b283fd03ff8..4889076b975f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3167,8 +3167,10 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
 	driver->cdevs[index]->ops = &tty_fops;
 	driver->cdevs[index]->owner = driver->owner;
 	err = cdev_add(driver->cdevs[index], dev, count);
-	if (err)
+	if (err) {
 		kobject_put(&driver->cdevs[index]->kobj);
+		driver->cdevs[index] = NULL;
+	}
 	return err;
 }
 
@@ -3305,7 +3307,7 @@ EXPORT_SYMBOL_GPL(tty_register_device_attr);
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	device_destroy(&tty_class, MKDEV(driver->major, driver->minor_start) + index);
-	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
+	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC) && driver->cdevs[index]) {
 		cdev_del(driver->cdevs[index]);
 		driver->cdevs[index] = NULL;
 	}
-- 
2.53.0
