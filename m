Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18437646E
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284766; cv=none; b=gFHrl4a8hgkIzSPdy6lF9VpkbYYKzY7f3LsFzLZxVkaCV+8HBHr0UQfi6RL8U1wHiugsZucHel87direm8VXVl5vlFChsYkw0TptimJpyogbNBoJLM8AkySeJ1gTOKq7NCu6/IAtnzsYRcJteVVyNWK/Sjxm0dWfagG4pOd9kFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284766; c=relaxed/simple;
	bh=4EACattefdN1kPvEocdj2dKw9wHsHEVwq2M4kvjjUNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed9nyEYJ3RWRVwUjYorGGCJVR49NCXuc782M2s6TaUSpuPcBaUoEiyRurkOgHgJwUkXejHeIwK9/mdp23g/u7KAVlzDve+bxNqNXyUiM7Dv7yrOs/fjnT17f5It8/h4P7GxmLJznvK88A/g65tM3ZG3DjgC8rn6mgV/r760XfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciEj+qGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciEj+qGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062931F00A3A;
	Fri, 21 Aug 2026 03:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787284764;
	bh=mFcZajzKEA48oPi1vqR2qRAyUz0wZGulf/dgLFcGV/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ciEj+qGNpreBNgAktz5+6EKIE9Q098aLBLX3QdOhCfhXxcmHQv0x8jQQ+wkVB0u3K
	 jYwxYimFCJSDwXmXg59Uk/QEDlM9E10iP5YUZCpmDfAAMI1ZW4DQK5T4RcsRrPUxHN
	 YlO81Ub4r86DI920RAPhviE9U3wv2NV2FDT2BY9pHuoxg/ppviPuNUJoG9R0CmWxGC
	 +MB1Yhzb8MJvNrKqMY+hsIsnInVS4wxMmVs7pTLIbg5KqQCqekNMczjWxRebYwrkOs
	 2zpjTf8x1wsN0x6JORT2rcCYowoy7Zx64uSk2zj6MyJAJrDPV5xUUfahU5Q0TwM3j4
	 We81frPYKNdtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Fresi <luca.fresi@bithiatec.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] serial: sc16is7xx: enable THRI before filling TX FIFO
Date: Thu, 20 Aug 2026 23:59:20 -0400
Message-ID: <20260821035920.2524947-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821035920.2524947-1-sashal@kernel.org>
References: <2026081754-ogle-alkalize-4f27@gregkh>
 <20260821035920.2524947-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Fresi <luca.fresi@bithiatec.com>

[ Upstream commit 246ac114f485c2affb454240f3ea4fabfce22456 ]

sc16is7xx_handle_tx() currently requests the THRI enable only after it has
filled the TX FIFO. The request is asynchronous because the IER update is
performed later by reg_work.

The SC16IS7xx generates a THRI interrupt when the TX FIFO crosses its
trigger level. If the FIFO drains past that level before reg_work enables
THRI, the chip does not generate a new interrupt. Characters remain queued
indefinitely even though the hardware FIFO is empty.

This was observed on an SC16IS752 while both UART channels were active.
During the stall the software TX buffer remained non-empty while TXLVL
reported 64 bytes free, LSR reported THR and transmitter empty, IER had
THRI enabled, and IIR reported no interrupt pending.

Enable THRI synchronously before filling the FIFO so the threshold crossing
cannot be missed.

Fixes: cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
Cc: stable <stable@kernel.org>
Signed-off-by: Luca Fresi <luca.fresi@bithiatec.com>
Link: https://patch.msgid.link/20260721222404.204746-1-luca.fresi@bithiatec.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index b534a830ab2a7..80b821f7b9a22 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -859,6 +859,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 		msleep(port->rs485.delay_rts_before_send);
 
 	guard(mutex)(&one->lock);
+	sc16is7xx_port_update(port, SC16IS7XX_IER_REG,
+			      SC16IS7XX_IER_THRI_BIT,
+			      SC16IS7XX_IER_THRI_BIT);
 	sc16is7xx_handle_tx(port);
 }
 
-- 
2.53.0

