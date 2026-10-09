Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3AA44C64C;
	Fri,  9 Oct 2026 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559012; cv=none; b=T6rZyvTntmnUCDEKURCDS1Vl5wAJvTK3GdImqokHWqDKv1Tmb/vMwHEIJzz6OExqPp5DpY+Go7TSTG016CiSfSKmA+X9cCzkirdyQMvbPRQDUsy8CW8BrtKbH3H0Onl8+25SNCWduF+BFNMLOq54mt2hu81zKS0hPTbnzuLh+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559012; c=relaxed/simple;
	bh=SCf9Wt5HPmCv9ZTpwNgAQ0/Cf9q8l8XlLO37xCmBXao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui0v85gmMb6wXWdbdFOm51iVmc39wY8DerH4+X13qQzj4Ciq1X4ldm2fo+1lP5rKJFcEtXzH6l9y/mejZ9jLlMtVSu+x7prLblHOHBBCBUbwviYipJsRWVGKEcwT+REmQw8QJpquISEjthxQgdKJwAXhmbzuDyw/M0WhZgb7KvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJ2J/d8x; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJ2J/d8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791559011; x=1823095011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCf9Wt5HPmCv9ZTpwNgAQ0/Cf9q8l8XlLO37xCmBXao=;
  b=iJ2J/d8x3ztIgp3sComF1zaW1SW0pD57qKOOSKpOE+sBx0+sp+TArAfN
   hSWwpci8FLnLpdn0Nj53+AiZyuXlPzWp2im0Y1sLRZ+uns3nXz9+aRxj6
   atXYf/J+iuGS1L59tz8mKlF/FW7f4KUhaFb4C5SiV2VwTXtPoRFolkagE
   Y8JhgFikR8AQdm/FuccYB2Lr8pp/UOqh7AKiS7rjbIcGH7UsiEDMY88wN
   /Txuh/pQOjawyiON/OfLPCFYGxZ4AO3sLZw/k/Bn0CdXP9F/XNyn2oLoc
   YEsfkr3nxwb1NDTybCEHnv3OqaTWS0E9eNCIJtjTrdMafKQXmY5SksYFb
   A==;
X-CSE-ConnectionGUID: GHFvpqbkQP2FDPO+9+WsaA==
X-CSE-MsgGUID: 7LO9l3pQTAmrqqdJK7nlpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="351723"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="351723"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 08:16:51 -0700
X-CSE-ConnectionGUID: fUjRQVl6Tr+ffpY84ay2DQ==
X-CSE-MsgGUID: xzD0WB3xR/qM8G6czMPEhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="650079"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.244.17])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 08:16:50 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Lianqin Hu <hulianqin@vivo.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 11/11] xhci: Prevent invalid vdev dereference during sideband unregister
Date: Fri,  9 Oct 2026 18:16:24 +0300
Message-ID: <20261009151624.618967-12-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009151624.618967-1-mathias.nyman@linux.intel.com>
References: <20261009151624.618967-1-mathias.nyman@linux.intel.com>
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

