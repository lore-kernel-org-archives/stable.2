Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045853;
	b=5QtjbhiYYeif/jSuxnWuc6TwjcZZfnmqJDywlOjGrp6UyRHNtzMrqd5Kg1No67RF583W
	 CdfRMqHa/oX6lBT6m9ql7oLB2f1bRHd235L4/WIfMWJWHLbYZZgm+zWg1dFrQEVeULPTt
	 eiij28DJ5cz58ohH1IBCXUP+ioGv3+nAOzHkl81yKnGPehIA4R1OHqTnuSY7b2V1r+fs+
	 ZO2wLZhmKF+zWHiLyWJXaUNt9zZUqfDTm32N8SfSZEJKzVQeizpA54HGOD4SipnKavjOq
	 HJGIYiVFF7fGK5AF2NG8QUR6BrZhBehslOaR091XvZfBH70nLgwolRB7TRDW4IYYKlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045853;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=l5nLQ/xMmjvdRT/5n7MpLEJ2/SlXevcabCzN+XFiXWU=;
	b=w825pYQwodgGyfes7kOcD8TqtWaX4XRm+aUCVG5iv39e5+J097hxPI8/zDqkvT0+UUrS
	 ejuKFI3rqQtu09KfKKq8T5JuuUvCulwVRBvBasZy0k0BgMQRae1FI00+B0SwlkRr6hfhA
	 EalJn1gdjFoHYohp/YqmarhXE7Yi9Jm5a1mkHhqeD5hOycsV1FMGqrITNe8dIIIQJMDNq
	 Pu3lS0dhbFuR1jjyKsLRNuItvTlYdlIeaDwbPc2AQcw0G8OnYozakjG0dg0VdR4nHsheS
	 AzwGQR7E1Y2+aWLmMMGQWvIlvv7HeeZGUyTo/bLlhAUEkQeHjix8d8cxgtmA47c+zbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=By7hmTwX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DA606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=By7hmTwX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83221F0089F;
	Sat,  7 Nov 2026 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045852;
	bh=l5nLQ/xMmjvdRT/5n7MpLEJ2/SlXevcabCzN+XFiXWU=;
	h=From:To:Cc:Subject:Date;
	b=By7hmTwXhIMfVsuMPJJ00TavZ2iRSONH/ftsADxy5se7sVdpVVksGonyF4yZ+LHSk
	 MPWybJKBBpUI0Ow5CSdFYWpRaGXJq2rtnBKDLF0vnhTfi6LnrZs12RF9tdxI37vD0w
	 G1FnA1GOFqqWSGCziZZsUOR3w9Jou28C3lM3zWGtSrUqeK4uHL0c7tXcC9YVWeDiEh
	 zlNpfD0FzvM3Hh/VHvSkxDajGo99pFGe3CqsWx5nR4kaumY4lVOsvfmGm/8ig3Gzcl
	 uBpu/fjbpzh/W/UxQt7kYnBnLbcFmSBTmnKuwzlZlSDzFOexWR16UrsOEj/SKxCFh4
	 vSa/7TeM45drw==
From: Sasha Levin <sashal@kernel.org>
To: james.a.fairweather@gmail.com,
	stiraspo@gmail.com,
	tzungbi@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/chrome: cros_usbpd_notify: Only use drvdata when parent is GOOG0004" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:10 -0500
Message-ID: <20261107050410-failed-7.3-ca75b38b1a3c@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x ca75b38b1a3c2eabe81d231dae4ea180cf6287cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050410-failed-7.3-ca75b38b1a3c@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ca75b38b1a3c2eabe81d231dae4ea180cf6287cd Mon Sep 17 00:00:00 2001
From: James Fairweather <james.a.fairweather@gmail.com>
Date: Sat, 3 Oct 2026 18:28:53 -0400
Subject: [PATCH] platform/chrome: cros_usbpd_notify: Only use drvdata when
 parent is GOOG0004

