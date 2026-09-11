Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2745D92E;
	Fri, 11 Sep 2026 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128399; cv=none; b=DW8OO/6EZ3E+NAUzOobDPAHIbKYrMwOg2g5Gj46+8k9NAXGgHaklCWrzheivhU7wtbgjdGdpPb69iNYJ08J0JFoLzl/zzMFIntbWe8r77RFZmOrrka0dJA+tmGiqg1a/nl2WGwoxdP/5mLRyLusmGcS0CsI93jP74eyCrmiCwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128399; c=relaxed/simple;
	bh=ryKKO7OTETC8QH5cwxHp5tX6KpxhABa+DLB0H2vUuqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIZbfob4Z9LEQ89SOoa87G63WaPTGTUN5i+NPfM7RWRZgdoOMz0GD1AqVpuAF89InRqVEbqYpHm6Gk4alxKYGY9kdADG/CNffzASP9VvHCbvQLI/2L6Ata1/9obrQsWW1HOms4BwP1GbQYT2l2O9e46sJL0GTVpoj8uHn07FWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUuOUkFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUuOUkFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6971A1F0089B;
	Fri, 11 Sep 2026 12:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128397;
	bh=fcgNY5TKlHEn7fX6OLEcfCh1tO1NGblSwkQuHMNwqY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JUuOUkFhSB8BoyTvfEAeHn8yCAsugBdkYS3CJQhP2faY5F11gQ5UQhIWN2mXrT8vi
	 vTu6vRf0oTRpOkPlFXm2OoA+jTbHUnb+l8khJBgiGDMHp3RxUnxwc9cHahQrRCQvxo
	 icMaKi0p/kr6cqTJ8SSyDeXKtbPU46b0AYO7ApW/iUhXnWcxxpQiIm2jOItwWmCnWV
	 xwIFINFUfnYIkoMvi3Jx0vE5p8ZL6Ip1P8v1OqtedbZMp1tQKOihFKJhja62QTC13J
	 r1QLGYwDGo/0RaMuWv335Ljl+Z3Kl9Se/2cmjLFKSmt+vWCu8SYRHHRnobf9B5lZlH
	 4kRujskOQtIZQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	linux-edac@vger.kernel.org,
	rounakdas2025@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv5 4/4] EDAC/altera: Fix use-after-free in error paths
Date: Fri, 11 Sep 2026 07:06:27 -0500
Message-ID: <20260911120627.2634225-5-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260911120627.2634225-1-dinguyen@kernel.org>
References: <20260911120627.2634225-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In both altr_edac_a10_device_add() and altr_portb_setup(), the error path
freed the dci structure before releasing the devres group. Since the managed
single and double bit IRQ handlers use altdev(dci->pvt_info) as their data, an
IRQ firing between freeing dci and unregistering the IRQs could dereference
the freed memory.

Release the devres group first so the managed IRQs are unregistered
before the dci structure is freed.

Assisted-by: Cursor:claude-4.8-opus
Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
Fixes: 588cb03ea208 ("EDAC, altera: Add Arria10 L2 Cache ECC handling")
Closes: https://sashiko.dev/#/patchset/20260719211238.589402-1-rosenp%40gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v5: No changes
v4: rebased to edac-urgent
v3: No changes
v2: reworked v1 to include only true sashiko hits
---
 drivers/edac/altera_edac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index ccdfb35178b69..4c20fb9261608 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1593,8 +1593,13 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
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
@@ -1997,9 +2002,17 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
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

