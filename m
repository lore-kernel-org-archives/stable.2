Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487932;
	b=UPqFTAtJQutKKEPFHo9Rvo5eUMPwmrYTdmlfxVhqDw0FEdqoKK7NyfGMQsDwTeFoCZBh
	 0rAza/ttu8WFSdtfm8/jE/OMytDSntJhzZpjSXkjUrG8m0s32XuqVuIRhWmG9xwNLnWxX
	 LzP5jo6oeJQmsWRSLEF+Pb051CdeRL7FT2G6dmFedQqrJBSFwZfDaWR/3Q1ScUgrQw5Ts
	 kqI0YWU1Bw0wFCsv/hRF37saN7/isniw2K7Bx2Gly7WqcMjqQ4/1qIjFtCcLbrmzJTqwW
	 hKEv69/ffVpjXgEbugvonp60O69e9sc7es984fQRGJgCKfrcswf6wMiO/BokBPH1ikQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487932;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gdGXhDc04esq8UKmQV0Kr8mQHHzjU1OgZnFCkRowno4=;
	b=Zo7Gu8NQBLfMCzd+PzEvQUKkkXP4L1ZSiVzyC0OTIptdlfJ05rQuYgKD80TMcrkRexUP
	 xGoyrYSYH8h/c9mIwt4qBUgi4uRV2w+Vzrt/3nIypJa7+pEj6ni5bgMGnQNpEwhBJ9jOQ
	 JbPJtb7Jo9SKBamNWWyIYaSdToP6TjgGLe5cbaYihpo7i7hYavSwEWfMB23FARXyHbzvz
	 dkBl1Veqtr3jt6N4ei32LFfHQSPuoh6XJPOzYup6PQ3FkGk8oP+bqkVGXBKfouxmcS49/
	 RpH1u1W4A2xdJldaw+JgBDd4PV5gUk7/IyjdikZkGHciwDSYUZMK9l+JewKXG+yUEsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=OFOQl+s4;
	arc=none smtp.remote-ip=115.124.28.149
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48A606A31C;
	Thu, 12 Nov 2026 12:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C48A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=OFOQl+s4
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794487926; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gdGXhDc04esq8UKmQV0Kr8mQHHzjU1OgZnFCkRowno4=;
	b=OFOQl+s4IZCeKVqlyERusFyYfJpcmjDRyKwujPD9KsL/MUZa73ePiLueKml4CapiatXpTH3Z3giAD8OO06pY5I/ue6R9LxAZbd/vnz7VgNftbTH4KLTQfZaduVxLxNO9DUnvh8aE7Z4mWp98e28RbdoUdTVfj608bdugRtulRgM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04441183|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00516513-0.000828919-0.994006;FP=15856795541377683968|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.k0cpdbS_1794487924;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k0cpdbS_1794487924 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 20:52:05 +0800
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
Subject: [PATCH net 1/5] net: wwan: iosm: validate the MUX DL block length
Date: Thu, 12 Nov 2026 20:51:57 +0800
Message-ID: <20261112125201.1019-2-fangxy@xiaopeng.com>
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

