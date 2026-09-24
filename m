Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A54CE673;
	Thu, 24 Sep 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282367; cv=none; b=iLKJStC44exuAM0MBnCiCeeqb+BasIB2gJRB42o/97BjmEx9m8uJwQ35666bH7mK9CdhxpkB4Spip6o6KSfZqvLhcbu/ecBW+ZghYLIftxoDfKGmPYwoRlqrwqS12hnt3paMvkeRwQpE8kK3yv2DD+fpL9NBnnz40NsJHX9+J30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282367; c=relaxed/simple;
	bh=3jVrqWHVmL2RraT3Mi3b21L1yYxL47Uc+1gWwEb2hek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NefUoHXJw6tlbIIo/nJlsGbOmLqL7WLgxbedpeNr+6iZVU2DKd9gch0brOUBd0AFo8U9aFP8wj5rbfNK7sCQIeC9SmxSuLkN3EIWtASDBJ8f+ZMXRrjA4TGwCYG7nD55vcxA3QtVLwKIOAp1ZFJO6RTnZvkHfprCfNadP1XzJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=eIw7o1X6; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="eIw7o1X6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790282365; x=1821818365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kBejIS3XTPtv+8rSCICSRV8LuykKs33Sp+7QIDwXSd8=;
  b=eIw7o1X6qni55ZJJmy4MM+aD4BR5LZWYrPoxdqqEOIXm3mDFqBdtNLRd
   hV/vd+zxa2Tpw/jSkfKpthqTJCh6w6gadPFcjpGlkm8bPVX7S5gklCRQn
   rOlfGZwQhMswKMH/9mqWHYVTg7yjxRLvzaaAxwL0GDwvnd3arKHaGW385
   ZiUmLNLMuMCDNVk5IedTkA6QYjTbAYKE6GrBrIAGtdTx6c0CLkff9+Xwx
   UBfwiUZWpjjWIiVv7eJFEte7fYGN8L2PEj0chyd2kViG17NFpEm4+Gx2T
   CqPk2k9p06/KD+jRlmRjc7rOKtTd1vy5S8Rhvz5VRDZhxO8p1XpTGV2sv
   Q==;
X-CSE-ConnectionGUID: hxBSeCFRTyGM15gG+jc36g==
X-CSE-MsgGUID: 4f6jy1ZcSkSQwh4gAX8SiA==
X-IronPort-AV: E=Sophos;i="6.27,121,1787011200"; 
   d="scan'208";a="29367262"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 20:39:25 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:29520]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.144:2525] with esmtp (Farcaster)
 id adf95163-f066-4943-bfe1-5ee58d62e57f; Thu, 24 Sep 2026 20:39:25 +0000 (UTC)
