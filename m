Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1A30E82B;
	Tue,  6 Oct 2026 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314748; cv=none; b=TRPql6Pik/STIFA9U5CfiFpsNKPIaJHO3Qeccs0yypV1d/fKJ9kXgY8HQtRcgbAkP4Y494kisuWKifMNsceWpp9fTKkX5sE8KeJ/6QK+zC+2I+bovwjdK9rPcdCaJtjvF1r1XD/DwoqPfAgW+12P+xed3LMEfhQ0C2U6tUTiEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314748; c=relaxed/simple;
	bh=iPBLfW64CUg6jt8QRZXpm3g4RCK2xrq/UO0xqYMhLlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1iWoQkxBvL6dKrCwdXDd+BIe1j7qWw8lWoCmXAU0rhagKbNWa6Z/DHM1ThvIePAY//qHaQHTb+3NJ+V0fba4K3zVnAKhjOboRmDQeD0xuMwImlwk229jDTXm9y+78+HiRDgPuiTDLlfZlz+bbut+55IZtc/N3QcsUmB7/YaVxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=XwD6SXe5; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="XwD6SXe5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=EQXUD6bxBIGWCzfLsXfSROjBURVXIPdAf6GTvkHipOQ=; b=XwD6SXe5iK8sTtIV4NLU5yons1
	ENAsEw0rcu81NJkU0xkzX2/5xAWtlQR8ZzbKdQ7j6mi4MQ5391dFnyElYlmZ2Iwxu0CkT8zP9sP5D
	kprjnY+PIXaO1l69WfCuDHaZoUTEkZ2mQKz5TmuQYHy7YM5rTfSCuko1s7L7ELxMK9Yo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xEAnH-0000000015R-2emv;
	Tue, 06 Oct 2026 15:25:44 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jon Ringle <jringle@gridpoint.com>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: sc16is7xx: declare MCR and IER as volatile registers
Date: Tue,  6 Oct 2026 15:25:37 -0400
Message-ID: <20261006192540.234402-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

MCR register has the same address as XON1 register.
IER register has the same address as DLH register.

Which register is accessed depends on bits configuration in some
other registers.

To prevent potential access errors, declare MCR and IER as volatile
registers.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 296079c16fdb9..d6b3b67d17d55 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -501,7 +501,9 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SC16IS7XX_RHR_REG: /* Shared address space with THR & DLL */
+	case SC16IS7XX_IER_REG: /* Shared address space with DLH */
 	case SC16IS7XX_IIR_REG: /* Shared address space with FCR & EFR */
+	case SC16IS7XX_MCR_REG: /* Shared address space with XON1 */
 	case SC16IS7XX_LSR_REG: /* Shared address space with XON2 */
 	case SC16IS7XX_MSR_REG: /* Shared address space with TCR & XOFF1 */
 	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */

base-commit: 36844ea19656fb41278799ef3d5cd52120d89149
-- 
2.47.3

