Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4237411F89;
	Mon, 27 Jul 2026 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158674; cv=none; b=cLj0RADSVviv3CY5QbYpqKVDOYkWpbx/OsCuqlj0/wVih2NkADLMgnv/eTBYL5bM5Y7sv44exj91MGoZhT/PuL6wZ9GAD9HMr7JgSb/KMPPnmfLMDrFdPDonCaqA2qsVaa3EBiLi9h0s9KQRIR6zJ7A05zCpSOXtHgygKKAzdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158674; c=relaxed/simple;
	bh=t2kTv/kR/dZbFDxftonl+7PFbOY1M9VjHzN3j4KEJGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgLElMiuPQIMLGqR2SKd9zlsEkmdA0oaWjz7XzDSSjTxFGo223R6182UDI1YMq8dkoO6cDCQhZzGmpHhBoNHhvhYRsDJ2GrBzyARLi8o7G3oBrp+dolQ6/8+9dEvf+o5IyuLhIOTJ8rzuH2WU6OV461D7PdVV6pmsVpDlhBfzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIDJgy7o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIDJgy7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B1F1F00A3A;
	Mon, 27 Jul 2026 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158672;
	bh=tMeo0N1Z/XNfaNwyXFzrH6lovYFAMkOGtg4eyTGsMYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mIDJgy7o/QnG247VvggcvNB1HHnqoQJmR5r65H2JBYsbLw5vFs+zzzQYMGHF2OkCx
	 N/3/CHtzDDtthW80JoEI/31K1G0Cg6mckgbc88jscfUOgkqTNb8ph3kjThqlHB9wOt
	 pTBvIIm9YqePTx4GugbkTV5q2lk1XLctoSGiQwlnvJ9SioqdXs/ciE5iyNWoURw0B2
	 n4/9z4W1bIFMt3N96bLBBp5XKTJUeKGR7DM5FqWohgU0y5WryFWARf1nNleFtkHMuS
	 FBB6e/FkZSqGKIHagaGc+bdaZqqAAMMFGbL8KOayx4Kxa8bTYIdqMxnsHz2CIctNKO
	 CApTioahYTe6g==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 02/10] EDAC/altera: Fix use-after-free in error paths
Date: Mon, 27 Jul 2026 08:24:08 -0500
Message-ID: <20260727132416.807230-3-dinguyen@kernel.org>
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

In both altr_edac_a10_device_add() and altr_portb_setup(), the error path
freed dci before releasing the devres group. Since the managed SB/DB IRQ
handlers use altdev(dci->pvt_info) as their data, an IRQ firing between
freeing dci and unregistering the IRQs could dereference freed memory.

Release the devres group first so the managed IRQs are unregistered
before dci is freed.

Assisted-by: Cursor:claude-4.8-opus
Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
Fixes: 588cb03ea208 ("EDAC, altera: Add Arria10 L2 Cache ECC handling")
Closes: https://sashiko.dev/#/patchset/20260719211238.589402-1-rosenp%40gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d6ca68d74f78a..34b33298cf86e 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1625,8 +1625,13 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	return 0;
 
 err_release_group_1:
-	edac_device_free_ctl_info(dci);
+	/*
+	 * Release the devres group first so the managed IRQs are
+	 * unregistered before dci (which contains the IRQ handler's
+	 * data via dci->pvt_info) is freed, avoiding a use-after-free.
+	 */
 	devres_release_group(device->edac->dev, altr_portb_setup);
+	edac_device_free_ctl_info(dci);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
 	return rc;
@@ -2029,9 +2034,17 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	return 0;
 
 err_release_group1:
+	/*
+	 * Release the devres group first so the managed IRQs are
+	 * unregistered before dci (which contains the IRQ handler's
+	 * data via dci->pvt_info) is freed, avoiding a use-after-free.
+	 */
+	devres_release_group(edac->dev, NULL);
 	edac_device_free_ctl_info(dci);
+	goto err_print;
 err_release_group:
 	devres_release_group(edac->dev, NULL);
+err_print:
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
 
-- 
2.42.0.411.g813d9a9188