X-Farcaster-Flow-ID: adf95163-f066-4943-bfe1-5ee58d62e57f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 24 Sep 2026 20:39:24 +0000
Received: from dev-dsk-surajjs-2c-afd24e6d.us-west-2.amazon.com
 (10.189.247.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Thu, 24 Sep 2026
 20:39:24 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Michael Kelley
	<mhklinux@outlook.com>, "K . Y . Srinivasan" <kys@microsoft.com>, "Haiyang
 Zhang" <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	<linux-hyperv@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.1.y] HID: hyperv: streamline driver probe to avoid devres issues
Date: Thu, 24 Sep 2026 20:39:21 +0000
Message-ID: <20260924203921.21711-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 66ef47faa90d838cda131fe1f7776456cc3b59f2 upstream

It was found that unloading 'hid_hyperv' module results in a devres
complaint:

 ...
 hv_vmbus: unregistering driver hid_hyperv
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 3983 at drivers/base/devres.c:691 devres_release_group+0x1f2/0x2c0
 ...
 Call Trace:
  <TASK>
  ? devres_release_group+0x1f2/0x2c0
  ? __warn+0xd1/0x1c0
  ? devres_release_group+0x1f2/0x2c0
  ? report_bug+0x32a/0x3c0
  ? handle_bug+0x53/0xa0
  ? exc_invalid_op+0x18/0x50
  ? asm_exc_invalid_op+0x1a/0x20
  ? devres_release_group+0x1f2/0x2c0
  ? devres_release_group+0x90/0x2c0
  ? rcu_is_watching+0x15/0xb0
  ? __pfx_devres_release_group+0x10/0x10
  hid_device_remove+0xf5/0x220
  device_release_driver_internal+0x371/0x540
  ? klist_put+0xf3/0x170
  bus_remove_device+0x1f1/0x3f0
  device_del+0x33f/0x8c0
  ? __pfx_device_del+0x10/0x10
  ? cleanup_srcu_struct+0x337/0x500
  hid_destroy_device+0xc8/0x130
  mousevsc_remove+0xd2/0x1d0 [hid_hyperv]
  device_release_driver_internal+0x371/0x540
  driver_detach+0xc5/0x180
  bus_remove_driver+0x11e/0x2a0
  ? __mutex_unlock_slowpath+0x160/0x5e0
  vmbus_driver_unregister+0x62/0x2b0 [hv_vmbus]
  ...

And the issue seems to be that the corresponding devres group is not
allocated. Normally, devres_open_group() is called from
__hid_device_probe() but Hyper-V HID driver overrides 'hid_dev->driver'
with 'mousevsc_hid_driver' stub and basically re-implements
__hid_device_probe() by calling hid_parse() and hid_hw_start() but not
devres_open_group(). hid_device_probe() does not call __hid_device_probe()
for it. Later, when the driver is removed, hid_device_remove() calls
devres_release_group() as it doesn't check whether hdev->driver was
initially overridden or not.

The issue seems to be related to the commit 62c68e7cee33 ("HID: ensure
timely release of driver-allocated resources") but the commit itself seems
to be correct.

Fix the issue by dropping the 'hid_dev->driver' override and using
hid_register_driver()/hid_unregister_driver() instead. Alternatively, it
would have been possible to rely on the default handling but
HID_CONNECT_DEFAULT implies HID_CONNECT_HIDRAW and it doesn't seem to work
for mousevsc as-is.

Fixes: 62c68e7cee33 ("HID: ensure timely release of driver-allocated resources")
Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ 6.1: context adjusted only - mousevsc_ll_driver is non-const in 6.1
  because the hid_ll_driver constification (for-6.12/constify-rdesc,
  e.g. 054e0bd34577) is not present; the applied diff is identical to
  the upstream commit, no functional change ]
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -456,6 +456,25 @@ static int mousevsc_hid_raw_request(struct hid_device *hid,
 	return 0;
 }
 
+static int mousevsc_hid_probe(struct hid_device *hid_dev, const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(hid_dev);
+	if (ret) {
+		hid_err(hid_dev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
+	if (ret) {
+		hid_err(hid_dev, "hw start failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static struct hid_ll_driver mousevsc_ll_driver = {
 	.parse = mousevsc_hid_parse,
 	.open = mousevsc_hid_open,
@@ -465,7 +484,16 @@ static struct hid_ll_driver mousevsc_ll_driver = {
 	.raw_request = mousevsc_hid_raw_request,
 };
 
-static struct hid_driver mousevsc_hid_driver;
+static const struct hid_device_id mousevsc_devices[] = {
+	{ HID_DEVICE(BUS_VIRTUAL, HID_GROUP_ANY, 0x045E, 0x0621) },
+	{ }
+};
+
+static struct hid_driver mousevsc_hid_driver = {
+	.name = "hid-hyperv",
+	.id_table = mousevsc_devices,
+	.probe = mousevsc_hid_probe,
+};
 
 static int mousevsc_probe(struct hv_device *device,
 			const struct hv_vmbus_device_id *dev_id)
@@ -507,7 +535,6 @@ static int mousevsc_probe(struct hv_device *device,
 	}
 
 	hid_dev->ll_driver = &mousevsc_ll_driver;
-	hid_dev->driver = &mousevsc_hid_driver;
 	hid_dev->bus = BUS_VIRTUAL;
 	hid_dev->vendor = input_dev->hid_dev_info.vendor;
 	hid_dev->product = input_dev->hid_dev_info.product;
@@ -522,20 +549,6 @@ static int mousevsc_probe(struct hv_device *device,
 	if (ret)
 		goto probe_err2;
 
-
-	ret = hid_parse(hid_dev);
-	if (ret) {
-		hid_err(hid_dev, "parse failed\n");
-		goto probe_err2;
-	}
-
-	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
-
-	if (ret) {
-		hid_err(hid_dev, "hw start failed\n");
-		goto probe_err2;
-	}
-
 	device_init_wakeup(&device->device, true);
 
 	input_dev->connected = true;
@@ -615,12 +628,23 @@ static struct  hv_driver mousevsc_drv = {
 
 static int __init mousevsc_init(void)
 {
-	return vmbus_driver_register(&mousevsc_drv);
+	int ret;
+
+	ret = hid_register_driver(&mousevsc_hid_driver);
+	if (ret)
+		return ret;
+
+	ret = vmbus_driver_register(&mousevsc_drv);
+	if (ret)
+		hid_unregister_driver(&mousevsc_hid_driver);
+
+	return ret;
 }
 
 static void __exit mousevsc_exit(void)
 {
 	vmbus_driver_unregister(&mousevsc_drv);
+	hid_unregister_driver(&mousevsc_hid_driver);
 }
 
 MODULE_LICENSE("GPL");
