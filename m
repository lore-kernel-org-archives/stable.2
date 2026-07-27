Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071E400998;
	Mon, 27 Jul 2026 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158673; cv=none; b=UkTO28AgAJmQPiB4HpVurvbWQ15/zjKuPh8aQ5XH1aoCh+8/v9g3W4qicAMlkD8BSw4LEQp9JdDE+CooCAAyu/bjEAv5ZD5JueiFv6j3e154DzR+DneIEJwV5pIKjIB3/UjRHvZ3XnaZNs0DHVQ3ltQVakmsvxuRNyRDsKc30/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158673; c=relaxed/simple;
	bh=D6l4SE4h/BdOSJLfRuizvlFoB9TyaNHImLpHG9cxlO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTkWttugxWHmEyK5sf/2WBi3QbZhdr165dtDYkDf5eMk8yUaa1eyDrUq4G3oj+fsUx6tmrQUYWpV0/C8bYygkfw1lDrPcAcbeOoygh2krzfUOyfqmuQsrRMlpFaxeQc0OrcEyKc+cv+qvcTYlHxh6M7/X0mTMcA9lVzBVSfw4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef0NG7q5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef0NG7q5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CDE1F00A3D;
	Mon, 27 Jul 2026 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158671;
	bh=VOaEUPObH7+587ZqOrLk42/rFD2diU/xqNd56e97zJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ef0NG7q58b8nJENhoUBA93lzw4WnbsqiKD3z/J5HvpFRbxJCOYbuz2mzf1thvu1uG
	 ZNLXlhhmTb1EyvVxY+IL4OTAg7NmMJ/372+JywEdfhKJ7taR3WtYLRQQQN3uZJAfLU
	 P9W4nkDKx1DwXxwZerhtRFjZZyLh9R4eFEhTTgAZIslUNIVGJ+2IPhICo7eie4IHh/
	 Xv7sBL6PQE4hRqIeIq71HD0e3QY9g9rIZ6BzpfbFHa0tqGCMIWcnvh30I0lThCnW6Y
	 mCk886Q/DxkAhlinh/8cU3/MdmpPm9X9ytcLzfX0YXAoiV9V5FGU+hWhOV0kxhDloO
	 PtlIF080oPx6w==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 01/10] EDAC/altera: Fix NULL of_node dereference altr_edac_device_probe()
Date: Mon, 27 Jul 2026 08:24:07 -0500
Message-ID: <20260727132416.807230-2-dinguyen@kernel.org>
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

In altr_edac_device_probe() dereferenced pdev->dev.of_node and
of_match_node() before validating it, which could cause a NULL pointer
dereference when the device tree node is missing. Check the result for
a NULL and bail out with -ENODEV before using it.

Assisted-by: Cursor:claude-4.8-opus
Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Closes: https://sashiko.dev/#/patchset/20260719211238.589402-1-rosenp%40gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 68846f583eeef..d6ca68d74f78a 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -710,9 +710,18 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	struct resource *r;
 	int res = 0;
 	struct device_node *np = pdev->dev.of_node;
-	char *ecc_name = (char *)np->name;
+	const struct of_device_id *edac_dev_match;
+	char *ecc_name;
 	static int dev_instance;
 
+	if (!np) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to get device tree node\n");
+		return -ENODEV;
+	}
+
+	ecc_name = (char *)np->name;
+
 	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "Unable to open devm\n");
@@ -757,7 +766,14 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	}
 
 	/* Get driver specific data for this EDAC device */
-	drvdata->data = of_match_node(altr_edac_device_of_match, np)->data;
+	edac_dev_match = of_match_node(altr_edac_device_of_match, np);
+	if (!edac_dev_match) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "%s: Unable to match device\n", ecc_name);
+		res = -ENODEV;
+		goto fail1;
+	}
+	drvdata->data = edac_dev_match->data;
 
 	/* Check specific dependencies for the module */
 	if (drvdata->data->setup) {
-- 
2.42.0.411.g813d9a9188

