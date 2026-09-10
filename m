Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DA73AAF6B;
	Thu, 10 Sep 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048227; cv=none; b=cPBuOeqkmfS+Yzc5LBPbpRz++/RiKS1rdSr/+mPpzjbtPEaeFne36patsuGNG46na+xvevyLPu0GE/GrAj9lmmlZnhQn1Mh9nwoqIBxuy+Z6Pjlx45D6ThEkO5uJ5BsO/3p+4Qc3qlUaambqtGJXag78iNj35YfUBu9FZTsLP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048227; c=relaxed/simple;
	bh=V9Y1F8P8Q5erbjhiCN13oXa0hejGdTWhlhNdfPBQ9ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWJeK+onKqhoW3jnTnJKofb62fDUb8p+HetGVOBIJQqKn2RoPsVqRp3b4JV8r6xSs/8NLPT/mZpzpcWwIx7LNPVhQe7BNLqE11Ey8Hk0WLHsldFhRkn+pJ/KxNqpEReB9jFpE5LTUFJxOWxJ5rPVj5RZV5KWYrseupIbvxFcbmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LytjJdIF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LytjJdIF"
Received: from mac.lan (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1FF4320B7166;
	Thu, 10 Sep 2026 06:49:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FF4320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789048181;
	bh=CPbWm5KrpeYp0YWqZerft7p6ELbJVPGttZYsnIzY9zM=;
	h=From:To:Cc:Subject:Date:From;
	b=LytjJdIF7NGkHvYURqJcJw98zt/TEpaAm4q9V+yBBFpifE8PXo9rFlieyd0MQogZF
	 HA0K9nrvUf5Yog8Qcre0rrS7LI+xbYrAW+/z4uwyfYRHE2iYAe/DK0hh/lsfaatYlX
	 sARchkzncykYJvr6ZIUWQE3xT85nbAIIeTlDABIM=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Martin Henriksson <mh@kvaser.com>,
	Jimmy Assarsson <extja@kvaser.com>,
	Christer Beskow <chbe@kvaser.com>,
	Nicklas Johansson <extnj@kvaser.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Kees Cook <kees@kernel.org>,
	Enrico Pozzobon <enrico.pozzobon@dissecto.com>,
	Yiran Qiu <eritque-arcus@ikuyo.dev>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: [PATCH net v4] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Thu, 10 Sep 2026 09:50:00 -0400
Message-ID: <20260910135000.34796-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
v4:
 - Reject extended command lengths outside the generic 8-byte header and
   the 128-byte maximum.
 - Validate complete CMD_TX_ACKNOWLEDGE_FD and CMD_RX_MESSAGE_FD extents
   before dispatch, deriving variable RX payload lengths from flags and DLC.
 - Apply command-specific validation to synchronous scanning, direct bulk
   receive, and fragmented-command reassembly.
 - Link: https://lore.kernel.org/all/20260827194410.4023800-1-kuba@kernel.org/

v3:
 - Preserve fragmented command headers by distinguishing incomplete size
   fields from invalid zero lengths.
 - Complete a fragmented extended size field before reading it, using the
   actual valid leftover length.
 - Link: https://lore.kernel.org/all/20260824214058.44948-1-blbllhy@gmail.com/

v2:
 - Clear malformed leftover state before returning.
 - Reject command lengths shorter than the buffered prefix.

v1:
 - The zero-length command loop is also addressed by:
   https://lore.kernel.org/linux-can/20260815-can-esd-hydra-fixes-v1-2-de644cbeaec2@ikuyo.dev/
 - This patch additionally handles truncated command headers in the
   synchronous wait and asynchronous receive paths, including the
   leftover-buffer path.

 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 140 +++++++++++++++++-
 1 file changed, 132 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index efbb7bed34c9..adc326c2d211 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -536,6 +536,80 @@ static size_t kvaser_usb_hydra_cmd_size(struct kvaser_cmd *cmd)
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
+		min_len = offsetof(struct kvaser_cmd_ext,
+				   rx_can.kcan_payload);
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
+	return cmd_len < min_len ? -EINVAL : 0;
+}
+
 static struct kvaser_usb_net_priv *
 kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
 				   const struct kvaser_cmd *cmd)
@@ -675,8 +749,11 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
 			size_t cmd_len;
 
 			tmp_cmd = buf + pos;
-			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
-			if (pos + cmd_len > actual_len) {
+			err = kvaser_usb_hydra_cmd_size_rx(tmp_cmd,
+							   actual_len - pos,
+							   &cmd_len);
+			if (err || pos + cmd_len > actual_len ||
+			    kvaser_usb_hydra_verify_cmd_size(tmp_cmd, cmd_len)) {
 				dev_err_ratelimited(&dev->intf->dev,
 						    "Format error\n");
 				break;
@@ -2110,6 +2187,7 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 {
 	unsigned long irq_flags;
 	struct kvaser_cmd *cmd;
+	int err;
 	int pos = 0;
 	size_t cmd_len;
 	struct kvaser_usb_dev_card_data_hydra *card_data =
@@ -2120,27 +2198,64 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	spin_lock_irqsave(usb_rx_leftover_lock, irq_flags);
 	usb_rx_leftover_len = card_data->usb_rx_leftover_len;
 	if (usb_rx_leftover_len) {
+		const size_t cmd_size_field_end =
+			offsetof(struct kvaser_cmd_ext, cmd_no_ext);
 		int remaining_bytes;
 
 		cmd = (struct kvaser_cmd *)card_data->usb_rx_leftover;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		if (cmd->header.cmd_no == CMD_EXTENDED &&
+		    usb_rx_leftover_len < cmd_size_field_end) {
+			remaining_bytes = min_t(int, len,
+						cmd_size_field_end -
+						usb_rx_leftover_len);
 
-		remaining_bytes = min_t(unsigned int, len,
+			memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len,
+			       buf, remaining_bytes);
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
-		       remaining_bytes);
+		memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len,
+		       buf + pos, remaining_bytes);
 		pos += remaining_bytes;
 
 		if (remaining_bytes + usb_rx_leftover_len == cmd_len) {
+			if (kvaser_usb_hydra_verify_cmd_size(cmd, cmd_len)) {
+				dev_err(&dev->intf->dev, "Format error\n");
+				card_data->usb_rx_leftover_len = 0;
+				spin_unlock_irqrestore(usb_rx_leftover_lock,
+						       irq_flags);
+				return;
+			}
+
 			kvaser_usb_hydra_handle_cmd(dev, cmd);
 			usb_rx_leftover_len = 0;
 		} else {
@@ -2154,9 +2269,13 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	while (pos < len) {
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
 
@@ -2174,6 +2293,11 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
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

base-commit: 7addb4e5ef1702704914b47bca3f706ef96c1589
-- 
2.55.0
