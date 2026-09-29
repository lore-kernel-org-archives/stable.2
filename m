Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6D45D91B;
	Tue, 29 Sep 2026 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716054; cv=pass; b=ALdAlVVhZiLK8BYT9VEw96SedZ4X9Y/O2etWP0Z8opX/EYrT9/pyHJwABwhqcA3K1jpKFX1bqwnTroooFIt3pN91ouL/Qlt3haeL2H1jM8bw2Ph3CbnAHZBcwaGirJ8S0shwbX4uPq4s6P9LapXSdsZZENWh+JhEcgse658oQYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716054; c=relaxed/simple;
	bh=4VMdeTa78FkHWrplmapjIBVfNG2stz1Xrkkr1mBd90k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6BY9P1wJ/nNSkoOlTBpAp45osQQpe0M5LxQ/xu0lWu5iIPio47whJry24gVzuJ/vcZBINga9oeBi1fWf0J4ylzIBQKJDgHD45E1zUTgQvsHfawOxKM6TqKRH2A6iufJDZLcf/0aVlg8B2kk6PxPSBeq+uO1ojbo8P4PsMqIw1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=abP8APa/; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="abP8APa/"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 29903201E7F;
	Tue, 29 Sep 2026 23:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOgeQRJH4ao0GcPqh++VRKg22Sia8Xe+adaiIeFq+co=;
	b=abP8APa/1SEmOnTWo7mS+XNFBFaj0h92LJO5xuRNYR+k5hrPWeCyqJuIvOQojpJw+cRg8k
	Yq+9PrLTSUZHXhTotnJ4fJJAHNKJhinEjZMEPM9kRQA3xOnD6vo/mlr2Rp4N/qlv2tVv27
	17VTNJYjodl/HJlpZ0pAcjsi7v6zr57AKAoAhFGMvCRDBPfuwJNE5ifaiovMWGU4RpWUiR
	IB06i2of+UUVf5eycBin8lx++IlUaY1HJEz7rC451fCdmE2nP+gIBCxLyIX07A1wC0oszY
	lYku5xSzaxoYHAw5xmRyGNj3APo/5+RgmMOumnqCk+CVxaB1Hke5d6kzFQxBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOgeQRJH4ao0GcPqh++VRKg22Sia8Xe+adaiIeFq+co=;
	b=JS+/lSMSSZEaxYnlTqESt0nkHITzMztrQBAO/27/2jDh7FciQv3iG3bz7lF3cbaW2XbzOy
	nTGcsBEpGJvR5dTLRKueM4FMy3kH/oEpRSrRdz8sVqdx6GgucJzO36o6Slg14bRawN1l69
	3oRAJYAnoVafjjTkBkgm4vl1qRmQDoEx+oArMngWWaBN6Sc+Y7RiBB5e0ZQZQ7H7jzqzPi
	S/ftC6JnIMs375PlfEIfyf6vNFqqsEWT3PIeZ3wpZUNQne3PrmIqIp3ngfKJJreNfJWsf4
	R/99v8EzGn+Ihj+9GjroFlz/OASD1LcptagA8TBGazrwefgUxSXhY4Zn0GF49A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716024; a=rsa-sha256;
	cv=none;
	b=BOI4Gyb5xl6n2GQwSZSqUxIanCcK6NMYI5EJqkuE1RfZogIofOsAUehHhhSw0o7Ubykuuw
	ZxXjqdbVAddw4oLANDvUTYcjn18ZxdzvwSE2jZnoeNQfLZabHH4BwyhwEfx7G74NBiyzb2
	iHTEZczfnWwxbGvxfwmZsbuVCvhGGKYlgak5UQPDnTyWLW+gHIRR9PAQz0COC+FhoojHKn
	/CUHud9irfYIk0Mnmo2PwX//QjRw0W8taSCSF0GtUjxnhlWsTKw2ZktNYgr5u9DNWF4CC3
	HWDdW7Vg0ENltZuHOPSVu/eYVjLPbPrHjv0jE+wWHpMBSqYN9P+ukIlo3/5D3Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S45-31;
	Tue, 29 Sep 2026 23:07:04 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A4AF55B4CDD;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
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
Subject: [PATCH net 13/16] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Tue, 29 Sep 2026 22:44:03 +0200
Message-ID: <20260929210700.1183036-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
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

