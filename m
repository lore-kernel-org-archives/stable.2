Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172175;
	b=yTOaNgKY3w5xLKfjHzsW74Pq3nFIebwnG4hEj3frf2wSlMG+WFeBw2X+9rxvIBt7Onhc
	 6zGwaA/nDfiuLw863GlfiHM0rCx1cStAm2Pmtm75zhiZr9n9z/tm6EkiuiW8ZsZgG8mQc
	 lhOcT8pqbDigxAioXW+gnq7AFJOmtsioKzw6erLD+ZxTKhUf+Y6UxPtEbK4NyaYsu+QHs
	 9IQvIgvCVH6gQ56Zdyrbe8qMjNTRvhGZ6s1XHzC+ysaEccR5r8pYlDifNzv8PPsmctPdK
	 IaGmWQtnsu7HkuAtQtGN1n/hwR27pZ6t7I4YunF4ISrPyCraa/aGl7IHDyNhQlY5R7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172175;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GiKbzD9l+ggvDg/9PLZOf99d7KW4cE2ZMfMaaXrLzAg=;
	b=gT6R2zzu4zzCyUc2QGst4RAiSXmPLreDS6ULwLPcwege056iH/ZjZ66n3KTd4YzyvBgh
	 WFT9zcTPrOOQbFkjLz9UQ5ZFjru9tT1RAPP//7ojWXNJZj88FQzLIiJyVvTBwAXjPgL4V
	 UGnO0H7iZwQiEnjHrPpT9NMJU473DbuWG3bhZlOM5/4HUGABM7W75W0TeKLpWiJSy0XQw
	 DftyDdveWnx9/On1Sn9g1OYtfj/gpvu0KH0awAdLhiTTvu5NM9fIJ0dsSdGgVcA5KvWO/
	 Yv+ighTy2u65kRKDkQhtBB4BQcOX+uWiINxPiZUSb2gwkqz+4rl2ofUMLjEK+Q1ffnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DXtDOwdi;
	arc=none smtp.remote-ip=115.124.28.76
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F69606A33B;
	Fri, 20 Nov 2026 10:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F69606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DXtDOwdi
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795172165; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GiKbzD9l+ggvDg/9PLZOf99d7KW4cE2ZMfMaaXrLzAg=;
	b=DXtDOwdi26wawFbjii4DI7KXe7NIzg7tL14yyPe324rD+XXLrOxsiyVfqvOidusP8CwwdkOl23wMYHWRwPPwMuEo1p3p/e8DJMHEKNO0JVG4dMC2ZYNlL42P012RBYZMrOcU72xxmcRSTawqlpkp9ljM3U1M6qkHl74PSlP7XW8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04446936|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00378321-8.81247e-05-0.996129;FP=14275886403969664128|1|1|4|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k6Wwa49_1795172163;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k6Wwa49_1795172163 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 18:56:04 +0800
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
Subject: [PATCH net v3 3/5] net: wwan: iosm: bound the ACBH command chain walk
Date: Fri, 20 Nov 2026 18:55:57 +0800
Message-ID: <20261120105559.54519-4-fangxy@xiaopeng.com>
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

ipc_mux_dl_acb_decode() walks the command chain of a received
Aggregated Command Block. first_cmd_index is passed through
array_index_nospec() with sizeof(struct mux_cmdh) as its bound, which
treats a byte offset as an array index and drops every command at or
beyond that offset. next_cmd_index is not validated, so the walk can
read past the end of the skb, loop on an earlier command, or decode
the header just read as a second command.

Bound every command offset by the received length and require room
for a complete command header. Validate the next index before
processing the command carrying it: it has to advance past the
current header and leave room for a complete next header, and only
zero terminates the chain. The offsets then strictly increase and the
walk terminates. The array_index_nospec() call is removed and
block_length is only sanity checked.

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 46 ++++++++++++++++++----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index 341c58b851cb..f1a742b20eab 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -526,30 +526,60 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
 /* Decode an aggregated command block. */
 static void ipc_mux_dl_acb_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 {
+	size_t hdr_len = offsetof(struct mux_cmdh, param);
 	struct mux_acbh *acbh;
 	struct mux_cmdh *cmdh;
-	u32 next_cmd_index;
+	u32 block_length, cmd_index, next_cmd_index;
 	u8 *block;
 	int size;
 
+	if (skb->len < sizeof(struct mux_acbh))
+		return;
+
 	acbh = (struct mux_acbh *)(skb->data);
 	block = (u8 *)(skb->data);
+	block_length = le32_to_cpu(acbh->block_length);
 
-	next_cmd_index = le32_to_cpu(acbh->first_cmd_index);
-	next_cmd_index = array_index_nospec(next_cmd_index,
-					    sizeof(struct mux_cmdh));
+	/*
+	 * The uplink encoder leaves block_length at the ACBH header size.
+	 * It cannot delimit the command chain, so use skb->len to bound
+	 * the command offsets.
+	 */
+	if (block_length < sizeof(struct mux_acbh) || block_length > skb->len)
+		return;
+
+	cmd_index = le32_to_cpu(acbh->first_cmd_index);
+
+	while (cmd_index != 0) {
+		/* Past the block header, and a full command header fits. */
+		if (cmd_index < sizeof(struct mux_acbh) ||
+		    cmd_index > skb->len ||
+		    hdr_len > skb->len - cmd_index)
+			break;
 
-	while (next_cmd_index != 0) {
-		cmdh = (struct mux_cmdh *)&block[next_cmd_index];
+		cmdh = (struct mux_cmdh *)&block[cmd_index];
 		next_cmd_index = le32_to_cpu(cmdh->next_cmd_index);
+
+		/*
+		 * The next index has to move past this header, stay inside
+		 * the received data and leave room for a header of its own.
+		 */
+		if (next_cmd_index != 0 &&
+		    (next_cmd_index <= cmd_index ||
+		     next_cmd_index - cmd_index < hdr_len ||
+		     next_cmd_index > skb->len ||
+		     skb->len - next_cmd_index < hdr_len))
+			break;
+
 		if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, cmdh->param,
 						       cmdh->command_type,
 						       cmdh->if_id,
 						       cmdh->transaction_id)) {
-			size = offsetof(struct mux_cmdh, param) +
-				sizeof(cmdh->param.flow_ctl);
+			size = hdr_len + sizeof(cmdh->param.flow_ctl);
 			ipc_mux_dl_acbcmd_decode(ipc_mux, cmdh, size);
 		}
+
+		cmd_index = next_cmd_index;
 	}
 }
 
-- 
2.50.1

