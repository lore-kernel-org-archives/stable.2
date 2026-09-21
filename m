Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CE4F649E
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015143; cv=none; b=HNmAZqs/0awe6xtJgB7S5fsPHGRjoSFC20avkYw5yypZPe/iuWytfwPY3wdbZYvXGHAmz2bWoFkw1IRMMWlIBU4Vl3BJdBKfmHNu7MfbsbHxHt0tO/3kAB45a9KYERGGKsYDHz/UsC+9AFxKFipq+5cR7WUTzhq33k4MlDuwzss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015143; c=relaxed/simple;
	bh=Zw7I68dk/dfQhHon05xSczDRBjRS89SCdhc9Ul/iA8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4ty9m0AcVYkqCb1DuzbxyTza4JXyJrDVwsh5wAb1tuCmPX/Sq5yc0ZTVJ8CnfVuyfgqJWP4kP/SAWzdJ41UPgxpJKnKytxpCe8rGc5gyAR13O/Q0AyXg+uXQKQS+5yBCCeJQBTdHMaCUpDZhdcLNMWtGvCWFRd7chPMtPEhT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=XfW6T/6s; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="XfW6T/6s"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so2795369a12.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790015141; x=1790619941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gnxM12bjAU6l32+T085J4xBzZcACDHL6vkRV2pEi6lg=;
        b=XfW6T/6stA8FS2kESvEUyJAdokPmDCtfrGOwDx7culklUvV6VSGutSOcyUaMpeA0rW
         B9zW5vL8hhOI9d0hHY65W8k0u1mvP4u5kBddnlPzCZXKEZVyQjcsKTzQWboqqoCdxleg
         ZAZbGkl8zWGLCJHXIiBYN/8ACjVy1VllwVFVPKSWmJWYiawCGQWX80Xi27+j60JI0dNF
         XnmqKZzbiQRLtrE0RJnMI/0rb1F7Z9Er7pHpC8+6LvxB7CvpEYjS4LPsylvKzL8j/sE1
         MqMUV6u54RN7G4o9rZfPLeTo8EDAzH8R9Zn+d5nU3J4oFpRPyNSSQ4wvP1zUIyp/5Sqm
         nn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015141; x=1790619941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnxM12bjAU6l32+T085J4xBzZcACDHL6vkRV2pEi6lg=;
        b=APAAJxKQ0ZpiN6aPFYBs1ByydbUxm6t+wfIjEGM/e5JPJu3UqHiLSOUN0dJJZH45Dy
         0c7vZNhlXez8cypZSvWvIa2LeItrQScbVK7CXQdPweuGMiknFYd7K0VJDUqLuuSRn4S2
         DPn0FwdB2e9afwvfSIHNQNq2901iq3GSep/p2mRHB1KpLrwOgYZ8CoAnycC0e8NG06On
         qAXA9fUVwZSNKNQrd2/Jl5P3Dn9ENdJ2cFNNS2s/hMPPhk6TFjqMGlviGFTkQG0mSA0y
         YFsvxnQWXkKcfAi3H2kcjtcUD+Pha9NtXP3OBdzxlb1iCduD24XTMF9iSexE8TlaRsZd
         U6hw==
X-Forwarded-Encrypted: i=1; AKwUvBx7AMX6EG/9qaKCbGIehqj0ihnCwFfI0wdMAESEZC8V6+xyE1CVLhJANh+QpiUcIAiE5Saxtk8=@vger.kernel.org
X-Gm-Message-State: AFuF++kVTGPij+YBpDRBht11AFErDjyfc1dDkkgnNatiK1jcZe7yHrDb
	F/D54rkg/OnXksIR1/hOnPVFLP63olw0/XNlsJ8w6DQd14CnMYkdz0+Q46sJ5keLC4s=
X-Gm-Gg: AYBFou2Uh8BSS89j75QYTXRD1Iocrg3ItRPecuvw/E6sw+ga6qcTJ+ySjqxcKorjWEm
	67Vpcp7wA9fiu5PTOJ8PRp64VRsiQhrEMzSs+FvcZMUjnw+UwJdmaOfK2LyvTJq6wPSjgF60JZM
	CWI4QSym8Ubt+2mdXy8sq3hepnJ4/7BBvz6k3gl5e/ytZrAAoC8fM5vI653QsF717wfjuDy22DS
	rB9gGe+yv8yHB12Cu88jGKvPeG8RpWQfoHhaDmW/ID3oVwaUe49oDNk31RPZr587ykTeF1LG4D7
	YgwgANr6FHzNVI8oVhXo0SH6RW/nTnp6YJpABeo5WsM+62J5z7f3MhIBR9oC9Gp2l/hSsJy+d9U
	rqFScriIyPCHhTYwzKgasEJXifGYw4YaZVMRjv4wqHNFJZtxeiX+PTdr7bM10syJaWeUnnhGu9u
	2KYtdsibZbN3zscu4bk1n4VO/7xaxLXUtiAabpNWwyi+AFQXcDsgZtDKLmLm1dvcS4IcqlweJPh
	g==
X-Received: by 2002:a05:6a21:4c81:b0:3dd:a196:906c with SMTP id adf61e73a8af0-3dda196a65dmr12713643637.54.1790015140904;
        Mon, 21 Sep 2026 11:25:40 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144df9ad683sm12408974c88.6.2026.09.21.11.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:25:40 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 21 Sep 2026 11:25:36 -0700
Subject: [PATCH v5 1/3] i2c: xiic: preserve PEC byte length in SMBus block
 read setup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-i2c-xiic-v5-1-2fca81e810ea@nexthop.ai>
References: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
In-Reply-To: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790015138; l=5861;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=Zw7I68dk/dfQhHon05xSczDRBjRS89SCdhc9Ul/iA8c=;
 b=hWgnVzhwB+BfXuq7pCDIDcjklKC5IdWFIUMjL8pPfjX0kmLkMe4PrklykCUOBH/adfk1HVV5R
 EgV2AvU1Y+QDLMH4+f1sMsEQwD0FWzQQyzkIBoIi1+4AskvkK1f4AEi
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
    i2c->smbus_actual_len and have xiic_process()'s RX_FULL completion
    site trim rx_msg->len down to it before clearing rx_msg.

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
 drivers/i2c/busses/i2c-xiic.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..22367a069ded 100644
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
 
@@ -797,6 +806,13 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
 		xiic_read_rx(i2c);
 		if (xiic_rx_space(i2c) == 0) {
+			/*
+			 * Undo the setup-time padding before rx_msg is cleared,
+			 * so the PEC check sees the right byte.
+			 */
+			if (i2c->rx_msg && i2c->smbus_actual_len)
+				i2c->rx_msg->len = i2c->smbus_actual_len;
+
 			/* this is the last part of the message */
 			i2c->rx_msg = NULL;
 
@@ -955,6 +971,9 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
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

