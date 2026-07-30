Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127C43C04B;
	Thu, 30 Jul 2026 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419338; cv=none; b=j7r/IIrs1thGkBl4DdGBWsacLM3liKKhTNPqkRsp4KQi5r5bK9kwYjU1v91ohHN5J99i24bYzkp1UosLHTf+KI9NT5I6K6afoO33Aj10AzNAlaP7im/GjKCpU5kLH9alg5HD/NaOoGy4OCHfpnCEO+H0GkNENC5bZknytyioq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419338; c=relaxed/simple;
	bh=3y1DnBmrtgDO7iMocdK6w1mNgAXgZtGsBoQi6yTWRvQ=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=WmsIpIF7FzqXB1VO1885Sf57Jni4bE5M6oeqINFcH2eZK85mGxe8xJZpA9cIK2Y+A/kJs4ruAtHMSviozF2GtxKiGnXhDCHzESa0xarL0eJG/4qCdpDu+TGRjYM7K8CUGCWEPNj9X9pXE/5EaETLcATqbtLYqfgi5MivRQued9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rbp0N0iq; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rbp0N0iq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785419327; bh=hSzfCjcKQBbYGMl/77NJGr8X/fP7WAcQkZ2m2AgNZks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=rbp0N0iqC1nGruFAj7g1GYeCvY0l2MEg6WJ97hCqeu6u9YY8Tbv6RRPesqcXn9dbR
	 vXrE4E9C8OEcGLZIjeyciNi+VVF/uZMlxH+apgU/FRnIzVyil41WCZWqO5TwVFMQ8l
	 pGAo2fusJR+WSN2RUP3to5jx/qDdm3Zsau4kbWI0=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id C291AE95; Thu, 30 Jul 2026 21:48:41 +0800
X-QQ-mid: xmsmtpt1785419324t8zgq7sl9
Message-ID: <tencent_A7CBE824C48D68057C23BAF8E1355DD0BC0A@qq.com>
X-QQ-XMAILINFO: NQQUvflVuqBO4/3RjWmvbSZKNti16VzVsLzOSGSV+YgKEdsKDUG33QXv2iqv5a
	 G5VL0jBmGu4H9VJZ/iVeKyoJxVSJaSD87TzaZvxrOm2VvHowcPhkup4L+ezUdTv3JnO6zHGUVwSr
	 PJjrBn2J+CBShzLqdBcOwfhYmAC+38VX9pq/FgCt+kf39hJqT+1BWCf+0PrtisCvtn6tGYJSu7JN
	 aIaVankjutTTY7bcGRFQZiD53GlUq8QsBYm/FRHhC9shymJijNtESzh5Gqj9k5jpybsrdvjOYtxg
	 J4VH2CX2s0Lke+NmKTt6SsRk/WV1HLx+jBiHxLhMeekj+PBdh4BBWRbv4QwPqlL/K0zAH0qKLQ9Z
	 fdqiK2w1lmErK+j0h/wprXET+gKw7/fcJuANnyGSs1t1O5y7EGCLp+oqC7GlGspMWZdNAPnRFkqS
	 zEI49HY/PfpdibSrfivP8Nwm7Mp8EiIN9O19cKukakpBzXhloYSWyjY581Bns3SM8JKvqEGbl9bt
	 q+kkE5MfX90LZ2uAsMVinlXmCp8gm4DNhbvDciVOGHTeP4CFibcY33vRLtJQbkTujSMWDhe4x5ZD
	 BrBKA+oqOuNnzmIgufeJT2LWsBVgTQAvBqwMu2a9LMRy3Tb7XNrTSdLbPnXqzfn7ZD0nMwtHP/Py
	 SEV4KXANEZg4vbPLgH4jOwNNlerKUtbzJ8OXuy09XAb5wILyi4UQDAk0Jmq4EFT8gcyMVy+ja2WN
	 rKteHTQ5f0SY+/dKj7vBz0Ut1JOzTNWc7z/ycfKg0y0fluOeUHAv3BwRcObz6OhEa0P94s9+ecjw
	 RZ+TkOO6mpfUcxnNnnvpbYWOkI6XfovGVC+oYdz6yYGC7y6nOBu+Q7rPfvhBu9flPwqOaFknJYYe
	 2MNx2j8Dm0N9Xi7oRIJCdhmj58/ED4A6C1fbYzXRka6wz+R7BefRHQvG5uVuQw2OCLHi22Q5h29A
	 q0z+NVN37vNOc4WIio/Lzt47T1dYZBzMX53Nz4vlgdqrNOJ7VZE8QjpFQFDCUNhQlNaD0NusNwNE
	 6oRw2GXOGHfW1X6RH7RhqB0OIOLkc5ERbIZnLvccUCX+GwpyOiQS86XunUJu1BgM6yyTJhg7B402
	 cMxwhXCAoQyQsBsIsGmXyJzwjvXGm+F4ELnpxXj4LE5gkHCn8w9KFXphyM2ps2IKFhNoS0cNKHm8
	 U9HvPpS4jBU15ZT2AGmEsGFHVs5QYbgipNEsg=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Cunhao Lu <1579567540@qq.com>
Date: Thu, 30 Jul 2026 21:48:39 +0800
Subject: [PATCH v3 2/3] can: rockchip_canfd: retry the outstanding TX
 buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260730-master-v3-2-91cf030c337d@qq.com>
References: <20260730-master-v3-0-91cf030c337d@qq.com>
In-Reply-To: <20260730-master-v3-0-91cf030c337d@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
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
index b1954b72560c..2b5cd6aab31b 100644
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

