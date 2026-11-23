Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459342;
	b=desDUDM5Cz7HdANFL3+LSHKIN8JjU42lFBKjKYWXbeurH1Wu8KIn/gi6IOBAw4tfbui+
	 gkGYHK+JvkYt66VsDNrZvh9IQzMbAayf2DxQ2ELAHAno5CH6OLle6VS/CIg87XDO99B+w
	 tR4JZKMceEDv0f5NeRAjArIu34flhMmKoq3Yf9RKtkPhLD+yClYOsm0ORadNmCX0HTb8K
	 Acav+hpPo08NH1DNMi1P0qiOf7jjpnq2A9qjhVG/6WRB8h0X43frWKHhtGk7iakxRIXPh
	 YfPyjqDwSaViQKcvYT9W8NDF9ob9n+Trl+NzjiIZ/mj2W+hqAw6LaRZOFrchShtVLsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459342;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Sj1QgnUCcj67Wu9CL/Rk6ZEmkka+I0rDPwZuBpcCNdg=;
	b=x1q/qC0CHi1zEJJb5vjqEeqF2du6+c0SwZaFZkkwWWobl17A0mjF/ocKXix2f6DoZb6Q
	 HTm0R8lQ63YDsA5rZdeRdXeO7WQ/SJOrb3YICx0mVSkQWeB123fu6LQAUXRTGiCLZpOWz
	 aDCWR8UNb4L7ZPF9227m2k6U2vfpyq/exnDuH8bBioH4AbUUaoHuhuonV83K6nTMyVeAb
	 SFKJBD2LJ3C9jidjmJMviEcMeNUXz9CkU3ZTgA3ji2ZmIXK1I8NVT/FqMSLahmO4doycY
	 7PvS9rLpnIAEQwTxvBG3LnSdNYN+hVN/6X+wTZY2VTVifScaGsGsO+90wO4KdNjtT7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=We4KrTBt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2986606A6AE;
	Mon, 23 Nov 2026 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=We4KrTBt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459341;
	b=3bMLqSSks6qTrILDZ5eTP3aL1auiW1fcZPtsx5xW/Gv9TYSqkpw7QGO4STNn4M/GXPnj
	 CK0z+LnpOMAiZ9spKlqheTmNkH/MfU3F83byNzcLropywnvoz7siYYoLjQWRqjzdu6X/M
	 8XFXT1cM4VjzsOcm5X/IYZ7De9iDPaAjhuh9slqrbjrWHrdvk2hT6Q2B8wG2iNyc+sMUh
	 EnWjAbyKRfVfao/dzTNNIUVxL+/m5+ij5aYRfkYH88UwfTbeuNRm7KOmuS5yXfm7YzEq3
	 vZWb41QWKrCFqNRDbD/uyOxH+ToPsQ6SzWvHmP7/Z8Dls2lqe9mmACo0n25isF7YUXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459341;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Sj1QgnUCcj67Wu9CL/Rk6ZEmkka+I0rDPwZuBpcCNdg=;
	b=OlxE1oHQfyGmDnkDLlp3R6rOCqx/s9wpI8RN939rSb+9wAT7ybm+29t0HSMRECE1v2X2
	 jJ/l/U0VLD2E/WftteNfljA9/CI2hnAEKtQ5Z9bGb1iD/T8A/OSjdsutcZFuekUbphItv
	 cIZRXe2LU723hTUHqC4iv3dRbeU8Foo1vHdYOINvneU1TBCdYpXJ+6wojD0VyGLeRl44W
	 nZur0Mf4qHCPmYWjLyRVDpK44drxii9c80hU/3nIjJHTSBfbypZAoiaK7NUPzG6x2i059
	 gi83VRGSfgImkW6WlMGhcmt5asxa8BAirzlrR7vAhdGZQe/YTlWZCTcjib0mAAXjR2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D3F191F000E6;
	Mon, 23 Nov 2026 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459340;
	bh=Sj1QgnUCcj67Wu9CL/Rk6ZEmkka+I0rDPwZuBpcCNdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=We4KrTBtNPfLe7ix9ckReVLOB5ASEIsa5r0A8qLmhJFA2YfsfCmePnHv/c6NybNG+
	 +QZ9V7Lt3tPW0Xe6N5t/MVwTE9uH8omHf9Q9zLHjLTPDpJtajE+rYMbPHRQPbY6hju
	 l+cZieG1tNDcq1gGrUssT+o1Wk/X390/fA4QDlRWSMnH9zDmjeNEdGrlSu0hb4pZ1T
	 UUqL7EgFbjjqW6/DcknZRgT91LHkrcPLYy/nUyzpu1O8wpd0SoQ68Luuo6voQllu6d
	 jiNcJpfwT4/200bKIkVozYfrH4Fpa91vX/V1rsuqoLRnZv94RHTmd5OHhGGrLXHCyc
	 Y6pY0yMINjIMg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BABE94C603;
	Mon, 23 Nov 2026 18:41:45 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:41:46 +0300
Subject: [PATCH 2/2] Input: sx8654 - check SX8650 status read errors
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
Message-Id: <20261123-b4-sx8650-fixes-v1-2-b82a881b971d@gmail.com>
References: <20261123-b4-sx8650-fixes-v1-0-b82a881b971d@gmail.com>
In-Reply-To: <20261123-b4-sx8650-fixes-v1-0-b82a881b971d@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459304; l=1341;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=j7j0QABqTYkyAI99G3MkmYNFWGfU+BRfuwxQGR7FYUQ=;
 b=hULECcoojitZP+pdrqNygybaX6ioV4cxlzfhmHcoFE2ypGfqmkKU23TUc6GA3WWApdVcX4F5r
 0tyqMowE55xD4j+hCYp50w3NPquNMPFb1GJUq4iGkAlkFNMBU9GXydX
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Keep the signed return value of i2c_smbus_read_byte_data and reject
errors before testing CONVIRQ. Truncating an errno to u8 can set the
conversion-pending bit; for example, -EIO becomes 0xfb and causes a
channel read and potentially a touch report after the failed status
read.

Fixes: 43df039c6d92 ("Input: sx8654 - add sx8650 support")

Cc: stable@vger.kernel.org

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 drivers/input/touchscreen/sx8654.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 13dd80a8e..1ae00cc2a 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -130,8 +130,7 @@ static irqreturn_t sx8650_irq(int irq, void *handle)
 {
 	struct sx8654 *ts = handle;
 	struct device *dev = &ts->client->dev;
-	int len, i;
-	u8 stat;
+	int len, i, stat;
 	u16 x, y;
 	u16 ch;
 	u16 chdata;
@@ -142,6 +141,9 @@ static irqreturn_t sx8650_irq(int irq, void *handle)
 	stat = i2c_smbus_read_byte_data(ts->client, CMD_READ_REGISTER
 						    | I2C_REG_SX8650_STAT);
 
+	if (stat < 0)
+		return IRQ_HANDLED;
+
 	if (!(stat & SX8650_STAT_CONVIRQ)) {
 		dev_dbg(dev, "%s ignore stat [0x%02x]", __func__, stat);
 		return IRQ_HANDLED;

-- 
2.53.0


