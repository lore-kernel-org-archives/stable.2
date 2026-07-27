Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE841A4F1;
	Mon, 27 Jul 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158678; cv=none; b=FfCX1qFvlt5VM+4tZ+BMy8MvDbeQynghoOZsTa2vGalcfhjRwlgohOPsytHfbHmiCBjvtwodGBOWMePWfNowi7e7GWkSNsX3biLCc2MX8RfpZNjc9/jijg94Uomm+JSriit33VPuBI9rdYT/vIUuL/oxwaaVmN9KMlHxFbjXJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158678; c=relaxed/simple;
	bh=Sx/FpO2qPLhV/nt//WVAS9yJZh/H2w91XUSr1AsRqbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Edw0GAxpy0pE7ZAhO8ATGFDMMp2EzZ2vl6JbpR89O+ronH1kA+Zu9MBuoQ9tmKB0ozUtuWGvdG2z5wyQSFvfv25hVeUVUm1lzKp8NYGkmxmMagSQxXBZ4/dxIBbP1nAzrXo4eXifz2seSmOmeGcFHfM4NIvkl2GXu55FkbA8eI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnRQfG+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnRQfG+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D569B1F00A3A;
	Mon, 27 Jul 2026 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158675;
	bh=C7wu8095LvIBsrR3QNvTMcL1FbE6M9cFqpSVX85qjwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BnRQfG+/xYoTrNDXExef+08fWBLE3LjbTxMcopE+FW/yq+GmHHBevEGONGaHZkYLn
	 TcqvhqDnKFlGzmnxjFNgmFhB+QjeMSXzDlG74MXdKyy7m2ZWHuZARJSZOn9UqYdGht
	 Hx4gdOAwGD3ph3MbrwuiswqOThtk12Vegd/nWL9sHxldCu3N/fzzpi3vAkQDJttUoE
	 aVVLAHdEYjOH7G/Ta4Z1Qha/glOmQl4VRwOnCu+vdiS1VNqtQBZ9ue7tcDue8Vf0LR
	 4OvFyK7HljRl5FxkL4dzgMOomnA3TZmST+Q/1rYWkMBtzzo4SyxLCC5BLCznOTXpgo
	 vBSjcw8KJF+ZQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 05/10] EDAC/altera: Fix code leak on dci allocation failure
Date: Mon, 27 Jul 2026 08:24:11 -0500
Message-ID: <20260727132416.807230-6-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260727132416.807230-1-dinguyen@kernel.org>
References: <20260727132416.807230-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko reports: If devres_open_group() fails, the function returns -ENOMEM
without freeing the dci structure allocated earlier with edac_device_alloc_ctl_info().

Free the dci structure if devres_open_group() fails.

Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e5d225f799f39..09e040b244673 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1554,8 +1554,10 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL)) {
+		edac_device_free_ctl_info(dci);
 		return -ENOMEM;
+	}
 
 	/* Update PortB specific values */
 	altdev->edac_dev_name = ecc_name;
-- 
2.42.0.411.g813d9a9188

