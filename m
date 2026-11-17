Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937238;
	b=whlLU3yZnwlf2yqJ6wdvuNHH4mkHRDYI0b2nTyuzWQmh2o3M1yiS6/6Qe6frJNwt9BKr
	 O2HlPnPdlcf2u0zP6rLBMjK/xzWLGHv5wobN42M/PvSABA7u0dcWWvejHC3lV3FwZLao8
	 5ZvNIkv8pIw9WrbwnyoH2iD2PTDKzQc3VTSbNSuGlwuSTSp2tiZcqw2qrLmu1uqNeObfU
	 2GSruBvg3xqEZYJW0ZT8t+lo5wxN2kZPOdBu6Nf7mZjHb2Dk0DGfaobsJfTK5wsbFlZyE
	 oBoPR8Rh2WkjwYZVWwNzFS2sReU/hYVuqNjozalGNHsCn0ij4Lsyt+ehxUig9UusubA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937238;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gdGXhDc04esq8UKmQV0Kr8mQHHzjU1OgZnFCkRowno4=;
	b=XSiI2fBqx3m5laGnDuYA0oA2UbifhN8RG72Lgw1wRnJX+IhGLaAiYf8C5iUYWLNupe1c
	 6/+i1RTn0geQlYhYEXwiMYltli8xQBfpA1W0H075TFJVS/pBhWHYm/0xFXqb8xeTENjzU
	 L6A5u66ji4NmovCPMPLL5/Vfln5RpzWskXWL18z4UpKRbe+ZpAkvGyMwnkn4i7mJwRoME
	 D93gWsqAVGCBfR+ZUZXfYbedX94iFDqqV9cVjErYrNAzhwttRKamIzB4F3+qGFJLGJsdn
	 Pkfa8WLikHpANxksshQf2DFZJsoZUCMBo/xz9jRcErfeuzCquDG30B/VfMLz2xycYGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=E7kKFkhy;
	arc=none smtp.remote-ip=115.124.28.194
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0D606A335;
	Tue, 17 Nov 2026 17:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A0D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=E7kKFkhy
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794937229; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gdGXhDc04esq8UKmQV0Kr8mQHHzjU1OgZnFCkRowno4=;
	b=E7kKFkhy5j01OR3taQTOPOHfS8IdQv4hhqh6a8l3QvbdkV/4uagbhlg11gHWK1Nk57MNZ3co/DXGTVWlZM9NdM06dskoVePUFbsw8mafbMSUBSoDfZ+5XkgO3w8pSDhqdEpx6YFNY1SyS0cZrPpRjEm+sSApsKKofvbrdmS/1wY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04441534|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00516513-0.000828919-0.994006;FP=15856795541377683968|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k4BATFD_1794937220;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k4BATFD_1794937220 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 18 Nov 2026 01:40:28 +0800
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
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH net v2 1/5] net: wwan: iosm: validate the MUX DL block length
Date: Wed, 18 Nov 2026 01:39:36 +0800
Message-ID: <20261117173940.34970-2-fangxy@xiaopeng.com>
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
index 0bbd41263cc2..5c33171ca701 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -696,6 +696,11 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 	if (!skb->data)
 		return;
 
+	if (skb->len < sizeof(signature)) {
+		dev_err(ipc_mux->dev, "invalid MUX block length %u", skb->len);
+		goto free_skb;
+	}
+
 	/* Decode the MUX header type. */
 	signature = le32_to_cpup((__le32 *)skb->data);
 
@@ -704,15 +709,24 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
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
 
@@ -720,6 +734,7 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 		dev_err(ipc_mux->dev, "invalid ABH signature");
 	}
 
+free_skb:
 	ipc_pcie_kfree_skb(ipc_mux->pcie, skb);
 }
 
-- 
2.50.1

