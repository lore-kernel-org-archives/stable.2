Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463A215161
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264886; cv=none; b=IHOciC6rA2yo0k/0MWrn8r1S6RqWazPNH/EKpfzu+AZWtWnR7CjCF+WgintFz3VMUi1QEQQw9xl3235ifQ8lh1vKgsOZw/+3BCpFCD3VO82n4Gn7zclzqEtlFzR4iV0aNx0XDmvMLLhPt/eiTugBSlKdXXFLcPeQP1NsVnDKcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264886; c=relaxed/simple;
	bh=NuBjT6A7tTfyrgp1M3PfXyIR1MRw7m/m2qpxuP+4jko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuqNSkz0i7RGvY3T/8xN02WT7ZZPBIn4XcYXF7ZnDIHtO/Vle7DpCqmvKzk8r5T4w0Q9KQ9oswowAkcI00vYfmZa9LaHV/V9shf2+Op/K07SMpIXefnAytlaZx3Bx4SCg3CafQE6voOgFcIvBcEkkHs68YcLtUm+q4Fe0PPBnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiALarKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiALarKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84DC1F00A3F;
	Thu, 20 Aug 2026 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787264885;
	bh=XzZKSnMvdgXi1VCu+gBiXMxSFJlFoM/1LFIPrZKya5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JiALarKS5YE2hLP8bltuArjdyHkQVMqXCRSC0U2bFofZh/WNSLtbRBLx3Lf9uNe9A
	 TgNRVdKa3w1owgwZmpdmXX+6gkkDXZlCKy/52Gl0bEya/FptY6/YojgITVq0T4Un15
	 Gd9TZID5PTbjLeZeVXwt0/f9c+qbyiviGph/5ciTDbop2JKwpmv2BjXl94CftSdTC9
	 fTS0EtO4CSPZL39S0g/XO7NQkGRCjsuki/AC6AWQFRgzTdg0AZcGknIi+8Yl9nMac2
	 nVtzBqXN4jZWlw8Rg+5nZCzKvOfl3uqsp2b0Np1HVhea3OF7W0IJS6chqRzL0fhCZ7
	 vzoaih7FIDezA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Fresi <luca.fresi@bithiatec.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] serial: sc16is7xx: enable THRI before filling TX FIFO
Date: Thu, 20 Aug 2026 18:28:01 -0400
Message-ID: <20260820222801.2320182-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820222801.2320182-1-sashal@kernel.org>
References: <2026081753-ebook-finisher-4e66@gregkh>
 <20260820222801.2320182-1-sashal@kernel.org>
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
index 8fcfc8b322d10..5592f797e3b03 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -874,6 +874,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 		msleep(port->rs485.delay_rts_before_send);
 
 	guard(mutex)(&one->lock);
+	sc16is7xx_port_update(port, SC16IS7XX_IER_REG,
+			      SC16IS7XX_IER_THRI_BIT,
+			      SC16IS7XX_IER_THRI_BIT);
 	sc16is7xx_handle_tx(port);
 }
 
-- 
2.53.0

