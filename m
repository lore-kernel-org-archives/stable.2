Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53037E5DA
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156797; cv=none; b=rAY9F+HrAdTRCQXil3JWxpcSjezpLHiuaLQ9R3ji5VLPLbFRuTS3xIiuSnklj46B7+kIFX8ZvOHIRMmtNLctI3s+B/1bWHqnO2AOGwsRB4Spd72Huhkpcyeu7wcqYY/ujdupDEVtUFPUwpNn+oq0iAiUQEihDndh0TARfG6BevU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156797; c=relaxed/simple;
	bh=P8to1nxLvgq/fwcKyUaRAJ0+6MiVvbBTbdcIwny9Muo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wsfwd26PM3/hd1kYGxbOpKKGiVy/2dYFfy+TsTynXfYe7BqyOW2LfKjQVROEWl7vUUoiC3+VBCGYzEJWfeJF/EFQUNCi7TJS4Y4ePlGZMpbyVnIlpXX7zTcTgqljMBGf/llW52UBvs+mszf4EJ1pQi1bS/uPN9OJVdCKSu+56FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqMtkiC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqMtkiC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F40E1F000E9;
	Mon, 27 Jul 2026 12:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785156795;
	bh=Swq6VJ8Ezzh4Dehw562z7BfQRYlvqxoLWZ6JxdSsRHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AqMtkiC1vLe8a2lXqpSEVgFZr/WE0N/sETadPB1ccnd3heylBejFByhGipTM6Yqyj
	 2aw0n0RIkr1n4tFw4gnOLErMlZSdxN7J3kKOpHP2knaORqnpltpVXWtN4cO6kOuB+D
	 HlM6kCgzpDkziIxy7XYMFD07gz+n74TiIw9x0FKvr2cqRXUYi0BxNaXgO4OFZPIgTq
	 6Kb9+39E5wkTmpinNlLAyaNKctHKh8O/XpIkqIKy9NIXbfW4sQBkSefDu2dDZdDtS/
	 WL0+OLwUbnwyrpf9UahgW4X5ZzLzd82Rhrh8Geb++GVVKKlM7MtqwKO/nI7GCWWwoM
	 Pd9PQb4b6+Nzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Jardin <vjardin@free.fr>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Carlos Song <carlos.song@nxp.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
Date: Mon, 27 Jul 2026 08:53:12 -0400
Message-ID: <20260727125312.224068-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727125312.224068-1-sashal@kernel.org>
References: <2026072036-vexingly-staff-77b3@gregkh>
 <20260727125312.224068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Jardin <vjardin@free.fr>

[ Upstream commit cb2fc37857693b55909fb77dc2c87cfbc1cdc476 ]

SMBus 3.1 6.5.7 allows a Block Read byte count of 0, but the atomic
(polling) path rejects it as -EPROTO. Worse, it returns without a
NACK+STOP: the next receive cycle has already started, so the target
keeps holding SDA and the bus stays stuck until a power cycle for
this i2c controller.

Reading I2DR to obtain the count likewise arms the next byte on the
count > I2C_SMBUS_BLOCK_MAX path, which also returned -EPROTO directly
and left the bus held.

Handle both: NACK the in-flight dummy byte (TXAK) and extend msgs->len so
the existing last-byte handling emits STOP; the dummy byte is discarded.
A count of 0 is a valid empty block read; a count above
I2C_SMBUS_BLOCK_MAX is still reported as -EPROTO, but only after the bus
has been released.

The interrupt-driven path has the same flaw from a later commit and is
fixed separately, as it carries a different Fixes: tag and stable range.

Fixes: 8e8782c71595 ("i2c: imx: add SMBus block read support")
Signed-off-by: Vincent Jardin <vjardin@free.fr>
Cc: <stable@vger.kernel.org> # v3.16+
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260713-for-upstream-i2c-lx2160-fix-v1-v3-1-073ac9e103a5@free.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-imx.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d5009272524041..db060b9f3af0b9 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1151,6 +1151,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 	int i, result;
 	unsigned int temp;
 	int block_data = msgs->flags & I2C_M_RECV_LEN;
+	int block_err = 0;
 
 	result = i2c_imx_prepare_read(i2c_imx, msgs, atomic, false);
 	if (result)
@@ -1172,8 +1173,20 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 		 */
 		if ((!i) && block_data) {
 			len = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
-			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX))
-				return -EPROTO;
+			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX)) {
+				/*
+				 * SMBus 3.1 6.5.7: support count byte of 0.
+				 * I2C_SMBUS_BLOCK_MAX case should not hold the SDA either.
+				 */
+				if (len > I2C_SMBUS_BLOCK_MAX)
+					block_err = -EPROTO;
+				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+				temp |= I2CR_TXAK;
+				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+				msgs->buf[0] = 0;
+				msgs->len = 2;
+				continue;
+			}
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> read length: 0x%X\n",
 				__func__, len);
@@ -1221,7 +1234,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 			"<%s> read byte: B%d=0x%X\n",
 			__func__, i, msgs->buf[i]);
 	}
-	return 0;
+	return block_err;
 }
 
 static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
-- 
2.53.0

