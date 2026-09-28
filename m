Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E4502D56;
	Mon, 28 Sep 2026 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624013; cv=pass; b=B9nxsAo+T/pdLEVzJgsc5VgSRLL6v2EQDbn9FlSXTt2RkUV+QOonrVW1+SksmtHFcWdCKMd+4HXVy2kXU1JJJWcCRNO6nZ2tMA3thLoPjTdGavnsd2+YUo6SeO3OQuIQfYtrBWGTUeGQtq0bKQ1lGmpslYkKIxeo++tkbjGwhZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624013; c=relaxed/simple;
	bh=4VMdeTa78FkHWrplmapjIBVfNG2stz1Xrkkr1mBd90k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KatKCwtdwdV4OYgcuSGSsAy6Pemy05HCiz2Z4fKEpOOmo22HOPKP/O5Dannjf775NN0xpJAYXgVtaYBZ9UFjTlSWr4XtxjkZImf0h1zCc9koCj6CvuPOeUKuLVfIoaZXi+KXGYprofB+JDcgrwlKFvzXAep6McR+0/cTJES4m3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Qd6xS2oW; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Qd6xS2oW"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E2DE72022DE;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOgeQRJH4ao0GcPqh++VRKg22Sia8Xe+adaiIeFq+co=;
	b=Qd6xS2oWwawKsdG2OMenboQuTJ8MPJJMxOMpsRFWdYNio8Pv3j2dwdwjvwBczYfZZyMpKC
	Q+e0Ao4mdZfywuVQrbvzqucDbjKwF6zUREDe5uzmktprQd954G8HXVxbn/zGsp8UGqo4W+
	iY4jMdqU24fskkrdcNyWS++/VrewAJt2zElJgtPa8SnMOnCTAZtmJQSPt2XI6mmES265rv
	oMd/MAf95TlTvDE/WuqzgkzryI+EOdyFLlGiQpb+cQAfN6RKmghGWv52qSAqPJGBTrJVrW
	M11skbToo2ZGyjL/wdYS8EjPw+yLoZ23rwYTXUFvVWFIdGewj9QoxWOy/Xm3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOgeQRJH4ao0GcPqh++VRKg22Sia8Xe+adaiIeFq+co=;
	b=euAx6Haie2jnRTLaYMf7aYN8AkViQpDa4u6UY/mIP63MLN5LI+fLdGakG5qoFLPOnNnHlH
	iioKbhSeKUAqa4OB28KDtUR6XdGhYZjcZMQT69xJNfKwSppdtE0ZJMwfdC0JQKP9o8KGQf
	bmcmwUg9WJZu1LhMYgvq+fPqptLtwQ2F4V1sEu1CEG6TkWi/tBs3BDQDh7xkW3mkeY/Nrr
	1laR5ZNp2kbpbvfslNtaH78zkjGXdzpUdeLzt5ctWwq6RTeDoc9K4JRnhE/2hD8ZgU5Hlx
	lJUTDS7r5Upw7deewOzd7ibD41uPDkcC+lhI2a57JfZRG6KvqH5FY74MrIBQrw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=FaavsRzbepyUIL8xS1P9tvaYVpwlQCWqkVP7x9cOJKD/99mXrFr5gNne7M1agLJLXMEAdU
	9uuNHywxDgU8x/Zg4x6vK6gcv6kFDiw6ZYtsslJhSEbeYP/0lV6nB0SPifV9yKYiu0snZO
	fjBtRA5gxIfT8gapa3s2/qK3XbVPUc1Yznov4jzcVjRUIu5pACa2xIJN1AzS+7I7QMsOfH
	i3r21LRzlgG6s1PpcnRiF0RShwC6to0TSTR+BW1zsMyR9TtJOG4PcK4yhzp4R53p2kJIbC
	aIfJhV9JehM/x3FZghhs8lUT/cS2IUmtoO77Xo6oyiheUw/B0PaWxlmrcYcvlQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6j-2U;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 776CC5B155C;
	Mon, 28 Sep 2026 19:33:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>,
	AutonomousCodeSecurity@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 21/22] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Mon, 28 Sep 2026 20:45:28 +0200
Message-ID: <20260928193312.553632-22-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>

