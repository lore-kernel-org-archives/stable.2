Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937240;
	b=JZYhau+WkL1BdZ4TcNPikI7m6Pr72h7xKOq5Js+3JuqrGJ/yWctAGM0RbsIU33PwBn9+
	 jDjOHGvB+rEl6s/5jGUH9HwdDj2xGev8PPyKKezCjhTzGW3HrA2o1MJhbXXEtAIdCvl3o
	 4UPJxQXomjRV5u3T68kZLb+WKW7+QOZHRqh//xMacxRpuXJrCnJmNXWgOHZ10Q0DfHi1W
	 H+9DQysYDxMk2nr8XGXo/1s4n7IwiBSSsOUXNT82tho41OKM+n7KFdXWQPSgk89IXbmPx
	 t8Xvu8cblACRpkXrZMs061VV7a7zyKXdCOv0AfKdbPGkcNWjC/Dn+GCyJa2RE64OD5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937240;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AyZSPZSAoyu0XMTrk6TSL45fPCkVoxP9QhoH2Zd6Zfo=;
	b=1QAgmX2yPW6txjQz4MEuESeZEy1V4FawwW+2MLbMXLvlQ4jre/FbLaGfozvRdM9pM1/3
	 i5jYf7+tFmPyG8tHk8Tbvln0FvCIQy3UoGoapJCd+ce6M77+V6CSzYgQAze4NN6sDjkV1
	 w8dyd6/giRFZKRYPkCn5FmzkU+D/1h0McSk+Lagd4h3p7v4bAC1GCYqw4o9JKYIIEZvqM
	 iKql+ARsnn4EiUwlPVhLpvN08jm2Qpk1uW+F00VyVsRWWFbOE626uVowrU/vLSXyyq8SA
	 JaOBADPI+GHrWIRRyJBfxNQXE4PdR7SMPM+JXJY81toCEsfrB6wsNutPJbrfs0704Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=oEj6iO0S;
	arc=none smtp.remote-ip=115.124.28.193
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC415606A881;
	Tue, 17 Nov 2026 17:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC415606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=oEj6iO0S
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794937231; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AyZSPZSAoyu0XMTrk6TSL45fPCkVoxP9QhoH2Zd6Zfo=;
	b=oEj6iO0Sl5CVpj/UQ7ndG2z/a5wWp3vmFtuZld8I7zgzi4QQZenpxkuAuCLj5rqQEqVOX8uFWjkcKqFjC38P+Js7vzdldLxXROZLoMKxvjYPhh4yy+L2rI1V9+d+E54y0HSGKKDYa05mv9MAiU6BDU9pwNCRuq+BSZ5+RXUiYY8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.05785682|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00349499-0.00128547-0.99522;FP=11296192970068365024|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032112;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.k4BATKx_1794937229;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k4BATKx_1794937229 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 18 Nov 2026 01:40:30 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/5] net: wwan: iosm: validate the ADGH datagram length
Date: Wed, 18 Nov 2026 01:39:37 +0800
Message-ID: <20261117173940.34970-3-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261117173940.34970-1-fangxy@xiaopeng.com>
References: <20261117173940.34970-1-fangxy@xiaopeng.com>
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

