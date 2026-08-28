Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB71348C66;
	Fri, 28 Aug 2026 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902446; cv=none; b=mttSwgW/a2hHoMTsWcEuA3M3jEMPM7r1+U7vbaIA35/5Ud9c2n488BvM5HpJhCalKi/DUKkuIzLhO5OGzbgcBsAQEg3XyKjUcr9Tvb5AvL3/eYFx33utCRDr7OG0HGUZaCTMyEsWrVMc9DP4FhhB+Wgct4dZurlovsum0MVe95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902446; c=relaxed/simple;
	bh=t+tiAOGT0OvohOIDQAsWh4svMsXwwz3aYaSwU8y4XJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruaLdx3uY4yCg9/qSye13CfICF73uTMqmgUMVQsNGCHTeI7d/gBVicD8cVBXKkn4ISdN8PNA50ubc0FaAaIZ1vdNlomg2Fs7EiBSmngT/XqxtlZL2GDye+FxgbcGHe1lxF1xNuI6f+Ks437ukgtG2+/vj/MLZqH3oy3Sw45sMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=yNS5dyAB; arc=none smtp.client-ip=195.10.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="yNS5dyAB"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4hWVMw6C0yzJF;
	Fri, 28 Aug 2026 09:27:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1787902060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wp8Cfi0TykYT6FODsDy0pOVzbapztWfE+Fg8egS0CPY=;
	b=yNS5dyAByIsjlxBeOsUbRNFbYm4Uoq+VfB6pjKhIVzgvMVAbjUD5dq1V5m4NiJvtonwknH
	gbqgbW9bn7dWghveeHVd0KYjBDlnvcg3d6RjWwr5eeU3QlVBBUBdNJIn/RC22SKmmVgfaN
	Q9kp4plCBY1eyon/alJUS9jVG9/dWi1Ly+sCg94XgesPWfcwV9yIRKypLGWwMAI9LrTrub
	iRfh8v+YV6GsqR7gn6+rVdrmE6TkaBmAw/7Hl/y1bazLhiYhisZmt69boKlgrq/4pSM4qe
	0fXvyvhL7MBexxYYXM/gTqYsHm6JBDtZS6LgrmhEs/CnuexKA/nL4GmX9oFBag==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: stable@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 6.6.y] Revert "usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal"
Date: Fri, 28 Aug 2026 09:27:27 +0200
Message-ID: <32dc704af59ce1a137f076a1bdec4f2aa0034463.1787901681.git.ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4hWVMw6C0yzJF

This reverts commit 319f7a85b3c4e34ac2fe083eb146fe129a556317.

The reverted commit uses disable_delayed_work_sync, which was introduced
by commit 86898fa6b8cd ("workqueue: Implement disable/enable for
(delayed) work items") in v6.10. The function is therefore unavailable
in 6.6.y, causing configurations that enable CONFIG_FSL_USB2_OTG to fail
to build.

The upstream commit is unaffected; only its incompatible stable backport
is being reverted.

Fixes: 319f7a85b3c4 ("usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal")
Link: https://lore.kernel.org/stable/20260827154302.706689-1-ralf@mandelbit.com/
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/usb/phy/phy-fsl-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index 552899fa985e..79617bb0a70e 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -987,7 +987,6 @@ static void fsl_otg_remove(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
-	disable_delayed_work_sync(&fsl_otg_dev->otg_event);
 	usb_remove_phy(&fsl_otg_dev->phy);
 	free_irq(fsl_otg_dev->irq, fsl_otg_dev);
 

base-commit: a4a971135a2ff64382ae4235b3ae60503bb1036a
-- 
2.55.0

