Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9A560ADA;
	Wed,  9 Sep 2026 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959594; cv=none; b=eiHGVr2M9+UxajYeWoNzSwXPnk+lzZNZln3B6hmlWzw1lWHaAZuhG2DrvbhjfSlPJuDmZ4BUeQMT9aIfWCfDL2kjr9xViNKoGkbaQWjxoCdjTeBFSV0OsOjUtU5UgNmtbLf0aXqnaCdvGAvM7qOhGlEtBkLqFH6rrfD1a37p348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959594; c=relaxed/simple;
	bh=vdfy9W8DpRTIzGtNaxE8tSbHUeibs9uxNTU1sWMs7ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbAPBBa07nwQ/798WOmrWgt8Ygz2F+d5ORoeI0KusBQPYcHP+ndlwHsKhCVUMjLE5J6GTKL5feCRkOCdk2Y1KEoCvrckaUC87u8nyGCkPz4nMx5Dt1LkkFa3LbbE0AkMQkqhuCcLg0PRgUaYJGpXOHfHsJc8FwyQXJC81trLE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hblcrCH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hblcrCH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225361F00A3D;
	Wed,  9 Sep 2026 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788959592;
	bh=nXgz50FbWhpnvfTGySvPlnSPlStDRwK/0Rn8bC0H3lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hblcrCH9Mt8nGVJpJ+OQCzPMVu19eV+r6Yz2hkYYC9bkcKrjvG/V7T+0CnU4k4wD0
	 nFjFWNECuD7rkN6VvEVQ3GGYYM6zftlEuoSzBnqT0IoJ/06aItyxmUQttMM1ZkosCT
	 cadwTWIvWda4o7KV+m6bOtMmsrA1HwIlAbD/54e8m+wQ+AGqimq4urc9F/B9SPoePR
	 eP0rtXGHeb8KfPTflwJMlnsO9u0TC7WviojVy65Tqm5lt1xykpxvLG9AZFiz7IZMj0
	 3ZZnuUliyE01JX+2k1UhYnKcztrnwpPK8iptuufWJPPkwNnE38OP9COeJI696oRLEc
	 qW5V+u3ziC/mg==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv4 4/4] EDAC/altera: Fix use-after-free in error paths
Date: Wed,  9 Sep 2026 08:12:53 -0500
Message-ID: <20260909131253.2158486-5-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260909131253.2158486-1-dinguyen@kernel.org>
References: <20260909131253.2158486-1-dinguyen@kernel.org>
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
v4: rebased to edac-urgent
v3: No changes
v2: reworked v1 to include only true sashiko hits
---
 drivers/edac/altera_edac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 4b289b90186f9..6fc474ec3811d 100644
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

