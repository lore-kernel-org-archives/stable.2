Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F368646D0AD;
	Fri, 11 Sep 2026 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117898; cv=none; b=iOens8HHybRkuqSnROSN9xiLyLCRQcu9Uo8RNok8eJYY1NfIa/8TXJK0sX+8cGfzX3kEOSyB1znZcyCzHe+0Yb/ZL77u+Ubp/GE+BOGlk2HLlmI/Nk1+EScFHzf2j7eASauOAJNE3PPn5x6lK8kMbmWv/RxO5ZgnyZm5Ldi2ZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117898; c=relaxed/simple;
	bh=c80gbTNgGfQZII2s+LPdlj1C/FICyHudXIPMWgOe/6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D86rCPZVt42cnm/dI2UbuZUg9WdIGFc+ULIGWOVrRm8BUjbSPIAlJ473w4yX/lupB3ZTNEPMdFRaELsaE1PRh8qpfV+WWfAy638LZwCTafZPTXEUZ8bHFHe7++OKaGQQzMijIujsFD/IzkLtEJosHoBPAbWJ+mTkmwWK2zXnLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c46f4a02adc011f19a56ed5b684f684d-20260911
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2d72926f-70de-435d-b517-7c99690b558d,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:ebf21e0efa857c9611e17beb6f56324b,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c46f4a02adc011f19a56ed5b684f684d-20260911
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1940728317; Fri, 11 Sep 2026 17:11:26 +0800
From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: txgbe: fix FDIR filter restore for VF rules
Date: Fri, 11 Sep 2026 17:11:23 +0800
Message-Id: <20260911091123.798931-1-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

txgbe_fdir_filter_restore() reprograms every filter from
txgbe->fdir_filter_list after a reset. It extracts the ring part of
filter->action with ethtool_get_flow_spec_ring() and maps it onto a
PF rx ring, silently dropping the VF part of the cookie that
txgbe_add_ethtool_fdir_entry() stores there (input->action =
fsp->ring_cookie).

For a rule directed at a VF, restore therefore reprograms the filter
to the PF queue with the same ring index: after any down/up or
txgbe_reinit_locked(), traffic matching the rule is steered to the
PF instead of the VF.

Handle VF rules the same way txgbe_add_ethtool_fdir_entry() does:
validate vf against wx->num_vfs and ring against
wx->num_rx_queues_per_pool, and map the ring onto the absolute
queue index ((vf - 1) * wx->num_rx_queues_per_pool) + ring.

Fixes: 7a91722e0dd4 ("net: txgbe: Support the FDIR rules assigned to VFs")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
index a84010828551..59a47532618c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
@@ -591,15 +591,24 @@ static void txgbe_fdir_filter_restore(struct wx *wx)
 			queue = TXGBE_RDB_FDIR_DROP_QUEUE;
 		} else {
 			u32 ring = ethtool_get_flow_spec_ring(filter->action);
+			u8 vf = ethtool_get_flow_spec_ring_vf(filter->action);
 
-			if (ring >= wx->num_rx_queues) {
+			if (!vf && ring >= wx->num_rx_queues) {
 				wx_err(wx, "FDIR restore failed, ring:%u\n",
 				       ring);
 				continue;
+			} else if (vf && (vf > wx->num_vfs ||
+				  ring >= wx->num_rx_queues_per_pool)) {
+				wx_err(wx, "FDIR restore failed, vf:%u, ring:%u\n",
+				       vf, ring);
+				continue;
 			}
 
 			/* Map the ring onto the absolute queue index */
-			queue = wx->rx_ring[ring]->reg_idx;
+			if (!vf)
+				queue = wx->rx_ring[ring]->reg_idx;
+			else
+				queue = ((vf - 1) * wx->num_rx_queues_per_pool) + ring;
 		}
 
 		ret = txgbe_fdir_write_perfect_filter(wx,
-- 
2.25.1

