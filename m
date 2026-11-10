Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335133;
	b=YijhGLrkvpy2ppfEM/nNS/DeBYpFrtQ6l9g6ccKIDungPaWpxpOm4dhi5xQBot5iB31X
	 b1dgIudS+n+yzrHOhk0HHgPMScU6bYsfwEo1QbptH9rg0QyfHNj9YQWawGrdXQlJEHIrD
	 fnPXUEwNeanXQSjJwu9TqLmVOhIELKjZs1rYsJAwRRhZWmeQrVLThswWtBIXA2USni5hf
	 xKfvCA5VlQzEGWQko8kfyp1iQG3poa/nj2t+FZqp1rgNziwWZjnbPUxn9ap3/ftEAWyRQ
	 dzeqCKGHIEl/M+jUXkvMfFnbBPQvs04vrCafwqfjwJ6o6nTbwVcYhiHniuR29i6/SXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335133;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1w79hK9QT3iMARdVovRc5G2MJyOkRYlu0s6zLbAQN2k=;
	b=WpvfyyJpUOdq1a8FVNoLJZYJ1FmYrAJP1ymDSJLazqkSY9mmImBHsA/lXqHw73bPZKsC
	 wxnqlKOLvtk7Wpn7eCUYZodkCynocJqBibKKTnSRgOnEvFx3aY1kKB9Ij2XVD6dzAjuIy
	 yHhOtvWMaFbPMZbWv7YFRSjjldujISXbjPDjE8kbqPO23Olp7K77uIyseNxxm+/ZZGv7V
	 91OzY5OBYJ1ClhNtyU6J8RmUR1N+PSVm5KAqsMJjQ/kpqadKpciMVkFtVbfs3kKmHYb48
	 E5jJt5ONjdTiPt++qdj+vOccdsqrGsVbQjsteSSd9wRklgv4FiEp4Pv97lhxRQUvx1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTKvFDvj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D5606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTKvFDvj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA211F008A5;
	Tue, 10 Nov 2026 18:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335132;
	bh=1w79hK9QT3iMARdVovRc5G2MJyOkRYlu0s6zLbAQN2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NTKvFDvjeSUTcmLnqLlLikYC5yWipTQKOHsuGlqoM2vu8/tWqhH2jlp0KfTqAD7Cr
	 Hj+hbfB9D0k8R0EEVqBVFy9DXPx5EsPO/naxmfz07IhUU9ywBEVkF7sBceHrbb/+Cs
	 UmSqwDqoP3W3seVppfPDT5RWDNy/qG0U+FfQqvqHbHrD6jXMZF8S211v3AYOoS5AvC
	 65kLbc4RgeyWEjAdANOj0OWSJCe6aMuc27WFHWhCUBp1MKPtGKZFzydKP+fa49aVxL
	 jpHPfAKTh5NWDauSy9/W3MdmzXexYe8c8IPwxSOG256BJYvFEQcRP6SaV9MoZUmGGF
	 mCLcYiirhiaTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] serial: sc16is7xx: add comments for lock requirements
Date: Tue, 10 Nov 2026 13:25:28 -0500
Message-ID: <20261110182507.3154310-2-sashal@kernel.org>
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
index ccac831bc69e2..c55cad61ff0bd 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -530,10 +530,10 @@ static const struct sc16is7xx_devtype sc16is762_devtype = {
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
@@ -768,6 +768,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 	unsigned long flags;
 	unsigned int status, changed;
 
+	/* Lock required as MSR address is shared with TCR and XOFF1. */
 	lockdep_assert_held_once(&one->lock);
 
 	status = sc16is7xx_get_hwmctrl(port);
-- 
2.53.0

