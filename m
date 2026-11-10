Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335134;
	b=tiggyfmu66+e+gBBnp8rJR4RMr5FpDJPlIzMe2JWVZ2liZvW5DxS/Nz8NognAQLPJh6P
	 3rdAgKtuin3W5zjJDxdJgGf+CrDX7SaIvHAgszNnl79E1nocUHcAnjQVO19IUdGCoaODY
	 E1XgLaCUvqz59Iw/6G4crVGvjtbKB9hopPnea+teWdTEmm3YcEu2xS9x14VYAVfK4Tr1e
	 wvpgLkNwtESIdLpg1xOrgTrDZUOBoL5/d8CasjApjlSCXGIS/QInOgYqU8IFoTQj5FTiZ
	 EMw1sH3vrRjwlZn0w/fexX5N/vYvCkufBH1dFMuiWTENY2x6auzLzpJKsTVOqCGOkDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hpzH0crHINH+KEzbXxggxhyO2K9/ocVmhztzrIIqfxs=;
	b=ErlCcfQywZLQnES0IaZaEQ8mF2tv/671JRghu9vZQZZGCDw/lrI/nno/595mARWWopoC
	 ICukneLp4PiGYIwT9G3E/m+rZjb4yhWtzokIhgSyPkRAo5Bm/e6OnaNzFfifOJX6/jEn9
	 gnUwEzbW/Ocq5L4kEw7L87IEo0HrFmzt2XzNr41Z4WUJCscgdTpHi04hs2ima0QJtBTv7
	 t1KU/hNT2i9qrNPdH/YAjF7rnfAxGqRuL1ayEjS+ex6y0R77mRaaLnZQYhHFq65FvyHYx
	 7NNgjd9LEe+hY12c6PAuN7U7GBewfp/V41FsTnSYAKMHKjve7x3SLqBX0ditejqYxQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRNdI5H+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB71606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRNdI5H+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54061F008A3;
	Tue, 10 Nov 2026 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335133;
	bh=hpzH0crHINH+KEzbXxggxhyO2K9/ocVmhztzrIIqfxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRNdI5H+09KX6+N2xtnT+Ge7sseYbuYlZostiItsY9kHYkq4NNSdZ4d5MikAN7kVZ
	 3LWLJA+9ElLPMHmarkILHuDr5aPFc6izhp9VUmDTPOomjFqnkNJwhT9kMuiC9lMyvt
	 T3QWNw8/gzOsDG1XdhcyK1X6H6bz2PEpUF/7sEEk47IQFWkA3y3ZmXEQGC0Cyeai3G
	 py6ie77mxQtp7940S/6oKLMQGeP5mgE6OWoiBQotmmZTALkpbAL8ZhqjkTWUn21s+8
	 t8p7d8Yq+gg/kvrP/0pskpzS1I533qfvkSxtiKz/xDk2zGJuTnr1o9Y0sxbvytYwn8
	 LTgZ0MfsqeuXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] serial: sc16is7xx: declare MCR and IER as volatile registers
Date: Tue, 10 Nov 2026 13:25:29 -0500
Message-ID: <20261110182507.3154310-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110182507.3154310-1-sashal@kernel.org>
References: <20261107054759-failed-6.1-1c41d09dcd07@kernel.org>
 <20261110182507.3154310-1-sashal@kernel.org>
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
index c55cad61ff0bd..a5b5f879b0e98 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -531,7 +531,9 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
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

