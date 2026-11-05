Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881271;
	b=ImPXbH76IYG0PeefUgKiyGc22lPfA21CH22iLXEGOCov2xNZUCQNt3jmLRMvAna+eYTy
	 vv9JPjKJgkt3sH8Yq4OWR6yqEURbxeg+twUQzIZDTIBSjJQgD5DmJD+xWYXWvMGI6kMCC
	 1x6ZfQLLxvcKNbkD5LTWck7Z9OrpkZR2FP5ZkRYBZm5iVoURHiaGDHObARwIFaY85djXC
	 HJo1wTpa/doXLBMAG/beabiy8BNfrDZFDiat5O1TD4Cx/AvYn7lZy/EoZ6wysnm3qiGMb
	 IVX9SfN4I327fNL1kMkcjEY84Lw5YvQCRicZKtvRGEQHeG3/FN6AchsvNJ9UGdA+aRw==
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
	bh=+Us0YwAEiDoAqm7IhBv0LrioY0E9mL8uGnhHw428fxg=;
	b=QbfY7aD+FQV6n2wpZjZuF8Z/b7g1DphxOmoGNkdip+Z/txwXFWAlOSiYZ5uFGeCPzqXt
	 c1DSFQVmtvjTuPs5EhM4yn36D5DGi+UQsWboSOVM8nMA97SlVVm5+Dmj6ej3CdbMnwdwA
	 JVHXfeOtx2UHpxz2LMpYBIKPnaOCoAbC+Cyals48scskS0+l+bu0k33wkN/wunNdcBrjI
	 16kBzUgbpx9R2o6L9JxUpar4TdYVU4T9HTHWd9svVurltZb+wuLZx795qvpmakemH5DSo
	 KdeqEnObPEZKxu8Dt3rHKSoiXty90Yf8RLl0hAfCHZ5zo72s9talNyOqQ7TD28yf7CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=ibsTIv2B;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4579606A329;
	Thu,  5 Nov 2026 12:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4579606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=ibsTIv2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793881267;
	bh=ZZ/ghGYkwBZQM+c2KEcS/Oc/PsLA0Q+BVFuvEIFZKMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibsTIv2B8sY/i8yF+sFulaPVVbTFm4pwbho+yi76JKyPxT7KjuHG1EzypdMdz70ig
	 Fqh8het746j1rI7lH4j2yyd2yGnBE2tLvcmEKqAt6K+wDGRtZA4ZdoD7TKR2Dkuj1l
	 9RTmhEvxuFUB+q3WTDPwP1Ep/l8i8zBAwEeY+poyiuFst+hBjTUTs779AyemeR4pTA
	 uAi38wqT7266c/MYXDnF57g98I2FT4jya/BawGnBAcISsxTzoEqVAx8zxvgKe7J2yh
	 C/e6XAYH3k3orWkVAJYW5k1DrSa1IJXD3SKEH9TH/V2cF/6J3nOvcWLlsmOYSBS0WT
	 GP4I6x4A1ZA+w==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id DD5142542C;
	Thu,  5 Nov 2026 15:21:07 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Thu,  5 Nov 2026 15:21:05 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.238])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jL1cc1gc3z2GXS;
	Thu, 05 Nov 2026 15:21:04 +0300 (MSK)
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
Subject: [PATCH 5.10/5.15 1/3] NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
Date: Thu,  5 Nov 2026 15:20:31 +0300
Message-ID: <20261105122035.2021-2-mdmitrichenko@astralinux.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207263 [Nov 05 2026]
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

commit 362a4549f2acfb03390ddfcd91041e65a11a739f upstream.

Some NTB implementations are backed by a PCI function that is not the right
struct device to use with DMA API helpers (e.g. due to IOMMU topology, or
because the NTB device is virtual).

Add an optional .get_dma_dev() callback to struct ntb_dev_ops and provide a
helper, ntb_get_dma_dev(), so NTB clients can use the appropriate struct
device for DMA allocations and mappings.

If the callback is not implemented, ntb_get_dma_dev() returns the current
default (ntb->dev.parent). Drivers that implement .get_dma_dev() must
return a non-NULL device.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
[bhelgaas: format doc]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260306031443.1911860-2-den@valinux.co.jp
Stable-dep-of: da6d997ac556 ("ntb: Store original DMA address for future release")
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Prerequisite for the CVE-2026-80884 fix.

 include/linux/ntb.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 191b524e5c0dc..5c29e904a9c52 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -256,6 +256,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @msg_clear_mask:	See ntb_msg_clear_mask().
  * @msg_read:		See ntb_msg_read().
  * @peer_msg_write:	See ntb_peer_msg_write().
+ * @get_dma_dev:	See ntb_get_dma_dev().
  */
 struct ntb_dev_ops {
 	int (*port_number)(struct ntb_dev *ntb);
@@ -329,6 +330,7 @@ struct ntb_dev_ops {
 	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
 	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
 	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
+	struct device *(*get_dma_dev)(struct ntb_dev *ntb);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -391,6 +393,8 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* !ops->msg_clear_mask == !ops->msg_count	&& */
 		!ops->msg_read == !ops->msg_count		&&
 		!ops->peer_msg_write == !ops->msg_count		&&
+
+		/* ops->get_dma_dev is optional */
 		1;
 }
 
@@ -1563,6 +1567,26 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * ntb_get_dma_dev() - get the device to use for DMA allocations/mappings
+ * @ntb:	NTB device context.
+ *
+ * Return a struct device suitable for DMA API allocations and mappings.
+ * This is typically the parent of the NTB device, but may be overridden by a
+ * driver by implementing .get_dma_dev().
+ *
+ * Drivers that implement .get_dma_dev() must return a non-NULL pointer.
+ *
+ * Return: device pointer to use for DMA operations.
+ */
+static inline struct device *ntb_get_dma_dev(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->get_dma_dev)
+		return ntb->dev.parent;
+
+	return ntb->ops->get_dma_dev(ntb);
+}
+
 /**
  * ntb_peer_resource_idx() - get a resource index for a given peer idx
  * @ntb:	NTB device context.
-- 
2.43.0

