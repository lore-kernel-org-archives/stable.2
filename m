Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B493530E15
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875422; cv=none; b=QVGgAiJHCIiIj1yELim2h4vZCCXk2vmuvi3iysVefwafEnIg2r44o4D7rGwoEPy0RGcxQt8En3Wz5n9Br8kOPZ+jbadizGgPnrxPPfgwZscXdejvuOAfdshHnAXkXDwVGNRiuauTctin82MP63jJTEFPChPkbPcQ24CHnr2DGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875422; c=relaxed/simple;
	bh=ar+43dOz2VmIYxEzbU/l1wzEmSyVzI2Ez00niz1s1oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUjdJSawDZ+g+W2qV4/Y7MLSwLDBSJkHT8lhph4WDloPbESQJKygIW8rzLyRP+SPfbVWPDoEXAJZk+xoClugT2zY85JqODZ8QFYed21py3Mcpy3PCCChCr4ZpBZgWFcU1amxweohjl4QfAqp1qTypt4hi89JnNumY8/8+1TRcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY6rLeTc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY6rLeTc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so38044345e9.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 06:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875399; x=1789480199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwxOcnlvcy9U0HQiJwkZMzbvB1txUIVhCVffQoriU+0=;
        b=BY6rLeTcGX80rOeajVwyXLN41Xcnj81oMvb07r1CEN0QEnEYwATqX0MbTe7zL2He2k
         2niDN40DprTmDlPtcrOk+mVu14M/RTb9jiY6JMR08b2xqIrFqyjmvHFoTwNMA2HEcWsE
         CBHKTFz+n2bJS/EExgqTJYNQ+JcUKuW+COCupeU3CWOvLjDxMHR5C3cAKV4TxjAzJjIR
         udra7JtfL4l+d46U09DxwFYzg/y+uYnS3JUIBVVxgjP+dap1dA0YNn8waUZFuwyI3uLS
         tMRU+98AHGtubjM9sqySAw17VQn+kKrOhqpGAJ2EFdVEktHCBf5GnLT/ia2soq++dx65
         Dkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875399; x=1789480199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwxOcnlvcy9U0HQiJwkZMzbvB1txUIVhCVffQoriU+0=;
        b=qpAtcttZ09TJOWlQZvg2j06TA5+78Gr54u/rmv8gv5zF7yZgUcoXG5FQVx6GTpGRj9
         YHPe9WESmyhYRJTtSsLmR4cwepfjXDS5SYAMANQe5/SuVzapkjg3A8Pe0tX8Fg1Y+iS0
         +NGOmP2O7Ut2H6U8L7u77c9pHw/skpjgkhAb31fz/qMBZiGgHTXpeMOpsUvqAEABoWFV
         cssRoN6nxSZwYLmj10Z0ugpY4kP6vxCwA8HyED0mj1PVwRVNx1qQqLuYANcG6/9VNN2w
         TQ6+GVIkuANd8skNrBnnzRhwplJyNoBJAfJDkpI4R0ksCgiYGQp7HNr0SdurnDzKDrjC
         zGYw==
X-Forwarded-Encrypted: i=1; AKwUvBxpmGjy0hULGv4Lxt2ujtokJMTSnYwcLwc3iVz0y9AfLVgPmFu56s8lTI5aRhPjDoiGIj05JOU=@vger.kernel.org
X-Gm-Message-State: AFuF++l9RmXSFEBnytdyxpV6jOra6o+8IiyG3N/e+peVE6IxoNWZjv04
	fq2V+s9LElEnut1Xltgs3nsEHSxrNhcAzV95TIGrh/KAJzHHu3L8VoTJ
X-Gm-Gg: AYBFou0bPCtS8Xmy+tpgd/AF90qmef5y3QOD2Y6jBlcHzwvIYHY9ouj+b5swVA6Khrt
	/BVDE2cDEnjsmb+HL0hOVDQeu9eg2wrA5ctMQ6yFUQI3v4JkcP4cSraV4iXbW6XuIpiykXbFz6R
	7Bw8q83UgB2vB5TNg/x5eSNTHmErvZbSufJR6siKn/Nk+dDmBvhCDQmIYjVBVHNFETVW5dZ9nkN
	qQ9iTpuZBpu0Ekh/t8hQWbR6zdiD8v1woLMT/w8Uu5IajJnv2GFo+ukntb1R6QzeYs5aiiYNGTZ
	gQpyJo8MsuBaRm87xlfvIKNJm1Aglrock2YwlbpWKXTAppIO/fOVHM2PUCNBw38/Q/Meic47z5g
	tncCg+LT5j1JmDkXNQB3X1X+9PTucCxn1O7HoeVotFfQS76gYuN5SIeVjEmLOFCKeRlk0u3cBqq
	4Iwg+/FqKkjPTioltRw8qBxntrzGB+vCqeZ5Xh/Rpc1pGcApoOKC129oKCps648xHjwXY5ECP83
	Y52+4kBguSL88NiOO0/a6XsA979Cs0W
X-Received: by 2002:a7b:cc91:0:b0:49c:ff9f:f6b6 with SMTP id 5b1f17b1804b1-49cffa00196mr188444915e9.6.1788875399076;
        Tue, 08 Sep 2026 06:49:59 -0700 (PDT)
Received: from LS-Tayyab-Farooq.dreambig.corp ([125.209.88.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7736132sm389144795e9.12.2026.09.08.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:49:58 -0700 (PDT)
From: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nobuo Iwata <nobuo.iwata@fujixerox.co.jp>,
	linux-usb@vger.kernel.org (open list:USB OVER IP DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>,
	syzbot+31117fde582fe6a0cd62@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usbip: fix use-after-free in usbip_stop_eh()
Date: Tue,  8 Sep 2026 18:49:02 +0500
Message-ID: <20260908134914.3169-1-syedtayyabfarooq08@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During device teardown (e.g. when unbinding a device), vhci_stop()
calls usbip_stop_eh() to wait for the event_handler workqueue to
finish processing shutdown events. usbip_stop_eh() uses
wait_event_interruptible(), so if the user-space process triggering
the teardown receives a signal, the wait is aborted immediately.

Since the return value is ignored, the teardown path proceeds to
free the vhci_hcd (and the embedded usbip_device) while the
event_handler is still actively using it, resulting in a
use-after-free:

  BUG: KASAN: slab-use-after-free in vhci_shutdown_connection

Fix this by switching to the uninterruptible wait_event(), so the
wait cannot be short-circuited by a signal and always completes
after the event handler has finished processing pending events for
this device.

Reported-by: syzbot+31117fde582fe6a0cd62@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=31117fde582fe6a0cd62
Fixes: bb7871ad99ea ("usbip: event handler as one thread")
Cc: stable@vger.kernel.org
Signed-off-by: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
---
 drivers/usb/usbip/usbip_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/usbip_event.c b/drivers/usb/usbip/usbip_event.c
index 0e00c2d000f8..81d761891184 100644
--- a/drivers/usb/usbip/usbip_event.c
+++ b/drivers/usb/usbip/usbip_event.c
@@ -115,7 +115,7 @@ void usbip_stop_eh(struct usbip_device *ud)
 	if (pending)
 		usbip_dbg_eh("usbip_eh waiting completion %lx\n", pending);
 
-	wait_event_interruptible(ud->eh_waitq, !(ud->event & ~USBIP_EH_BYE));
+	wait_event(ud->eh_waitq, !(ud->event & ~USBIP_EH_BYE));
 	usbip_dbg_eh("usbip_eh has stopped\n");
 }
 EXPORT_SYMBOL_GPL(usbip_stop_eh);
-- 
2.43.0

