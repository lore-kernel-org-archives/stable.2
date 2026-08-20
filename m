Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28841243964;
	Thu, 20 Aug 2026 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206925; cv=none; b=sZSvPFItegSW7RyMgtRHjBAaA1pZ6gAv10YZYAsgJ7UDLHgEwU1nuNw5a+r88NJO0MXi6uWNiGwOHCbYOk4LcW9WTcfzif8C9ca5ucLxLXX3/OCvuXCMrvfBeFE4ok6Fq2q2mQ9iXmGsGD2iyHXogQbQjaZKgUCyPGXqYclajHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206925; c=relaxed/simple;
	bh=PP+5zV7rnpsVE7kf043KXVMlMpTb4ithikiSuOtY6q4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S/PLrlR1T1/fzcXg5fEyxDGYNQIos3ZbUEU93ZA4uQxkpZNdaPwgsvaeA5/lQvumnlQGOy2dvuz0QJwch9+WhsYJ8pDNtL9q0kTF5LRsELMcZXJAaPk2cYpbZBxeMlYeNXeh5siX0J498b+r5tmJM2D60zruEkGl5buyykFFO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 733ed3549c5f11f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:563cafff-13e0-4332-96d4-44848cd7c0d7,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:5f13a2ee97072dd819cf445dc635087d,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50,EDM:-3|
	-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 733ed3549c5f11f19a56ed5b684f684d-20260820
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 733940770; Thu, 20 Aug 2026 14:21:59 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	David Lin <yu-hao.lin@nxp.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: prevent authentication frame length truncation
Date: Thu, 20 Aug 2026 14:21:55 +0800
Message-Id: <20260820062155.3981976-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mwifiex_cfg80211_authenticate() derives the authentication frame length
from req->ie_len and req->auth_data_len, both of type size_t, but stores
it in a u16.

NL80211_ATTR_AUTH_DATA only has a minimum length policy. Since nla_len is
a u16, a single attribute can carry up to 65531 bytes of payload, so the
sum can exceed U16_MAX before it is assigned to pkt_len. The truncated
pkt_len determines the skb frame area, while the copy length remains
req->auth_data_len - 4, resulting in a heap buffer overflow.

For example, with auth_data_len equal to 65510 and no IEs, the sum is
65546. It is truncated to 10 and then reduced by four to 6. The driver
appends only six bytes to the skb with skb_put(), but then copies 65506
user-provided bytes into the authentication body.

Reaching this path requires CAP_NET_ADMIN in the user namespace owning
the network namespace, an up station netdev, and a suitable BSS/SAE
authentication request.

Compute the length in size_t, reject values that cannot be represented by
the firmware's u16 frame length field, and only then assign it to pkt_len.

Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index abc703441c5d8..e4ad2e29f10e7 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4279,6 +4279,7 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct sk_buff *skb;
 	u16 pkt_len, auth_alg;
+	size_t frame_len;
 	int ret;
 	struct mwifiex_ieee80211_mgmt *mgmt;
 	struct mwifiex_txinfo *tx_info;
@@ -4351,10 +4352,17 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 
 	mwifiex_cancel_scan(adapter);
 
-	pkt_len = (u16)req->ie_len + req->auth_data_len +
+	frame_len = req->ie_len + req->auth_data_len +
 		MWIFIEX_MGMT_HEADER_LEN + MWIFIEX_AUTH_BODY_LEN;
 	if (req->auth_data_len >= 4)
-		pkt_len -= 4;
+		frame_len -= 4;
+
+	if (frame_len > U16_MAX) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "auth frame too long: %zu bytes\n", frame_len);
+		return -EINVAL;
+	}
+	pkt_len = frame_len;
 
 	skb = dev_alloc_skb(MWIFIEX_MIN_DATA_HEADER_LEN +
 			    MWIFIEX_MGMT_FRAME_HEADER_SIZE +

base-commit: 2812e64e1575e05500a35c405aaa6e99b7d7930b
-- 
2.25.1

