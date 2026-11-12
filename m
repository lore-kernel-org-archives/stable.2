Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487937;
	b=LBk1wtF49eGcGAoYDH530a442DFPOncihaT2wZlQjU0dMcEoy+1ZSanWHA+vo4Ot6Mi4
	 NpuQ7nR1aVLLocFK4bvWwx1kCgvY4tvZXfQGDlqzh4rR+ObnP+apGEKKdBTqCS8zIiII5
	 /TCZHUlbObTRE1+TqARL/If1QClHAKlI2j8EAYo0fWCB/m1i00mL2mx51borusSLzIVi5
	 0Z3vYswvfu0p4Hppc58I1CBiHr4CNtbkx0cRugeyFNjanC3Vm8wPXQUHaido5eCfMEQwb
	 tAJqxBvq50orkEeHFJzCeYI3VM49OpfMvyBq5rVACrjKcWSI4a528Z5MWFIuZu28mpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487937;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3ZzRM1TMy4CKf0OK/aVurv3ZPAdZhi/gagQSrUOe9K4=;
	b=iEhsdIuYQzAWach7B0G2VoVs3DsaTFXARSI7hgUqqcEQnJjdI9GayKfqzWOjVDeQn0r4
	 xCReBAU0AcmuCMY5MpkJanrfacx1PdDudkdHFnoG50q0VRWv/L9xfI+486NJwjEYy4lsE
	 VghI+0niBJEnrYQRYTt34SHOPvvzbb2sxDHpX/fiTrU2W+JpTFl7mWqt9yFXvpr6ITVP8
	 pmrfHYFsKruzTad/w76syGdzYtkWZvuuLMJO4U1K1HSknwpyExxd/we/SQxOSxPtXauiN
	 MZEuFPuOfa4YJ15DXCYl8S8SkwWgQ4Xry2dNYYEPGJCaLZURUE4HD1908hTueCri6ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ZFaUef42;
	arc=none smtp.remote-ip=115.124.28.169
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8E606A330;
	Thu, 12 Nov 2026 12:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7A8E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=ZFaUef42
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794487928; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3ZzRM1TMy4CKf0OK/aVurv3ZPAdZhi/gagQSrUOe9K4=;
	b=ZFaUef42PTXFC/rCUbu1u7MC89hqet0aVXbpX/s6/gilcsEqiTASzgaF8/a+Efr5wB5y8gkpdoQbsXs0JEQ8g5Y7rZPNC25E0btYFsQbPzDKA602mOmb9RYv4jIvjcSm9PJZzxztdu+3Pw+6PRkxnnlVBlBlgIv5u6k5aJGpz7o=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.05054769|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00426958-0.000982241-0.994748;FP=2075142655635132128|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.k0cpdce_1794487926;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k0cpdce_1794487926 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 20:52:07 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Simon Horman <horms@kernel.org>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH net 2/5] net: wwan: iosm: validate the ADGH datagram length
Date: Thu, 12 Nov 2026 20:51:58 +0800
Message-ID: <20261112125201.1019-3-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261112125201.1019-1-fangxy@xiaopeng.com>
References: <20261112125201.1019-1-fangxy@xiaopeng.com>
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
adgh_len - packet_offset to the network stack as the payload size of the
cloned skb, without bounding adgh_len at all. When the device reports a
datagram shorter than the ADGH header plus its negotiated padding, the
subtraction wraps to a huge u32, skb_trim() refuses the length and keeps
the clone unchanged, and the stack gets every byte left in the block
instead of the declared payload. A length beyond skb->len is nonsense
that the driver passes on as well.

Require the datagram length to cover packet_offset and to fit into
skb->len, and drop the block otherwise.

Fixes: c34ca4f32c24 ("net: wwan: iosm: fix incorrect skb length")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index 5c33171ca701..b573067a366f 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -473,6 +473,15 @@ static void ipc_mux_dl_adgh_decode(struct iosm_mux *ipc_mux,
 	if_id += ipc_mux->wwan_q_offset;
 	adgh_len = le16_to_cpu(adgh->length);
 
+	/* The device supplied length bounds the datagram. It has to
+	 * cover packet_offset and fit into the received block.
+	 */
+	if (adgh_len < packet_offset || adgh_len > skb->len) {
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