cros_usbpd_notify_probe_acpi() takes the EC device pointer from
dev_get_drvdata(dev->parent) and assumes it is a struct cros_ec_device.
That only holds when GOOG0003 is a child of GOOG0004. On older devices
without that hierarchy, such as Google Nami, GOOG0003 and GOOG0004 are
siblings under the ACPI EC (PNP0C09):

  PNP0C09:00 (acpi-ec)
  |-- GOOG0003:00 (cros-usbpd-notify-acpi)
  `-- GOOG0004:00 (cros_ec_lpcs)

Before commit db65a06d10b3 ("ACPI: EC: Convert the driver to a platform
one") the parent platform device had no driver data, so the driver
warned and continued without an EC pointer, as intended for these
devices. Since that commit the ACPI EC driver stores its struct acpi_ec
there, so the driver treats a struct acpi_ec as a struct cros_ec_device
and calls cros_ec_cmd() on it for every USB-C PD host event. Plugging
or unplugging a charger then intermittently oopses, followed by soft
lockups and a hung system:

  BUG: unable to handle page fault for address: ffffffff9cf03220
  #PF: supervisor write access in kernel mode
  Hardware name: Google Nami/Nami, BIOS  09/19/2019
  Workqueue: kacpi_notify acpi_os_execute_deferred
  RIP: 0010:native_queued_spin_lock_slowpath+0x29d/0x330
  Call Trace:
   _raw_spin_lock_irqsave+0x59/0x80
   __mutex_lock.constprop.0+0x129/0x930
   cros_ec_cmd_xfer+0x2a/0xf0 [cros_ec_proto]
   cros_ec_cmd_xfer_status+0x1a/0x90 [cros_ec_proto]
   cros_ec_cmd+0xb7/0x140 [cros_ec_proto]
   cros_usbpd_get_event_and_notify+0x42/0xc0 [cros_usbpd_notify]
   acpi_ev_notify_dispatch+0x4e/0x70
   acpi_os_execute_deferred+0x1a/0x30

Only read the parent's driver data when the parent's ACPI node is
GOOG0004, and otherwise continue without an EC pointer. While at it,
drop the reference taken by fwnode_get_parent().

Fixes: db65a06d10b3 ("ACPI: EC: Convert the driver to a platform one")
Fixes: e4ee0bb077cd ("platform/chrome: cros_usbpd_notify: defer probe when parent EC driver isn't ready")
Cc: stable@vger.kernel.org
Assisted-by: claude-opus-5-5 checkpatch
Signed-off-by: James Fairweather <james.a.fairweather@gmail.com>
Reported-by: Sergey Tiraspolsky <stiraspo@gmail.com>
Closes: https://lore.kernel.org/all/20261003204623.18124-1-stiraspo@gmail.com
Tested-by: Sergey Tiraspolsky <stiraspo@gmail.com>
Link: https://lore.kernel.org/r/20261003222855.23707-1-james.a.fairweather@gmail.com
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_usbpd_notify.c | 39 +++++++++++----------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 6f5eea4938cb4..25da31ec19969 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -110,26 +110,29 @@ static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
 	if (!pdnotify)
 		return -ENOMEM;
 
-	/* Get the EC device pointer needed to talk to the EC. */
-	ec_dev = dev_get_drvdata(dev->parent);
-	if (!ec_dev) {
-		/*
-		 * We continue even for older devices which don't have the
-		 * correct device hierarchy, namely, GOOG0003 is a child
-		 * of GOOG0004. If GOOG0003 is a child of GOOG0004 and we
-		 * can't get a pointer to the Chrome EC device, defer the
-		 * probe function.
-		 */
-		parent_fwnode = fwnode_get_parent(dev->fwnode);
-		if (parent_fwnode) {
-			parent_adev = to_acpi_device_node(parent_fwnode);
-			if (parent_adev &&
-			    acpi_dev_hid_match(parent_adev, CREC_DRV_NAME)) {
-				return -EPROBE_DEFER;
-			}
+	/*
+	 * Get the EC device pointer needed to talk to the EC. The parent's
+	 * driver data is only a struct cros_ec_device when GOOG0003 is a
+	 * child of GOOG0004. On older devices without that hierarchy the
+	 * parent may be bound to an unrelated driver (e.g. the ACPI EC
+	 * driver for PNP0C09), so don't touch its driver data and continue
+	 * without an EC pointer. If GOOG0003 is a child of GOOG0004 and we
+	 * can't get a pointer to the Chrome EC device yet, defer the probe.
+	 */
+	ec_dev = NULL;
+	parent_fwnode = fwnode_get_parent(dev->fwnode);
+	parent_adev = to_acpi_device_node(parent_fwnode);
+	if (parent_adev && acpi_dev_hid_match(parent_adev, CREC_DRV_NAME)) {
+		ec_dev = dev_get_drvdata(dev->parent);
+		if (!ec_dev) {
+			fwnode_handle_put(parent_fwnode);
+			return -EPROBE_DEFER;
 		}
-		dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
 	}
+	fwnode_handle_put(parent_fwnode);
+
+	if (!ec_dev)
+		dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
 
 	pdnotify->dev = dev;
 	pdnotify->ec = ec_dev;
-- 
2.53.0




