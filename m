Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9A25DB0D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006615; cv=none; b=Scr2toMALC7Ip53g31BSOi4UVWLPSYyUpKiMcVuE5cVWUGRK9oInB+nVukxh5XZzdsZt7oK3Jcda+f4xGnRzR28OV4gx7hWlgfW82ZHwUX04Y3Bcls+MNYiIS75zwao4DwSVuLUG3fek5DQK0OJpzVJyXVtcYTDNMKjfTwM1PpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006615; c=relaxed/simple;
	bh=5Qw2xtza4DKWqSY6pflRsPHCNEsUgmwilyXtWh7VrdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSOUQmgPWV9uzep6Ce8fLU4zIoSMZzFL2KKxrUvKu2qzZn7ZQr7EZr0i7IRFJztRAksEgkW/58vfnpCf2j4aRzVMjVOk/F/WArG5Nraat3qybzh7H0Ysk3n6AMWAs7yFPyDOKnSfxFCeDsPLJJdJODewz6iS73PbQfmWariwXrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPFq7mwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPFq7mwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C88B1F000FF;
	Thu, 10 Sep 2026 02:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006613;
	bh=B6as4zd7ghd3TGXm+5m0HobUMK7rK+T3olvDEKpOGDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPFq7mwibaynvxA6wrsQcs2iOwiLBdjWh9+cSOPOfoS2VVbNkU/zDVdoD5zEptp3o
	 +Mn+w3xDr1andsPM60I+rDC5hsaEafHvsFFRYH6/ubtC2Pu3gESF9OA80vTYSTQRvC
	 htJJmfXEpskEy5f8B4QdJn3IrrohtixEr6FSATeRaPVXzvRM44Kyh038UqbXQBzaCv
	 3/LcXh341//MX6zggA8Kbw/BaGj/seJ3kwkP/NsSDgk/erFCx1B+9sGrF8A0TLWtXJ
	 G1G8KnBx6X0WTKi+CaqLntRv9gWOznvfVRbwAMZMrWKQZmRnfRAWhCriP9/h2ei5Zq
	 OkY6dudAvSYjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] xhci: Cleanup Candence controller PCI device and vendor ID usage
Date: Wed,  9 Sep 2026 22:16:49 -0400
Message-ID: <20260910021651.4003185-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090845-lyrically-primal-44f3@gregkh>
References: <2026090845-lyrically-primal-44f3@gregkh>
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
index f8988f110dcff..556242257a132 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -88,8 +88,7 @@
 #define PCI_DEVICE_ID_ASMEDIA_3042_XHCI			0x3042
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
 
-#define PCI_DEVICE_ID_CADENCE				0x17CD
-#define PCI_DEVICE_ID_CADENCE_SSP			0x0200
+#define PCI_DEVICE_ID_CDNS_SSP				0x0200
 
 static const char hcd_name[] = "xhci_hcd";
 
@@ -393,9 +392,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
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

