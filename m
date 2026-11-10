Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333203;
	b=3zFkiw+DxtYNrTP2k2gf6egkZ+pCfpUavOPU2kkTSDGDSF9I5MZG5iMBLa49+sX2AjbT
	 s5JwBX6IuxbuSm7INgXQINd9/H37ZU5poQidek4TAsvhTTMs1i7yFhl+/uaFdTmPtm0VA
	 Wrnfw0s/RKtJMTbVkRsLiZp7H3pI00zE3rqSVsJGbWniFI2eLvNTYqLjNagbm87rha4dx
	 DLcES5s+WBgCT7FAt4tqK3oqCuloBmOwWz+IuLicW+vcfvlS7CuuA5UKVr1UL2++e38Oi
	 mbJSsn3He/G4Wai+Cx7fYAO5cQ9oEDoiSAKqQgOB9KqSM46NbR1oXXKQb+OvSMPv4Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=u1qYsTBNoWOtR5RrkFoSy6pAj3H4JJc6abf4FtUmCek=;
	b=WZILRxYTS+B4DIZZlEYeH9+q/GP28+IC3AweuCiyxpFQvOvs13hI1gN58VjllfpBrMam
	 UeG01lNpgQOBT11Hoaz/uT5VCZfX9R0KIByFD69gHYKLIh3KnY+rmtw8hPaJ0Qux/3dSn
	 HtDx54TXNvGaov+ibzGgoG6XVOVCOwpkqu5K3BL6QXfcEk3zoPSgA7XWPOpS+3yUAnusG
	 9Gz1J5n680vf/rrBUYkAB89jlRkyMkV+hIe9V/hVK7eG0DzPtbDKfqmdE+sEL1nG1J4Ey
	 dveiNReHqxV59oWUcHR09BymUgdvPP7pBen7TwQnWxO/8ZcJk0GJk41wJQVnVOWuh9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+LohBde;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E3606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+LohBde
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAFA1F0089F;
	Tue, 10 Nov 2026 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333202;
	bh=u1qYsTBNoWOtR5RrkFoSy6pAj3H4JJc6abf4FtUmCek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H+LohBdeyUw5gIunS0YJB1qt30hLSUBE3pK/rhJEBkMGMLoatXPpFh466nSK9q2CY
	 S4tqqgy/Sce+1Z27ImAJ+QkFlns3kZKzYWBg+5qvSRToqjEGxxC5FU6AmxVt7n6Dwj
	 I4c5nWEgi3hZP+w7MK7NTamYUaUW6KhrmDnivNaRA3apuBrGZpbkVVzcfPaiVqEbPr
	 Wr8XUZMftFLkgmIyRY02w4jgzbQaEQQtFW3LwmUj8ZpXbjUa41SLA7b3+4T99P37GE
	 67jsj4gYRedt1RB3tXemRkdPOwPijTXTtzrD3fpmZWJA5kk9jfI0UcZWCXTk8WhKIw
	 LewWKWc369OMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] serial: sc16is7xx: add comments for lock requirements
Date: Tue, 10 Nov 2026 12:53:18 -0500
Message-ID: <20261110175308.3003406-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110175308.3003406-1-sashal@kernel.org>
References: <20261107051058-failed-6.18-1c41d09dcd07@kernel.org>
 <20261110175308.3003406-1-sashal@kernel.org>
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

[ Upstream commit 42405cb77fd35b5acc0e5a11d74eef68c2afa484 ]

Indicate why lock needs to be asserted when accessing
MSR register, as this is not immediately obvious when looking at this
register in the device datasheet.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20251027142957.1032073-15-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1c41d09dcd07 ("serial: sc16is7xx: declare MCR and IER as volatile registers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7cf3056b93939..b2d020a0b20d0 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -538,10 +538,10 @@ EXPORT_SYMBOL_GPL(sc16is762_devtype);
 static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case SC16IS7XX_RHR_REG:
-	case SC16IS7XX_IIR_REG:
-	case SC16IS7XX_LSR_REG:
-	case SC16IS7XX_MSR_REG:
+	case SC16IS7XX_RHR_REG: /* Shared address space with THR & DLL */
+	case SC16IS7XX_IIR_REG: /* Shared address space with FCR & EFR */
+	case SC16IS7XX_LSR_REG: /* Shared address space with XON2 */
+	case SC16IS7XX_MSR_REG: /* Shared address space with TCR & XOFF1 */
 	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
@@ -785,6 +785,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 	unsigned long flags;
 	unsigned int status, changed;
 
+	/* Lock required as MSR address is shared with TCR and XOFF1. */
 	lockdep_assert_held_once(&one->lock);
 
 	status = sc16is7xx_get_hwmctrl(port);
-- 
2.53.0

