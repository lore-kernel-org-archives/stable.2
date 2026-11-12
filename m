Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504477;
	b=aeAOZclBE0uWqV7PUpxVLMB9j75hKkob89ECEEa95HLSM6KOftlvpXLrEXeNvOCzpn5M
	 JJ3+/1nGLcqBbhW0Ec3yJxlyLIstXHbB7kp6FkRMDhYOvlOD3xJa3Gg7tG7QVr7fvtjmv
	 w49dez8d5YH9IYt0H6tPXDoHB2L4bHK1cVEQOJytkimDfq+1CMUUQF1SZnKfD2avkurqN
	 gEL35nRRY5ijxhjfrGBV5fvW42y1FsGpc83wkezdzXaoGP33rjBAH+HZV1bqkOWplIsTd
	 tYJ1ClL5sLcXsmMtgQAs+qyS93A2lFpMmvTNxvqJ4olQ20ymamSvyN1BXi3pVQs6urw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504477;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oE10Mo/COjpbov79+NF0rHDyXxL+FvsL0v5e9tMoXcg=;
	b=InxhjoUFWJS4eZBbvRwIcqyFKtT6h4lnhTlLHW8nzxW3cx8f1eTZj+Th9KtR0u7BQaE1
	 FRnGGqtrAcncdZu6oxZILQJebhCXaiWdidNk81iQd3bUQbLDo89zsQfkfazlVPEywcwjU
	 yqx0TrITYs+KSYAnlro+Gds6ti3IiPPh9VyEh5RIwT5cYNyLE7r7w/KIjEkHlfIoVYu4I
	 wfrSDAt2jreWDp6P2lct7nL8AlostLrlCsRI1iTA53RQa0STHfdQp7NKhvuXYYxL30F/z
	 B9cVdmcGJtfixWcNCqsD7k10NSdX8Pi/aH3bUV1Uzqrq7/1izwWrK2FTPSTCogimiWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Il7r2OHj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4B9606A8AE;
	Thu, 12 Nov 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Il7r2OHj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794504476;
	b=WrEHCMhyxzDjPyJSIn4Tlq+5L+s1cLxe8A/qebw/qGvvgUaxhADUp7Rjiss1bN9dMkIZ
	 efmKb+KFdXkXV9rDdCwrb+pzZ7RI8bUnx7+7k4VkBhd9ZdCg9RIWGHilgy/PnJhAvXiGL
	 oXTb7Nd4OMwmnOEb1xssggSoOl1bwJ0G5hznt7TI2HS43z1gmIgrPjCd+VHYSwu+SAOIO
	 RD7Ohx5t+CC04gFTXAZQZYOlq8bkwebwTzVjRtvLTJoRz8Z7Tvgv3cpopsLjhe9XNQXtP
	 fLD8zBbByW1XOaSz+OQYgjE6sivEUdZljXK0uedUzEhR6B6mlOO21miv3yew2Q5PHgg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794504476;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oE10Mo/COjpbov79+NF0rHDyXxL+FvsL0v5e9tMoXcg=;
	b=k2F2uHtJUQacaLtwrwyK2GByQ9HZ0+3sqM29Zn8H9YJjaJu2noH3d1DMg4QFucvSAmr3
	 QHZW5Xrd0kEjqETX4/Q60cKZi/hPI5+bUNpIrec5Gd6qy4qyl3esLzy2OKp1lItsT/0fx
	 UCFvzPx7pO6ov6h0yEpRGyBWAV1RUQVznUoaZqCpSfefHRTWQ/hTVKbuxEmr7QDzKsCgV
	 UQffHy1gIUMtkkmAEcOcGuvs41V8vFt2poluXSwv12KbhhnlKXnmW73G6ULfJwoxcX+1a
	 c0UuhiulVHIjUUubLjZB8PwDxNiWpyRaUaeTfCnTaaV/xjKbUQ8oZ85ysO3fy/5OdhQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1064E1F000CA;
	Thu, 12 Nov 2026 17:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504476;
	bh=oE10Mo/COjpbov79+NF0rHDyXxL+FvsL0v5e9tMoXcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Il7r2OHjSXsQXNi0ZsPJhkQruXpBOeflvV2GarWH4PWZdn9aR5Ewv2jNIow/Rqc0f
	 uhmgSk0Vw7NotsDItUyC7NzIl5fRGhP1C+vptdwOdW4fgO0APT+JnF8sK8GFIPnr4t
	 Ll0limCJX0ZbRlH2h9imNad60DlBj2pWGq8wNoRxmtTmO4PdiTyI/JqePNMmEF5Htn
	 FwE3P1l7fqeD7E58I+hV9DioqnV9frhA+xh7m0xst6oCGS2YCNfwkD/9f4eWWd21vd
	 Vei7fHKIus33zjros0jAHqQyNu6ELmo+fXZDnmEjDiZMjWpAgq1Q1bj/IRuMGHfAjH
	 xi9mrBiS/neVw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 92A7947465;
	Thu, 12 Nov 2026 17:27:55 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 17:27:58 +0000
