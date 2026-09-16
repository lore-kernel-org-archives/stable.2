Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D541F345
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590803; cv=none; b=q1NpEIiWo9xFs3qeRqXzaGRYlwJVpfyzrDrad69VenLVJwMvGA6IIP/T8dgi7fqNMW+w5lBZTKuSfzAz8+6XL9F6hoXkrdsWmQcV1FLuoO/vH4+crbXVMhqWE+vT+wjdrqtmaRMh32tAnN/J6So5tCE6smGClyYGMiD59yMzFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590803; c=relaxed/simple;
	bh=xSfkzwoyq8KAI+AUDmINK5SfiXqijGQCrmr00/9qWGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUDhHiKQ/oRtbUBHytSVzGAW4lgaLJ31DHFvmlZa0bIOaXT7Z1MpzMht29xibiTdBCd6sl5HCIb+JyYkFIweztB94otFxLuAMMQkhZ37Gbm+1YK5lOzqLdjloODkg9iJZv20qH7CURRkifeufNriOl7a47w1IzsFkZkg615bihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2bXq8XF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2bXq8XF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274FB1F00898;
	Wed, 16 Sep 2026 20:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789590777;
	bh=I3zpdp5X47/K/mzTh+0IY6Rw8+F8G+2iwxDottI8ZLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F2bXq8XFsZxB6jOxzmxWRsLfMig8HAkhkmrBasYHHTVGOFeN023EWDlsfbJJbUE8C
	 qWtQrfQD64V6TYVKwVVIl6Gd2nXWuAbsDAgoV+4B7d0d90do6iGJqvl7Ql/dSy3kcQ
	 VOPWt6e2ak89N3NjWLetElAC75uMvxIBrNzQ6LRiBs6xgNIM5jWBZ3qvc2HTYS0L+7
	 DPLZY9Ei2kpGWxmr7fw/A/b0HaJeFY9hwU5aQ2l1Y6U1wsfaVd3YYkyxUX5fXeVmCH
	 b7k5ISgBuGPofw6Z8+0XD+GqnGJ7kHfkX0QSfRdQwvVIqe/aTOv4DdLBuswUaOLI6d
	 DoTJLALZqbCzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] EDAC/altera: Use parent device for devres in altr_portb_setup()
Date: Wed, 16 Sep 2026 16:32:54 -0400
Message-ID: <20260916203254.2573996-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203254.2573996-1-sashal@kernel.org>
References: <2026091624-rethink-safeness-e66f@gregkh>
 <20260916203254.2573996-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dinh Nguyen <dinguyen@kernel.org>

[ Upstream commit 9868f5c077dfe0b606331f2e782484f91a5789a5 ]

Anchor the devres group and the devm-managed IRQ requests in altr_portb_setup()
to the actual parent device (device->edac->dev) instead of the embedded struct
device inside the copied per-port altr_edac_device_dev.

This keeps devres_open_group(), devm_request_irq(), devres_remove_group() and
devres_release_group() all referring to the same long-lived device so the
group and the resources allocated inside it are torn down together.

Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
Closes: https://sashiko.dev/#/patchset/20260503212558.2811480-1-dbgh9129%40gmail.com
Assisted-by: LLM
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260617164303.585555-1-dinguyen@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/altera_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8feef22629d92..3eaeb095a8032 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1497,7 +1497,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(&altdev->ddev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* Update PortB specific values */
@@ -1525,7 +1525,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		rc = -ENODEV;
 		goto err_release_group_1;
 	}
-	rc = devm_request_irq(&altdev->ddev, altdev->sb_irq,
+	rc = devm_request_irq(device->edac->dev, altdev->sb_irq,
 			      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 			      ecc_name, altdev);
 	if (rc) {
@@ -1547,7 +1547,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 			rc = -ENODEV;
 			goto err_release_group_1;
 		}
-		rc = devm_request_irq(&altdev->ddev, altdev->db_irq,
+		rc = devm_request_irq(device->edac->dev, altdev->db_irq,
 				      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 				      ecc_name, altdev);
 		if (rc) {
@@ -1567,13 +1567,13 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 
 	list_add(&altdev->next, &altdev->edac->a10_ecc_devices);
 
-	devres_remove_group(&altdev->ddev, altr_portb_setup);
+	devres_remove_group(device->edac->dev, altr_portb_setup);
 
 	return 0;
 
 err_release_group_1:
 	edac_device_free_ctl_info(dci);
-	devres_release_group(&altdev->ddev, altr_portb_setup);
+	devres_release_group(device->edac->dev, altr_portb_setup);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
 	return rc;
-- 
2.53.0

