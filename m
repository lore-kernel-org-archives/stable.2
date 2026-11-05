Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901090;
	b=FPm3ayzw5v4QzLfFANaZyeBQ13dHsf9x4bVKv7C43U+cJyNgbbdZZb0btoPcI+L2I5Dv
	 2IVZjuc3L7B1emE0j2gYKNe9xJVQyA1GpoJRMIQVS679INkj3cRGp3I2XSDAcyOFY4Bug
	 tITUduTVsWW8nybAETgzj+5jlcyVdUd5llJoOFV3naeCDmhox8CDZ3YlNcLH575aHRfqc
	 08VVc/4t8A3zcLFA0ev1p9J69o7s5VYQtcA0yfoX5yvcDIjXhrLykYCH0QQCVHLsfjEAZ
	 ESy/DQQc45QKbPGeTPvUxjm8DMZwuyCOlLhAcBTAtyU2meoxP2mp8uROCMHs2p6NOdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901090;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ibHPfRmXhU7PfDQCKJSUbQDufm7aILOjC5+xStnQXzE=;
	b=gI9xtJFvkT3EitUwG/bh1IfSJodw2aH1Kd4ZX2v9vKBjfylCqgxIA7VUagM/3sy8+VjG
	 AGooIW6T0QuZ48g+Q9nBdOi4GmXrr5YjcJqVbA+EQ4M+y5wT3fpDC6rNxv6ie/aacH1iw
	 EnhoFKptYdx1ZACLhPZzSlirU8W7SDUr7PnBHdHXh6/pOTusWvEKeg2Q6AQu9+qk+i4VU
	 P0fpxxK0y3iq0QKnO+nOl5rSbK6FrCFagsOw6Jawd7kEw3nXOIYup5Lh/H75etJ45Cuv1
	 SR4DByWCFACO+sOwYZtL7MVSOq3waZtoHTQRcI7cYbuqXeyhMQCsyPYIrsOufBXIBIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cP0vja2J;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5D606A329;
	Thu,  5 Nov 2026 17:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56D5D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cP0vja2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793901090; x=1825437090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=goFA/ztPQOMgqcsSnt/3SiXl4vOpPed6uZQcj+75rRY=;
  b=cP0vja2JEtzVCJvEFSozJEXoalxCziKyJFHLTPKqpzW7TIQ71Z1CAJYY
   kLYS2zB1iNVCMVkVbOSPM4yYxKl7q9ivOa+mtA33zALwELEr8JboN65oo
   0RnjbXqPdUgVFs54YWN62m2zQ2ZqJIO1K6feDYs0VOX7JbS69IFdYmh8v
   5mTHW/V+dgj4wD+ds99yKnFsh/7I9098vFzXkdispnQymo2zxre5fTcJz
   sGI4Spi3L8DkW1XjU5YYGJIRU0NAITYV7a8fA6ENlYXN+yjRnW3xbHzoq
   VlN48KzIK0xZunlWkumGyvMtD0wJ/1vZDg6ZQvxZNBsdrcuHsfki/5lGS
   g==;
X-CSE-ConnectionGUID: Sa2i2CAETZ+C33inMjY2Pg==
X-CSE-MsgGUID: vIoJIkPGQXSKMrKmznOuTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2572545"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2572545"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 09:51:30 -0800
X-CSE-ConnectionGUID: mtPUfoxLRfCVNqR/zsv7rA==
X-CSE-MsgGUID: iFluPaJCSrWX5UYUk7FFNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7064873"
Received: from amilburn-desk.amilburn-desk (HELO mnyman-desk.home) ([10.245.244.193])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 09:51:28 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Rishabh Jain <rishabh.jain1198@gmail.com>,
	stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	McKenna Fan <blue_sun@tuta.io>,
	Quinn Schive <quinnschive@hotmail.com>,
	Bruno Filipe <bmilreu@gmail.com>,
	Maciej Zonski <me@zonni.pl>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 3/5] usb: pci-quirks: always assert xHCI OS ownership
Date: Thu,  5 Nov 2026 19:51:04 +0200
Message-ID: <20261105175106.241182-4-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105175106.241182-1-mathias.nyman@linux.intel.com>
References: <20261105175106.241182-1-mathias.nyman@linux.intel.com>
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

From: Rishabh Jain <rishabh.jain1198@gmail.com>

The xHCI ownership protocol requires the OS driver to assert the HC OS
Owned semaphore before using the host controller, then wait for HC BIOS
Owned to clear if firmware owns it.

quirk_usb_handoff_xhci() currently asserts OS Owned only when BIOS Owned
is already set. If firmware leaves BIOS Owned clear, Linux uses the xHC
while both ownership semaphores remain clear.

The timeout fallback also clears BIOS Owned using the original register
value, which can clear OS Owned at the same time.

On an AMD PROM21 xHCI controller (1022:43fc), this caused every S3
resume to terminate Controller Restore State with USBSTS 0x401. Linux
then reset the host controller, both root hubs and the USB Bluetooth
adapter.

The controller entered resume ready and halted with USBSTS 0x1.
Endpoint state, 100 ms save/restore delays, scratchpads, the DCBAA,
device contexts and command, event and transfer rings were verified not
to cause the restore error.

Across four S3 cycles, asserting only HC OS Owned changed USBLEGSUP from
0x00000801 to 0x01000801 and eliminated the restore failure. Testing
included the unmodified 7.1.8-ogc1.1.fc44.x86_64 distribution kernel
using a test module that set the HC OS Owned semaphore. The same test
was repeated after review with the same result. Clearing USBLEGCTLSTS
was independently verified to be unnecessary.

Always assert OS Owned for controllers using the standard xHCI handoff,
and leave the existing TI/Renesas forced handoff unchanged. Keep OS
Owned asserted after the standard handoff, including when forcing BIOS
Owned clear after a timeout, to prevent firmware from reclaiming the
controller during subsequent suspends.

Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: McKenna Fan <blue_sun@tuta.io>
Tested-by: Quinn Schive <quinnschive@hotmail.com>
Tested-by: Bruno Filipe <bmilreu@gmail.com>
Tested-by: Maciej Zonski <me@zonni.pl>
Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/pci-quirks.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index f670e7aab984..1dbfd697a582 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1195,10 +1195,11 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 			 && pdev->device == 0x0014)) {
 		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
 		writel(val, base + ext_cap_offset);
-	}
-
-	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
-	if (val & XHCI_HC_BIOS_OWNED) {
+	} else {
+		/*
+		 * Perform the standard handoff and leave OS ownership set to
+		 * keep the BIOS at bay during subsequent suspends.
+		 */
 		writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
 
 		/* Wait for 1 second with 10 microsecond polling interval */
@@ -1210,7 +1211,9 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 			dev_warn(&pdev->dev,
 				 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
 				 val);
-			writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
+			writel((val | XHCI_HC_OS_OWNED) &
+			       ~XHCI_HC_BIOS_OWNED,
+			       base + ext_cap_offset);
 		}
 	}
 
-- 
2.43.0

