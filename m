Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172173;
	b=RGlRYspJlC/KDtuYYOJHIyUFXs2XbV3lET4W/pa4WBCjhOHu2pBMcw5awR5oRNsYFCSp
	 k2KN7OPfobdexyMLzskxeleTnORhztbbmXXhdfsnaKcIqNRhMj2ni6g0bc52Vs2IU7N/4
	 0PXe6DeDMcA/y0q35j7k7G3RL3TVL+j4Gnouvam94U2TQUmtbeeXtc+nbHL1cU9JkohL+
	 /z7tElC1ShQON7yIoB+mZEzTsr0ZvRVHMFKIJ8gEx+rCLn6uTGp+stf/VQUoBAQk5hJTL
	 03fHbK/mnIRx5xjP2CF/iFOFsZz1EtzQ7+++tRNCX5rlNJlDsx6YcCTEb3KVQzKwcpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172173;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3cFlORKO4ZMUPJ7YeS0hbOVYAx1+1ovhhSAf8EKDuHs=;
	b=uzHzWYE+wdSgBhwdbVM11yaDnxJzO2iagVMa2pXSVXk+ov5REQYvMKtl+yDVhE+dGXwF
	 xGcqWjA0TR3h9O+jHTPjKujWQ5wp7tR7o68FRQbjk/5IcSE07G7OdE5dx62gpUwBGb719
	 9TWQkD8MG/io96A8zAGqxFRmvFFhR0nKcon6bp5ly8QMB2HizcMDWaHV+yVlKMqa+rHOv
	 sHaeRd3m2qdAqJNwBsmVwxvxg7jjs6Mc6upW4XXmzf0RKxSLIvOwcCZmnRe0MbsrUUW6p
	 ah2C0rtSQe97THc6uzi2UEcpaDN1b/90ouUK/jeFcuIAAxVGEkqpPjr1vt68Rr8itsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="pZqiPFV/";
	arc=none smtp.remote-ip=115.124.28.50
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AD606A337;
	Fri, 20 Nov 2026 10:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB4AD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=pZqiPFV/
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795172162; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3cFlORKO4ZMUPJ7YeS0hbOVYAx1+1ovhhSAf8EKDuHs=;
	b=pZqiPFV/Qncfi2P3lRh14T26vDvJehVJR+j8otLvcq7LhcYktxqOP3VGAWX0PS65Pvkzy8GDZUmXcyj9TCf4173TY3Y40bPQGad02tnX0orpZPuMygRY6V2AN7IRvbVjd+P85h9kFGVPKpW050IHFkKjYnE03fx7pSKZqoX9+fc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04441332|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00496029-0.000681013-0.994359;FP=6633282784209179140|1|1|4|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k6Wwa21_1795172161;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k6Wwa21_1795172161 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 18:56:02 +0800
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
Subject: [PATCH net v3 1/5] net: wwan: iosm: validate the MUX DL block length
Date: Fri, 20 Nov 2026 18:55:55 +0800
Message-ID: <20261120105559.54519-2-fangxy@xiaopeng.com>
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

The received length of a DL MUX block is supplied by the device and can
be shorter than the header its signature advertises. ipc_mux_dl_decode()
reads the four byte signature and then lets the decoders index their
header structures without checking skb->len, so a short block makes the
driver decode past the received data.

Check the signature before reading it, and check the header size of the
ADGH, FCTH and CMDH branches before dispatching to their decoders. The
ADB branch already validates its own headers, and the ACBH branch is
covered by the bounds checks of its command chain walk. A block too
short to carry its signature is dropped on the way to the single free.

Fixes: 9413491e20e1 ("net: iosm: encode or decode datagram")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index 2b8a22980c87..1c5aae25f08f 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -693,6 +693,11 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 {
 	u32 signature;
 
+	if (skb->len < sizeof(signature)) {
+		dev_err(ipc_mux->dev, "invalid MUX block length %u", skb->len);
+		goto free_skb;
+	}
+
 	/* Decode the MUX header type. */
 	signature = le32_to_cpup((__le32 *)skb->data);
 
@@ -701,15 +706,24 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 		mux_dl_adb_decode(ipc_mux, skb);
 		break;
 	case IOSM_AGGR_MUX_SIG_ADGH:
+		if (skb->len < sizeof(struct mux_adgh))
+			break;
+
 		ipc_mux_dl_adgh_decode(ipc_mux, skb);
 		break;
 	case MUX_SIG_FCTH:
+		if (skb->len < sizeof(struct ipc_mem_lite_gen_tbl))
+			break;
+
 		ipc_mux_dl_fcth_decode(ipc_mux, skb->data);
 		break;
 	case IOSM_AGGR_MUX_SIG_ACBH:	/* Aggregated Command Block Header */
 		ipc_mux_dl_acb_decode(ipc_mux, skb);
 		break;
 	case MUX_SIG_CMDH:
+		if (skb->len < offsetof(struct mux_lite_cmdh, param))
+			break;
+
 		ipc_mux_dl_cmd_decode(ipc_mux, skb);
 		break;
 
@@ -717,6 +731,7 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 		dev_err(ipc_mux->dev, "invalid ABH signature");
 	}
 
+free_skb:
 	ipc_pcie_kfree_skb(ipc_mux->pcie, skb);
 }
 
-- 
2.50.1

