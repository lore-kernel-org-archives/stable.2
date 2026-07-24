Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1783EDAA0;
	Fri, 24 Jul 2026 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885172; cv=none; b=I//ojGde8O5IPHSqTk9S368zCqJzdhHhQ0nq9PWkm8bLgUUPt77HyEw9OGTnV+yEKGQRzSBbIbe4iovPwaBLl8FgCLBLbggSwqBJ310JLgrqFQcv/ZMIZ8u0TP+UJC+BvRNMlDQFFh/lrv0LVfFUlKtNbXdq1p3y93kbEUFh160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885172; c=relaxed/simple;
	bh=drXljy61xDN6zke+J1JKPUvou8TShhwpl9OB2ppSrw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsnF0Bkjwuvmviszmj0asjzXrG438TDpz405bG2M4RtyGCYW5gDf/iJXpF9kVLwKPgNfEAKRSzAq0jgpoedZcmk0dwrP9+UFXn9OZ5KAlOyw++66lOfBSwGWfZ7EEHIoc6y8lsrJC1IUiB3tNGfjknG+B05PYD1q9kdm69m33Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: acf78b46874111f1aa26b74ffac11d73-20260724
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
X-CID-O-INFO: VERSION:1.3.12,REQID:d1d971ef-e0d3-43ae-aac2-a6d42c736a89,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:d1d971ef-e0d3-43ae-aac2-a6d42c736a89,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:e6e350f9cebe034f045e12c66c461c69,BulkI
	D:260724172559EM6LYIJM,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|865|89
	8,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: acf78b46874111f1aa26b74ffac11d73-20260724
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 165337671; Fri, 24 Jul 2026 17:25:56 +0800
From: Can Peng <pengcan@kylinos.cn>
To: arend.vanspriel@broadcom.com
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: Set DMA direction for msgbuf packet IDs
Date: Fri, 24 Jul 2026 17:25:30 +0800
Message-ID: <20260724092530.674624-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brcmf_msgbuf_init_pktids() takes the DMA direction from its callers,
but never stores it in the packet ID state.  Since the state is zeroed,
pktids->direction remains DMA_BIDIRECTIONAL for both the TX and RX
packet ID pools.

All msgbuf packet ID map and unmap paths use pktids->direction.  As a
result, TX buffers requested with DMA_TO_DEVICE and RX buffers requested
with DMA_FROM_DEVICE are mapped and unmapped as DMA_BIDIRECTIONAL
instead.

Store the caller-provided direction when initializing the packet ID
state.

Fixes: 9a1bb60250d2 ("brcmfmac: Adding msgbuf protocol.")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index ba1ce1552e0f..c1feb164d845 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -310,6 +310,7 @@ brcmf_msgbuf_init_pktids(u32 nr_array_entries,
 	}
 	pktids->array = array;
 	pktids->array_size = nr_array_entries;
+	pktids->direction = direction;
 
 	return pktids;
 }
-- 
2.53.0

