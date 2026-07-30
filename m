Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35966400991;
	Thu, 30 Jul 2026 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406335; cv=none; b=QgNlUIu1wVLkR3oXZQ22FKjKc64xS5r5NHGLXflD8guFg2R/+qaNQlOrf/1wPJV6D0GcMx4ODIIpcWMbAqxGpYbQrkrHOD5p4EiN01udO4lj12Phc1E0AIKbYF3uel7fg2o/PIeGWPH78V0ydz2IQz3drZeSQypW0tzjRRDtI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406335; c=relaxed/simple;
	bh=OmKGLVNvEcZHDkluQvI4KGqoZ4VlCJxQjkJk7XZMML8=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=sfFNP42F1N1UuSzxpro+E4jVqpbl2x2bVeWXeKxien9ezOHfIlUS//Qjh38m6zFBZf8cjNkp470PnmA0qRwvG/rPfoCxwYOxFIKufzU5bJCfxw+Pzlq/NQbT88lnpQi9Vwcn4cBV/VMj8/2a34vg/DjrHQF7ltQYvECyvL4s94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PfcNDdN9; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PfcNDdN9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785406322; bh=D2dZ+8WBmAZ8INSWYao28PUGk/5wdatznsr8FR9QCUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PfcNDdN9HEpo54iDmx6ymE93zvw8L3alx0QviOULa1Yr7JFS+bMGWHIwr8OboLc4X
	 SBGvMZqTaKdg91H8D0KqBibH/hj4JdRE/k9xQhJINTwFlC5AodpdUc4zFYr1G5m8db
	 Ipnep7ILC1rP/kUCUnl6uo2X1kiNw3lyk7p2hios=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 2F88CE83; Thu, 30 Jul 2026 18:11:56 +0800
X-QQ-mid: xmsmtpt1785406320t0nla270x
Message-ID: <tencent_9A8D6405DC23EAFB7D35E9D09CC93424F00A@qq.com>
X-QQ-XMAILINFO: MlFiathi08wuL68g05Bew/1Dsk+TXee8hoXreVEpw925Y6t6CkfIWqATAdoekT
	 pDeBn16t36o3t5J9AKGVLtGUqgmuLcOnF+NPfjMFxDZ/5CuhyCgmqy6khAG8ufn26+U+o5z6dzyk
	 up3JJu2lhu7//eeeULr0/dJiLkaeXVikhDfA1UMSWZ+ahTLRIxWUaaADtY+NIgv6YiclomW3bZsV
	 hmuAll0OR3tjeh7OeDZh/sHDlgLXOK1eYedoO3l6j7t+KmqJyPOcNQ/9scB5M6qC0Z5ZPhVn02da
	 EBL18c5hNt5B8CCW02wwqUBqVTNFyJ5qFIjGqKfY5I0NvuPpAwISe0ZlQvnKQr3wOK/B/+2NRkqo
	 zYugjjoX3UmciA1QqgNxmMiDL/WO9/k9P+KY3Lbu42RalMlEeRYSMD+awZK2+Yf/vJ91NXaBYO8G
	 EnwyUmUEMjZCCy00oiKXfL4Nxpb7vSgm0LTVlEBYnibSzVhsjNbGKtL/S8+Jx4ZnI3J7oHDa0bRX
	 0Mo++nAtQnwD+w22XHTc8rSJ4PqpoCcZ9HeGFKp7BQ+62WxqDKq3bU3/qCyT2vxLaAvxzUE++6GZ
	 WwgXaLKOCiCN6qr5D5WZWdnbJkGLEq9nGsVF0GF5SlktIBCRVq4RBP9Z1hFk+m3BTc3ItXplfyqh
	 NQefx7ZCH3L/3/84pGrPpvNykPBKNlRYcIRQEcGpB6yGt8d4fKOXQSt6jaeF6RDHYEvu28GxR4Ty
	 R2CexNvvma9RJq29Gf++YDd3UfwHuefsth3+2Mytw+zK+HMKUpPpCZinjMN0Jju3DEO9bPLoF5Nk
	 imBTv+iNt+l8zvgZ1SFzD5PhtD5xD16FigNrLfPK4SoFsDh13t0N9PrivF4A+KZstLNzmkwYIRMo
	 TJUXRxtd+kFYyStUSURXvACaRhGx5DJ0tS006Vs4cWxQVz9Y2qUKW0vk6SbEzgITyUVpWtEqyVkF
	 wcbSfudAtQlHhprMq9YcIVfHJj3tc18aVVOznMY363E7It/tm/2dIKjEap0c5S/pqjbLA+X8wPjk
	 hRofN9vjUjcnO7CuQYYOXaevw9B/Jtc46uocCMfrYKOsCesrnO/O7AiTX/BU+XfULnWnyWGsDofh
	 xcyIJCS0lft1Tpq0n9deyGG82KmZpnaOPC98MFP7rsJfO1mhxuYKwg025srJOBieuJH8z+cFNPiV
	 kEQvbGm0JT5At9sb770idtWcyHJ8mWTRuw2kmeaTHaNK0Q4w==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Cunhao Lu <1579567540@qq.com>
Date: Thu, 30 Jul 2026 18:11:47 +0800
Subject: [PATCH v2 2/3] can: rockchip_canfd: retry the outstanding TX
 buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260730-master-v2-2-572974052400@qq.com>
References: <20260730-master-v2-0-572974052400@qq.com>
In-Reply-To: <20260730-master-v2-0-572974052400@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

rkcanfd_xmit_retry() originally operated with a TX FIFO depth of one. At
that depth, the masked head and tail indices both select buffer 0, so using
tx_head happened to select the correct buffer.

After the FIFO depth was increased to two, tx_head instead identifies the
next free buffer when one frame is outstanding. The erratum 6 workaround
therefore requests transmission from the wrong buffer, leaving the
outstanding echo entry incomplete and the netdev TX queue stopped.

Use tx_tail to select the outstanding buffer for retransmission.

Fixes: a5605d61c7dd ("can: rockchip_canfd: enable full TX-FIFO depth of 2")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index d2cbe25c46d6..c4ecdc9411cc 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -57,8 +57,8 @@ static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
 
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
 {
-	const unsigned int tx_head = rkcanfd_get_tx_head(priv);
-	const u32 reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
+	const unsigned int tx_tail = rkcanfd_get_tx_tail(priv);
+	const u32 reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_tail);
 
 	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
 }

-- 
2.34.1

