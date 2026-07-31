Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2791419314;
	Fri, 31 Jul 2026 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494377; cv=none; b=tMFbj0zXFngiORpNTlaLOYrJm9Wpbqm8q9PIdonIxl5EaweBik0MygMJSY10LXErdBSNvjtgA3xKK1OPOvfi8crUiIQJl2QKpYsnOZ1ld7gA/S8xdcgmrZ4TNS3uEEebzHTyvwiqwc/UDt2FM5Nzm8C2pATbuFQjGJXVFqRTTXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494377; c=relaxed/simple;
	bh=wg8x6u+4TzPcdTYNcVysFW+KUvgEmZz5uNkyXYhwe8Q=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=SuFMyZJfM5XbawNJoxINRDSE2lpVCaGr5/GARFPB+1CCto9MTHY4jIymbZQ9cH3hjKYtWzh74o70YKW1TlqHA7T0gdzyNPd+n/s7893rhBtYzeGOXLOPoqb/wb7P6qR7lrp7Dvc7NqbwwdsZpatBeRVsiVulkDyyivw3KrskzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eGUycrc/; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eGUycrc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785494356; bh=oBDU/YtjvhaZ72VaLs77dEfEt1kLZuVD3FCxqe1mOLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eGUycrc/aX1L/RY4O3zh5BxrLUqAlPv1730T51XbgU1Fl3XI+ZmK3OxAG6it6Ub9a
	 J1l0oANL8z18iy24S9ePUrX3hERW0xDgU0GKgEnIr9oRhi3rlyFjVlRRSpmDVApslY
	 8Dy7eTewacsS8pR8wqBU+ag04djS9+qFZjVeTT/k=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 9C92DE69; Fri, 31 Jul 2026 18:39:09 +0800
X-QQ-mid: xmsmtpt1785494353t27rq4q8b
Message-ID: <tencent_2CCE005FC440BF8026599A6999EC04BE1107@qq.com>
X-QQ-XMAILINFO: MVuDTlnnQDnqiN+DIdj/H5VA6Hiln6C8xQjKq1d/daSxtzSNLORWBWrP09X4FS
	 uv4Gz/d+BtLR93RIIThQEYgZ2rc7TqMz5M/gXYygOYA1vLLRavOFhEAXjvzUsSnbheh0ELnlVCdL
	 /5PzUA4+zL8+Jy+ESCP4mU6KpVvO3uIxM3gnWsi1kNUt/DOcTFjFoJGTe3BgfF9CFtmiBA0350gT
	 5vzYMwUMDzM+if/6AatR6ZvZCpVyUx0WIxFCmk0Fwu0O70O9ZGE00b8FcbSoInumd4nIxtELFJYi
	 h1knfXYbZtISKdRUMcgTjiAq2MT5vAJo6V6knvxKd3czKJzWQCVAt9NPUZiTInw9T0t80a/x60Bp
	 qI/e/LXjGDvQRi3jgV7xMO/LK1w9idsglNViUNc6icxpXts5PGW0xbOIFP5FD02O4aTCDafUL6D0
	 oqw/a3yR+Ecbwyldp/S7LH5KhN/xG9O7WY725TyiO55R5h0MXqeBV1SZVcOoPEHm+/L/6Gv4kqrL
	 e4bZEyDD+r0f+Bz6BgLPJM18eod0Lo8HkR6JPkadsQDlcjBDOOdO+6u5vO1HmnNP4LwzFkINUKMi
	 mf6z2rG56Qc5P53yshhZazYho/NifSF5mEkScaM9oXx9cTVWD3xtLmrtdeLjuAZvTYJqUk5UXWJX
	 nmGyidchDlmTUeMDdVawrNQe2JAd2myWDQdXKEeH852fNYNKf0W43ycMIji71UZJtEM0dLLhhPtN
	 18o3Yv12xS6lH9+SdriUZHwNUftfZoo7G0pA3XXRGNYqadXeAH6IvUmdGcAX1Z/0nktjaFb2vsLW
	 bwpBPGjXzFvxBt6NFVaXaky4flgAsiUWwZxmiCu3SjHxWDMr5wyGv9TkSnCc4EaXOBAgTZR60eGW
	 wQ19XEyvlFMYbfV/ha9t2oqiw1gD7SmG+d7BRLFYcCT8qQ7mqdBD411H7yAi/r2xOJaeAjRcKM92
	 wtoJUAvF8MsxugoKLcNX44ANcgqLido3ch2Es5V+ZqFnyvefBFtULEEIkgLfsbgRYefrtpFy2amq
	 Q+LJ2slFkZCNzNRZVkpc2slDZDzNxYgc6QwepAgBAVJV3KPoZsade1mfaMXS2tnS/Zdu2RkQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 31 Jul 2026 18:39:04 +0800
Subject: [PATCH v5 2/3] can: rockchip_canfd: retry the outstanding TX
 buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260731-master-v5-2-5b27029dee20@qq.com>
References: <20260731-master-v5-0-5b27029dee20@qq.com>
In-Reply-To: <20260731-master-v5-0-5b27029dee20@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org
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
index 86fa8f2e1c8b..fc338ea865fe 100644
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