The receive-path command parsers (kvaser_usb_hydra_wait_cmd and
kvaser_usb_hydra_read_bulk_callback) call kvaser_usb_hydra_cmd_size()
without verifying that enough buffer remains. For CMD_EXTENDED,
kvaser_usb_hydra_cmd_size() unconditionally reads a 2-byte len field
at offset 4. A malicious USB device can place a CMD_EXTENDED header at
the end of a 3072-byte bulk transfer such that only 4 bytes remain,
causing a 2-byte slab-out-of-bounds read.

  BUG: KASAN: slab-out-of-bounds in kvaser_usb_hydra_wait_cmd+0x3f1/0x480
    [kvaser_usb_hydra.c:678]
  Read of size 2 at addr ffff888013f7ec00 by task kworker/0:0/9
   kvaser_usb_hydra_wait_cmd+0x3f1/0x480
   kvaser_usb_hydra_get_software_details+0x1c7/0x5d0
   kvaser_usb_probe+0x36a/0x1240

Additionally, if the device sends CMD_EXTENDED with len=0,
kvaser_usb_hydra_cmd_size() returns 0 and the parser loops forever
(pos += 0), permanently burning one CPU core.

A positive but undersized extended length can also pass the buffer extent
check and reach a handler. For example, an 8-byte CMD_RX_MESSAGE_FD at
the end of an RX URB causes kvaser_usb_hydra_rx_msg_ext() to read fixed
fields and payload past the buffer.

Add receive-side length validation which preserves incomplete headers for
reassembly, rejects extended lengths outside 8..128 bytes, and checks each
known extended command against the minimum length its handler consumes.
For CMD_RX_MESSAGE_FD, derive the required length from its flags and DLC
so valid variable-length commands remain accepted. Apply the checks to
both receive paths and clear malformed leftover state before returning.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20260819145658.29872-1-blbllhy@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
Link: https://patch.msgid.link/20260910135000.34796-1-cenzhang@linux.microsoft.com
[mkl: reduce scope of err in kvaser_usb_hydra_read_bulk_callback()]
[mkl: increase readability, reformat to make use of ~100 columns]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 135 +++++++++++++++++-
 1 file changed, 128 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index efbb7bed34c9..43405b1b6a3c 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -536,6 +536,82 @@ static size_t kvaser_usb_hydra_cmd_size(struct kvaser_cmd *cmd)
 	return ret;
 }
 
