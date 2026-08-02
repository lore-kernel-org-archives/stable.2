Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12733A3821
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672369; cv=none; b=Dkh8fE2b0qExbW/eg+1V9zjGiBbp7hIvNN1WNv1Ky/l5s4g+yXJutEsPuU/5M+Oc1/WVlPEnMU48g53fPRo2bEPP0Y0wGYID9W2kCFjoEtErwfVKWvX7Ghxmabv2z2Z5u9l0yna5gAwrI064WX3XyKIGfYmuqA7CGGxBikXIUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672369; c=relaxed/simple;
	bh=ja9SEZY37py2LPC3UCzbojlbnwIXzxtJJQ0uGcIg/sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPKN7cGp1Qov6F8zzAyVophYKIG7FWd6sqtX5YFPh7oxkagsWewYH8qJ1p6q744dR8XC7Li8U/aMWL1qAKx1mry86Us4ylr0G5S7GDYcEOsdJQaHOEs6+X2+r9l4vVm9L5uX+fqoZpGFEpYPCb3h0rWIaHHxY+lXlxk15kLgC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=dgpKf/1V; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="dgpKf/1V"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso3930515e9.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785672366; x=1786277166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YmI7MBDeloKectxU/BNiRN1jB4jCnA25xpecmEwYe0k=;
        b=dgpKf/1VX/V/XUhdm6FM3HK3/hMzv9nsCRIOy6R61ouRFAXv02jm+AyOcOJu87XgPd
         RpEixcxwjNs1eXFeMGUrHULio5bx7oNjwj0Vv8ut8kRDoDusqtrl7DTE3sbMNEKGzl6s
         T6d9CBEcGP2HoR/8Ov66/12Uu0hrIKHKDRmZEBPLng4QSi4Hr5CeXgK4kIzHOl9Vjm6P
         odcqZsrzPB6DzUWg2y+GN44ChXwp8eU5gXndFY7tZ/AI1PiaM9c+u+L+b2KlSJHoU7Va
         bXKpvLiovV5TWbh0E/YyvyzVXKDuOV/JquH/2ijGvuYDeMq8wRuWYjbCNmccWh5kyBla
         Ev9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785672366; x=1786277166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmI7MBDeloKectxU/BNiRN1jB4jCnA25xpecmEwYe0k=;
        b=Gsbmt67expIvb2nYEkMBrh5ZdmFCC+GnKyRjr9Ezql9A0KlUB9ADiiM4wWW8FFa/hN
         JeKprXtClJUlof9suhAxNu0qStg/3oLgYjl6TTkO5Q/W9hS9KUizGuFXzN1MjWBsr67i
         yKP2j2Jy1J/OJQP7AQaoM534pV5tgNw8tYuYyeWchOdiez7h0Yn+DVaJ2x39wLy+/9cJ
         Ww9jgbsy8jEk+4JbfXWWBU1KOOFwanJqFf19XZqIEdr+30vCV5+QLE1SY2ITkjg++qOv
         PCb/13AC8W+XchMHTUkZ9rXcSe78HZXA26/QwHrMmlylS4sgXo17KRwVOHp6vLIr3VSj
         +fjQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvK1HTENObIBHW98KFSy2zcTqlHX01/KKKnMYmbLtAYQgPNB8/KI80KqwUj5Yti561nnc65m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0VK8aFdXH2GTb71hMlWKthZCkhdiviF7ZLptrE0n4DZ8q3Dl
	A7ch25RduwydS3SRLTmh7EkTf+f/cz8dvcUyqY7Wbzc6beBTZjIoGiUCaYZZ1wzkiIra
X-Gm-Gg: AR+sD12pzZM7F23hvwa1YrG4zfqFShJ0Yr3vYKTz/QoB+FVWiRY8VNW2CsJ0MybEQMl
	WYL+RPdNvnojaUfU7W4OAg3OObnLSKtDim7Pxl5fp6yawy5ufJF5GnIjyk0GUqJ2hpYICclQRMv
	nwn778MmsfC+RFCDGnvBG9hcvJRaWSV8+ubRShd3k1t11ZbNPnEU3/5rOyX12a7qWD85VJ/CEtW
	4J5ygJfM1HPJOyuYng+xX78p4czfPJJqJSifG+cQAlH/H2sI8g2U8jJIhuFle78GQ92bVg9C+ph
	5vxqE9zDsIKVxITVAevpIRLCl3LvT1v7a+2iXuyZ9BwGbbmKtuOcZb+wWBilIZCnAMeL/BI65uP
	QRPjw8OvJtm5B7q3mG6HJmdJ/pRKfdq8dct9QX4GwgyyKvEN7LNxMqyVKrEP5Un7L6lJqqu0aBO
	HZ6ohzH8NWT+H9acwLLNtbMHFi099rHWBU7kRN0Ir5CrVqrFoUqbBMle5jEHFU9QvsWCI+qHGIc
	yr0EdFzfu+TPv8u4jNrWbmHyNGSO6eKSa5jqNReox3GO0bDg8eXXBdQ6gE2VMsO9QLomr/bL75f
	s/5wU/+HFNjCUIKJfQ==
