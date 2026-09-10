Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103836B90C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005576; cv=none; b=E5OEwr1UCaAIHoYiOG1SrjXVkItsVG+uU2XXNAtkawCVSujq2QbOBEGHH0LT7qGU01IxHqFXjHFMzODmh1bItJNSzJURgIUnNSXE7G5Uu60Ke+2eBoXKLfVwyaeyUo/Q5N57M4CtTNIRl42o6QBktEcYH+5BwnK3HdFu4yI3cMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005576; c=relaxed/simple;
	bh=zJ4EPPgcTyc9unAzzGWaB3U2x4Uvh14fcx+T9oDz5g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMUp0Oa+lBbxlk4WvHgrAYbHX0EP2gPYoczCLkb+uYYYAaXW72xab6hALEfN1nYVVPAD1gc/bu8jUoZ4R3cChIIKqor9GKjybFcXYPqDEPYjs5v9fn689dq0Mv/M+66VGQ/I+ohKZ/5vj4UOrZS9O9yd5VBxnXHaLdamNfm+O10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0M/gygF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0M/gygF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D328A1F00893;
	Thu, 10 Sep 2026 01:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005574;
	bh=uRLLwJih2SFaARgGcbkE+SWXVoMWLNu0W+kE8zFbdr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z0M/gygFnQxZv09/A+/rlRy0C7U9cxi0q4NRdTLQo0/CIZmun/yMxbNG/NDbKNiDT
	 If+wU2+tSXC651vTYp0TSFO79wkfivG38/0m5mgDYBZBkGpI6KjDZT5qi17YBsBHj0
	 VEx5jLbYoSqwWsrGH0yqJjTHXZvTSYx5KLpR3H0QY+ru0DyCmvw/Ksk8sg4lCfKqNs
	 OmJFRpExFwQV7hDfLvxEFml1nscdCaiiZ9ItWB2UFFFKWTV/8cKbAq2zP872pT/qXL
	 F0JujRqeNWuB4Vt3KD37eRbVwk6+4Bkq8kT44Ubgw/iQajueeYZUfpDnldday5b0su
	 HWstZM6kK/XVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] xhci: Cleanup Candence controller PCI device and vendor ID usage
Date: Wed,  9 Sep 2026 21:59:30 -0400
Message-ID: <20260910015932.3952831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090843-suspense-pleading-37f3@gregkh>
References: <2026090843-suspense-pleading-37f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit f28a7d7db247af8b9f1090bd6b1ca1fa48a3f0e4 ]

Use predefined PCI vendor ID constant for Cadence controller in pci_ids.h
Rename the Candence device ID to match the pattern other PCI vendor and
device IDs use

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/linux-usb/ZuMOfHp9j_6_3-WC@surfacebook.localdomain
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: eae6460f6173 ("usb: cdnsp: fix wakeup from S3 after controller context loss")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index bd33cf6769cf6..c2ae0e5f4c2b7 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -94,8 +94,7 @@
 #define PCI_DEVICE_ID_ASMEDIA_3042_XHCI			0x3042
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
 
-#define PCI_DEVICE_ID_CADENCE				0x17CD
-#define PCI_DEVICE_ID_CADENCE_SSP			0x0200
+#define PCI_DEVICE_ID_CDNS_SSP				0x0200
 
 static const char hcd_name[] = "xhci_hcd";
 
@@ -509,9 +508,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		if (pdev->device == 0x9203)
 			xhci->quirks |= XHCI_TRB_OVERFETCH;
 	}
-
-	if (pdev->vendor == PCI_DEVICE_ID_CADENCE &&
-	    pdev->device == PCI_DEVICE_ID_CADENCE_SSP)
+	if (pdev->vendor == PCI_VENDOR_ID_CDNS &&
+	    pdev->device == PCI_DEVICE_ID_CDNS_SSP)
 		xhci->quirks |= XHCI_CDNS_SCTX_QUIRK;
 
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
-- 
2.53.0

