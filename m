Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647035A3B1
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156238; cv=none; b=KIkix2If7TFCndczKUI+CnZdDblCK91uz3OHoQQeHiU86PJ/C/aJ5fPCN/lyw7MFc4qO7kJZ7//joGgN5jv0dGnXZ+7fatR3tWZ/m73KkKVx8UnL2YHT3q6NNo9P7XngeaUTaUZQLmoD9Dna18zM7dnYd8Ii4/z5f5G+q9qwiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156238; c=relaxed/simple;
	bh=/8uDHDmLixfhFpYdEQf2GEmia+14q67TtwmDcW/D6yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcr/CN3aYuTxsPZ5ytfFr4gJJLL+qop+gjLvSopCwma2Xf0C2WhtSYRqSent0kkWmuR5/yrnUb6meTHNPPoHtWKNyQ1C5wFm1N+LNV4uHhPJKaCg5V/wM8iVjHVWvv/o6Ut/2E5xP0WPmyaZDoqmklpmMahsZwFumjREn1dnFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9AZZNHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9AZZNHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE521F000E9;
	Mon, 27 Jul 2026 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785156237;
	bh=/He7+myDZBr2SX9314XrDoH7TTIxFn0+RiRvHw93YmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l9AZZNHALthbh7DwJp4Ca1FSSzOjIOK/U0YjDv9CHLGT9JvZkfQYEl2GF57qNRPkQ
	 f5C55NHSkRYHnkFEQcjeK8nEio5M+0uvhJ6mqBALTGlHxoiJ1gidflHlxAg6FCMtVK
	 2wnKLB4NEdi5crKIWfgKECZ0c1/t8v/yYffzFSMRjEsFPq6g5641JRz+QEOB7rAiMq
	 5RQsq09qW43z/Yw8bG3ltVIuNXBQyW+zdxv+YB7npj3eRuplXKK4HleTPYZVgV5iGh
	 pJzEwVW5DbkX9Ic1IdJEml3ziCTeGrbMl4BQqz/BmuOS2qaI4Gx7FQmgf6uc3uX6rm
	 Xwsu/Z4EqkTPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Frank Li <Frank.Li@nxp.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] i2c: imx: separate atomic, dma and non-dma use case
Date: Mon, 27 Jul 2026 08:43:53 -0400
Message-ID: <20260727124354.171852-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072036-sanitizer-aloe-66ef@gregkh>
References: <2026072036-sanitizer-aloe-66ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

[ Upstream commit b460b15b3cc23ef3639cc51043bf8b2a70ca1878 ]

Separate the atomic, dma and non-dma use case as a preparation step for
moving the non-dma use case to the isr to avoid rescheduling while a
transfer is in progress.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: cb2fc3785769 ("i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-imx.c | 107 +++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 37 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 76d5b80abfc700..bcd3cb48902b54 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1012,6 +1012,43 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	return i2c_imx_acked(i2c_imx);
 }
 
+static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
+				struct i2c_msg *msgs, bool atomic,
+				bool use_dma)
+{
+	int result;
+	unsigned int temp = 0;
+
+	/* write slave address */
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
+	result = i2c_imx_trx_complete(i2c_imx, atomic);
+	if (result)
+		return result;
+	result = i2c_imx_acked(i2c_imx);
+	if (result)
+		return result;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
+
+	/* setup bus to read data */
+	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+	temp &= ~I2CR_MTX;
+
+	/*
+	 * Reset the I2CR_TXAK flag initially for SMBus block read since the
+	 * length is unknown
+	 */
+	if (msgs->len - 1)
+		temp &= ~I2CR_TXAK;
+	if (use_dma)
+		temp |= I2CR_DMAEN;
+
+	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
+
+	return 0;
+}
+
 static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 			struct i2c_msg *msgs, bool is_lastmsg)
 {
@@ -1022,6 +1059,11 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 	struct imx_i2c_dma *dma = i2c_imx->dma;
 	struct device *dev = &i2c_imx->adapter.dev;
 
+	result = i2c_imx_prepare_read(i2c_imx, msgs, false, true);
+	if (result)
+		return result;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
 
 	dma->chan_using = dma->chan_rx;
 	dma->dma_transfer_dir = DMA_DEV_TO_MEM;
@@ -1132,50 +1174,24 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 	return 0;
 }
 
