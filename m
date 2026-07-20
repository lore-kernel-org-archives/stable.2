Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118F3D79E8
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590082; cv=none; b=iJL7j+d/z0SFc8eSrqXZvf3UHf59AJkMcqqvn80lr49Rm3QSupkPhZ7qHxPHxGmQQmiitl1stKyJ3EM40lrAK97wJ1c2SZiSjgOKuLK4mBYjVz2le3pNmFvA19e2uGQsXFEsBCC3+meCXp3LN6xWRsKYQKDOuwps+WNHrV3ZK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590082; c=relaxed/simple;
	bh=F0YKP0rtoD0MZK99XrKtmQEktL1n62Dpb2rcauw/G7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avhc04GXhT3JMJdMv0VmT6cBGdwWg9U57ioHrA25rqlFppIre4XOPDSOTEcFIx3oBu34OjS/C56bNGgvDE4e4MpVfYAuRWhBzRMp32grDXMeZCAsvGpTytf+iBHsN/TFIYkvgVqF0KTimH2UUWcNfIoBn1xQkEoqqbIozfaqA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=OeQx/STO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="OeQx/STO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1784590078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9a6DuitCJL6N4gMGmNvwMHBy9Nw77LmfpwFVp8GiUD0=;
	b=OeQx/STOwQBzyYnQ7RMWbVzsxK2pC8hgBbnor7/IyLHy8mnladzTmPuLMdcjCmwhghLYwV
	V/gYtWP9FWcjshzAfpALtbS4Q7wQCkO3KuQM9Guj5uuzoCY21Rrn0L47+E/PJoeHw5lyfh
	CjZ1/F/07mcfkKpbVf2CGXm9jFKRmosDSQr+a+xaa32Zg5/td01eZYXnpUJKSGcgxUjk7B
	EKdVrSxGf7OcEwuW+sB2V/hNmHTrGcNsaYC9i7e32XM/DstpsUZRLz4NeL5dmKIYkMHbmr
	vugkQ8J2iOKq1D0S6ofuY2wNiCdXbOY/DevivVEdXY/DPgp7+mWKWPLWzCRQOA==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: restrict NPU/PPE active checks to MMIO devices
Date: Mon, 20 Jul 2026 16:27:36 -0700
Message-ID: <20260720232640.41293-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

mt76_npu_device_active() and mt76_ppe_device_active() read dev->mmio.npu
and dev->mmio.ppe_dev. The mmio, usb and sdio bus structs share a union in
struct mt76_dev, so on USB and SDIO these read unrelated data from the
usb/sdio struct, which is non-NULL in practice.

mt76_npu_device_active() then returns true on USB, and
mt76_rx_poll_complete() takes the offload path and skips
mt76_rx_aggr_reorder(). RX A-MPDU subframes are delivered out of order and
the peer's TCP stack treats that as loss: heavy retransmissions and reduced
throughput in AP mode. Seen on mt7921u, mt7925u, mt76x2u and mt76x0u.

Gate both helpers on mt76_is_mmio() so they only run for the bus type that
owns the mmio union member.

Fixes: 7fb554b1b623 ("wifi: mt76: Introduce the NPU generic layer")
Cc: stable@vger.kernel.org
Tested-by: Nick Morrow <morrownr@gmail.com>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 07955555f84d..a32ba7c23f92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1736,12 +1736,12 @@ static inline int mt76_npu_send_txrx_addr(struct mt76_dev *dev, int ifindex,
 
 static inline bool mt76_npu_device_active(struct mt76_dev *dev)
 {
-	return !!rcu_access_pointer(dev->mmio.npu);
+	return mt76_is_mmio(dev) && !!rcu_access_pointer(dev->mmio.npu);
 }
 
 static inline bool mt76_ppe_device_active(struct mt76_dev *dev)
 {
-	return !!rcu_access_pointer(dev->mmio.ppe_dev);
+	return mt76_is_mmio(dev) && !!rcu_access_pointer(dev->mmio.ppe_dev);
 }
 
 static inline int mt76_npu_send_msg(struct airoha_npu *npu, int ifindex,
-- 
2.55.0

