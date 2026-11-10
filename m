Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333201;
	b=IOlaMc/70ISaUYXJsuSE/JxyfeDb8JnGYDPOBo58y7o2VEB4Bw2k/7brqyTqyf3pbrkN
	 r9Kml1/f3cnpALr+w3taBRJFcNBwCGE289Y0QUIx6dtXKvH+YL5KQh6rwSLczt/szy9fk
	 Eo0jFqD463bdkMiG2Iw5an+FAiM4G9Dq2PQGMWh4jldd0Se41utJRM/ym70XuUR4OBPbd
	 pfGo2SYs5DiovqMX7wHUM0fr8PbbWrpiBXS0F1bdUflNughOq0gRFeP7E8Fvx7Bnm0mYj
	 IY+O6RaE7YXTYRdBYISL076Tcna0OgJoenaZQiRqw/tTEinrdkxTMAIQLA6iOtNdlxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333201;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LOF166q/4VRxqOWTXYT67ihmDrjTmF5ScFCjNy0Wcj4=;
	b=QHbL/t2/ElaB/P3tXYYEKinftYg5qnSfmFbf8nBgMgf+TpZKZYa73poR8e6e8f0KtaD6
	 qUmd4ckMUoSWWFBdv0mS4WfOIYUnJ2xlSC7oVc0kzrzyUgDwtYSi7xTUxDnzYlTkBu6gb
	 Fnee8IjpTaymbZsSVSkUPu4koifkAykS+eyQxLE+/fWZhf1+O64HSW36qzviu5JZ5C+BD
	 yRPicnKtquoel9HbdiTNYxn+KZUmFIyGlZZuqwzLQuFhlzwyp4Yi2wdL6AXxGGkinXHKa
	 eL3fFU4fvGTNHvS/KGz1I+zIBjoGI30UYsfKRdMq0/C0TiJm5kkJZmRpmjc4qF6z6dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeRPyRAj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9B606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeRPyRAj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34BD1F008A1;
	Tue, 10 Nov 2026 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333201;
	bh=LOF166q/4VRxqOWTXYT67ihmDrjTmF5ScFCjNy0Wcj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YeRPyRAja8nauCb8i9R/X4BtlEnDINEzK93XtjVlviFdU32tpfh/M1E22dRPaNNWk
	 hlCJQqe1gR6vn8WAwtqhkqLD7/3RO1dycVEybLp8aUm7VTRB6YH2hxL8MYIt1pNxIC
	 tLb/PHHQgCqNw0VJTVdrYv2yRWYU5iYP4mdF1wdlipMSiD7+NDZcxsicUjZuo+IWNT
	 FrmozlXazyhnqYXWHf2bg4cWpnYotIz+wtSD4prO0kVoVyPC5DdPlAPEz6ewMLJEcg
	 lqHXX8xolBYuDv7HV0ZpMerIt71Rar/Gre+unJ+3OIt3Xt4YAvyvYHIqFa87i7nCo8
	 Cide3Dg0YCU3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
Date: Tue, 10 Nov 2026 12:53:17 -0500
Message-ID: <20261110175308.3003406-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051058-failed-6.18-1c41d09dcd07@kernel.org>
References: <20261107051058-failed-6.18-1c41d09dcd07@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 983f91e5f13149ade6dbd9568053ecd0ab5e9265 ]

SPR shares the same address space as TLR and XOFF2. If SPR or TLR were to
be used eventually, this could lead to incorrect read value from the cache.

Prevent this potential bug by declaring SPR/TLR/XOFF2 as volatile.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20251027142957.1032073-8-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1c41d09dcd07 ("serial: sc16is7xx: declare MCR and IER as volatile registers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 42ad926f1fe68..7cf3056b93939 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -542,6 +542,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 	case SC16IS7XX_IIR_REG:
 	case SC16IS7XX_LSR_REG:
 	case SC16IS7XX_MSR_REG:
+	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
 	case SC16IS7XX_IOSTATE_REG:
-- 
2.53.0

