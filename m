Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795270759;
	b=yz/oLldPKPdPF4wGVoKcyYMOfmqw+xBExy+3F9EfVAtd9hDZ9MwUf/4vm3PpYpNjPxNu
	 devJWnLFtPr5WVTwVofTcbcfqzdt8dzJxDLzXur8XbcGaRN3cqMNpHqz+B5Z20QReuNiB
	 z0reMOxfSZgQIia6ZfviCG1M+xmXYMCYDpggjy0PLitG/viwWDY5jlg4JqZ5X7zut4uDx
	 mGItkM2Im2fDs3gepfGUBK4EbHmdoPckRJB56sW+QpcIAPCh1UFGgbFmkGMhYrvuH9OUS
	 2itUKV+1huMFbO+HlRdMyozVjFhS2iCI42RC+zm3vNsiPh2bK3UIN7khq3E9t4kweDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795270759;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AyZSPZSAoyu0XMTrk6TSL45fPCkVoxP9QhoH2Zd6Zfo=;
	b=gw7waEgrd2Ay0hPjpEElJQxUMBLlCo22lfrIbBhhFsEdGTNuwEgfcgY5L2RTmptotRDM
	 N84s+irUU353LuXIPbCY3rBpcgnQgGuaWeuoFvTjlpchlSJxZka+LHOcgp5yYJtRiERoA
	 ZpUZViF2VpgHOPBxU94lPgrZyn4az8uhrJ4IrPSDEGuDNMglQRV6NmGoycsJW77PJmT6Q
	 Sb+mOhQsFcGzgQDeGqgpIR1ag/DEVs/OfzXyXpIoZdCBqq/8OdJZqRdYzj0W5SW9U+Wpd
	 3OTRM9f/+1Of1LgEJBb24OJbv+LrImeOh6WaN2JJoSq0AOaZIhT6XfJENyWGZ5Ti/oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="pjsVH/iO";
	arc=none smtp.remote-ip=115.124.28.4
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6022606A32C;
	Sat, 21 Nov 2026 14:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6022606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=pjsVH/iO
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795270749; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AyZSPZSAoyu0XMTrk6TSL45fPCkVoxP9QhoH2Zd6Zfo=;
	b=pjsVH/iOOVfb8Wqp7YXvv9oVrYDkuf72Nv+t7GFzg67WHcZF79UFvZn6/ZR12+1Vi8TV3dBpu5hKYx5YnfAsWo/VAcIR+LKSpunWuV2hih7L7UaVfShxda2t48mduQZ+4uQnIJYW6yMwxsCSqjkKyl5KD76fuMw+u1QTrqa+lhk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.05731619|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00349499-0.00128547-0.99522;FP=11260164001253854944|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040092104;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k7GCEYM_1795270746;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k7GCEYM_1795270746 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 22:19:09 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	johannes@sipsolutions.net,
	maoyixie.tju@gmail.com,
	zhugl3@xiaopeng.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/5] net: wwan: iosm: validate the ADGH datagram length
Date: Sat, 21 Nov 2026 22:18:47 +0800
Message-ID: <20261121141850.73754-3-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261121141850.73754-1-fangxy@xiaopeng.com>
References: <20261121141850.73754-1-fangxy@xiaopeng.com>
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

ipc_mux_dl_adgh_decode() takes adgh->length from the device and hands
adgh_len - packet_offset to the network stack as the payload size of
the cloned skb, without bounding adgh_len. A length below the header
plus its negotiated padding wraps the subtraction, skb_trim() keeps
the clone unchanged and the stack gets the whole rest of the block. A
length equal to packet_offset yields a zero length clone that
ipc_wwan_receive() still reads skb->data[0] from.

Require the datagram length to exceed packet_offset and to fit into
skb->len, and drop the block otherwise.

Fixes: c34ca4f32c24 ("net: wwan: iosm: fix incorrect skb length")
Cc: stable@vger.kernel.org
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index 5c33171ca701..65421f6b4c91 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -473,6 +473,15 @@ static void ipc_mux_dl_adgh_decode(struct iosm_mux *ipc_mux,
 	if_id += ipc_mux->wwan_q_offset;
 	adgh_len = le16_to_cpu(adgh->length);
 
+	/* The device supplied length bounds the datagram. It has to
+	 * exceed packet_offset and fit into the received block.
+	 */
+	if (adgh_len <= packet_offset || adgh_len > skb->len) {
+		dev_err(ipc_mux->dev, "invalid ADGH length %u, skb len %u",
+			adgh_len, skb->len);
+		return;
+	}
+
 	/* Pass the packet to the netif layer */
 	rc = ipc_mux_net_receive(ipc_mux, if_id, wwan, packet_offset,
 				 adgh->service_class, skb,
-- 
2.50.1