+static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
+{
+	return i2c_imx_write(i2c_imx, msgs, true);
+}
+
 static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 			bool is_lastmsg, bool atomic)
 {
 	int i, result;
 	unsigned int temp;
 	int block_data = msgs->flags & I2C_M_RECV_LEN;
-	int use_dma = i2c_imx->dma && msgs->flags & I2C_M_DMA_SAFE &&
-		msgs->len >= DMA_THRESHOLD && !block_data;
 
-	dev_dbg(&i2c_imx->adapter.dev,
-		"<%s> write slave address: addr=0x%x\n",
-		__func__, i2c_8bit_addr_from_msg(msgs));
-
-	/* write slave address */
-	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
-	result = i2c_imx_trx_complete(i2c_imx, atomic);
+	result = i2c_imx_prepare_read(i2c_imx, msgs, atomic, false);
 	if (result)
 		return result;
-	result = i2c_imx_acked(i2c_imx);
-	if (result)
-		return result;
-
-	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
-
-	/* setup bus to read data */
-	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
-	temp &= ~I2CR_MTX;
-
-	/*
-	 * Reset the I2CR_TXAK flag initially for SMBus block read since the
-	 * length is unknown
-	 */
-	if ((msgs->len - 1) || block_data)
-		temp &= ~I2CR_TXAK;
-	if (use_dma)
-		temp |= I2CR_DMAEN;
-	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
 
-	if (use_dma)
-		return i2c_imx_dma_read(i2c_imx, msgs, is_lastmsg);
-
 	/* read data */
 	for (i = 0; i < msgs->len; i++) {
 		u8 len = 0;
@@ -1242,6 +1258,12 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 	return 0;
 }
 
+static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
+			       bool is_lastmsg)
+{
+	return i2c_imx_read(i2c_imx, msgs, is_lastmsg, true);
+}
+
 static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 			       struct i2c_msg *msgs, int num, bool atomic)
 {
@@ -1249,6 +1271,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 	int result;
 	bool is_lastmsg = false;
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
+	int use_dma = 0;
 
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx, atomic);
@@ -1301,15 +1324,25 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 			(temp & I2SR_SRW ? 1 : 0), (temp & I2SR_IIF ? 1 : 0),
 			(temp & I2SR_RXAK ? 1 : 0));
 #endif
+
+		use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
+			msgs[i].flags & I2C_M_DMA_SAFE;
 		if (msgs[i].flags & I2C_M_RD) {
-			result = i2c_imx_read(i2c_imx, &msgs[i], is_lastmsg, atomic);
+			int block_data = msgs->flags & I2C_M_RECV_LEN;
+
+			if (atomic)
+				result = i2c_imx_atomic_read(i2c_imx, &msgs[i], is_lastmsg);
+			else if (use_dma && !block_data)
+				result = i2c_imx_dma_read(i2c_imx, &msgs[i], is_lastmsg);
+			else
+				result = i2c_imx_read(i2c_imx, &msgs[i], is_lastmsg, false);
 		} else {
-			if (!atomic &&
-			    i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
-				msgs[i].flags & I2C_M_DMA_SAFE)
+			if (atomic)
+				result = i2c_imx_atomic_write(i2c_imx, &msgs[i]);
+			else if (use_dma)
 				result = i2c_imx_dma_write(i2c_imx, &msgs[i]);
 			else
-				result = i2c_imx_write(i2c_imx, &msgs[i], atomic);
+				result = i2c_imx_write(i2c_imx, &msgs[i], false);
 		}
 		if (result)
 			goto fail0;
-- 
2.53.0

