Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795270764;
	b=uMauK85g9IfoDGbvMkMMsOrE+Ud7ml48pGRv/lTEWqHspSvwLqd//PX5fRwlD6GUXLc9
	 NKbABwaEl1OuZE3odD1P8WUUPirDZfKZ3awXsiEG3/Q+hoc26VZiSbx2NJ0FAopG0eOEN
	 BpzwPcbu5iJ60Xu6c81j/ZS7/SGEpz5GgjENz+Gw88nfWOnr86CHJUDo7gQO/IEgUME1t
	 AzPCttqKVTC0okIbSd1OPwa+QIaxyMxSf+Flu7V6uS78k+SHfJXkdThLBIFqfv8YtgCaM
	 OrMhH0ayLJTq7gMqAULKKzv3v96OUX+FlM/vWXpAkrkDEawconY0YvBzNr57DtNwrUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795270764;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dH3XbXnDqDUIiU7bFseXAANFSe3VoFujE+ufZbliiUE=;
	b=3j2Z2LOQUKd33/B3PAov8xrOhYgra103N+XfkvlkBw/6wvUbcDwvIdv3QiX2djl23BMz
	 iuTGO2+UTe1ypTRu42LsEZpKe/O7sJoTV82fIOv4CytfSKym9t77kRhPomHh/NU1i8y/L
	 Nhx8IaWukiAWCN7o1Usm1yYqn96vCHpVDtfdbTzr7oi/Reg5WPx8EipL8y3i2LxczmLGO
	 al0Ot3H/hPf9uRt9m8GFsg8ZFhHepn9Keb1V+/kzib6QtqCjlULDAs2j07CJH2yp8zeKf
	 jUfWjLcHhg+ZNYduTuP7p1oWEEjEwUMy4tOw9zPPZ1xZ4w55gON/yl5V9RfZ38wuLvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=j3CjG3SF;
	arc=none smtp.remote-ip=115.124.28.98
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C3606A33A;
	Sat, 21 Nov 2026 14:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D3C3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=j3CjG3SF
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795270753; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dH3XbXnDqDUIiU7bFseXAANFSe3VoFujE+ufZbliiUE=;
	b=j3CjG3SFZtXsjDmFZrw+ps4y2DMi30dT+MvJerfMc9/2ndbLy6N4i29ZwmG/4m+YeCquZi4aFMAz58v5RjqJaTI+XTRDXNIpADCJo8qKNA6EA7KFO17Vf4DUAFBOCHlGgjNxzbLaBLKhKbXMVp7d3M0isXy8Xg8FB/ZtgYWjT/c=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04449996|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00378321-8.81247e-05-0.996129;FP=14274760503927538816|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k7GCEaC_1795270749;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k7GCEaC_1795270749 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 22:19:12 +0800
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
Subject: [PATCH net v4 3/5] net: wwan: iosm: bound the ACBH command chain walk
Date: Sat, 21 Nov 2026 22:18:48 +0800
Message-ID: <20261121141850.73754-4-fangxy@xiaopeng.com>
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
index 65421f6b4c91..a8448e273c02 100644
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

