Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B24AA028;
	Fri,  9 Oct 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539955; cv=none; b=j1UZCTuuLodjO1wMyKlHA5D/c4zzvKrpI0GFTiOrCXY5O6JFLlA2w5IUml84Se7zzB9orcwdMtg2CqcXYsVvTN+5jpn8tIebF1W2fPmTk59cOr+6Jg6+/8Ub2s/GqC8I28t2c3uaETIW/UY2z1KjMS3UtJ2ofDIKJUzkPBaY3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539955; c=relaxed/simple;
	bh=SCf9Wt5HPmCv9ZTpwNgAQ0/Cf9q8l8XlLO37xCmBXao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsMaeF6PYMNHlZ7mb3F+US40g4m9z54zOD0NWin3TnEVcrdEFccadSkKFuT91J/bqK/HA/QJ1xRX2xOA8AixwaMrnzVfItUcFVJUtKdCs0gwwoxNG+UQA1fqGfxFrtOezRY4KMozEjw+NgdOkQ3q2zE/Moh5wHARkUyv8mMc+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtVWGVQ8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtVWGVQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791539955; x=1823075955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCf9Wt5HPmCv9ZTpwNgAQ0/Cf9q8l8XlLO37xCmBXao=;
  b=mtVWGVQ8XUGDSteUZC2bbD6Rx6iL71cUiBuspXuGJRdc8hcvw+lpepgc
   0SjvDq1dksE9w6qnyKH4Icqx5kbHR2MkG97BX9rbvxyvhgR5njokaNYzV
   asJsv31IeJNqfo9JYQVzdBRJboGWtQxRqLKZbp73nMxwwMww70uYWn6wd
   08MqnQkxlzBkUSQvuSWgJSN5EeO6TdK0ioKvIGHreUK/UpICkiwmJOumt
   dD7j7BdcD18DAn01C00xHnTmdEtwaQ1SnzwugeLUAlrno09NaudniEpIS
   urGxmx+8sTXVb8NRXq8vyOOVC+3U8miYHmIXdosIFoYUW4PEIUR8Q/D/B
   A==;
X-CSE-ConnectionGUID: 3QsOJO3JQ+mR2BvhgAMnoA==
X-CSE-MsgGUID: /zU+/K2DRVut18FebBnC8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="224149"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="224149"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 02:59:14 -0700
X-CSE-ConnectionGUID: 72M6RWV1SE2fG0/fQgULUA==
X-CSE-MsgGUID: LwKFW8jxSbyq+xGAsXN86A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="613454"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.244.17])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 02:59:12 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Lianqin Hu <hulianqin@vivo.com>,
	stable@vger.kernel.org
Subject: [PATCH 14/14] xhci: Prevent invalid vdev dereference during sideband unregister
Date: Fri,  9 Oct 2026 12:58:34 +0300
Message-ID: <20261009095834.561578-15-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009095834.561578-1-mathias.nyman@linux.intel.com>
References: <20261009095834.561578-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Offloaded USB audio devices using the xhci-sideband API store a pointer to
the xhci virtual device (vdev) in the sideband structure when registering.

This pointer typically remains valid throughout the lifetime of the USB
device. If a configured offloaded device requires a reset, the USB core
usually unbinds or notifies the audio driver beforehand, ensuring that the
sideband is unregistered before the vdev is freed.

An exception occurs when the USB core resets a device to recover from a
failed resume, but a subsequent 'address device' request also fails. To
recover in this specific scenario, the xHCI driver disables and re-enables
the slot, which frees and re-allocates the vdev.

xhci_sideband_unregister() later dereferences the stale, previously freed
vdev pointer during disconnect, triggering a kernel oops:

 Unable to handle kernel paging request at virtual address dead000000000122
 Call trace:
  xhci_get_ep_ctx+0x0/0x38
  xhci_sideband_unregister+0x68/0xf0
  uaudio_disconnect+0x70/0x144
  usb_audio_disconnect+0x7c/0x268
  usb_unbind_interface+0x13c/0x340
  device_release_driver_internal+0x1c4/0x2bc
  usb_disable_device+0x84/0x190
  usb_disconnect+0xe8/0x338
  hub_event+0xbd8/0x19ac

Fix this by preventing the reallocation of the vdev in this specific error
path if the device is registered for sideband use.

Just propagate the error directly to the USB core. It should either retry
enumeration or detect the disconnected device, and handle it accordingly.

Debugging this issue to the dangling vdev pointer, reporting it, testing,
and initial patch with different solution by Lianqin Hu

Reported-by: Lianqin Hu <hulianqin@vivo.com>
Closes: https://lore.kernel.org/linux-usb/TYUPR06MB6217000B59003EDF233D7246D2B22@TYUPR06MB6217.apcprd06.prod.outlook.com/
Tested-by: Lianqin Hu <hulianqin@vivo.com>
Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 9564dde8bb34..30ac1bc4559b 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4435,10 +4435,13 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 		dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);
 
 		mutex_unlock(&xhci->mutex);
-		ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
-		if (!ret) {
-			if (xhci_alloc_dev(hcd, udev) == 1)
-				xhci_setup_addressable_virt_dev(xhci, udev);
+
+		if (!virt_dev->sideband) {
+			ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
+			if (!ret) {
+				if (xhci_alloc_dev(hcd, udev) == 1)
+					xhci_setup_addressable_virt_dev(xhci, udev);
+			}
 		}
 		kfree(command->completion);
 		kfree(command);
-- 
2.43.0

