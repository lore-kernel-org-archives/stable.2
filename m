Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DE32C8B;
	Thu, 23 Jul 2026 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786214; cv=none; b=YFV3wcLA0tdTCeBv+PMRfhzE4oAR83SX05mPjUHpZiHCzmXzmKgT4O8nAOuD+LtI/nEY1GtAEWW/97LENkE54njHSfLK84E1jkWxfkdWz3svLLfGMPQLzi/KSKjYRYg3B9+eq8K2Iuf/KCbvoQgRqta6z6fIxL6+5RytGXR+bDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786214; c=relaxed/simple;
	bh=Cqk1ptQtxj4qk/xkEuPbGl6DAS7KDJCCIj4ljvzUlck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0LLgj4tJjGhgfOs5UyigdFt8sbHO4H3P+dF2PdoMUa2Rp0xs2mNhkrONOcuqrkQBh6Q/g+xHiwYftXVq6dRzM3ZLU1JEe8ayW6W0S216aniaBGepCxl55A4pyImSj0s5NVX3bpQFxW5kQVedHcxa/IwjY2PfJ16/kpNgx5jxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 486208e6865b11f1aa26b74ffac11d73-20260723
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7127cefc-d1ad-41d8-8d61-1b111faf8609,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:7127cefc-d1ad-41d8-8d61-1b111faf8609,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:800708d5eeef0dfb32c2f880fb7051e1,BulkI
	D:2607231356460W1D820V,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|865|89
	8,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:1,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 486208e6865b11f1aa26b74ffac11d73-20260723
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 729145037; Thu, 23 Jul 2026 13:56:43 +0800
From: Can Peng <pengcan@kylinos.cn>
To: arend.vanspriel@broadcom.com
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: brcmfmac: validate msgbuf flowring IDs before use
Date: Thu, 23 Jul 2026 13:56:17 +0800
Message-ID: <20260723055618.550834-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware messages carry flow_ring_id values which brcmfmac converts
to an internal flowid by subtracting
BRCMF_H2D_MSGRING_FLOWRING_IDSTART. The resulting value is used as
a bit index in txstatus_done_map and as an array index into
msgbuf->flowrings and the flowring state.

Validate the firmware supplied flow_ring_id before using it. This
prevents flow_ring_id values below BRCMF_H2D_MSGRING_FLOWRING_IDSTART
from underflowing and rejects values outside msgbuf->max_flowrings.

In the tx status path, complete the packet with an error after
removing a valid packet id so the skb is not leaked when the flow
ring id is invalid.

Fixes: 9a1bb60250d2 ("brcmfmac: Adding msgbuf protocol.")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c  | 46 +++++++++++++++++++---
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index ba1ce1552e0f..8146d50d6f07 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -560,6 +560,28 @@ brcmf_msgbuf_remove_flowring(struct brcmf_msgbuf *msgbuf, u16 flowid)
 	brcmf_flowring_delete(msgbuf->flow, flowid);
 }
 
+static bool brcmf_msgbuf_get_flowid(struct brcmf_msgbuf *msgbuf,
+				    u16 flow_ring_id, u16 *flowid)
+{
+	u32 id = flow_ring_id;
+
+	if (id < BRCMF_H2D_MSGRING_FLOWRING_IDSTART) {
+		bphy_err(msgbuf->drvr, "invalid flowring id %u\n",
+			 flow_ring_id);
+		return false;
+	}
+
+	id -= BRCMF_H2D_MSGRING_FLOWRING_IDSTART;
+	if (id >= msgbuf->max_flowrings) {
+		bphy_err(msgbuf->drvr, "invalid flowring id %u\n",
+			 flow_ring_id);
+		return false;
+	}
+
+	*flowid = id;
+	return true;
+}
+
 
 static struct brcmf_msgbuf_work_item *
 brcmf_msgbuf_dequeue_work(struct brcmf_msgbuf *msgbuf)
@@ -880,17 +902,23 @@ brcmf_msgbuf_process_txstatus(struct brcmf_msgbuf *msgbuf, void *buf)
 	struct msgbuf_tx_status *tx_status;
 	u32 idx;
 	struct sk_buff *skb;
+	u16 flow_ring_id;
 	u16 flowid;
 
 	tx_status = (struct msgbuf_tx_status *)buf;
 	idx = le32_to_cpu(tx_status->msg.request_id) - 1;
-	flowid = le16_to_cpu(tx_status->compl_hdr.flow_ring_id);
-	flowid -= BRCMF_H2D_MSGRING_FLOWRING_IDSTART;
+	flow_ring_id = le16_to_cpu(tx_status->compl_hdr.flow_ring_id);
 	skb = brcmf_msgbuf_get_pktid(msgbuf->drvr->bus_if->dev,
 				     msgbuf->tx_pktids, idx);
 	if (!skb)
 		return;
 
+	if (!brcmf_msgbuf_get_flowid(msgbuf, flow_ring_id, &flowid)) {
+		brcmf_txfinalize(brcmf_get_ifp(msgbuf->drvr, tx_status->msg.ifidx),
+				 skb, false);
+		return;
+	}
+
 	set_bit(flowid, msgbuf->txstatus_done_map);
 	commonring = msgbuf->flowrings[flowid];
 	atomic_dec(&commonring->outstanding_tx);
@@ -1237,13 +1265,16 @@ brcmf_msgbuf_process_flow_ring_create_response(struct brcmf_msgbuf *msgbuf,
 	struct msgbuf_flowring_create_resp *flowring_create_resp;
 	u16 status;
 	u16 flowid;
+	u16 flow_ring_id;
 
 	flowring_create_resp = (struct msgbuf_flowring_create_resp *)buf;
 
-	flowid = le16_to_cpu(flowring_create_resp->compl_hdr.flow_ring_id);
-	flowid -= BRCMF_H2D_MSGRING_FLOWRING_IDSTART;
+	flow_ring_id = le16_to_cpu(flowring_create_resp->compl_hdr.flow_ring_id);
 	status =  le16_to_cpu(flowring_create_resp->compl_hdr.status);
 
+	if (!brcmf_msgbuf_get_flowid(msgbuf, flow_ring_id, &flowid))
+		return;
+
 	if (status) {
 		bphy_err(drvr, "Flowring creation failed, code %d\n", status);
 		brcmf_msgbuf_remove_flowring(msgbuf, flowid);
@@ -1266,13 +1297,16 @@ brcmf_msgbuf_process_flow_ring_delete_response(struct brcmf_msgbuf *msgbuf,
 	struct msgbuf_flowring_delete_resp *flowring_delete_resp;
 	u16 status;
 	u16 flowid;
+	u16 flow_ring_id;
 
 	flowring_delete_resp = (struct msgbuf_flowring_delete_resp *)buf;
 
-	flowid = le16_to_cpu(flowring_delete_resp->compl_hdr.flow_ring_id);
-	flowid -= BRCMF_H2D_MSGRING_FLOWRING_IDSTART;
+	flow_ring_id = le16_to_cpu(flowring_delete_resp->compl_hdr.flow_ring_id);
 	status =  le16_to_cpu(flowring_delete_resp->compl_hdr.status);
 
+	if (!brcmf_msgbuf_get_flowid(msgbuf, flow_ring_id, &flowid))
+		return;
+
 	if (status) {
 		bphy_err(drvr, "Flowring deletion failed, code %d\n", status);
 		brcmf_flowring_delete(msgbuf->flow, flowid);
-- 
2.53.0
