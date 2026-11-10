Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331970;
	b=48ibIOu3DBjTvaWg6W6qGvI+VLbV7Wl+sKynKn3BAprtsLY77yFL3y2HmoyiB89j/HiG
	 4+oi6RnK9ae8b+WK0wbS2g0MpzBXi6uaNKexcgr8LEBnodOuzvJ5vy6wrZjVGboFrzut2
	 n4f1EKtIQJnMI5GgJZ38OSoCMggkpkZJN1hqJ53p+7h+ZA3j7dcGecFYUF9v2fUz/ot3s
	 My6+ozwsdeQPwTu570t6LOoRsEF67kbLBC5eXRkUqYBorEAZKp1ndbWJGViUe+zEOQOG7
	 b1HjJmiCfuZ1KKUUwKuZaPRy3g4YN9BShN761GiiL20rpmWdnFnDjNC2pkO+A/tFFmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4MoXJWRxPjLOf8TcjeoGJYtu99ZkOFUZPfw4J5SgBKA=;
	b=HZRii4oO67U0bs/fxEaNQ85Eo4oaDePNvVNb2xbmfCtY1ZkeSon1KiRVJWnRwjz/5D9j
	 5qFBbv/vnSCAUjIFCAgTdXlIQzN53VrFxvSmD1Xai5vxKhTQauRjOJvlX20PjTsDddrEb
	 ZTiPENWbAZluHtwwki2BJ+sREenO0YEtqN3BsXY7h7TJgFA9ztsxuK+gcqkMVuGOEd9PZ
	 3tokpF++Y8K3rP7IGnQdtxEEj/XJR4SJuXlQzTvLBGKtC0xIfskyvtOS0h6kr+OQq/FtV
	 n1dYerO9bDVOeGulP4Re+SEFyMqa0SqkWeTAfJPkUgvYgib6GYL9GjaVDFXSgkg60qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDB3TgI+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F8606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDB3TgI+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4551F008A1;
	Tue, 10 Nov 2026 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331970;
	bh=4MoXJWRxPjLOf8TcjeoGJYtu99ZkOFUZPfw4J5SgBKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDB3TgI+Mh36oS+2tqSm8yzbB4+CcaCcv9+2pS8/U5mgcLiwMAwSg3/AN0XTuIlzn
	 GZ2/iC6LsufHqerroQrza58ZQYTqGwNPDlz/rSRhLXmhgczFtUvVQ0JaU/tZj4R6eV
	 roDTKnIGIMweeInbk+kIy4WBUY42jYIJpEr3+yaFsMbPjNWk+2hcjKPqFqpTN3myoF
	 RGVlTz3BA1PNHEbmdyOWA5U/O4ktZxemGqLMiXPRjuZ/+kgdlXMda3nbeYL9Wq4KoF
	 FR4r1OVxA1AATa/B7jTK0CzUYl6KfBBYv5D4p6COgIAbZE0WTwgF0NQ7HIw5xT/rl2
	 sLAf1MDQf8i+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] fbdev: nvidia: Convert to managed PCI and ioremap API
Date: Tue, 10 Nov 2026 12:32:47 -0500
Message-ID: <20261110173235.2968169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052149-failed-6.12-8710af6a3520@kernel.org>
References: <20261107052149-failed-6.12-8710af6a3520@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shixiong Ou <oushixiong@kylinos.cn>

[ Upstream commit a41961f364bc7aee1611796e7ab5bd687708d770 ]

Fix missing pci_disable_device() in probe and remove.

Use pcim_enable_device(), pcim_request_all_regions(),
devm_ioremap() and devm_ioremap_wc() to replace manual resource
management. Remove all pci_release_regions() and iounmap() calls.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
Stable-dep-of: 8710af6a3520 ("fbdev: nvidia: Release write-combining handle on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/nvidia/nvidia.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 5f61d953e4c76..d298ba71ee0e3 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1288,7 +1288,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	NVTRACE_ENTER();
 	assert(pd != NULL);
 
-	if (pci_enable_device(pd)) {
+	if (pcim_enable_device(pd)) {
 		printk(KERN_ERR PFX "cannot enable PCI device\n");
 		return -ENODEV;
 	}
@@ -1301,7 +1301,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	nvidiafb_fix.mmio_start = pci_resource_start(pd, 0);
 	nvidiafb_fix.mmio_len = pci_resource_len(pd, 0);
 
-	REGS = ioremap(nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
+	REGS = devm_ioremap(&pd->dev, nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
 	if (!REGS) {
 		printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
 		return -ENODEV;
@@ -1329,7 +1329,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	if (info->pixmap.addr == NULL)
 		goto err_out_kfree;
 
-	if (pci_request_regions(pd, "nvidiafb")) {
+	if (pcim_request_all_regions(pd, "nvidiafb")) {
 		printk(KERN_ERR PFX "cannot request PCI regions\n");
 		goto err_out_enable;
 	}
@@ -1354,7 +1354,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
 
 	if (NVCommonSetup(info))
-		goto err_out_free_base0;
+		goto err_out_enable;
 
 	par->FbAddress = nvidiafb_fix.smem_start;
 	par->FbMapSize = par->RamAmountKBytes * 1024;
@@ -1374,8 +1374,8 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
 	par->CursorStart = par->FbUsableSize + (32 * 1024);
 
-	info->screen_base = ioremap_wc(nvidiafb_fix.smem_start,
-				       par->FbMapSize);
+	info->screen_base = devm_ioremap_wc(&pd->dev, nvidiafb_fix.smem_start,
+					    par->FbMapSize);
 	info->screen_size = par->FbUsableSize;
 	nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
 
@@ -1419,19 +1419,15 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
-	iounmap(info->screen_base);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);
-err_out_free_base0:
-	pci_release_regions(pd);
 err_out_enable:
 	kfree(info->pixmap.addr);
 err_out_kfree:
 	framebuffer_release(info);
 err_out:
-	iounmap(REGS);
 	return -ENODEV;
 }
 
@@ -1446,11 +1442,8 @@ static void nvidiafb_remove(struct pci_dev *pd)
 	unregister_framebuffer(info);
 
 	arch_phys_wc_del(par->wc_cookie);
-	iounmap(info->screen_base);
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);
-	iounmap(par->REGS);
-	pci_release_regions(pd);
 	kfree(info->pixmap.addr);
 	framebuffer_release(info);
 	NVTRACE_LEAVE();
-- 
2.53.0

