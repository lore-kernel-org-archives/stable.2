Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881265;
	b=BQwcnegvd0Xe35/SEJ6sSlxHga4lG1EcNlueDtfXWziyA2AvBMZB5O5J4F35oOXCiKUf
	 JeGjRK4UeszLGWqmlxBp+fxG252aOAsCfQ4FAu+zhWScaqwmvlXA99UBbU5Pk2WhywTfh
	 iVImo/qlKTpUQOwzrH9WYTzlBT/YyHnlL8HcPALT2g0lxe1A2COzRRTu2YYJdILu2VoAF
	 lRchZust+O4id+4h7/30HCmyc2VrHfFEz0s+TIQsuLCjtoVAEWs9izgkRvHHwj2i1v7Tw
	 TYem1psGhLkY8tV4t1rYXLAlg/Y80qV7cb1IVYX83sT4TxpfrmqYnHJAGpnakGIIGtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881265;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=x7nNiMSDMHajixcROE15rpGTzfEukvU4mFb6L32NELA=;
	b=ZqUxVY2SJHwfvF9LKJ870KFMGKDHvLm3ObbO3niqqtYJAjExF6Cb73Q81uZPha9RQuyU
	 b0DlGAZURQkoFBMdaITBqOf+m+Av9EOeVyQyZpv0PXZ2f00T9ml/YmaNGhArMRtoylzJ3
	 hwUbJi24Mv8lk4zHGUmlO75ZuNyGLbbOSs3Iy/JJ0JTKIMtoASHnsljSsrTJ8EhOFdBFX
	 sMFlcQvu9xDbra1EsUXDLp+hb7tjOTmTWotR/ZLdsECEbWRVIJFL/tNquEhpR052j3Io/
	 WPKqllGiiHNLvPz48tJ7ESVv0a81KPpsFj9HdfHXiWpgL9Wf2KfZ25KsV5B5BWKSx2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=Dv0an8H2;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5BE606A328;
	Thu,  5 Nov 2026 12:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E5BE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=Dv0an8H2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793881253;
	bh=wqOF64oZtzKFZ4w2INVGLRadUC0Ak0kgVazhpZnAZOE=;
	h=From:To:Cc:Subject:Date:From;
	b=Dv0an8H2wIAVnhuQwsyvDoPg9p0Eef3lLpMjteJ+IsAhuMUh+CB83rkhL40Blxd1D
	 DVmbOKPf9dlm8EtKg2X9qXWGq4rZtqQS/DN8ZiT1OTF9jwbpxYsLpPgQ/iTUI5Y/KM
	 G20IHFg5XAfUuIeb30yG7auB09ngW8bBNs1YTVzprScO3d9dzP7wUWzr5K2z8cWAXx
	 EKVhZIN4QnYKZ5U15PgFCunPz5mGb/wpO92hCWtalNQp2+1p/JjEt0p0CCwN4/+9lc
	 YchnqNbdpT4w4jqhMPR4BWIi6bu4riLktYHjG9EwlbQu4lDiG8swc/XrfEanQyiBdn
	 SFEZsXHc23ZEQ==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id DB9482544E;
	Thu,  5 Nov 2026 15:20:53 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Thu,  5 Nov 2026 15:20:50 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.238])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jL1cK2qhCz2GXH;
	Thu, 05 Nov 2026 15:20:49 +0300 (MSK)
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
Subject: [PATCH 5.10/5.15 0/3] Backport NTB DMA release fix
Date: Thu,  5 Nov 2026 15:20:30 +0300
Message-ID: <20261105122035.2021-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {diag_burst_silent}, {date_rfc_vio_soft_silent}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207263 [Nov 05 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/05 10:48:00 #28800686
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

When the NTB receive buffer needs manual alignment, ntb_transport
keeps the aligned DMA address and later passes it to dma_free_coherent()
along with the original CPU address. Preserve the original DMA handle
and use it when releasing the allocation.

The fix is needed in 5.10.y and 5.15.y. Include two prerequisites so the
upstream fix applies without changes. Existing hardware drivers do not
implement get_dma_dev, so the new helper returns ntb->dev.parent, which
ntb_register_device() sets to &ntb->pdev->dev in both branches.

The same prerequisite series and fix are present in 6.1.y and newer
stable branches.

All three commits apply cleanly to v5.10.273 and v5.15.224.
Build-tested only.

Fix for CVE-2026-80884.

Koichiro Den (2):
  NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
  NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers

Leon Romanovsky (1):
  ntb: Store original DMA address for future release

 drivers/ntb/ntb_transport.c | 18 ++++++++++--------
 include/linux/ntb.h         | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 8 deletions(-)
