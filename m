Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487944;
	b=Oogd8bY5W7Suunk0wEHDXvi56Gg0jJmyliVwogb5FOhvW3L0pRzg8RQcZNnnq/RII7J+
	 bUASKdjBi10QJ9HuYxM0N381xVrXNT+TpzHxZHa1+1JpjJJSqGEtxDcVR4S5QNVhCJL74
	 cGuXotTgWTDtsZof4qv9mKrLYnNMS0+XeU+oEtgKsVdUuKnSs52TRlTeE+jKo5p0M7Tss
	 I5nANNEjEqFS41nlcPmurjZQNov6z0ydQhJCK548RSs5ZSkRNzPSiLQ9+MjmTy91WVR84
	 owjp3HcjoIyNVpTvkyeeuWwGowbnIGiVT800cpmdxCwqbx7F5zu/vCulVLi7Y/FsMGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487944;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kGz2caQrn/oMaBFUZ5fLhiO81Wz2kqTnrt9ceNW8k3M=;
	b=ndUXV1PAwlBjdFVrH8lfEvqFVD7QqMa01yi0ZAWeTEtaDEd3jwsoRV8by1FuV2gN5YFH
	 mBjb8+AYKExDzQBo4d99aZSAa7MNBPYQtj8O8ijq6flT5RATzevfVFWAKNdTkhxLZIAHt
	 9DL5QEbHkoqRpaIqLjjIpbBCtYTLd5SafgCEjeYYjImUmGNj5HC4/ajGCToZctza/sykn
	 dwk/HJFiJkPnaAmiS4OVsCiKU19JIepegcxeV9+uI4DD1GbKWo9ML5dJLQlcKdwsRt47Z
	 8rYbKsWMjMCtAkabhmIb06NTbU5PG52Dq7i45iM0qkvYsPNGG62J/00yx7Zy/4b0ndQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="BFV8/T7l";
	arc=none smtp.remote-ip=115.124.28.98
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285860A260B;
	Thu, 12 Nov 2026 12:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A285860A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=BFV8/T7l
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794487932; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kGz2caQrn/oMaBFUZ5fLhiO81Wz2kqTnrt9ceNW8k3M=;
	b=BFV8/T7lCsoWR92vc5Saia6k34A4cTUyJv9NipV96jH2Zftc6Xi67Qn//IVuYJCVY2DUauuB/EDG70UIQWYRbgUGDdcBJQ+LPz3gcyxF6eh1afIOCSC2FKh1A5QRdPfY1IbGobgJYmzXJAxfbK45xix/yTg4bBIW4TSM8ca2UeI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00498463-0.000181134-0.994834;FP=16021593803602805072|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033065158064;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.k0cpdgF_1794487930;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k0cpdgF_1794487930 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 20:52:12 +0800
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
Subject: [PATCH net 5/5] net: wwan: iosm: validate the command parameter length
Date: Thu, 12 Nov 2026 20:52:01 +0800
Message-ID: <20261112125201.1019-6-fangxy@xiaopeng.com>
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

Both command decoders read members of the parameter union without
knowing how long the parameter actually is.
ipc_mux_dl_cmdresps_decode_process() and
ipc_mux_dl_cmds_decode_process() used to be handed the size of the whole
union or of the command header, which is a property of the structures,
not of the received command: an OPEN_SESSION_RESP truncated below its
twelve byte parameter copied bytes past the command into acb->got_param
and then resumed the session establishment waiting on it, and a FLOW_CTL
whose parameter does not fit left the flow control mask and the state of
the session built from whatever bytes followed.

Derive the parameter length from what the current command owns: for MUX
Lite the bytes cmd_len declares beyond the header, for a command of an
aggregated block the bytes up to the next command, or up to the end of
the received block for the last one. Both stay capped by the received
length.

cmd_len is not used as a per-command parameter bound in the aggregated
path: next_cmd_index is what identifies the next command, and the flow
control decoder already treats a cmd_len that does not match the header
and parameter size as a legacy device instead of as an error, so the
field is not a hard bound there. In MUX Lite, cmd_len bounds the
parameter only when it covers at least the header. The protocol asks for
0x10 or more, but a shorter value is not rejected: the received length
keeps the limit there, which preserves the handling the existing
backward compatible code gives legacy devices and is still tighter than
the unbounded read it replaces. That case stays silent, like the
compatibility handling itself.

Check the member each command type really uses against that length: the
two session responses by their own size, which differ, and the flow
control mask before it is read. A parameter too short for its command
type is returned as -EMSGSIZE and the callers no longer hand it to the
command decoder, so a known but incomplete response is dropped instead
of being retried as a command.

In an aggregated block, ipc_mux_dl_acbcmd_decode() used to swallow that
error: the command was not acted upon, but the walk went on to the next
one. It now returns it, so a block that declared a command it cannot
hold is not trusted for the ones behind it either. A command of unknown
type still returns -EINVAL, is tried as a command and the walk
continues, as before.

Fixes: 9413491e20e1 ("net: iosm: encode or decode datagram")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 116 +++++++++++++++------
 1 file changed, 85 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index aea4cd9ec20d..bd6c82746cc4 100644
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
@@ -315,19 +329,36 @@ static int ipc_mux_dl_cmds_decode_process(struct iosm_mux *ipc_mux,
 static void ipc_mux_dl_cmd_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 {
 	struct mux_lite_cmdh *cmdh = (struct mux_lite_cmdh *)skb->data;
+	size_t hdr_len = offsetof(struct mux_lite_cmdh, param);
+	size_t param_len;
 	__le32 trans_id = cmdh->transaction_id;
-	int size;
+	u16 cmd_len;
+	int ret, size;
 
-	if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, &cmdh->param,
-					       cmdh->command_type, cmdh->if_id,
-					       cmdh->transaction_id)) {
+	cmd_len = le16_to_cpu(cmdh->cmd_len);
+	param_len = skb->len > hdr_len ? skb->len - hdr_len : 0;
+	/*
+	 * A cmd_len below the header is not a usable declaration: the
+	 * received length stays the limit, as for a legacy device.
+	 */
+	if (cmd_len >= hdr_len)
+		param_len = min_t(size_t, param_len, cmd_len - hdr_len);
+
+	ret = ipc_mux_dl_cmdresps_decode_process(ipc_mux, &cmdh->param,
+						 param_len,
+						 cmdh->command_type,
+						 cmdh->if_id,
+						 cmdh->transaction_id);
+	if (ret == -EMSGSIZE)
+		return;
+
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
@@ -494,8 +525,9 @@ static void ipc_mux_dl_adgh_decode(struct iosm_mux *ipc_mux,
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
@@ -503,32 +535,39 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
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
@@ -568,12 +607,27 @@ static void ipc_mux_dl_acb_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
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

