Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72410376BD1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006276; cv=none; b=BFwMXq376AQnHp+YtvtRKo7V6kjVDsfLjfDSD2p2I832E+LzA6W3y8xx9jSrLj4FQzlll7fxbzv0liB0wmFseFz7EC22V4cuaVVEcc1s1JgUi9qV+IHT0WuFOa5nSTXq0exiTrVXiHtw+RT0FHeRsefydQrOs6Z+g21FewnE0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006276; c=relaxed/simple;
	bh=1HKdvgSjsVzR1FXtVHA/CNuUoToRxY7qb6DhHcUdBqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1ZG+t2+GG1qxg0G9FRqhFARdIAgJ47UUvbp7HJ9K+2HAfnENNHazEdzd7dZhdbGCxsfPcl6Kt01d6N9cjtq+VNKKsPB5qA8qcwMp57Le25BKgDGyimfiz5Uad0Z4RO7EaX9lDZz3BaFTRWQSqSVSpw3uCO8KHZWUvPz70kEa6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hcob/gWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hcob/gWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F49B1F000FF;
	Thu, 10 Sep 2026 02:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006275;
	bh=pvUc8b+VhLTdK/H5BeywP0WHOVvRbbqj6k774jSNnTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hcob/gWkWkv/acNgqOmbXPZIj6xqt7XywjdHVYohFVAlufsU9f2D8oXgbrV2npose
	 3q1ez3CwY9/Y6tdbZRF/as80wRA42/hGmwb0Oq4jIGadnLEoN3EPoKNhFXJaiaYGGN
	 bfFTNvRcxtqhewXgCiT8xDeB+bjf2ih9Kk/HDPBg/8Pz23st56AumwcRh1uTL+tToV
	 /uA0wcy0Ti3UTXs342cODkVVEwoOWSMe2U9bajLryOQecszuszn5k/qTfcOS/EOZHC
	 6A2/sZ0/3AezPTaLoEComFdppOAgA96HIWhw/+63vupZEFY0B3Fl8JSsINSK6Z+12Q
	 LqCkW33QOKMnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] xhci: Cleanup Candence controller PCI device and vendor ID usage
Date: Wed,  9 Sep 2026 22:11:11 -0400
Message-ID: <20260910021113.3989344-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090844-colossal-stem-a83f@gregkh>
References: <2026090844-colossal-stem-a83f@gregkh>
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
index d5ba5a34625be..fde209ecac16d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -88,8 +88,7 @@
 #define PCI_DEVICE_ID_ASMEDIA_3042_XHCI			0x3042
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
 
-#define PCI_DEVICE_ID_CADENCE				0x17CD
-#define PCI_DEVICE_ID_CADENCE_SSP			0x0200
+#define PCI_DEVICE_ID_CDNS_SSP				0x0200
 
 static const char hcd_name[] = "xhci_hcd";
 
@@ -565,9 +564,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
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

