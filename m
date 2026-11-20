Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172177;
	b=KbmP1KcUA9R1dtaAtAZpPD340CykBe0AKoXx8l3QPVJAiLnUagBDv0CL1aRpULYk0gH0
	 eqeYnz0UORBLQNkkoSkAXO8LXRM6UD3pJbjlErXq0abmeQoA3vzGfyKmGAkER36PT9xdi
	 hKiw85GI370DVQwMMef4zTIgf7hloMlo/o2AhYWZTwdNr1dxw32VTLCsg0pbAh+WYbmZR
	 I2uiNw2o8tYad0w+gVSsb49U1Xl3s/u3Ba6j5MUBD3OJAaBkf55fHLyRI7nPyLlhG2rj5
	 b+G7HoEk6NB6K5V0ynaDR264toB70GRETpNxXHNtxd6xiGxU7bZ+RG346q+uO5KjA7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172177;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JoXJoxdHx8fE92ZvcU6qtOwGfUp0AD5mZGY95/KszNo=;
	b=ywOhQMIcAyiTpR+Z6sO0N5CMl+dRT/Pfaa4I9v9gqO+DnTW7Me1ZTbARd6DLiK46i7mY
	 6rYbm/J+/eO9M//6RaMjZ02xAGDgrPL/Fqp5B83Q6aj0sYCOBXlMXldiosSZR4bVXS66h
	 37cLZwIh5ECVu9vao/n6g+UjNVjrRbYAh+jK+qXUgNBJU5TZjMJjp21oUZmn2QS9UbMdj
	 vDuiwRtPswbie5l7O/1UjbyP130h40owCQajclK/lIbAeUj9qosulU+MKOX7hq0VLt42h
	 LE7eY/oJtW0kae9R1CCJEnkbxcSRQkxBCMJhliA21EVlth0oyO5dzygG+DRuTpSgpsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rQCfwbOo;
	arc=none smtp.remote-ip=115.124.28.146
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980860A2605;
	Fri, 20 Nov 2026 10:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0980860A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rQCfwbOo
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795172168; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JoXJoxdHx8fE92ZvcU6qtOwGfUp0AD5mZGY95/KszNo=;
	b=rQCfwbOoP2FzsWIj9p0d/OJILU7avJTRbPbcRLkySnXoouaxW32Ao+ZRl49TO2cxDBQbvMyz5UHuKOgjAUTkHXioNa5qBXETd2mljTGTNh2SrU4LkKqLicf1TXg5kDxfvnzFYmb1Rte4MVHIkDbvT/nooeOK6mTYugJqd9Y9Hj4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00490976-0.000198701-0.994892;FP=16021593803604885584|1|1|4|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k6Wwa6c_1795172166;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k6Wwa6c_1795172166 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 18:56:07 +0800
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
Subject: [PATCH net v3 5/5] net: wwan: iosm: validate the command parameter length
Date: Fri, 20 Nov 2026 18:55:59 +0800
Message-ID: <20261120105559.54519-6-fangxy@xiaopeng.com>
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

Both command decoders read members of the parameter union without
knowing how long the parameter actually is, so a truncated
OPEN_SESSION_RESP copies bytes past the command into acb->got_param
and resumes the session establishment waiting on it, and a short
FLOW_CTL builds the flow control mask from whatever bytes followed.

Derive the parameter length from what the command owns: the bytes
beyond the header in MUX Lite, the bytes up to the next command in an
aggregated block, or up to the end of the block for the last one.
Check the member each command type uses against that length and
return -EMSGSIZE when it does not fit; the callers drop the command,
and in an aggregated block the walk ends there. Unknown types still
return -EINVAL and the walk continues. cmd_len is passed to the
decoder unchanged.

