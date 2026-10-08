Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4662388E76
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475980; cv=none; b=oN59WN7/tN/eW8Yp8SCA0QlPJgo1bUl6DzGWT6T0aSsHAtsDFi9hJQHPLbfd/Y9Q8HTYi39XjzWeyXQnbsr8VBM5ESxSV7AhJ0jpSL3Ew22voOUSlBEL1YdduexwhIxuCwNEbYMMifixRNw/ZsoRsMl+no3SQ0MGULIO3otA1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475980; c=relaxed/simple;
	bh=BmN0rljmONbdz/PXm/OprH8FzTn9S1DwuWMcx7k7+c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNoHdjbfKJvGeWvPnMY8ttWryK6ZK3aLvmYTc8p9bR8TavlRJhDYULxVkYr9ptssj6aSFrqCe3QMGeXwYeRnc9V1xff6s9/hi/f5vj1/WHUOzrgkSlXgIcxhA6eJNRfRA3Zvo56VPkEP4cOJ5KddZ8hPoZE5DmhVISICsWz5yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qhp5Y83x; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qhp5Y83x"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so2335295a91.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791475979; x=1792080779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDdHvibVLCCzB2QsTRiQrrzTd39n/2ojg5xJ6kjQ3YM=;
        b=Qhp5Y83xrBNwJSC0bf1AnH29alk4CYhB9uumjrwHD16jkBJVcKapwHnnlkKa2L3sTc
         AtydfL3JoBdzo4RSRBbtzHz8Zfb8tbzDG2UPnRCk7aD3Nc2Wq1Pmh6SCm3hnXAFkT8M1
         50ArTK03WHNqCsG5PpMJ9gGg1px+8hNglmDgZDwEYRSgILHLZSB/elnkqzCz3SjNcpFB
         qitiICIXD4Ry+yV+300BUcWj45036SBo3Bju+wYO6U4dVt2YOOewQPrPpAICiD3pJxjR
         UTEZV3xtvCC6ZtgrnFIwuMBgb+FHjDaP/ooAPe1TNCJReD4Iz4ookmcvaD6TwpRUnFJu
         nYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791475979; x=1792080779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hDdHvibVLCCzB2QsTRiQrrzTd39n/2ojg5xJ6kjQ3YM=;
        b=UzuZAUAkHzKpPjNdbjR6q+EZ9OUlOkIs7kez19M4oHbMmGo0Wl8jjWwD6Qi8/0cjNk
         fRyLKU8lamAWtMi+N/Vl6oS8m9qDRKWEbkv7DCDN7tzBq/xEuDEUrBw6b+40Dy3EVRJK
         i3I0hmXVu+29X0z6im8IxF1UzTzNW82UMCpRg8DcWUDdrus02naLp4D1tN+oGM0ml6JH
         GUtj/hX+ybnKN69tfE67HZUMmeTOadvxa+2/FMzsiMpWm2ZKDm2TP3fTN6MZL3kRt4lB
         LFPyJJNzQONoryvUOpcXh3ujiXYIhnacM1IzSnVfDKQQu+HPbV56U4178/Zwmcuopm6z
         sOqA==
X-Forwarded-Encrypted: i=1; AKwUvBwigsikzGWYPlJz7tIHMt+u6H9ngwxlJTM3xQQ5bRol/x4URdlYAMa1L/aWATS3RA1NSj5IMzQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxZwsBtHHmt21NRUdD7GV4jpPpVIgEDf/9TTxUqsj7p81EQVrr
	bMUQNu73EdKbRlbv5bKVfNjYq1+xOmA6CznN+4rZrCLxis3NBInuuS9e
