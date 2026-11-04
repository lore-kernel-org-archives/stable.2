Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793770089;
	b=P8aMtdQCuIUz7+GzCWlu+IN98B62YIfxfiIIr8gtrOqrMc5ZDq6X0bAdfALOPAhpGT7P
	 o/kJ06fIQZh3PVFbTZa0L/KIqTcLTCcjmlcd29HUjQvdPFwEa/mPzqlfhfQZWUoSp0SfQ
	 Hz0XX0klFPjVErYkowm1LLn0ddXiGUzWo/rzeW+Zv3JU91NzqbwNa6XfRi0SonjVdMFcI
	 7jLeegDaN7Tzthmx52tu8jU+x9RUmYA6oeBqKcvAeRMjWCew9JxQAzLlwZ2mtKj6tt/zk
	 j20PZnNkr0x9x/MVYiFa2QmK/ePZ9gWAQGKRwgAOV8RcDvo4xu2StawnYiswvQLWe6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793770089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=irQAokomBOrEvq1E25b1/yaWaEKJedcNM9avak0rsxM=;
	b=ui263f0TNY42ZrQ9DrbNwmIaa+F2luqjtVxTJqYypou8arsnadTQzyRW84mBxNiroVdz
	 eq7YMLcqRXnO++sI/ojCjDgW2rbw64TrnjX1Lhxh5zILdSeGsb+TLn8Vf4DpLbRg4YkIY
	 Y2Ef49d9x8SInrDoSmlmvgjPohsIGY1dUlHEDewvV60f6yK5RnoXAwSQdgSUAFI7wPOq2
	 wDQbxQ7WFdk+Usjh/OlcuGtn/4a49gu8NSIgBhq+OWU8QG1bkfKsk5SQ3UL9JDpxBq5SZ
	 3IoALH93tyUgEufiaVaTB61Wl8KOVxDEDGIZa30PswbrJJi1v0pCnanTacRUzVLP8aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oAnu04eU;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E6606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 05:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C2E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oAnu04eU
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso140001f8f.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 21:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793770087; x=1794374887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=irQAokomBOrEvq1E25b1/yaWaEKJedcNM9avak0rsxM=;
        b=oAnu04eU+s3LGkUx1jwkqz7Twro5AjH5asleqtuon57Etq/k0ktcWSor0iWMB0/l3m
         fJ9E75NjnOf3htVo3Mixg2r95tpRcUZ5aPiupyVY7H+nuJbKLr3nB/AZ/LcopLRhFPTk
         l4/oooMuHStQY89DRz/4dC3LlbRlJPq9rY9ijo4IpoVZaKejlzAD6U7ZtMgLUYlakxe3
         JkFzpM+ndtOyjIsFDAWfOKQwsMqXL6lKHnRkqr/MeoRMW9UfqANYsTNdFdQBR2k7Ex6A
         VJ2jwbWIaT46VKs4uL6gotYb4fngQ1RtXzxNxYKkb97QymYrMszkXGOYcYCrIZdchKaN
         Wypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793770087; x=1794374887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=irQAokomBOrEvq1E25b1/yaWaEKJedcNM9avak0rsxM=;
        b=t101AYUbxIif+KtyVo6n3mturL3z/IyAz4nESx9Zy7aw3GnZa4tVk/F+VE7WcvVPL3
         ct8nu2vw+K6ejl+0oQtATxsGcjz92COEBdtbL4XtQjGMnb6Jxar0Swut4gWuYWb0wpah
         3zmQUbj5YSMfO2Hpzo2GUUF6GWPH3HB1BZ5ZiIDgugtgpdXM4CM9TLC2TBTJQVIV7wp0
         F472QzZAR/01Dee8OPasjI2y3X5o+x8QzU6jrm4woQ/UC//+LwQ8GuKgcBSA6pqfrL9Z
         ogDjgeaMQVy6cpoBLoi2EX5ly//PHYU7j4XH/yglVO4Kl/lclH64EXeTrIDKPg5y2ipE
         wImA==
X-Forwarded-Encrypted: i=1; AKwUvBwm16UNWOu31HJPcOwWlaenmHpOhep3yyTF9yV7GeIg+/3sBuf32qSFQKtSp9mYCz8cFBviIXI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6QDmfLAYlIKHInEzEYdRviYEwuDbE/dS7u1ZssZbbD05YyddJ
	CyNvTLc3tA/nd2QP0+vcoebzn+pX0igeI7HZZjTZ0JgzekReS6998zn5
