Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88E395D8E
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214345; cv=none; b=J6m3lbjxZc50+D4MdWdmxfNZhMtze4kkhn0HU5H5cWIR3uv2lUOX7cFRoDL1ysRdob1xp/+a+gMWfDyCvE8VJlK+HnWEWXgPhYLGL3Po6DvavrB3NMBl0cwrh+TH8/BQm/WyBfaLnJ25mJy0u9atEzw4klN3iYkKUk+MdYv5lMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214345; c=relaxed/simple;
	bh=k/4jwuXnA12hp9k1BEvLCcEgKt2ybI+KTJlDgEkJj5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wgq6qBLfwiIcUus/91EE22NYgCg42dtY3JO0h2G4yvG5I4bcCDM/2Qa0zNBB2+SudqNE2Ihs1smCJZ1+iarvlhsP5MMMDikgBpJT2024bXGMRn89ExJ+BGmHGeNZTLZxIY9ZYvERmuf4k5POUdfEXimCqlFGEKreHBKxd82CjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=T0LYpTHF; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="T0LYpTHF"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd04edb5so2676492c88.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 18:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790214342; x=1790819142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sciGWXbPKjaBz8QOgB5kzziZxkd6jBEVBtn6uKIW3/M=;
        b=T0LYpTHFQ4yxEt+FX1kOUNUw58IwY5qRRD3e7qXtuPqVLMk/IRYFB8mSVsJm0avLLy
         fpf8r8pDgKFfK3toxvVSCLVXmOSwjjG4N6VZ33YzUgWhKXra7VXoEBf609dg9ns3TBxt
         oL+Y2qspSzzFXSdh0cU4Yoj+9pgg+gjnRXH/8dLXnF1OObo/W4Q+sLHfqO6XOhvI8rcA
         qMV1jw3K0Q57RziB6sR1o4kRQmnSHwjTWlXrWWdq5fvyfMKigKmkyVhiu4xTFlK6/4Ue
         4jcm+4LsYLwVq5iUffHsUHenJgbzZucq62UhRuMNk5t9b4POnEyhSlxWSlwYNFHot61d
         WIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214342; x=1790819142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sciGWXbPKjaBz8QOgB5kzziZxkd6jBEVBtn6uKIW3/M=;
        b=j2zirtWM8fsXKQBryIZp1FWmtifV1Z6E/xcEdlI8/irAbNdL6+w9xpS0cmGcav0teQ
         fn/UfspGCUO0QywvsJyZTTjcHcTHZXA/+AOv8pjOV538UpUUXdqgnnUS8oeJ5mBmg/mZ
         pMPdwVBqoeGa1g61kOQNmqwkzSBoK86lKWLjvh30SsTeQLnt8EyXtQo7c6Jg/EmKsNHI
         RnhfHxaWN7cOweqUb5TGXRMLqHU9xzygiPqeJ9oo7B1e2mo10TTR1mYGZDj+PVFduiah
         zhpyBk7FkBfno1LYjR+5kwrpBaM/3bHcEgkbegGhz9yuO9UJ2zlCyHpM60jPfrzpN9tL
         uZQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxo8YhWaOgRTuTAldxXWbRUCVfryfQL8IEeRmoWjD5Afp2zQehgPxK4xiEn4XjmN6W2D8hrgc4=@vger.kernel.org
X-Gm-Message-State: AFuF++klgT1TQbeMc+YTfR+RIbUt8V1G14u1ZrWt3KZMP3SV8Jr+hKSz
	CEk1pLX9V34RADeCzgnQOvpi11cqDV80KL6nuunkk7DakUirMEgSG82XNvokobHTxYo=
