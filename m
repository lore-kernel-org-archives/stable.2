Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172173;
	b=iEIlzVROmsFoaEQYpzhKcevLLvqVyFnJW5rIcTf25kjPwPHLPmRErf60y+lYMknGlDpU
	 JbJYJu/e65zRJkyGtdLuFDYCk0pnqqaEzNYBcbngwOoxF7qhQW/ppuzxjHnWOBfDKMDgC
	 nUnqskeEmgoAMHn/vsvHIkQhu40LSamvM/bS1lrATfHeWSaaKgeAsa9GcNazA3aTwBC2a
	 fVCxgwYfugCpr5TqJ7+1LURYdu0wlxt9t0ezI2VDNy7S/Lvg4OJY/HGboBNp59eG9rPS2
	 J/VFgxqaKWDHnw705r9ifZHkE/CSBMmqzIgw/mANXaWQZLyop03/kr2DjUFF1hAANqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172173;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YNmhIN96G/XaUV9fy0P9SjX0B+4zL5Q0jDqnNZEKxz8=;
	b=ByBM4cbPK8PBjReRskCfR55VnWAMaf9PPpbv8AIW0+JDcsQKnMS8od9DOczq5cgERmNt
	 bkU3uhmrzrmh/C/rgg4pspuDMRNiVdc5t8Ha5Q/gKMqNZK8teLze3uoTM70YedvbTArMQ
	 DQ3Q/GTL9koHtsiGuGyy/jH4EUuch9oCae20i6iAX3R9Kbpf85qruQcbYP6m4gPTD7vJi
	 DfqOL6kqu/7YdS56mLX6Z0dXSsg3smyOxqogso1vwBDylLfKNyJRJ4uITmt2hp1lCqaRZ
	 C4UNakV12MExL003t8MvgRf/ve/4lGR36FrEMB/YPdF1nhm85CYw3ElCZucPy7ZeKhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="FtyeK/CD";
	arc=none smtp.remote-ip=115.124.28.172
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B30606A336;
	Fri, 20 Nov 2026 10:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08B30606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=FtyeK/CD
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795172164; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YNmhIN96G/XaUV9fy0P9SjX0B+4zL5Q0jDqnNZEKxz8=;
	b=FtyeK/CDxXGxyy4cVKK8fg6EjqsRODDOWLoHqZEFx/s+CI6y3seEM2e3r+Jc+W3XtTD0tl2HWFaSoIaXRZAqowXpIFuXpoB/r0zLZhuOetCF01EpUCtMawmNcoWN5fFAsLfVbAqndsRw7M62ZabXlypc3cS3co7HekMobryT2gA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.05407562|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00349499-0.00128547-0.99522;FP=11300766904079126240|1|1|4|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k6Wwa33_1795172162;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k6Wwa33_1795172162 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 18:56:03 +0800
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
	Guanglei Zhu <zhugl3@xiaopeng.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/5] net: wwan: iosm: validate the ADGH datagram length
Date: Fri, 20 Nov 2026 18:55:56 +0800
Message-ID: <20261120105559.54519-3-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261120105559.54519-1-fangxy@xiaopeng.com>
References: <20261120105559.54519-1-fangxy@xiaopeng.com>
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
index 1c5aae25f08f..341c58b851cb 100644
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