Fixes: 9413491e20e1 ("net: iosm: encode or decode datagram")
Cc: stable@vger.kernel.org
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 105 +++++++++++++++------
 1 file changed, 75 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index 3c5b957893ab..4d7783a059d3 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -185,6 +185,7 @@ void ipc_mux_netif_tx_flowctrl(struct mux_session *session, int idx, bool on)
 
 static int ipc_mux_dl_cmdresps_decode_process(struct iosm_mux *ipc_mux,
 					      const union mux_cmd_param *param,
+					      size_t param_len,
 					      __le32 command_type, u8 if_id,
 					      __le32 transaction_id)
 {
@@ -192,9 +193,18 @@ static int ipc_mux_dl_cmdresps_decode_process(struct iosm_mux *ipc_mux,
 
 	switch (le32_to_cpu(command_type)) {
 	case MUX_CMD_OPEN_SESSION_RESP:
-	case MUX_CMD_CLOSE_SESSION_RESP:
+		if (param_len < sizeof(param->open_session_resp))
+			return -EMSGSIZE;
+
 		/* Resume the control application. */
-		acb->got_param = *param;
+		acb->got_param.open_session_resp = param->open_session_resp;
+		break;
+
+	case MUX_CMD_CLOSE_SESSION_RESP:
+		if (param_len < sizeof(param->close_session_resp))
+			return -EMSGSIZE;
+
+		acb->got_param.close_session_resp = param->close_session_resp;
 		break;
 
 	case MUX_LITE_CMD_FLOW_CTL_ACK:
@@ -229,6 +239,7 @@ static int ipc_mux_dl_cmdresps_decode_process(struct iosm_mux *ipc_mux,
 
 static int ipc_mux_dl_cmds_decode_process(struct iosm_mux *ipc_mux,
 					  union mux_cmd_param *param,
+					  size_t param_len,
 					  __le32 command_type, u8 if_id,
 					  __le16 cmd_len, int size)
 {
@@ -242,6 +253,9 @@ static int ipc_mux_dl_cmds_decode_process(struct iosm_mux *ipc_mux,
 	case MUX_LITE_CMD_FLOW_CTL:
 	case IOSM_AGGR_MUX_CMD_FLOW_CTL_DISABLE:
 
+		if (param_len < sizeof(param->flow_ctl))
+			return -EMSGSIZE;
+
 		if (if_id >= IPC_MEM_MUX_IP_SESSION_ENTRIES) {
 			dev_err(ipc_mux->dev, "if_id [%d] not valid",
 				if_id);
@@ -315,18 +329,26 @@ static int ipc_mux_dl_cmds_decode_process(struct iosm_mux *ipc_mux,
 static void ipc_mux_dl_cmd_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 {
 	struct mux_lite_cmdh *cmdh = (struct mux_lite_cmdh *)skb->data;
+	size_t hdr_len = offsetof(struct mux_lite_cmdh, param);
+	size_t param_len = skb->len > hdr_len ? skb->len - hdr_len : 0;
 	__le32 trans_id = cmdh->transaction_id;
-	int size;
+	int ret, size;
+
+	ret = ipc_mux_dl_cmdresps_decode_process(ipc_mux, &cmdh->param,
+						 param_len,
+						 cmdh->command_type,
+						 cmdh->if_id,
+						 cmdh->transaction_id);
+	if (ret == -EMSGSIZE)
+		return;
 
-	if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, &cmdh->param,
-					       cmdh->command_type, cmdh->if_id,
-					       cmdh->transaction_id)) {
+	if (ret) {
 		/* Unable to decode command response indicates the cmd_type
 		 * may be a command instead of response. So try to decoding it.
 		 */
-		size = offsetof(struct mux_lite_cmdh, param) +
-				sizeof(cmdh->param.flow_ctl);
+		size = hdr_len + sizeof(cmdh->param.flow_ctl);
 		if (!ipc_mux_dl_cmds_decode_process(ipc_mux, &cmdh->param,
+						    param_len,
 						    cmdh->command_type,
 						    cmdh->if_id,
 						    cmdh->cmd_len, size)) {
@@ -494,8 +516,9 @@ static void ipc_mux_dl_adgh_decode(struct iosm_mux *ipc_mux,
 	ipc_mux->session[if_id].flush = 1;
 }
 
-static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
-				     struct mux_cmdh *cmdh, int size)
+static int ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
+				    struct mux_cmdh *cmdh, size_t param_len,
+				    int size)
 {
 	u32 link_st  = IOSM_AGGR_MUX_CMD_LINK_STATUS_REPORT_RESP;
 	u32 fctl_dis = IOSM_AGGR_MUX_CMD_FLOW_CTL_DISABLE;
@@ -503,32 +526,39 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
 	u32 fctl_ack = IOSM_AGGR_MUX_CMD_FLOW_CTL_ACK;
 	u32 cmd = link_st;
 	u32 trans_id;
+	int ret;
 
-	if (!ipc_mux_dl_cmds_decode_process(ipc_mux, &cmdh->param,
-					    cmdh->command_type, cmdh->if_id,
-					    cmdh->cmd_len, size)) {
-		if (cmdh->command_type == cpu_to_le32(fctl_ena) ||
-		    cmdh->command_type == cpu_to_le32(fctl_dis))
-			cmd = fctl_ack;
-		else if (cmdh->command_type != cpu_to_le32(link_st))
-			return;
-
-		trans_id = le32_to_cpu(cmdh->transaction_id);
-		/* No response parameter is sent in the aggregated protocol. */
-		ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
-					 trans_id, NULL, 0, false, true);
-	}
+	ret = ipc_mux_dl_cmds_decode_process(ipc_mux, &cmdh->param, param_len,
+					     cmdh->command_type, cmdh->if_id,
+					     cmdh->cmd_len, size);
+	if (ret)
+		return ret;
+
+	if (cmdh->command_type == cpu_to_le32(fctl_ena) ||
+	    cmdh->command_type == cpu_to_le32(fctl_dis))
+		cmd = fctl_ack;
+	else if (cmdh->command_type != cpu_to_le32(link_st))
+		return -EINVAL;
+
+	trans_id = le32_to_cpu(cmdh->transaction_id);
+
+	/* No response parameter is sent in the aggregated protocol. */
+	ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id, trans_id,
+				 NULL, 0, false, true);
+
+	return 0;
 }
 
 /* Decode an aggregated command block. */
 static void ipc_mux_dl_acb_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 {
 	size_t hdr_len = offsetof(struct mux_cmdh, param);
+	size_t cmd_end, param_len;
 	struct mux_acbh *acbh;
 	struct mux_cmdh *cmdh;
 	u32 block_length, cmd_index, next_cmd_index;
 	u8 *block;
-	int size;
+	int ret, size;
 
 	if (skb->len < sizeof(struct mux_acbh))
 		return;
@@ -568,12 +598,27 @@ static void ipc_mux_dl_acb_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 		     skb->len - next_cmd_index < hdr_len))
 			break;
 
-		if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, &cmdh->param,
-						       cmdh->command_type,
-						       cmdh->if_id,
-						       cmdh->transaction_id)) {
+		/*
+		 * A command owns the bytes up to the next one, the last
+		 * one of the chain those up to the end of what arrived.
+		 */
+		cmd_end = next_cmd_index ? next_cmd_index : skb->len;
+		param_len = cmd_end - cmd_index - hdr_len;
+
+		ret = ipc_mux_dl_cmdresps_decode_process(ipc_mux, &cmdh->param,
+							 param_len,
+							 cmdh->command_type,
+							 cmdh->if_id,
+							 cmdh->transaction_id);
+		if (ret == -EMSGSIZE)
+			break;
+
+		if (ret) {
 			size = hdr_len + sizeof(cmdh->param.flow_ctl);
-			ipc_mux_dl_acbcmd_decode(ipc_mux, cmdh, size);
+			ret = ipc_mux_dl_acbcmd_decode(ipc_mux, cmdh, param_len,
+						       size);
+			if (ret == -EMSGSIZE)
+				break;
 		}
 
 		cmd_index = next_cmd_index;
-- 
2.50.1