X-Gm-Gg: AYBFou3GgfB3YmNw0mce+MFLrOIj1EhfvjRH3Ur5G5Lw+RMIvYCg6FYVaJU/wMtJX1B
	E2TRQKAOv7fsgQKjulRcbMBz5/hqc/U0cz+wkKtOwm2VBPoUc8A3g1g3A+60eCMaf7yd7yhTPN4
	QCwv77WueHtYQDUyFO+h2HY2nnK+4DT1fs9MbluTU5yYYmdfUKaTPvNxs6KmNeTS2XLwzm9PJfQ
	BS0gLawjv9FOVvLR6rNL6CHFaaYwB5wslm1CFGxqtL6//Xs8aKmo59DwIbr+kWN21NZe97jzVWj
	DdaoGhtx8l726RA0Nkalg4phy00bj7MAgu2MmpM5TEfshkKXCOFFMRnF67SkwPiVlsxrNxRxpJr
	7rZGEaU65dyNCJIIwr8r8gmzIbNfmxgYqg3PiwKMX0fWNjV9DTHurALitXDjBzy5I2V1rTfNVRa
	qDsu5U+mTePr5yh1Jk4ScyZyfKwXOM6DW3bsbCvl6R/SHzQFjCJLGaVb31A2vzcH93Idsl9lwwa
	Q==
X-Received: by 2002:a05:7022:294:20b0:13b:3bee:1e2e with SMTP id a92af1059eb24-14503fa45acmr668581c88.18.1790214342262;
        Wed, 23 Sep 2026 18:45:42 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14501794269sm2927598c88.8.2026.09.23.18.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:45:41 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 23 Sep 2026 18:45:36 -0700
Subject: [PATCH v6 1/3] i2c: xiic: preserve PEC byte length in SMBus block
 read setup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-i2c-xiic-v6-1-3a15b6397f5a@nexthop.ai>
References: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
In-Reply-To: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Raviteja Narayanam <raviteja.narayanam@xilinx.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790214340; l=6559;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=k/4jwuXnA12hp9k1BEvLCcEgKt2ybI+KTJlDgEkJj5E=;
 b=r4M8X37QqLw4CWgFFpJYX3JMWOwMDO9jjlOqzPXK17vlYuyqjFULgyEWCva/UHc8Gkz+yryO/
 fl0w4ey4h3cDBcV2DQqK5o7h+KzKVw7U/K42OZjAGtoOqkRRzVJgZdg
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

xiic_smbus_block_read_setup() recalculates i2c->rx_msg->len based on the
length byte returned by the device, but historically clobbered the PEC
byte expectation the SMBus core had baked into msg->len. That dropped
the PEC byte from the caller's buffer on the normal and chunked
receive-fifo branches.

Compute pec_len up-front as (i2c->rx_msg->len - 1) and add it to the
new length in every branch:

  - chunked (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH): set the drain
    target to rxmsg_len + 1 + pec_len.

  - deferred (small enough to drain in one fill but >= MIN_LEN total):
    same.

  - padded (1 + rxmsg_len + pec_len < SMBUS_BLOCK_READ_MIN_LEN): the
    hardware needs at least 3 bytes on the bus to exit the read
    cleanly (the second byte is already being clocked in by the time
    the ISR reads the length byte and is too late to NACK), so we
    still pad rx_msg->len up to SMBUS_BLOCK_READ_MIN_LEN. The dummy
    trailing byte that gets drained must then be trimmed off before
    handing the message back to the SMBus core; otherwise
    i2c_smbus_check_pec() reads buf[len-1] (= dummy) instead of the
    real PEC byte at buf[1] and rejects every clean zero-length block
    read with -EBADMSG.

    Record the true valid byte count in a new field
    i2c->smbus_actual_len and trim rx_msg->len down to it in
    xiic_smbus_trim_len(), called from both completion sites that
    clear rx_msg: xiic_process()'s RX_FULL branch and
    xiic_recv_atomic(), which drains the FIFO with interrupts off.

    smbus_actual_len is per-receive state, so xiic_start_recv() clears
    it before every receive. Only the padded branch ever sets it, and
    a block read aborted by arbitration loss or a TX error never
    reaches the completion site, so without that clear a stale value
    would trim the length of an unrelated later read.

    Widen the branch condition from the old "(rxmsg_len == 1) ||
    (rxmsg_len == 0)" to "(1 + rxmsg_len + pec_len) < MIN_LEN" so that
    user requests with multi-byte trailing bytes (e.g. pec_len == 2 on
    a zero-length block) flow through the deferred branch instead of
    getting truncated to MIN_LEN here.

