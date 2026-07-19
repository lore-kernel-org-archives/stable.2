Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D303AC0F0
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477313; cv=none; b=a/vKtWBd41BdEN5NguhbFGhaBuMiIwfw+25OEsrN3+TTDSvU0L32tmMaoiTVtqyCIYXD/65JSgYuF3Ml8hT9/IDgNvo/Z/EwEceh09QaI9KGTiK6qarcJOTie3C2m8AKNkGev2GL5zxqp9fkvJCvjAstkAQLkZ0HUpO38M78TaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477313; c=relaxed/simple;
	bh=dUEaJRxUr1v76K2SCkn5RSwlmWHDmcrArC8H6gE7+XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4EDYUtLRslHQEvqcZ21Qq+vLeSfBEk6XYLSxIq0pF36Ovkr3nzs4Sr1Gd/MS5DtSf4p2IlgIf3uvmQAY+7OomZ+f+1V3qA/PQ83oOCxc/gIA4NhQb4m799sDCutwoqvV0C8gcjA6wLUkwhtRON7JlP4CpuHqKO89p44qLNtsvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaUKXbaD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaUKXbaD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49553515a8bso10583325e9.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477310; x=1785082110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2WnfrXCKBHilw+RfhMqIc4Ta8+VRnPx7kVZTMW2Ow4=;
        b=FaUKXbaD2xS8CpVouYiuQBwUs4dxWJL7p8xKThYj0pqrUjEuBuDwC84z11byA5zT+/
         5eyibtyJSquCWcq6vhuLARojMPINnlobb7xZeWIs/tmb8m/+kmmrzvb3tVQdXQn+c4d1
         WNYCSNGKsZkezmtQYc17DQLAd1Kv2bJN0by6JZnRBWc+p+VnakJeTY4GSQgOzVdh5iGe
         lY1XfI01OY7hdtFm3sV8I32IHRJN/3MJlkNSKVehIlcbpQEs9G1gTVOdKcdFAsYli89J
         KJUZyT2XH1fFdlgOBX/31hZebv4rbhYHSqollW6WoyHAYYtaivfgCNBluoSxJIAC0M9r
         UdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477310; x=1785082110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2WnfrXCKBHilw+RfhMqIc4Ta8+VRnPx7kVZTMW2Ow4=;
        b=bCzxTwWfVFQX5fBIinGhWfN2GnYGZCfZZPDtz2tJCjXyxTCp+7Z7BT86d5tRs6EJl3
         ReVYTvHGTYDuwtsttLIjaBjAPv6WpirR/0gabXsYHoa6Ob24rwGmoQKawy9m0juM2tWM
         iEQ/MPIs3/Bc0GdqvoX/6Xy3eJFPZew5eZg9FXX6n/3rqUcrI+7XiROXDmpoaU/IefUJ
         uzpnztbOQ8Ojdn28QGYTxcL3zXtcI8BSyfQEr3Sn2wSO9T6b3hqm27MWG7tT1ssCY6hB
         53aJ2mBkSAl7AIFO5cTsA73rwt9DZXJucuU3hEPV24NuT82Kzp5Nq1hdGJCmFvFlThov
         Fb8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpvwzLAVK7F5rb1LvKP/xlZ07dfzyXZ6IhaAEF476XoaPHHVkkpDqAYDc38EEt8BP08acwbJIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhExcb9zZQ5rZZYaZJCOIodsz87HqO226QPU1I0AnrdFouWpcs
	lxEqwJ338CzzhPZIFT0FNbSb8pMEDqr9O/x0r7as0fXRSSdWcUfctww01zGD1B1+
X-Gm-Gg: AfdE7cnAsa5TkTuzZMyxhT96O/7e2oK7/QLVcloyjM2IJ92o5HssZ2LCHrGQidEw0Ji
	2ZJBrhGpGWNywqSmN9jxrdOZ2zFrfQpR+RTc+h8S/py/3DMnoLqJVW8+VkjnTILuUZZWDPORSj1
	Py9UxIupQICV0beA4swOvmem7TtGkpPNCDYn+NhGKRDPMUEJ2i6wO3zj1SG+Yc6jISMBDXlN0hq
	pgytAcXEfqYdQxvLfyuU0xmZEsw53JBHqQRbjQXbAGEvUGYxp6k+wp2H8fhWzpSzFtDlaoVy94e
	fbM8nM677APY2urCs/mNfbtQrPbMzyLF5907NqSAt9OwA/paf8wmR/TIX1mNxtcxP9kxtsNygip
	UfLEk6/g5hrieLpN0OG+4si+/eXrnBR66gE3Qg/EQ9XXbasZlb9LkQgO81ygK7HeEcx+OtdSjBV
	nLgKUGo64bn6yQhyVSsa2KbjO5gFhld3knZ5OqYs29063E4hU00GLi/mTh9NptfpcePl1qjj44O
	2/1QD0Dih7DUY8cD0zlodDwfK6PNWWRvV5ONpWhNmF53Mb4w1E7YUl45Fb/c8FadhZqbKx5inoR
	4Jx2XInl3A==
X-Received: by 2002:a05:600c:4685:b0:495:4a77:1327 with SMTP id 5b1f17b1804b1-4954a771521mr125054115e9.33.1784477309565;
        Sun, 19 Jul 2026 09:08:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm223826745e9.12.2026.07.19.09.08.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 09:08:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] serial: core: clear freed pointers on uart_register_driver() failure
Date: Sun, 19 Jul 2026 18:08:10 +0200
Message-Id: <20260719160812.35407-3-kmehltretter@gmail.com>
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

uart_register_driver() leaves freed pointers behind on failure. If
tty_alloc_driver() fails, it frees drv->state without clearing it. If
tty_register_driver() fails, it also drops the tty driver reference
without clearing drv->tty_driver.

Several drivers register the uart_driver lazily and use drv->state as
an "already registered" sentinel. After a failed registration, the
next probe sees the stale pointer, skips re-registration and calls
uart_add_one_port() with freed state.

The resulting unwind can call uart_unregister_driver() with a NULL or
dangling drv->tty_driver and oops in tty_unregister_driver():

  Unhandled fault: page domain fault (0x01b) at 0x00000018
  PC is at tty_unregister_driver+0x10/0x68
  LR is at uart_unregister_driver+0x1c/0x60

Reproduced with failslab fail-nth injection on qemu's raspi1ap board:
fail the tty_alloc_driver() allocation during a sysfs bind of the
PL011 port, then bind again in the same boot.

Clear drv->state after freeing the state array and clear
drv->tty_driver after dropping the tty driver reference, as
uart_unregister_driver() already does.

The tty_register_driver() failure case predates Git history. The
tty_alloc_driver() failure case was introduced by commit 9e845abfc8a8
("serial: fix NULL pointer dereference"), which made that error path
return cleanly instead of crashing in put_tty_driver(NULL).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 9e845abfc8a8 ("serial: fix NULL pointer dereference")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 887b1dd80ad2..ba9145c5a38a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2777,8 +2777,10 @@ int uart_register_driver(struct uart_driver *drv)
 	for (i = 0; i < drv->nr; i++)
 		tty_port_destroy(&drv->state[i].port);
 	tty_driver_kref_put(normal);
+	drv->tty_driver = NULL;
 out_kfree:
 	kfree(drv->state);
+	drv->state = NULL;
 out:
 	return retval;
 }
-- 
2.53.0
