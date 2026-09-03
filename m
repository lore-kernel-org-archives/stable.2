Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6882874E6
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418519; cv=none; b=PXarGB/RD6PktjXbvNngjJhJPQOmVSNCl10KaJGgnNs7tCiEpjP3yhpmBQeLSRcRCkv40RJp+cPL2nMBK0USVK6XTB2hO7d2ZzYGkwV2MSSOUPAaAYiUHv4swTDw6v28MTsKQVl4FvrVZtqq2xc6sWNzVtLwidC87Xuhs3XeWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418519; c=relaxed/simple;
	bh=oa6WB+umSgxVr987pD57pruTBL5thHf0LfnK+znBMTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Nz99JxQiMbM4snPTt8JNwXAWFMEvzhWvAA2U4aIkqTJChDeBY2ZfXwmRTOt2xKc8U8ObyIUIquH3/rwqNVJJxLn/slDHrHA7+wCGY2sbfPH0uecFTXYdkVxtoWwpD8kyOMLXMHT6PYUDtjUjBcTMT6QdQATRp9w6++4SDTfDPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SObh8OHf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SObh8OHf"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1770694a91.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788418517; x=1789023317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YHnCYdfWO8H72f9QyWQ298YfRVkI7e4oKnP551gsCfE=;
        b=SObh8OHfCE1Q7Iiz3Dgqv8ZyvacjfpYprZoavC4SQyfyfd/HyyVb0E0agvh48KrEMl
         4uKpl2O7hYaxjkhZXWS7stzBIPsUZVV0bc4T+RNl2KfPYef3DJp6G7GQcnmAMxPRs+Md
         iR7XpZ5YIlPjl/HZu8jMjKW61byfqn+mrVfEzO2jc2yk0F1+lH7yk9IOyfnhY2JDBsQH
         ppnn7AYlZfJesN9HJw4hZfRNbYajs/L+JEypxPP4JawFUkfNX5rEO7R/7aqkd7X7Xt1j
         cSCdXdclP4ocmB85CEKhVyDRVU/Vgm6O7/0qJTgb03Hem/aaoOr+cy/yEA/2wQjC9qvm
         O2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788418517; x=1789023317;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YHnCYdfWO8H72f9QyWQ298YfRVkI7e4oKnP551gsCfE=;
        b=AD4kqnoYRL0b1w8Tt9neED5NR7+qD9oWg4JDDlRQakwdSX87YJPk5Dc5GlwqxoHS50
         rcDPIjt4h9Hpgc6IGKxUnQTMnT+PyXaqNFX80Awxjxx2e6/N+62s0nW6XHWZaDrDy43u
         ZAsEy03DzhW1JHm5VXMt5SqlGZTOh3nLXnxbcsR//urFxpC/pvFO6l/+Oh2EV50bCGrc
         +5znCF+IaDNdv9u7XoBEUocou/QkIiYNZKhHXNdMMQTHB7WOg8UsawZy7hnM6W4V2EEm
         JPQ7j51WCw+1uCBWcOoPqBGjVofdR8H29sud65G83xLnYVhTLpUNprqLLqa56dsK9w1P
         QLmQ==
X-Gm-Message-State: AFuF++lmfPaWJRXg2PdWu7q27/Daw4kBEpTXHKtRc+BkFmHqhBYIWLqv
	kDuhGLvntooJAzizztYaxC9mO4t33oRim09lc0JPELrT/woSgE2EygC9MIgVdafm
X-Gm-Gg: AYBFou0Iz1leEQ1/+6/7eWqE6e72TWetoelzhl1enoDjsdsgSr3niKxXZiqJxFmSRHe
	255nLT1lncRINzLBBNgOv+Oe3kvWd9vY/iPLzRwa2LXjTnlRBizcdDrlD1s5Z8OwKcRM+hssOAt
	8yQ2QTzMi0QNjgTcd9zr1QQIBNsrzwshCbxG5Sw9cKovotE8zYZyZsYeghOrSW4W1Urs+pl9jEp
	sRv5msvpVh+QnDs0X+wX0T4MLIuT+X0tiPejadPINszIZzEeM7oaCQQBYWe6gZOLX+qjIVn0b41
	O3CpPVaSqQN+LieraBA5VxH9a3krFny8+EoxTJPz/JeYIp6Uo1gpH1UCVDnsfBV8ofxlZRlm1WT
	AHG9NvPW7fsXXoZl6cJaKpamXEb4qHd7f+A/JCpVMW5KV+V3skJilZKJeJtIxBIbhN0slYiIhnK
	qzQPYhiXVegx3oNXV8jNiIKyaZNll+CrSQDFLftrB6YAIpnU+PanLErbv5w4h9XYJ9y/cVvARi0
	4zCy3XQZV50/A==
