Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795270765;
	b=YbCkpOOfuDqayhsCMMkfpsfBGm6qbdntvfXUPFW7hd98wh+aI73mULU9SfBicuT2EaGz
	 3a4puouA5L0iK1f8w7cyzDpsV67EoqjgcroSokNwSGr+4My9TjTCbCwdBTlvfXDgVDEbG
	 CPqZPB9K9Yb0PV1NR+c20yDuvk5xIyvLsYUIL+kYT70yWqKkvLqUkNe86y35Zkq1YG3ho
	 qO6YqsRLOqvLunNnvTDjumU2zD8rcyXUjGTwkcbt948OXIIdIxD3IaY+jCwQdvOiJoML7
	 Wuwa2XxD/BHu8G2q8uY8RrOL/no0hZ5cwRc2bPBF2DLImeD2UX8x7ckh5eXBprEOSQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795270765;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pqdb1CZmw00+aWMEKUmzfViHJG+GiKGhJXCKYqajwNg=;
	b=QzY4/E8sqSLZWqwWefC1A86nmlEUPthRRgkXqA8HvAI/NFm98i/rf2+yImgAreynkjwl
	 GSLV1IvGuuiYnOlQY/cmcnw/8YkCNHj9J6AGXEDhLAFuT+IZ5iDSdmAIF4Rw/Cd5HYuJK
	 tVJrpE4wuYqSFvKZhO/t9ZXs+4sQ3aMXvSjWcaZkLad7+IJ42crZGljG6siEYr+iyVg1B
	 hq5kVMiNGLuaENBpwgls3aMxWWMj4Sr7XrHX3z77W9Z9boYOECeqN+beNon5wVuHLN3KA
	 esxxcocZap0NRfStvmloFXHc8sATOKU1Re3xs5DgEqFgOEb2Otym6t3H3szSz/ZsWKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=qeC99Cbo;
	arc=none smtp.remote-ip=115.124.28.145
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68226606A338;
	Sat, 21 Nov 2026 14:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68226606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=qeC99Cbo
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795270755; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Pqdb1CZmw00+aWMEKUmzfViHJG+GiKGhJXCKYqajwNg=;
	b=qeC99CboETZZmO/pp6EHlJhZBWRlRw0+RBxEVbL9YJTD3QjWtf+AJjil8eidI8pnk9sIzcIIC7jdiGTkkbyTi5UqqIG8OlGjJ2aAZwoTsSqMEdl3hkjtrCTnLHbYEZTHEsvizi8odoXXafS/RSAc/6ThvkiGKFFQi5z6wNTJtf8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436263|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00745487-0.000394108-0.992151;FP=16019482191521677331|13|3|17|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k7GCEcI_1795270753;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k7GCEcI_1795270753 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 22:19:15 +0800
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
Subject: [PATCH net v4 4/5] net: wwan: iosm: pass the DL command parameter by pointer
Date: Sat, 21 Nov 2026 22:18:49 +0800
Message-ID: <20261121141850.73754-5-fangxy@xiaopeng.com>
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

ipc_mux_dl_cmdresps_decode_process() takes the twelve byte union
mux_cmd_param by value, so every received command copies the whole
union out of the skb even when its type only needs one member,
reading past what arrived for a truncated response. The driver also
builds its link status response inside the received block.

Take the parameter as a const pointer and keep the lite path response
in a local variable; the aggregated path sends no response parameter.
The session response path still copies the full parameter union here.
The next patch adds the received parameter length check and restricts
each response copy to its own member. This change is a prerequisite
for that fix and is tagged for stable alongside it.

