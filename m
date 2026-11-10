Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333822;
	b=WBVCLPQCdjANWtDApoqaGcxRF2P4f/pMhV/huFIZrTtaNPWv9BbosrQRZe+42I0RdxIY
	 OYaJdK1k23caomvXvK4Tx1lGJRK7WTdkjslYxpGjdLhciIWESsLTmFso1sQ+7OU1pJZLM
	 GSbXkyUczKA6A15T5/v60lhHDVZGVfKspi54Dy3iDXhSC9abzP6GSFHsJWflVl1/iR5PV
	 NsOQCoXH4QQZ02tUjRvVYThJ4AZT6sVJYeDcL/oAOHs2DBFytRj0Vdd0qNqGbJa9Qao6w
	 BsDg/Ppbmu9rrCS8c+cHD77bXX9URhJprt9e9oYeuCo/q78XdQR4uPzxsxvfiPH44pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N61KQ/O6Q5Xj9ns3NUEYCHhpi1Np2gGUBxMsWXnBnBo=;
	b=i8JJM8wW9Z3qHtq92PML7+6a+0/m0WVEF+ZeT6jh+iowqi0VQ6S49nGQ0YLIAh/4H58e
	 jHG+msqxxItYaV+X+ysycXEs0az5iO7m/GSTHlYpyLbrSzNB7PHJwFR0EUtj+wU3h4Py+
	 qi1OTkT5g0U9xt1S1CHF57mc61cD3MZcn7MN6eY+4qyR9Bpbbg2/z51ktJvUhS+H/1w6R
	 5nby7Px+VjSJ+P/kdK6MQ5uuWSQxIH2MZwImh2Q8E1LR08B+2jUfPAcsKcksckZiQRA//
	 UKcAs9o0uw7vxhXZjYBwdROYhYY3UO9cN/rwm8Dr+8SkmFgso7m9SGpwdBrK+TB4Bsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlHrso18;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlHrso18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589B11F008A1;
	Tue, 10 Nov 2026 18:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333821;
	bh=N61KQ/O6Q5Xj9ns3NUEYCHhpi1Np2gGUBxMsWXnBnBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UlHrso18JCiDaRL5H3Zp9pJag8mHxMHiRtDW5qZhJhoSifNkcc6JTMkGq3RCLa8NW
	 ukbHDRos6qAv8SrWT/9P6YSJJEQlf5U2qvSboOUnqpFZy7kKhOFfg/oYHNntApAX7k
	 ZbuXBQktmoyYhqNmYe7cFNsB5XLd0eFlf37chICyVOnDrPk79A0/0DUdb+4uEBB6nP
	 Npohy0kwXPZrVIrQkqtKXQTkQgjaQlnWqnD8jVkuRQx2Ei89tdfcJhE/t9gcoi017l
	 /QWWvLBm7ou9Xs71TtXXk4EPTUErEMKw5TJyLjpeux40vFY/gV9xQ7+uZQ+Lf0H7PR
	 780Ia/9KmyRzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
Date: Tue, 10 Nov 2026 13:03:37 -0500
Message-ID: <20261110180249.3093454-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052158-failed-6.12-1c41d09dcd07@kernel.org>
References: <20261107052158-failed-6.12-1c41d09dcd07@kernel.org>
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
index 942d12f40a394..bd38a2efd34ec 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -539,6 +539,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 	case SC16IS7XX_IIR_REG:
 	case SC16IS7XX_LSR_REG:
 	case SC16IS7XX_MSR_REG:
+	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
 	case SC16IS7XX_IOSTATE_REG:
-- 
2.53.0

