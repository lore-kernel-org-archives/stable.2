Received: from outbound.qs.icloud.com (qs-2006b-snip4-1.eps.apple.com [57.103.85.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D8723B62B
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785287799; cv=none; b=rVOInCCzWA/DickrHD1bzqckzrk5tuwCA22oOgS0Ej1Zg46ABbSZhVgNTNGyapWXlz4k9FGMPCzmOLSbF2x8dcY6v1m4SwbOyvQEsMjovNvbX9pMRimmQzkmNdRBrhwrv6c4q+3l4dp9UxwkUc7aRFnUBwgk5H4PnbTobwvqljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785287799; c=relaxed/simple;
	bh=/xLHixPPHgwI/mktxPqxg3tUxxSyHalLo29pAOZfuXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQCcJcRWB3az4JXPDdkIn1bysszET+6GSAcktDVS++iApVDqt8/6ZK1SZ0f7uilAnzMIwva1LETRlGfXvQbLR+Ft7txLtRt2PzksTXtvy0aedWf8Cg7z9kOxa5bIabHwvni1J1VHk9LGxwIb6UIDTOhWr8qbFITgqmvqpxwVC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pllhzpun; arc=none smtp.client-ip=57.103.85.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pllhzpun"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPS id C20A518001BD;
	Wed, 29 Jul 2026 01:16:34 +0000 (UTC)
X-ICL-RepId: 019fab71-e021-7504-b2ec-357fbe25243d
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhLBkMGWAReC0wdVRcOVk1KFlwaQAdTG1w4Wg5bBEcUFxtcABcNVk1QG18CQg8cE1YVEx9UVgNBGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNUBtfAkIPHBNWFRMAXg8PTAtIAVsHXABJCUkCWANcHEEASQpcGlofA1cXRBpbClkVeRFQAVgeVl5aF15TFx9LAFxFWg5bBEcU
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785287796; x=1787879796; bh=P8vDWChRywZk11eXLObnIJl0i0uCHh7F3bByRED5MNY=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=pllhzpunLWG7vGZgqw94pcGqiWzU6JvaRIOnGx4ymT/r12MF7IHgh/Cayz6T5WoXfmEa8/0Ux6oBVE1GN28bT1Lw273sJKNgJ57vCAZtodpww7RNANHLtC+0EKTJKwP3hH+4LWL5yjsHBh3g2lCEOkd3D+MUPuF8/nXVWQli+klutXc1XTrg/v5WsnTIl6OysSFblhIiVC+sCjIRCWZlO1PxYP7VD/j6AMalyC9QAhlHbCOekA7097WkJ3vg5jMD577Q2OAmza2WOOdwn/0R/PeGHqcScQj1YAXGVx0ZIRW+Z0wm7gJVCBx04KhbJAG7HFUGaUCYja/y6Y0oXo/Ztw==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPSA id 4F141180018E;
	Wed, 29 Jul 2026 01:16:32 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: David Heidelberg <david@ixit.cz>
Cc: netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
Date: Wed, 29 Jul 2026 03:15:46 +0200
Message-ID: <20260729011547.19191-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=SZ/6t/Ru c=1 sm=1 tr=0 ts=6a695473
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=D1Ezx_vhIy9DZtWJ5osA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=5Q-93EyGrU3sW_9myDOF:22
X-Proofpoint-ORIG-GUID: YLz_5tAZMuFu1KyW3ieqGplDpra4K7gv
X-Proofpoint-GUID: YLz_5tAZMuFu1KyW3ieqGplDpra4K7gv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAwNyBTYWx0ZWRfX0OY+Y1by0cDv
 wLLm7L4VZNtS882sDmcx9vZZoaki/FUA9wP3NFWR3xlCnvirnswi3aruisZnIOuGJ4ceoxAMGnD
 0HyNVb7lk5c4GzxwLBLqVoBItnb49AxfNFJOH2qhFx6G8fXjiratNgcN73ERpxh2JN2OkcKGtaS
 mVIT7+lwTqQCPLOA3hnQ1y0WBtlOFJOaK5R6jU2Qi4CLdRquiIEAZYWN3Kb7tp2QIEI8Vd6Va9G
 wD+cfubVr+L8DMDWru+J2E86RnA/Ih5CjJDCnNhckfDRCqznKp/KnMtuEyhRdOuBqyR2TV+Tvv2
 lM0Em+5547vsb+20+hWFdsxqfAqkca2qcKzE1UGFjknQ4L5WkGov3uaMK+6efA=

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
index f5c9a8ab7ec1..263f76a2450f 100644
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

