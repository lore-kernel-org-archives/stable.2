Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68E3793A2;
	Fri, 24 Jul 2026 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870942; cv=none; b=BlNDvETP/y1HfV/3MO8z7THcEMkX/Rkq2IGOMa5w+nspemWt7qNeAkkR3rP6sl1snp9V9QhhrmsA/ZTHOGuCHllGoFf3uF/wcZLHYbc+5s1EyaqdZzzoLqdW6B896LjRV5Fz0AvZTS2q1drS71KJNJKuoI/mVcl/7wygPzjPbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870942; c=relaxed/simple;
	bh=b0duXdXgYd99c3OOklMLakLWBcCVIfMdCNoL9ZH3seo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5ACzV31yYhSlvQqZJn0SX5HcPbHLLvjUdmeIQ1myDtCOvrEu8OQZ5g/EBBIyzOAhahGu4vKixRMw2V9hqveW27NgHrxU7/YEsq81JCky2SbCi5dlEBUDZKEWarbnyUg88RbxvQTh58OcLXmzF+Q5djLx8FxPw4t0Dhzyny7Ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Kbc6/yfa; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Kbc6/yfa"
Received: from LAPTOP-99KJFSET (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47691a1b4;
	Fri, 24 Jul 2026 13:28:47 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	arnd@arndb.de
Cc: linusw@kernel.org,
	brgl@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	getshell@seu.edu.cn
Subject: [RFC PATCH 6.6.y 1/4] misc: ti-st: publish the transport only after probe succeeds
Date: Fri, 24 Jul 2026 13:28:39 +0800
Message-ID: <20260724052842.1052-2-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260724052842.1052-1-getshell@seu.edu.cn>
References: <20260724052842.1052-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f9298fba403a1kunm7e8f9dea2445d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQkpOVh5PSEJMQhhOGEJPS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=Kbc6/yfabJyf/03rYPQYNY0UIWXW3QZatn1worIhdRoiW7yPRYdqfkehkSSAxL1C9g84ipJ1aiIuju1WBp/OW1LihqCyXOubPXycyecxq/Rn6VNDt+RW1GBDMsdPkWniCJPLdh6Lx5bHR/gQEVTjxTYpHmAbdpHCASvtyu9G3C8=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=XcpAFmWCemUPFvXUcajXloVAt1chJRe4T7S+wG8nQ+I=;
	h=date:mime-version:subject:message-id:from;

kim_probe() stores the platform device in st_kim_devices[] before the
transport core and the remaining resources are initialized.  If a later
probe step fails, st_kim_ref() can follow that published device to freed
driver data.

Publish the device only after probe has completed, and clear drvdata when
rolling probe back.

Fixes: 53618cc1e51e ("Staging: sources for ST core")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/misc/ti-st/st_kim.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index fe682e0..ec265a6 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -699,15 +699,7 @@ static int kim_probe(struct platform_device *pdev)
 {
 	struct kim_data_s	*kim_gdata;
 	struct ti_st_plat_data	*pdata = pdev->dev.platform_data;
-	int err;
-
-	if ((pdev->id != -1) && (pdev->id < MAX_ST_DEVICES)) {
-		/* multiple devices could exist */
-		st_kim_devices[pdev->id] = pdev;
-	} else {
-		/* platform's sure about existence of 1 device */
-		st_kim_devices[0] = pdev;
-	}
+	int err, id = 0;
 
 	kim_gdata = kzalloc(sizeof(struct kim_data_s), GFP_KERNEL);
 	if (!kim_gdata) {
@@ -762,12 +754,16 @@ static int kim_probe(struct platform_device *pdev)
 				kim_gdata, &version_fops);
 	debugfs_create_file("protocols", S_IRUGO, kim_debugfs_dir,
 				kim_gdata, &list_fops);
+	if (pdev->id >= 0 && pdev->id < MAX_ST_DEVICES)
+		id = pdev->id;
+	st_kim_devices[id] = pdev;
 	return 0;
 
 err_sysfs_group:
 	st_core_exit(kim_gdata->core_data);
 
 err_core_init:
+	platform_set_drvdata(pdev, NULL);
 	kfree(kim_gdata);
 
 	return err;
-- 
2.50.1.windows.1

