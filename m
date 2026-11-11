Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366787;
	b=KLGA4GUES/lY7wwlNU0aJe46zHdj7vGPxKniZUWyGGC5BOJ7CbfI23EK1pz1dPQoBzB+
	 SyhTDHj6ts8qnqlp+NQH0Ukg8LVIWcumUNjS7uOLPQdc6lc1qhKZOLMvFiLhR7RRNOOj6
	 vEOIC7+aiuXByredge0ti/BrFD1QDb9kLRElBmNS/JWFIYhMUkP8Ie37WLJPEv6jOUFDK
	 CbOPEJ0CGDDiJEtc8SaAQHjC/H/cQ2JpY534dJRG3YmVVmRArhrffemmohnpeKmgW1JpW
	 82Ccgoo4yOGW3Jt2s+Q29be6m449Y/bLJG/gEvKakmbtQMOx9fVpXwLtszZdHNyGjBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366787;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Bp8q6U65VGNuRYTkbJitn2ETKuafUTRBZIhyoV+aYOw=;
	b=B+7pMUS6SmNVD28kuKsk3O5vrop1xoGz6N8jwXjcHiU88MhNx/oOgNDfj+tokmizxlYZ
	 v0sb0FqU2LE4hleFvycfzodp8fhl189b3enIP8BRS1/l7hllq4Vh5k1+JSfAQ+UXuVD9l
	 ELQCJRAAnpAIW/dTvKokd4nJkdxwYoAAWFejFiZLDRnPAAMDF9oki+E3CzHLvvQvX+IMA
	 BDmL7REWdQH0w+rPP4/0cScnofM6/+2xhQjIvq+1QWQxeP9Yo9oYjVdlEUhRQZIIMAblG
	 RgGI7v21qrn8SlAvzzEk3WGRtq8ApUwjN26wagXSEuVAi8xw+OhS8ZzWnef/tUS2IRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdF16sSN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A44606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdF16sSN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923C71F0089F;
	Wed, 11 Nov 2026 03:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366787;
	bh=Bp8q6U65VGNuRYTkbJitn2ETKuafUTRBZIhyoV+aYOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UdF16sSNtitFbqKPDWb0ajulzsP0ZKWmzLWBwLCzIGGFI8IkPF0gGWtu9hiXHGtRK
	 0KldL170ujR653l+D/fyBqkZpSz/ZjrNB3Ne0q90e9jAQs8IsUrHrHIDwRgK0uz3Oq
	 t4tKLRnddSA+OrCiFgu+OhJGtDGJ6Ddqrhg7jNKprk6nYcT6+G9VLkpVW+vT5XFKFJ
	 Sly20pc7jPNbnflC6GsTPVfp/B8zXANxzRBUBgeungoGkvrxBoXt2AEdAe3VrAJLis
	 3cW7w/1R73CS0ejw4YOhua4kAP5dj6GCuIZobwrO+o4UNttfRPYZQ2X7ZHrFY5K8gu
	 jZpe9JHlCpj7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Fairweather <james.a.fairweather@gmail.com>,
	Sergey Tiraspolsky <stiraspo@gmail.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] platform/chrome: cros_usbpd_notify: Only use drvdata when parent is GOOG0004
Date: Tue, 10 Nov 2026 22:13:04 -0500
Message-ID: <20261111030918.832540-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111030918.832540-1-sashal@kernel.org>
References: <20261107050410-failed-7.3-ca75b38b1a3c@kernel.org>
 <20261111030918.832540-1-sashal@kernel.org>
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

From: James Fairweather <james.a.fairweather@gmail.com>

[ Upstream commit ca75b38b1a3c2eabe81d231dae4ea180cf6287cd ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