X-Gm-Gg: AYBFou2rn5/I14qWvCt3oH6/YLBPJux9IJ7gg7GWi6YSEcNl6MPxefieKA6Lr5D1gDF
	ZqWmrCLYoZLVGdX1Pnt5DpEzJgOzMvzW/g5Pic+ZMYSmUzNvRpSVER5D57L/BDfKTIm1cwrbST5
	6hD8UXwLzkJ6j0ofud2cBiWYZkCQIX/ytq1E/TNIF5ctlL5Lb79M50oafgu2yBNROH19QD9ZXa5
	nAEKYyGmV/Na1e8LY94l5HtV870xPEH9FqbqLO6tBg161zoxNyZgBwkOOWwjKCyakp87XnBoZqr
	PqGyLOrDQAvbHod4tqe8bGo5WRx9ZkoAP63bmU4obYjTvjPemAi7m2DPiN3Lqe4IB3H17M+n2L9
	v1lHuvjgkHFryQSxOZ1w+FSOsNCORRSXPomPxy9hqu4VyNb0yIBYFJhTrXbSezmOGWlWvxs7wK9
	YUh5qsjs1bj2sF8GPc1cCOgeywb4TPVEDoMEnigpVwV1zoFXtMJhdM6VR/4Hyry8t0Hafit8jGv
	ObDdoKVCml/9WPk70QLuZUcPVew96PCW0vyKe5m5XfawKYeLf227Arb4qSsZhZct7aBxEbUcQxb
	Db3M3RDonRsWNe/vqvl0mYgaYRGKCh+DedI8AqrRbP00PD7wBFPT006fUZNZhfPKydYEV7XhQyY
	wnkd7zA==
X-Received: by 2002:a05:6000:4301:b0:48d:ff0d:cfa5 with SMTP id ffacd0b85a97d-48e6e50049emr34787634f8f.47.1793770087179;
        Tue, 03 Nov 2026 21:28:07 -0800 (PST)
Received: from recorder.play.pl ([2a02:a31a:a1b6:b080:1f0e:f037:ff95:4265])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed92a753sm1917062f8f.45.2026.11.03.21.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 21:28:06 -0800 (PST)
From: Greg Sikorski <sikorski.grzegorz@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	"Jiangong . Han" <jiangong.han@windriver.com>,
	linux-kernel@vger.kernel.org,
	Greg Sikorski <sikorski.grzegorz@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: em28xx: fix NULL pointer dereference on disconnect of dual-TS devices
Date: Wed,  4 Nov 2026 06:28:00 +0100
Message-ID: <20261104052800.44551-1-sikorski.grzegorz@gmail.com>
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

Commit 826915b6b65e ("media: em28xx: fix use-after-free of
dev_next->devlist on disconnect") made em28xx_close_extension() unlink
dev->dev_next->devlist from em28xx_devlist. On a regular dual-TS board
(e.g. Hauppauge WinTV-dualHD, 2040:8265) the secondary device is never
added to that list: em28xx_duplicate_dev() kmemdup()s the primary device
during probe, before request_modules() -> em28xx_init_extension() links
the primary one, so dev_next->devlist is { NULL, NULL }. With
CONFIG_LIST_HARDENED the inlined list_del() validity check dereferences
the NULL prev pointer and every disconnect oopses in usb_hub_wq with
em28xx_devlist_mutex held; the device never re-enumerates and the USB hub
thread stays stuck until reboot:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  Workqueue: usb_hub_wq hub_event
  RIP: 0010:em28xx_close_extension+0x80/0x130 [em28xx]
  Call Trace:
   em28xx_usb_disconnect.cold+0x87/0xed [em28xx]
   usb_unbind_interface+0x9b/0x2c0
   ...
   usb_disconnect+0xe7/0x300
   hub_port_connect+0x7f/0x930

Initialise the list head in em28xx_init_dev(), which runs for both
devices (for the secondary one after the kmemdup()), and unlink both
entries with list_del_init(). That is correct whether or not dev_next was
ever linked, so the use-after-free fixed by 826915b6b65e stays fixed.

Fixes: 826915b6b65e ("media: em28xx: fix use-after-free of dev_next->devlist on disconnect")
Cc: stable@vger.kernel.org

Signed-off-by: Greg Sikorski <sikorski.grzegorz@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-cards.c | 1 +
 drivers/media/usb/em28xx/em28xx-core.c  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 8440eafad..4d2ea2e27 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3845,6 +3845,7 @@ static int em28xx_init_dev(struct em28xx *dev, struct usb_device *udev,
 	const char *chip_name = NULL;
 
 	dev->intf = intf;
+	INIT_LIST_HEAD(&dev->devlist);
 	mutex_init(&dev->ctrl_urb_lock);
 	spin_lock_init(&dev->slock);
 
diff --git a/drivers/media/usb/em28xx/em28xx-core.c b/drivers/media/usb/em28xx/em28xx-core.c
index 62a1c25a2..ab1e1e18b 100644
--- a/drivers/media/usb/em28xx/em28xx-core.c
+++ b/drivers/media/usb/em28xx/em28xx-core.c
@@ -1263,8 +1263,8 @@ void em28xx_close_extension(struct em28xx *dev)
 		}
 	}
 	if (dev->dev_next)
-		list_del(&dev->dev_next->devlist);
-	list_del(&dev->devlist);
+		list_del_init(&dev->dev_next->devlist);
+	list_del_init(&dev->devlist);
 	mutex_unlock(&em28xx_devlist_mutex);
 }
 
-- 
2.53.0

