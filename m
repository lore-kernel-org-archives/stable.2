Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AC34F483;
	Wed,  9 Sep 2026 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932656; cv=none; b=mBLmMMbt+U2KInT49VD9nHPYabvGpmS6wJy0f4SNX6cZa6LtMTszVWYXvEk/0ysNg/aGViH7J3pJUk/+qaH3NHadLbhXQF7pSOjadJ9pa0aBMLXdsPUFIC7h4JrfgYRAr/MERQ8chQDxfVGq62KEgNaaMQE1NeRPKeul5MmULIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932656; c=relaxed/simple;
	bh=ncL1TZaUvrafoNmevXZ2l6gNwmK0Gf7X0LneI3k+DaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjHOd0WfunI26lCWXjfho6Sdt/l5ZnU5IX4FlcHOJ3feKNDQK9c7V1cXnqR415p2KkiNGeusXubc/KiUjdf6pM5natqWJvQJDpKkJ/8DufK1V0Mkc80mN8/caFLTp8VFPlaQUbeE57V4fjBa0T2qRR//wbQyXwpv5EdXR63zoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=sUOy8V56; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="sUOy8V56"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788932643; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=clFMEoaK0/ropSvPOKmrmoJ/NX3PTGHrk1ZEqEfZ2Gw=;
	b=sUOy8V56Hts7+VMLHZRqB5ibeq5aDMG9g4bwT5VUOaBhh+0Ife+pQpYrjTALIdeWFjxA9db+7/bYt1sOZWmcWu3cCsV7hceTvyfBmxeotXeQHOWmsC6G+BYqlGNdivqcV5tuzImwTl65EASjXUoar6a/+BLkFGNmBsOD1w4tgXE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.169033|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00438728-0.000974205-0.994639;FP=11404490654595305044|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.j9ME9Bu_1788932641;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.j9ME9Bu_1788932641 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 09 Sep 2026 13:44:02 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: wwan: t7xx: validate the HS2 message data length
Date: Wed,  9 Sep 2026 13:44:01 +0800
Message-ID: <20260909054401.718959-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
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

0e7c074cfcd9 ("net: wwan: t7xx: validate port_count against message
length in t7xx_port_enum_msg_handler") added this kind of check for
the port enumeration path but missed the handshake path.

Reject the message when data_length does not fit into the skb.

Fixes: da45d2566a1d ("net: wwan: t7xx: Add control port")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---

Verified in a QEMU guest with a fault injector feeding the driver's
control port thread a handshake message whose data_length exceeds the
skb: the unpatched driver trips KASAN on a read of 8192 bytes past a
500-byte payload, and the extra bytes land in the FSM event.  With
this check the message is rejected, and well-formed handshakes are
unaffected.
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index f869e4ed9..0f2ead8a7 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
@@ -178,22 +178,32 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 
 	ctrl_msg_h = (struct ctrl_msg_header *)skb->data;
 	switch (le32_to_cpu(ctrl_msg_h->ctrl_msg_id)) {
-	case CTL_ID_HS2_MSG:
+	case CTL_ID_HS2_MSG: {
+		u32 data_length;
+
 		skb_pull(skb, sizeof(*ctrl_msg_h));
+		data_length = le32_to_cpu(ctrl_msg_h->data_length);
 
 		if (port_conf->rx_ch == PORT_CH_CONTROL_RX ||
 		    port_conf->rx_ch == PORT_CH_AP_CONTROL_RX) {
 			int event = port_conf->rx_ch == PORT_CH_CONTROL_RX ?
 				    FSM_EVENT_MD_HS2 : FSM_EVENT_AP_HS2;
 
-			ret = t7xx_fsm_append_event(ctl, event, skb->data,
-						    le32_to_cpu(ctrl_msg_h->data_length));
-			if (ret)
-				dev_err(port->dev, "Failed to append Handshake 2 event");
+			if (data_length > skb->len) {
+				dev_err(port->dev, "Invalid HS2 message length %u\n",
+					data_length);
+				ret = -EINVAL;
+			} else {
+				ret = t7xx_fsm_append_event(ctl, event, skb->data,
+							    data_length);
+				if (ret)
+					dev_err(port->dev, "Failed to append Handshake 2 event");
+			}
 		}
 
 		dev_kfree_skb_any(skb);
 		break;
+	}
 
 	case CTL_ID_MD_EX:
 	case CTL_ID_MD_EX_ACK:
-- 
2.43.0