X-Gm-Gg: AYBFou0OZrT/Rm1wCDQqTiPJpyHnxVysgvHYAbYXnTfV6EhakTj+FWCzREYWR1qd4qx
	Szu6ZK06y+ykobYya7pbAJTQVw3E/4EN5enPVwRlWfkQ4VDe4j0w7yeewolzKouxY+lEwXUtB1i
	pdFnYmxJ2KOrwLr0/JRBHQXRag/rAG3NQnFcB0pJn+XUlpYrhLe5B0DCD/KdTYLgb63U4iWxw1V
	QMEcDJBJUHcf8ztrT+V7+2L5HmXiqdDcfEjmbO3k9+p/0AjjAkmO/P5cQVLCMNguhOLqf1MNBar
	rFKee79lXTQVp0dF/0CY75GejqMwA3gt4M63NZRnxdUJ4KZit+zfGxRwo1u6Zu2j6SwnNZoNxi3
	NKhth6wgHNVrl/+NyhbqT8+clvtt/6tlaXLUNxdBogshSSB84NzxWsc9w2dEHffDTcD8wiyHCPa
	uzXPkTkyYsqKZT8Yi09cskviKPeO2oyqSh5RLL++U0hVJOtHP+yPTMS1iiBAqTxFGTLJ1M44ke
X-Received: by 2002:a17:90b:5848:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-3a89f687798mr4750893a91.5.1791475978758;
        Thu, 08 Oct 2026 09:12:58 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45b:16d2::246:b6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1a7e9e4sm4834011a91.7.2026.10.08.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:12:58 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+863936f50214e843ae0c@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v3] driver core: bind a device with a preset driver even without autoprobe
Date: Thu,  8 Oct 2026 23:12:53 +0700
Message-ID: <20261008161253.138698-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008144859.25548-1-ngocthang2710.1999@gmail.com>
References: <20261008144859.25548-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_driver_claim_interface() may claim an interface that is not yet
registered, in which case it only sets dev->driver and relies on the
later device_add() to bind it via __device_attach().  With the bus
drivers_autoprobe disabled, device_initial_probe() skips the attach, so
the device is registered with dev->driver set but never added to the
driver's klist.

Releasing such a device (from usb_driver_release_interface() or from
sysfs unbind) makes __device_release_driver() call klist_remove() on an
unattached node and dereference a NULL klist:

  KASAN: null-ptr-deref in range [0x58-0x5f]
  RIP: klist_put+0x4d/0x1d0
   klist_remove+0x14c/0x2e0
   device_release_driver_internal+0x4fb/0x620
   usb_driver_release_interface+0x10e/0x190
   cdc_ncm_unbind+0x2ac/0x350
   usbnet_disconnect+0x1e2/0x300
   usb_unbind_interface+0x1dd/0x9e0

Autoprobe only governs matching drivers to devices; a device that
already has a driver needs no matching, just the bind that was promised
at claim time.  Do that bind under the device lock when autoprobe is
off, so that a concurrently cleared dev->driver cannot fall through to
probing every driver on the bus.

Reported-by: syzbot+863936f50214e843ae0c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=863936f50214e843ae0c
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v3: Sashiko noted that the lockless dev->driver check in v2 could race
with dev->driver being cleared, letting __device_attach() probe every
driver despite autoprobe being off.  Do the preset bind in a helper that
checks dev->driver under the device lock.
v2: fix the unbound state itself rather than usb_driver_release_interface()
(a sysfs unbind would still hit it).

Tested with the syzbot C reproducer in QEMU (KASAN, dummy_hcd).  The
race that leaves the interface unbound is rare, so to make it
deterministic I temporarily made device_initial_probe() behave as if
autoprobe were off whenever dev->driver is set: the unpatched logic
oopses 3/3, with this patch 0/4 (64 USB connects each).  The plain
patched kernel shows no oops either.

 drivers/base/dd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 137bf1dea333..bb1e76bf6122 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1142,6 +1142,16 @@ int device_attach(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_attach);
 
+/* Bind a device whose driver was set before device_add(), no matching. */
+static void device_bind_preset(struct device *dev)
+{
+	device_lock(dev);
+	if (!dev->p->dead && dev->driver && !device_is_bound(dev) &&
+	    device_bind_driver(dev))
+		device_set_driver(dev, NULL);
+	device_unlock(dev);
+}
+
 void device_initial_probe(struct device *dev)
 {
 	struct subsys_private *sp = bus_to_subsys(dev->bus);
@@ -1149,9 +1159,10 @@ void device_initial_probe(struct device *dev)
 	if (!sp)
 		return;
 
-	/* a device with a preset driver must still be bound */
-	if (sp->drivers_autoprobe || dev->driver)
+	if (sp->drivers_autoprobe)
 		__device_attach(dev, true);
+	else
+		device_bind_preset(dev);
 
 	subsys_put(sp);
 }
-- 
2.43.0

