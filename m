Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333823;
	b=B3jyh8OM18NEIWTokLmL8bxH3UmDOwZxIduUFjbQhtrMlBSPhQYzY0KWJ20pRUziwrtn
	 P1oyAQ53l6UEuKJXFzdOv77uN+afFhF3KJR3kwlUyirCu1e73Uh9pltWISXLQ6Gk/tbah
	 +7DNydCNmu0AUACdrcQDEV/hhf2PN7pIKJnLv3KGT4ZouIgB3WVbW09onUez8sjsdPFb2
	 WzdIflHr9u3xn0KM0h1e2Py8SKpkzDJl7dPs8L8LvXtmVLG71bDj4Tbtu6d44DgZxsuyl
	 45GLLiJjojyaKWQxCU5Yzr9DiZqypNRziKJTkQC/Y2UkK02ub9gCY4LZ4HgUu0tieaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PfZdNEPScTKJetP4HICv0jlODMdEYKoGqUkDlVRqi14=;
	b=jKgxBEbQEwmk6XaG5/uO8fyjmEwZ2/BBM4ZiYtJZZuRAMioa6+IZGgNfSIysdkQDOn5R
	 vd5qvxcrTpKtlwO+SFS8U/HuWV6z6YTSiTS55RZSG/+9YeiN6nnLQb0aXGee5o/dAqBcv
	 9NXCQi8taFnfX8hcc2e4MpoA4AnhziOfKzLsfUHfacelP2zVTWYDlS64vAZNsIwn2zikD
	 JzvFwztSs/v6Fo6u0cR2ZLZzoJ/7E0wvmMNJrZKRR+LmPahjCSK5v8w355lUc9kM89eB8
	 cYjjZ0R7+qTdFGHvxFTOO64yRUN+A78c2rqfT1MFvx2Hhd/UK3yGTI+SdWJOKQkCTFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmKN1Xmy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15DB606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmKN1Xmy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392CD1F008A3;
	Tue, 10 Nov 2026 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333822;
	bh=PfZdNEPScTKJetP4HICv0jlODMdEYKoGqUkDlVRqi14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SmKN1XmyvpNw7e8QpUH5F9dfJseBHLNIMXrgqFLw8edKNGq6Ejju/Nr1tO8gMEqZc
	 N/8E7RUSEfDylGV4Cu9u4iDaALkLlNHb7mKFBZtgfxXSY5bQ6IKW/UDaEkyUngNQKv
	 9H2t2vLpYU3u+Is2a2plJb8fesS583fUs0g9ePbfmPrNYaljtLMDXv6UGZaO/bQxJ5
	 QPw2FK3AZjhqhb4NlNS8VMvUCAVS/7O7eIQTtl4OR16ZLczYA9wrKYNX2ogOowfH7z
	 o4BSHcEiu+oo0z2wV9Eap7KVHk4zoOknin2lbG5Uq6PkxhtqMNzmpZnIeSRJQjGhT3
	 8fA58cQd0E1kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] serial: sc16is7xx: add comments for lock requirements
Date: Tue, 10 Nov 2026 13:03:38 -0500
Message-ID: <20261110180249.3093454-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110180249.3093454-1-sashal@kernel.org>
References: <20261107052158-failed-6.12-1c41d09dcd07@kernel.org>
 <20261110180249.3093454-1-sashal@kernel.org>
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
index bd38a2efd34ec..92869e56ce5d2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -535,10 +535,10 @@ EXPORT_SYMBOL_GPL(sc16is762_devtype);
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
@@ -782,6 +782,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 	unsigned long flags;
 	unsigned int status, changed;
 
+	/* Lock required as MSR address is shared with TCR and XOFF1. */
 	lockdep_assert_held_once(&one->lock);
 
 	status = sc16is7xx_get_hwmctrl(port);
-- 
2.53.0