Fixes: e4c1ff772e1a ("i2c: xiic: Add smbus_block_read functionality")
Cc: stable@vger.kernel.org
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..6cb264cbc366 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -73,6 +73,9 @@ enum i2c_scl_freq {
  * @prev_msg_tx: Previous message is Tx
  * @quirks: To hold platform specific bug info
  * @smbus_block_read: Flag to handle block read
+ * @smbus_actual_len: Valid byte count (length + payload + optional PEC) of a
+ *	padded SMBus block read. msg->len is trimmed to this on completion.
+ *	Zero when no trimming is needed.
  * @input_clk: Input clock to I2C controller
  * @i2c_clk: I2C SCL frequency
  * @atomic: Mode of transfer
@@ -98,6 +101,7 @@ struct xiic_i2c {
 	bool prev_msg_tx;
 	u32 quirks;
 	bool smbus_block_read;
+	unsigned int smbus_actual_len;
 	unsigned long input_clk;
 	unsigned int i2c_clk;
 	bool atomic;
@@ -539,6 +543,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 
 	/* Check if received length is valid */
 	if (rxmsg_len <= I2C_SMBUS_BLOCK_MAX) {
+		unsigned int pec_len = i2c->rx_msg->len - 1;
+
 		/* Set Receive fifo depth */
 		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
 			/*
@@ -546,23 +552,26 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			 * Receive fifo depth should set to Rx fifo capacity minus 1
 			 */
 			rfd_set = IIC_RX_FIFO_DEPTH - 1;
-			i2c->rx_msg->len = rxmsg_len + 1;
-		} else if ((rxmsg_len == 1) ||
-			(rxmsg_len == 0)) {
+			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
+		} else if (1 + rxmsg_len + pec_len < SMBUS_BLOCK_READ_MIN_LEN) {
 			/*
-			 * Minimum of 3 bytes required to exit cleanly. 1 byte
-			 * already received, Second byte is being received. Have
-			 * to set NACK in read_rx before receiving the last byte
+			 * The HW needs SMBUS_BLOCK_READ_MIN_LEN bytes on the
+			 * bus to exit cleanly: by the time the ISR reads the
+			 * length byte the second byte is already being clocked
+			 * in, too late to NACK. Pad the drain target and record
+			 * the real length, trimmed back on completion so the
+			 * PEC check sees the right byte.
 			 */
 			rfd_set = 0;
 			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
+			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
 		} else {
 			/*
 			 * When Rx msg len less than Rx fifo capacity
 			 * Receive fifo depth should set to Rx msg len minus 2
 			 */
 			rfd_set = rxmsg_len - 2;
-			i2c->rx_msg->len = rxmsg_len + 1;
+			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
 
@@ -575,6 +584,16 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 	dev_err(i2c->adap.dev.parent, "smbus_block_read Invalid msg length\n");
 }
 
+/*
+ * Undo the setup-time padding of a short SMBus block read before rx_msg is
+ * cleared, so the PEC check sees the right byte.
+ */
+static void xiic_smbus_trim_len(struct xiic_i2c *i2c)
+{
+	if (i2c->rx_msg && i2c->smbus_actual_len)
+		i2c->rx_msg->len = i2c->smbus_actual_len;
+}
+
 static void xiic_read_rx(struct xiic_i2c *i2c)
 {
 	u8 bytes_in_fifo, cr = 0, bytes_to_read = 0;
@@ -797,6 +816,8 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
 		xiic_read_rx(i2c);
 		if (xiic_rx_space(i2c) == 0) {
+			xiic_smbus_trim_len(i2c);
+
 			/* this is the last part of the message */
 			i2c->rx_msg = NULL;
 
@@ -938,6 +959,7 @@ static void xiic_recv_atomic(struct xiic_i2c *i2c)
 			return;
 	}
 
+	xiic_smbus_trim_len(i2c);
 	i2c->rx_msg = NULL;
 	xiic_irq_clr_en(i2c, XIIC_INTR_TX_ERROR_MASK);
 
@@ -955,6 +977,9 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 	u8 cr = 0, rfd_set = 0;
 	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
 
+	/* A stale value from an aborted block read would truncate this msg. */
+	i2c->smbus_actual_len = 0;
+
 	if (!i2c->atomic)
 		dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
 			__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),

-- 
2.54.0