X-Received: by 2002:a17:90b:280a:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-39aee085053mr15282922a91.16.1788418516860;
        Wed, 02 Sep 2026 23:55:16 -0700 (PDT)
Received: from ML-GYSUBT565.ECARX.COM.CN ([101.47.164.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b07ac1174sm3620165a91.0.2026.09.02.23.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 23:55:16 -0700 (PDT)
From: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
To: syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org,
	Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
Subject: [PATCH] usb: core: fix GPF on disconnect when interface claimed before registration
Date: Thu,  3 Sep 2026 14:55:13 +0800
Message-Id: <20260903065513.97561-1-khiemtranzo532001@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usb_driver_claim_interface() sets dev->driver unconditionally before
checking device_is_registered(dev).  When called from usb_audio_probe()
during configuration, the interface device has not been added to the
driver core yet (device_add() is called later in usb_set_configuration()).

As a result, knode_driver is never attached to the driver's klist, but
dev->driver is set.  On subsequent disconnect, bus_remove_device() calls
__device_release_driver(), which calls klist_remove(&dev->p->knode_driver)
unconditionally on the uninitialized node, causing a general protection
fault:

  BUG: kernel NULL pointer dereference
  RIP: klist_remove+0x...
  Call Trace:
   __device_release_driver
   bus_remove_device
   device_del
   usb_disable_device
   usb_disconnect

Fix this by deferring the assignment of dev->driver for interfaces that
are not yet registered.  Instead, record the claim via two new fields in
struct usb_interface: a claimed bitflag and a claimed_driver pointer.
After device_add() completes in usb_set_configuration(), call
device_bind_driver() explicitly for claimed interfaces.

device_bind_driver() skips ->probe() (which is exactly what usb_audio
needs — PCM and MIDI devices are created before bind), but it does
attach knode_driver to the driver's klist, making teardown safe.

The else-if branch in dd.c that handles dev->driver already set at
device_add() time (used by w1, usb_port, ccwgroup, pata_parport, and
others) is intentionally left untouched.

Reported-by: syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=87188222c77c0dbbdb4d
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
---
 drivers/usb/core/driver.c  | 19 ++++++++++++++-----
 drivers/usb/core/message.c | 15 +++++++++++++++
 include/linux/usb.h        |  2 ++
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index f63004417..59e74872b 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -562,7 +562,6 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 	if (!iface->authorized)
 		return -ENODEV;

-	dev->driver = &driver->driver;
 	usb_set_intfdata(iface, data);
 	iface->needs_binding = 0;

@@ -580,11 +579,19 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 	else
 		pm_runtime_set_active(dev);

-	/* if interface was already added, bind now; else let
-	 * the future device_add() bind it, bypassing probe()
-	 */
-	if (device_is_registered(dev))
+	if (device_is_registered(dev)) {
+		dev->driver = &driver->driver;
 		retval = device_bind_driver(dev);
+	} else {
+		/*
+		 * Interface not yet registered: record the claim without
+		 * setting dev->driver.  usb_set_configuration() will call
+		 * device_bind_driver() explicitly after device_add(), which
+		 * skips ->probe() and attaches knode_driver so teardown is safe.
+		 */
+		iface->claimed = 1;
+		iface->claimed_driver = driver;
+	}

 	if (retval) {
 		dev->driver = NULL;
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 75e2bfd74..73c630750 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2269,8 +2269,23 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		if (ret != 0) {
 			dev_err(&dev->dev, "device_add(%s) --> %d\n",
 				dev_name(&intf->dev), ret);
+			intf->claimed = 0;
+			intf->claimed_driver = NULL;
 			continue;
 		}
+		if (intf->claimed) {
+			intf->dev.driver = &intf->claimed_driver->driver;
+			ret = device_bind_driver(&intf->dev);
+			if (ret) {
+				dev_err(&dev->dev,
+					"device_bind_driver(%s) --> %d\n",
+					dev_name(&intf->dev), ret);
+				intf->dev.driver = NULL;
+				intf->condition = USB_INTERFACE_UNBOUND;
+			}
+			intf->claimed = 0;
+			intf->claimed_driver = NULL;
+		}
 		create_intf_ep_devs(intf);
 	}

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 1da4ad161..0ec743e76 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -266,6 +266,8 @@ struct usb_interface {
 	unsigned needs_binding:1;	/* needs delayed unbind/rebind */
 	unsigned resetting_device:1;	/* true: bandwidth alloc after reset */
 	unsigned authorized:1;		/* used for interface authorization */
+	unsigned claimed:1;		/* driver claimed before device_add() */
+	struct usb_driver *claimed_driver;	/* driver for deferred bind */
 	enum usb_wireless_status wireless_status;
 	struct work_struct wireless_status_work;
--
2.34.1
