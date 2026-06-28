Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C112FDC5E
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.150.240
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782641934; cv=pass; b=uo+5staipd6OVNACk6l5XlZ43m/WeZYmYT84pjv6wyAAqVp/laBPRt9uA4tGyI+UmkH5TfS1YiS4Mr/x7qyGt6FA51bmgGWPwlS5nVxNJvaZI3Z0x+y4YumEsOIceqIcZ2U5uV5TRgn8wNNBfZlJxEmmkhMP8BH4r3yxeASxS8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782641934; c=relaxed/simple;
	bh=DvFXAFCO9tcZqdlLmhVk/h5vnLge5f1OqFfZkggU5zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QC98/PmlOvZFTZO06EYG8570vYfyYyscBEb+heB7/L9KWg6CL3kL1lLQ20jcXMxZSuTaXdrSYsicrnTX73gv7wohLvGwsu6KjtxRsu02LBVr5Xsj/Uprqa1BeNMtN0KPFQV42e5upKM2RkysCeYLb1Eolwua95Orhpat1v3uvIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=Md+xHcmJ; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=d1iOmTAO; arc=pass smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="Md+xHcmJ";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="d1iOmTAO"
Received: from pps.filterd (m0355795.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65S9XtDF3851466
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 06:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=20180315; bh=IqIUFv8eyNO2DKWR0kEueaSzy
	xNdYsgSTleO4QX3P+k=; b=Md+xHcmJaAM5DZklTrqr+kCJUp3Ox9WP8ZyARl3zZ
	hrhv9GzB5beVYuals8qVoylFKSErqAIzaXkvgOnQ0gkTXaxLv7P5ZJQxBGy7VlTm
	UQWmiFAena6dZQVPGIVC88O/kz1claUlC3IWFFT4rjgxCol2magmsFgPZCQkrzhI
	3xS892bFQ3XDXBGsNDnFyw1T+TanAaRm0UjyytuQtya9d3Pp0avttC+Ka+++vNQk
	J6wUDeH002PscOoTVF5kG/HihChHjWVvsNjYq1xYluy2dRCwxUQS3Rf6xT192U+4
	yb7pLEnPGOE/jzjwi2h2WL3HdAZGNg0qihHRttOrEjxEw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4f2v2mhgs7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 06:18:51 -0400 (EDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37fc0aaa94cso562784a91.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782641930; cv=none;
        d=google.com; s=arc-20260327;
        b=LgfkXU1TuH7RRgFLJySmRVnOkyYiFow7qhrlNjkUzqnFtNWDP59LpBXTxotkaMqCq7
         v3jDLGZeABB8wo6tVqOEg4z/Gc/CG2PYXfeVvGzEZHEkDh+IE+oTWQLWpAqa5fZXflzc
         EbINI0ZmXSxNuJIAmBkOmnDAqUseccDW8zpHSpC3jRGpGVnfbSk2SKcncwdZAJJof4rT
         imXxzSmclzHbFlr5VkoHoIhsWzK/P2ZHZN6cUhA4FLDh06H6GvjUBLt4+5MYSbo8eZwe
         w5qWSzX+fHApI7+aU9QsodFGqZ+v+LDh2PF37lzfo/FH8CC5EBZgZhTIL/bfYz7F3OCp
         yDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IqIUFv8eyNO2DKWR0kEueaSzyxNdYsgSTleO4QX3P+k=;
        fh=1PeJOQfFxHC9HxiKbS4E31xJhWGJ2n0wAcz+g0b/4YI=;
        b=I3l/d7BceplbEooJbySPqEEAPyE7SOe3TtFV0/l6j/AwlNAilsQiqw2f+57jArh9Jo
         GHhQwxnNZq5QozWpNhrey2tqCia48XEqAtPG/AAfLii50XuPp6ruIxJfVWUF6gYOeRSY
         6LXHKG0MPgAHQHLDWhfavoMdawqXLbqJ7ZyNEZEEgD/0CfbyEsMc8pEIq1eLDq2zrplo
         OdEefi+PY/nUD+s4G0/NVx0859E1pnumRY44iTWN1iV6NTV3st0K3lXAbth1FUGNhiWy
         mBildI0vO8yFfMr+RoMF9lTOYVyn35l1vGHHVOQqUyLBNGAZ64BL7e3+tWOcvi+42IFA
         hbAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1782641930; x=1783246730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IqIUFv8eyNO2DKWR0kEueaSzyxNdYsgSTleO4QX3P+k=;
        b=d1iOmTAOoQA+TT9ZAudDugMB4X0BNgjxADbfRwKnswAD6/2XxtuVKM1ZtA3HDhdNtR
         3FgGakZP1Mc+f2mGnx40EfWSQUBprZHf1W4lY3T7vqT4IQsVc7sdjePDGILS0TiNKkVH
         aCAeXb6Jn/dBH4AAxE761G1HBohjIWJirAM/rZh2Qyur69rufv2etnPFAtGDgHCrHPp6
         Gd07w76lzOzxvU8ZJMkFcARoyyyXwAkjeJvIe3knF0dzjQ0QpjmLHuUd1cbtZOtnSnKv
         PYn0LO7rFhMFrxrzXv2dsB5U93h0s8ax+288ndp8yDwjdivOg1aebkeZV37M1Tq4f0uC
         Iz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782641930; x=1783246730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqIUFv8eyNO2DKWR0kEueaSzyxNdYsgSTleO4QX3P+k=;
        b=M6yxAdrXXuLlbVCIFv+FQmE28DXVvuWe05JShARWXEmC6y5bLZ3b6jBoKUGd9S8Nf+
         X638EOfyYCVAolQ2REBy9Z9uVtdbTuUqOsgA2KOdJrlyhkOzC2WEwIVeH0REOmx1GFSv
         UppYSNcv+4trU7Hq5Lhz+gO4jjV5tAUNgYpUd91w/n40XXagWqkxP+9jfPNANTJf18Xr
         sWNnQjuBNP/Rav4EQxXRq+5i9AtGpxlKS1JooyYzMsa4Sxz3GaQ86puJNgjN59JMYV9Q
         ppSJEqe6qbf0NHg8UAQCJCMBgfM9uIjoji+3H0EhoOroMHmqUN0gKM91T/0MS0H4ocAP
         FBvA==
X-Forwarded-Encrypted: i=1; AHgh+RoDwfdhrmK6P/yId3WSqjCLv1oOIycOkMtut8EJ7nJjxdPU7reJPGahyh5Sqz0+A0ZRokWrTnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PNbOR8YCMMyBKpRyHjb2oc6OeC1eOJqqWnK8+R+kOvsuFtTd
	YC2+0KilZVNSJg7Hxh/7ZufYQnfwNlAqhxBHXrNerUFQHDJHy1im3ZST2bPgNAgdeS2lBjnefak
	gXicSbHKq2HpaKMd+JW90ggHNiM5jwDZ5qev22ViaE2L5HLVrXMz/pBkG6UF6lqNQrw4wwvVwIJ
	TYvb9r9RySVeNNMO/xj4slPNYUUJo7aA==
X-Gm-Gg: AfdE7claGJTrgqrKt8+sqGhgbnQVQGImzHaoQfkM8IYDN7khWFaHjnV9z2PG2JaSbwa
	Bt7Z7NDO3cGC7Fmuvr5t0vwj98FbT7vqXJjWbD9s3ApxgouHFrxFVCfGGnAUvUK+xmEsBv4hjlU
	Odiy9ydXHP+0Ca7VMNYtLRCRQx4/mxvn89MI/2QSmbJogW2fFKP7Ox/Bi7t+hooWOisXSc
X-Received: by 2002:a17:90b:1c81:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-37f7a52c19fmr5834462a91.1.1782641930517;
        Sun, 28 Jun 2026 03:18:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1c81:b0:37c:6910:5758 with SMTP id
 98e67ed59e1d1-37f7a52c19fmr5834447a91.1.1782641930109; Sun, 28 Jun 2026
 03:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMt2zv5c0cYzfe0RQ5AfoUdm+b4bAshgjCs23NjFBhQXDKLniQ@mail.gmail.com>
In-Reply-To: <CAMt2zv5c0cYzfe0RQ5AfoUdm+b4bAshgjCs23NjFBhQXDKLniQ@mail.gmail.com>
From: Yang Liu <liu.y@nyu.edu>
Date: Sun, 28 Jun 2026 03:18:14 -0700
X-Gm-Features: AVVi8Cf8t9Ato-3g7XWUk93rEfgPTT4Ew3KvNQiLLSuTjXEG34M_PT0p9XJVcFI
Message-ID: <CAMt2zv5gsy-vbjfZC5jQaNsOj1NnkhNrQuCKSQ2Sn32gmnCcag@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: fix TX DMA mapping leak for ADDBA-req frames
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDA4OSBTYWx0ZWRfX2x7HRnxZFvHn
 XVFZipKLOxcjuQHnosn5xtxjdvXwLk1a6TQq9vsvBW+vMxrSlzSZ+qzhbdEWH38tU2g1hpCFYNk
 H0e02Om9f0vCDzcL/1SRCHCt3ky84e8=
X-Authority-Analysis: v=2.4 cv=YfSNIQRf c=1 sm=1 tr=0 ts=6a40f50b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=Lu3rmdZLeA08KL8VqJdF:22 a=VwQbUJbxAAAA:8
 a=BIFNTvHFq2Y8mDqsfgwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: OYvRiO5Lk-t_eITKqUcaxLL7jNzi9uTF
X-Proofpoint-ORIG-GUID: OYvRiO5Lk-t_eITKqUcaxLL7jNzi9uTF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDA4OSBTYWx0ZWRfX2o0FjEXqjg8D
 bCBAnVPtAjjX852f92ltk11cFyy9eCYq1L2ifpfUt6nKj6wX4gAnRwoq4CY4CYzUX/cy9zfgQlH
 bEGjcJ1pacmHIg7RG5GzblJRLdB2WSsF6OkoQ8/AwaHUTnnsgpR26EAV0hagwXbJ5cQTujqMG6F
 Pz8ajES+d3ANfzgccxN/1PNPopqiQYJWPDun+hX2gB+iLX38slG7u8dIzoV2yxPryy4T6jmxaou
 90ESeCq6gIQMUgdxzd1vXCQOh9foxsPjfDwAsXorKe6MI49W2Wp/6B6Ptux+FPtVFyoWsRNABTX
 3UcCtrCg65Yeh+1tbKaH95ZJhQJFS0Hb9MmFpUFtOZlzUBCoVRYCLsCiYAmg/zpIz4N+ZzC1eiN
 7/7qhyEUbtdCHU7am8Xf6AslxiCMeoTGz81TTvBVwhtS4eiCWkegmwd8LFHs2fAqh5gmLp5ViKM
 8JfNu4LHgy5bIEQ1Dww==
X-Orig-IP: 209.85.216.71
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 priorityscore=1501 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280089

MT7996 hands the firmware a HW MAC-TXP for ADDBA-req action frames
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
Signed-off-by: Yang Liu <liu.y@nyu.edu>
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
+     * DMA-ring cleanup for them instead (see commit message).
+     */
+    tx_info->buf[1].skip_unmap = !mac_txd;
     tx_info->nbuf = MT_CT_DMA_BUF_NUM;

     return 0;
-- 
2.53.0
