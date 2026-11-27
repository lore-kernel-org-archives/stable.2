Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776060;
	b=H2pClN4NtujEwXu0sqbvEZBAQPXxrJ+uDHOEzN4TsZjC2PeeeVEoSjDCPMrkSRgec0UG
	 BGK2l41R1/8SgVhiYM8h/VHD/JQrlNohjjTQSeQUQO+smsdBZetZdYIxfu9Xd3o8wQ6wB
	 e6d/iGu5cLFik7McCBQSczjUgnOBvwL7Vub3AtZOpaKAhQjsYZquye1D5P3TcDEaqWIJ7
	 MVSeEhCBfEI5glN6R5B89FeRLtF3vj8dAPH8K1DpK48gBcktlu4SYaUxXhWuTozHyzCqR
	 X5jNZe8TdJlcRnzhuDk85+OpYzb/0sy7rQbQ3OoozYsaNEmlOF8KK9r+GFIH4Y+o43w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=kVvljxRJFWTX1Of7BMq7tBbEcyKcnjbgUy5aROkMRo4=;
	b=TR5jEeiBKIA3dHpwkpVzGm8VuN1u332uUvpDb7rppq1PTnPtK5OqB32s+XyTDJh9U2Jh
	 9lW/lp2mgfdHeN/EHaBCrfklPNAx12DvyU/vncizd+vTuhtDI6Y78El807Yly/HEot+De
	 efncIvKCgjQ/fDVWVUZ9bGnB1Boqztm/xEdExn9kweUZh+36Pc6NfWBuq491dLPwbzrpb
	 V3dcPMNqvDVl3cvhb+AybD7yac4+rEId7QagvMsEtfp+rq0AWpViaaQJYlKUARm+bJeMw
	 CRhtFxJmmFiXpkGEhsM3hJca9xNtz+W2p5015R+wlaX5TTssBMHMpNKl5iwXlxFDXHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=df1TchSO;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D684606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D684606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=df1TchSO
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso3639178f8f.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1795776058; x=1796380858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kVvljxRJFWTX1Of7BMq7tBbEcyKcnjbgUy5aROkMRo4=;
        b=df1TchSOBPJNJwnpdOdshy9DMRuKwziYE2ERQw+kFLTv//MX2VH0MvuoWDwD4ntyzc
         yyvYpCzdygEGN0BjCyXAoXR9b3tMWmmD55fMPlM7GFMJAvOuB0jYbm6j0B2nw8e5tUHy
         6LW8FI7wGTxTtn2BWDybOn4kaVIaYkRdIDD0f80ihns5YeMFJG+PHoG5Cm+VdLhoSLWO
         MeeVdjmoz+Lol9sCioJt0zG2o9FSWDr8tws//ft4llmNGCyQgThiaZmOdIdWuMlKG/KL
         w+lz4E1hNWTI8PTuzNPLQuenBmcBYyYB1fnOkVYRx0LQ4nS+0rPytpZhp2rO88ZRYCvu
         BoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776058; x=1796380858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVvljxRJFWTX1Of7BMq7tBbEcyKcnjbgUy5aROkMRo4=;
        b=AnPgm3vqqIFI26WQwvFwHtFh2nAYIb20xx/vFPI/aFZNj1Y2k9fAbaIdcPo/6RXgLY
         VWabEOPzPdU6txK4gxyUT1o9hHe3Peuw6XhhDEoKL4RzdEg/7tjdJkXPIiepjRphSu6J
         a8KP+bz1sR2cW+8xTiaWl/1RXA32DbPpBisEt2CVI8rCb6XMAeiKtxC3sAnLUSeg71Zt
         aNIEZwsSRAS/ug0yBMK9EFLOuisozoCx9CZGAfJuY/904x3KupA/eRyBU2Aew5rMEf2B
         0Y6vdivE6aqQxlVgm+Wb5K3vQ2AhTuY2Nf8LSZyPy6bn96IYrELNd01JePjw9cnzOL+M
         FS4A==
X-Forwarded-Encrypted: i=1; AL+hErGl/RaY7m4oZ98XxWAu06+tK1nS+LrzjYtmMxEzYF3abqc5qFpzZ4aZkOUOkX7iOEiyymqcxec=@vger.kernel.org
X-Gm-Message-State: APuU4Z+P2229pQi/Sc5OoP2uholKyqPsqDk+fONvgfKVvS0O1KqUvdTZ
	JCKPMC8Qvs66b3IwrS9M29dEW75ytQwIo60Wj5SaYBK5j0mAxebyjOLupdclBBxU6MU=