Subject: [PATCH v3 4/4] can: kvaser_usb: hydra: check the payload of
 extended rx commands
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-kvaser-usb-validate-v3-4-61587f639508@gmail.com>
References: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>
In-Reply-To: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794504474; l=2808;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=WJCjgUb94163buNtNhHfE+CDpz0+R00yFLhc1KmDJuY=;
 b=7xCW0Jrj0rmfzez6b34gGJhOU73/5bicHQMaYqAVD1b0s2gnqNXuRl5zinNc1UiaSCiLTHftT
 w0ThJMmM1UsCW1lcnqDjvknzQqAAJi2XYpvZik350eaNA+nP0t2bNFK
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

kvaser_usb_hydra_rx_msg_ext() reads the error frame data or copies up
to 64 bytes of CAN FD payload from an extended command.  Both start at
byte 32 of the command, and the number of payload bytes is derived from
the DLC in kcan_header.  Neither is checked against the length of the
command, which the parsers only guarantee to be at least
sizeof(struct kvaser_cmd), 32 bytes.

A device can therefore send a short CMD_RX_MESSAGE_FD command with a
large DLC and make the driver copy up to 64 bytes that follow the
command into the CAN frame that is passed to user space: stale data of
earlier transfers in the receive buffer or in usb_rx_leftover, or data
beyond the 3072 bytes of the receive buffer if the command is the last
one in a full transfer.

Check that the command contains the error frame data and the payload
before using them, and count the command as an rx error otherwise.

Found by the Sashiko AI review of the previous version of this series.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 6b68e0714ae3..387a522c60fa 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1308,6 +1308,7 @@ static void kvaser_usb_hydra_rx_msg_ext(const struct kvaser_usb *dev,
 	struct sk_buff *skb;
 	struct skb_shared_hwtstamps *shhwtstamps;
 	struct net_device_stats *stats;
+	size_t cmd_len = le16_to_cpu(cmd->len);
 	u32 flags;
 	u8 dlc;
 	u32 kcan_header;
@@ -1327,6 +1328,12 @@ static void kvaser_usb_hydra_rx_msg_ext(const struct kvaser_usb *dev,
 	hwtstamp = kvaser_usb_hydra_ktime_from_cmd(dev->cfg, std_cmd);
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME) {
+		if (cmd_len < offsetofend(struct kvaser_cmd_ext,
+					  rx_can.err_frame_data)) {
+			stats->rx_errors++;
+			return;
+		}
+
 		kvaser_usb_hydra_error_frame(priv, &cmd->rx_can.err_frame_data,
 					     hwtstamp);
 		return;
@@ -1370,6 +1377,14 @@ static void kvaser_usb_hydra_rx_msg_ext(const struct kvaser_usb *dev,
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_REMOTE_FRAME) {
 		cf->can_id |= CAN_RTR_FLAG;
 	} else {
+		/* The payload must be part of the received command */
+		if (cmd_len < offsetof(struct kvaser_cmd_ext,
+				       rx_can.kcan_payload) + cf->len) {
+			stats->rx_errors++;
+			kfree_skb(skb);
+			return;
+		}
+
 		memcpy(cf->data, cmd->rx_can.kcan_payload, cf->len);
 
 		stats->rx_bytes += cf->len;

-- 
2.43.0


