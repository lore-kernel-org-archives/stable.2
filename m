Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335132;
	b=xwYVpOOryenusQ4HYYSKGmv/G81pXK9GHGnPYhtpGe30U22wPDUKscu0GovwK4USgxqL
	 4VGqFeBjqNMXvD7vy0681WZwTKeEtloxLNp1KW633hPB6RduxQFp8bxA/bQKXKP9ZefFL
	 Yw7/2lMvtc2J4/wmh157nqd0PZxL61pP6LqhCExwiDmBZl10q5v38dVuSUQz3kNtxizj1
	 72ojsaV9Kcxj/9+XBZXuvdWQnD54/UrGuwjYUI5cAU+QloAL+oOfNDCbxRnxCPgthVThx
	 0RfjGotTFyCQ6U9NBCWktHtxOYdUzsl0l5ug8aV4DYdM7m5C0CNCp+YUjIMtqZxnISA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335132;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IBvxMmwTI7vx0g8aBSlzC3ISVFra1krO/cZ/bXQQNkc=;
	b=Nfg3g/shLPjvo3pfUHNG40X1j0wGFNEu51HQF70mVt+ax+luGbUpmJucAn38IN6Tcfd4
	 8h3XpPOL8HGpQdmfxMOK5d7sSBk2tmOFz9N1wPAkr9UMPvwB/1VxL+OGmDioGjuJbrOtx
	 YBP2eVm2ciyOBPb6Unkv3G/PQV9i5ALFkOgAGb2DD/3g9Xe2Pn66OX/NMuo4kAPRvON9j
	 AEOQoLSIA9XwoAO57bxJhVllhjBsSnh9QNSjczkSIXxz6G38KtRaPj8b3qBV4VfjTCluL
	 H9vpnvzpVb7f1wINDt8wRRTgqkoWTIop9hwl/YMfv3WmzrGszFYrviLtE4SCi8krLxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMxq34yS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46B606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMxq34yS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0942F1F0089F;
	Tue, 10 Nov 2026 18:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335131;
	bh=IBvxMmwTI7vx0g8aBSlzC3ISVFra1krO/cZ/bXQQNkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cMxq34ySHpLbf8Y2ZFk+1HGhwoMJNCXJvYIElUN+c9wrWwZPz/HEdnL6SwI2+80Sy
	 NLtwpPdWMu+3tqVRcRQmbp7QfAmHKGPMAfAggArU/CZMg5PN8Cz384AaRhljDrU0Da
	 GzcDlYx+ssHjMsejYCGq5M4PYl3BnJq6vRXS4uaBwgJIVXJ5HZOeihFUZ+te78ZRQP
	 s4VooBea+DkO739VmzAzSf/8wRWQTHrNB1ioR1XjIem1s/ikG+s13juTgsFPl2sB1h
	 dwmSw0nx1nfhg5qBcswX18JnVD++RdSDEn63ry1doHrYLQ5A/1KaSGVkpb8/+veYBp
	 4p6LZ3M7jMv6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
Date: Tue, 10 Nov 2026 13:25:27 -0500
Message-ID: <20261110182507.3154310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054759-failed-6.1-1c41d09dcd07@kernel.org>
References: <20261107054759-failed-6.1-1c41d09dcd07@kernel.org>
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
index 7e2f48ea0f331..ccac831bc69e2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -534,6 +534,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 	case SC16IS7XX_IIR_REG:
 	case SC16IS7XX_LSR_REG:
 	case SC16IS7XX_MSR_REG:
+	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
 	case SC16IS7XX_IOSTATE_REG:
-- 
2.53.0

