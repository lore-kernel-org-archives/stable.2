Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215634E4C3C;
	Fri,  9 Oct 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553426; cv=pass; b=DHUe9aBGpY7SisqJ5WPXlksX7xr6qXAuL/2jsy6/sPk8CNQFrA7pdmQ8rug70/crMpyzJUgtbI+7ai7ZREHuSx5u7q/cqmx/DbH2FG2/TigtMzTqQ0/+3f8mChg8LloRV5i8mRjJ5yJMSXH7S4wLljUUqZuqoWxZ2IB8vdh4qAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553426; c=relaxed/simple;
	bh=LKD4GPBRmEu7+sUhuUJC0oMqH55Ha3xWr5gcKTCEr0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kE8xF7B34vuMREdfe9aQpkPdPwfpf5h7myMLyS4xy+UXyj3RRbpZCfI287Hwl9Eu4GYcMni5092iLQD7Ig3i5yXmFE5FDh/MSZexn8PyMMAQAGlw5gQqhIcueWRqwg6G2+M9i0EeXe9uNKT1sBYuaZr8Vl/yGYTYYoKqxsm6hwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=QeLbbcAO; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="QeLbbcAO"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2631220261F;
	Fri, 09 Oct 2026 15:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JfNdBai0Cdad7n2CL4qgG0kOFBI3OkXdAYgVHpPLf4=;
	b=QeLbbcAONEQgpDjpP3NdCHcIWNDDco2JNj8pEzSpHBU+FOQyrHRdlqF1CL/kmTVT4EdZSd
	/bO/ztv3ohHDXQacripkxBMWEqs8KhIJzN7tr7rjK2FzY8G9Gxg4uNK0kfHqZFa4y1Euw/
	vq9ZU/poMjVa9xQH6tGQCeBZcyleloo/W+iMADg6ng8xRGkZERiYI8M9JJb2+VjOGUezJs
	Nezk3FX8OOHJ7wOL7mTpp9/cdIvuiO7D5HMK1w4ZeyuathZ5l6bkQDssu27h1LY47p4GKp
	uceiA6rtbbL5SmEG79joDYD7FmLzcVk2o5+4NPJNaDU0yQ9+jJutmUJo91DA1g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553421; a=rsa-sha256;
	cv=none;
	b=IUPleuqIFIl+USILJQd14mw9dQuL00xynZwNIB/DnHliW36YOgY8WIsjjarBmlnGmQv/N9
	sc0ImtW0GbMu+tbvw4xXtEFbIoPmpx6xvYmXJI31ieryhaOcvdLfY9vOuklhrYvsg2FKZh
	l1gEMMK/wXJHwu5RIvoMvvnmzw46eD1+AmVr1xWvpF0qHeiRulOfg1Vl7t90ThJB0YVNQp
	xvEd0adxrhusjIqJlwymrrMaJfVoI0XpnOvhvOzICbFANj7DyirZ086AIOKH9ttZ83s0OH
	1zw6MGmtsMaqRbPm0EmrB9oGAapgtzCKJImS4GfIUv5GU2KTBuEb1XE8AO/9xg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JfNdBai0Cdad7n2CL4qgG0kOFBI3OkXdAYgVHpPLf4=;
	b=XZyxz4CqkdnI9e2YnFPKcnc/6qjZ4/GtLzNjGyiMFMczIzX7/yDX+0H0G8EqIYRe1qQ7VB
	jmEFbk4TfARMf8bOZTjn89xMqZSU0sB4L9riSGQBPbqCozhWyzC1oyxoARl7/RYHOEYmFC
	9Nz6s/Lnk/iEW5S51xEXXmtogUbnnQ2RHzYQvqlmyOhVs9njivTTMc0N76C4raaHCMuv7m
	mwn9kafVT4/9PU46rdSSJBa4YDnAmxfvU3NlqznJCCsB7DAg47K1Jm5DQYGm0PT4Y/R1bT
	Ehk8u1BOeKGn/K5wE5dYLf7skLiC3tmlaaWsK07aPYgAPk05HPM0D+d9rncUcw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsv-0053TZ-0B;
	Fri, 09 Oct 2026 15:43:41 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7C1D15BD8E9;
	Fri, 09 Oct 2026 13:43:40 +0000 (UTC)
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
Subject: [PATCH net-next 32/37] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Fri,  9 Oct 2026 15:28:04 +0200
Message-ID: <20261009134323.64064-33-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
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
index ad168cad1d78..68bbccb94bb1 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -533,6 +533,82 @@ static size_t kvaser_usb_hydra_cmd_size(struct kvaser_cmd *cmd)
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
@@ -672,8 +748,9 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
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
@@ -2091,27 +2168,60 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
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
@@ -2123,11 +2233,17 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
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
 
@@ -2145,6 +2261,11 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
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