+/* -EAGAIN means incomplete; -EINVAL rejects an invalid command length. */
+static int kvaser_usb_hydra_cmd_size_rx(struct kvaser_cmd *cmd,
+					size_t remaining, size_t *cmd_len)
+{
+	if (remaining < sizeof(cmd->header.cmd_no))
+		return -EAGAIN;
+
+	if (cmd->header.cmd_no == CMD_EXTENDED &&
+	    remaining < offsetof(struct kvaser_cmd_ext, cmd_no_ext))
+		return -EAGAIN;
+
+	*cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+	if (cmd->header.cmd_no != CMD_EXTENDED)
+		return 0;
+
+	if (*cmd_len < offsetof(struct kvaser_cmd_ext, rx_can) ||
+	    *cmd_len > KVASER_USB_HYDRA_MAX_CMD_LEN)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int kvaser_usb_hydra_verify_cmd_size(const struct kvaser_cmd *cmd,
+					    size_t cmd_len)
+{
+	const struct kvaser_cmd_ext *cmd_ext;
+	size_t min_len;
+
+	if (cmd->header.cmd_no != CMD_EXTENDED)
+		return 0;
+
+	cmd_ext = (const struct kvaser_cmd_ext *)cmd;
+
+	/* Keep this switch in sync with kvaser_usb_hydra_handle_cmd_ext(). */
+	switch (cmd_ext->cmd_no_ext) {
+	case CMD_TX_ACKNOWLEDGE_FD:
+		min_len = offsetof(struct kvaser_cmd_ext, tx_ack.timestamp) +
+			  sizeof(cmd_ext->tx_ack.timestamp);
+		break;
+
+	case CMD_RX_MESSAGE_FD: {
+		u32 flags;
+
+		min_len = offsetof(struct kvaser_cmd_ext, rx_can.kcan_payload);
+		if (cmd_len < min_len)
+			return -EINVAL;
+
+		flags = le32_to_cpu(cmd_ext->rx_can.flags);
+		if (flags & KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME) {
+			min_len += sizeof(cmd_ext->rx_can.err_frame_data);
+		} else if (!(flags & KVASER_USB_HYDRA_CF_FLAG_REMOTE_FRAME)) {
+			u32 kcan_header;
+			u8 dlc;
+
+			kcan_header = le32_to_cpu(cmd_ext->rx_can.kcan_header);
+			dlc = (kcan_header & KVASER_USB_KCAN_DATA_DLC_MASK) >>
+				KVASER_USB_KCAN_DATA_DLC_SHIFT;
+
+			if (flags & KVASER_USB_HYDRA_CF_FLAG_FDF)
+				min_len += can_fd_dlc2len(dlc);
+			else
+				min_len += can_cc_dlc2len(dlc);
+		}
+		break;
+	}
+
+	default:
+		return 0;
+	}
+
+	if (cmd_len < min_len)
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct kvaser_usb_net_priv *
 kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
 				   const struct kvaser_cmd *cmd)
@@ -675,8 +751,9 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
 			size_t cmd_len;
 
 			tmp_cmd = buf + pos;
-			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
-			if (pos + cmd_len > actual_len) {
+			err = kvaser_usb_hydra_cmd_size_rx(tmp_cmd, actual_len - pos,&cmd_len);
+			if (err || pos + cmd_len > actual_len ||
+			    kvaser_usb_hydra_verify_cmd_size(tmp_cmd, cmd_len)) {
 				dev_err_ratelimited(&dev->intf->dev,
 						    "Format error\n");
 				break;
@@ -2120,27 +2197,60 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	spin_lock_irqsave(usb_rx_leftover_lock, irq_flags);
 	usb_rx_leftover_len = card_data->usb_rx_leftover_len;
 	if (usb_rx_leftover_len) {
+		const size_t cmd_size_field_end = offsetof(struct kvaser_cmd_ext, cmd_no_ext);
 		int remaining_bytes;
+		int err;
 
 		cmd = (struct kvaser_cmd *)card_data->usb_rx_leftover;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		if (cmd->header.cmd_no == CMD_EXTENDED &&
+		    usb_rx_leftover_len < cmd_size_field_end) {
+			remaining_bytes = min_t(int, len, cmd_size_field_end - usb_rx_leftover_len);
 
-		remaining_bytes = min_t(unsigned int, len,
+			memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len, buf, remaining_bytes);
+			usb_rx_leftover_len += remaining_bytes;
+			card_data->usb_rx_leftover_len = usb_rx_leftover_len;
+			pos += remaining_bytes;
+
+			if (usb_rx_leftover_len < cmd_size_field_end) {
+				spin_unlock_irqrestore(usb_rx_leftover_lock,
+						       irq_flags);
+				return;
+			}
+		}
+
+		err = kvaser_usb_hydra_cmd_size_rx(cmd, usb_rx_leftover_len,
+						   &cmd_len);
+		if (err || cmd_len < usb_rx_leftover_len) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			card_data->usb_rx_leftover_len = 0;
+			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
+			return;
+		}
+
+		remaining_bytes = min_t(unsigned int, len - pos,
 					cmd_len - usb_rx_leftover_len);
 		/* Make sure we do not overflow usb_rx_leftover */
 		if (remaining_bytes + usb_rx_leftover_len >
 						KVASER_USB_HYDRA_MAX_CMD_LEN) {
 			dev_err(&dev->intf->dev, "Format error\n");
+			card_data->usb_rx_leftover_len = 0;
 			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
 			return;
 		}
 
-		memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len, buf,
+		memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len, buf + pos,
 		       remaining_bytes);
 		pos += remaining_bytes;
 
 		if (remaining_bytes + usb_rx_leftover_len == cmd_len) {
+			if (kvaser_usb_hydra_verify_cmd_size(cmd, cmd_len)) {
+				dev_err(&dev->intf->dev, "Format error\n");
+				card_data->usb_rx_leftover_len = 0;
+				spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
+				return;
+			}
+
 			kvaser_usb_hydra_handle_cmd(dev, cmd);
 			usb_rx_leftover_len = 0;
 		} else {
@@ -2152,11 +2262,17 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
 
 	while (pos < len) {
+		int err;
+
 		cmd = buf + pos;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		err = kvaser_usb_hydra_cmd_size_rx(cmd, len - pos, &cmd_len);
+		if (err && err != -EAGAIN) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			return;
+		}
 
-		if (pos + cmd_len > len) {
+		if (err == -EAGAIN || pos + cmd_len > len) {
 			/* We got first part of a command */
 			int leftover_bytes;
 
@@ -2174,6 +2290,11 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 			break;
 		}
 
+		if (kvaser_usb_hydra_verify_cmd_size(cmd, cmd_len)) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			return;
+		}
+
 		kvaser_usb_hydra_handle_cmd(dev, cmd);
 		pos += cmd_len;
 	}
-- 
2.53.0

