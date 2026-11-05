Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.188.205.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881271;
	b=P93v07Gm+ZW/e8pDBhtr/3O2wk76khovBe5EkwG24YKB1Lx5Hvh1bJLlXBwscs+RJrwM
	 qAX7JJ7q7arlG0YaKrLEzU+ny8SbaNbwSX6ObqTWvk20IF6XQowH1brmxr5LOmjwLTPFN
	 un3gKdK6FZOrwjNnTXu8TTCl51icmF1L0kB4rAb08khoI1WHMjWsFm3uXWWcHxbag0eey
	 rXpu+2Dkn9XJ3YK6USbiVyQIBDsbT8KpuLqurdzaeuSxxFC3/Rw6tBlVcHjRnTOJxSxTT
	 KSYLX0gcPHOVpTprFBsyY3JD0a5LdJkvtnukoJRsYDLrRjM1kAzWCoBjmsn0JawKw9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881271;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=6dYhO8Ky0PMDHBhpJpa0aDR10YKmdIlw5QfpREoKqHQ=;
	b=or81Hz8iJ1Y43x00GpejASafyWKqKhwuzKrQGjobpuXg80af9D/F0RYfCXX84i82BWDo
	 bPU9bQ3j7ceLm+uUsXmEVLjACz1yrpVLGCDi0orxNbf5FpDkzt1RDBUH6jOGVsvn2T6BU
	 yRo4kEFBVMqOSo0kgaSINCOdL5GmmY+kmo+o+t5opw3OW8pt90W5sgWwW2RCBpK1LGR9O
	 sDE4WG7M4uWJnmLy/vjsdIp+MV2i8ZcsU3FOnR8ZBgsxmYx3V280j6uIQB1aYEJE2HY5k
	 nGcJc+8CMi+4v5cNSHPdzvVGuJLfFwdrdSP/7ZPnfbPC0fhv6a6V+09EpiSHBZfRVUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=ANgMETgX;
	arc=none smtp.remote-ip=93.188.205.243
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF35C606A32D;
	Thu,  5 Nov 2026 12:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF35C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=ANgMETgX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793881268;
	bh=gRZCO5Xqjrey14xqpvfE7i/WH3G43qfphgmpatW52f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANgMETgXyLNpnT840VQ4+VDdhEK1qR77Oy9I1h6w3GxSmUnMNTnG49b7coEAmMaQz
	 ii2OPgmz3txMzZSs8XI8MDOohhfUTSMg7bYqXi3f1Gd6cmzXAZDzUaio5mx+a2hcgJ
	 PkFrI2m1alcTKalfEnX2LgXHiD31aSjEtWoStK1qNvb+WA4p1SVo6wSxQ4AearwsC3
	 j64iISx5VXf7kAG2lIwcPQB/hVpahDO7EJyk20aRygZ+oc/FSNnd29mrGXQfqBK13r
	 893SpoCAj0o0Lx5kOOtRb6bmoV9Sfus496GSKPqLKRHt1tLkA2AeNgLjVyL2hDYAcl
	 HEE/UwAnoW2+A==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 24F751F406;
	Thu,  5 Nov 2026 15:21:08 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu,  5 Nov 2026 15:21:06 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.238])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jL1cf0vrMz2GXT;
	Thu, 05 Nov 2026 15:21:06 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Koichiro Den <den@valinux.co.jp>,
	Leon Romanovsky <leonro@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15 2/3] NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
Date: Thu,  5 Nov 2026 15:20:32 +0300
Message-ID: <20261105122035.2021-3-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20261105122035.2021-1-mdmitrichenko@astralinux.ru>
References: <20261105122035.2021-1-mdmitrichenko@astralinux.ru>
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/05 10:44:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, patch.msgid.link:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207265 [Nov 05 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/05 10:48:00 #28800686
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/05 10:44:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Koichiro Den <den@valinux.co.jp>

commit 852b94ff92cbe26a0dbb15eed9474f5493767f3b upstream.

ntb_transport currently uses ndev->pdev->dev for coherent allocations
and frees.

Switch the coherent buffer allocation/free paths to use
ntb_get_dma_dev(), so ntb_transport can work with NTB implementations
where the NTB PCI function is not the right device to use for DMA
mappings.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260306031443.1911860-3-den@valinux.co.jp
Stable-dep-of: da6d997ac556 ("ntb: Store original DMA address for future release")
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Prerequisite for the CVE-2026-80884 fix.

 drivers/ntb/ntb_transport.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 94a8e294b7f21..2fca53b8e486d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -793,13 +793,13 @@ static void ntb_transport_msi_desc_changed(void *data)
 static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
 
 	if (!mw->virt_addr)
 		return;
 
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
-	dma_free_coherent(&pdev->dev, mw->alloc_size,
+	dma_free_coherent(dma_dev, mw->alloc_size,
 			  mw->alloc_addr, mw->dma_addr);
 	mw->xlat_size = 0;
 	mw->buff_size = 0;
@@ -856,7 +856,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 		      resource_size_t size)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
 	size_t xlat_size, buff_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
@@ -885,12 +885,12 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	mw->buff_size = buff_size;
 	mw->alloc_size = buff_size;
 
-	rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+	rc = ntb_alloc_mw_buffer(mw, dma_dev, xlat_align);
 	if (rc) {
 		mw->alloc_size *= 2;
-		rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+		rc = ntb_alloc_mw_buffer(mw, dma_dev, xlat_align);
 		if (rc) {
-			dev_err(&pdev->dev,
+			dev_err(dma_dev,
 				"Unable to alloc aligned MW buff\n");
 			mw->xlat_size = 0;
 			mw->buff_size = 0;
@@ -903,7 +903,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
 			      mw->xlat_size);
 	if (rc) {
-		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
+		dev_err(dma_dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
 		return -EIO;
 	}
-- 
2.43.0

