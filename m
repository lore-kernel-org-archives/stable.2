Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FD433BB9
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560022; cv=none; b=ortWEgs2igQUFugmWmZDu/2eG9GGQ8Pc3S4XswZih8Mgz3WI8/e+K2yFHb3NUGp521hVZAvsQIvQV8gC1R1ODcH3HGdUT4i1Bnf9FjN2IfJL40VZLPzqCSA4KRgZUK9itDlPTYCxT3nXr24R4ZzbePB0Ylv8iay93TYQm6j515M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560022; c=relaxed/simple;
	bh=BMq5jFZOtvc7/B99+0z7sz8ldPBISccTanzGeE9ZweI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OWQuVScYT+IPJ/8SAifgY/23KltS4cejaBKEYMqaiF/wLXnPuKgMle2R73euyfANynYd1iLEw7THkAZs95E0pPkm9xikmZiG6VaThWvFM/8tLYEQ/2MBMuat3W4LR+LhWPqz0PX7DTA/AAnCOcXP7w/wKAcnc4mVWsocB0zzsWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YFB1GcHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YFB1GcHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7B71F000E9;
	Mon, 20 Jul 2026 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560021;
	bh=3Uq5lBLrSVckEDmW/djDtOYdkficudthBQiwZWANdns=;
	h=Subject:To:Cc:From:Date;
	b=YFB1GcHuKCzKDdZdHgJt92S3G76sJ+lwkX+R+75/Hd25/1zX5JtBLAscc9Cw6CeGB
	 EzGVDUGu3ki1hTVoA/I/lipCNdJGR1FkyIvZiE+OHdsFU4gKFAk23B7RC5Z1HS6zPc
	 /kJ0fQe2tZskg0B6rSg0QKyorWejm33rl+gnu/7k=
Subject: FAILED: patch "[PATCH] i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)" failed to apply to 5.10-stable tree
To: vjardin@free.fr,andi.shyti@kernel.org,carlos.song@nxp.com,eichest@gmail.com,o.rempel@pengutronix.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:06:37 +0200
Message-ID: <2026072037-gentleman-dwelled-cdd7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cb2fc37857693b55909fb77dc2c87cfbc1cdc476
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072037-gentleman-dwelled-cdd7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb2fc37857693b55909fb77dc2c87cfbc1cdc476 Mon Sep 17 00:00:00 2001
From: Vincent Jardin <vjardin@free.fr>
Date: Mon, 13 Jul 2026 20:11:59 +0200
Subject: [PATCH] i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)

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

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 28313d0fad37..cfd1e63359e7 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1415,6 +1415,7 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
 	int i, result;
 	unsigned int temp;
 	int block_data = msgs->flags & I2C_M_RECV_LEN;
+	int block_err = 0;
 
 	result = i2c_imx_prepare_read(i2c_imx, msgs, false);
 	if (result)
@@ -1436,8 +1437,20 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
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
@@ -1485,7 +1498,7 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
 			"<%s> read byte: B%d=0x%X\n",
 			__func__, i, msgs->buf[i]);
 	}
-	return 0;
+	return block_err;
 }
 
 static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,

