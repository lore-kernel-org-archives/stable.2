Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3133C1D7C;
	Fri, 28 Aug 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902469; cv=none; b=Szw+HJrOQRAFK/LVtZQ2Wh3hKv7s/PdiDf5z4aIGinm9bd56lQwVMGGyxXeIjchUSOZnyTazM2iPbdnWnqutElHcmJfPo8In8nwycOxEvniHSZW5mOoKLoQZUP3SiM29LePZYqnONumkbQJOrMhDLFCkvQKiiTYLS+q+PA8e0SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902469; c=relaxed/simple;
	bh=W5D3O+R9VURSSgSzCJKhXBOgALY1Sf/WRIMArY72PwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4FYOx+iWRxkmSTYxLqXmz4lJSzmaJINARoYZ8FM4YeQ0Dk07C9tbFOzpacwklGpAW34tgSUNnXomGPGai+tLjCxxvMERjbaqxoMwsnxsDDlcFMdRDSJkrvRjA16VqVNtrbARRlTl2vbXg2Fxu9VWzgF5fh7Y/AtYHoN3w0Rs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=nTKPEt/g; arc=none smtp.client-ip=195.10.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="nTKPEt/g"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hWVMD18qVzLlr8;
	Fri, 28 Aug 2026 09:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1787902024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uu2quDv9BXIJXVAu8nYVgirdDkUUo0uu4AfJYmAk8Io=;
	b=nTKPEt/gXykPqT7gsEUv856eL0gw7J+sfgcroVjAb40gPzJr1OuG6pS7EmL3NxhIY1p7jA
	3CpQGTZuzzVQ9UMp5gfV4/ubCOisaxjQdslUaZwH9FCnKvX74RRtNgbox3VNcXoDLn2o9s
	8TmAUg49Tb1FWrPaI+1jZzb5+6NGCEEOIZq1wmW1UgOqd2M5tO294GjUYSg3e17wU81qbP
	IBhO8wAqBhcq2ZCO8czmdTnGzpKE9l3nUIke1e7q7/Izf135pjkA8N34VPUy/20/lfd7ii
	7ZfbwnAYdn7sXci1sx70CMAHwYCy31ODbG3Prqd8n579IaaUEqunueuZ7o4n0w==
From: Ralf Lici <ralf@mandelbit.com>
To: stable@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 6.1.y] Revert "usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal"
Date: Fri, 28 Aug 2026 09:26:45 +0200
Message-ID: <de6cc86708372c418d670cf8ec4d5929538c3417.1787901520.git.ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4476c73bbbb09b13a962176fca934b32d3954a2e.

The reverted commit uses disable_delayed_work_sync, which was introduced
by commit 86898fa6b8cd ("workqueue: Implement disable/enable for
(delayed) work items") in v6.10. The function is therefore unavailable
in 6.1.y, causing configurations that enable CONFIG_FSL_USB2_OTG to fail
to build.

The upstream commit is unaffected; only its incompatible stable backport
is being reverted.

Fixes: 4476c73bbbb0 ("usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal")
Link: https://lore.kernel.org/stable/20260827154302.706689-1-ralf@mandelbit.com/
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/usb/phy/phy-fsl-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index ab4df5819ef8..972704262b02 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -987,7 +987,6 @@ static int fsl_otg_remove(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
-	disable_delayed_work_sync(&fsl_otg_dev->otg_event);
 	usb_remove_phy(&fsl_otg_dev->phy);
 	free_irq(fsl_otg_dev->irq, fsl_otg_dev);
 

base-commit: d64a499eea6b62b5121beceed9e8a1f57b00d863
-- 
2.55.0

