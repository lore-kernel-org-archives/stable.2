Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334566;
	b=NJUpGJK9XvkqID25rBg4uOulOX0gVMhn343eUnsVHHfvZluXTyQhdgaPoQ17ZQaQDrxx
	 EbXWSMIgRciFDVJx/MvLHY/pG7zXlX9n6gFXIOJaYLOaASY4n6ObtXoPsDz1rfl42kRQf
	 wJjz9wzkA+q9gHhYuGhz0a0TO33C5dMzAoRtzQUmYuV60MZU9OX6pqgTZK4cdn+mdB2Qc
	 XnpwmTfcEclmnNeqof2WN76+vl8s+6tW4kRGYkW9+tyyLDr+GAmM/WsREsg+MrDdU2An0
	 O6zDfPbPoeEy6AXkA83op6ik33Ggkn7FIURpY0yGstQEjrHZ21KFhKJEctA6kTq9ayw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334566;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V/zRREYVDIWFqr14/GXY7Bz0H5ZtBUvvAeNVTtCvcnQ=;
	b=aNmCRztaXwZNpCc+y9m0e9SvxZvtl1jFNdg8LhJjQ0f9TI1GwDS4ScWZ5GX/12zGLDmT
	 cC0/qyldT+JBEBlRc+NQiZBE7Wi8SOefyDkr4CjduSBAgbdqj+OWEeSAzb0O5nmQzJc1f
	 YElDjtMZrCTQOZFTuTtWuStoPcq3IFtJ6oOJXzHjQNNOAaA4cJ9cLMJZlG/2IJa5B50iS
	 gMphssS5aFZXK1GwlA5iOLbuzL9EHqwpqSTKNhhf+PS1+CWI3YnsfTa10g5coYFcaOATg
	 oanYxLa22FRzSwRpw1k79b1Rw3zf4YDsdY1sKC6bZebClL0pOlZq6A8dM0+GGLCu9dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc6cI6Hr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB1606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc6cI6Hr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500DC1F008A1;
	Tue, 10 Nov 2026 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334565;
	bh=V/zRREYVDIWFqr14/GXY7Bz0H5ZtBUvvAeNVTtCvcnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tc6cI6HryUlfsCwqXOstG0wLzgy2EOjPmOKSamZljOIhfb4gN8jLoHrMavlFk3LNx
	 N2tr00CDq2s61hsxrKXs6+VbzlNvOeOVK972VbM0rkVz87l839xj1RXeO9Jm/bpYhd
	 oarGBy5ZLeOVR1Oxnsnma7LWsUQ7WxdrSukj92wqb1scnjWWO2WFLNLObxpZpkfoTe
	 YeOHlup8s71JGh4bwCvkxHjS5wPT5vuqeMDxMERAfh6UK1V4O/+4Aq+A3aqY9NHFJa
	 qbLpSFhJwMZqs13EJZg9ByNcStwapqfCYlB921vRTPzUyxbW5WKC5jrmH9cZNep2nd
	 oycWLl5sAK14A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
Date: Tue, 10 Nov 2026 13:16:01 -0500
Message-ID: <20261110181549.3115506-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053420-failed-6.6-1c41d09dcd07@kernel.org>
References: <20261107053420-failed-6.6-1c41d09dcd07@kernel.org>
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
index b208181de2455..fbe8128b5e681 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -536,6 +536,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 	case SC16IS7XX_IIR_REG:
 	case SC16IS7XX_LSR_REG:
 	case SC16IS7XX_MSR_REG:
+	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
 	case SC16IS7XX_IOSTATE_REG:
-- 
2.53.0

