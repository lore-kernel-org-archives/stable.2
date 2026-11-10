Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333203;
	b=D+p+kfO3kYhKFXQz2Ozl8oFgwPAXlWdkbrHXPQLfLo4t18VBqwnxqJEZ4WFHn1ZPF7Qo
	 7RAPglvq/DmsR56VnK8pmTuZDSuBUGZ4NKQdxwaZdBqL8statxr/ZxOQxosAz+xeNL09C
	 lRHJC9B6WA8h9blxXKKzSZjdEl465wGPabrwQeOC1bIzjCpLDX4xDSXj6TUQyvZSh8+xA
	 hLNpJiUhYROYJG4AuSnu+cXtLwuh+hSfmZi0/8dpvnZHRA9gZmUASYvZX9qRhID7AfTvn
	 EhgvkO+2NXPOdHMAq3bXGcXKp90WWSc8zqZ/g41hyuGRKs1ftL8cvGZMhXKv94WK8+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7oi7j01SWvsk1v8Hfy0oPjBxBnVEGRN+CcJmNW20kMw=;
	b=TAQ25LzSqGjYCMpNW/UEBO0pOXsftlzP++vwulAqhcRMDFFZInqJbMywfvia6wn+CUy2
	 UyAFBw94TIlN+3z8Dl10khrfvuIV8YpLW/Ppv9wKb6070QXaHSe0879eaZbxNA3ELJAEv
	 tnwi4tbuvCvymmKOEmIp1GexFcW3SVEFnUK+kBTz76wgXOq05vWMk9SkAjAHumHxyYG2l
	 iBn1NBkfuYWbo2fBTqpg0hujxpT8YZ7LhTFL/l2TyqT1TYVO1qDk0k1jQkPBeJXagNec6
	 gak0FIvdLw/lfArd+oM42D3M48klJf1fUWdROdUJbcaGsV0pmWAL+h1Kr6rSAJe9slA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eY6m/RnC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CD606A33B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eY6m/RnC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1A01F008A1;
	Tue, 10 Nov 2026 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333203;
	bh=7oi7j01SWvsk1v8Hfy0oPjBxBnVEGRN+CcJmNW20kMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eY6m/RnC/cQSCrcZkaUKyciGJdPqxjgoiWK7vQq7LKANmiGvoYgpOckhVECIP76xZ
	 jdbHMkjlERUxKCc54q4fnkSW6l3qQ2c7umvc8v3v/zxIZuQM1kZTRP13eztKkB/Qwb
	 eKp1EZLp7V7WjZydNXTLb5SB+jmlg9cla57PdgSEj/TLBCDyU1RwZAXxa7SGyWlO98
	 mOeIwiQbIXpDED8q49Gf0DFRYGFLNB5ChBxveWz/RQtVnBZdfadjhzJXB06LeZH+yc
	 kHzp+Qlp1zw9ksvS1CSn2Lhu4RFRn3U2VeHaZBfz3lLL63kSJb6FThB9w2nSO/pqqh
	 ziHiiBLyzh+Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] serial: sc16is7xx: declare MCR and IER as volatile registers
Date: Tue, 10 Nov 2026 12:53:19 -0500
Message-ID: <20261110175308.3003406-3-sashal@kernel.org>
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
index b2d020a0b20d0..b5e301741b844 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -539,7 +539,9 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
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

