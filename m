Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541D41B8EE;
	Mon, 27 Jul 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158681; cv=none; b=cSfu5v2hV/VMM47hjJyxtxc0dblZ3FX5/e4u28unpW3EKakxvVnG1cLFc8b+HKLiCz8nj0vBuTEl9IlF0lSsYPWaMvKTsLM/EPjGSkXp/HZrUDEwVdkSnLMkCJZ0Uu7vX5w0JQ/SnQ9nr+lJRKgtlRIosSzIjrhj2cK5J2DKvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158681; c=relaxed/simple;
	bh=T+HZh0Mo9Eq87bAXNsVNuY2efEq9dh/IIMkRd95SviY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa8cSpgO36sJ3FdZlOoPHnsCM3zpq55boP0fqD1yU+o/PZxDcfHJNmbwSbRfWZm9GzdZ51c0wJ3nA6BRZYNGXsRgPceCvgY5GBBje02a9B0aboWPaLrIIfaPOeGi4XyXgCFcXPoS5DWrLLzkiiH1EXcCwDpWy+MdvlPri4d/el8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcZ1IO0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcZ1IO0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D5B1F00A3D;
	Mon, 27 Jul 2026 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158680;
	bh=MZPvTQ3xWeQwfWztOZduPA5Y4NXz4y8TQXqkhPpdG+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dcZ1IO0IGeFRccCR3+DZqIOJmoxt6A0BVIs/qahCfqmXcNyvxyvUzPuxzFErbBpPD
	 4nckW7jdDF6Xba6xXrn63kglE9WHMPkSguY1cBA4DyGz5IDzThnJk9mXd9+qG0WC/q
	 TF/V0dqsQRxChTgGiTrsff6Y828+2QCCe9HUiy9//7R9HdDXve3i/kRLJmcrZeRd63
	 HVuxXau0qyUlg9bPAAoJ2Wi5OnlsEDidkOz1nwUHaIVSW//gao73PVG2AVxVkxe5gn
	 XfDNNnwi2OujObI6k7MS4ELOmloqT1BYkTyxcB/Eh66uvGiChAskoS5NJVQ0QbTKWx
	 G46kiwLTw7YNQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 10/10] EDAC/altera: Fix error cleanup path in altr_edac_device_probe()
Date: Mon, 27 Jul 2026 08:24:16 -0500
Message-ID: <20260727132416.807230-11-dinguyen@kernel.org>
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

sashiko reports: Does the error cleanup path in
altr_edac_device_probe() free data before unregistering the interrupt
handler? If a failure occurs, dci is explicitly freed via
edac_device_free_ctl_info(dci) before the managed IRQ handler is unregistered
via devres_release_group(). If an interrupt fires in this window, could it
dereference the freed dci?

Clean up the fail1 path to always call devres_release_group() and
conditionally free the dci.

Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 80ca9f511ac98..b6048a1884f43 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -701,7 +701,7 @@ MODULE_DEVICE_TABLE(of, altr_edac_device_of_match);
  */
 static int altr_edac_device_probe(struct platform_device *pdev)
 {
-	struct edac_device_ctl_info *dci;
+	struct edac_device_ctl_info *dci = NULL;
 	struct altr_edac_device_dev *drvdata;
 	struct resource *r;
 	int res = 0;
@@ -729,7 +729,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "Unable to get mem resource\n");
 		res = -ENODEV;
-		goto fail;
+		goto fail1;
 	}
 
 	if (!devm_request_mem_region(&pdev->dev, r->start, resource_size(r),
@@ -737,7 +737,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "%s:Error requesting mem region\n", ecc_name);
 		res = -EBUSY;
-		goto fail;
+		goto fail1;
 	}
 
 	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), ecc_name,
@@ -747,7 +747,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "%s: Unable to allocate EDAC device\n", ecc_name);
 		res = -ENOMEM;
-		goto fail;
+		goto fail1;
 	}
 
 	drvdata = dci->pvt_info;
@@ -806,9 +806,9 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	return 0;
 
 fail1:
-	edac_device_free_ctl_info(dci);
-fail:
 	devres_release_group(&pdev->dev, NULL);
+	if (dci)
+		edac_device_free_ctl_info(dci);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, res);
 
-- 
2.42.0.411.g813d9a9188