X-Gm-Gg: AZFdTZfh+q9Oa94Nmvw02EPojyNy4duHz7CjKLJtFzDVIffoXSJPT5h2Y/HBmAzUyei
	cx/Kx2nQkfPrZTwVt6fZW0uVuAG+VToUJ97aY+F+i3B0GkR11UTujOrrnnhjh+cchHPQKZsfp3R
	LSXClZkRVpPedr4RwjesLmS+iEKt50RgBwF3NqDNRNKDoCPRidGbWSpr3KAn5gy1HIijZJFnjpq
	tWlDSCbt4PLpMa7Pypj8+uOjbXddAtQlRYCqel8LgLTh7XQZu4PKXaWYbMzOUHLW1J0+A6aVvu+
	20iDhKTd7OgjRwiaqxlmk8fJ7DIApxFtg8CIZQQfrGjNnYvAsbDYo0+toQrjwtnjfbJt0FE/QcX
	g4njWb4T9fqLdsUOQBEkUfCaZciouHPTY6/GSYCQMTZ9y6u1turDPqCkc9BnJ7fbBc1zKfLrcbj
	OdsLmVcgV0a8VVVEczEig9Y52BSv+OnMQXfip4I7H/cAR+K9IKLZ31ai9y8eyU7Bd/hoNdCwFD/
	Gw9/Oz8A99u0oFNGG9Yp2bTTarNvTMVbTTLnr0zBa8YB6VT24hc7rChcZ/U8SgK/KUVqKBSExAI
	sqPmP8WVqKS2DcXrZ/rVue65EU1z9akqMQhRXZkwdsCR+Akrz/WM2hF5dlW9vHrbBDp6600uht+
	aBr2YyxRWRg==
X-Received: by 2002:a05:6000:4a0e:b0:48b:451:4f19 with SMTP id ffacd0b85a97d-4abb7971c1dmr45358032f8f.51.1795776057820;
        Fri, 27 Nov 2026 02:40:57 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm45597649f8f.32.2026.11.27.02.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:40:57 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 27 Nov 2026 14:40:46 +0400
Subject: [PATCH v2 1/6] usb: typec: fusb302: Find the next message when the
 RX FIFO is out of step
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-fusb302-getsourcecap-v2-1-6770eb1e7945@flipper.net>
References: <20261127-fusb302-getsourcecap-v2-0-6770eb1e7945@flipper.net>
In-Reply-To: <20261127-fusb302-getsourcecap-v2-0-6770eb1e7945@flipper.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Yueyao Zhu <yueyao@google.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12171; i=alchark@flipper.net;
 h=from:subject:message-id; bh=8FqjcSdoBj2gZZl7Z82yfPvjmeuPF0tJnGWe6Lh9qE4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRzxpmplHa/uesk9uD8s3p2tRmcFq21yQ3fZhWfvvhZ6
 0LN6hsnOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqLE1Ghs8e2yQ3PtZtn/Hk71nzVTJPrYwup3NPnfaH3/5uAqefvDLD/+LHE95
 IME04enFCzI29zwu0pu1I/ZawbpPyXDvGGn7XXfwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The chip writes each byte into the RX FIFO as it comes off CC, so a
flush in the middle of a packet leaves the rest of that packet in the
FIFO with no token in front, and the driver reads that tail, padded with
zeros where the FIFO runs dry, as a message. TCPM acts on the junk
header. On a Flipper One attaching as a sink, the flush that turns PD RX
on raced the partner's first message in 2 of about 35 attaches: a
"message" with header 0 made TCPM see a data role mismatch and go to
ERROR_RECOVERY. With the FIFO flushed on purpose 27 times while the
partner sent a Ping every 20ms, 98 junk messages reached TCPM, and it
reset 17 times.

Flushing the FIFO again once the junk is spotted is no cure, as any
message behind the tail may have been acknowledged already, and the
partner never sends it again.

Keep the bytes read from the FIFO in a buffer instead, and scan for a full
valid message, including a CRC that checks out, to avoid interpreting junk
bytes as a start of a message.

In the same test, no junk reaches TCPM now, and only the Pings that the
forced flushes cut short go missing.

