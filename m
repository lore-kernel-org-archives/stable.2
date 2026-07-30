Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857D3B27E9;
	Thu, 30 Jul 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427038; cv=none; b=kuRlPlijXXxdboiEwNUGXxC8eAt5xXdRGokrEt8nRVSoogpcYJLuvibUleYJcRpFudHPfmkdADetx6ALvCvYJxCQEn1Zt2hqUA8pqDGMYyBkuIOhEB3xFAmKj1OSbcuQAszkIOxaDDAkipiotAhovYkiSJ0xrPJIC5EBhDeqB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427038; c=relaxed/simple;
	bh=3y1DnBmrtgDO7iMocdK6w1mNgAXgZtGsBoQi6yTWRvQ=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=VdulTL1QO4m1dDEz/7CcxOwLJStxreNLfSys2KBA/izzms+Xr+HHMJ6TWcw8Tw86ojRJzL9R9omsPAdnBvdspkwtzXfHGwOIxUixIsGH+/waIiOuOto2DCFYUf7gBqwfbYtGEcKFLaxmVtcFWAKwMzwMxKONXe+Y4KW6ayHWD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cI4o5RjQ; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cI4o5RjQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785427030; bh=hSzfCjcKQBbYGMl/77NJGr8X/fP7WAcQkZ2m2AgNZks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cI4o5RjQunuf46fS6ijtHZUWA4bhJZNLR1OGeUfL0Yy7EjCQ+/8AXbxx51cLdYatN
	 fwJ3Kb+t2/PC/C29F07yDuKeevo7e1+WVtWuSlB2vDCS+NZfXdCPeOnVavXoa4nx3t
	 OxabJFmCOCT0F4yLrzMezZaI06AJ1i6EkpOFNz50=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id E4428204; Thu, 30 Jul 2026 23:57:04 +0800
X-QQ-mid: xmsmtpt1785427028t431mypjd
Message-ID: <tencent_BD7611A1FCC89A34685A64621292464E0209@qq.com>
X-QQ-XMAILINFO: MwVIzXK2McqoNPkGl4FuNWD2PSjZPdIPRrDECmTRpKe2Xy2ihWIc0Nmx7s+VKt
	 dBWy6JyPBBPT46JOMdW3bY555/J/efHyAJrv/gPVXQYbKr4ifqpfptXsywGRZ6x8045PlJLCvzrN
	 vaIHdHz+xchkBRGWr2Ex9vCNvW8WLFlXmJShFSvSEn/pAvF+HdZL38ep1TK2nA7hIG8GEGSlEUIZ
	 Iv7+ZT4BIa1QZBybx4pZH/FqjWjI/ml1ncFsWguKvoHK5zl54QmVRu2EXaA9DYicanJ1genBnM1s
	 6NDyM9FoyfWicopOuWBL+SXfkAQZ9AZEXcsTCkd2OXj3PgTgpj6wGZ9mAdp7mDqJNkPTO3I5LE4m
	 hJViWDoHH5qF6vfWOO5U5D+Kt70tGKk1UfC+oIbq+YVd4yVCHOWjH9I4NEgpKYsVlNVGPT2Reeu+
	 Dx+i59IudtmVGZenmdI3DzIRuYEEKyx7RkLleg5fFuOhpFH7UFb/Cioz9L6MAPnB1rhkudLuJ/Ia
	 Vuc1Z2KyQobOcS8EH152KasZxoYnI3XU1AtaaOewI9vo9Q/rAmqdGnSkzm07DK6MprIpdukdE9/0
	 rgjO66eRsrH6fSEGsLXF7ZGz8Ucs5rrZpo6qLy+DnWG5z2hXqBGMkdzHWMZC3eopfH1pwrsEj9+m
	 wcWZ5fKEXYubMH/GpZgP5BLhJHD7hMMiLoDLUIEV1mhVP7xR0m+AeiCcyIjdpeq4FlVUDbh5d9uA
	 KhdVebSMgTFcpXHvUyU3x9LkFGOOM2xo6+VEJ+TEvfC9qDh7ZrTdjlfohsoDfbWjefLcB0uAtEk0
	 PegG/CWTMfCBMZfCoura18l+BUVcu74roOY4/x0Act0CscpSqHagcR24C5rJqVWJwclV32RmEqIT
	 ihqnI2dyI1hQa7TiLPpsXX+xTLDluB0RCEzoBk/KzbBijF/MMIBItubkMpudOAr5hi9/menyWYZI
	 4BjRO9KChr9QBpNVppEd65VbxZFIM3NaEyxhBLqos+/W1e6p4CLGYfPE+MBYmwqRzxAHn7Sgh51G
	 LtTnF8DzrdgwvHrV2lT7A1oG4IGbldzVaorYqIPQ8oORqqa7Q/UD19ldNrdMZq8KPMiWuMTTmI8W
	 zrNjq9titmRQCLq7GN4LuTea71vr1MJ9IShZPWklNkRAUUodOyLCUDun+whp6sGWFnOoLBSELf0m
	 i/P9OsWbL+5P/vL7CTOlMlg5NYQpJQZQrnYWzxejUiLVU1wQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Cunhao Lu <1579567540@qq.com>
Date: Thu, 30 Jul 2026 23:50:42 +0800
Subject: [PATCH v4 2/3] can: rockchip_canfd: retry the outstanding TX
 buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260730-master-v4-2-07f7952f761d@qq.com>
References: <20260730-master-v4-0-07f7952f761d@qq.com>
In-Reply-To: <20260730-master-v4-0-07f7952f761d@qq.com>
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

