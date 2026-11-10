Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331580;
	b=CsVWWh2OkYs4MOQmpZ0uAr/QMYtF4qLNAr/nsiGJ6BeR2ZJsul1snaAVVGjYwCc6uUGd
	 FFMkYauDJqUXJUTVPbBUxnNnW19F1L5omwWNgMb0NDPZO7TH7BX4R4pbWR+ZJPw01l3Je
	 b4RThLFK3PyZxb2mmqvYTuc/YcWBEj4b5wGj1B55ZcrRJ/nw7vWE0zNwFjwCS738G7ddx
	 DWGEU6ZCI+B9+cOxmVw+fLqSYlEwkGuDlGyDwsv5YCpETDBptCkfJ0UzoLurWlrjvFPyZ
	 DxI6vUUmVxjPOBKkX7MVfB9EFqqOZ/TnMjsrJhQu8TihVKwKpZbzGF3BraFUtlt+a6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331580;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zhhNtJokT9W73CXccQLnjdQAsheHkI9mQVmHviYF0i8=;
	b=pF2ikllAD0u6yXP6/ZJ29FeB6FRn73EHETTDLBfrA/nRq48qPSdeDgG/wsmgaglAXyat
	 6D/HTU24K2ReebpntHWOqy0TnGTcng4gHR8AuJUcwoN54mLH5QLAP5Y0auPiDIk7RXrkR
	 jcs8BzZQkhJB+rc03ZA3nvyv8PfozeDMmhVP0cHeaReO2e+4OlhI60fSOqh6HwPnDr8hK
	 ZplubN01Wz5Ss/jnJ+YDbW4KR7OA0i30oauGTlzUPyz3mGbu6vF3krD8arTX4+VLSrVhV
	 K6taxvFPJQ1y/2ajTLy1EpAOof1tJwHH64U/GPCq9rbZhNacMpLGSIun201keh/LQfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7jYrfHt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7jYrfHt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAC11F0089F;
	Tue, 10 Nov 2026 17:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331579;
	bh=zhhNtJokT9W73CXccQLnjdQAsheHkI9mQVmHviYF0i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l7jYrfHtGUtz6KhbR+PDxxuciJVUOh057j5aqskU8leW2BzKwnzZLbQXntbBXR8dl
	 zx/vQjUGKJnmNG2annmZs4Q5LwhWjXZYjA0Ko5rMvyE/yQUvjkNw48wC2g7vqlC8+F
	 8X4c4YV5EaMeZvN3QAKEG6gTArbdkZOqmkp8cRrwATyTr1NofexneYlfdoPL8SBJ3Q
	 Ns0eqPp7NRACBw8qInNIipOJMZNtSxRMpEcChCn5q8pTvoRn7Pq6+KUstg9iOKHSvr
	 C9mDmKP0dKdZcUvacu13B2NSxTRZwAAkUOr3kPWFoAhTLtWsIzqkWC8gGdWTxJj7qA
	 DIs/4nSyHctPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] fbdev: nvidia: Convert to managed PCI and ioremap API
Date: Tue, 10 Nov 2026 12:26:16 -0500
Message-ID: <20261110172609.2854755-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051049-failed-6.18-8710af6a3520@kernel.org>
References: <20261107051049-failed-6.18-8710af6a3520@kernel.org>
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
index c9dcc9e899487..f917d569bdbd5 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1289,7 +1289,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	NVTRACE_ENTER();
 	assert(pd != NULL);
 
-	if (pci_enable_device(pd)) {
+	if (pcim_enable_device(pd)) {
 		printk(KERN_ERR PFX "cannot enable PCI device\n");
 		return -ENODEV;
 	}
@@ -1302,7 +1302,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	nvidiafb_fix.mmio_start = pci_resource_start(pd, 0);
 	nvidiafb_fix.mmio_len = pci_resource_len(pd, 0);
 
-	REGS = ioremap(nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
+	REGS = devm_ioremap(&pd->dev, nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
 	if (!REGS) {
 		printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
 		return -ENODEV;
@@ -1330,7 +1330,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	if (info->pixmap.addr == NULL)
 		goto err_out_kfree;
 
-	if (pci_request_regions(pd, "nvidiafb")) {
+	if (pcim_request_all_regions(pd, "nvidiafb")) {
 		printk(KERN_ERR PFX "cannot request PCI regions\n");
 		goto err_out_enable;
 	}
@@ -1355,7 +1355,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
 
 	if (NVCommonSetup(info))
-		goto err_out_free_base0;
+		goto err_out_enable;
 
 	par->FbAddress = nvidiafb_fix.smem_start;
 	par->FbMapSize = par->RamAmountKBytes * 1024;
@@ -1375,8 +1375,8 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
 	par->CursorStart = par->FbUsableSize + (32 * 1024);
 
-	info->screen_base = ioremap_wc(nvidiafb_fix.smem_start,
-				       par->FbMapSize);
+	info->screen_base = devm_ioremap_wc(&pd->dev, nvidiafb_fix.smem_start,
+					    par->FbMapSize);
 	info->screen_size = par->FbUsableSize;
 	nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
 
@@ -1420,19 +1420,15 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
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
 
@@ -1447,11 +1443,8 @@ static void nvidiafb_remove(struct pci_dev *pd)
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

