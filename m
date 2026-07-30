Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6538DC76;
	Thu, 30 Jul 2026 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391988; cv=none; b=UTPZ8XP8nCbp0nRXdexdDc0en8fF6I+U8PpXwJdl62+XFP5s3/6mgeAddWI6K56aWZqKqZOzUgjHyIujGKFb32Jh15gCy8WxI8MnYpW7wfbVPdod1ng8kpWhiG1UEy9q2c4CJmOUbaD5sFB5jOpmWGJsc/L3kzW4yttqtnDgmpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391988; c=relaxed/simple;
	bh=OmKGLVNvEcZHDkluQvI4KGqoZ4VlCJxQjkJk7XZMML8=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=BS7bipx29DqAgmUhiLjT78NNuckC1hpa1OK/2+4Zt+ZH3p8xLFJxmEyGZuzaaZLokz5xiOPnQ/Ff7WWVLXocZ8UJCN+0X1E2USOYgNnTwgrCxQx4+gaUYoJa5dj5H3aoSvCsTuqI1YaWdMPKw79k9JCFVCqiKF7X7Qi9j/r86ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jksZmVoG; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jksZmVoG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785391967; bh=D2dZ+8WBmAZ8INSWYao28PUGk/5wdatznsr8FR9QCUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jksZmVoG3OJN5iUib0pX7eLOiKs9KiN3gViwDVzyfmIvj8ZEYdRHwlS1ceQUaOkbX
	 IdevTWQYvJBOWqifPRcEjeLivj8f43smcTXN0elRKfRYpE4QsaooEH8amQmS9AWwqK
	 yvUBOqlF+cBJ9/Sd3BaZqaWGWjtrqkzcXCG2k60U=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 2DF15055; Thu, 30 Jul 2026 14:11:31 +0800
X-QQ-mid: xmsmtpt1785391894txg4lng26
Message-ID: <tencent_803FA8A6621A5D198504BC91BE003D442007@qq.com>
X-QQ-XMAILINFO: MfvJ0+4D3P+7xxzKzQ3k6L2jiKfqNsu/rtn1/30H+OnK0sm6vWNyfEuix9tTXR
	 vdvX5JQOTiSZsPBn0IL25auocfZKs+yeVyeRWfBGthdHk+aQEogSsCHGnfyX9Zze+14qEfsUYm5U
	 of5zbvG9Jg3JdYKCDecqLUqq9h/IFi3UbTHwWSBwK9pAIYOhlrxQ+IFOMQqsAwi8Zj+yBzEKbyJg
	 P1LgpNgdeKraeK60uM+GDM+Bj2utZxTxQCulN8teSZdU+srXK3pIcd5hAkEUe2+HcGrM+mXl6vVX
	 ReicJnrs7Qw9VC8nafSr3DJAW2V5bxiAZubsvThIjvia/WEOqDquNHz+JkiMuzo9ZBXtjCFlN9Ph
	 cneUd1eFR7wdjHiu9nB+kLYTkzzNMIUv1vNbqUIeUiTY5vFKn0GvzAAXeucE9VkwC2lqdzZ7rp7F
	 YdQ9CGb+6bqOKkZGf8QOA04pljHragFK9F0ANFCUc0YB5MLcBjguYrR6Y9qPY/X1SpgLUqq9P9Xy
	 46L2fF/4/V+aO5wkJfM3z7fMPT3Xv4G1jpAuOnrEb9FQ5KtGqEL25QoGzKHMbAMrxMzyvwXEoFea
	 h8FwxUX8P0C3mBsv6LMs1C3JBTALowTNQ1eEMGQo1weT1oqQfa2z9jQ2uEMQfWQ23BGyKvhkeGZF
	 UlPKwj6XcBA5pdgWnBg+08eMV0N2sakdFI/t4EKeIslxtD5417h2TqpbMGjJvLxImURrKxJFT74X
	 uAeB6NSqnkc4E2IFnMwL7hd7vnraS333NfRv03PUrbmI/UqPwcvBNbrfQQX4sprWweBGTBOY3SSV
	 crvgw61RrNRt8IIv+kuL/FjSBLc88KqDE/2AVVjzUFWHUKj6TUyxAUqL1btEKa1OqVcWPRVtmSwZ
	 EkwBRrwI0fqpcSXkKiobIkP/PI2ojpFgq4pDHygcVmvmgEdSEBcsGmEX9Zj6BWv1L6x/OPFub75E
	 f8ujPMF9CzOEObkaRoqS0sni/fkGtoR1K9q3JwksDgZ33GaEr2/u9PYGZbjZbUq8HRwmy+Ap8KA3
	 ox/n8047qhiaw1eDZDV2XWK1kgSR+6+xZNQhY4WZ7kwLgy9M3DU2vpGJEElgoQqIZfHA5kWkpXEo
	 nnpyr9UjA3e3VxCwQEQu4x6+9PQxGsLIlM0xURZBXohJipm7QyTI/Z/lrEWTsEhAlIAtEqjymXPs
	 USv4E=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Cunhao Lu <1579567540@qq.com>
Date: Thu, 30 Jul 2026 14:11:23 +0800
Subject: [PATCH 2/3] can: rockchip_canfd: retry the outstanding TX buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260730-master-v1-2-6945fdd4f0ff@qq.com>
References: <20260730-master-v1-0-6945fdd4f0ff@qq.com>
In-Reply-To: <20260730-master-v1-0-6945fdd4f0ff@qq.com>
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