Fixes: c034a43e72dd ("staging: typec: Fairchild FUSB302 Type-c chip driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/typec/tcpm/Kconfig   |   1 +
 drivers/usb/typec/tcpm/fusb302.c | 222 +++++++++++++++++++++++++++++++++------
 2 files changed, 190 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 00baa7503d45..e551cb63a775 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -59,6 +59,7 @@ config TYPEC_FUSB302
 	depends on I2C
 	depends on EXTCON || !EXTCON
 	depends on DRM || DRM=n
+	select CRC32
 	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
 	help
 	  The Fairchild FUSB302 Type-C chip driver that works with
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 1cbe272ad686..d2d0e8ffc308 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -6,6 +6,7 @@
  */
 
 #include <drm/bridge/aux-bridge.h>
+#include <linux/crc32.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -27,6 +28,7 @@
 #include <linux/string.h>
 #include <linux/string_choices.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/usb.h>
 #include <linux/usb/typec.h>
 #include <linux/usb/tcpm.h>
@@ -72,6 +74,11 @@ static const u8 rd_mda_value[] = {
 #define LOG_BUFFER_ENTRIES	1024
 #define LOG_BUFFER_ENTRY_SIZE	128
 
+/* An SOP* token, the header, up to seven data objects and the CRC */
+#define FUSB302_RX_MSG_MAX	(1 + 2 + PD_MAX_PAYLOAD * 4 + 4)
+/* The size of the RX FIFO */
+#define FUSB302_RX_FIFO_LEN	80
+
 struct fusb302_chip {
 	struct device *dev;
 	struct i2c_client *i2c_client;
@@ -110,6 +117,17 @@ struct fusb302_chip {
 	bool vbus_on;
 	bool charge_on;
 	bool pd_rx_on;
+	/*
+	 * Bytes read from the RX FIFO but not handled yet: the start of a
+	 * message to read on, or bytes to find the next message in
+	 */
+	u8 rx_buf[FUSB302_RX_MSG_MAX];
+	u8 rx_len;
+	/*
+	 * The next message may not be at the start of the buffer.
+	 * Look for its start first before processing.
+	 */
+	bool rx_resync;
 	bool vbus_present;
 	enum typec_cc_polarity cc_polarity;
 	enum typec_cc_status cc1;
@@ -831,6 +849,17 @@ static int fusb302_pd_rx_flush(struct fusb302_chip *chip)
 				    FUSB_REG_CONTROL1_RX_FLUSH);
 }
 
+/*
+ * Forget whatever was read from the RX FIFO but not handled yet. After a flush
+ * or a reset, the FIFO may go on with the rest of a packet cut short, so look
+ * for the next message then, rather than read on from the first byte.
+ */
+static void fusb302_pd_rx_reset(struct fusb302_chip *chip, bool cut_short)
+{
+	chip->rx_len = 0;
+	chip->rx_resync = cut_short;
+}
+
 static int fusb302_pd_set_auto_goodcrc(struct fusb302_chip *chip, bool on)
 {
 	if (on)
@@ -885,6 +914,7 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 		fusb302_log(chip, "cannot flush pd rx buffer, ret=%d", ret);
 		goto done;
 	}
+	fusb302_pd_rx_reset(chip, true);
 	ret = fusb302_pd_tx_flush(chip);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot flush pd tx buffer, ret=%d", ret);
@@ -1477,43 +1507,168 @@ static int fusb302_handle_togdone(struct fusb302_chip *chip)
 
 static int fusb302_pd_reset(struct fusb302_chip *chip)
 {
+	/* What was read of a message before the reset is of no use after it */
+	fusb302_pd_rx_reset(chip, true);
+
 	return fusb302_i2c_set_bits(chip, FUSB_REG_RESET,
 				    FUSB_REG_RESET_PD_RESET);
 }
 
-static int fusb302_pd_read_message(struct fusb302_chip *chip,
-				   struct pd_message *msg)
+static void fusb302_pd_rx_drop(struct fusb302_chip *chip, int n)
 {
-	int ret = 0;
-	u8 token;
-	u8 crc[4];
-	int len;
+	chip->rx_len -= n;
+	memmove(chip->rx_buf, chip->rx_buf + n, chip->rx_len);
+}
 
-	/* first SOP token */
-	ret = fusb302_i2c_read(chip, FUSB_REG_FIFOS, &token);
-	if (ret < 0)
-		return ret;
-	ret = fusb302_i2c_block_read(chip, FUSB_REG_FIFOS, 2,
-				     (u8 *)&msg->header);
-	if (ret < 0)
-		return ret;
-	len = pd_header_cnt_le(msg->header) * 4;
-	/* add 4 to length to include the CRC */
-	if (len > PD_MAX_PAYLOAD * 4) {
-		fusb302_log(chip, "PD message too long %d", len);
-		return -EINVAL;
+static bool fusb302_pd_rx_is_token(u8 byte)
+{
+	byte &= FUSB302_RX_TKN_MASK;
+
+	return byte == FUSB302_RX_TKN_SOP || byte == FUSB302_RX_TKN_SOP1;
+}
+
+/* FIFO bytes taken by the message whose token is at rx_buf[off] */
+static int fusb302_pd_rx_msg_len(struct fusb302_chip *chip, int off)
+{
+	u16 header = get_unaligned_le16(chip->rx_buf + off + 1);
+
+	return 1 + 2 + pd_header_cnt(header) * 4 + 4;
+}
+
+/* The chip keeps the CRC it received after the header and data objects */
+static bool fusb302_pd_rx_crc_ok(struct fusb302_chip *chip, int off, int len)
+{
+	return ~crc32_le(~0U, chip->rx_buf + off + 1, len - 5) ==
+	       get_unaligned_le32(chip->rx_buf + off + len - 4);
+}
+
+/*
+ * Return the offset of the first message past the start of rx_buf that it
+ * holds in full, with its CRC checking out, or 0 if there is none
+ */
+static int fusb302_pd_rx_find(struct fusb302_chip *chip)
+{
+	int off, len;
+
+	for (off = 1; off + 3 <= chip->rx_len; off++) {
+		if (!fusb302_pd_rx_is_token(chip->rx_buf[off]))
+			continue;
+		len = fusb302_pd_rx_msg_len(chip, off);
+		if (off + len <= chip->rx_len &&
+		    fusb302_pd_rx_crc_ok(chip, off, len))
+			return off;
 	}
-	if (len > 0) {
-		ret = fusb302_i2c_block_read(chip, FUSB_REG_FIFOS, len,
-					     (u8 *)msg->payload);
+
+	return 0;
+}
+
+/*
+ * Read up to n more bytes into rx_buf and return how many. When the FIFO is in
+ * step, rx_buf starts with a message the chip has received in full, so read the
+ * rest in one go. Otherwise read one byte at a time while the FIFO holds data,
+ * as a dried out FIFO starts returning zeros instead of received data, and real
+ * bytes will be returned to the next read instead once the device receives them
+ */
+static int fusb302_pd_rx_read(struct fusb302_chip *chip, int n)
+{
+	u8 status1;
+	int ret;
+
+	if (chip->rx_resync) {
+		ret = fusb302_i2c_read(chip, FUSB_REG_STATUS1, &status1);
 		if (ret < 0)
 			return ret;
+		if (status1 & FUSB_REG_STATUS1_RX_EMPTY)
+			return 0;
+		n = 1;
 	}
-	/* another 4 bytes to read CRC out */
-	ret = fusb302_i2c_block_read(chip, FUSB_REG_FIFOS, 4, crc);
-	if (ret < 0)
+	ret = fusb302_i2c_block_read(chip, FUSB_REG_FIFOS, n,
+				     chip->rx_buf + chip->rx_len);
+	if (ret < 0) {
+		/* Some of it may have left the FIFO all the same */
+		chip->rx_resync = true;
 		return ret;
-	fusb302_log(chip, "PD message header: %x", msg->header);
+	}
+	chip->rx_len += n;
+
+	return n;
+}
+
+/*
+ * Read in and handle the next message in the RX FIFO. Return 1 if there was
+ * one, 0 if the FIFO ran out first, or a negative error code.
+ */
+static int fusb302_pd_read_message(struct fusb302_chip *chip)
+{
+	struct pd_message msg = {};
+	int dropped = 0;
+	int len, off, ret;
+	u8 token;
+
+	for (;;) {
+		/*
+		 * Already discarded a full FIFO's worth of junk - leave
+		 * whatever remains to another pass
+		 */
+		if (dropped >= FUSB302_RX_FIFO_LEN) {
+			ret = 0;
+			goto out;
+		}
+		/*
+		 * The chip writes each byte into the FIFO as it comes off CC,
+		 * so a flush in the middle of a packet leaves the rest of it
+		 * there with no token in front. Following bytes may look like a
+		 * valid token without being one, so only trust them if the CRC
+		 * of the resulting message checks out, too. If not, look on
+		 * from the next byte: there may be a next message that the chip
+		 * has already acknowledged, and we must not miss it.
+		 */
+		while (chip->rx_len &&
+		       !fusb302_pd_rx_is_token(chip->rx_buf[0])) {
+			chip->rx_resync = true;
+			fusb302_pd_rx_drop(chip, 1);
+			dropped++;
+		}
+		if (chip->rx_len < 3)
+			len = 3;
+		else
+			len = fusb302_pd_rx_msg_len(chip, 0);
+		if (chip->rx_len < len) {
+			ret = fusb302_pd_rx_read(chip, len - chip->rx_len);
+			if (ret < 0)
+				goto out;
+			if (ret)
+				continue;
+			/*
+			 * The FIFO ran dry, which may be due to a bogus token
+			 * claiming more bytes than will ever come. See if the
+			 * following bytes contain a complete valid message.
+			 */
+			off = fusb302_pd_rx_find(chip);
+			if (!off)
+				goto out;
+			fusb302_pd_rx_drop(chip, off);
+			dropped += off;
+			continue;
+		}
+		if (fusb302_pd_rx_crc_ok(chip, 0, len))
+			break;
+		if (!chip->rx_resync)
+			fusb302_log(chip, "PD message failed CRC check, header: %x",
+				    get_unaligned_le16(chip->rx_buf + 1));
+		chip->rx_resync = true;
+		fusb302_pd_rx_drop(chip, 1);
+		dropped++;
+	}
+
+	chip->rx_resync = false;
+	token = chip->rx_buf[0];
+	memcpy(&msg, chip->rx_buf + 1, len - 5);
+	fusb302_pd_rx_drop(chip, len);
+	len -= 7;
+	ret = 1;
+
+	fusb302_log(chip, "PD message header: %x", msg.header);
 	fusb302_log(chip, "PD message len: %d", len);
 
 	/*
@@ -1526,13 +1681,15 @@ static int fusb302_pd_read_message(struct fusb302_chip *chip,
 	 * TX_SUCCESS and GCRCSENT events out of order on occasion, so we need
 	 * to check the message type to ensure correct reporting to TCPM.
 	 */
-	if ((!len) && (pd_header_type_le(msg->header) == PD_CTRL_GOOD_CRC))
+	if (!len && pd_header_type_le(msg.header) == PD_CTRL_GOOD_CRC)
 		tcpm_pd_transmit_complete(chip->tcpm_port, TCPC_TX_SUCCESS);
 	else if ((token & FUSB302_RX_TKN_MASK) == FUSB302_RX_TKN_SOP1)
-		tcpm_pd_receive(chip->tcpm_port, msg, TCPC_TX_SOP_PRIME);
+		tcpm_pd_receive(chip->tcpm_port, &msg, TCPC_TX_SOP_PRIME);
 	else
-		tcpm_pd_receive(chip->tcpm_port, msg, TCPC_TX_SOP);
-
+		tcpm_pd_receive(chip->tcpm_port, &msg, TCPC_TX_SOP);
+out:
+	if (dropped)
+		fusb302_log(chip, "dropped %d bytes from the RX FIFO", dropped);
 	return ret;
 }
 
@@ -1605,7 +1762,6 @@ static void fusb302_irq_work(struct work_struct *work)
 	bool intr_togdone;
 	bool intr_bc_lvl;
 	bool intr_comp_chng;
-	struct pd_message pd_msg;
 
 	mutex_lock(&chip->lock);
 	/* grab a snapshot of intr flags */
@@ -1693,7 +1849,7 @@ static void fusb302_irq_work(struct work_struct *work)
 
 	if (interrupta & FUSB_REG_INTERRUPTA_TX_SUCCESS) {
 		fusb302_log(chip, "IRQ: PD tx success");
-		ret = fusb302_pd_read_message(chip, &pd_msg);
+		ret = fusb302_pd_read_message(chip);
 		if (ret < 0) {
 			fusb302_log(chip,
 				    "cannot read in PD message, ret=%d", ret);
@@ -1713,7 +1869,7 @@ static void fusb302_irq_work(struct work_struct *work)
 
 	if (interruptb & FUSB_REG_INTERRUPTB_GCRCSENT) {
 		fusb302_log(chip, "IRQ: PD sent good CRC");
-		ret = fusb302_pd_read_message(chip, &pd_msg);
+		ret = fusb302_pd_read_message(chip);
 		if (ret < 0) {
 			fusb302_log(chip,
 				    "cannot read in PD message, ret=%d", ret);

-- 
2.56.0

