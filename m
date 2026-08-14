Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1D27AC45;
	Fri, 14 Aug 2026 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715365; cv=none; b=DKsLi4G8cXBIHLcr5+4jVxqdXNsDD75DICukdwLOrEvHKmxPi4Der3Efg4GMAYzYAw1gOMDiqjERxRnEKZrP/WGKpd9ZDOEpRrMPjuI2UJYIuh0k1f2e5Bvi1BXfeUSNZ/slLXU3dLnK/czG1iPT3CcZ6pLzgAGhlURHZAD1Qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715365; c=relaxed/simple;
	bh=oFElH+YkvnoQvpI/WsY/CwDmCtD8hcSGFr5q/2hL5YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBp0thjeZANDFxTql7zpnzZEhKYoY61hxW+ZtpvDhZjz9BmzmyjOB4/dQtLHrsCMygwsTqb5+qEJZ1Okvi6NMDlwvrjcJxAKuQ0T7tnIuYslmsRwgRlUziCjjA6W2EaddLE9pFRWL4pC++FhNFjUvogRnnxp6+y14at/RVeBIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8PsYGt+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8PsYGt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C611F000E9;
	Fri, 14 Aug 2026 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715357;
	bh=ossAc12bogg0WH+/AWrD3L5dUP83LQVGUPuyIcbrnwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B8PsYGt+zZ31HOQbWofCxi4GwsJCAyb0o8NjSjsm5nqedu1wcD14/XPN3crgUBC7n
	 dRnIisWycM75XRbLl6n2Q+ZtaUf5a4BTc+HDbvwDvb82I73iVFBuhkvzM03tOe3V3k
	 nKyODiBWELTjJP4WYocOnbSziVDUzkKo1jK339GZ6OlQaDuHJE0iJm9y8K95uVHhCG
	 tsQxOEYAKHBRupS7bxfd3ezfuXF2EJW/+pOuPdWCIlY9TQQMZIorOn2NGwk4KcLQCy
	 cM6kfNzhyb9+ikCzyhpIMYnYByGOVTSUHco6oNLAnYSmlemxXJXdBw3mcSEywjPKxm
	 C7WA171HqDE6w==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv3 4/4] EDAC/altera: Fix use-after-free in error paths
Date: Fri, 14 Aug 2026 08:48:54 -0500
Message-ID: <20260814134854.2397810-5-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260814134854.2397810-1-dinguyen@kernel.org>
References: <20260814134854.2397810-1-dinguyen@kernel.org>
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