Fixes: 9413491e20e1 ("net: iosm: encode or decode datagram")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 29 ++++++++++------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index a8448e273c02..3f93d7293785 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -184,7 +184,7 @@ void ipc_mux_netif_tx_flowctrl(struct mux_session *session, int idx, bool on)
 }
 
 static int ipc_mux_dl_cmdresps_decode_process(struct iosm_mux *ipc_mux,
-					      union mux_cmd_param param,
+					      const union mux_cmd_param *param,
 					      __le32 command_type, u8 if_id,
 					      __le32 transaction_id)
 {
@@ -194,7 +194,7 @@ static int ipc_mux_dl_cmdresps_decode_process(struct iosm_mux *ipc_mux,
 	case MUX_CMD_OPEN_SESSION_RESP:
 	case MUX_CMD_CLOSE_SESSION_RESP:
 		/* Resume the control application. */
-		acb->got_param = param;
+		acb->got_param = *param;
 		break;
 
 	case MUX_LITE_CMD_FLOW_CTL_ACK:
@@ -318,7 +318,7 @@ static void ipc_mux_dl_cmd_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 	__le32 trans_id = cmdh->transaction_id;
 	int size;
 
-	if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, cmdh->param,
+	if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, &cmdh->param,
 					       cmdh->command_type, cmdh->if_id,
 					       cmdh->transaction_id)) {
 		/* Unable to decode command response indicates the cmd_type
@@ -333,14 +333,15 @@ static void ipc_mux_dl_cmd_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 			/* Decoded command may need a response. Give the
 			 * response according to the command type.
 			 */
+			union mux_cmd_param response = {};
 			union mux_cmd_param *mux_cmd = NULL;
 			size_t size = 0;
 			u32 cmd = MUX_LITE_CMD_LINK_STATUS_REPORT_RESP;
 
 			if (cmdh->command_type ==
 			    cpu_to_le32(MUX_LITE_CMD_LINK_STATUS_REPORT)) {
-				mux_cmd = &cmdh->param;
-				mux_cmd->link_status_resp.response =
+				mux_cmd = &response;
+				response.link_status_resp.response =
 					cpu_to_le32(MUX_CMD_RESP_SUCCESS);
 				/* response field is u32 */
 				size = sizeof(u32);
@@ -500,26 +501,22 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
 	u32 fctl_dis = IOSM_AGGR_MUX_CMD_FLOW_CTL_DISABLE;
 	u32 fctl_ena = IOSM_AGGR_MUX_CMD_FLOW_CTL_ENABLE;
 	u32 fctl_ack = IOSM_AGGR_MUX_CMD_FLOW_CTL_ACK;
-	union mux_cmd_param *cmd_p = NULL;
 	u32 cmd = link_st;
 	u32 trans_id;
 
 	if (!ipc_mux_dl_cmds_decode_process(ipc_mux, &cmdh->param,
 					    cmdh->command_type, cmdh->if_id,
 					    cmdh->cmd_len, size)) {
-		size = 0;
-		if (cmdh->command_type == cpu_to_le32(link_st)) {
-			cmd_p = &cmdh->param;
-			cmd_p->link_status_resp.response = MUX_CMD_RESP_SUCCESS;
-		} else if ((cmdh->command_type == cpu_to_le32(fctl_ena)) ||
-				(cmdh->command_type == cpu_to_le32(fctl_dis))) {
+		if (cmdh->command_type == cpu_to_le32(fctl_ena) ||
+		    cmdh->command_type == cpu_to_le32(fctl_dis))
 			cmd = fctl_ack;
-		} else {
+		else if (cmdh->command_type != cpu_to_le32(link_st))
 			return;
-			}
+
 		trans_id = le32_to_cpu(cmdh->transaction_id);
+		/* No response parameter is sent in the aggregated protocol. */
 		ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
-					 trans_id, cmd_p, size, false, true);
+					 trans_id, NULL, 0, false, true);
 	}
 }
 
@@ -571,7 +568,7 @@ static void ipc_mux_dl_acb_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 		     skb->len - next_cmd_index < hdr_len))
 			break;
 
-		if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, cmdh->param,
+		if (ipc_mux_dl_cmdresps_decode_process(ipc_mux, &cmdh->param,
 						       cmdh->command_type,
 						       cmdh->if_id,
 						       cmdh->transaction_id)) {
-- 
2.50.1

