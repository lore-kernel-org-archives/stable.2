Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8333955C3;
	Tue,  1 Sep 2026 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253463; cv=none; b=P+F1FfgMz/JqiQP6S3aXRfPnzJt5XydVq9Cw/QCmJL9ShcHLjDpRj6mvmcZZ8L09ZW406R/noxXVbxewD1mGCodasvzhyI11rZjUaQaAgAVSioGhzgpTLJm399Kqp+kBIylWJUJbQaxIyDrURR85DHAFMvPIENZ9sNzLKqgF720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253463; c=relaxed/simple;
	bh=LTI8q0Epg6Ut8DoCocYaTVrkvbZWppAJSxZWpWWifWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cb6lR8FMO37ggKwj/kUEynKQqh3v3X27pqcmPmDjJMK4/I6zZAu1dvWLh5RpLgnvwQ6x382lUdHhAEVZ+QGw0MaR9jLMjpeu1jxXBnevylmp2XjUCzkaOHcYNkhBVin7cnghureFdGzcFhKfteEVOa00UUxl5mu9C6bXvov44gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=bdXY9cRu; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="bdXY9cRu"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1788253448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5RrptSmK1QMQpguF6j6YC9fFHhdiNT6BCnOECykAPBI=;
	b=bdXY9cRux1f0eydM3Nho/qef0dC9qkFezjTeFlVfdr1tMHx8v/kScmmEzjvf8svAd+s/mZ
	nu2SKTmB20PJUeGZM6Yna2bsoPnAXvZdO/fEHG1BmoWX6hjpXrmlIs2ufoWOP5SrY9082c
	Onx9Obp55ivVZcprhXvcG2JsnQevNfc=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Sebastian Haas <haas@ems-wuensche.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10] can: ems_usb: validate CPC message lengths
Date: Tue,  1 Sep 2026 12:04:06 +0300
Message-ID: <20260901090408.10353-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

commit 02925f51377f2a42a6724f00549167499c9302e5 upstream.

ems_usb_read_bulk_callback() walks CPC messages packed in one USB
receive buffer.

Check that each declared message fits in the URB payload. Also require the
type-specific payload to cover the fields used by the CAN, state, error and
overrun handlers.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Link: https://patch.msgid.link/20260706092752.79600-1-pengpeng@iscas.ac.cn
Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[Denis Arefev: adapted for 5.10: use get_can_dlc() instead of
 can_cc_dlc2len(), the latter was introduced in 6.x along with
 include/linux/can/length.h; get_can_dlc() has identical semantics
 for classic CAN frames (min(dlc, CAN_MAX_DLEN))]
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
Backport fix for CVE-2026-74460 
Link: https://nvd.nist.gov/vuln/detail/CVE-2026-74460
---
 drivers/net/can/usb/ems_usb.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 65aa1100e894..a645962da37a 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -402,6 +402,40 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 	netif_rx(skb);
 }
 
+static bool ems_usb_rx_msg_len_valid(struct ems_cpc_msg *msg)
+{
+	size_t len = msg->length;
+	size_t can_len;
+
+	switch (msg->type) {
+	case CPC_MSG_TYPE_CAN_STATE:
+		return len >= sizeof(msg->msg.can_state);
+
+	case CPC_MSG_TYPE_CAN_FRAME:
+	case CPC_MSG_TYPE_EXT_CAN_FRAME:
+	case CPC_MSG_TYPE_RTR_FRAME:
+	case CPC_MSG_TYPE_EXT_RTR_FRAME:
+		if (len < CPC_CAN_MSG_MIN_SIZE)
+			return false;
+
+		if (msg->type == CPC_MSG_TYPE_RTR_FRAME ||
+		    msg->type == CPC_MSG_TYPE_EXT_RTR_FRAME)
+			return true;
+
+		can_len = get_can_dlc(msg->msg.can_msg.length & 0xf);
+		return len >= CPC_CAN_MSG_MIN_SIZE + can_len;
+
+	case CPC_MSG_TYPE_CAN_FRAME_ERROR:
+		return len >= sizeof(msg->msg.error);
+
+	case CPC_MSG_TYPE_OVERRUN:
+		return len >= sizeof(msg->msg.overrun);
+
+	default:
+		return true;
+	}
+}
+
 /*
  * callback for bulk IN urb
  */
@@ -444,6 +478,15 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 			}
 
 			msg = (struct ems_cpc_msg *)&ibuf[start];
+			if (msg->length >
+			    urb->actual_length - start - CPC_MSG_HEADER_LEN) {
+				netdev_err(netdev, "format error\n");
+				break;
+			}
+			if (!ems_usb_rx_msg_len_valid(msg)) {
+				netdev_err(netdev, "format error\n");
+				break;
+			}
 
 			switch (msg->type) {
 			case CPC_MSG_TYPE_CAN_STATE:
-- 
2.43.0

