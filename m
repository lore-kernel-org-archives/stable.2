Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334568;
	b=XqNwmiafkOjtCcfbk3GMqW04Em8WeJ7CJo3xP09C0d6dTr37IlLHIYvH72NbZpc5cLAz
	 CEpDOxyBDJNNHhVE09sVfckofUzFImOCqHOSv0j7NuocX0pAQFsV1VOCizIF5cLbMoxVm
	 OYhJRfd+v1nUZo9Ln4ygG557ljYSiytTxMtN+yCxSLi1p8eIXI29dAf8XGY9qOKdKJcIe
	 p5TT6POqoV7DiEEyCUVTzlCJd4DKn5FxMTk1v/2teo95uixKQlX+ZNVJbkrcTd7pAczr1
	 dHUlRS+XDCHcy19/Wb+WR8eVSZZwmAjCOk3rVdALP7UhSVBhMpFOaj5/WPkFlmz4A9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=azEqfVxF9d9iJ3P3evYeNbLJ0KobIEFeoGmc7DYzEas=;
	b=a5B61xqsv+hkZvm0t2zBL9T1vgtIUyw/DdeXhuNmZbEzneiaoDlNA0pXSqKx2C1Fm9NJ
	 KTjca8g9fbj+mtT0TEdsSmNQuImXTvNw3/K1plgq9wBb/fEqI1HIvFwzSRhsVlSVrvHnB
	 DUoKbgdw99a0Gf8IzZZQU0PJAEhykUEa2c678B7wPF84TBWq5LBCkhtcLnfXeWOBr3I/q
	 3dQmPpMdHS6XkTLaWTKbwuWTPw0kZppLnHKosRZBH/lFxhZs1sFJbIaKtJ9tFszLozTGy
	 tuNKS/zin/uYwAy55ALIxP5WOiuAYvUDS8h+/DvhWx4jzSg+WSKfLfv8/kvgmq6MAog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk8M7hie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F3606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk8M7hie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DB31F008A4;
	Tue, 10 Nov 2026 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334567;
	bh=azEqfVxF9d9iJ3P3evYeNbLJ0KobIEFeoGmc7DYzEas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vk8M7hieFHunvJXmM1l17Pbez0YXZTzjweaUeFgav9SpArmM7AhV8zAu6u+jTaMUM
	 V4FapCb+EXTyfhdF26DtZ4kou+9CQrUbLhtYWaU0UqaxABhCHEE7M2TJvaFxTpnYHf
	 s2tixmgI8ZoesAJWhn70mY9OIJ9BxqFMLix3QhZApR69Y/a9iJQPryZjAb4W15bPBb
	 RFSyBf1gc/7T3txlArI6ShtZfBc1BpdCfroF1TgyX75Wk0z+w1nsLkwB3eCvckRFBO
	 rE4R71SXkaHqUxflD2mIrv7c9Vy/vYBcZTXSde8sR8rBoYuHfkQviFYmKcLIb/7U4k
	 wdPaQ4y9znAwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] serial: sc16is7xx: declare MCR and IER as volatile registers
Date: Tue, 10 Nov 2026 13:16:03 -0500
Message-ID: <20261110181549.3115506-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110181549.3115506-1-sashal@kernel.org>
References: <20261107053420-failed-6.6-1c41d09dcd07@kernel.org>
 <20261110181549.3115506-1-sashal@kernel.org>
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

[ Upstream commit 1c41d09dcd07ee9648e20aa8238e404c2e6a12fb ]

MCR register has the same address as XON1 register.
IER register has the same address as DLH register.

Which register is accessed depends on bits configuration in some
other registers.

To prevent potential access errors, declare MCR and IER as volatile
registers.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20261006192540.234402-1-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3a11bd9230555..34260d06b114b 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -533,7 +533,9 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SC16IS7XX_RHR_REG: /* Shared address space with THR & DLL */
+	case SC16IS7XX_IER_REG: /* Shared address space with DLH */
 	case SC16IS7XX_IIR_REG: /* Shared address space with FCR & EFR */
+	case SC16IS7XX_MCR_REG: /* Shared address space with XON1 */
 	case SC16IS7XX_LSR_REG: /* Shared address space with XON2 */
 	case SC16IS7XX_MSR_REG: /* Shared address space with TCR & XOFF1 */
 	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
-- 
2.53.0

