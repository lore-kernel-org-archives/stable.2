Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF46351C17;
	Tue, 29 Sep 2026 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649568; cv=none; b=EcXONRylTzDY3m0Uj7YhG6vgIYF2bM0HMM8SvmOs8yTUJmZgtRMdMJSjXJ3LYA5KdvurIlQuwTWEiYq1TySurMwiNYRE+k1K8bF19qyMK/DhbNptQDGrg6jvr2hFFk/F31vb5lhFhWTvXmnUIA9wxGGQwCBKinYm86AnRXOl48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649568; c=relaxed/simple;
	bh=WV+1vG6r/S/WKkOQObfkAsdbddxIKMKiumGpwtu9B8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPqFmU91DOFlMS3A7tTwi9BBq7w246nng3ahQBkAFey6wO1KcSUnKWySdnTc5KQY3ShLz3wc5WRQbepbLtCqbtLqXoRM/V2TGcmaOJqaUxNr/QUNzLnPdtT8zGHIL4Z44uxXiRzT8m7rHSmjCcsiGhLoVmYMn/VgIjR0f7/3IzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=aqXy1lyc; arc=none smtp.client-ip=115.124.28.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="aqXy1lyc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790649556; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3S3qJl7wU6ok42IM6/A9TRrEJi+qKG+KXTexZJ1Q6jE=;
	b=aqXy1lycxOg+70ol5WhdJ/AHrVq19Pg5iRe61JlBodkhwEQIPqNPdjAK2AnJP+Xf1Iv3bjkrh2tLJbAsqaay8KcTo3mFfoDR4aH0WxeHRFbW3QXmhg2plHu5Z2R/2L/2dUboPI9oyWHLCDnCU8RQrYj8PMImbeQ9N6GMho9bAR4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07847276|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0146087-0.00380905-0.981582;FP=11396015069220981788|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jQoX4OC_1790649554;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jQoX4OC_1790649554 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 10:39:15 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: chandrashekar.devegowda@intel.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	guozh23@xiaopeng.com
Subject: [PATCH v2] net: wwan: t7xx: validate the HS2 message data length
Date: Tue, 29 Sep 2026 10:39:14 +0800
Message-ID: <20260929023914.247374-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909054401.718959-1-zhugl3@xiaopeng.com>
References: <20260909054401.718959-1-zhugl3@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

control_msg_handler() passes the modem-supplied data_length field of a
CTL_ID_HS2_MSG message straight to t7xx_fsm_append_event(), which
memcpy()s that many bytes out of the skb.  Nothing compares the field
with the actual length of the message, so a modem reporting a larger
data_length makes the driver read past the end of the skb and store
kernel heap memory in the FSM event.

The message is not even checked against the control header itself:
for a message shorter than sizeof(struct ctrl_msg_header) the
skb_pull() is a no-op and ctrl_msg_h->data_length is read past the
skb tail.  And on the consumer side, t7xx_prepare_device_rt_data()
reads a full struct feature_query out of the event without looking at
its length, so a short data_length makes it read past the end of the
event allocation and echo the out-of-bounds bytes back to the modem
in the HS3 reply.

Reject the message when it is shorter than the control header or when
data_length does not fit into the skb, and make
t7xx_prepare_device_rt_data() bail out when the payload is shorter
than struct feature_query.

Fixes: da45d2566a1d ("net: wwan: t7xx: Add control port")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v2, addressing the sashiko AI review:

- reject messages shorter than the control header, so
  ctrl_msg_h->data_length is not read past the skb tail
- make t7xx_prepare_device_rt_data() length-aware: a payload shorter
  than struct feature_query is rejected instead of being read past
  the end of the event allocation and echoed back in the HS3 reply
- flatten the HS2 arm nesting while at it

The data_length upper-bound check was verified in a QEMU guest with a
fault injector feeding the driver's control port thread a handshake
message whose data_length exceeds the skb: the unpatched driver trips
KASAN on a read of 8192 bytes past a 500-byte payload, and the extra
bytes land in the FSM event.  With this check the message is
rejected, and well-formed handshakes are unaffected.

 drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 10 ++++++--
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 27 ++++++++++++++++++----
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index adb29d3..de689aa 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -400,13 +400,18 @@ static void t7xx_prepare_host_rt_data_query(struct t7xx_sys_info *core)
 }
 
 static int t7xx_prepare_device_rt_data(struct t7xx_sys_info *core, struct device *dev,
-				       void *data)
+				       void *data, int data_length)
 {
 	struct feature_query *md_feature = data;
 	struct mtk_runtime_feature *rt_feature;
 	unsigned int i, rt_data_len = 0;
 	struct sk_buff *skb;
 
+	if (data_length < sizeof(*md_feature)) {
+		dev_err(dev, "Invalid runtime data length: %d\n", data_length);
+		return -EINVAL;
+	}
+
 	/* Parse MD runtime data query */
 	if (le32_to_cpu(md_feature->head_pattern) != MD_FEATURE_QUERY_ID ||
 	    le32_to_cpu(md_feature->tail_pattern) != MD_FEATURE_QUERY_ID) {
@@ -563,7 +568,8 @@ static void t7xx_core_hk_handler(struct t7xx_modem *md, struct t7xx_sys_info *co
 	if (ctl->exp_flg)
 		goto err_free_event;
 
-	ret = t7xx_prepare_device_rt_data(core_info, dev, event->data);
+	ret = t7xx_prepare_device_rt_data(core_info, dev, event->data,
+					  event->length);
 	if (ret) {
 		dev_err(dev, "Device failure parsing runtime data: %d", ret);
 		goto err_free_event;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index f869e4e..5ed07c4 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
@@ -178,22 +178,39 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 
 	ctrl_msg_h = (struct ctrl_msg_header *)skb->data;
 	switch (le32_to_cpu(ctrl_msg_h->ctrl_msg_id)) {
-	case CTL_ID_HS2_MSG:
-		skb_pull(skb, sizeof(*ctrl_msg_h));
+	case CTL_ID_HS2_MSG: {
+		u32 data_length;
+
+		if (skb->len < sizeof(*ctrl_msg_h)) {
+			dev_err(port->dev,
+				"Invalid HS2 message: need %zu, have %u\n",
+				sizeof(*ctrl_msg_h), skb->len);
+			ret = -EINVAL;
+			dev_kfree_skb_any(skb);
+			break;
+		}
 
-		if (port_conf->rx_ch == PORT_CH_CONTROL_RX ||
-		    port_conf->rx_ch == PORT_CH_AP_CONTROL_RX) {
+		skb_pull(skb, sizeof(*ctrl_msg_h));
+		data_length = le32_to_cpu(ctrl_msg_h->data_length);
+
+		if (data_length > skb->len) {
+			dev_err(port->dev, "Invalid HS2 message length %u\n",
+				data_length);
+			ret = -EINVAL;
+		} else if (port_conf->rx_ch == PORT_CH_CONTROL_RX ||
+			   port_conf->rx_ch == PORT_CH_AP_CONTROL_RX) {
 			int event = port_conf->rx_ch == PORT_CH_CONTROL_RX ?
 				    FSM_EVENT_MD_HS2 : FSM_EVENT_AP_HS2;
 
 			ret = t7xx_fsm_append_event(ctl, event, skb->data,
-						    le32_to_cpu(ctrl_msg_h->data_length));
+						    data_length);
 			if (ret)
 				dev_err(port->dev, "Failed to append Handshake 2 event");
 		}
 
 		dev_kfree_skb_any(skb);
 		break;
+	}
 
 	case CTL_ID_MD_EX:
 	case CTL_ID_MD_EX_ACK:
-- 
2.43.0

