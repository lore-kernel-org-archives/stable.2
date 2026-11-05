Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.188.205.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881272;
	b=XRQK5LpcWY4Y9dqK5+41trtbPpT7jhqfhDs+3UBnWDav68DRIIxT23dYxjjumG0mmbpI
	 RAuZ+U98+6a9WrhU9Ft6f8kUXy4QVcdfVX8JANbxUaSPfjtLde5+ma+KZYISLPOAmbRmK
	 F0QU6c2Jbf0DPJOamggQzDfV6VovBLiEKwGS4ZiotAQ7fYr8dWgoSEdmr7HZ36aBsZE6w
	 qSyCLGc/ik+X77DapaB1jHPJdee4fQra66O7zsDFvil7sZ2rKQT60r9pkWd1CqCxjElH1
	 fLkVlGzWQx5jEpRZZzAAa2l3jJ52K3XudlVgDAK53Rrdffu5oqNuNtv0vwtpYYece8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881272;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=827W8Bv4XvdqTsXocFrr5OhNWM/nbGthPBlHBnMvyIw=;
	b=Lapa0E87ZN5+iyDCrYFn8Kt1X4qtFdJ1JEHAbLPNWtqivLUbicQw5w/Ss8zK8pOucep/
	 fbMTn4XSWA+7055CDpkGBh3NJb3aCFq2jlFsIg8P85xwqnHPPGAm4Gs37SPYOReTCToqV
	 8Hqkbsx0GZwGcDlulEUqyUI13w0vYJs7JTZBGspXPuLG6GJSqg7K3Cd1uvic4INO/L4qi
	 +Y1t7hQnjNdjonUWZSAYL/FTfDXc6PHzr6HeBYjnOkQss/z16vdmdvZdHsVZpYoz3dCSp
	 VamBzI9SwGcyUSWJ8oUBDcs3DY9Dj7btM0IMWlcq4Jt/mor3G0ND6yTkom0lgeIyjGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=Vn6HXFxS;
	arc=none smtp.remote-ip=93.188.205.243
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2886606D809;
	Thu,  5 Nov 2026 12:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2886606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=Vn6HXFxS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793881269;
	bh=/NNL9SQ1CVMDnRywr9WJ/sjPBHVESoryl5LZcxDT9HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vn6HXFxSO3qYbreVpqIA4D8esHMMih9wrjgJs0SICjZvAioXe9HU3NpjC9WIb8wHu
	 vjsEarU9SR/m738vxvdI8B7IGrcCC9BsskqgtvYmWGSdYKv0ZO0HuvAMzDZlL2dl7w
	 eROAdxGb7tM2wDTnXTYQVeLOQ4sb0z+vMAGfrSJS9Ap0qCLhYubnqo4oU7figograU
	 a3kI6IbEvdTn431iUDdd2as/mXbI6vcnFv4zI2JwGrpoSzhSFD7FMVKSK5otaYMiLg
	 1SOUnu3q/kYhJcMDttDMT06nHPQlMdie6xvZjfnlApnHf4CMrH+gal6xxOz1eXwkqM
	 A7oP1MVF80LTw==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 910AC1F6FA;
	Thu,  5 Nov 2026 15:21:09 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu,  5 Nov 2026 15:21:08 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.238])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jL1cg509zz2GXX;
	Thu, 05 Nov 2026 15:21:07 +0300 (MSK)
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
Subject: [PATCH 5.10/5.15 3/3] ntb: Store original DMA address for future release
Date: Thu,  5 Nov 2026 15:20:33 +0300
Message-ID: <20261105122035.2021-4-mdmitrichenko@astralinux.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
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

From: Leon Romanovsky <leonro@nvidia.com>

commit da6d997ac556479c112554ab5d95cbd04683eb11 upstream.

The DMA API requires that dma_free_attrs receive the exact dma_handle
originally returned by the allocation function. Do not modify it.

Fixes: fc5d1829f9bf ("NTB: transport: Try harder to alloc an aligned MW buffer")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20260501-dma-attrs-debug-v2-1-8dbac75cd501@nvidia.com
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-80884.

 drivers/ntb/ntb_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 2fca53b8e486d..fd3af0058f08c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -211,6 +211,7 @@ struct ntb_transport_mw {
 	void *alloc_addr;
 	void *virt_addr;
 	dma_addr_t dma_addr;
+	dma_addr_t original_dma_addr;
 };
 
 struct ntb_transport_client_dev {
@@ -800,7 +801,7 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
 	dma_free_coherent(dma_dev, mw->alloc_size,
-			  mw->alloc_addr, mw->dma_addr);
+			  mw->alloc_addr, mw->original_dma_addr);
 	mw->xlat_size = 0;
 	mw->buff_size = 0;
 	mw->alloc_size = 0;
@@ -823,6 +824,7 @@ static int ntb_alloc_mw_buffer(struct ntb_transport_mw *mw,
 		return -ENOMEM;
 	}
 	virt_addr = alloc_addr;
+	mw->original_dma_addr = dma_addr;
 
 	/*
 	 * we must ensure that the memory address allocated is BAR size
-- 
2.43.0

