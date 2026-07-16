Received: from outbound.ms.icloud.com (ms-2001e-snip4-7.eps.apple.com [57.103.73.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2C38F250
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.73.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234335; cv=none; b=RMPOlILBePJI9UeHxmAReeUUFSFVRMzjqk7ryJSGGHkX+nPIMbP1QHzu1uxKiuKcGKBbwPJ/KZp7FtX8Z7zGBvHh6pZJwrmUS9eAFuL8IVyeuRQCHn6rUfKajKklYotZyWghehBg2iasBNfrA9Ok9tgUVoaXuKuG6LwBrzA6u2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234335; c=relaxed/simple;
	bh=j3b4VOYxjD81BehbWkKrtO6yr2ztZstj51wU7jWIYg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GG2LHuhXzvp1OL0UkSW7IynqsrJ8wp86D1z4Z/5W5hOZ8dvdsT7J4AZj+UIZj6323wXzz8QVGlyRkd3qkBh5dAVjphYOkZiZ3hYXhuaP5odZMWO0P2XrV+CZieHcm1RPZ1QbKA4IOD5oUvkWcmxbvcQC3Q5EZKhAUSHnoWML2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=wwAoycXY; arc=none smtp.client-ip=57.103.73.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="wwAoycXY"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPS id AABA5180010E;
	Thu, 16 Jul 2026 20:38:50 +0000 (UTC)
X-ICL-RepId: 019f6ca7-4a1e-72c3-a089-207c87b3b533
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVQORQBEF0kDXRcOVk1KFlwaQAdTG1w4Wg5bBEcUFxtcABcNVk1QG18CQg8cE1YVEx9UVgNCGRBWAVhWXQVNGlwYWQ8cHUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNUBtfAkIPHBNWFRMAXg8PTAtIAVsHXANGC0gAWAdcHEcKSgtABUZBHlYPRAFWAFcwUBtfAkIPHBNWFQ1NQxJCFQQRUAFYHlY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784234332; x=1786826332; bh=AhENZ93ibKchL1kH2Ykj8OQurjHy95oojjIY4Yk47FE=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=wwAoycXYxxpXR1xSu9KUVlwto+yOpysVVRe50pi7vSNsd2I/SherrwgSYaalsjpdHkc+QeFLe/9cRNRiTrvPaYNnEujy1ZqBdDaGPA91uMJv18WMRV71wZaqrZxrn9Xgaq6eFS6PPEjlsrD4Bexbi/mIwiYEJdC9id9UFxi9UUjHjKgQG8unoLV3mIoI7XddP3dTqawlZspi/9Z+YJS1k59QBI6Rn5mlyAs6RrRC4+vUvUiz8MYL7B/+uXwqs97JTZXHdjg1ktKc/qaKGpXzuz2dL+liTMq/lXux3q43pgCPHu5XKz39/bgCD7aXlalIT8RulLdJ+0GAjpuy+nO1nw==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPSA id E949B1800112;
	Thu, 16 Jul 2026 20:38:47 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: David Heidelberg <david+nfc@ixit.cz>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	krzk@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>,
	stable@vger.kernel.org
Subject: [PATCH net v5 1/3] nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
Date: Thu, 16 Jul 2026 22:35:05 +0200
Message-ID: <20260716203507.7328-2-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260716203507.7328-1-snowwlake@icloud.com>
References: <20260716203507.7328-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfXwNBSoAL7TEcU
 HlfvkvlIzf+n3+tvPnGv05gZuJG/O0yvPQH72iAdYyCbApVigKo7UmhaWyF0shHzrWRL4YpEHRw
 O8uZWS7ZZwHOXxMAJfAcGEQRCGjypBJIOFz0gLSijyYinJ7WDFOlktJg1NJGcUV0OaZFlgLxODn
 0YF8LRuLp+Fx2HJ+ShMgXbo++7SlhSB+NkcIlbMJVulo4J8iY1BCx2VUnb3u168R0elxqICirOQ
 NjLSr9MvplDCX0G0VytgCPIg+UnnnrnbBP7F29lOPysBIbHrtNmszyGpGljHLX/syDg3c0+yni+
 v7bHdIHDYuPzdQbjlDr
X-Proofpoint-ORIG-GUID: 11P8mST5W-22YE1CcVjzaluAUeED6ecg
X-Proofpoint-GUID: 11P8mST5W-22YE1CcVjzaluAUeED6ecg

nci_store_general_bytes_nfc_dep() computes the General Bytes length by
subtracting a fixed header offset from the peer-supplied atr_res_len
(POLL) or atr_req_len (LISTEN) field:

    ndev->remote_gb_len = min_t(__u8,
        atr_res_len - NFC_ATR_RES_GT_OFFSET,   /* offset = 15 */
        NFC_ATR_RES_GB_MAXSIZE);

Both length fields are __u8.  When a malicious NFC-DEP peer sends an
ATR_RES/ATR_REQ whose length is smaller than the fixed offset (< 15
or < 14 respectively), the subtraction wraps:

    atr_res_len = 0  ->  (u8)(0 - 15) = 241
    min_t(__u8, 241, NFC_ATR_RES_GB_MAXSIZE=47) = 47

The subsequent memcpy then reads 47 bytes beyond the valid activation
parameter data into ndev->remote_gb[].  This buffer is later fed to
nfc_llcp_parse_gb_tlv() as a TLV array.

Reject the frame with NCI_STATUS_RF_PROTOCOL_ERROR when the length is
below the required offset.  The existing caller already logs and
continues for other helpers that return a non-OK status from this
switch, so no change is required on the caller side.

Fixes: 767f19ae698e ("NFC: Implement NCI dep_link_up and dep_link_down")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/nci/ntf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 87f76a29f0ec..1a38f4666e97 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -653,6 +653,9 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
+		    NFC_ATR_RES_GT_OFFSET)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.poll_nfc_dep.atr_res_len
 						- NFC_ATR_RES_GT_OFFSET),
@@ -665,6 +668,9 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
+		    NFC_ATR_REQ_GT_OFFSET)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.listen_nfc_dep.atr_req_len
 						- NFC_ATR_REQ_GT_OFFSET),
-- 
2.51.0

