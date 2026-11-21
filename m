Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795270760;
	b=KVD1qOcp/dBNF36r0lVQ5zC0yLQWaVhPD376RkV1/C6tLmm3ULcWb/Auh6xiMrW17g1l
	 EInEF6b0ASVmVMX+1VfTA1xm6H25KO5FbbTaaOggA2aGMel8/4iKKEraqLzW35vGeTR+B
	 00agzoBbVicuOFp5txN4zGSo3HxU1LqoPXMyM2En5VZbrwDaGRtQtOImRj6XM73VgdH1C
	 9IleYiSfrMHsMg0hEkbStIbXJPnUalTaNX9AnCIZnHpyPGe1uomrE3LhOgdlxqGJIEusM
	 tTs8LSCmn3autvFN31msl6YRp5iE1W4MwodLmGj6FrW1xVeCvuS4M71N7nukBxTCG6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795270760;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gdGXhDc04esq8UKmQV0Kr8mQHHzjU1OgZnFCkRowno4=;
	b=WgzGPnkm4EGoUJWzgneyvzY0TSCF6I2EPu6I13IPS/GAYNDhd1YSVBqVaIixXdl1n1F/
	 Ab1UtkYwqcnuBt508JAqPDrRA4u3WchFfH6DfKS2rsxnet1PQo//qQpHmYwVuSjdJbktS
	 OVuo9wtufbQp4mbEmGq4zFQ33jCcZEb/YRCd9nVtQ9b/s5+L8PG8tiFTd8CbGdr3ngchF
	 UGiQa9mTW6bo/+Qx3oT1xOFx6A4chnyXBmw5rNyeKr8iFbUexvJLztq/dWAyreDObMIdE
	 2HBkFpepYyqRU+ELQsBMTpNQ2JIsDnc3ryj9fxuSCfeA61RwZNBvNshmGcyUhiS56lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=q+vfaZfN;
	arc=none smtp.remote-ip=115.124.28.1
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29B606A32A;
	Sat, 21 Nov 2026 14:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F29B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=q+vfaZfN
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795270747; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gdGXhDc04esq8UKmQV0Kr8mQHHzjU1OgZnFCkRowno4=;
	b=q+vfaZfNrfOnOTWOZOI3tQX8YdZ+dpgmH4EPKiiKFqDSYt5q5gcjM9DLVxMEIz8R8Qjdf7ZPVUKcN3qGMwICZz/Krz3NydqcJbeFC2zrgQKQ21u/+BesgdMuEnnX5kB5HvRWY9ZWR3JRaT0IdCW+hk6ZAkjQdd6l84zmu9aWaeg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0444128|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00516513-0.000828919-0.994006;FP=15856795541377683968|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k7GCEW8_1795270743;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k7GCEW8_1795270743 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 22:19:06 +0800
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
Subject: [PATCH net v4 1/5] net: wwan: iosm: validate the MUX DL block length
Date: Sat, 21 Nov 2026 22:18:46 +0800
Message-ID: <20261121141850.73754-2-fangxy@xiaopeng.com>
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

