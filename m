Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90083472539;
	Thu,  6 Aug 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026113; cv=none; b=tEJP/GFZ2WAHkgLlJbLJwHol6AKPPNDC6JFPJWnDSUWTHCPh//fDAwTQB8XW/BdUNNzGeoiYW0J+euA05NjOxvoDMuA2Xoy9f6iXAkdRICUiR47WdgGmEC0uisYcb3fK4cYcHlF8mp4/uHjkMLBpPzuyGS3Vb0Pbl4S1M6mYp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026113; c=relaxed/simple;
	bh=yAIwoAbrGT8jNg3TKEYoUEzHO7UYHARcWgRFuKbfK6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beXKQ/IZeuLAWW21vom//DTus/tkVCy6tmM4iRaA0NDWlyeT3IxqQg7A+n0m3aUtg/Ax8k6AM0Lp0PY82HhH2zR/sq0ieuuAZ9szX4w2DXTSxi6G04NyipaeWrys5i/PMLNgEYB6n3dymX1fbYRgAKFHbwmF/mIfDYypnfo6Mx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1hBCZGU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1hBCZGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786026112; x=1817562112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yAIwoAbrGT8jNg3TKEYoUEzHO7UYHARcWgRFuKbfK6E=;
  b=I1hBCZGURn3kNRcUYjs+7jd6/rEkyhKK3/bs9ZLX7iHHKCa6KWcxS6g4
   iJwUG86jnDjwex3pni6Gfwm7ScNJvsfEWOokEje7hVRNhPzxMz9uipzma
   vAK6Z42T6ogHcMaRw8N9MHuY8e32+3A8u+tS9UvVc6Fd14RbS3izxlzH6
   9JB5Sl5gIWuuwgrjklLOrX0YfA7xxbyVys0EKwuv0R0eJOac3n/+9QZ1w
   Xyr4ApsVExXLsz6xYh6oTXNLwAWNTMrdn1blxLQhX3UXuHhbpFlVRl7lV
   8onYRHz7WVoANc9zcDqPLhlPRLLTYI7UVJGC8PH8J1ZFzYo8jGZQDNKiG
   g==;
X-CSE-ConnectionGUID: PYtfanvSR0y4AxOhD/yVfw==
X-CSE-MsgGUID: gc5W4jFxS4i4lbDJXfOybg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97268211"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="97268211"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:21:52 -0700
X-CSE-ConnectionGUID: 1hnODkh3TkqwoGH2ZM1cMg==
X-CSE-MsgGUID: bI+qpOZRTai1eSquAzY+Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="285500526"
Received: from amilburn-desk.amilburn-desk (HELO mnyman-desk.home) ([10.245.244.235])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:21:51 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Semih Baskan <strst.gs@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 16/17] usb: xhci: Handle USB3 port events when there is one roothub
Date: Thu,  6 Aug 2026 17:21:12 +0300
Message-ID: <20260806142113.2436238-17-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806142113.2436238-1-mathias.nyman@linux.intel.com>
References: <20260806142113.2436238-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Semih Baskan <strst.gs@gmail.com>

handle_port_status() drops every USB3 port event when xhci->shared_hcd is
NULL. The check dates from a time when xhci-plat always created a shared
hcd, so a NULL one could only mean the hcd had been removed.

Since commit 4736ebd7fcaf ("usb: host: xhci-plat: omit shared hcd if
either root hub has no ports") that is no longer true. A controller whose
USB2 root hub has no ports gets a single roothub, the USB3 rhub is served
by the main hcd, and shared_hcd stays NULL for the lifetime of the device.
Every SuperSpeed port event is then thrown away as bogus behind a debug
message, so devices never enumerate even though the port sees the device
and its change bits stay set:

  0x006a1203 Powered Connected Enabled Link:U0 PortSpeed:4
  Change: CSC WRC PRC PLC

Broadcom Northstar is such a controller. USB3 works there up to 5.15 and
stops working from 5.19 onwards.

Ask xhci_get_usb3_hcd() instead. It returns the shared hcd when there is
one, the main hcd when the USB2 root hub has no ports, and NULL once the
shared hcd is gone, which keeps the original meaning of the check.

Tested on an Asus RT-N18U (BCM47081), which has a single roothub. Before
the change nothing enumerates on the USB3 port; after it SuperSpeed
devices enumerate normally over repeated connect and disconnect cycles,
the change bits shown above clear, and USB2 is unaffected on both ports.

Fixes: 4736ebd7fcaf ("usb: host: xhci-plat: omit shared hcd if either root hub has no ports")
Cc: stable@vger.kernel.org
Signed-off-by: Semih Baskan <strst.gs@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 6e60959e3faa..69bd582c7e2b 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2019,7 +2019,7 @@ static void handle_port_status(struct xhci_hcd *xhci, union xhci_trb *event)
 		vdev = xhci->devs[port->slot_id];
 
 	/* We might get interrupts after shared_hcd is removed */
-	if (port->rhub == &xhci->usb3_rhub && xhci->shared_hcd == NULL) {
+	if (port->rhub == &xhci->usb3_rhub && xhci_get_usb3_hcd(xhci) == NULL) {
 		xhci_dbg(xhci, "ignore port event for removed USB3 hcd\n");
 		bogus_port_status = true;
 		goto cleanup;
-- 
2.43.0

