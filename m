Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795270770;
	b=fqAuq9/WfxfGR9/LYvaJk1ITh+eftKVDiaqo5libsxF1bO/SIsokuFwDgdrCE6wrKvJb
	 cUM3DOo5cHoRAP65umXMRocCoZ8EpXqPlRZL9iA4KZvANrIZH2rccqwULGhC7+8/N8zSL
	 rgLGPUVskp+AWranQo+cLFzVEvwM+Qr5eRcIshIu+EXd4FqQl/FLswMPXsuB6ooP8J2ag
	 0zqNOOzu98RQ6Qu93a/1JhxWwRcI3CeHQDaQKqSlkz/I08IQg0KJtr+518b9fR3jy1fmx
	 dRXm6IVNEntcRPQRRc9UWOuucasxtwvtN7ghgR6H5BrYry+W8u52mjeOCYwngq4Wvaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795270770;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EjP5V1wK+o8RHYcg61HZrDjyGwB3sEbKCFTcA45qvlY=;
	b=4S6sIJ3FM/cwKZREroc9+4eCwaWfnxza+pKgYXPRGbihjWwDv63jsiXvZfqdw7z9yTmV
	 nRurgDq5cLostI8g6Nxkop/AcsFvlf5yfJTNvRnaWgS+DeSm85x8zNZt9S1u+TE36vhfQ
	 jUqhT8h/+oiGevdFts3o8c5zace/PkbMSx9NDIpTBeiS+nJS2w1QQsQ5BEOobB3XPvAG9
	 lEusTtNMZIR+J1xWepEEWcyI7CiTSXs8WncOMTcCldGAu+bxoQzOkjz1I35KQD2zUjEZr
	 8BmdVf/iaGN8EJ/qevQSrXgS3sBeEKS0+NMOebcyfs4Ju0K+SW2FrxQjK5rhDPKNDJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=gd9wCmHy;
	arc=none smtp.remote-ip=115.124.28.221
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16875606A6BA;
	Sat, 21 Nov 2026 14:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16875606A6BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=gd9wCmHy
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795270758; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EjP5V1wK+o8RHYcg61HZrDjyGwB3sEbKCFTcA45qvlY=;
	b=gd9wCmHyXZRjp/iF6gmgwvSgdflrC8lXdDyosBFQNKcxFo2n5GC4EobRmTI4h0XYjLJl3fV9tatp4+zeEKm6guqdEduu02PNO8mgNaGevutT1niA6uIXZpqXRdk7pkaWg9LKuJLyqWBsP6rL1UYCrzA770E3hgfPn7OS/KxqT3I=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00490976-0.000198701-0.994892;FP=16021593803604901968|13|3|17|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k7GCEds_1795270755;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k7GCEds_1795270755 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 22:19:17 +0800
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
Subject: [PATCH net v4 5/5] net: wwan: iosm: validate the command parameter length
Date: Sat, 21 Nov 2026 22:18:50 +0800
Message-ID: <20261121141850.73754-6-fangxy@xiaopeng.com>
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
index 3f93d7293785..b2bd53c5ba30 100644
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

