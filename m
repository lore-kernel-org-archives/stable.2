Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794137682;
	b=V5EieBHukdttAvnipqP9gI50PN9i1TKApWjAwPU+ELNmyh2y4MP3naYDV71vekNS/cLy
	 OJ3kqFLSSDWXcqSAhfnqm+DhXBjfgmyL1wjBI6I20mn8i197su3WqlTatk32cTeBRcIz9
	 94fIMhBH3F6+HbyE1s2l6KW+FCrj2d0PFuYVzeViTRRvRfV92RqKwquFrb4h1w7s5Hf4X
	 rOI5NZjiIpMFeXF4vadxh7A4EFbRauwfrzhv+S0vfrS4YDxxd6lU6eCu9wF1IQqqNzyrf
	 Y/f6mSmriQcT25bEzA+wBNLCfZahVocMOR2QT46SNTW7R1Tnz5+9JBgHq1aAq3rlc9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137682;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=irh7FtabIZf9G5NtC74mI7+F4qF39JvEMv9fHyqNNSU=;
	b=Y1BqCg6FQT1AjtUzsLTaBZc+kZ81QLlrLa48MgGSidla6V8uYGPVruTSpDiXB/8QnadY
	 hf+pVHBL3RTLqB2zk3MKDNyHtw7zQepY5xURKNOYXTPd8KCawJJClnWvQp3X/B3cksyq/
	 KD6pS3DtS8YDzM5FJZ7sFjS3eOm9+j9JC5HlL5T7WBHCrGRfEaThbj0UH97xblU6q60lT
	 TLtXSAcj8hvBeDuUHLbgLO3se+b0Ufm4XthwZ1jrriHvoPE4wvN1+DHKb411W8hYGOrIa
	 6Std0Xel/OOPy8qzYxatKZ9HJonYgwzSEi9JojllB2BZVkOL7iVaiNhmuMShJjVjEow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4phKShs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C5606A31C;
	Sun,  8 Nov 2026 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4phKShs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794137681;
	b=NM9Fi8rrt5YNCNf/OeifaEVDn+bqb9ZcADo5hZrDeK9AVFO4YDlrOPREZg32BV8l9nZE
	 AxHKX+3Op89XpxAa2zNps5XUMVytr4FtSUgEvJ9UkmphN0L+pUVqWan6Iz1YIC8aRpV0G
	 vcOoY46ROdv8182Ht6BPF7PDul/vgJfY4wgF8njewmGUFuGSLj2kCr2L5uVjQwFRKyx0a
	 PA81T0m4HJ1DVzEp6bNhekcDcTlinSMHz7dMILUDcjv6TU4rjF3uuVmuV7jBIJooiT0cF
	 1OMUGb2I5YFBUpv67Es87J3b2E2/EJwy9nyAlTRpKNXzsVOcw31FNHfhBn2k7f9kPhg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794137681;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=irh7FtabIZf9G5NtC74mI7+F4qF39JvEMv9fHyqNNSU=;
	b=S4U84FbJMTwHtvp8jyw/yToMoHC9EMp42lJH1YFIgDZsiLpW5lRaQ9Sa4bwSoK6E8v1C
	 xO1f3i9tnTUoYZ5SwirkMqPntc9AAVmVsow9YuYTJEtHFjYZjiS6PDQLbs5p13rRunN2l
	 ge9auoGqX6ZwAgqzv7xTXILLKDShLhIppP4UcGtlvIo+bdi0qlCkRr5/1qwkgEhdZjwN5
	 c74qksvxTHCuINXoK9gASI9WcdVXGLSMs7gIU0zFvAgOfiuxo0CLSvfcclNuDj5B3M2SZ
	 AjRDuo9QfUULV/MWyAItqYAgbxClinEJwPzU8QkF5dkwjWKqdKvnWqVJ/btCZuLuyzQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C4F921F008A3;
	Sun,  8 Nov 2026 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794137681;
	bh=irh7FtabIZf9G5NtC74mI7+F4qF39JvEMv9fHyqNNSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=N4phKShsnuVPT9bSG5HGbp2ly6lelu5KmPLmwis51hHqeczdww7dQTm2pe2KM1MGz
	 xEiJVK+JKfQbvkIU/YbotXTRisgQrM4BQfbLtkjzXCqDMGFRlWQL7PuugFxSlQcSd1
	 cwSRkNg80/7obgLeEcTgXpplOBBGdjYoYAj6n1+fgIDacNvuSC30wTO32Zrx+xKNfh
	 +yuVH5hRhFe/gOUeDyoKHd+g+LKLZEbe06soPoZ6NBwbyHOpADdQxU2O6CQDwre4Kb
	 8eo3RpA3ytWTCelDA35CDC8sw9JF6dDz7YL64a0fkmKg9fW+brDERPe/oHpyBflrXw
	 BddJW6n24qnZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4BAB247F15;
	Sun,  8 Nov 2026 11:34:40 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Sun, 08 Nov 2026 19:33:30 +0800
Subject: [PATCH net v8 03/10] can: rockchip_canfd: retry the outstanding TX
 buffer
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
Message-Id: <20261108-rockchip-canfd-restart-close-v8-3-3e7a23fd9eae@qq.com>
References: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
In-Reply-To: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794137678; l=1735;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=mAdiDJWuUPvQyM82hTpk52wGLUSpbq2jpnpY6emM93U=;
 b=5PD3i2rXvndHL9umpnZZAsui/1VjENqN/gRejX7O7unl+AadS6RIjqskIrEeKTbuOi2Z5U+n+
 V5DughzQwSGAMzCZBZhEjnvCjwIxOfZtZl3wXwGzioCjFv+ItgjAm8I
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

rkcanfd_xmit_retry() uses tx_head to select the buffer for the erratum 6
retransmission. With a TX FIFO depth of one, the masked head and tail
indices both select buffer 0. With two buffers and one outstanding frame,
tx_head selects the next free buffer instead of the pending one.

Use tx_tail to retry the outstanding buffer. Otherwise, the pending echo
entry can remain incomplete and leave the TX queue stopped.

Backports must include the preceding TX serialization fix or equivalent
synchronization. It prevents completion and retry from observing a newly
published head before its initial TX command and serializes the
MODE/CMD/MODE sequences used by submission and retry.

Fixes: a5605d61c7dd ("can: rockchip_canfd: enable full TX-FIFO depth of 2")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v8:
- Apply the retry-slot correction after TX serialization.
---
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index caa71cf8e39a..8998b7855d15 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -63,8 +63,8 @@ static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
 
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
 {
-	const unsigned int tx_head = rkcanfd_get_tx_head(priv);
-	const u32 reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
+	const unsigned int tx_tail = rkcanfd_get_tx_tail(priv);
+	const u32 reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_tail);
 
 	lockdep_assert_held(&priv->tx_lock);
 

-- 
2.34.1


