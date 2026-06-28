Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47FE2FDC5E
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.150.240
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782642079; cv=pass; b=XcQ0cn32Fa7e5PQsIruI06pYmbGBNHKuV4gzh97D1QsQtqJIRx2mAEuroQPNPrc8daKoCYZcBGrl8cpQbjNU9HQWb6mNwMnBLajbCaYjMoyPEniWNIanoGl8t6ibYlPGNGyLyHfqR0apF4YO+rSDJbqBS9QA4VsqHOFkTKWGKkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782642079; c=relaxed/simple;
	bh=mWSYADSikqRBBBw/l6+1fgSqFY9GutZDLsvyNjYAOEs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ePiCf94wpyUGy74doxWOxtkESe0nXoYUNvWJtYw59sWymF73UfphB+7yen+H3BlabLiiz1A2ejwhJ+VNnIEsehBfrvk88YHRo8d2OgYnbvQWKAgBghOBJ5AeQ/wK+fuOeblHxQ3rhxr1nWXTSBT4oxM/PBAwbXre9T32/sIfu1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=qt80f/WZ; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=qubN+9KU; arc=pass smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="qt80f/WZ";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="qubN+9KU"
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65S9VZvl3876353
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 06:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	20180315; bh=+tQ+6VE88il0RYGsLv5vQZVWSmR1xeHekDkDjYsVFso=; b=qt8
	0f/WZl8dQD3BlCxgeK21Mrin3EUthecFAcbGf4zFxUgiQxqsP27ZKlyd5rEs99OR
	ff08LECVjs1/Sm9RAi0sZXa8wNGTdu86cCCjzbKQvaxi0MuT/b2MW3nC+L/L387r
	XgTvKjFagGWvWQTSQnSjhQg/c7t2+UDkunyDnlt8V+kVxW8mOc2yNJf5mKl9cR/H
	yjMypTOfHeG6OKrv2TyBJMHYdpk6B9Ghldtlrxj2DssPkwEqoG2ZxYvQ/sTXmc8M
	+HVDnEaOxSFwxkCu8JgSh837BC8UPpfx8W00IKJrFEAHoEQ3hRMD+CYWiFX+ECNg
	h+Xoa7tRwjuR2wcpGYg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4f2nj3kyur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 06:11:52 -0400 (EDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-845c733743eso1595848b3a.3
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782641512; cv=none;
        d=google.com; s=arc-20260327;
        b=A2o6+yfpyXFskHEBhjNxJZpu4nSlXiUpUndXBWZ1Ykqbq9ZnzmZT0kD2D0b2cQ6kj6
         XT6UEgi5uN9v5ill+l4zfQ7uPddCbZSFmDAnHstfJQUqmDzeA90eYA6QZS/GTsUUCYeW
         0HCdupKgSoHAz+OuAKrW2S2BKpxqXpIJbsb2sP79h/LltmsHzGHMxxxdozc1M01tB4Dl
         7bYdnG1XbXEq/Q9wPGVcM9CCLhOmaizbE3ISFPnO3dLkEElgD+7gw1t/njynR44U+kYR
         prKtCBrxhc+/S7gnFh6nmJm5uE38rErrmUs7wGerA7cwrfLfWFj7b8Uw3mtTdTNwYziS
         rQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+tQ+6VE88il0RYGsLv5vQZVWSmR1xeHekDkDjYsVFso=;
        fh=uTSAO/NH+HQGYfuvyoL0t0XbEHbhZUscqobYXOL/eRM=;
        b=XLmzlIvJWpoK1CMBbEsiySBOv/G0oWVTjC/A0RBShfQf+KEkYl0+S9b5EIgzDAQiTs
         6CGscnF1utM6zrn2I7qJZZvFkkCSJm4YmnzH3r1IkaqhxTrdY2ulU41DbMjmnjBXa6W0
         7VZJTOpZ+zey8vI39PFIl7yX2IRYi8Y5a8IxdDrhL2eUJzv1vcQAeUXQoBQaKyh11bpj
         3tpzBjLJS7JNzCjDyTGmHTQ9fEkYsjJpOmzHPeA9+2A6Lhw44oAa+76CK/sSYOP7Osgr
         /cMroukS4huVDSx/k7ffqWwnR/I2RsdOrJt5ek9YeeLe17TG+4FIejXW9Ah4BabhoGyD
         j3xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1782641512; x=1783246312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+tQ+6VE88il0RYGsLv5vQZVWSmR1xeHekDkDjYsVFso=;
        b=qubN+9KUHmL3JiTS356xSAHunkS/M9pRyi/QtbLbt7QEsZThS3jgvV/8xSj5N7Gbe1
         UJrw0BL6gtx6iT3f+h2/Mv6g4fKScPLUEHftt/HLErEwE+alvBT8I/A3QqE4TLsmunPt
         0iTK2gKFoPcqp6/4/yzZ90N9yGp7C24KAtIyFPMrj9pWzJXMxhqoXmrfaQJVKpk/s2QX
         tZXGDFDEk3RXeqjX9GPQYq3Uk3WjGBbvVgHV1N0iaF3qlkw/afnRfmDwz6TTIHtTUEtM
         EZ1FaQt0/PJGk0/XDDP7+kaYlawqRsUucEnAFD1BVLB4TRQqXrvj5aAVOv03jwI+uKA6
         wb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782641512; x=1783246312;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tQ+6VE88il0RYGsLv5vQZVWSmR1xeHekDkDjYsVFso=;
        b=EpWmDn6swCGpw511A1k4we4G1PPF6AVzzg6pprVpWa7oo7F5IcSMHGELx28aqVN6Ez
         4pv7Gpb8yvDrgi8dFAgNh1VlgbXl3xGM5vcr1hMGIBFubyw6RZ7p1weT1rSSwGBypvWZ
         eWdpsV5BEO6I+0MBYFUmf0YtQA6y9f+fFAJy9BEzrsbJ69m6m6jXV/WvDMZ+wxes7wLy
         mPjCnuXxq47Bpipxp6fXzuOs65oL1xATkNLuDQFRCsH4pFN//UrM55a4YQtJAD2IAzx1
         y4eD52/aOwhQ4VXg0z6ESPAWmr1BY6QVZSB3pxQfcOsk00efpM7yIsCJKWSOFVrjFu+W
         xefA==
X-Forwarded-Encrypted: i=1; AHgh+RoO4ds1m3SMmFpW0mtzyuc7Ofu68pWmr+RXku8Yepa+G5ogTq6JqXI6w31VD5x5BotALpXHXCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+JU1MxgFGskoXpabTCwi1Rqmps/CLrPSPhLfV1tnFqp/VAE1
	2UGAr6R6YQUnt7PyqV85zfIE7dIDxdpr2NbqTI+D2ZksMyEf9Au2OBqCxfUOs3QmmZHCzdWo31n
	/wRjTynpJQkhI3HGj5ym6JMZ4fx/TnM8uUgYkaNQWSm8nqsrWjT5GcXx0r6FFzsvLQE/QNcK1ti
	c/7JyIzSIVsnckdRkA7mwH9erb1Sr8Wg==
X-Gm-Gg: AfdE7cnl9hXP2fS9IdjOPxxC5IajavdUzuzl5O2lTA5ACyMVY4rFoVNzedzeJsuPg3Y
	CtCqCFeBVGZB/1ZFBr/uh//jO1vcI4K3IfUcXV51Cqo0l/ZOnXV/c7GRjK2MeB5supvV6D3fcGM
	ALCBnUzO81n9GUd6cnjcHbB7cb38TNNJh6ojkJYHXolwduPEL2RVAQ8IkW+NGyopjtXYrb
X-Received: by 2002:a05:6a00:6017:b0:835:405a:7e6d with SMTP id d2e1a72fcca58-845b3aa11fdmr12288937b3a.21.1782641512359;
        Sun, 28 Jun 2026 03:11:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:6017:b0:835:405a:7e6d with SMTP id
 d2e1a72fcca58-845b3aa11fdmr12288922b3a.21.1782641512007; Sun, 28 Jun 2026
 03:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yang Liu <liu.y@nyu.edu>
Date: Sun, 28 Jun 2026 03:11:16 -0700
X-Gm-Features: AVVi8CfAIoUNIfxM5v9T3o58Vnf7MK0HDsknT8lit6LguFvobXTyIEHZKWs90-A
Message-ID: <CAMt2zv5c0cYzfe0RQ5AfoUdm+b4bAshgjCs23NjFBhQXDKLniQ@mail.gmail.com>
Subject: [PATCH] wifi: mt76: mt7996: fix TX DMA mapping leak for ADDBA-req frames
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: SepZL-6C1Hah9geWx1YJ14S25A7MIk1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDA4OCBTYWx0ZWRfX+fhUsbz8tXZt
 yWcWshT2NnHzsdlEVa0nET9FMgFgNl+0ve6OgMFcA/wzvswdj+alUqI3yGbK8NylIMbzpYZiJAM
 qb/BFEc5V6dtSCYnN80dPRsXN1VvEEfCoDU1Voa7VC0sf9bVWSC/2XZlA1nC3O2A2mthw5B9YU0
 wNuu+3ArzkGzGgC6UYs4pjfjjjFeKIRGuG5lGnh/cDMB0icC5K0QCDeUM2tZt7/ywesn00mnk75
 oT0gaFlQwAqm3rq+gIz0WK+rEkHGEBVpH7CNBfGbDA1vRudMupvPm+2GgHKvHDAzhHq/8V+O3NT
 oxkbOJ8a4xaQ/zEOxrBjR5/ez8X7kYq+tHeWtWMvQ0luxiiD9SiyRpikwqnRoMSgjerMkq+gVX4
 EEC0WZnRiomw2CYMY24ENMi9EZl9rpZjGVSShv2DSgYDDFDIoOEZXBYj3ricrqkH8p5dKEDYst1
 fbmQK214iSzR19i9Qng==
X-Authority-Analysis: v=2.4 cv=W8AIkxWk c=1 sm=1 tr=0 ts=6a40f368 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=CxnIfPQeirmdGRAfp5MW:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=b7W-z1OYDQUBpEVa_EYA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: SepZL-6C1Hah9geWx1YJ14S25A7MIk1o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDA4OCBTYWx0ZWRfXxwAanQZbxl52
 srN6cB1WwqjHhRzXthsn6I9CzWCjj3OFvI7G0NLm4HccO5iY6iBudG7m7cEYUGqUgcdZA7NM5XP
 GjQzY3dT61+CNqX7X3exiVDVVbXsgO8=
X-Orig-IP: 209.85.210.199
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280088

mt7996 hands the firmware a HW MAC-TXP for ADDBA-req action frames
(MT_TXD7_MAC_TXD, set in mt7996_mac_write_txwi_80211()), but the chip is a
FW-TXP device, so on TX completion mt76_connac_txp_skb_unmap() decodes
the per-frame txp as a struct mt76_connac_fw_txp.  For a MAC-TXP the
fw_txp.nbuf byte aliases the high byte of the TID word
(MT_TXP1_TID_ADDBA, GENMASK(14, 12)), which is always zero, so the
unmap loop runs zero times and buf[1] (the skb DMA mapping) is never
unmapped. mt7996_tx_prepare_skb() also sets buf[1].skip_unmap
unconditionally, so the generic mt76 DMA-ring cleanup skips it as well.

Each ADDBA req therefore leaks one TX DMA mapping, i.e. roughly one per
(re)association.  When WED is enabled the mt76 DMA device bounces these
mappings through the WED swiotlb pool, so under continuous client
reconnect churn the pool is exhausted after ~1-2 days, after which DMA
mapping fails for WED, the WiFi MCU and other on-SoC consumers.

Only set buf[1].skip_unmap on the FW-TXP path. For MAC-TXD frames
leave it clear so mt76_dma_tx_cleanup_idx() unmaps buf[1]. The FW
unmap is a no-op for these frames (nbuf reads 0), so there is no double
free.

Fixes: cb6ebbdffef2 ("wifi: mt76: mt7996: support writing MAC TXD for
AddBA Request")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-opus-4-8
Signed-off-by: X <50459973+ly4096x@users.noreply.github.com>
---
Tested on a Banana Pi R4 Pro (MT7988A, MT7996/BE14, WED enabled, 6.18.35):
under a continuous client (re)association reproducer (~51 reassoc/min),
/sys/kernel/debug/swiotlb/io_tlb_used grew ~25 slots/min before this
patch (steady leak; pool exhaustion and the resulting DMA failures after
~1-2 days) and is flat after it, with no double free.

 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0eebc81..962dad4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1010,6 +1010,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev,
void *txwi_ptr,
     struct mt76_txwi_cache *t;
     int id, i, pid, nbuf = tx_info->nbuf - 1;
     bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+    bool mac_txd;
     __le32 *ptr = (__le32 *)txwi_ptr;
     u8 *txwi = (u8 *)txwi_ptr;
     u8 link_id;
@@ -1096,7 +1097,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev,
void *txwi_ptr,
     /* MT7996 and MT7992 require driver to provide the MAC TXP for AddBA
      * req
      */
-    if (le32_to_cpu(ptr[7]) & MT_TXD7_MAC_TXD) {
+    mac_txd = le32_to_cpu(ptr[7]) & MT_TXD7_MAC_TXD;
+    if (mac_txd) {
         u32 val, mac_txp_size = sizeof(struct mt76_connac_hw_txp);

         ptr = (__le32 *)(txwi + MT_TXD_SIZE);
@@ -1167,7 +1169,11 @@ int mt7996_tx_prepare_skb(struct mt76_dev
*mdev, void *txwi_ptr,

     /* pass partial skb header to fw */
     tx_info->buf[1].len = MT_CT_PARSE_LEN;
-    tx_info->buf[1].skip_unmap = true;
+    /* MAC-TXD (ADDBA-req) frames use a HW MAC-TXP that the fw-txp
+     * mt76_connac_txp_skb_unmap() path does not unmap; free buf[1] via the
+     * DMA-ring cleanup for them instead.
+     */
+    tx_info->buf[1].skip_unmap = !mac_txd;
     tx_info->nbuf = MT_CT_DMA_BUF_NUM;

     return 0;
-- 
2.53.0