X-Received: by 2002:a05:600c:1f8f:b0:493:f478:4c71 with SMTP id 5b1f17b1804b1-4980eba0817mr106984535e9.7.1785672365325;
        Sun, 02 Aug 2026 05:06:05 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm175226825e9.3.2026.08.02.05.06.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 05:06:04 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: agk@godking.net,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: usb: ipheth: fix carrier_work UAF on disconnect
Date: Sun,  2 Aug 2026 14:06:02 +0200
Message-ID: <20260802120602.42595-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipheth_sndbulk_callback() re-arms the carrier-check work on any
non-zero URB status:

	else
		schedule_delayed_work(&dev->carrier_work, 0);

Nothing ties that to the interface being up, so the work can be armed
again after ipheth_close() has already drained it, and stay armed
until the netdev whose private area embeds it is freed.

On unplug with a TX URB in flight, ipheth_disconnect() drains the work
through unregister_netdev() -> ipheth_close() ->
cancel_delayed_work_sync() and only then calls ipheth_kill_urbs().
usb_kill_urb() completes the in-flight TX URB with -ENOENT, so
ipheth_sndbulk_callback() runs after the drain and re-arms
carrier_work.

The same completion also re-arms the work if the interface is only
brought down while a TX URB is in flight, and
ipheth_carrier_check_work() then keeps re-queueing itself once a
second. unregister_netdev() does not call ipheth_close() for an
already-down interface, so nothing drains it on the later unplug
either.

In both cases free_netdev() frees the netdev while carrier_work is
still pending, and ipheth_carrier_check_work() dereferences freed
memory.

Tie the work to the interface state instead of chasing the completion:
disable it in ipheth_close() and enable it in ipheth_open(), so a
schedule_delayed_work() from the URB completion is a no-op whenever
the interface is not up. disable_delayed_work_sync() also waits for a
running instance, so it fully replaces the cancel_delayed_work_sync()
it takes the place of. The work starts out disabled in ipheth_probe()
so the enable/disable counts balance from the first open.

Reproduced under KASAN on linux-next (next-20260731) with dummy_hcd and
raw-gadget standing in for the device, driving the second path above (the
interface is already down, so unregister_netdev() does not call
ipheth_close()): 15 of 15 unpatched boots report a slab-use-after-free in
__run_timers(), freed by ipheth_disconnect() and re-armed from
ipheth_sndbulk_callback() via queue_delayed_work_on(). The
same trigger on a kernel differing only by this patch reports 0 of 15,
and the carrier check still functions across open/close cycles.

The reproducer needs an attached USB device that stops draining bulk OUT,
plus a link down and unplug, driven as root. It is not a privilege
boundary crossing and no exploit primitive was developed.

Found by 0sec (https://0sec.ai).

Fixes: bb1b40c7cb86 ("usbnet: ipheth: prevent TX queue timeouts when device not ready")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
 - Fix this at the scheduling site as Jakub suggested, instead of
   adding a second cancel_delayed_work_sync() to ipheth_disconnect().
 - Took the disable/enable option rather than a netif_running() test.
   The test would sit in ipheth_sndbulk_callback(), which can observe
   __LINK_STATE_START still set and then queue the work after the
   cancel_delayed_work_sync() in ipheth_close() has already returned.
   Disabling the work closes that window.
 - Now runtime-reproduced: 15/15 unpatched boots splat under KASAN,
   0/15 with this patch (x86_64, W=1, no new warnings). v1 and the
   earlier v2 draft said compile-tested only; that is no longer true.
   KASAN was confirmed live on both kernels via KUNIT before trusting
   the negative, and the two kernels differ only by this patch.
 - v1: https://lore.kernel.org/netdev/20260724134250.34360-1-doruk@0sec.ai/

Note for stable: disable_delayed_work_sync() and enable_delayed_work()
first appeared in v6.10 (86898fa6b8cd "workqueue: Implement disable/enable
for (delayed) work items"), so 6.6 and older trees need a different
backport.

 drivers/net/usb/ipheth.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index bb1364f85bd1f..2b490114d2327 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -490,6 +490,7 @@ static int ipheth_open(struct net_device *net)
 	if (retval)
 		return retval;
 
+	enable_delayed_work(&dev->carrier_work);
 	schedule_delayed_work(&dev->carrier_work, IPHETH_CARRIER_CHECK_TIMEOUT);
 	return retval;
 }
@@ -499,7 +500,11 @@ static int ipheth_close(struct net_device *net)
 	struct ipheth_device *dev = netdev_priv(net);
 
 	netif_stop_queue(net);
-	cancel_delayed_work_sync(&dev->carrier_work);
+	/* A TX URB can still complete with an error after this point and
+	 * try to re-arm the carrier work. Disable it instead of cancelling
+	 * it, so that such a schedule_delayed_work() is a no-op.
+	 */
+	disable_delayed_work_sync(&dev->carrier_work);
 	return 0;
 }
 
@@ -629,6 +634,10 @@ static int ipheth_probe(struct usb_interface *intf,
 	}
 
 	INIT_DELAYED_WORK(&dev->carrier_work, ipheth_carrier_check_work);
+	/* Armed only between ipheth_open() and ipheth_close(). Start out
+	 * disabled so the enable/disable counts balance from the first open.
+	 */
+	disable_delayed_work(&dev->carrier_work);
 
 	retval = ipheth_alloc_urbs(dev);
 	if (retval) {
-- 
2.43.0

