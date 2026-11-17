Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937247;
	b=ygzYzeqnxKROcCJNB3kcjqWUbupCJ97BBr5RWB36cP4f/lI/gwzsMqysMMLGTthWkOsu
	 MQRfmYqPzIIZv3V4NOSVCswS161yEvOSNrkxhA43jgIqy/qiUlilaY+LeetXSKWAVNSZQ
	 KANBG/DQPdSmR5MVyPaKRhUC1vB1JsCkz8vQaXUKIUF8ivQweiXuAMhvpNYUiIJPRoViQ
	 E3VL3omrPwUB37N1dkR9LR7OAtwUqMCyLI+DEhnSfJdKA4wR7+qb9Z98k+f3Rys0inz+Q
	 NUCoNZxBuc36pvQq83qsYUgBi8ffmZhhXwk7cIjUzhom77SKekndpBfA0CJe8VXI0/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937247;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sY2qJlWUgcl94s52tJqGI+A6a5RUHPP55ZByRYq+1S8=;
	b=EPjKw5EOhamxf57NgXSTaM7vQgQRHgBOVbGjNrXdeMxzwuXNn52alSEG60o2O4utS9Hy
	 mO1MJxmlKxp0kTKh5aUZW6AreNTSUXezQ7LMlsQkp9MJGry+Q9UI5iWzqIrF8EXlY1SXu
	 oWjCAexkAKXHVruQs/ncBUuDxzwjNJ0FW10xoVMe33yUdxfwCFrWYqZQEuLhcFFQSGD7p
	 jWN7KqNPCyFXVbYPKOXJuQulGe5dRHMW6do05GHtnEI0BQukT2MAplA8wMziflkbn4KlS
	 D+P7jcdWdq+t2b1zD+FxFNGetKY1W4GQ7W4cJTlFSxJdnlcDv0d6u9yo8eRFNJnFNgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MpPfDKen;
	arc=none smtp.remote-ip=115.124.28.169
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27387606A894;
	Tue, 17 Nov 2026 17:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27387606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MpPfDKen
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794937237; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sY2qJlWUgcl94s52tJqGI+A6a5RUHPP55ZByRYq+1S8=;
	b=MpPfDKenGwO45iMH/xBv2/3tktwSQoeNy48lfcl8IAGRQMg1srinVbMGwUoCM6ZbQwTHfDFlahVxeBqUkw7AKlxl3/stgousbiChucTmi/Y8aEBPeTxkPdtJKsUmM/5sO3GPkcTn1kSvm9/yDKD1mIaY+N+DPjsCXupef9nj+CE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00498046-0.000196643-0.994823;FP=16021593803604885584|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.k4BATPd_1794937235;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k4BATPd_1794937235 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 18 Nov 2026 01:40:37 +0800
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
Subject: [PATCH net v2 5/5] net: wwan: iosm: validate the command parameter length
Date: Wed, 18 Nov 2026 01:39:40 +0800
Message-ID: <20261117173940.34970-6-fangxy@xiaopeng.com>
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
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 106 +++++++++++++++------
 1 file changed, 75 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index 3f93d7293785..592ff99b6c77 100644
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
@@ -315,19 +329,26 @@ static int ipc_mux_dl_cmds_decode_process(struct iosm_mux *ipc_mux,
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
-						    cmdh->command_type,
+						    param_len, cmdh->command_type,
 						    cmdh->if_id,
 						    cmdh->cmd_len, size)) {
 			/* Decoded command may need a response. Give the
@@ -494,8 +515,9 @@ static void ipc_mux_dl_adgh_decode(struct iosm_mux *ipc_mux,
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
@@ -503,32 +525,39 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
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
@@ -568,12 +597,27 @@ static void ipc_mux_dl_acb_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
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

